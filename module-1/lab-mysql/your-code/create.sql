-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema esquema_lab
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema esquema_lab
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `esquema_lab` DEFAULT CHARACTER SET utf8 ;
USE `esquema_lab` ;

-- -----------------------------------------------------
-- Table `esquema_lab`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `esquema_lab`.`customers` (
  `ID_customer` INT(11) NOT NULL AUTO_INCREMENT,
  `customer_id` INT(11) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `adress` VARCHAR(45) NULL DEFAULT NULL,
  `city_state` VARCHAR(45) NULL DEFAULT NULL,
  `country` VARCHAR(45) NULL DEFAULT NULL,
  `postalcode` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_customer`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `esquema_lab`.`salespersons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `esquema_lab`.`salespersons` (
  `ID_salesperson` INT(11) NOT NULL AUTO_INCREMENT,
  `staffID` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `store` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_salesperson`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `esquema_lab`.`invoices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `esquema_lab`.`invoices` (
  `ID_invoice` INT(11) NOT NULL AUTO_INCREMENT,
  `invoice_number` INT(11) NOT NULL,
  `date` DATE NOT NULL,
  `ID_customer` INT(11) NOT NULL,
  `ID_salesperson` INT(11) NOT NULL,
  PRIMARY KEY (`ID_invoice`),
  INDEX `fk_invoices_customers1_idx` (`ID_customer` ASC),
  INDEX `fk_invoices_salespersons1_idx` (`ID_salesperson` ASC),
  CONSTRAINT `fk_invoices_customers1`
    FOREIGN KEY (`ID_customer`)
    REFERENCES `esquema_lab`.`customers` (`ID_customer`),
  CONSTRAINT `fk_invoices_salespersons1`
    FOREIGN KEY (`ID_salesperson`)
    REFERENCES `esquema_lab`.`salespersons` (`ID_salesperson`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `esquema_lab`.`cars`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `esquema_lab`.`cars` (
  `ID_cars` INT NOT NULL AUTO_INCREMENT,
  `VIN` INT(11) NOT NULL,
  `manufactures` VARCHAR(45) NULL DEFAULT NULL,
  `model` VARCHAR(45) NULL DEFAULT NULL,
  `year` INT(11) NULL DEFAULT NULL,
  `color` VARCHAR(45) NULL DEFAULT NULL,
  `ID_invoice` INT(11) NOT NULL,
  PRIMARY KEY (`ID_cars`),
  INDEX `fk_cars_invoices_idx` (`ID_invoice` ASC),
  CONSTRAINT `fk_cars_invoices`
    FOREIGN KEY (`ID_invoice`)
    REFERENCES `esquema_lab`.`invoices` (`ID_invoice`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
