-- ============================================================
-- 03_sample_data.sql
-- Dữ liệu mẫu: 2 khóa học, bài học, quiz, học viên đăng ký
-- Tương ứng với yêu cầu bài thực hành 30/03/2026
-- ============================================================

USE wordpress_lms;
SET NAMES utf8mb4;
SET time_zone = '+07:00';

-- ===========================================================
-- PHẦN A: CÁC POST (Khóa học, Lesson, Quiz, Question)
-- ===========================================================

INSERT INTO `wp_posts`
  (`ID`, `post_author`, `post_date`, `post_date_gmt`,
   `post_content`, `post_title`, `post_excerpt`,
   `post_status`, `post_name`, `post_modified`, `post_modified_gmt`,
   `to_ping`, `pinged`, `post_content_filtered`, `post_parent`,
   `guid`, `menu_order`, `post_type`, `post_mime_type`, `comment_count`)
VALUES

-- ----------------------------------------------------------
-- KHÓA HỌC 1: Lập trình Web Cơ bản (Miễn phí) – ID: 10
-- ----------------------------------------------------------
(10, 1, NOW(), UTC_TIMESTAMP(),
 '<p>Khóa học toàn diện về HTML, CSS và JavaScript cho người mới bắt đầu.</p><p>Sau khóa học này, bạn có thể xây dựng website tĩnh hoàn chỉnh và hiểu cơ bản về lập trình frontend.</p>',
 'Lập trình Web Cơ bản', 'Học HTML, CSS và JavaScript từ đầu',
 'publish', 'lap-trinh-web-co-ban',
 NOW(), UTC_TIMESTAMP(), '', '', '', 0,
 'http://localhost:8080/?post_type=lp_course&p=10',
 0, 'lp_course', '', 0),

-- LESSON 1.1 – ID: 11
(11, 1, NOW(), UTC_TIMESTAMP(),
 '<h2>HTML là gì?</h2><p>HTML (HyperText Markup Language) là ngôn ngữ đánh dấu chuẩn để tạo trang web.</p><h3>Cấu trúc cơ bản</h3><pre><code>&lt;!DOCTYPE html&gt;\n&lt;html&gt;\n  &lt;head&gt;&lt;title&gt;Trang đầu tiên&lt;/title&gt;&lt;/head&gt;\n  &lt;body&gt;&lt;h1&gt;Xin chào!&lt;/h1&gt;&lt;/body&gt;\n&lt;/html&gt;</code></pre>',
 'Bài 1: Giới thiệu HTML và cấu trúc trang web', '',
 'publish', 'bai-1-gioi-thieu-html',
 NOW(), UTC_TIMESTAMP(), '', '', '', 10,
 'http://localhost:8080/?post_type=lp_lesson&p=11',
 0, 'lp_lesson', '', 0),

-- LESSON 1.2 – ID: 12
(12, 1, NOW(), UTC_TIMESTAMP(),
 '<h2>CSS – Cascading Style Sheets</h2><p>CSS dùng để định dạng giao diện HTML. Cú pháp cơ bản:</p><pre><code>selector {\n  thuoc-tinh: gia-tri;\n}</code></pre><p>Ví dụ: <code>h1 { color: red; font-size: 24px; }</code></p>',
 'Bài 2: CSS và định dạng giao diện', '',
 'publish', 'bai-2-css-dinh-dang-giao-dien',
 NOW(), UTC_TIMESTAMP(), '', '', '', 10,
 'http://localhost:8080/?post_type=lp_lesson&p=12',
 0, 'lp_lesson', '', 0),

-- QUIZ 1 – ID: 13
(13, 1, NOW(), UTC_TIMESTAMP(),
 '', 'Kiểm tra: HTML & CSS Cơ bản', '',
 'publish', 'kiem-tra-html-css',
 NOW(), UTC_TIMESTAMP(), '', '', '', 10,
 'http://localhost:8080/?post_type=lp_quiz&p=13',
 0, 'lp_quiz', '', 0),

