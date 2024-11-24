
-- Schema restaurant
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema restaurant
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `restaurant` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
-- -----------------------------------------------------
-- Schema Restaurant_Reservtion
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Restaurant_Reservation
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Restaurant_Reservation` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `restaurant` ;

-- -----------------------------------------------------
-- Table `restaurant`.`restaurant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`restaurant` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` TINYINT(1) NOT NULL DEFAULT '0',
  `deleted_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`restaurant_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`restaurant_info` (
  `restaurant_id` INT NOT NULL,
  `phone_number` VARCHAR(15) NOT NULL,
  `full_address` VARCHAR(255) NOT NULL,
  `website_url` TEXT NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` TINYINT(1) NOT NULL DEFAULT '0',
  `deleted_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`restaurant_id`),
  UNIQUE INDEX `phone_number` (`phone_number` ASC) VISIBLE,
  UNIQUE INDEX `full_address` (`full_address` ASC) VISIBLE,
  CONSTRAINT `restaurant_info_ibfk_1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant`.`restaurant` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`restaurant_location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`restaurant_location` (
  `restaurant_id` INT NOT NULL,
  `latitude` DECIMAL(10,8) NOT NULL,
  `longitude` DECIMAL(11,8) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` TINYINT(1) NOT NULL DEFAULT '0',
  `deleted_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`restaurant_id`),
  CONSTRAINT `restaurant_location_ibfk_1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant`.`restaurant` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`user_auth`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`user_auth` (
  `id` INT NOT NULL,
  `password_hash` VARCHAR(45) NOT NULL,
  `ident` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `is_deleted` TINYINT(1) NOT NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`customer` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(10) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `is_deleted` TINYINT(1) NOT NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_customer_user_auth1`
    FOREIGN KEY (`id`)
    REFERENCES `Restaurant_Reservation`.`user_auth` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`order_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`order_status` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `status_id` INT NOT NULL,
  `created_at` INT NOT NULL,
  `total_price` INT NOT NULL,
  `restaurant_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `booking_id` INT NOT NULL,
  `reservation_fee` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `order_ibfk_1` (`status_id` ASC) VISIBLE,
  INDEX `fk_order_customer1` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `Restaurant_Reservation`.`customer` (`id`),
  CONSTRAINT `order_ibfk_1`
    FOREIGN KEY (`status_id`)
    REFERENCES `Restaurant_Reservation`.`order_status` (`id`),
  CONSTRAINT `fk_order_restaurant1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`order_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`order_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quntity` INT NOT NULL,
  `price` INT NOT NULL,
  `order_id` INT NOT NULL,
  `menu_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `order_item_ibfk_1` (`order_id` ASC) VISIBLE,
  CONSTRAINT `order_item_ibfk_1`
    FOREIGN KEY (`order_id`)
    REFERENCES `Restaurant_Reservation`.`order` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`restaurant_menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`restaurant_menu` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `restaurant_id` INT NOT NULL,
  `menu_name` VARCHAR(255) NOT NULL,
  `menu_description` TEXT NULL DEFAULT NULL,
  `menu_price` INT NOT NULL,
  `menu_photo_path` TEXT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `restaurant_id` (`restaurant_id` ASC) VISIBLE,
  CONSTRAINT `restaurant_menu_ibfk_1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant`.`restaurant` (`id`),
  CONSTRAINT `fk_restaurant_menu_order_item1`
    FOREIGN KEY (`id`)
    REFERENCES `Restaurant_Reservation`.`order_item` (`menu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`restaurant_photo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`restaurant_photo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `restaurant_id` INT NOT NULL,
  `photo_name` TEXT NOT NULL,
  `photo_path` TEXT NOT NULL,
  `photo_type` VARCHAR(10) NULL DEFAULT NULL,
  `photo_size` INT NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` TINYINT(1) NOT NULL DEFAULT '0',
  `deleted_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `restaurant_id` (`restaurant_id` ASC) VISIBLE,
  CONSTRAINT `restaurant_photo_ibfk_1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant`.`restaurant` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`restaurant_review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`restaurant_review` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `restaurant_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `review_rating` INT NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` TINYINT(1) NOT NULL DEFAULT '0',
  `deleted_at` DATETIME NULL DEFAULT NULL,
  `review_caption` TEXT(100) NULL,
  PRIMARY KEY (`id`),
  INDEX `restaurant_id` (`restaurant_id` ASC) VISIBLE,
  CONSTRAINT `restaurant_review_ibfk_1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant`.`restaurant` (`id`),
  CONSTRAINT `fk_restaurant_review_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `Restaurant_Reservation`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`review_photo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`review_photo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `review_id` INT NOT NULL,
  `photo_name` TEXT NOT NULL,
  `photo_path` TEXT NOT NULL,
  `photo_type` VARCHAR(10) NULL DEFAULT NULL,
  `photo_size` INT NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` TINYINT(1) NOT NULL DEFAULT '0',
  `deleted_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `review_id` (`review_id` ASC) VISIBLE,
  CONSTRAINT `review_photo_ibfk_1`
    FOREIGN KEY (`review_id`)
    REFERENCES `restaurant`.`restaurant_review` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`menu-photo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`menu-photo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `photo_name` TEXT NOT NULL,
  `photo_path` TEXT NOT NULL,
  `photo_type` VARCHAR(10) NULL DEFAULT NULL,
  `photo_size` INT NULL,
  `review_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` TINYINT(1) NOT NULL DEFAULT '0',
  `deleted_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
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
-- Table `Restaurant_Reservation`.`reservation_time`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`reservation_time` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `time` TIME NOT NULL,
  `max_guests_count` INT NOT NULL,
  `restaurant_id` INT NOT NULL,
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
-- Table `Restaurant_Reservation`.`reservation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`reservation` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NOT NULL,
  `reservation_time_id` INT NOT NULL,
  `booking_date` DATE NOT NULL,
  `guests_count` TINYINT NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `is_deleted` TINYINT(1) NOT NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `reservation_ibfk_2` (`reservation_time_id` ASC) VISIBLE,
  CONSTRAINT `reservation_ibfk_2`
    FOREIGN KEY (`reservation_time_id`)
    REFERENCES `Restaurant_Reservation`.`reservation_time` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`pickup_time`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`pickup_time` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `time` TIME NOT NULL,
  `restaurant_id` INT NOT NULL,
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
  `id` INT NOT NULL AUTO_INCREMENT,
  `picked_at` INT NOT NULL,
  `pickup_time_id` INT NOT NULL,
  `pickup_date` DATE NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `is_deleted` TINYINT(1) NOT NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `pickup_ibfk_2` (`pickup_time_id` ASC) VISIBLE,
  CONSTRAINT `pickup_ibfk_2`
    FOREIGN KEY (`pickup_time_id`)
    REFERENCES `Restaurant_Reservation`.`pickup_time` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`booking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`booking` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` ENUM('pickup', 'reservation') NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `booking_ibfk_1`
    FOREIGN KEY (`id`)
    REFERENCES `Restaurant_Reservation`.`reservation` (`id`),
  CONSTRAINT `booking_ibfk_15`
    FOREIGN KEY (`id`)
    REFERENCES `Restaurant_Reservation`.`order` (`id`),
  CONSTRAINT `booking_ibfk_8`
    FOREIGN KEY (`id`)
    REFERENCES `Restaurant_Reservation`.`pickup` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`owner`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`owner` (
  `id` INT NOT NULL,
  `restaurant_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `is_deleted` TINYINT(1) NOT NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_owner_restaurant1_idx` (`restaurant_id` ASC) VISIBLE,
  CONSTRAINT `fk_owner_user_auth1`
    FOREIGN KEY (`id`)
    REFERENCES `Restaurant_Reservation`.`user_auth` (`id`),
  CONSTRAINT `fk_owner_restaurant1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`payment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `method` INT NOT NULL,
  `amount` INT NOT NULL,
  `status` INT NOT NULL,
  `transaction_date` INT NOT NULL,
  `order_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `is_deleted` TINYINT(1) NOT NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `payment_ibfk_1` (`order_id` ASC) VISIBLE,
  CONSTRAINT `payment_ibfk_1`
    FOREIGN KEY (`order_id`)
    REFERENCES `Restaurant_Reservation`.`order` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`payment_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`payment_history` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `method` INT NOT NULL,
  `amount` INT NOT NULL,
  `status` INT NOT NULL,
  `transaction_date` INT NOT NULL,
  `payment_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `payment_history_ibfk_1` (`payment_id` ASC) VISIBLE,
  CONSTRAINT `payment_history_ibfk_1`
    FOREIGN KEY (`payment_id`)
    REFERENCES `Restaurant_Reservation`.`payment` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`pickup_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`pickup_status` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`pickup_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`pickup_history` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `status_id` INT NOT NULL,
  `picked_at` DATETIME NULL DEFAULT NULL,
  `pickup_id` INT NOT NULL,
  `pickup_date` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `pickup_history_ibfk_1` (`status_id` ASC) VISIBLE,
  INDEX `pickup_history_ibfk_2` (`pickup_id` ASC) VISIBLE,
  CONSTRAINT `pickup_history_ibfk_1`
    FOREIGN KEY (`status_id`)
    REFERENCES `Restaurant_Reservation`.`pickup_status` (`id`),
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
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`reservation_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`reservation_history` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `status_id` INT NOT NULL,
  `visited_at` DATETIME NULL DEFAULT NULL,
  `reservation_id` INT NOT NULL,
  `booking_time` DATE NOT NULL,
  `guests_count` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `reservation_history_ibfk_1` (`status_id` ASC) VISIBLE,
  INDEX `reservation_history_ibfk_2` (`reservation_id` ASC) VISIBLE,
  CONSTRAINT `reservation_history_ibfk_1`
FOREIGN KEY (`status_id`)
    REFERENCES `Restaurant_Reservation`.`reservation_status` (`id`),
  CONSTRAINT `reservation_history_ibfk_2`
    FOREIGN KEY (`reservation_id`)
    REFERENCES `Restaurant_Reservation`.`reservation` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`role` (
  `id` INT NOT NULL,
  `role_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_role_user_auth1`
    FOREIGN KEY (`id`)
    REFERENCES `Restaurant_Reservation`.`user_auth` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
  `id` INT NOT NULL,
  `created_at` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `party_size` INT NOT NULL,
  `restaurant_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_wating_customer1` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_wating_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `Restaurant_Reservation`.`customer` (`id`),
  CONSTRAINT `fk_wating_waiting_info1`
    FOREIGN KEY (`id`)
    REFERENCES `Restaurant_Reservation`.`waiting_info` (`waiting_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`waiting_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`waiting_history` (
  `waiting_id` INT NOT NULL,
  `created_at` INT NOT NULL,
  `waiting_status` INT NOT NULL,
  PRIMARY KEY (`waiting_id`, `created_at`),
  CONSTRAINT `fk_waiting_history_waiting_info1`
    FOREIGN KEY (`waiting_id`)
    REFERENCES `Restaurant_Reservation`.`waiting_info` (`waiting_id`),
  CONSTRAINT `fk_waiting_history_wating1`
    FOREIGN KEY (`waiting_id`)
    REFERENCES `Restaurant_Reservation`.`wating` (`id`)
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
  `id` INT NOT NULL,
  `restaurant_id` INT NOT NULL,
  `table_type` INT NOT NULL,
  `seat_capcity` INT NOT NULL,
  `is_avaliable` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `is_deleted` TINYINT(1) NOT NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_restaurant_table_restaurant1_idx` (`restaurant_id` ASC) VISIBLE,
  INDEX `fk_restaurant_table_table_type1_idx` (`table_type` ASC) VISIBLE,
  CONSTRAINT `fk_restaurant_table_restaurant1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_restaurant_table_table_type1`
    FOREIGN KEY (`table_type`)
    REFERENCES `Restaurant_Reservation`.`table_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restaurant_Reservation`.`reataurant_bookmark`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurant_Reservation`.`reataurant_bookmark` (
  `restaurant_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `is_deleted` TINYINT(1) NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`restaurant_id`, `customer_id`),
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
  `restaurant_id` INT NOT NULL,
  `food_category` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `is_deleted` TINYINT(1) NOT NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`restaurant_id`, `food_category`),
  CONSTRAINT `fk_restaurant_food_category_restaurant1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
