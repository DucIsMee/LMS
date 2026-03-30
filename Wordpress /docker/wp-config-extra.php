<?php
/**
 * Cấu hình bổ sung cho WordPress LMS
 * File này được include vào wp-config.php qua volume mount
 */

// Tắt editor file trong Admin (bảo mật)
define( 'DISALLOW_FILE_EDIT', false );

// Tăng memory limit cho LearnPress
define( 'WP_MEMORY_LIMIT', '256M' );
define( 'WP_MAX_MEMORY_LIMIT', '512M' );

// Tắt cron mặc định, dùng server cron thực
// define( 'DISABLE_WP_CRON', true );

// URL cố định cho môi trường Docker local
define( 'WP_HOME',    'http://localhost:8080' );
define( 'WP_SITEURL', 'http://localhost:8080' );

// Số phiên bản lưu trữ bài viết (giảm tải DB)
define( 'WP_POST_REVISIONS', 3 );

// Xóa thùng rác sau 7 ngày
define( 'EMPTY_TRASH_DAYS', 7 );