-- QUESTION 1 (thuộc Quiz 1) – ID: 14
(14, 1, NOW(), UTC_TIMESTAMP(),
 '<p>Thẻ HTML nào dùng để tạo tiêu đề lớn nhất?</p>',
 'Thẻ tiêu đề lớn nhất trong HTML', '',
 'publish', 'cau-hoi-the-h1',
 NOW(), UTC_TIMESTAMP(), '', '', '', 13,
 'http://localhost:8080/?post_type=lp_question&p=14',
 0, 'lp_question', '', 0),

-- QUESTION 2 (thuộc Quiz 1) – ID: 15
(15, 1, NOW(), UTC_TIMESTAMP(),
 '<p>Thuộc tính CSS nào dùng để thay đổi màu chữ?</p>',
 'Thuộc tính CSS màu chữ', '',
 'publish', 'cau-hoi-css-color',
 NOW(), UTC_TIMESTAMP(), '', '', '', 13,
 'http://localhost:8080/?post_type=lp_question&p=15',
 0, 'lp_question', '', 0),

-- ----------------------------------------------------------
-- KHÓA HỌC 2: WordPress Nâng cao – ID: 20
-- ----------------------------------------------------------
(20, 1, NOW(), UTC_TIMESTAMP(),
 '<p>Khóa học chuyên sâu về phát triển theme và plugin WordPress. Yêu cầu đã biết PHP cơ bản.</p><p>Nội dung gồm: WordPress hooks, Custom Post Types, REST API, WP-CLI và bảo mật.</p>',
 'Phát triển Plugin WordPress Nâng cao', 'Xây dựng plugin từ đầu với chuẩn WordPress Coding Standards',
 'publish', 'phat-trien-plugin-wordpress',
 NOW(), UTC_TIMESTAMP(), '', '', '', 0,
 'http://localhost:8080/?post_type=lp_course&p=20',
 0, 'lp_course', '', 0),

-- LESSON 2.1 – ID: 21
(21, 1, NOW(), UTC_TIMESTAMP(),
 '<h2>WordPress Hooks: Actions & Filters</h2><p>Hook là cơ chế cốt lõi của WordPress cho phép can thiệp vào luồng xử lý mà không sửa code gốc.</p><h3>Action Hook</h3><pre><code>add_action( \'init\', function() {\n    // Chạy khi WordPress khởi tạo\n});</code></pre><h3>Filter Hook</h3><pre><code>add_filter( \'the_content\', function( $content ) {\n    return $content . \'<p>Thêm vào cuối bài viết</p>\';\n});</code></pre>',
 'Bài 1: WordPress Hooks – Actions và Filters', '',
 'publish', 'bai-1-wordpress-hooks',
 NOW(), UTC_TIMESTAMP(), '', '', '', 20,
 'http://localhost:8080/?post_type=lp_lesson&p=21',
 0, 'lp_lesson', '', 0),

-- LESSON 2.2 – ID: 22
(22, 1, NOW(), UTC_TIMESTAMP(),
 '<h2>Custom Post Types (CPT)</h2><p>CPT cho phép tạo loại nội dung tùy chỉnh ngoài Post và Page mặc định của WordPress.</p><pre><code>function dang_ky_cpt_khoa_hoc() {\n    register_post_type( \'khoa_hoc\', array(\n        \'labels\'  => array( \'name\' => \'Khóa học\' ),\n        \'public\'  => true,\n        \'supports\'=> array( \'title\', \'editor\', \'thumbnail\' ),\n    ));\n}\nadd_action( \'init\', \'dang_ky_cpt_khoa_hoc\' );</code></pre>',
 'Bài 2: Custom Post Types và Taxonomies', '',
 'publish', 'bai-2-custom-post-types',
 NOW(), UTC_TIMESTAMP(), '', '', '', 20,
 'http://localhost:8080/?post_type=lp_lesson&p=22',
 0, 'lp_lesson', '', 0),

-- QUIZ 2 – ID: 23
(23, 1, NOW(), UTC_TIMESTAMP(),
 '', 'Kiểm tra: WordPress Plugin Development', '',
 'publish', 'kiem-tra-plugin-development',
 NOW(), UTC_TIMESTAMP(), '', '', '', 20,
 'http://localhost:8080/?post_type=lp_quiz&p=23',
 0, 'lp_quiz', '', 0),

