#!/bin/bash
# ============================================================
# scripts/setup.sh
# Script tự động cài đặt WordPress + LearnPress qua WP-CLI
# Chạy: docker-compose run --rm wp-setup
# ============================================================

set -e

# Màu sắc terminal
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log()    { echo -e "${GREEN}[✔]${NC} $1"; }
warn()   { echo -e "${YELLOW}[!]${NC} $1"; }
error()  { echo -e "${RED}[✘]${NC} $1"; exit 1; }
header() { echo -e "\n${BLUE}══════════════════════════════════${NC}"; echo -e "${BLUE}  $1${NC}"; echo -e "${BLUE}══════════════════════════════════${NC}"; }

# Thư mục WordPress
WP_DIR="/var/www/html"

# Chờ MySQL sẵn sàng
header "1. Chờ MySQL sẵn sàng..."
for i in $(seq 1 30); do
    if mysqladmin ping -h db -u wp_user -pwp_pass123 --silent 2>/dev/null; then
        log "MySQL đã sẵn sàng!"
        break
    fi
    warn "Đang chờ MySQL... ($i/30)"
    sleep 3
done

# Di chuyển vào thư mục WP
cd $WP_DIR

# ============================================================
header "2. Cài đặt WordPress Core..."
# ============================================================
if ! wp core is-installed --allow-root 2>/dev/null; then
    log "Đang cài đặt WordPress..."
    wp core install \
        --url="http://localhost:8080" \
        --title="LMS – Học Lập Trình Online" \
        --admin_user="admin" \
        --admin_password="admin123" \
        --admin_email="admin@lms-demo.local" \
        --skip-email \
        --allow-root
    log "WordPress đã được cài đặt!"
else
    warn "WordPress đã được cài đặt trước đó, bỏ qua."
fi

# ============================================================
header "3. Cài đặt Plugin LearnPress..."
# ============================================================
if ! wp plugin is-installed learnpress --allow-root 2>/dev/null; then
    log "Đang tải LearnPress từ WordPress.org..."
    wp plugin install learnpress --activate --allow-root
    log "LearnPress đã được cài đặt và kích hoạt!"
else
    wp plugin activate learnpress --allow-root 2>/dev/null || true
    warn "LearnPress đã tồn tại, đã kích hoạt."
fi

# ============================================================
header "4. Kích hoạt Plugin lp-stats-addon..."
# ============================================================
if [ -f "$WP_DIR/wp-content/plugins/lp-stats-addon/lp-stats-addon.php" ]; then
    wp plugin activate lp-stats-addon --allow-root
    log "lp-stats-addon đã được kích hoạt!"
else
    warn "Không tìm thấy lp-stats-addon. Kiểm tra volume mount trong docker-compose.yml"
fi

# ============================================================
header "5. Cấu hình WordPress..."
# ============================================================
# Cấu hình permalink
wp rewrite structure '/%postname%/' --allow-root
wp rewrite flush --allow-root
log "Permalink đã được cấu hình."

# Đặt trang chủ
wp option update show_on_front 'page' --allow-root
log "Cấu hình hiển thị trang cơ bản xong."

# Timezone
wp option update timezone_string 'Asia/Ho_Chi_Minh' --allow-root
wp option update time_format 'H:i' --allow-root
wp option update date_format 'd/m/Y' --allow-root
log "Timezone đặt Asia/Ho_Chi_Minh."

# ============================================================
header "6. Tạo tài khoản học viên mẫu..."
# ============================================================
# Học viên 1
if ! wp user get hocvien1 --allow-root 2>/dev/null; then
    wp user create hocvien1 hocvien1@lms-demo.local \
        --role=subscriber \
        --user_pass=demo123 \
        --display_name="Nguyễn Văn An" \
        --allow-root
    log "Tạo tài khoản: hocvien1 / demo123"
else
    warn "hocvien1 đã tồn tại."
fi

# Học viên 2
if ! wp user get hocvien2 --allow-root 2>/dev/null; then
    wp user create hocvien2 hocvien2@lms-demo.local \
        --role=subscriber \
        --user_pass=demo123 \
        --display_name="Trần Thị Bình" \
        --allow-root
    log "Tạo tài khoản: hocvien2 / demo123"
else
    warn "hocvien2 đã tồn tại."
fi

# ============================================================
header "7. Tạo trang chủ với Shortcode..."
# ============================================================
PAGE_ID=$(wp post create \
    --post_type=page \
    --post_status=publish \
    --post_title="Trang chủ" \
    --post_content='<!-- wp:shortcode -->[lp_total_stats]<!-- /wp:shortcode -->

<!-- wp:heading -->
<h2>Chào mừng đến với LMS Demo</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Nền tảng học trực tuyến mẫu. Plugin <strong>lp-stats-addon</strong> hiển thị thống kê bên trên.</p>
<!-- /wp:paragraph -->' \
    --porcelain \
    --allow-root 2>/dev/null || echo "0")

if [ "$PAGE_ID" != "0" ] && [ -n "$PAGE_ID" ]; then
    wp option update page_on_front "$PAGE_ID" --allow-root
    log "Tạo trang chủ (ID: $PAGE_ID) với shortcode [lp_total_stats]."
else
    warn "Bỏ qua tạo trang chủ (đã tồn tại)."
fi

# ============================================================
header "8. Cài đặt LearnPress Sample Data (nếu có)..."
# ============================================================
# Chạy WP-CLI command của LearnPress để tạo dữ liệu mẫu
wp learnpress import-sample-data --allow-root 2>/dev/null && log "LearnPress sample data imported." || warn "Lệnh import-sample-data không khả dụng, dữ liệu đã được import qua SQL."

# ============================================================
header "✅ THIẾT LẬP HOÀN TẤT!"
# ============================================================
echo ""
echo -e "  ${GREEN}WordPress:${NC}   http://localhost:8080"
echo -e "  ${GREEN}Admin:${NC}       http://localhost:8080/wp-admin"
echo -e "  ${GREEN}Admin user:${NC}  admin / admin123"
echo -e "  ${GREEN}Học viên 1:${NC}  hocvien1 / demo123"
echo -e "  ${GREEN}Học viên 2:${NC}  hocvien2 / demo123"
echo -e "  ${GREEN}phpMyAdmin:${NC}  http://localhost:8081"
echo ""
echo -e "  ${YELLOW}Shortcode:${NC}   [lp_total_stats] hoặc [lp_total_stats theme=\"dark\"]"
echo ""
