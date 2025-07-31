-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema courier_delivery
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema courier_delivery
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `courier_delivery` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `courier_delivery` ;

-- -----------------------------------------------------
-- Table `courier_delivery`.`couriers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `courier_delivery`.`couriers` (
  `courier_id` INT NOT NULL,
  `birth_date` DATE NULL,
  `sex` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`courier_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `courier_delivery`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `courier_delivery`.`users` (
  `user_id` INT NOT NULL,
  `birth_date` DATE NULL DEFAULT NULL,
  `sex` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `courier_delivery`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `courier_delivery`.`orders` (
  `order_id` INT NOT NULL,
  `creation_time` DATE NULL,
  `products_id` VARCHAR(45) NULL,
  `users_user_id` INT NOT NULL,
  `couriers_courier_id` INT NOT NULL,
  PRIMARY KEY (`order_id`, `users_user_id`, `couriers_courier_id`),
  INDEX `fk_orders_users1_idx` (`users_user_id` ASC) VISIBLE,
  INDEX `fk_orders_couriers1_idx` (`couriers_courier_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_users1`
    FOREIGN KEY (`users_user_id`)
    REFERENCES `courier_delivery`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_couriers1`
    FOREIGN KEY (`couriers_courier_id`)
    REFERENCES `courier_delivery`.`couriers` (`courier_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `courier_delivery`.`courier_actions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `courier_delivery`.`courier_actions` (
  `courier_id` INT NULL DEFAULT NULL,
  `order_id` INT NULL DEFAULT NULL,
  `action` TEXT NULL DEFAULT NULL,
  `time` DATE NULL DEFAULT NULL,
  INDEX `fk_courier_actions_couriers1_idx` (`courier_id` ASC) VISIBLE,
  INDEX `fk_courier_actions_orders1_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `fk_courier_actions_couriers1`
    FOREIGN KEY (`courier_id`)
    REFERENCES `courier_delivery`.`couriers` (`courier_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_courier_actions_orders1`
    FOREIGN KEY (`order_id`)
    REFERENCES `courier_delivery`.`orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `courier_delivery`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `courier_delivery`.`orders` (
  `order_id` INT NOT NULL,
  `creation_time` DATE NULL,
  `products_id` VARCHAR(45) NULL,
  `users_user_id` INT NOT NULL,
  `couriers_courier_id` INT NOT NULL,
  PRIMARY KEY (`order_id`, `users_user_id`, `couriers_courier_id`),
  INDEX `fk_orders_users1_idx` (`users_user_id` ASC) VISIBLE,
  INDEX `fk_orders_couriers1_idx` (`couriers_courier_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_users1`
    FOREIGN KEY (`users_user_id`)
    REFERENCES `courier_delivery`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_couriers1`
    FOREIGN KEY (`couriers_courier_id`)
    REFERENCES `courier_delivery`.`couriers` (`courier_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `courier_delivery`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `courier_delivery`.`products` (
  `product_id` INT NOT NULL,
  `product_name` TEXT NULL DEFAULT NULL,
  `price` INT NULL DEFAULT NULL,
  PRIMARY KEY (`product_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `courier_delivery`.`user_actions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `courier_delivery`.`user_actions` (
  `user_id` INT NULL,
  `order_id` INT NULL DEFAULT NULL,
  `action` TEXT NULL DEFAULT NULL,
  `time` DATE NULL DEFAULT NULL,
  INDEX `fk_user_actions_users_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_user_actions_orders1_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_actions_users`
    FOREIGN KEY (`user_id`)
    REFERENCES `courier_delivery`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_actions_orders1`
    FOREIGN KEY (`order_id`)
    REFERENCES `courier_delivery`.`orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `courier_delivery`.`orders_has_products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `courier_delivery`.`orders_has_products` (
  `orders_order_id` INT NOT NULL,
  `products_product_id` INT NOT NULL,
  PRIMARY KEY (`orders_order_id`, `products_product_id`),
  INDEX `fk_orders_has_products_products1_idx` (`products_product_id` ASC) VISIBLE,
  INDEX `fk_orders_has_products_orders1_idx` (`orders_order_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_has_products_orders1`
    FOREIGN KEY (`orders_order_id`)
    REFERENCES `courier_delivery`.`orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_has_products_products1`
    FOREIGN KEY (`products_product_id`)
    REFERENCES `courier_delivery`.`products` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