-- QUESTION 3 (thuộc Quiz 2) – ID: 24
(24, 1, NOW(), UTC_TIMESTAMP(),
 '<p>Hook nào được gọi khi WordPress hoàn tất khởi tạo nhưng chưa gửi header?</p>',
 'Hook khởi tạo WordPress', '',
 'publish', 'cau-hoi-hook-init',
 NOW(), UTC_TIMESTAMP(), '', '', '', 23,
 'http://localhost:8080/?post_type=lp_question&p=24',
 0, 'lp_question', '', 0),

-- QUESTION 4 (thuộc Quiz 2) – ID: 25
(25, 1, NOW(), UTC_TIMESTAMP(),
 '<p>Hàm nào dùng để thêm widget vào WordPress Admin Dashboard?</p>',
 'Hàm thêm Dashboard Widget', '',
 'publish', 'cau-hoi-dashboard-widget',
 NOW(), UTC_TIMESTAMP(), '', '', '', 23,
 'http://localhost:8080/?post_type=lp_question&p=25',
 0, 'lp_question', '', 0),

-- TRANG CHỦ – ID: 100
(100, 1, NOW(), UTC_TIMESTAMP(),
 '[lp_total_stats]\n\n<h2>Chào mừng đến với LMS Demo</h2>\n<p>Nền tảng học trực tuyến mẫu cho bài thực hành WordPress Plugin.</p>',
 'Trang chủ', '',
 'publish', 'trang-chu',
 NOW(), UTC_TIMESTAMP(), '', '', '', 0,
 'http://localhost:8080/?page_id=100',
 0, 'page', '', 0);

-- ===========================================================
-- PHẦN B: POSTMETA – Giá tiền, cài đặt khóa học
-- ===========================================================

INSERT INTO `wp_postmeta` (`post_id`, `meta_key`, `meta_value`) VALUES
-- Khóa học 1: Miễn phí
(10, '_lp_price',           '0'),
(10, '_lp_sale_price',      ''),
(10, '_lp_course_price_type', 'free'),
(10, '_lp_duration',        '30 days'),
(10, '_lp_max_students',    '100'),
(10, '_thumbnail_id',       ''),
(10, '_lp_passing_condition','80'),

-- Khóa học 2: Có phí
(20, '_lp_price',           '299000'),
(20, '_lp_sale_price',      '199000'),
(20, '_lp_course_price_type', 'paid'),
(20, '_lp_duration',        '60 days'),
(20, '_lp_max_students',    '50'),
(20, '_thumbnail_id',       ''),
(20, '_lp_passing_condition','75'),

-- Quiz settings
(13, '_lp_duration',        '30 minutes'),
(13, '_lp_passing_grade',   '80'),
(13, '_lp_retake_count',    '3'),
(23, '_lp_duration',        '45 minutes'),
(23, '_lp_passing_grade',   '75'),
(23, '_lp_retake_count',    '2'),

-- Question 1 answers: h1 / h2 / h3 / h4
(14, '_lp_question_answer', 'a:4:{s:5:"value";a:4:{i:0;s:2:"h1";i:1;s:2:"h2";i:2;s:2:"h3";i:3;s:2:"h4";}s:7:"correct";a:1:{i:0;s:1:"0";}s:4:"text";a:4:{i:0;s:8:"&lt;h1&gt;";i:1;s:8:"&lt;h2&gt;";i:2;s:8:"&lt;h3&gt;";i:3;s:8:"&lt;h4&gt;";}s:7:"options";a:4:{i:0;b:1;i:1;b:0;i:2;b:0;i:3;b:0;}}'),
(14, '_lp_question_type',   'single_choice'),

