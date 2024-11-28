-- MySQL Script generated by MySQL Workbench
-- Fri Nov 29 08:34:30 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema restaurant
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema restaurant
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `restaurant` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
-- -----------------------------------------------------
-- Schema Restaurant_Reservation
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Restaurant_Reservation
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Restaurant_Reservation` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `restaurant` ;

-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`user_auth`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`user_auth` (
  `id` INT UNSIGNED NOT NULL,
  `password_hash` VARCHAR(45) NOT NULL,
  `login_id` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`owner`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`owner` (
  `id` INT UNSIGNED NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0,
  `deleted_at` DATETIME NULL,
  CONSTRAINT `fk_owner_user_auth1`
    FOREIGN KEY (`id`)
    REFERENCES `Restaurant_Reservation`.`user_auth` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`restaurant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`restaurant` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` TINYINT(1) NOT NULL DEFAULT '0',
  `deleted_at` DATETIME NULL DEFAULT NULL,
  `owner_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_restaurant_owner1_idx` (`owner_id` ASC) VISIBLE,
  CONSTRAINT `fk_restaurant_owner1`
    FOREIGN KEY (`owner_id`)
    REFERENCES `Restaurant_Reservation`.`owner` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`restaurant_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`restaurant_info` (
  `restaurant_id` INT UNSIGNED NOT NULL,
  `phone_number` VARCHAR(11) NOT NULL,
  `website_url` VARCHAR(255) NULL DEFAULT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` TINYINT(1) NOT NULL DEFAULT '0',
  `deleted_at` DATETIME NULL DEFAULT NULL,
  UNIQUE INDEX `phone_number` (`phone_number` ASC),
  CONSTRAINT `restaurant_info_ibfk_1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`restaurant_location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`restaurant_location` (
  `restaurant_id` INT UNSIGNED NOT NULL,
  `latitude` DECIMAL(10,8) NOT NULL,
  `longitude` DECIMAL(11,8) NOT NULL,
  CONSTRAINT `restaurant_location_ibfk_1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`customer` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `phone_number` VARCHAR(11) NOT NULL,
  CONSTRAINT `fk_customer_user_auth1`
    FOREIGN KEY (`id`)
    REFERENCES `Restaurant_Reservation`.`user_auth` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`order_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`order_status` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`reservation_time`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`reservation_time` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `time` TIME NOT NULL,
  `restaurant_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_reservation_time_restaurant1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`table_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`table_type` (
  `id` INT NOT NULL,
  `type_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`restaurant_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`restaurant_table` (
  `id` INT UNSIGNED NOT NULL,
  `restaurant_id` INT UNSIGNED NOT NULL,
  `type` INT UNSIGNED NOT NULL,
  `seat_capcity` TINYINT(10) UNSIGNED NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_restaurant_table_restaurant1_idx` (`restaurant_id` ASC) VISIBLE,
  INDEX `fk_restaurant_table_table_type1_idx` (`type` ASC) VISIBLE,
  CONSTRAINT `fk_restaurant_table_restaurant1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_restaurant_table_table_type1`
    FOREIGN KEY (`type`)
    REFERENCES `Restaurant_Reservation`.`table_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`reservation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`reservation` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reservation_time_id` INT UNSIGNED NOT NULL,
  `booking_date` DATE NOT NULL,
  `guests_count` TINYINT(6) NOT NULL,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `restaurant_table_id` INT NOT NULL,
  `is_hidden` TINYINT(1) NULL DEFAULT 1,
  `restaurant_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `restaurant_id`),
  INDEX `reservation_ibfk_2` (`reservation_time_id` ASC) VISIBLE,
  INDEX `fk_reservation_restaurant_table1_idx` (`restaurant_table_id` ASC) VISIBLE,
  INDEX `fk_reservation_restaurant1_idx` (`restaurant_id` ASC) VISIBLE,
  CONSTRAINT `reservation_ibfk_2`
    FOREIGN KEY (`reservation_time_id`)
    REFERENCES `Restaurant_Reservation`.`reservation_time` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservation_restaurant_table1`
    FOREIGN KEY (`restaurant_table_id`)
    REFERENCES `Restaurant_Reservation`.`restaurant_table` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservation_restaurant1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`pickup_time`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`pickup_time` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `time` TIME NOT NULL,
  `restaurant_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_pickup_time_restaurant1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`pickup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`pickup` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `picked_at` DATETIME NULL,
  `pickup_time_id` INT UNSIGNED NOT NULL,
  `pickup_date` DATE NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `restaurant_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `pickup_ibfk_2` (`pickup_time_id` ASC) VISIBLE,
  INDEX `fk_pickup_restaurant1_idx` (`restaurant_id` ASC) VISIBLE,
  CONSTRAINT `pickup_ibfk_2`
    FOREIGN KEY (`pickup_time_id`)
    REFERENCES `Restaurant_Reservation`.`pickup_time` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pickup_restaurant1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`booking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`booking` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` ENUM('pickup', 'reservation') NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `booking_ibfk_1`
    FOREIGN KEY (`id`)
    REFERENCES `Restaurant_Reservation`.`reservation` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `booking_ibfk_8`
    FOREIGN KEY (`id`)
    REFERENCES `Restaurant_Reservation`.`pickup` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `status_id` INT NOT NULL,
  `created_at` INT UNSIGNED NOT NULL,
  `total_price` INT UNSIGNED NOT NULL,
  `restaurant_id` INT UNSIGNED NOT NULL,
  `customer_id` INT UNSIGNED NOT NULL,
  `reservation_fee` INT UNSIGNED NOT NULL,
  `booking_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `order_ibfk_1` (`status_id` ASC) VISIBLE,
  INDEX `fk_order_customer1` (`customer_id` ASC) VISIBLE,
  INDEX `fk_order_booking1_idx` (`booking_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `Restaurant_Reservation`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `order_ibfk_1`
    FOREIGN KEY (`status_id`)
    REFERENCES `Restaurant_Reservation`.`order_status` (`id`),
  CONSTRAINT `fk_order_restaurant1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_booking1`
    FOREIGN KEY (`booking_id`)
    REFERENCES `Restaurant_Reservation`.`booking` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`order_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`order_item` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `quantity` INT UNSIGNED NOT NULL,
  `price` INT UNSIGNED NOT NULL,
  `order_id` INT UNSIGNED NOT NULL,
  `menu_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `order_item_ibfk_1` (`order_id` ASC) VISIBLE,
  CONSTRAINT `order_item_ibfk_1`
    FOREIGN KEY (`order_id`)
    REFERENCES `Restaurant_Reservation`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`restaurant_menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`restaurant_menu` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `restaurant_id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `price` INT UNSIGNED NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_hidden` TINYINT(1) NULL DEFAULT 0,
  PRIMARY KEY (`restaurant_id`),
  INDEX `restaurant_id` (`restaurant_id` ASC) VISIBLE,
  CONSTRAINT `restaurant_menu_ibfk_1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_restaurant_menu_order_item1`
    FOREIGN KEY (`id`)
    REFERENCES `Restaurant_Reservation`.`order_item` (`menu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`restaurant_image`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`restaurant_image` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `restaurant_id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `url` VARCHAR(255) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `restaurant_id` (`restaurant_id` ASC) VISIBLE,
  CONSTRAINT `restaurant_photo_ibfk_1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`restaurant_review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`restaurant_review` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `restaurant_id` INT UNSIGNED NOT NULL,
  `customer_id` INT UNSIGNED NOT NULL,
  `rating` DECIMAL(3,1) NOT NULL DEFAULT 5,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0,
  `deleted_at` DATETIME NULL DEFAULT NULL,
  `text` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `restaurant_id` (`restaurant_id` ASC) VISIBLE,
  CONSTRAINT `restaurant_review_ibfk_1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_restaurant_review_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `Restaurant_Reservation`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`review_image`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`review_image` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `review_id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(5) NOT NULL,
  `url` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `review_id` (`review_id` ASC) VISIBLE,
  CONSTRAINT `review_photo_ibfk_1`
    FOREIGN KEY (`review_id`)
    REFERENCES `restaurant`.`restaurant_review` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`menu_image`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`menu_image` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(5) NOT NULL,
  `url` VARCHAR(255) NOT NULL,
  `review_id` INT UNSIGNED NOT NULL,
  CONSTRAINT `fk_menu-photo_restaurant_menu1`
    FOREIGN KEY (`id`)
    REFERENCES `restaurant`.`restaurant_menu` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `Restaurant_Reservation` ;

-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`payment` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `amount` INT UNSIGNED NOT NULL,
  `order_id` INT UNSIGNED NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0,
  `deleted_at` DATETIME NULL,
  `method` VARCHAR(30) NOT NULL COMMENT 'CARD, COUPON\n',
  PRIMARY KEY (`id`),
  INDEX `payment_ibfk_1` (`order_id` ASC) VISIBLE,
  CONSTRAINT `payment_ibfk_1`
    FOREIGN KEY (`order_id`)
    REFERENCES `Restaurant_Reservation`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`payment_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`payment_history` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `method` VARCHAR(30) NOT NULL,
  `amount` INT UNSIGNED NOT NULL,
  `status` INT UNSIGNED NOT NULL,
  `transaction_date` DATE NOT NULL,
  `payment_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `payment_history_ibfk_1` (`payment_id` ASC) VISIBLE,
  CONSTRAINT `payment_history_ibfk_1`
    FOREIGN KEY (`payment_id`)
    REFERENCES `Restaurant_Reservation`.`payment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`pickup_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`pickup_status` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`pickup_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`pickup_history` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `status_id` INT UNSIGNED NOT NULL,
  `picked_at` DATETIME NULL,
  `pickup_id` INT UNSIGNED NOT NULL,
  `pickup_date` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `pickup_history_ibfk_1` (`status_id` ASC) VISIBLE,
  INDEX `pickup_history_ibfk_2` (`pickup_id` ASC) VISIBLE,
  CONSTRAINT `pickup_history_ibfk_1`
    FOREIGN KEY (`status_id`)
    REFERENCES `Restaurant_Reservation`.`pickup_status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `pickup_history_ibfk_2`
    FOREIGN KEY (`pickup_id`)
    REFERENCES `Restaurant_Reservation`.`pickup` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`reservation_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`reservation_status` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`reservation_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`reservation_history` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `status_id` INT UNSIGNED NOT NULL,
  `visited_at` DATETIME NULL DEFAULT NULL,
  `reservation_id` INT UNSIGNED NOT NULL,
  `booking_time` DATE NOT NULL,
  `guests_count` TINYINT(6) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `status_id`),
  INDEX `reservation_history_ibfk_1` (`status_id` ASC) VISIBLE,
  INDEX `reservation_history_ibfk_2` (`reservation_id` ASC) VISIBLE,
  CONSTRAINT `reservation_history_ibfk_1`
    FOREIGN KEY (`status_id`)
    REFERENCES `Restaurant_Reservation`.`reservation_status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `reservation_history_ibfk_2`
    FOREIGN KEY (`reservation_id`)
    REFERENCES `Restaurant_Reservation`.`reservation` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`waiting_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`waiting_info` (
  `waiting_id` INT NOT NULL,
  `party_size` INT NOT NULL,
  `restaurant_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`waiting_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`wating`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`wating` (
  `id` INT UNSIGNED NOT NULL,
  `created_at` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `guest_count` INT NOT NULL,
  `restaurant_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `customer_id`),
  INDEX `fk_wating_customer1` (`customer_id` ASC) VISIBLE,
  INDEX `fk_wating_restaurant1_idx` (`restaurant_id` ASC) VISIBLE,
  CONSTRAINT `fk_wating_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `Restaurant_Reservation`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wating_waiting_info1`
    FOREIGN KEY (`id`)
    REFERENCES `Restaurant_Reservation`.`waiting_info` (`waiting_id`),
  CONSTRAINT `fk_wating_restaurant1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`waiting_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`waiting_status` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`waiting_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`waiting_history` (
  `id` INT UNSIGNED NOT NULL,
  `waiting_id` INT UNSIGNED NOT NULL,
  `created_at` INT NOT NULL,
  `waiting_status_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_waiting_history_waiting_status1_idx` (`waiting_status_id` ASC) VISIBLE,
  CONSTRAINT `fk_waiting_history_waiting_info1`
    FOREIGN KEY (`waiting_id`)
    REFERENCES `Restaurant_Reservation`.`waiting_info` (`waiting_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_waiting_history_wating1`
    FOREIGN KEY (`waiting_id`)
    REFERENCES `Restaurant_Reservation`.`wating` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_waiting_history_waiting_status1`
    FOREIGN KEY (`waiting_status_id`)
    REFERENCES `Restaurant_Reservation`.`waiting_status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`reataurant_bookmark`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`reataurant_bookmark` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `restaurant_id` INT UNSIGNED NOT NULL,
  `customer_id` INT UNSIGNED NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` TINYINT(1) NOT NULL,
  `deleted_at` DATETIME NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_reataurant_bookmark_customer2`
    FOREIGN KEY (`customer_id`)
    REFERENCES `Restaurant_Reservation`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reataurant_bookmark_restaurant1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`restaurant_food_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`restaurant_food_category` (
  `restaurant_id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`name`),
  CONSTRAINT `fk_restaurant_food_category_restaurant1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`custom_work_schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`custom_work_schedule` (
  `id` INT UNSIGNED NULL,
  `date` DATE NOT NULL,
  `start_time` TIME NOT NULL,
  `end_time` TIME NOT NULL,
  `restaurant_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_work_schedule_restaurant1_idx` (`restaurant_id` ASC) VISIBLE,
  CONSTRAINT `fk_work_schedule_restaurant1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`work_schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`work_schedule` (
  `id` INT UNSIGNED NULL,
  `day_of_week` VARCHAR(1) NOT NULL,
  `start_time` TIME NOT NULL,
  `end_time` TIME NOT NULL,
  `restaurant_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `restaurant_id`),
  INDEX `fk_work_schedule_restaurant1_idx` (`restaurant_id` ASC) VISIBLE,
  CONSTRAINT `fk_work_schedule_restaurant10`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`custom_holiday_schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`custom_holiday_schedule` (
  `id` INT UNSIGNED NULL,
  `date` DATE NOT NULL,
  `restaurant_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_work_schedule_restaurant1_idx` (`restaurant_id` ASC) VISIBLE,
  CONSTRAINT `fk_work_schedule_restaurant11`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
