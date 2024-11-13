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

-- Устанавливаем DELIMITER для объявления триггеров
DELIMITER //

-- Первый триггер: 
CREATE TRIGGER update_agent_and_payment
AFTER INSERT ON `mydb`.`Contract`
FOR EACH ROW
BEGIN
    DECLARE deal_status VARCHAR(15);

    SELECT `status` INTO deal_status
    FROM `mydb`.`Deal`
    WHERE `deal_id` = NEW.Deal_deal_id;

    IF deal_status = 'Completed' THEN
        UPDATE `mydb`.`Agent`
        SET `walrus` = `walrus` + 100
        WHERE `agent_id` = NEW.Agent_agent_id;

        UPDATE `mydb`.`Payment` AS p
        INNER JOIN `mydb`.`Deal` AS d ON p.Deal_deal_id = d.deal_id
        INNER JOIN `mydb`.`Contract` AS c ON d.deal_id = c.Deal_deal_id
        SET p.total_cost = p.total_cost + 100
        WHERE c.Agent_agent_id = NEW.Agent_agent_id
          AND d.status = 'Pending'
          AND p.status <> 'Paid';

        UPDATE `mydb`.`Agent`
        SET `num_of_succs_deals` = `num_of_succs_deals` + 1
        WHERE `agent_id` = NEW.Agent_agent_id;
    END IF;
END //

--  2ый триггер:
CREATE TRIGGER update_deal_and_run_actions
AFTER UPDATE ON `mydb`.`Payment`
FOR EACH ROW
BEGIN
    IF NEW.status = 'Paid' AND OLD.status <> 'Paid' THEN
            UPDATE `mydb`.`Deal`
            SET `status` = 'Completed'
            WHERE `deal_id` = NEW.Deal_deal_id;

            UPDATE `mydb`.`Agent`
            SET `walrus` = `walrus` + 100
            WHERE `agent_id` = (SELECT `Agent_agent_id` FROM `mydb`.`Contract` WHERE `Deal_deal_id` = NEW.Deal_deal_id);

            UPDATE `mydb`.`Agent`
            SET `num_of_succs_deals` = `num_of_succs_deals` + 1
            WHERE `agent_id` = (SELECT `Agent_agent_id` FROM `mydb`.`Contract` WHERE `Deal_deal_id` = NEW.Deal_deal_id);
    END IF;
END //


--  3ий триггер: 
CREATE TRIGGER decrement_successful_deals_and_walrus_on_contract_delete
AFTER DELETE ON `mydb`.`Contract`
FOR EACH ROW
BEGIN
    DECLARE deal_status VARCHAR(15);
    SELECT `status` INTO deal_status
    FROM `mydb`.`Deal`
    WHERE `deal_id` = OLD.Deal_deal_id;
    IF deal_status = 'Completed' THEN
        UPDATE `mydb`.`Agent`
        SET `num_of_succs_deals` = `num_of_succs_deals` - 1,
            `walrus` = `walrus` - 100
        WHERE `agent_id` = OLD.Agent_agent_id;
    END IF;
END //

--  4ый триггер
CREATE TRIGGER update_payment_total_cost_on_object_price_change
AFTER UPDATE ON `mydb`.`Object`
FOR EACH ROW
BEGIN
    DECLARE price_difference INT;

    IF OLD.cost <> NEW.cost THEN
        SET price_difference = NEW.cost - OLD.cost;

        UPDATE `mydb`.`Payment` AS p
        INNER JOIN `mydb`.`Deal` AS d ON p.Deal_deal_id = d.deal_id
        SET p.total_cost = p.total_cost + price_difference
        WHERE d.Object_object_id = NEW.object_id
          AND p.status <> 'Paid'; 
    END IF;
END //

--  5ый триггер:
CREATE TRIGGER update_deal_status_on_payment_expected
AFTER UPDATE ON `mydb`.`Payment`
FOR EACH ROW
BEGIN
    IF NEW.status = 'Expected' AND OLD.status <> 'Expected' THEN
        UPDATE `mydb`.`Deal`
        SET `status` = 'Pending'
        WHERE `deal_id` = NEW.Deal_deal_id;
    END IF;
END //

-- Возвращаем DELIMITER к стандартному значению
DELIMITER ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