-- Question 2 answers: color / font-color / text-color / foreground
(15, '_lp_question_answer', 'a:4:{s:5:"value";a:4:{i:0;s:5:"color";i:1;s:10:"font-color";i:2;s:10:"text-color";i:3;s:10:"foreground";}s:7:"correct";a:1:{i:0;s:1:"0";}s:4:"text";a:4:{i:0;s:5:"color";i:1;s:10:"font-color";i:2;s:10:"text-color";i:3;s:10:"foreground";}s:7:"options";a:4:{i:0;b:1;i:1;b:0;i:2;b:0;i:3;b:0;}}'),
(15, '_lp_question_type',   'single_choice'),

-- Question 3: init / ready / wp_loaded / after_setup_theme
(24, '_lp_question_answer', 'a:4:{s:5:"value";a:4:{i:0;s:4:"init";i:1;s:5:"ready";i:2;s:9:"wp_loaded";i:3;s:17:"after_setup_theme";}s:7:"correct";a:1:{i:0;s:1:"0";}s:4:"text";a:4:{i:0;s:4:"init";i:1;s:5:"ready";i:2;s:9:"wp_loaded";i:3;s:17:"after_setup_theme";}s:7:"options";a:4:{i:0;b:1;i:1;b:0;i:2;b:0;i:3;b:0;}}'),
(24, '_lp_question_type',   'single_choice'),

-- Question 4: wp_add_dashboard_widget
(25, '_lp_question_answer', 'a:4:{s:5:"value";a:4:{i:0;s:24:"wp_add_dashboard_widget()";i:1;s:22:"add_dashboard_widget()";i:2;s:22:"register_widget_area()";i:3;s:16:"add_meta_box()";}s:7:"correct";a:1:{i:0;s:1:"0";}s:4:"text";a:4:{i:0;s:24:"wp_add_dashboard_widget()";i:1;s:22:"add_dashboard_widget()";i:2;s:22:"register_widget_area()";i:3;s:16:"add_meta_box()";}s:7:"options";a:4:{i:0;b:1;i:1;b:0;i:2;b:0;i:3;b:0;}}'),
(25, '_lp_question_type',   'single_choice');

-- ===========================================================
-- PHẦN C: CẤU TRÚC KHÓA HỌC (Sections & Items)
-- ===========================================================

-- Sections của Khóa học 1
INSERT INTO `wp_learnpress_sections` (`section_id`, `section_name`, `section_course_id`, `section_order`) VALUES
(1, 'Chương 1: Nền tảng HTML',   10, 1),
(2, 'Chương 1: Nền tảng CSS',    10, 2),
(3, 'Chương 1: WordPress Hooks', 20, 1),
(4, 'Chương 2: Plugin Development', 20, 2);

-- Items của từng section
INSERT INTO `wp_learnpress_section_items` (`section_id`, `item_id`, `item_order`) VALUES
(1, 11, 1),  -- Lesson 1.1 → Section 1
(2, 12, 1),  -- Lesson 1.2 → Section 2
(2, 13, 2),  -- Quiz 1     → Section 2
(3, 21, 1),  -- Lesson 2.1 → Section 3
(4, 22, 1),  -- Lesson 2.2 → Section 4
(4, 23, 2);  -- Quiz 2     → Section 4

-- Quiz → Questions
INSERT INTO `wp_learnpress_quiz_questions` (`quiz_id`, `question_id`, `question_order`, `question_mark`) VALUES
(13, 14, 1, 5),
(13, 15, 2, 5),
(23, 24, 1, 5),
(23, 25, 2, 5);

-- ===========================================================
-- PHẦN D: ĐĂNG KÝ HỌC (learnpress_user_items)
-- Đây là dữ liệu mà plugin lp-stats-addon đọc trực tiếp
-- ===========================================================

INSERT INTO `wp_learnpress_user_items`
  (`user_item_id`, `user_id`, `item_id`, `item_type`, `status`, `ref_id`, `ref_type`, `graduation`, `start_time`, `end_time`)
VALUES

-- hocvien1 (user_id=2) đăng ký Khóa học 1 → ĐÃ HOÀN THÀNH
(1,  2, 10, 'lp_course', 'completed',   0, NULL, 'passed',
 DATE_SUB(NOW(), INTERVAL 20 DAY), DATE_SUB(NOW(), INTERVAL 5 DAY)),

