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
  `ID_cars` INT NOT NULL,
  `VIN` VARCHAR(45) NOT NULL,
  `manufactures` VARCHAR(45) NULL DEFAULT NULL,
  `model` VARCHAR(45) NULL DEFAULT NULL,
  `year` INT(11) NULL DEFAULT NULL,
  `color` VARCHAR(45) NULL DEFAULT NULL,
  `ID_invoice` INT(11) NULL DEFAULT NULL,
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

INSERT INTO customers (customer_id, name, phone, adress, city_state, country, postalcode)
VALUES (10001,'Pablo Picasso','+34 636 17 63 82','Paseo de la Chopera, 14 Madrid','Madrid','Spain',28045),
(20001,'Abraham Lincoln','+1 305 907 7086','120 SW 8th St	Miami','Florida','United States',33130),
(30001,'Napoléon Bonaparte','+33 1 79 75 40 00','40 Rue du Colisée Paris','Île-de-France','France',75008);

INSERT INTO salespersons (staffID, name, store)
VALUES (00001,'Petey Cruiser','Madrid'),
(00002,'Anna Sthesia','Barcelona'),
(00003,'Paul Molive','Berlin'),
(00004,'Gail Forcewind','Paris'),
(00005,'Paige Turner','Mimia'),
(00006,'Bob Frapples','Mexico City'),
(00007,'Walter Melon','Amsterdam'),
(00008,'Shonda Leer','São Paulo');

INSERT INTO invoices (invoice_number, date, ID_customer, ID_salesperson)
VALUES (852399038,'22.08.2018',2,4),
(731166526,'31.12.2018',1,6),
(271135104,'22.01.2019',3,8);

INSERT INTO cars (ID_cars, VIN, manufactures, model, year, color, ID_invoice)
VALUES (1,'3K096I98581DHSNUP','Volkswagen','Tiguan',2019,'Blue',1),
(2,'ZM8G7BEUQZ97IH46V','Peugeot','Rifter',2019,'Red',),(3,'RKXVNNIHLVVZOUB4M','Ford','Fusion',2018,'White',3),(4,'HKNDGS7CU31E9Z7JW','Toyota','RAV4',2018,'Silver',2),(5,'DAM41UDN3CHU2WVF6','Volvo','V60',2019,'Gray',),(6,'DAM41UDN3CHU2WVF6','Volvo','V60 Cross Country',2019,'Gray',);