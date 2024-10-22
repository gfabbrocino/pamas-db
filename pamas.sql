-- MySQL Script generated by MySQL Workbench
-- Fri Oct 18 19:42:44 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pamas
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pamas
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pamas` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin ;
USE `pamas` ;

-- -----------------------------------------------------
-- Table `pamas`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pamas`.`address` ;

CREATE TABLE IF NOT EXISTS `pamas`.`address` (
  `id_address` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(80) NULL,
  `civic` VARCHAR(8) NULL,
  `cap` INT NULL,
  `city` VARCHAR(60) NULL,
  `province` VARCHAR(2) NULL,
  `nation` VARCHAR(60) NULL,
  PRIMARY KEY (`id_address`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pamas`.`garage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pamas`.`garage` ;

CREATE TABLE IF NOT EXISTS `pamas`.`garage` (
  `id_garage` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NOT NULL,
  `owner` VARCHAR(80) NULL,
  `id_address` INT UNSIGNED NULL,
  `piva` VARCHAR(11) NULL,
  `phone` VARCHAR(16) NULL,
  `mobile` VARCHAR(16) NULL,
  `web` VARCHAR(80) NULL,
  `mail` VARCHAR(80) NULL,
  `pec` VARCHAR(80) NULL,
  `logo` VARCHAR(250) NULL,
  `updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_garage`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) INVISIBLE,
  INDEX `fk_garage_address_idx` (`id_address` ASC) VISIBLE,
  CONSTRAINT `fk_garage_address`
    FOREIGN KEY (`id_address`)
    REFERENCES `pamas`.`address` (`id_address`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pamas`.`account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pamas`.`account` ;

CREATE TABLE IF NOT EXISTS `pamas`.`account` (
  `username` VARCHAR(120) NOT NULL,
  `password` VARCHAR(80) NOT NULL,
  `role` ENUM('Admin', 'Office', 'Operator') NOT NULL,
  `account_expired` TINYINT NOT NULL DEFAULT 0,
  `account_locked` TINYINT NOT NULL DEFAULT 0,
  `credentials_expired` TINYINT NOT NULL DEFAULT 0,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  `updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`username`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pamas`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pamas`.`user` ;

CREATE TABLE IF NOT EXISTS `pamas`.`user` (
  `id_user` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(120) NOT NULL,
  `name` VARCHAR(40) NOT NULL,
  `surname` VARCHAR(40) NOT NULL,
  `id_address` INT UNSIGNED NULL,
  `fiscalcode` VARCHAR(16) NULL,
  `badge` VARCHAR(16) NULL,
  `phone` VARCHAR(16) NULL,
  `mobile` VARCHAR(16) NULL,
  `mail` VARCHAR(80) NULL,
  `updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_user`),
  INDEX `fk_user_address1_idx` (`id_address` ASC) VISIBLE,
  INDEX `fk_user_account1_idx` (`username` ASC) VISIBLE,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) INVISIBLE,
  CONSTRAINT `fk_user_address1`
    FOREIGN KEY (`id_address`)
    REFERENCES `pamas`.`address` (`id_address`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_account1`
    FOREIGN KEY (`username`)
    REFERENCES `pamas`.`account` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pamas`.`permission`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pamas`.`permission` ;

CREATE TABLE IF NOT EXISTS `pamas`.`permission` (
  `id_permission` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_user` INT UNSIGNED NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `value` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_permission`),
  INDEX `fk_permission_user1_idx` (`id_user` ASC) VISIBLE,
  CONSTRAINT `fk_permission_user1`
    FOREIGN KEY (`id_user`)
    REFERENCES `pamas`.`user` (`id_user`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pamas`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pamas`.`customer` ;

CREATE TABLE IF NOT EXISTS `pamas`.`customer` (
  `id_customer` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `surname` VARCHAR(60) NOT NULL,
  `company` VARCHAR(60) NULL,
  `id_address` INT UNSIGNED NULL,
  `fiscalcode` VARCHAR(16) NULL,
  `piva` VARCHAR(11) NULL,
  `phone` VARCHAR(16) NULL,
  `mobile` VARCHAR(16) NULL,
  `email` VARCHAR(80) NULL,
  `pec` VARCHAR(80) NULL,
  `updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_customer`),
  INDEX `fk_customer_address1_idx` (`id_address` ASC) VISIBLE,
  CONSTRAINT `fk_customer_address1`
    FOREIGN KEY (`id_address`)
    REFERENCES `pamas`.`address` (`id_address`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pamas`.`vehicle_model`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pamas`.`vehicle_model` ;

CREATE TABLE IF NOT EXISTS `pamas`.`vehicle_model` (
  `id_vehicle_model` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `typology` ENUM('Autobus', 'Autocarro', 'Autoveicolo', 'Camper', 'Furgone', 'Roulotte', 'Motociclo', 'Motoveicolo', 'Altro') NOT NULL DEFAULT 'Autoveicolo',
  `brand` VARCHAR(50) NOT NULL,
  `model` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`id_vehicle_model`),
  INDEX `brand_idx` (`brand` ASC) INVISIBLE,
  INDEX `model_idx` (`model` ASC) INVISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pamas`.`rate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pamas`.`rate` ;

CREATE TABLE IF NOT EXISTS `pamas`.`rate` (
  `id_rate` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `default` TINYINT(1) NOT NULL DEFAULT 0,
  `name` VARCHAR(80) NOT NULL,
  `description` VARCHAR(250) NULL,
  `script` TEXT NULL,
  `updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_rate`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pamas`.`vehicle_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pamas`.`vehicle_type` ;

CREATE TABLE IF NOT EXISTS `pamas`.`vehicle_type` (
  `id_vehicle_type` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_rate` INT UNSIGNED NULL,
  `default` TINYINT(1) NOT NULL DEFAULT 0,
  `name` VARCHAR(80) NOT NULL,
  `subprice` DECIMAL(10,2) NULL,
  `updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_vehicle_type`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  INDEX `fk_vehicle_type_rate1_idx` (`id_rate` ASC) VISIBLE,
  CONSTRAINT `fk_vehicle_type_rate1`
    FOREIGN KEY (`id_rate`)
    REFERENCES `pamas`.`rate` (`id_rate`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pamas`.`subscription`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pamas`.`subscription` ;

CREATE TABLE IF NOT EXISTS `pamas`.`subscription` (
  `id_subscription` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_customer` INT UNSIGNED NOT NULL,
  `stipulation` TIMESTAMP NOT NULL,
  `payday` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `frequency` ENUM('Settimanale', 'Mensile', 'Bimestrale', 'Trimestrale', 'Semestrale', 'Annuale') NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `discount` DECIMAL(10,2) NOT NULL DEFAULT 0,
  `expiration` TIMESTAMP NULL,
  `suspended` TINYINT NULL DEFAULT 0,
  `note` VARCHAR(1024) NULL DEFAULT '',
  `updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_subscription`),
  INDEX `fk_subscription_customer1_idx` (`id_customer` ASC) VISIBLE,
  CONSTRAINT `fk_subscription_customer1`
    FOREIGN KEY (`id_customer`)
    REFERENCES `pamas`.`customer` (`id_customer`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pamas`.`vehicle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pamas`.`vehicle` ;

CREATE TABLE IF NOT EXISTS `pamas`.`vehicle` (
  `plate` VARCHAR(16) NOT NULL,
  `id_typology` INT UNSIGNED NOT NULL,
  `id_model` INT UNSIGNED NULL,
  `id_customer` INT UNSIGNED NULL,
  `id_subscription` INT UNSIGNED NULL,
  `subprice` DECIMAL(10,2) NULL,
  `updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`plate`),
  INDEX `fk_vehicle_customer1_idx` (`id_customer` ASC) VISIBLE,
  INDEX `fk_vehicle_model1_idx` (`id_model` ASC) VISIBLE,
  INDEX `fk_vehicle_vehicle_type1_idx` (`id_typology` ASC) VISIBLE,
  INDEX `fk_vehicle_subscription1_idx` (`id_subscription` ASC) VISIBLE,
  CONSTRAINT `fk_vehicle_customer1`
    FOREIGN KEY (`id_customer`)
    REFERENCES `pamas`.`customer` (`id_customer`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_vehicle_model1`
    FOREIGN KEY (`id_model`)
    REFERENCES `pamas`.`vehicle_model` (`id_vehicle_model`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_vehicle_vehicle_type1`
    FOREIGN KEY (`id_typology`)
    REFERENCES `pamas`.`vehicle_type` (`id_vehicle_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vehicle_subscription1`
    FOREIGN KEY (`id_subscription`)
    REFERENCES `pamas`.`subscription` (`id_subscription`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pamas`.`ticket`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pamas`.`ticket` ;

CREATE TABLE IF NOT EXISTS `pamas`.`ticket` (
  `id_ticket` INT UNSIGNED NOT NULL,
  `status` ENUM('Free', 'Reserved', 'Busy', 'Exit') NOT NULL DEFAULT 'Free',
  `id_user` INT UNSIGNED NULL,
  `plate` VARCHAR(16) NULL,
  `id_rate` INT UNSIGNED NULL,
  `entry` TIMESTAMP NULL,
  `withdraw` TIMESTAMP NULL,
  `terminal` VARCHAR(40) NULL,
  `updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_ticket`),
  INDEX `fk_ticket_vehicle1_idx` (`plate` ASC) VISIBLE,
  INDEX `fk_ticket_user1_idx` (`id_user` ASC) VISIBLE,
  INDEX `fk_ticket_rate1_idx` (`id_rate` ASC) VISIBLE,
  CONSTRAINT `fk_ticket_vehicle1`
    FOREIGN KEY (`plate`)
    REFERENCES `pamas`.`vehicle` (`plate`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ticket_user1`
    FOREIGN KEY (`id_user`)
    REFERENCES `pamas`.`user` (`id_user`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ticket_rate1`
    FOREIGN KEY (`id_rate`)
    REFERENCES `pamas`.`rate` (`id_rate`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pamas`.`logbook`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pamas`.`logbook` ;

CREATE TABLE IF NOT EXISTS `pamas`.`logbook` (
  `id_logbook` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ticket` SMALLINT NOT NULL,
  `dtmove` TIMESTAMP NOT NULL,
  `user` VARCHAR(80) NOT NULL,
  `terminal` VARCHAR(40) NOT NULL,
  `plate` VARCHAR(16) NOT NULL,
  `typology` VARCHAR(60) NOT NULL DEFAULT 'Autoveicolo',
  `model` VARCHAR(120) NULL,
  `direction` ENUM('Ingresso', 'Uscita') NOT NULL,
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_logbook`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pamas`.`transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pamas`.`transaction` ;

CREATE TABLE IF NOT EXISTS `pamas`.`transaction` (
  `id_transaction` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `opening` TIMESTAMP NOT NULL,
  `user_opening` INT UNSIGNED NULL,
  `closing` TIMESTAMP NULL,
  `user_closing` INT UNSIGNED NULL,
  `cashfund` DECIMAL(10,2) NOT NULL DEFAULT 0,
  `profit` DECIMAL(10,2) NOT NULL DEFAULT 0,
  `withdrawal` DECIMAL(10,2) NOT NULL DEFAULT 0,
  `updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_transaction`),
  INDEX `fk_transaction_user1_idx` (`user_opening` ASC) VISIBLE,
  INDEX `fk_transaction_user2_idx` (`user_closing` ASC) VISIBLE,
  CONSTRAINT `fk_transaction_user1`
    FOREIGN KEY (`user_opening`)
    REFERENCES `pamas`.`user` (`id_user`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_transaction_user2`
    FOREIGN KEY (`user_closing`)
    REFERENCES `pamas`.`user` (`id_user`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pamas`.`invoice`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pamas`.`invoice` ;

CREATE TABLE IF NOT EXISTS `pamas`.`invoice` (
  `id_invoice` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_transaction` INT UNSIGNED NULL,
  `id_user` INT UNSIGNED NULL,
  `id_customer` INT UNSIGNED NULL,
  `terminal` VARCHAR(60) NOT NULL,
  `perciva` TINYINT NOT NULL DEFAULT 22,
  `amount` DECIMAL(10,2) NOT NULL DEFAULT 0,
  `iva` DECIMAL(10,2) NOT NULL DEFAULT 0,
  `total` DECIMAL(10,2) NOT NULL DEFAULT 0,
  `withholding` DECIMAL(10,2) NULL,
  `payment` ENUM('Contanti', 'Bancomat', 'Carta', 'Assegno', 'Credito') NOT NULL,
  `cashed` TIMESTAMP NULL,
  `updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_invoice`),
  INDEX `fk_invoice_customer1_idx` (`id_customer` ASC) VISIBLE,
  INDEX `fk_invoice_user1_idx` (`id_user` ASC) VISIBLE,
  INDEX `fk_invoice_transaction1_idx` (`id_transaction` ASC) VISIBLE,
  INDEX `fk_invoice_payment_idx` (`payment` ASC) VISIBLE,
  INDEX `fk_invoice_cashed_idx` (`cashed` ASC) VISIBLE,
  CONSTRAINT `fk_invoice_customer1`
    FOREIGN KEY (`id_customer`)
    REFERENCES `pamas`.`customer` (`id_customer`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_invoice_user1`
    FOREIGN KEY (`id_user`)
    REFERENCES `pamas`.`user` (`id_user`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_invoice_transaction1`
    FOREIGN KEY (`id_transaction`)
    REFERENCES `pamas`.`transaction` (`id_transaction`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pamas`.`invoice_detail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pamas`.`invoice_detail` ;

CREATE TABLE IF NOT EXISTS `pamas`.`invoice_detail` (
  `id_invoice_detail` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_invoice` INT UNSIGNED NOT NULL,
  `position` TINYINT NOT NULL DEFAULT 0,
  `business` ENUM('ABM', 'PAO', 'SRV') NOT NULL,
  `description` VARCHAR(512) NOT NULL,
  `quantity` TINYINT NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  `iva` DECIMAL(10,2) NOT NULL DEFAULT 22,
  `total` DECIMAL(10,2) NOT NULL,
  `updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_invoice_detail`),
  INDEX `fk_invoiced_detail_invoice1_idx` (`id_invoice` ASC) VISIBLE,
  CONSTRAINT `fk_invoiced_detail_invoice1`
    FOREIGN KEY (`id_invoice`)
    REFERENCES `pamas`.`invoice` (`id_invoice`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pamas`.`rate_param`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pamas`.`rate_param` ;

CREATE TABLE IF NOT EXISTS `pamas`.`rate_param` (
  `id_rate_param` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_rate` INT UNSIGNED NOT NULL,
  `name` VARCHAR(60) NOT NULL,
  `label` VARCHAR(120) NOT NULL,
  `value` VARCHAR(1024) NOT NULL DEFAULT 0,
  `updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_rate_param`),
  INDEX `fk_rate_param_rate1_idx` (`id_rate` ASC) VISIBLE,
  CONSTRAINT `fk_rate_param_rate1`
    FOREIGN KEY (`id_rate`)
    REFERENCES `pamas`.`rate` (`id_rate`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pamas`.`subscription_payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pamas`.`subscription_payment` ;

CREATE TABLE IF NOT EXISTS `pamas`.`subscription_payment` (
  `id_subscription_payment` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_subscription` INT UNSIGNED NOT NULL,
  `id_invoice` INT UNSIGNED NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  `payment_date` TIMESTAMP NOT NULL,
  `payment_type` ENUM('Contanti', 'Bancomat', 'Carta', 'Assegno', 'Credito') NOT NULL,
  `expiration` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id_subscription_payment`),
  INDEX `fk_subscription_payment_subscription1_idx` (`id_subscription` ASC) VISIBLE,
  INDEX `fk_subscription_payment_invoice1_idx` (`id_invoice` ASC) VISIBLE,
  CONSTRAINT `fk_subscription_payment_subscription1`
    FOREIGN KEY (`id_subscription`)
    REFERENCES `pamas`.`subscription` (`id_subscription`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_subscription_payment_invoice1`
    FOREIGN KEY (`id_invoice`)
    REFERENCES `pamas`.`invoice` (`id_invoice`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;

USE `pamas` ;

-- -----------------------------------------------------
-- Placeholder table for view `pamas`.`transaction_list`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pamas`.`transaction_list` (`id` INT, `opening` INT, `userOpening` INT, `closing` INT, `userClosing` INT, `cashfund` INT, `profit` INT, `withdrawal` INT, `invoiceCount` INT);

-- -----------------------------------------------------
-- procedure getFreeTicket
-- -----------------------------------------------------

USE `pamas`;
DROP procedure IF EXISTS `pamas`.`getFreeTicket`;

DELIMITER $$
USE `pamas`$$
CREATE PROCEDURE `getFreeTicket` (IN inpIdUser INT)
BEGIN
	DECLARE reservedCount INT;
	SELECT COUNT(*) INTO reservedCount
	FROM `ticket`
	WHERE `status` = 'Reserved' AND id_user = inpIdUser;
	IF reservedCount > 0 THEN
		SELECT * FROM `ticket` WHERE `status`='Reserved' AND id_user = inpIdUser ORDER BY `id_ticket` ASC LIMIT 1;
	ELSE
		SELECT * FROM `ticket` WHERE `status`='Free' ORDER BY `id_ticket` ASC LIMIT 1;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure getSummary
-- -----------------------------------------------------

USE `pamas`;
DROP procedure IF EXISTS `pamas`.`getSummary`;

DELIMITER $$
USE `pamas`$$
CREATE PROCEDURE `getSummary` (IN idTransaction INT)
BEGIN
	SELECT
		id.business,
		CASE 
			WHEN id.business = 'PAO' THEN 'Parcheggio'
			WHEN id.business = 'SRV' THEN 'Servizi'
			WHEN id.business = 'ABM' THEN 'Abbonamenti'
			ELSE 'Altro'
		END AS `description`,
		SUM(CASE WHEN i.payment = 'Contanti' THEN id.total ELSE 0 END) AS cash,
		SUM(CASE WHEN i.payment <> 'Contanti' THEN id.total ELSE 0 END) AS other,
		SUM(id.total) AS total,
		CASE 
			WHEN id.business = 'PAO' THEN 'bg-blue-500'
			WHEN id.business = 'SRV' THEN 'bg-amber-500'
			WHEN id.business = 'ABM' THEN 'bg-green-500'
			ELSE 'Altro'
		END AS `color`
	FROM
		invoice_detail id
	JOIN
		invoice i ON id.id_invoice = i.id_invoice
	WHERE
		i.id_transaction = idTransaction
	GROUP BY
		id.business
        
	UNION ALL

	SELECT
		'TOT' AS business,
		'Totale' AS `description`,
		SUM(CASE WHEN i.payment = 'Contanti' THEN id.total ELSE 0 END) AS cash,
		SUM(CASE WHEN i.payment <> 'Contanti' THEN id.total ELSE 0 END) AS other,
		SUM(id.total) AS total,
		'bg-red-500' AS color
	FROM
		invoice_detail id
	JOIN
		invoice i ON id.id_invoice = i.id_invoice
	WHERE
		i.id_transaction = idTransaction;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `pamas`.`transaction_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pamas`.`transaction_list`;
DROP VIEW IF EXISTS `pamas`.`transaction_list` ;
USE `pamas`;
CREATE  OR REPLACE VIEW `transaction_list` AS
SELECT
	`t`.`id_transaction` AS `id`,
	`t`.`opening` AS `opening`,
	CONCAT(`uo`.`name`, ' ', `uo`.`surname`) AS `userOpening`,
	`t`.`closing` AS `closing`,
	CONCAT(`uc`.`name`, ' ', `uc`.`surname`) AS `userClosing`,
	`t`.`cashfund` AS `cashfund`,
	SUM(`i`.`total`) AS `profit`,
	`t`.`withdrawal` AS `withdrawal`,
	COUNT(`i`.`id_invoice`) AS `invoiceCount`
FROM
	(((`transaction` `t`
	LEFT JOIN `user` `uo` ON ((`t`.`user_opening` = `uo`.`id_user`)))
	LEFT JOIN `user` `uc` ON ((`t`.`user_closing` = `uc`.`id_user`)))
	LEFT JOIN `invoice` `i` ON ((`t`.`id_transaction` = `i`.`id_transaction`)))
GROUP BY `t`.`id_transaction`
ORDER BY `t`.`id_transaction` DESC;
SET SQL_MODE = '';
DROP USER IF EXISTS pamaster;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'pamaster' IDENTIFIED BY '8mJfEV8o3#0@6p+L1cPi';

GRANT ALL ON `pamas`.* TO 'pamaster';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `pamas`.`address`
-- -----------------------------------------------------
START TRANSACTION;
USE `pamas`;
INSERT INTO `pamas`.`address` (`id_address`, `street`, `civic`, `cap`, `city`, `province`, `nation`) VALUES (1, 'Via Chiatamone', '26', 80100, 'Napoli', 'NA', 'ITALY');

COMMIT;


-- -----------------------------------------------------
-- Data for table `pamas`.`garage`
-- -----------------------------------------------------
START TRANSACTION;
USE `pamas`;
INSERT INTO `pamas`.`garage` (`id_garage`, `name`, `owner`, `id_address`, `piva`, `phone`, `mobile`, `web`, `mail`, `pec`, `logo`, `updated`, `created`) VALUES (1, 'Garage Chiatamone', 'PARTENOPE PARKING SRL', 1, '07800580636', '081 764 28 63', NULL, 'www.garagechiatamone.it', NULL, NULL, NULL, DEFAULT, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `pamas`.`account`
-- -----------------------------------------------------
START TRANSACTION;
USE `pamas`;
INSERT INTO `pamas`.`account` (`username`, `password`, `role`, `account_expired`, `account_locked`, `credentials_expired`, `enabled`, `updated`, `created`) VALUES ('admin@eparking.it', '$2a$10$sD/f1KWv.r7Cs42uSYikROFV.5ZETK0aBg73qwkENkJz15tYtlGVa', 'Admin', 0, 0, 0, 1, DEFAULT, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `pamas`.`user`
-- -----------------------------------------------------
START TRANSACTION;
USE `pamas`;
INSERT INTO `pamas`.`user` (`id_user`, `username`, `name`, `surname`, `id_address`, `fiscalcode`, `badge`, `phone`, `mobile`, `mail`, `updated`, `created`) VALUES (DEFAULT, 'admin@eparking.it', 'Angelo', 'Addato', NULL, 'ANGADD65N06N222R', '123456', NULL, NULL, NULL, DEFAULT, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `pamas`.`vehicle_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `pamas`;
INSERT INTO `pamas`.`vehicle_type` (`id_vehicle_type`, `id_rate`, `default`, `name`, `subprice`, `updated`, `created`) VALUES (1, NULL, DEFAULT, 'Autobus', 0, DEFAULT, DEFAULT);
INSERT INTO `pamas`.`vehicle_type` (`id_vehicle_type`, `id_rate`, `default`, `name`, `subprice`, `updated`, `created`) VALUES (2, NULL, DEFAULT, 'Autocarro', 0, DEFAULT, DEFAULT);
INSERT INTO `pamas`.`vehicle_type` (`id_vehicle_type`, `id_rate`, `default`, `name`, `subprice`, `updated`, `created`) VALUES (3, NULL, DEFAULT, 'Autoveicolo', 0, DEFAULT, DEFAULT);
INSERT INTO `pamas`.`vehicle_type` (`id_vehicle_type`, `id_rate`, `default`, `name`, `subprice`, `updated`, `created`) VALUES (4, NULL, DEFAULT, 'Camper', 0, DEFAULT, DEFAULT);
INSERT INTO `pamas`.`vehicle_type` (`id_vehicle_type`, `id_rate`, `default`, `name`, `subprice`, `updated`, `created`) VALUES (5, NULL, DEFAULT, 'Furgone', 0, DEFAULT, DEFAULT);
INSERT INTO `pamas`.`vehicle_type` (`id_vehicle_type`, `id_rate`, `default`, `name`, `subprice`, `updated`, `created`) VALUES (6, NULL, DEFAULT, 'Roulotte', 0, DEFAULT, DEFAULT);
INSERT INTO `pamas`.`vehicle_type` (`id_vehicle_type`, `id_rate`, `default`, `name`, `subprice`, `updated`, `created`) VALUES (7, NULL, DEFAULT, 'Motociclo', 0, DEFAULT, DEFAULT);
INSERT INTO `pamas`.`vehicle_type` (`id_vehicle_type`, `id_rate`, `default`, `name`, `subprice`, `updated`, `created`) VALUES (8, NULL, DEFAULT, 'Motoveicolo', 0, DEFAULT, DEFAULT);
INSERT INTO `pamas`.`vehicle_type` (`id_vehicle_type`, `id_rate`, `default`, `name`, `subprice`, `updated`, `created`) VALUES (9, NULL, DEFAULT, 'Altro', 0, DEFAULT, DEFAULT);

COMMIT;

