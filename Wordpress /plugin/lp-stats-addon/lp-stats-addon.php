<?php
/**
 * Plugin Name:       LearnPress Stats Dashboard
 * Plugin URI:        https://github.com/NTTDat7525/lp-stats-addon
 * Description:       Hiển thị thống kê LearnPress trong Dashboard Widget và Shortcode [lp_total_stats].
 * Version:           1.0.0
 * Requires at least: 5.8
 * Requires PHP:      7.4
 * Author:            Can Duc Diep
 * Author URI:        https://example.com
 * License:           GPL v2 or later
 * License URI:       https://www.gnu.org/licenses/gpl-2.0.html
 * Text Domain:       lp-stats-addon
 */

if ( ! defined( 'ABSPATH' ) ) { exit; }

define( 'LP_STATS_VERSION', '1.0.0' );
define( 'LP_STATS_DIR', plugin_dir_path( __FILE__ ) );
define( 'LP_STATS_URL', plugin_dir_url( __FILE__ ) );

if ( ! class_exists( 'LP_Stats_Addon' ) ) :

class LP_Stats_Addon {

    public static function init() {
        add_action( 'wp_dashboard_setup',   array( __CLASS__, 'register_dashboard_widget' ) );
        add_shortcode( 'lp_total_stats',    array( __CLASS__, 'render_shortcode' ) );
        add_action( 'wp_enqueue_scripts',   array( __CLASS__, 'enqueue_frontend_styles' ) );
        add_action( 'admin_enqueue_scripts',array( __CLASS__, 'enqueue_admin_styles' ) );
    }

    // ── Truy vấn dữ liệu ────────────────────────────────────

    public static function get_total_courses() {
        $query = new WP_Query( array(
            'post_type'      => 'lp_course',
            'post_status'    => 'publish',
            'posts_per_page' => -1,
            'fields'         => 'ids',
        ) );
        return (int) $query->found_posts;
    }

    public static function get_total_enrolled_students() {
        global $wpdb;
        $table = $wpdb->prefix . 'learnpress_user_items';
        if ( $wpdb->get_var( "SHOW TABLES LIKE '{$table}'" ) !== $table ) return 0;
        return (int) $wpdb->get_var( $wpdb->prepare(
            "SELECT COUNT(DISTINCT user_id) FROM {$table} WHERE item_type = %s", 'lp_course'
        ) );
    }

    public static function get_total_completed_courses() {
        global $wpdb;
        $table = $wpdb->prefix . 'learnpress_user_items';
        if ( $wpdb->get_var( "SHOW TABLES LIKE '{$table}'" ) !== $table ) return 0;
        return (int) $wpdb->get_var( $wpdb->prepare(
            "SELECT COUNT(*) FROM {$table} WHERE item_type = %s AND status = %s",
            'lp_course', 'completed'
        ) );
    }

    public static function get_all_stats() {
        return array(
            'total_courses'     => self::get_total_courses(),
            'total_students'    => self::get_total_enrolled_students(),
            'completed_courses' => self::get_total_completed_courses(),
        );
    }

    // ── Dashboard Widget ─────────────────────────────────────

    public static function register_dashboard_widget() {
        wp_add_dashboard_widget(
            'lp_stats_dashboard_widget',
            '📊 LearnPress – Thống kê tổng quan',
            array( __CLASS__, 'render_dashboard_widget' )
        );
    }

    public static function render_dashboard_widget() {
        $stats = self::get_all_stats();
        ?>
        <div class="lp-stats-widget">
            <div class="lp-stats-grid">
                <div class="lp-stat-card lp-card-blue">
                    <div class="lp-stat-icon">📚</div>
                    <div class="lp-stat-info">
                        <span class="lp-stat-number"><?php echo esc_html( $stats['total_courses'] ); ?></span>
                        <span class="lp-stat-label">Khóa học</span>
                    </div>
                </div>
                <div class="lp-stat-card lp-card-green">
                    <div class="lp-stat-icon">👨‍🎓</div>
                    <div class="lp-stat-info">
                        <span class="lp-stat-number"><?php echo esc_html( $stats['total_students'] ); ?></span>
                        <span class="lp-stat-label">Học viên đăng ký</span>
                    </div>
                </div>
                <div class="lp-stat-card lp-card-orange">
                    <div class="lp-stat-icon">✅</div>
                    <div class="lp-stat-info">
                        <span class="lp-stat-number"><?php echo esc_html( $stats['completed_courses'] ); ?></span>
                        <span class="lp-stat-label">Lượt hoàn thành</span>
                    </div>
                </div>
            </div>
            <p class="lp-stats-footer">Cập nhật: <?php echo esc_html( current_time( 'd/m/Y H:i' ) ); ?></p>
        </div>
        <?php
    }

    // ── Shortcode ────────────────────────────────────────────

    public static function render_shortcode( $atts ) {
        $atts  = shortcode_atts( array( 'theme' => 'light' ), $atts, 'lp_total_stats' );
        $stats = self::get_all_stats();
        $cls   = 'lp-theme-' . sanitize_html_class( $atts['theme'] );
        ob_start();
        ?>
        <div class="lp-stats-shortcode <?php echo esc_attr( $cls ); ?>">
            <h3 class="lp-stats-title">📊 Thống kê Khóa học</h3>
            <div class="lp-stats-grid">
                <div class="lp-stat-card lp-card-blue">
                    <div class="lp-stat-icon">📚</div>
                    <div class="lp-stat-info">
                        <span class="lp-stat-number"><?php echo esc_html( $stats['total_courses'] ); ?></span>
                        <span class="lp-stat-label">Tổng số Khóa học</span>
                    </div>
                </div>
                <div class="lp-stat-card lp-card-green">
                    <div class="lp-stat-icon">👨‍🎓</div>
                    <div class="lp-stat-info">
                        <span class="lp-stat-number"><?php echo esc_html( $stats['total_students'] ); ?></span>
                        <span class="lp-stat-label">Học viên đăng ký</span>
                    </div>
                </div>
                <div class="lp-stat-card lp-card-orange">
                    <div class="lp-stat-icon">✅</div>
                    <div class="lp-stat-info">
                        <span class="lp-stat-number"><?php echo esc_html( $stats['completed_courses'] ); ?></span>
                        <span class="lp-stat-label">Lượt hoàn thành</span>
                    </div>
                </div>
            </div>
        </div>
        <?php
        return ob_get_clean();
    }

    // ── Styles ───────────────────────────────────────────────

    public static function enqueue_admin_styles( $hook ) {
        if ( 'index.php' !== $hook ) return;
        wp_enqueue_style( 'lp-stats-admin', LP_STATS_URL . 'assets/css/lp-stats.css', array(), LP_STATS_VERSION );
    }

    public static function enqueue_frontend_styles() {
        wp_enqueue_style( 'lp-stats-frontend', LP_STATS_URL . 'assets/css/lp-stats.css', array(), LP_STATS_VERSION );
    }
}

endif;

LP_Stats_Addon::init();
