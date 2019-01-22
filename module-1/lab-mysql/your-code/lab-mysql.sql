-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Salesperson`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Salesperson` (
  `ID_salesperson` INT NOT NULL AUTO_INCREMENT,
  `staffID` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `store` VARCHAR(45) NULL,
  PRIMARY KEY (`ID_salesperson`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Customers` (
  `ID_customers` INT NOT NULL AUTO_INCREMENT,
  `customersID` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `adress` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  `postalcode` INT NULL,
  PRIMARY KEY (`ID_customers`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Invoices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Invoices` (
  `invoceNumber` INT NOT NULL,
  `date` DATE NOT NULL,
  `Salesperson_ID_salesperson` INT NOT NULL,
  `Customers_ID_customers` INT NOT NULL,
  PRIMARY KEY (`invoceNumber`, `Salesperson_ID_salesperson`, `Customers_ID_customers`),
  INDEX `fk_Invoices_Salesperson1_idx` (`Salesperson_ID_salesperson` ASC),
  INDEX `fk_Invoices_Customers1_idx` (`Customers_ID_customers` ASC),
  CONSTRAINT `fk_Invoices_Salesperson1`
    FOREIGN KEY (`Salesperson_ID_salesperson`)
    REFERENCES `mydb`.`Salesperson` (`ID_salesperson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Invoices_Customers1`
    FOREIGN KEY (`Customers_ID_customers`)
    REFERENCES `mydb`.`Customers` (`ID_customers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cars`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cars` (
  `ID cars` INT NOT NULL AUTO_INCREMENT,
  `VIN` INT NOT NULL,
  `manufacturer` VARCHAR(45) NOT NULL,
  `model` VARCHAR(45) NOT NULL,
  `year` INT NOT NULL,
  `color` VARCHAR(45) NOT NULL,
  `Invoices_invoceNumber` INT NOT NULL,
  PRIMARY KEY (`ID cars`),
  INDEX `fk_Cars_Invoices_idx` (`Invoices_invoceNumber` ASC),
  CONSTRAINT `fk_Cars_Invoices`
    FOREIGN KEY (`Invoices_invoceNumber`)
    REFERENCES `mydb`.`Invoices` (`invoceNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
