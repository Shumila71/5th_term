SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Agent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Agent` (
  `agent_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `phoneNumber` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `num_of_succs_deals` INT NOT NULL,
  `walrus` INT NOT NULL,
  PRIMARY KEY (`agent_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Client` (
  `client_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `phoneNumber` VARCHAR(45) NOT NULL,
  `age` INT NOT NULL,
  `date_of_born` DATETIME NOT NULL,
  PRIMARY KEY (`client_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Object`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Object` (
  `object_id` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(45) NOT NULL,
  `cost` INT NOT NULL,
  `area` INT NOT NULL,
  PRIMARY KEY (`object_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`inspection`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`inspection` (
  `inspection_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `Agent_agent_id` INT NOT NULL,
  `Client_client_id` INT NOT NULL,
  `Object_object_id` INT NOT NULL,
  PRIMARY KEY (`inspection_id`),
  INDEX `fk_inspection_Agent_idx` (`Agent_agent_id` ASC) VISIBLE,
  INDEX `fk_inspection_Client1_idx` (`Client_client_id` ASC) VISIBLE,
  INDEX `fk_inspection_Object1_idx` (`Object_object_id` ASC) VISIBLE,
  CONSTRAINT `fk_inspection_Agent`
    FOREIGN KEY (`Agent_agent_id`)
    REFERENCES `mydb`.`Agent` (`agent_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_inspection_Client1`
    FOREIGN KEY (`Client_client_id`)
    REFERENCES `mydb`.`Client` (`client_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_inspection_Object1`
    FOREIGN KEY (`Object_object_id`)
    REFERENCES `mydb`.`Object` (`object_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Deal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Deal` (
  `deal_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `status` VARCHAR(15) NOT NULL,
  `Object_object_id` INT NOT NULL,
  `Client_client_id` INT NOT NULL,
  PRIMARY KEY (`deal_id`),
  INDEX `fk_Deal_Object1_idx` (`Object_object_id` ASC) VISIBLE,
  INDEX `fk_Deal_Client1_idx` (`Client_client_id` ASC) VISIBLE,
  CONSTRAINT `fk_Deal_Object1`
    FOREIGN KEY (`Object_object_id`)
    REFERENCES `mydb`.`Object` (`object_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Deal_Client1`
    FOREIGN KEY (`Client_client_id`)
    REFERENCES `mydb`.`Client` (`client_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment` (
  `date` DATETIME NOT NULL,
  `status` VARCHAR(15) NOT NULL,
  `total_cost` INT NOT NULL,
  `Deal_deal_id` INT NOT NULL,
  PRIMARY KEY (`Deal_deal_id`),
  CONSTRAINT `fk_Payment_Deal1`
    FOREIGN KEY (`Deal_deal_id`)
    REFERENCES `mydb`.`Deal` (`deal_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Contract`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Contract` (
  `date_signed` DATETIME NOT NULL,
  `conditions` LONGTEXT NOT NULL,
  `Agent_agent_id` INT NOT NULL,
  `Deal_deal_id` INT NOT NULL,
  PRIMARY KEY (`Deal_deal_id`),
  INDEX `fk_Contract_Agent1_idx` (`Agent_agent_id` ASC) VISIBLE,
  INDEX `fk_Contract_Deal1_idx` (`Deal_deal_id` ASC) VISIBLE,
  CONSTRAINT `fk_Contract_Agent1`
    FOREIGN KEY (`Agent_agent_id`)
    REFERENCES `mydb`.`Agent` (`agent_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Contract_Deal1`
    FOREIGN KEY (`Deal_deal_id`)
    REFERENCES `mydb`.`Deal` (`deal_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