-- hocvien1 học Lesson 1.1 → hoàn thành
(2,  2, 11, 'lp_lesson', 'completed',   10, 'lp_course', NULL,
 DATE_SUB(NOW(), INTERVAL 20 DAY), DATE_SUB(NOW(), INTERVAL 18 DAY)),

-- hocvien1 học Lesson 1.2 → hoàn thành
(3,  2, 12, 'lp_lesson', 'completed',   10, 'lp_course', NULL,
 DATE_SUB(NOW(), INTERVAL 18 DAY), DATE_SUB(NOW(), INTERVAL 15 DAY)),

-- hocvien1 làm Quiz 1 → passed
(4,  2, 13, 'lp_quiz',   'completed',   10, 'lp_course', 'passed',
 DATE_SUB(NOW(), INTERVAL 15 DAY), DATE_SUB(NOW(), INTERVAL 15 DAY)),

-- hocvien1 đăng ký Khóa học 2 → ĐANG HỌC (in-progress)
(5,  2, 20, 'lp_course', 'in-progress', 0, NULL, NULL,
 DATE_SUB(NOW(), INTERVAL 3 DAY), NULL),

-- hocvien1 học Lesson 2.1 → hoàn thành
(6,  2, 21, 'lp_lesson', 'completed',   20, 'lp_course', NULL,
 DATE_SUB(NOW(), INTERVAL 3 DAY), DATE_SUB(NOW(), INTERVAL 2 DAY)),

-- hocvien2 (user_id=3) đăng ký Khóa học 1 → ĐÃ HOÀN THÀNH
(7,  3, 10, 'lp_course', 'completed',   0, NULL, 'passed',
 DATE_SUB(NOW(), INTERVAL 15 DAY), DATE_SUB(NOW(), INTERVAL 2 DAY)),

-- hocvien2 học Lesson 1.1
(8,  3, 11, 'lp_lesson', 'completed',   10, 'lp_course', NULL,
 DATE_SUB(NOW(), INTERVAL 15 DAY), DATE_SUB(NOW(), INTERVAL 13 DAY)),

-- hocvien2 học Lesson 1.2
(9,  3, 12, 'lp_lesson', 'completed',   10, 'lp_course', NULL,
 DATE_SUB(NOW(), INTERVAL 13 DAY), DATE_SUB(NOW(), INTERVAL 10 DAY)),

-- hocvien2 làm Quiz 1 → passed
(10, 3, 13, 'lp_quiz',   'completed',   10, 'lp_course', 'passed',
 DATE_SUB(NOW(), INTERVAL 10 DAY), DATE_SUB(NOW(), INTERVAL 10 DAY));

-- ===========================================================
-- PHẦN E: LIÊN KẾT KHÓA HỌC ↔ DANH MỤC
-- ===========================================================
INSERT INTO `wp_term_relationships` (`object_id`, `term_taxonomy_id`) VALUES
(10, 1),  -- Khóa học 1 → Lập trình Web
(20, 2);  -- Khóa học 2 → WordPress

-- Trang chủ: đặt làm front page
INSERT INTO `wp_options` (`option_name`, `option_value`, `autoload`) VALUES
('show_on_front', 'page', 'yes'),
('page_on_front', '100',  'yes')
ON DUPLICATE KEY UPDATE `option_value` = VALUES(`option_value`);

-- ===========================================================
-- KIỂM TRA DỮ LIỆU (có thể xóa sau khi import)
-- ===========================================================
SELECT
  (SELECT COUNT(*) FROM wp_posts WHERE post_type = 'lp_course' AND post_status = 'publish') AS tong_khoa_hoc,
  (SELECT COUNT(DISTINCT user_id) FROM wp_learnpress_user_items WHERE item_type = 'lp_course') AS tong_hoc_vien,
  (SELECT COUNT(*) FROM wp_learnpress_user_items WHERE item_type = 'lp_course' AND status = 'completed') AS luot_hoan_thanh;

SELECT 'Sample data inserted successfully.' AS status;
