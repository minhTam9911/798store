CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1: active, 0: inactive',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Lưu thông tin người dùng hệ thống';

-- Bảng lưu thông tin sản phẩm
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT 'Tên sản phẩm',
  `slug` varchar(255) NOT NULL COMMENT 'Slug cho SEO URL',
  `sku` varchar(50) DEFAULT NULL COMMENT 'Mã sản phẩm',
  `short_description` text DEFAULT NULL COMMENT 'Mô tả ngắn cho SEO',
  `description` longtext DEFAULT NULL COMMENT 'Mô tả chi tiết sản phẩm',
  `price` decimal(10,2) NOT NULL COMMENT 'Giá gốc',
  `sale_price` decimal(10,2) DEFAULT NULL COMMENT 'Giá khuyến mãi',
  `stock_quantity` int(11) NOT NULL DEFAULT 0 COMMENT 'Số lượng tồn kho',
  `weight` decimal(10,2) DEFAULT NULL COMMENT 'Trọng lượng (gram)',
  `length` decimal(10,2) DEFAULT NULL COMMENT 'Chiều dài (cm)',
  `width` decimal(10,2) DEFAULT NULL COMMENT 'Chiều rộng (cm)',
  `height` decimal(10,2) DEFAULT NULL COMMENT 'Chiều cao (cm)',
  `meta_title` varchar(255) DEFAULT NULL COMMENT 'Meta title cho SEO',
  `meta_description` text DEFAULT NULL COMMENT 'Meta description cho SEO',
  `meta_keywords` text DEFAULT NULL COMMENT 'Meta keywords cho SEO',
  `status` varchar(15) NOT NULL DEFAULT 'draft' COMMENT 'Trạng thái sản phẩm draft,published,archived',
  `featured` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Sản phẩm nổi bật',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  UNIQUE KEY `sku` (`sku`),
  FULLTEXT KEY `search_index` (`name`,`short_description`,`description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Lưu thông tin sản phẩm';

-- Bảng danh mục sản phẩm
CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT 'Tên danh mục',
  `slug` varchar(100) NOT NULL COMMENT 'Slug cho SEO URL',
  `description` text DEFAULT NULL COMMENT 'Mô tả danh mục',
  `parent_id` int(11) DEFAULT NULL COMMENT 'Danh mục cha',
  `image` varchar(255) DEFAULT NULL COMMENT 'Ảnh đại diện danh mục',
  `meta_title` varchar(255) DEFAULT NULL COMMENT 'Meta title cho SEO',
  `meta_description` text DEFAULT NULL COMMENT 'Meta description cho SEO',
  `meta_keywords` text DEFAULT NULL COMMENT 'Meta keywords cho SEO',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1: active, 0: inactive',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Danh mục sản phẩm';

-- Bảng liên kết sản phẩm với danh mục
CREATE TABLE `product_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_category` (`product_id`,`category_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `product_categories_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_categories_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Liên kết sản phẩm với danh mục';

-- Bảng hình ảnh sản phẩm
CREATE TABLE `product_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `path` varchar(255) NOT NULL COMMENT 'Đường dẫn ảnh',
  `alt_text` varchar(255) DEFAULT NULL COMMENT 'Alt text cho SEO',
  `is_default` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Ảnh mặc định',
  `sort_order` int(11) NOT NULL DEFAULT 0 COMMENT 'Thứ tự sắp xếp',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `product_images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Hình ảnh sản phẩm';

-- Bảng thuộc tính sản phẩm (màu sắc, kích thước)
CREATE TABLE `attributes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT 'Tên thuộc tính (vd: Màu sắc, Kích cỡ)',
  `slug` varchar(100) NOT NULL COMMENT 'Slug thuộc tính',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Thuộc tính sản phẩm';

-- Bảng giá trị thuộc tính (vd: Đỏ, Xanh, XL, M)
CREATE TABLE `attribute_values` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attribute_id` int(11) NOT NULL,
  `value` varchar(100) NOT NULL COMMENT 'Giá trị thuộc tính',
  `color_code` varchar(20) DEFAULT NULL COMMENT 'Mã màu nếu là thuộc tính màu',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `attribute_id` (`attribute_id`),
  CONSTRAINT `attribute_values_ibfk_1` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Giá trị thuộc tính';

-- Bảng liên kết sản phẩm với thuộc tính
CREATE TABLE `product_attributes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `attribute_id` int(11) NOT NULL,
  `attribute_value_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_attribute_value` (`product_id`,`attribute_id`,`attribute_value_id`),
  KEY `attribute_id` (`attribute_id`),
  KEY `attribute_value_id` (`attribute_value_id`),
  CONSTRAINT `product_attributes_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_attributes_ibfk_2` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_attributes_ibfk_3` FOREIGN KEY (`attribute_value_id`) REFERENCES `attribute_values` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Liên kết sản phẩm với thuộc tính';

-- Bảng biến thể sản phẩm (kết hợp các thuộc tính)
CREATE TABLE `product_variants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `sku` varchar(50) DEFAULT NULL COMMENT 'Mã SKU riêng cho biến thể',
  `price` decimal(10,2) DEFAULT NULL COMMENT 'Giá riêng nếu khác giá sản phẩm',
  `sale_price` decimal(10,2) DEFAULT NULL COMMENT 'Giá khuyến mãi riêng',
  `stock_quantity` int(11) NOT NULL DEFAULT 0 COMMENT 'Số lượng tồn kho',
  `image` varchar(255) DEFAULT NULL COMMENT 'Ảnh riêng cho biến thể',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `sku` (`sku`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `product_variants_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Biến thể sản phẩm';

-- Bảng thuộc tính của biến thể
CREATE TABLE `variant_attributes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `variant_id` int(11) NOT NULL,
  `attribute_id` int(11) NOT NULL,
  `attribute_value_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `variant_attribute` (`variant_id`,`attribute_id`),
  KEY `attribute_id` (`attribute_id`),
  KEY `attribute_value_id` (`attribute_value_id`),
  CONSTRAINT `variant_attributes_ibfk_1` FOREIGN KEY (`variant_id`) REFERENCES `product_variants` (`id`) ON DELETE CASCADE,
  CONSTRAINT `variant_attributes_ibfk_2` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `variant_attributes_ibfk_3` FOREIGN KEY (`attribute_value_id`) REFERENCES `attribute_values` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Thuộc tính của biến thể';

-- Bảng đánh giá sản phẩm
CREATE TABLE `product_reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `rating` tinyint(1) NOT NULL COMMENT 'Đánh giá từ 1-5 sao',
  `review` text DEFAULT NULL COMMENT 'Nội dung đánh giá',
  `status` varchar(10) NOT NULL DEFAULT 'pending' COMMENT 'Trạng thái phê duyệt pending, approved,rejected',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `product_reviews_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_reviews_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Đánh giá sản phẩm';

-- Bảng đơn hàng
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_number` varchar(20) NOT NULL COMMENT 'Mã đơn hàng',
  `user_id` int(11) DEFAULT NULL COMMENT 'Khách hàng đăng nhập',
  `customer_name` varchar(100) NOT NULL COMMENT 'Tên khách hàng',
  `customer_email` varchar(100) NOT NULL COMMENT 'Email khách hàng',
  `customer_phone` varchar(20) NOT NULL COMMENT 'SĐT khách hàng',
  `customer_address` text NOT NULL COMMENT 'Địa chỉ giao hàng',
  `order_note` text DEFAULT NULL COMMENT 'Ghi chú đơn hàng',
  `subtotal` decimal(10,2) NOT NULL COMMENT 'Tổng tiền hàng',
  `shipping_fee` decimal(10,2) NOT NULL DEFAULT 0 COMMENT 'Phí vận chuyển',
  `discount` decimal(10,2) NOT NULL DEFAULT 0 COMMENT 'Giảm giá',
  `total` decimal(10,2) NOT NULL COMMENT 'Tổng thanh toán',
  `payment_method` varchar(50) NOT NULL COMMENT 'Phương thức thanh toán',
  `payment_status`varchar(10)  NOT NULL DEFAULT 'pending' COMMENT 'Trạng thái thanh toán pending, paid,failed,refunded',
  `status` varchar(10) NOT NULL DEFAULT 'pending' COMMENT 'Trạng thái đơn hàng pending,processing,shipped,delivered,cancelled',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_number` (`order_number`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Đơn hàng';

-- Bảng chi tiết đơn hàng
CREATE TABLE `order_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `variant_id` int(11) DEFAULT NULL COMMENT 'ID biến thể nếu có',
  `product_name` varchar(255) NOT NULL COMMENT 'Tên sản phẩm lúc mua',
  `product_image` varchar(255) DEFAULT NULL COMMENT 'Ảnh sản phẩm lúc mua',
  `price` decimal(10,2) NOT NULL COMMENT 'Giá lúc mua',
  `quantity` int(11) NOT NULL COMMENT 'Số lượng',
  `subtotal` decimal(10,2) NOT NULL COMMENT 'Thành tiền',
  `attributes` text DEFAULT NULL COMMENT 'JSON lưu thuộc tính biến thể',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Chi tiết đơn hàng';

-- Bảng khuyến mãi
CREATE TABLE `coupons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL COMMENT 'Mã khuyến mãi',
  `discount_type` varchar(10) NOT NULL COMMENT 'Loại giảm giá draft,published',
  `discount_value` decimal(10,2) NOT NULL COMMENT 'Giá trị giảm giá',
  `min_order_amount` decimal(10,2) DEFAULT NULL COMMENT 'Đơn tối thiểu để áp dụng',
  `start_date` datetime NOT NULL COMMENT 'Ngày bắt đầu',
  `end_date` datetime NOT NULL COMMENT 'Ngày kết thúc',
  `usage_limit` int(11) DEFAULT NULL COMMENT 'Giới hạn số lần sử dụng',
  `used_count` int(11) NOT NULL DEFAULT 0 COMMENT 'Số lần đã sử dụng',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1: active, 0: inactive',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Mã khuyến mãi';

-- Bảng lưu lịch sử sử dụng coupon
CREATE TABLE `coupon_usages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coupon_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `discount_amount` decimal(10,2) NOT NULL COMMENT 'Số tiền đã giảm',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `coupon_id` (`coupon_id`),
  KEY `user_id` (`user_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `coupon_usages_ibfk_1` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`) ON DELETE CASCADE,
  CONSTRAINT `coupon_usages_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `coupon_usages_ibfk_3` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Lịch sử sử dụng coupon';

-- Bảng blog (hỗ trợ SEO content)
CREATE TABLE `blogs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT 'Tiêu đề bài viết',
  `slug` varchar(255) NOT NULL COMMENT 'Slug cho SEO URL',
  `short_description` text DEFAULT NULL COMMENT 'Mô tả ngắn',
  `content` longtext DEFAULT NULL COMMENT 'Nội dung bài viết',
  `image` varchar(255) DEFAULT NULL COMMENT 'Ảnh đại diện',
  `meta_title` varchar(255) DEFAULT NULL COMMENT 'Meta title cho SEO',
  `meta_description` text DEFAULT NULL COMMENT 'Meta description cho SEO',
  `meta_keywords` text DEFAULT NULL COMMENT 'Meta keywords cho SEO',
  `status` varchar(10) NOT NULL DEFAULT 'draft' COMMENT 'Trạng thái bài viết draft,published',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  FULLTEXT KEY `search_index` (`title`,`short_description`,`content`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Bài viết blog hỗ trợ SEO';

-- Bảng tags cho blog
CREATE TABLE `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT 'Tên tag',
  `slug` varchar(50) NOT NULL COMMENT 'Slug tag',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Tags cho bài viết blog';

-- Bảng liên kết blog với tags
CREATE TABLE `blog_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `blog_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `blog_tag` (`blog_id`,`tag_id`),
  KEY `tag_id` (`tag_id`),
  CONSTRAINT `blog_tags_ibfk_1` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `blog_tags_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Liên kết blog với tags';

-- Bảng lưu thông tin SEO cho các trang tĩnh
CREATE TABLE `seo_pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_name` varchar(100) NOT NULL COMMENT 'Tên trang (vd: trang chủ, giới thiệu)',
  `slug` varchar(100) NOT NULL COMMENT 'Slug trang',
  `meta_title` varchar(255) DEFAULT NULL COMMENT 'Meta title cho SEO',
  `meta_description` text DEFAULT NULL COMMENT 'Meta description cho SEO',
  `meta_keywords` text DEFAULT NULL COMMENT 'Meta keywords cho SEO',
  `canonical_url` varchar(255) DEFAULT NULL COMMENT 'Canonical URL',
  `og_title` varchar(255) DEFAULT NULL COMMENT 'OG title',
  `og_description` text DEFAULT NULL COMMENT 'OG description',
  `og_image` varchar(255) DEFAULT NULL COMMENT 'OG image',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Thông tin SEO cho các trang tĩnh';