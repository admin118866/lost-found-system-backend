/*
 Navicat Premium Dump SQL

 Source Server         : mybatis
 Source Server Type    : MySQL
 Source Server Version : 80025 (8.0.25)
 Source Host           : localhost:3306
 Source Schema         : lost_and_found

 Target Server Type    : MySQL
 Target Server Version : 80025 (8.0.25)
 File Encoding         : 65001

 Date: 05/03/2026 22:31:24
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for announcements
-- ----------------------------
DROP TABLE IF EXISTS `announcements`;
CREATE TABLE `announcements`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告内容',
  `announcement_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'SYSTEM' COMMENT '公告类型: SYSTEM/ACTIVITY/MAINTENANCE/OTHER',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'DRAFT' COMMENT '状态: DRAFT/PUBLISHED',
  `is_top` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否置顶: 0否, 1是',
  `publisher_id` bigint NOT NULL COMMENT '发布者ID',
  `publisher_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发布者姓名',
  `publish_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `expire_time` datetime NULL DEFAULT NULL COMMENT '过期时间',
  `view_count` int NOT NULL DEFAULT 0 COMMENT '浏览次数',
  `created_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_publisher_id`(`publisher_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_is_top`(`is_top` ASC) USING BTREE,
  INDEX `idx_announcement_type`(`announcement_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for claim_records
-- ----------------------------
DROP TABLE IF EXISTS `claim_records`;
CREATE TABLE `claim_records`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '认领记录ID',
  `item_id` bigint NOT NULL COMMENT '失物ID',
  `claim_user_id` bigint NOT NULL COMMENT '认领用户ID',
  `claim_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '认领理由',
  `contact_info` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '认领人联系方式',
  `status` enum('PENDING','APPROVED','REJECTED','COMPLETED') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'PENDING' COMMENT '状态',
  `admin_remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '管理员备注',
  `processed_time` datetime NULL DEFAULT NULL COMMENT '处理时间',
  `created_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_item_id`(`item_id` ASC) USING BTREE,
  INDEX `idx_claim_user_id`(`claim_user_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  CONSTRAINT `fk_claim_record_item` FOREIGN KEY (`item_id`) REFERENCES `lost_items` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_claim_record_user` FOREIGN KEY (`claim_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '认领记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for item_categories
-- ----------------------------
DROP TABLE IF EXISTS `item_categories`;
CREATE TABLE `item_categories`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `category_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分类名称',
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分类描述',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序',
  `created_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_category_name`(`category_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '物品分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for lost_items
-- ----------------------------
DROP TABLE IF EXISTS `lost_items`;
CREATE TABLE `lost_items`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '失物ID',
  `item_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '物品名称',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '物品详细描述',
  `lost_location` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '丢失地点',
  `lost_time` datetime NULL DEFAULT NULL COMMENT '丢失时间',
  `category_id` bigint NULL DEFAULT NULL COMMENT '分类ID',
  `item_images` json NULL COMMENT '物品图片JSON数组',
  `status` enum('LOST','FOUND','RETURNED') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'LOST' COMMENT '状态',
  `contact_info` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系方式',
  `creator_id` bigint NOT NULL COMMENT '发布者ID',
  `created_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_creator_id`(`creator_id` ASC) USING BTREE,
  INDEX `idx_category_id`(`category_id` ASC) USING BTREE,
  CONSTRAINT `fk_lost_items_category` FOREIGN KEY (`category_id`) REFERENCES `item_categories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_lost_items_creator` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 113 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '失物信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for messages
-- ----------------------------
DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '消息ID',
  `sender_id` bigint NOT NULL COMMENT '发送者ID',
  `receiver_id` bigint NOT NULL COMMENT '接收者ID',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '消息标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '消息内容',
  `msg_type` enum('SYSTEM','USER') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'SYSTEM' COMMENT '消息类型',
  `is_read` tinyint NULL DEFAULT 0 COMMENT '是否已读',
  `created_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_sender_id`(`sender_id` ASC) USING BTREE,
  INDEX `idx_receiver_id`(`receiver_id` ASC) USING BTREE,
  INDEX `idx_is_read`(`is_read` ASC) USING BTREE,
  CONSTRAINT `fk_message_receiver` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_message_sender` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '站内信记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for thank_notes
-- ----------------------------
DROP TABLE IF EXISTS `thank_notes`;
CREATE TABLE `thank_notes`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '感谢信ID',
  `record_id` bigint NOT NULL COMMENT '认领记录ID',
  `thank_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '感谢内容',
  `rating` int NULL DEFAULT 5 COMMENT '评分1-5',
  `created_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_record_id`(`record_id` ASC) USING BTREE,
  CONSTRAINT `fk_thank_note_record` FOREIGN KEY (`record_id`) REFERENCES `claim_records` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '感谢信/评价表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID，主键自增',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名，唯一',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '手机号',
  `role` enum('USER','ADMIN') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'USER' COMMENT '用户角色',
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像URL',
  `created_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` enum('ACTIVE','INACTIVE') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'ACTIVE' COMMENT '账号状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
