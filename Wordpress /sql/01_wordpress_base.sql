-- ============================================================
-- 01_wordpress_base.sql
-- Bảng cơ bản của WordPress + dữ liệu khởi tạo
-- Database: wordpress_lms
-- ============================================================

USE wordpress_lms;
SET NAMES utf8mb4;
SET time_zone = '+07:00';

-- ----------------------------------------------------------
-- Bảng: wp_options (cấu hình WordPress)
-- ----------------------------------------------------------
CREATE TABLE IF NOT EXISTS `wp_options` (
  `option_id`    bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `option_name`  varchar(191)        NOT NULL DEFAULT '',
  `option_value` longtext            NOT NULL,
  `autoload`     varchar(20)         NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`option_id`),
  UNIQUE KEY `option_name` (`option_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `wp_options` (`option_name`, `option_value`, `autoload`) VALUES
('siteurl',           'http://localhost:8080',        'yes'),
('blogname',          'LMS – Học Lập Trình Online',   'yes'),
('blogdescription',   'Nền tảng học trực tuyến mẫu',  'yes'),
('admin_email',       'admin@lms-demo.local',          'yes'),
('blogpublic',        '1',                             'yes'),
('template',          'twentytwentyfour',              'yes'),
('stylesheet',        'twentytwentyfour',              'yes'),
('active_plugins',    'a:2:{i:0;s:36:"learnpress/learnpress.php";i:1;s:44:"lp-stats-addon/lp-stats-addon.php";}', 'yes'),
('woocommerce_currency', 'VND',                        'yes'),
('permalink_structure',  '/%postname%/',               'yes');

-- ----------------------------------------------------------
-- Bảng: wp_users (tài khoản người dùng)
-- ----------------------------------------------------------
CREATE TABLE IF NOT EXISTS `wp_users` (
  `ID`                  bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_login`          varchar(60)  NOT NULL DEFAULT '',
  `user_pass`           varchar(255) NOT NULL DEFAULT '',
  `user_nicename`       varchar(50)  NOT NULL DEFAULT '',
  `user_email`          varchar(100) NOT NULL DEFAULT '',
  `user_url`            varchar(100) NOT NULL DEFAULT '',
  `user_registered`     datetime     NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_activation_key` varchar(255) NOT NULL DEFAULT '',
  `user_status`         int(11)      NOT NULL DEFAULT 0,
  `display_name`        varchar(250) NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  KEY `user_login_key` (`user_login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Password: admin123 (md5 hashed by WordPress)
INSERT INTO `wp_users` (`ID`, `user_login`, `user_pass`, `user_nicename`, `user_email`, `user_registered`, `display_name`) VALUES
(1, 'admin',    '$P$BIRXVebe/ZCzdBPssFDkwMI0KTukt11', 'admin',    'admin@lms-demo.local',   NOW(), 'Administrator'),
(2, 'hocvien1', '$P$BIRXVebe/ZCzdBPssFDkwMI0KTukt11', 'hocvien1', 'hocvien1@lms-demo.local', NOW(), 'Nguyễn Văn An'),
(3, 'hocvien2', '$P$BIRXVebe/ZCzdBPssFDkwMI0KTukt11', 'hocvien2', 'hocvien2@lms-demo.local', NOW(), 'Trần Thị Bình');

-- ----------------------------------------------------------
-- Bảng: wp_usermeta (vai trò người dùng)
-- ----------------------------------------------------------
CREATE TABLE IF NOT EXISTS `wp_usermeta` (
  `umeta_id`   bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id`    bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `meta_key`   varchar(255)        DEFAULT NULL,
  `meta_value` longtext,
  PRIMARY KEY (`umeta_id`),
  KEY `user_id` (`user_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `wp_usermeta` (`user_id`, `meta_key`, `meta_value`) VALUES
(1, 'wp_capabilities',    'a:1:{s:13:"administrator";b:1;}'),
(1, 'wp_user_level',      '10'),
(2, 'wp_capabilities',    'a:1:{s:10:"subscriber";b:1;}'),
(2, 'wp_user_level',      '0'),
(3, 'wp_capabilities',    'a:1:{s:10:"subscriber";b:1;}'),
(3, 'wp_user_level',      '0');

-- ----------------------------------------------------------
-- Bảng: wp_posts (bài viết, trang, khóa học)
-- ----------------------------------------------------------
CREATE TABLE IF NOT EXISTS `wp_posts` (
  `ID`                    bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `post_author`           bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `post_date`             datetime            NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_date_gmt`         datetime            NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content`          longtext            NOT NULL,
  `post_title`            text                NOT NULL,
  `post_excerpt`          text                NOT NULL,
  `post_status`           varchar(20)         NOT NULL DEFAULT 'publish',
  `comment_status`        varchar(20)         NOT NULL DEFAULT 'open',
  `ping_status`           varchar(20)         NOT NULL DEFAULT 'open',
  `post_password`         varchar(255)        NOT NULL DEFAULT '',
  `post_name`             varchar(200)        NOT NULL DEFAULT '',
  `to_ping`               text                NOT NULL,
  `pinged`                text                NOT NULL,
  `post_modified`         datetime            NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_modified_gmt`     datetime            NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content_filtered` longtext            NOT NULL,
  `post_parent`           bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `guid`                  varchar(255)        NOT NULL DEFAULT '',
  `menu_order`            int(11)             NOT NULL DEFAULT 0,
  `post_type`             varchar(20)         NOT NULL DEFAULT 'post',
  `post_mime_type`        varchar(100)        NOT NULL DEFAULT '',
  `comment_count`         bigint(20)          NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`),
  KEY `post_name`   (`post_name`(191)),
  KEY `type_status_date` (`post_type`, `post_status`, `post_date`, `ID`),
  KEY `post_author` (`post_author`),
  KEY `post_parent` (`post_parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------
-- Bảng: wp_postmeta
-- ----------------------------------------------------------
CREATE TABLE IF NOT EXISTS `wp_postmeta` (
  `meta_id`    bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `post_id`    bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `meta_key`   varchar(255)        DEFAULT NULL,
  `meta_value` longtext,
  PRIMARY KEY (`meta_id`),
  KEY `post_id`  (`post_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------
-- Bảng: wp_terms, wp_term_taxonomy, wp_term_relationships
-- ----------------------------------------------------------
CREATE TABLE IF NOT EXISTS `wp_terms` (
  `term_id`    bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name`       varchar(200)        NOT NULL DEFAULT '',
  `slug`       varchar(200)        NOT NULL DEFAULT '',
  `term_group` bigint(10)          NOT NULL DEFAULT 0,
  PRIMARY KEY (`term_id`),
  KEY `slug` (`slug`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `wp_term_taxonomy` (
  `term_taxonomy_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `term_id`          bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `taxonomy`         varchar(32)         NOT NULL DEFAULT '',
  `description`      longtext            NOT NULL,
  `parent`           bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `count`            bigint(20)          NOT NULL DEFAULT 0,
  PRIMARY KEY (`term_taxonomy_id`),
  UNIQUE KEY `term_id_taxonomy` (`term_id`, `taxonomy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `wp_term_relationships` (
  `object_id`        bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `term_taxonomy_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `term_order`       int(11)             NOT NULL DEFAULT 0,
  PRIMARY KEY (`object_id`, `term_taxonomy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Danh mục khóa học
INSERT INTO `wp_terms` (`term_id`, `name`, `slug`) VALUES
(1, 'Lập trình Web',   'lap-trinh-web'),
(2, 'WordPress',        'wordpress'),
(3, 'Chưa phân loại',  'uncategorized');

INSERT INTO `wp_term_taxonomy` (`term_taxonomy_id`, `term_id`, `taxonomy`, `description`, `parent`, `count`) VALUES
(1, 1, 'course_category', 'Các khóa học Lập trình Web', 0, 1),
(2, 2, 'course_category', 'Các khóa học WordPress',     0, 1),
(3, 3, 'category',        '',                            0, 0);
