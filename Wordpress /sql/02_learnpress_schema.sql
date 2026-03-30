-- ============================================================
-- 02_learnpress_schema.sql
-- Tạo các bảng tùy chỉnh của LearnPress
-- ============================================================

USE wordpress_lms;
SET NAMES utf8mb4;

-- ----------------------------------------------------------
-- Bảng: wp_learnpress_user_items
-- Lưu tiến trình học của từng user với từng item (course/lesson/quiz)
-- Đây là bảng quan trọng nhất mà plugin lp-stats-addon truy vấn
-- ----------------------------------------------------------
CREATE TABLE IF NOT EXISTS `wp_learnpress_user_items` (
  `user_item_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id`      bigint(20) UNSIGNED NOT NULL DEFAULT 0,   -- ID học viên (wp_users)
  `item_id`      bigint(20) UNSIGNED NOT NULL DEFAULT 0,   -- ID course/lesson/quiz (wp_posts)
  `item_type`    varchar(45)         NOT NULL DEFAULT '',  -- 'lp_course','lp_lesson','lp_quiz'
  `status`       varchar(45)         NOT NULL DEFAULT '',  -- 'enrolled','in-progress','completed'
  `ref_id`       bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `ref_type`     varchar(45)                  DEFAULT NULL,
  `graduation`   varchar(45)                  DEFAULT NULL, -- 'passed','failed'
  `access_level` varchar(45)                  DEFAULT NULL,
  `start_time`   datetime                     DEFAULT NULL,
  `end_time`     datetime                     DEFAULT NULL,
  `expiration_time` datetime                  DEFAULT NULL,
  PRIMARY KEY (`user_item_id`),
  KEY `idx_user_id`   (`user_id`),
  KEY `idx_item_id`   (`item_id`),
  KEY `idx_item_type` (`item_type`),
  KEY `idx_status`    (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------
-- Bảng: wp_learnpress_user_itemmeta
-- Metadata bổ sung cho từng user_item
-- ----------------------------------------------------------
CREATE TABLE IF NOT EXISTS `wp_learnpress_user_itemmeta` (
  `meta_id`      bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `learnpress_user_item_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `meta_key`     varchar(255)        DEFAULT NULL,
  `meta_value`   longtext,
  `extra_value`  longtext,
  PRIMARY KEY (`meta_id`),
  KEY `meta_key` (`meta_key`(191)),
  KEY `learnpress_user_item_id` (`learnpress_user_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------
-- Bảng: wp_learnpress_sections
-- Chương/phần trong khóa học
-- ----------------------------------------------------------
CREATE TABLE IF NOT EXISTS `wp_learnpress_sections` (
  `section_id`          int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `section_name`        text             NOT NULL,
  `section_course_id`   bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `section_order`       int(11) UNSIGNED NOT NULL DEFAULT 0,
  `section_description` text,
  PRIMARY KEY (`section_id`),
  KEY `section_course_id` (`section_course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------
-- Bảng: wp_learnpress_section_items
-- Danh sách bài học/quiz trong mỗi section
-- ----------------------------------------------------------
CREATE TABLE IF NOT EXISTS `wp_learnpress_section_items` (
  `section_item_id`    bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `section_id`         int(11) UNSIGNED    NOT NULL DEFAULT 0,
  `item_id`            bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `item_order`         int(11) UNSIGNED    NOT NULL DEFAULT 0,
  `item_prevtype`      varchar(45)                  DEFAULT NULL,
  `item_duration`      varchar(45)                  DEFAULT NULL,
  PRIMARY KEY (`section_item_id`),
  KEY `section_id` (`section_id`),
  KEY `item_id`    (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------
-- Bảng: wp_learnpress_quiz_questions
-- Câu hỏi trong bài kiểm tra
-- ----------------------------------------------------------
CREATE TABLE IF NOT EXISTS `wp_learnpress_quiz_questions` (
  `quiz_question_id`    bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `quiz_id`             bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `question_id`         bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `question_order`      int(11) UNSIGNED    NOT NULL DEFAULT 0,
  `question_mark`       float               NOT NULL DEFAULT 1,
  `question_type`       varchar(45)                  DEFAULT 'single_choice',
  PRIMARY KEY (`quiz_question_id`),
  KEY `quiz_id`     (`quiz_id`),
  KEY `question_id` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------
-- Bảng: wp_learnpress_order_items
-- Đơn hàng (mua khóa học)
-- ----------------------------------------------------------
CREATE TABLE IF NOT EXISTS `wp_learnpress_order_items` (
  `order_item_id`   bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_item_name` text                NOT NULL,
  `order_id`        bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `item_id`         bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `item_type`       varchar(45)         NOT NULL DEFAULT 'lp_course',
  `course_id`       bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`order_item_id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------
-- Bảng: wp_learnpress_order_itemmeta
-- ----------------------------------------------------------
CREATE TABLE IF NOT EXISTS `wp_learnpress_order_itemmeta` (
  `meta_id`           bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_item_id`     bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `meta_key`          varchar(255)        DEFAULT NULL,
  `meta_value`        longtext,
  PRIMARY KEY (`meta_id`),
  KEY `order_item_id` (`order_item_id`),
  KEY `meta_key`      (`meta_key`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SELECT 'LearnPress schema created successfully.' AS status;
