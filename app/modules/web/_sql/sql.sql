SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

CREATE TABLE IF NOT EXISTS `{prefix}web_comments` (
  `id_web_comments` int(11) NOT NULL AUTO_INCREMENT,
  `id_web_posts` int(11) NOT NULL,
  `ip` varchar(255) NOT NULL,
  `comment_name` varchar(255) NOT NULL,
  `comment_email` varchar(255) NOT NULL,
  `comment_website` varchar(255) DEFAULT NULL,
  `comment_date` datetime NOT NULL,
  `comment` longtext NOT NULL,
  `parent` int(11) DEFAULT NULL,
  `approve` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_web_comments`),
  KEY `web_comments_web_posts` (`id_web_posts`),
  KEY `web_comments_web_comments` (`parent`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `{prefix}web_menus` (
  `id_web_menus` int(11) NOT NULL AUTO_INCREMENT,
  `id_web_menus_groups` int(11) NOT NULL,
  `menu_name` varchar(255) NOT NULL,
  `url` text NOT NULL,
  `menu_type` enum('publish','private','draft') NOT NULL DEFAULT 'publish',
  `parent` int(11) DEFAULT NULL,
  `options` text NOT NULL,
  `order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_web_menus`),
  KEY `web_menus_web_menus` (`parent`),
  KEY `web_menus_web_menus_groups` (`id_web_menus_groups`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `{prefix}web_menus_groups` (
  `id_web_menus_groups` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id_web_menus_groups`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `{prefix}web_posts` (
  `id_web_posts` int(11) NOT NULL AUTO_INCREMENT,
  `id_users` int(11) NOT NULL,
  `post_date` datetime NOT NULL,
  `post_title` varchar(255) NOT NULL,
  `post_name` varchar(255) NOT NULL,
  `post_content` longtext NOT NULL,
  `post_status` enum('publish','private','draft','trash') NOT NULL DEFAULT 'draft',
  `allow_comment` tinyint(1) NOT NULL,
  `post_password` varchar(255) DEFAULT NULL,
  `post_modified` datetime NOT NULL,
  `post_type` enum('post','page') NOT NULL DEFAULT 'post',
  `order` int(11) NOT NULL,
  `e_sku` varchar(255) DEFAULT NULL,
  `e_stock_status` tinyint(1) DEFAULT NULL,
  `id_web_spec` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_web_posts`),
  UNIQUE KEY `UNIQUE` (`post_name`),
  UNIQUE KEY `e-sku` (`e_sku`),
  KEY `web_posts_web_spec` (`id_web_spec`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `{prefix}web_price` (
  `id_web_price` int(11) NOT NULL AUTO_INCREMENT,
  `id_web_posts` int(11) NOT NULL,
  `datetime` datetime NOT NULL,
  `price_type` enum('price','sale') NOT NULL,
  `price` int(11) NOT NULL DEFAULT '0',
  `sch_start` date DEFAULT NULL,
  `sch_finish` date DEFAULT NULL,
  PRIMARY KEY (`id_web_price`),
  KEY `web_price_web_posts` (`id_web_posts`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `{prefix}web_spec` (
  `id_web_spec` int(11) NOT NULL AUTO_INCREMENT,
  `spec_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id_web_spec`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `{prefix}web_spec_items` (
  `id_web_spec_items` int(11) NOT NULL AUTO_INCREMENT,
  `id_web_spec` int(11) NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `item_type` enum('text','int','enum') NOT NULL,
  `item_default` text,
  `order` int(11) DEFAULT '0',
  PRIMARY KEY (`id_web_spec_items`),
  KEY `web_spec_items_web_spec` (`id_web_spec`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `{prefix}web_spec_value` (
  `id_web_spec_value` int(11) NOT NULL AUTO_INCREMENT,
  `id_web_posts` int(11) NOT NULL,
  `id_web_spec_items` int(11) NOT NULL,
  `value` text,
  PRIMARY KEY (`id_web_spec_value`),
  UNIQUE KEY `UNIQUE` (`id_web_posts`,`id_web_spec_items`),
  KEY `web_spec_value_web_spec_items` (`id_web_spec_items`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `{prefix}web_stock` (
  `id_web_stock` int(11) NOT NULL AUTO_INCREMENT,
  `id_web_posts` int(11) NOT NULL,
  `datetime` datetime NOT NULL,
  `stock` int(11) DEFAULT '0',
  `info` text,
  PRIMARY KEY (`id_web_stock`),
  KEY `web_stock_web_posts` (`id_web_posts`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `{prefix}web_terms` (
  `id_web_terms` int(11) NOT NULL AUTO_INCREMENT,
  `term_name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `parent` int(11) DEFAULT NULL,
  `term_type` enum('category','tag') NOT NULL DEFAULT 'category',
  PRIMARY KEY (`id_web_terms`),
  UNIQUE KEY `UNIQUE` (`slug`),
  KEY `web_terms_web_terms` (`parent`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `{prefix}web_terms_relations` (
  `id_web_terms_relations` int(11) NOT NULL AUTO_INCREMENT,
  `id_web_terms` int(11) NOT NULL,
  `id_web_posts` int(11) NOT NULL,
  PRIMARY KEY (`id_web_terms_relations`),
  UNIQUE KEY `UNIQUE` (`id_web_terms`,`id_web_posts`),
  KEY `web_terms_relationsweb_posts` (`id_web_posts`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `{prefix}web_widgets` (
  `id_web_widgets` int(11) NOT NULL AUTO_INCREMENT,
  `widget_title` varchar(255) NOT NULL,
  `widget_content` text NOT NULL,
  `widget_position` varchar(255) NOT NULL,
  `widget_status` enum('publish','private','draft') NOT NULL DEFAULT 'publish',
  `options` longtext NOT NULL,
  `order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_web_widgets`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;


ALTER TABLE `{prefix}web_comments`
  ADD CONSTRAINT `web_comments_web_comments` FOREIGN KEY (`parent`) REFERENCES `{prefix}web_comments` (`id_web_comments`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `web_comments_web_posts` FOREIGN KEY (`id_web_posts`) REFERENCES `{prefix}web_posts` (`id_web_posts`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `{prefix}web_menus`
  ADD CONSTRAINT `web_menus_web_menus` FOREIGN KEY (`parent`) REFERENCES `{prefix}web_menus` (`id_web_menus`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `web_menus_web_menus_groups` FOREIGN KEY (`id_web_menus_groups`) REFERENCES `{prefix}web_menus_groups` (`id_web_menus_groups`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `{prefix}web_posts`
  ADD CONSTRAINT `web_posts_web_spec` FOREIGN KEY (`id_web_spec`) REFERENCES `{prefix}web_spec` (`id_web_spec`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `{prefix}web_price`
  ADD CONSTRAINT `web_price_web_posts` FOREIGN KEY (`id_web_posts`) REFERENCES `{prefix}web_posts` (`id_web_posts`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `{prefix}web_spec_items`
  ADD CONSTRAINT `web_spec_items_web_spec` FOREIGN KEY (`id_web_spec`) REFERENCES `{prefix}web_spec` (`id_web_spec`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `{prefix}web_spec_value`
  ADD CONSTRAINT `web_spec_value_web_posts` FOREIGN KEY (`id_web_posts`) REFERENCES `{prefix}web_posts` (`id_web_posts`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `web_spec_value_web_spec_items` FOREIGN KEY (`id_web_spec_items`) REFERENCES `{prefix}web_spec_items` (`id_web_spec_items`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `{prefix}web_stock`
  ADD CONSTRAINT `web_stock_web_posts` FOREIGN KEY (`id_web_posts`) REFERENCES `{prefix}web_posts` (`id_web_posts`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `{prefix}web_terms`
  ADD CONSTRAINT `web_terms_web_terms` FOREIGN KEY (`parent`) REFERENCES `{prefix}web_terms` (`id_web_terms`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `{prefix}web_terms_relations`
  ADD CONSTRAINT `web_terms_relationsweb_posts` FOREIGN KEY (`id_web_posts`) REFERENCES `{prefix}web_posts` (`id_web_posts`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `web_terms_relations_web_terms` FOREIGN KEY (`id_web_terms`) REFERENCES `{prefix}web_terms` (`id_web_terms`) ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE `{prefix}web_users`(  
  `id_web_users` INT NOT NULL,
  `address` TEXT NOT NULL,
  `province` VARCHAR(255) NOT NULL,
  `city` VARCHAR(255) NOT NULL,
  `postal_code` VARCHAR(10) NOT NULL,
  `phone` VARCHAR(25) NOT NULL,
  UNIQUE INDEX (`id_web_users`),
  CONSTRAINT `web_users_users` FOREIGN KEY (`id_web_users`) REFERENCES `{prefix}users`(`id_users`) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `{prefix}web_buy`(  
  `id_web_buy` INT NOT NULL AUTO_INCREMENT,
  `id_users` INT,
  `datetime` DATETIME NOT NULL,
  `code` INT(3) NOT NULL,
  `confirm` BOOLEAN NOT NULL DEFAULT FALSE,
  `process` BOOLEAN NOT NULL DEFAULT FALSE,
  `arrived` BOOLEAN NOT NULL DEFAULT FALSE,
  `name` VARCHAR(255) NOT NULL,
  `address` TEXT NOT NULL,
  `province` VARCHAR(255) NOT NULL,
  `city` VARCHAR(255) NOT NULL,
  `postal_code` VARCHAR(10) NOT NULL,
  `phone` VARCHAR(25) NOT NULL,
  `insurance` BOOLEAN NOT NULL DEFAULT TRUE,
  `note` TEXT NOT NULL,
  PRIMARY KEY (`id_web_buy`),
  UNIQUE INDEX (`datetime`, `code`),
  CONSTRAINT `web_buy_users` FOREIGN KEY (`id_users`) REFERENCES `{prefix}users`(`id_users`) ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE `{prefix}web_buy_list`(
  `id_web_buy_list` INT NOT NULL AUTO_INCREMENT,
  `id_web_buy` INT NOT NULL,
  `id_web_posts` INT NOT NULL,
  `price` INT NOT NULL DEFAULT 0,
  `qty` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_web_buy_list`)
);
ALTER TABLE `{prefix}web_buy_list`  
  ADD CONSTRAINT `web_buy_list_web_buy` FOREIGN KEY (`id_web_buy`) REFERENCES `{prefix}web_buy`(`id_web_buy`) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD CONSTRAINT `web_buy_list_web_posts` FOREIGN KEY (`id_web_posts`) REFERENCES `{prefix}web_posts`(`id_web_posts`) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE `{prefix}web_buy_list`   
  ADD UNIQUE INDEX (`id_web_buy`, `id_web_posts`);

ALTER TABLE `{prefix}web_buy`   
  ADD COLUMN `price_plus` INT DEFAULT 0  NOT NULL AFTER `code`;
ALTER TABLE `{prefix}web_buy`   
  ADD COLUMN `send_email` BOOLEAN DEFAULT FALSE  NOT NULL AFTER `price_plus`,
  ADD COLUMN `send_sms` BOOLEAN DEFAULT FALSE  NOT NULL AFTER `send_email`;
ALTER TABLE `{prefix}web_buy`   
  ADD COLUMN `confirm_req` BOOLEAN DEFAULT FALSE  NOT NULL AFTER `send_sms`;
ALTER TABLE `{prefix}web_buy`   
  ADD COLUMN `confirm_req_price` INT DEFAULT 0  NOT NULL AFTER `confirm_req`;
ALTER TABLE `{prefix}web_buy`   
  CHANGE `price_plus` `price_plus` INT(11) DEFAULT 0  NULL,
  CHANGE `send_email` `send_email` TINYINT(1) DEFAULT 0  NULL,
  CHANGE `send_sms` `send_sms` TINYINT(1) DEFAULT 0  NULL,
  CHANGE `confirm_req` `confirm_req` TINYINT(1) DEFAULT 0  NULL,
  ADD COLUMN `confirm_req_date` DATETIME NULL AFTER `confirm_req`,
  CHANGE `confirm_req_price` `confirm_req_price` INT(11) DEFAULT 0  NULL,
  CHANGE `confirm` `confirm` TINYINT(1) DEFAULT 0  NULL,
  ADD COLUMN `confirm_date` DATETIME NULL AFTER `confirm`,
  CHANGE `process` `process` TINYINT(1) DEFAULT 0  NULL,
  ADD COLUMN `process_date` DATETIME NULL AFTER `process`,
  CHANGE `arrived` `arrived` TINYINT(1) DEFAULT 0  NULL,
  ADD COLUMN `arrived_date` DATETIME NULL AFTER `arrived`;
ALTER TABLE `{prefix}web_buy`   
  ADD COLUMN `confirm_req_send` DATE NULL AFTER `confirm_req_date`;


ALTER TABLE `{prefix}web_posts`   
  ADD COLUMN `e_weight` FLOAT(3,3) NULL AFTER `e_stock_status`;

ALTER TABLE `{prefix}web_posts`   
  CHANGE `post_type` `post_type` ENUM('post','page','product') CHARSET latin1 COLLATE latin1_swedish_ci DEFAULT 'post'   NOT NULL;

ALTER TABLE `{prefix}web_users`   
  CHANGE `province` `id_province` INT NOT NULL,
  CHANGE `city` `id_city` INT NOT NULL;
ALTER TABLE `{prefix}web_posts`   
  CHANGE `e_weight` `e_weight` FLOAT(3,3) NULL   COMMENT '(Kg)';
ALTER TABLE `{prefix}web_buy`   
  ADD COLUMN `courier` VARCHAR(10) NULL AFTER `code`,
  ADD COLUMN `courier_service` VARCHAR(10) NULL AFTER `courier`,
  ADD COLUMN `courier_cost` INT NULL AFTER `courier_service`;

CREATE TABLE `{prefix}web_visitor`(  
  `id_web_posts_visitor` INT NOT NULL AUTO_INCREMENT,
  `id_web_posts` INT,
  `ip` VARCHAR(25),
  `datetime` DATETIME,
  `useragent` VARCHAR(255),
  PRIMARY KEY (`id_web_posts_visitor`),
  CONSTRAINT `web_visitor_web_posts` FOREIGN KEY (`id_web_posts`) REFERENCES `{prefix}web_posts`(`id_web_posts`) ON UPDATE CASCADE ON DELETE CASCADE
);
ALTER TABLE `{prefix}web_visitor`   
  ADD COLUMN `id_web_terms` INT NULL AFTER `id_web_posts`;


SET FOREIGN_KEY_CHECKS=1;
