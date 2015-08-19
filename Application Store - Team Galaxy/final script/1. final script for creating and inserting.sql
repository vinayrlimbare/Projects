SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User` (
  `User_ID` INT NOT NULL AUTO_INCREMENT,
  `Password` VARCHAR(16) NOT NULL,
  `FirstName` VARCHAR(20) NOT NULL,
  `LastName` VARCHAR(20) NOT NULL,
  `EmailID` VARCHAR(100) NOT NULL,
  `Gender` VARCHAR(1) NULL,
  `DateOfBirth` DATE NULL,
  `PhoneNumber` VARCHAR(20) NULL,
  `State` VARCHAR(20) NULL,
  `City` VARCHAR(20) NULL,
  `Country` VARCHAR(20) NULL,
  PRIMARY KEY (`User_ID`),
  UNIQUE INDEX `EmailID_UNIQUE` (`EmailID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CardDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CardDetails` (
  `Card_ID` INT NOT NULL AUTO_INCREMENT,
  `CardName` VARCHAR(45) NOT NULL,
  `CardNumber` VARCHAR(20) NOT NULL,
  `ExpiryDate` DATE NOT NULL,
  `CVV` VARCHAR(10) NOT NULL,
  `BillingAddress` VARCHAR(100) NULL,
  `CardType` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Card_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Company` (
  `Company_ID` INT NOT NULL AUTO_INCREMENT,
  `CompanyName` VARCHAR(50) NOT NULL,
  `CompanyPassword` VARCHAR(20) NOT NULL,
  `CompanyEmailId` VARCHAR(45) NULL,
  `TypeV` VARCHAR(1) NULL,
  `TypeA` VARCHAR(1) NULL,
  PRIMARY KEY (`Company_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AccountDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AccountDetails` (
  `Account_ID` INT NOT NULL AUTO_INCREMENT,
  `AccountNumber` VARCHAR(30) NULL,
  `BankName` VARCHAR(45) NULL,
  `RoutingNumber` VARCHAR(20) NULL,
  `AccountType` VARCHAR(20) NULL,
  `CheckingNumber` VARCHAR(20) NULL,
  PRIMARY KEY (`Account_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Employee` (
  `Emp_ID` INT NOT NULL AUTO_INCREMENT,
  `EmpName` VARCHAR(45) NULL,
  `EmpDept` VARCHAR(20) NULL,
  `EmpType` VARCHAR(1) NULL,
  `Salary` INT NULL,
  PRIMARY KEY (`Emp_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tester`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tester` (
  `TEmp_ID` INT NOT NULL,
  PRIMARY KEY (`TEmp_ID`),
  CONSTRAINT `fk_Tester_Employee1`
    FOREIGN KEY (`TEmp_ID`)
    REFERENCES `mydb`.`Employee` (`Emp_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CategoryGenre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CategoryGenre` (
  `Category_ID` INT NOT NULL,
  `CategoryName` VARCHAR(45) NULL,
  `TypeOfProduct` VARCHAR(2) NULL,
  PRIMARY KEY (`Category_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Product` (
  `Product_ID` INT NOT NULL AUTO_INCREMENT,
  `Company_ID` INT NOT NULL,
  `Category_ID` INT NOT NULL,
  `Tester_ID` INT NOT NULL,
  `Status` VARCHAR(10) NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `AvgRating` VARCHAR(45) NULL,
  `NumberOfDownloads` VARCHAR(45) NULL,
  `Description` VARCHAR(200) NULL,
  `Price` FLOAT NULL,
  `MultimediaLink` VARCHAR(100) NULL,
  `ProductType` VARCHAR(2) NULL,
  PRIMARY KEY (`Product_ID`),
  INDEX `Company_ID_idx` (`Company_ID` ASC),
  INDEX `fk_Product_Tester1_idx` (`Tester_ID` ASC),
  INDEX `fk_Product_CategoryGenre1_idx` (`Category_ID` ASC),
  CONSTRAINT `Company_ID`
    FOREIGN KEY (`Company_ID`)
    REFERENCES `mydb`.`Company` (`Company_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Product_Tester1`
    FOREIGN KEY (`Tester_ID`)
    REFERENCES `mydb`.`Tester` (`TEmp_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Product_CategoryGenre1`
    FOREIGN KEY (`Category_ID`)
    REFERENCES `mydb`.`CategoryGenre` (`Category_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Details` (
  `Details_ID` INT NOT NULL AUTO_INCREMENT,
  `User_ID` INT NOT NULL,
  `Card_ID` INT NULL,
  PRIMARY KEY (`Details_ID`),
  INDEX `User_ID_idx` (`User_ID` ASC),
  INDEX `Card_ID_idx` (`Card_ID` ASC),
  CONSTRAINT `User_ID`
    FOREIGN KEY (`User_ID`)
    REFERENCES `mydb`.`User` (`User_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Card_ID`
    FOREIGN KEY (`Card_ID`)
    REFERENCES `mydb`.`CardDetails` (`Card_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Version`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Version` (
  `Version_ID` INT NOT NULL AUTO_INCREMENT,
  `VersionNumber` VARCHAR(45) NULL,
  `MobileOS` VARCHAR(20) NULL,
  `Size` FLOAT NULL,
  `ProductLink` VARCHAR(45) NULL,
  `WhatsNew` VARCHAR(45) NULL,
  `VersionDate` DATE NULL,
  `Product_ID` INT NOT NULL,
  PRIMARY KEY (`Version_ID`),
  INDEX `fk_Version_Product1_idx` (`Product_ID` ASC),
  CONSTRAINT `fk_Version_Product1`
    FOREIGN KEY (`Product_ID`)
    REFERENCES `mydb`.`Product` (`Product_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Transaction` (
  `Transaction_ID` INT NOT NULL AUTO_INCREMENT,
  `Details_ID` INT NOT NULL,
  `Version_ID` INT NOT NULL,
  `Status` VARCHAR(45) NULL,
  `Timestamp` DATETIME NULL,
  `Amount` FLOAT NULL,
  `Gateway_ID` VARCHAR(16) NULL,
  PRIMARY KEY (`Transaction_ID`),
  INDEX `Details_ID_idx` (`Details_ID` ASC),
  INDEX `fk_Transaction_Version1_idx` (`Version_ID` ASC),
  CONSTRAINT `Details_ID`
    FOREIGN KEY (`Details_ID`)
    REFERENCES `mydb`.`Details` (`Details_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transaction_Version1`
    FOREIGN KEY (`Version_ID`)
    REFERENCES `mydb`.`Version` (`Version_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Game`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Game` (
  `GProduct_ID` INT NOT NULL,
  PRIMARY KEY (`GProduct_ID`),
  CONSTRAINT `fk_Game_Product1`
    FOREIGN KEY (`GProduct_ID`)
    REFERENCES `mydb`.`Product` (`Product_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Movie` (
  `MOProduct_ID` INT NOT NULL,
  `Length` FLOAT NULL,
  `Quality` INT NULL,
  PRIMARY KEY (`MOProduct_ID`),
  CONSTRAINT `fk_Movie_Product1`
    FOREIGN KEY (`MOProduct_ID`)
    REFERENCES `mydb`.`Product` (`Product_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Music`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Music` (
  `MUProduct_ID` INT NOT NULL,
  `Singer` VARCHAR(45) NULL,
  `Album` VARCHAR(45) NULL,
  `Length` FLOAT NULL,
  `SongQuality` INT NULL,
  PRIMARY KEY (`MUProduct_ID`),
  CONSTRAINT `fk_Music_Product1`
    FOREIGN KEY (`MUProduct_ID`)
    REFERENCES `mydb`.`Product` (`Product_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ebooks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ebooks` (
  `EProduct_ID` INT NOT NULL,
  `ISBN` VARCHAR(30) NULL,
  `Author` VARCHAR(45) NULL,
  `Version` VARCHAR(10) NULL,
  PRIMARY KEY (`EProduct_ID`),
  CONSTRAINT `fk_Ebooks_Product1`
    FOREIGN KEY (`EProduct_ID`)
    REFERENCES `mydb`.`Product` (`Product_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Advertiser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Advertiser` (
  `Card_ID` INT NULL,
  `ACompany_ID` INT NOT NULL,
  INDEX `fk_Advertiser_CardDetails1_idx` (`Card_ID` ASC),
  PRIMARY KEY (`ACompany_ID`),
  CONSTRAINT `fk_Advertiser_CardDetails1`
    FOREIGN KEY (`Card_ID`)
    REFERENCES `mydb`.`CardDetails` (`Card_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Advertiser_Company1`
    FOREIGN KEY (`ACompany_ID`)
    REFERENCES `mydb`.`Company` (`Company_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AdvertisementManager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AdvertisementManager` (
  `Manager_Emp_ID` INT NOT NULL,
  PRIMARY KEY (`Manager_Emp_ID`),
  CONSTRAINT `fk_AdvertisementManager_Employee1`
    FOREIGN KEY (`Manager_Emp_ID`)
    REFERENCES `mydb`.`Employee` (`Emp_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Advertisement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Advertisement` (
  `Advertisement_ID` INT NOT NULL AUTO_INCREMENT,
  `AdvName` VARCHAR(45) NULL,
  `PricePerHour` FLOAT NULL,
  `DurationInHoursPerWeek` FLOAT NULL,
  `Date` DATE NULL,
  `MultimediaLink` VARCHAR(100) NULL,
  `AdvStatus` VARCHAR(20) NULL,
  `ACompany_ID` INT NOT NULL,
  `AdvertisementManager_Manager_Emp_ID` INT NOT NULL,
  PRIMARY KEY (`Advertisement_ID`),
  INDEX `fk_Advertisement_Advertiser1_idx` (`ACompany_ID` ASC),
  INDEX `fk_Advertisement_AdvertisementManager1_idx` (`AdvertisementManager_Manager_Emp_ID` ASC),
  CONSTRAINT `fk_Advertisement_Advertiser1`
    FOREIGN KEY (`ACompany_ID`)
    REFERENCES `mydb`.`Advertiser` (`ACompany_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Advertisement_AdvertisementManager1`
    FOREIGN KEY (`AdvertisementManager_Manager_Emp_ID`)
    REFERENCES `mydb`.`AdvertisementManager` (`Manager_Emp_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Vendor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Vendor` (
  `Account_ID` INT NULL,
  `Company_Company_ID` INT NOT NULL,
  INDEX `fk_Vendor_AccountDetails1_idx` (`Account_ID` ASC),
  PRIMARY KEY (`Company_Company_ID`),
  CONSTRAINT `fk_Vendor_AccountDetails1`
    FOREIGN KEY (`Account_ID`)
    REFERENCES `mydb`.`AccountDetails` (`Account_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vendor_Company1`
    FOREIGN KEY (`Company_Company_ID`)
    REFERENCES `mydb`.`Company` (`Company_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`App`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`App` (
  `AProduct_ID` INT NOT NULL,
  PRIMARY KEY (`AProduct_ID`),
  INDEX `fk_App_Product1_idx` (`AProduct_ID` ASC),
  CONSTRAINT `fk_App_Product1`
    FOREIGN KEY (`AProduct_ID`)
    REFERENCES `mydb`.`Product` (`Product_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ProductReview`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ProductReview` (
  `Review_ID` INT NOT NULL,
  `User_ID` INT NOT NULL,
  `Product_ID` INT NOT NULL,
  `ReviewTitle` VARCHAR(30) NULL,
  `ReviewDescription` VARCHAR(200) NULL,
  `ReviewDate` DATETIME NULL,
  `ProdRating` FLOAT NULL,
  PRIMARY KEY (`Review_ID`),
  INDEX `fk_User_has_Product1_Product1_idx` (`Product_ID` ASC),
  INDEX `fk_User_has_Product1_User1_idx` (`User_ID` ASC),
  CONSTRAINT `fk_User_has_Product1_User1`
    FOREIGN KEY (`User_ID`)
    REFERENCES `mydb`.`User` (`User_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Product1_Product1`
    FOREIGN KEY (`Product_ID`)
    REFERENCES `mydb`.`Product` (`Product_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `mydb`.`User`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (1, '1', 'X', 'Beach', 'eget.nisi@nonfeugiatnec.co.uk', 'F', '1981-12-28', '1-718-180-3062', 'Banffshire', 'Portsoy', 'Germany');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (2, '2', 'M', 'George', 'Phasellus.ornare.Fusce@fringilla.com', 'M', '2000-04-01', '1-698-334-0061', 'North Island', 'Kerikeri', 'UK');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (3, '3', 'P', 'Mack', 'Phasellus@anteMaecenasmi.ca', 'M', '1982-10-14', '1-642-173-8547', 'West-Vlaanderen', 'Bossuit', 'USA');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (4, '4', 'O', 'Shaw', 'pharetra.Quisque.ac@NullafacilisiSed.co.uk', 'M', '1970-02-25', '1-158-671-3612', 'UP', 'Hathras', 'India');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (5, '5', 'I', 'Alston', 'mollis@gravidaAliquamtincidunt.org', 'F', '1963-05-28', '1-927-573-0319', 'Idaho', 'Boise', 'India');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (6, '6', 'O', 'Stone', 'consequat.auctor.nunc@etpedeNunc.net', 'F', '1959-10-14', '1-948-421-0499', 'Hamburg', 'Hamburg', 'China');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (7, '7', 'V', 'Rhodes', 'mus.Aenean.eget@In.co.uk', 'M', '2011-07-23', '1-503-960-5352', 'WI', 'Milwaukee', 'UK');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (8, '8', 'V', 'Dodson', 'ipsum.primis.in@luctus.net', 'F', '1955-10-21', '1-778-488-4489', 'LA', 'Lafayette', 'Australia');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (9, '9', 'M', 'Simpson', 'in@Aliquameratvolutpat.ca', 'F', '1994-08-01', '1-293-366-7832', 'Oklahoma', 'Lawton', 'Australia');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (10, '10', 'L', 'Zimmerman', 'mauris@enimcondimentum.co.uk', 'M', '1998-11-26', '1-859-611-3692', 'Basse-Normandie', 'Saint-Lô', 'Argentina');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (11, '11', 'Y', 'Pacheco', 'sapien@purusNullamscelerisque.co.uk', 'M', '1961-02-09', '1-505-850-3273', 'Minas Gerais', 'Sete Lagoas', 'USA');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (12, '12', 'G', 'Peterson', 'Nullam@elitdictum.ca', 'M', '1954-02-03', '1-267-419-0479', 'H', 'Ulloa (Barrial)', 'China');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (13, '13', 'Z', 'Glass', 'penatibus.et.magnis@arcu.ca', 'F', '1996-10-17', '1-327-907-1227', 'KN', 'Kano', 'Canada');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (14, '14', 'L', 'Schultz', 'Suspendisse.ac.metus@ornarelectus.co.uk', 'M', '1951-01-14', '1-846-597-5283', 'Wi', 'Vienna', 'Argentina');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (15, '15', 'B', 'Slater', 'amet.luctus@lacusvariuset.net', 'F', '2013-09-23', '1-242-738-9365', 'AB', 'Lacombe', 'Argentina');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (16, '16', 'M', 'Payne', 'auctor@natoque.com', 'M', '2014-05-18', '1-477-768-5477', 'TX', 'San Antonio', 'UK');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (17, '17', 'B', 'Knapp', 'Sed@Suspendissecommodo.co.uk', 'M', '2005-02-01', '1-301-886-8052', 'Zl', 'Middelburg', 'Argentina');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (18, '18', 'T', 'Rowe', 'nibh.Phasellus.nulla@Maecenasornareegestas.co.uk', 'F', '1983-12-02', '1-744-806-7145', 'KL', 'Allappuzha', 'Argentina');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (19, '19', 'U', 'Bird', 'sit.amet@posuereat.co.uk', 'M', '2002-09-22', '1-819-473-0811', 'WV', 'Ingooigem', 'Germany');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (20, '20', 'I', 'Copeland', 'orci@Craseutellus.co.uk', 'F', '1950-12-23', '1-565-216-4399', 'Pernambuco', 'Camaragibe', 'Brazil');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (21, '21', 'L', 'Dunn', 'pede.Cras.vulputate@veliteget.edu', 'M', '2012-11-01', '1-434-187-5604', 'QC', 'Montreal', 'Australia');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (22, '22', 'Y', 'Hansen', 'penatibus.et@augueeu.com', 'M', '1963-04-11', '1-346-410-7505', 'IL', 'Boulogne-Billancourt', 'Argentina');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (23, '23', 'W', 'Chen', 'arcu.vel.quam@metuseu.net', 'F', '1999-11-11', '1-988-141-4255', 'LU', 'Biała Podlaska', 'Australia');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (24, '24', 'K', 'Hawkins', 'lorem.eu@adipiscingnon.ca', 'F', '1959-12-17', '1-523-365-3206', 'GA', 'Georgia', 'Brazil');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (25, '25', 'T', 'Richards', 'leo.elementum.sem@facilisisSuspendisse.org', 'F', '2011-02-14', '1-828-716-8941', 'LI', 'Brive-la-Gaillarde', 'UK');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (26, '26', 'P', 'Rodgers', 'Nunc.ac@Quisque.net', 'M', '1986-08-18', '1-363-424-4934', 'CA', 'Fresno', 'Canada');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (27, '27', 'R', 'Munoz', 'sed@sedfacilisisvitae.co.uk', 'M', '1989-10-08', '1-261-907-0015', 'Ontario', 'East Gwillimbury', 'Argentina');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (28, '28', 'B', 'Buck', 'arcu.vel.quam@duiquis.edu', 'F', '2001-10-17', '1-117-520-4491', 'NT', 'Nottingham', 'USA');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (29, '29', 'Z', 'Rivera', 'eu.neque@feugiat.net', 'M', '1996-04-27', '1-225-774-8178', 'CA', 'Frigento', 'Canada');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (30, '30', 'F', 'Morris', 'lectus.justo.eu@augueidante.edu', 'F', '1995-01-02', '1-190-988-6770', 'C', 'Carmen', 'Australia');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (31, '31', 'J', 'Vance', 'aliquet.vel.vulputate@vestibulumneque.ca', 'F', '1990-04-13', '1-209-536-5577', 'Małopolskie', 'Kraków', 'China');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (32, '32', 'Z', 'Blevins', 'in.consectetuer@a.com', 'M', '1990-03-18', '1-749-431-4686', 'RF', 'Johnstone', 'Argentina');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (33, '33', 'V', 'Beard', 'nisi.Cum.sociis@tempusnon.org', 'F', '1967-11-18', '1-660-312-7322', 'Bihar', 'Patna', 'Brazil');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (34, '34', 'J', 'Valentine', 'ac@nonummy.ca', 'M', '2009-04-10', '1-508-540-9584', 'WB', 'Berhampore', 'USA');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (35, '35', 'L', 'Mccullough', 'dui.Cum.sociis@lobortis.com', 'M', '2003-07-17', '1-327-552-4335', 'HB', 'Bremerhaven', 'China');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (36, '36', 'U', 'Coffey', 'id@lorem.ca', 'F', '1962-02-03', '1-551-622-9329', 'LA', 'Sète', 'Canada');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (37, '37', 'T', 'Cochran', 'tellus.Aenean@tristiqueaceleifend.ca', 'M', '1994-07-01', '1-158-732-9389', 'North Island', 'Lower Hutt', 'USA');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (38, '38', 'Y', 'Townsend', 'a.sollicitudin@vitaealiquam.com', 'F', '1981-10-03', '1-974-221-9192', 'C', 'Carmen', 'Canada');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (39, '39', 'F', 'Richards', 'congue@luctus.co.uk', 'F', '1980-08-17', '1-705-598-6624', 'Maharastra', 'Malegaon', 'India');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (40, '40', 'T', 'Hunt', 'a@mollis.net', 'M', '1967-05-08', '1-848-471-3805', 'SP', 'Carapicuíba', 'USA');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (41, '41', 'H', 'Johnson', 'a.mi@interdumSed.org', 'F', '2004-01-14', '1-991-750-7626', 'Henegouwen', 'Froidchapelle', 'Brazil');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (42, '42', 'A', 'Warner', 'mollis.lectus@enimcondimentum.co.uk', 'F', '1957-08-25', '1-670-835-1674', 'IL', 'Aubervilliers', 'UK');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (43, '43', 'Q', 'Rhodes', 'semper.cursus.Integer@auctornon.ca', 'F', '1978-04-15', '1-180-683-3060', 'MH', 'Malegaon', 'Brazil');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (44, '44', 'O', 'Fuentes', 'lacinia.Sed@consequatauctornunc.net', 'F', '1961-10-11', '1-304-834-5855', 'NI', 'Hamilton', 'UK');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (45, '45', 'W', 'Maxwell', 'semper.auctor@bibendum.ca', 'F', '1989-01-17', '1-580-902-3537', 'CO', 'Denver', 'UK');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (46, '46', 'B', 'Buck', 'bibendum.Donec.felis@lacusQuisquepurus.co.uk', 'M', '1999-01-19', '1-876-767-9287', 'SI', 'Dunedin', 'India');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (47, '47', 'M', 'Bowman', 'eros.turpis@tristiqueneque.com', 'M', '1988-06-13', '1-184-821-0553', 'AN', 'Cádiz', 'India');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (48, '48', 'Z', 'Vaughn', 'placerat.augue.Sed@pedenonummy.com', 'F', '1963-06-26', '1-425-196-2646', 'VI', 'Horsham', 'Australia');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (49, '49', 'G', 'Dale', 'Donec@urna.com', 'M', '1972-07-09', '1-861-860-9619', 'Alajuela', 'San José de Alajuela', 'India');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (50, '50', 'Z', 'Strong', 'sem.ut@nonlobortis.net', 'F', '2000-07-27', '1-932-525-4115', 'WA', 'Stratford-upon-Avon', 'USA');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (51, '51', 'W', 'Schultz', 'odio.Phasellus.at@nonummyipsum.ca', 'M', '1976-03-24', '1-157-783-1773', 'Perthshire', 'Coupar Angus', 'Argentina');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (52, '52', 'K', 'Wiley', 'ut@metus.co.uk', 'M', '1992-05-07', '1-452-630-3442', 'ON', 'LaSalle', 'UK');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (53, '53', 'M', 'Mays', 'et.pede@molestie.org', 'M', '1983-09-19', '1-695-513-0420', 'SJ', 'San Isidro de El General', 'Brazil');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (54, '54', 'W', 'House', 'Duis.elementum@volutpatornare.co.uk', 'F', '1978-01-10', '1-641-177-6331', 'Ontario', 'Windsor', 'India');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (55, '55', 'R', 'Sandoval', 'Nunc@diam.com', 'F', '1994-12-12', '1-596-248-3559', 'MS', 'Hattiesburg', 'Argentina');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (56, '56', 'P', 'Snow', 'Maecenas@euodiotristique.org', 'M', '1970-06-11', '1-347-764-0783', 'MN', 'Duluth', 'USA');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (57, '57', 'K', 'Wynn', 'Nunc@libero.org', 'M', '1979-04-29', '1-670-126-6626', 'OY', 'Iseyin', 'Germany');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (58, '58', 'B', 'Blake', 'Aliquam.vulputate.ullamcorper@aodio.com', 'F', '1971-04-26', '1-831-111-7413', 'Gl', 'Hattem', 'Argentina');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (59, '59', 'L', 'Rivas', 'rutrum.urna@sed.com', 'F', '1967-01-20', '1-908-693-1579', 'Saxony', 'Mei�en', 'Germany');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (60, '60', 'B', 'Osborne', 'orci.quis@pellentesque.edu', 'F', '1975-12-30', '1-326-758-6236', 'SJ', 'Mata de Plátano', 'UK');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (61, '61', 'E', 'Aguirre', 'sem@Integer.com', 'M', '2012-05-10', '1-483-751-4327', 'VB', 'Hoeilaart', 'Germany');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (62, '62', 'U', 'Gordon', 'ligula.Aenean.gravida@enimmitempor.com', 'F', '1981-01-11', '1-249-522-8491', 'NS', 'Penrith', 'China');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (63, '63', 'D', 'Bell', 'libero.est@interdumfeugiat.com', 'M', '1968-02-22', '1-848-728-3799', 'HH', 'Hamburg', 'Australia');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (64, '64', 'Z', 'Moore', 'Aliquam@CuraePhasellusornare.edu', 'M', '1956-07-03', '1-131-832-7684', 'Wi', 'Vienna', 'India');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (65, '65', 'N', 'Ray', 'diam@DonecestNunc.edu', 'F', '1984-05-17', '1-393-948-5457', 'OR', 'Portland', 'UK');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (66, '66', 'X', 'Weber', 'Suspendisse.tristique.neque@lectusquismassa.net', 'F', '2001-08-12', '1-340-977-3874', 'Pernambuco', 'Camaragibe', 'Brazil');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (67, '67', 'Q', 'Garner', 'sed@Donec.com', 'F', '1997-10-20', '1-790-274-3992', 'Radnorshire', 'Presteigne', 'China');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (68, '68', 'J', 'Johns', 'ac@neceleifendnon.net', 'M', '1990-12-15', '1-217-771-4881', 'Comunitat Valenciana', 'Elx', 'China');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (69, '69', 'U', 'Moses', 'Cum.sociis.natoque@egestas.net', 'M', '1974-06-25', '1-598-401-1098', 'QC', 'Rimouski', 'Brazil');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (70, '70', 'Y', 'Walter', 'nascetur.ridiculus.mus@lobortisquama.ca', 'F', '2005-03-25', '1-737-311-0143', 'San José', 'Tirrases', 'India');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (71, '71', 'J', 'Marsh', 'arcu.Nunc.mauris@blanditmattis.com', 'M', '2008-02-10', '1-645-914-4502', 'CA', 'Tarrasa', 'USA');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (72, '72', 'U', 'Weber', 'lorem@eteuismod.edu', 'F', '1959-10-28', '1-201-719-4520', 'WA', 'Solihull', 'Argentina');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (73, '73', 'N', 'Armstrong', 'lorem@arcu.com', 'M', '1950-12-04', '1-884-466-7727', 'RJ', 'Belford Roxo', 'China');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (74, '74', 'D', 'Witt', 'malesuada.augue@sollicitudina.org', 'F', '1977-05-02', '1-763-793-7732', 'Berlin', 'Berlin', 'Canada');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (75, '75', 'L', 'Branch', 'interdum.Curabitur.dictum@pedenec.org', 'F', '2004-07-10', '1-292-977-3437', 'LO', 'Corvino San Quirico', 'China');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (76, '76', 'H', 'Fuentes', 'sit@acipsumPhasellus.net', 'F', '1957-04-30', '1-537-363-6023', 'VI', 'Frankston', 'China');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (77, '77', 'G', 'Cohen', 'Lorem.ipsum@Donecporttitor.ca', 'F', '1961-12-19', '1-330-195-4850', 'NI', 'Huntly', 'Australia');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (78, '78', 'Q', 'Horton', 'fringilla@arcuVestibulum.net', 'M', '2012-05-09', '1-594-708-8226', 'LX', 'Nives', 'USA');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (79, '79', 'Q', 'Swanson', 'Morbi@Sedmalesuada.edu', 'F', '1981-12-18', '1-440-676-3590', 'Ontario', 'Pickering', 'Canada');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (80, '80', 'N', 'Velez', 'Suspendisse.sagittis@Fuscemi.ca', 'F', '1994-10-14', '1-499-163-9023', 'Rajasthan', 'Pali', 'Canada');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (81, '81', 'D', 'Cooley', 'luctus.lobortis@Vivamus.net', 'F', '1951-07-27', '1-499-962-1978', 'HH', 'Hamburg', 'Australia');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (82, '82', 'F', 'Gates', 'erat@auctorvelit.ca', 'F', '2000-11-23', '1-972-187-6205', 'Vienna', 'Vienna', 'Australia');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (83, '83', 'C', 'Knox', 'ultrices@Maurisvestibulum.edu', 'F', '1953-02-24', '1-848-584-6371', 'KN', 'Kano', 'Australia');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (84, '84', 'C', 'Love', 'mollis.vitae@necligulaconsectetuer.co.uk', 'F', '1992-04-05', '1-553-443-4038', 'SP', 'Guarulhos', 'Canada');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (85, '85', 'N', 'Ford', 'dis.parturient@inmagna.co.uk', 'M', '1957-04-02', '1-887-221-7897', 'SK', 'Weyburn', 'Brazil');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (86, '86', 'W', 'Wolfe', 'convallis.in@nulla.net', 'F', '2004-06-19', '1-653-117-7880', 'West-Vlaanderen', 'Sint-Kruis', 'India');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (87, '87', 'I', 'Head', 'nec.ante@DonecestNunc.edu', 'F', '1999-08-21', '1-692-737-5379', 'BO', 'Bama', 'Australia');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (88, '88', 'J', 'Reese', 'sit.amet@Mauris.org', 'M', '1951-08-24', '1-856-953-6272', 'Zeeland', 'Sluis', 'UK');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (89, '89', 'Q', 'Hall', 'dolor@luctussit.net', 'M', '1982-04-14', '1-531-544-2028', 'KO', 'Okene', 'Argentina');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (90, '90', 'A', 'Miranda', 'facilisis@Sed.org', 'M', '1998-03-06', '1-876-271-6746', 'Bahia', 'Feira de Santana', 'Canada');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (91, '91', 'Z', 'Lynn', 'pretium.aliquet.metus@Aeneaneget.ca', 'M', '1991-10-29', '1-509-509-6467', 'SJ', 'Mata de Plátano', 'UK');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (92, '92', 'D', 'Dillon', 'Integer.eu@etipsumcursus.com', 'M', '1958-04-23', '1-880-198-5066', 'Noord Holland', 'Edam', 'Canada');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (93, '93', 'G', 'Hooper', 'dui@velconvallis.ca', 'F', '1997-02-14', '1-668-527-4890', 'WL', 'Livingston', 'UK');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (94, '94', 'L', 'Ochoa', 'quis@vitaevelitegestas.edu', 'F', '2004-11-16', '1-705-671-0854', 'Andhra Pradesh', 'Anantapur', 'Argentina');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (95, '95', 'F', 'Haynes', 'Nullam.scelerisque@fringilla.co.uk', 'F', '1984-06-29', '1-118-591-7304', 'Vermont', 'South Burlington', 'USA');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (96, '96', 'T', 'Robles', 'et@sit.co.uk', 'F', '1968-12-30', '1-188-965-6382', 'BC', 'Nakusp', 'UK');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (97, '97', 'T', 'Hardin', 'lorem.eget.mollis@ettristique.com', 'F', '1986-09-25', '1-928-543-0957', 'Jigawa', 'Dutse', 'Germany');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (98, '98', 'Y', 'Miller', 'sem.eget@convallisconvallis.ca', 'F', '1961-10-31', '1-264-997-2794', 'Oklahoma', 'Broken Arrow', 'India');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (99, '99', 'H', 'Stanley', 'faucibus@auctor.co.uk', 'F', '1960-11-17', '1-466-528-0029', 'Sb', 'Sankt Johann im Pongau', 'India');
INSERT INTO `mydb`.`User` (`User_ID`, `Password`, `FirstName`, `LastName`, `EmailID`, `Gender`, `DateOfBirth`, `PhoneNumber`, `State`, `City`, `Country`) VALUES (100, '100', 'N', 'Gray', 'lorem.eu@lobortisquam.com', 'M', '1984-10-28', '1-840-662-4791', 'SO', 'Glastonbury', 'Argentina');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`CardDetails`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (1, 'Beach', '5370 9445 9606 0152', '2022-02-25', '996', 'Banffshire,Portsoy,Somalia', 'Discover');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (2, 'George', '5479 0864 6570 8600', '2028-01-03', '415', 'North Island,Kerikeri,Ireland', 'Discover');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (3, 'Mack', '5544 8931 7884 0757', '2027-06-01', '673', 'West-Vlaanderen,Bossuit,Palestine, State of', 'American Express');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (4, 'Shaw', '5410 8485 0147 7025', '2026-01-18', '844', 'UP,Hathras,Romania', 'Maestro');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (5, 'Alston', '5526 8359 5051 8178', '2029-11-10', '825', 'Idaho,Boise,Brazil', 'American Express');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (6, 'Stone', '5173 8925 4145 3320', '2022-03-10', '400', 'Hamburg,Hamburg,Côte D\'Ivoire (Ivory Coast)', 'Discover');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (7, 'Rhodes', '5525 4660 2819 5715', '2027-01-24', '252', 'WI,Milwaukee,Eritrea', 'Maestro');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (8, 'Dodson', '5186 5699 2384 2321', '2025-01-01', '725', 'LA,Lafayette,Virgin Islands, United States', 'Visa');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (9, 'Simpson', '5160 1952 8718 3415', '2029-02-06', '339', 'Oklahoma,Lawton,Moldova', 'Visa');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (10, 'Zimmerman', '5488 6511 3549 4367', '2021-11-29', '469', 'Basse-Normandie,Saint-Lô,Andorra', 'MasterCard');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (11, 'Pacheco', '5540 5109 4203 4277', '2027-05-04', '599', 'Minas Gerais,Sete Lagoas,Bahrain', 'Discover');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (12, 'Peterson', '5283 9109 8274 6700', '2025-03-24', '694', 'H,Ulloa (Barrial),Benin', 'MasterCard');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (13, 'Glass', '5299 5773 1318 7979', '2023-07-23', '847', 'KN,Kano,Burkina Faso', 'American Express');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (14, 'Schultz', '5420 8640 5000 6444', '2025-06-03', '450', 'Wi,Vienna,Bosnia and Herzegovina', 'Maestro');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (15, 'Slater', '5554 4067 1858 6496', '2022-11-01', '463', 'AB,Lacombe,Uganda', 'Visa');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (16, 'Payne', '5559 1960 5193 6813', '2029-01-11', '856', 'TX,San Antonio,Tonga', 'Discover');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (17, 'Knapp', '5116 0759 2148 3097', '2028-11-19', '921', 'Zl,Middelburg,Anguilla', 'American Express');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (18, 'Rowe', '5337 4898 0009 8657', '2024-02-28', '127', 'KL,Allappuzha,Croatia', 'Visa');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (19, 'Bird', '5235 8886 0004 1762', '2026-09-16', '722', 'WV,Ingooigem,Sint Maarten', 'Maestro');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (20, 'Copeland', '5348 2059 8903 3894', '2025-11-10', '534', 'Pernambuco,Camaragibe,Ukraine', 'American Express');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (21, 'Dunn', '5133 6582 7669 2765', '2029-10-09', '443', 'QC,Montreal,Slovenia', 'American Express');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (22, 'Hansen', '5412 6925 0744 7592', '2026-10-21', '375', 'IL,Boulogne-Billancourt,Liechtenstein', 'Discover');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (23, 'Chen', '5428 4692 1086 9210', '2022-12-06', '950', 'LU,Biała Podlaska,Cambodia', 'Discover');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (24, 'Hawkins', '5273 1284 7496 7112', '2026-10-10', '462', 'GA,Georgia,United States', 'Visa');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (25, 'Richards', '5461 9739 7006 6543', '2028-10-24', '432', 'LI,Brive-la-Gaillarde,Mauritius', 'American Express');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (26, 'Rodgers', '5268 5713 5386 6326', '2030-03-24', '362', 'CA,Fresno,Singapore', 'MasterCard');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (27, 'Munoz', '5462 4235 6758 4432', '2021-09-22', '909', 'Ontario,East Gwillimbury,Saint Helena, Ascension and Tristan da Cunha', 'Visa');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (28, 'Buck', '5171 3975 8887 8860', '2027-12-30', '790', 'NT,Nottingham,Netherlands', 'Visa');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (29, 'Rivera', '5483 2506 3588 6530', '2026-12-25', '633', 'CA,Frigento,Norfolk Island', 'MasterCard');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (30, 'Morris', '5397 8284 2039 5042', '2021-07-28', '591', 'C,Carmen,Trinidad and Tobago', 'Maestro');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (31, 'Vance', '5125 2565 5255 2629', '2023-03-09', '232', 'Małopolskie,Kraków,Jamaica', 'MasterCard');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (32, 'Blevins', '5375 2968 6291 7606', '2027-12-24', '959', 'RF,Johnstone,Andorra', 'American Express');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (33, 'Beard', '5576 2165 8944 3345', '2030-04-14', '700', 'Bihar,Patna,Iceland', 'Discover');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (34, 'Valentine', '5448 1676 5752 3417', '2029-10-05', '635', 'WB,Berhampore,Czech Republic', 'Discover');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (35, 'Mccullough', '5195 8884 7324 3246', '2023-04-04', '436', 'HB,Bremerhaven,Montserrat', 'American Express');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (36, 'Coffey', '5295 1462 2229 7909', '2027-08-28', '314', 'LA,Sète,Korea, South', 'American Express');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (37, 'Cochran', '5418 8726 0962 9776', '2028-02-17', '919', 'North Island,Lower Hutt,Libya', 'American Express');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (38, 'Townsend', '5179 8822 7861 4164', '2026-02-06', '386', 'C,Carmen,Taiwan', 'Discover');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (39, 'Richards', '5547 7256 1195 2145', '2024-05-06', '810', 'Maharastra,Malegaon,Saint Vincent and The Grenadines', 'Maestro');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (40, 'Hunt', '5344 0394 9887 4421', '2026-08-29', '957', 'SP,Carapicuíba,Guatemala', 'Discover');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (41, 'Johnson', '5562 9076 0886 9538', '2025-07-14', '806', 'Henegouwen,Froidchapelle,Azerbaijan', 'MasterCard');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (42, 'Warner', '5187 3778 8603 7650', '2024-03-20', '526', 'IL,Aubervilliers,French Guiana', 'Visa');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (43, 'Rhodes', '5328 2014 3130 6297', '2024-03-16', '487', 'MH,Malegaon,Aruba', 'MasterCard');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (44, 'Fuentes', '5208 1681 8821 6927', '2026-08-12', '608', 'NI,Hamilton,San Marino', 'American Express');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (45, 'Maxwell', '5185 9512 3813 2195', '2029-02-08', '347', 'CO,Denver,Liberia', 'Visa');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (46, 'Buck', '5102 1074 0757 4424', '2023-12-23', '718', 'SI,Dunedin,Anguilla', 'MasterCard');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (47, 'Bowman', '5204 6002 1964 4861', '2030-03-26', '493', 'AN,Cádiz,Chile', 'Visa');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (48, 'Vaughn', '5567 1995 5848 7199', '2026-02-17', '946', 'VI,Horsham,Guernsey', 'MasterCard');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (49, 'Dale', '5350 8328 8853 5672', '2023-10-03', '490', 'Alajuela,San José de Alajuela,Bolivia', 'Maestro');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (50, 'Strong', '5415 0196 1216 0521', '2022-11-29', '784', 'WA,Stratford-upon-Avon,South Georgia and The South Sandwich Islands', 'Visa');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (51, 'Schultz', '5529 9191 5226 4190', '2020-12-31', '206', 'Perthshire,Coupar Angus,Cocos (Keeling) Islands', 'Visa');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (52, 'Wiley', '5482 6905 4007 1143', '2027-11-17', '998', 'ON,LaSalle,Russian Federation', 'Discover');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (53, 'Mays', '5459 5501 2805 5224', '2030-05-07', '703', 'SJ,San Isidro de El General,United Kingdom (Great Britain)', 'MasterCard');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (54, 'House', '5123 9029 8218 1495', '2030-05-26', '250', 'Ontario,Windsor,Croatia', 'MasterCard');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (55, 'Sandoval', '5505 1853 5596 4006', '2025-02-01', '555', 'MS,Hattiesburg,Guinea', 'MasterCard');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (56, 'Snow', '5205 2760 1479 6229', '2021-04-27', '457', 'MN,Duluth,Trinidad and Tobago', 'Maestro');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (57, 'Wynn', '5266 3871 2835 0823', '2022-02-07', '177', 'OY,Iseyin,Saudi Arabia', 'Maestro');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (58, 'Blake', '5142 5093 1074 4006', '2025-10-15', '441', 'Gl,Hattem,Kenya', 'Visa');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (59, 'Rivas', '5239 6426 0511 2847', '2022-03-01', '257', 'Saxony,Mei�en,Bouvet Island', 'Maestro');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (60, 'Osborne', '5355 3010 3634 0802', '2030-04-13', '828', 'SJ,Mata de Plátano,Bosnia and Herzegovina', 'MasterCard');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (61, 'Aguirre', '5516 4460 6537 5405', '2028-01-31', '594', 'VB,Hoeilaart,Bolivia', 'Visa');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (62, 'Gordon', '5460 4241 8772 3824', '2027-05-26', '764', 'NS,Penrith,Niger', 'Maestro');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (63, 'Bell', '5131 9612 0019 9507', '2024-04-23', '556', 'HH,Hamburg,Papua New Guinea', 'American Express');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (64, 'Moore', '5575 1312 0442 0175', '2030-03-23', '470', 'Wi,Vienna,Trinidad and Tobago', 'MasterCard');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (65, 'Ray', '5595 9672 0747 7241', '2025-09-14', '141', 'OR,Portland,Guinea', 'Maestro');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (66, 'Weber', '5297 0418 3244 2458', '2027-08-26', '320', 'Pernambuco,Camaragibe,French Guiana', 'MasterCard');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (67, 'Garner', '5486 0184 1179 9509', '2029-10-15', '193', 'Radnorshire,Presteigne,El Salvador', 'MasterCard');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (68, 'Johns', '5570 1184 6451 5385', '2029-02-25', '299', 'Comunitat Valenciana,Elx,Brunei', 'Visa');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (69, 'Moses', '5125 1628 3592 1922', '2029-11-06', '472', 'QC,Rimouski,Hungary', 'Maestro');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (70, 'Walter', '5120 9381 3855 2802', '2027-10-24', '644', 'San José,Tirrases,Tokelau', 'Visa');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (71, 'Marsh', '5292 0878 1135 0746', '2022-07-10', '206', 'CA,Tarrasa,Saudi Arabia', 'Visa');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (72, 'Weber', '5526 6220 1787 6918', '2029-11-05', '688', 'WA,Solihull,Lithuania', 'MasterCard');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (73, 'Armstrong', '5161 8350 7995 2431', '2029-11-17', '982', 'RJ,Belford Roxo,Colombia', 'Maestro');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (74, 'Witt', '5150 1329 7528 4785', '2029-03-09', '657', 'Berlin,Berlin,Canada', 'MasterCard');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (75, 'Branch', '5568 5916 6294 6830', '2030-05-29', '789', 'LO,Corvino San Quirico,Namibia', 'Visa');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (76, 'Fuentes', '5451 6932 3486 0349', '2024-10-20', '719', 'VI,Frankston,Tokelau', 'American Express');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (77, 'Cohen', '5153 6314 8529 2037', '2024-10-27', '335', 'NI,Huntly,Haiti', 'Maestro');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (78, 'Horton', '5525 8858 6744 1577', '2029-12-18', '990', 'LX,Nives,Thailand', 'Visa');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (79, 'Swanson', '5267 1874 7295 3753', '2024-09-14', '544', 'Ontario,Pickering,Gabon', 'Visa');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (80, 'Velez', '5477 4708 6383 7090', '2026-12-12', '947', 'Rajasthan,Pali,Christmas Island', 'MasterCard');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (81, 'Cooley', '5359 5197 6665 7998', '2026-03-02', '520', 'HH,Hamburg,Yemen', 'Maestro');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (82, 'Gates', '5261 3057 1277 7057', '2023-02-12', '691', 'Vienna,Vienna,Slovenia', 'MasterCard');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (83, 'Knox', '5172 1901 1361 2279', '2027-12-19', '988', 'KN,Kano,Serbia', 'MasterCard');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (84, 'Love', '5192 0006 1014 8279', '2027-11-29', '510', 'SP,Guarulhos,Timor-Leste', 'Maestro');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (85, 'Ford', '5114 1869 7054 0935', '2026-05-08', '720', 'SK,Weyburn,Greece', 'Visa');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (86, 'Wolfe', '5317 4256 7436 1692', '2030-05-14', '308', 'West-Vlaanderen,Sint-Kruis,Sweden', 'Maestro');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (87, 'Head', '5196 9810 2998 3008', '2028-04-28', '601', 'BO,Bama,Malta', 'Maestro');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (88, 'Reese', '5590 2226 1274 4511', '2029-05-17', '449', 'Zeeland,Sluis,United States', 'MasterCard');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (89, 'Hall', '5177 3523 6599 8831', '2022-04-17', '517', 'KO,Okene,Paraguay', 'Maestro');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (90, 'Miranda', '5446 7631 3590 4492', '2024-04-16', '356', 'Bahia,Feira de Santana,Comoros', 'Visa');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (91, 'Lynn', '5424 6719 1464 5390', '2027-11-29', '324', 'SJ,Mata de Plátano,Uruguay', 'MasterCard');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (92, 'Dillon', '5344 6110 5916 6973', '2022-07-16', '797', 'Noord Holland,Edam,Finland', 'Visa');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (93, 'Hooper', '5181 8154 3675 1524', '2026-01-05', '225', 'WL,Livingston,Australia', 'American Express');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (94, 'Ochoa', '5329 7382 6666 1352', '2022-12-15', '983', 'Andhra Pradesh,Anantapur,Sri Lanka', 'Maestro');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (95, 'Haynes', '5493 7018 7573 0489', '2022-12-14', '842', 'Vermont,South Burlington,Antarctica', 'MasterCard');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (96, 'Robles', '5107 1945 7285 4489', '2028-12-13', '389', 'BC,Nakusp,Micronesia', 'Discover');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (97, 'Hardin', '5164 1805 9698 9054', '2023-05-29', '309', 'Jigawa,Dutse,Panama', 'Maestro');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (98, 'Miller', '5593 8085 8106 9414', '2023-07-07', '980', 'Oklahoma,Broken Arrow,Venezuela', 'MasterCard');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (99, 'Stanley', '5369 2109 4394 8371', '2023-03-24', '997', 'Sb,Sankt Johann im Pongau,Zambia', 'American Express');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (100, 'Gray', '5592 7783 9794 4251', '2023-01-13', '917', 'SO,Glastonbury,Netherlands', 'American Express');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (101, 'Aimee', '5402 9696 2184 7028', '2024-12-18', '590', 'Ap #413-1481 Non Av.', 'American Express');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (102, 'Danielle', '5437 1541 7350 0262', '2021-03-21', '872', 'Ap #780-8412 Id St.', 'MasterCard');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (103, 'Sonya', '5248 8308 1113 1227', '2022-04-05', '167', '6217 Vitae Rd.', 'American Express');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (104, 'Marny', '5349 7931 0422 4570', '2024-10-05', '357', 'P.O. Box 509, 1470 Nullam Avenue', 'Visa');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (105, 'Miriam', '5504 6306 2142 0706', '2024-10-12', '719', '505-1028 Nunc Ave', 'American Express');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (106, 'Odette', '5100 9930 0186 8649', '2025-02-17', '651', 'Ap #834-7621 Diam Street', 'Visa');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (107, 'Tatum', '5574 3740 6950 5844', '2025-01-27', '685', 'Ap #885-3883 Sociosqu Ave', 'MasterCard');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (108, 'Stewart', '5108 7288 2225 3643', '2025-07-06', '679', '115-499 At St.', 'Visa');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (109, 'Jasper', '5472 0031 8978 6520', '2021-11-19', '786', '365-3802 Arcu. Rd.', 'MasterCard');
INSERT INTO `mydb`.`CardDetails` (`Card_ID`, `CardName`, `CardNumber`, `ExpiryDate`, `CVV`, `BillingAddress`, `CardType`) VALUES (110, 'Jamalia', '5577 8253 5794 4935', '2027-06-30', '470', 'P.O. Box 167, 8476 Molestie. Street', 'MasterCard');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Company`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Company` (`Company_ID`, `CompanyName`, `CompanyPassword`, `CompanyEmailId`, `TypeV`, `TypeA`) VALUES (1, 'Gameloft', 'blgfeiw', 'Gameloft@gmail.com', 'V', 'A');
INSERT INTO `mydb`.`Company` (`Company_ID`, `CompanyName`, `CompanyPassword`, `CompanyEmailId`, `TypeV`, `TypeA`) VALUES (2, 'Glu', 'gweerg', 'Glu@gmail.com', 'V', NULL);
INSERT INTO `mydb`.`Company` (`Company_ID`, `CompanyName`, `CompanyPassword`, `CompanyEmailId`, `TypeV`, `TypeA`) VALUES (3, 'Google', 'fdw343', 'Google@gmail.com', 'V', 'A');
INSERT INTO `mydb`.`Company` (`Company_ID`, `CompanyName`, `CompanyPassword`, `CompanyEmailId`, `TypeV`, `TypeA`) VALUES (4, 'Microsoft', '23fe3f3', 'Microsoft@gmail.com', 'V', NULL);
INSERT INTO `mydb`.`Company` (`Company_ID`, `CompanyName`, `CompanyPassword`, `CompanyEmailId`, `TypeV`, `TypeA`) VALUES (5, 'WB', 'e345r3', 'WB@gmail.com', 'V', NULL);
INSERT INTO `mydb`.`Company` (`Company_ID`, `CompanyName`, `CompanyPassword`, `CompanyEmailId`, `TypeV`, `TypeA`) VALUES (6, 'Lionsgate', 'r3345f43', 'Lionsgate@gmail.com', 'V', NULL);
INSERT INTO `mydb`.`Company` (`Company_ID`, `CompanyName`, `CompanyPassword`, `CompanyEmailId`, `TypeV`, `TypeA`) VALUES (7, 'SonyMusic', '345fe43', 'SonyMusic@gmail.com', 'V', NULL);
INSERT INTO `mydb`.`Company` (`Company_ID`, `CompanyName`, `CompanyPassword`, `CompanyEmailId`, `TypeV`, `TypeA`) VALUES (8, 'Tseries', 'f3453f3', 'Tseries@gmail.com', 'V', NULL);
INSERT INTO `mydb`.`Company` (`Company_ID`, `CompanyName`, `CompanyPassword`, `CompanyEmailId`, `TypeV`, `TypeA`) VALUES (9, 'Princeton', '34rfewy34', 'Princeton@gmail.com', 'V', NULL);
INSERT INTO `mydb`.`Company` (`Company_ID`, `CompanyName`, `CompanyPassword`, `CompanyEmailId`, `TypeV`, `TypeA`) VALUES (10, 'Amazon', 'g3t2345f', 'Amazon@gmail.com', 'V', 'A');
INSERT INTO `mydb`.`Company` (`Company_ID`, `CompanyName`, `CompanyPassword`, `CompanyEmailId`, `TypeV`, `TypeA`) VALUES (11, 'Walmart', '35eghwy3t', 'Walmart@gmail.com', NULL, 'A');
INSERT INTO `mydb`.`Company` (`Company_ID`, `CompanyName`, `CompanyPassword`, `CompanyEmailId`, `TypeV`, `TypeA`) VALUES (12, 'Facebook', 'gr3453w', 'Facebook@gmail.com', NULL, 'A');
INSERT INTO `mydb`.`Company` (`Company_ID`, `CompanyName`, `CompanyPassword`, `CompanyEmailId`, `TypeV`, `TypeA`) VALUES (13, 'Apple', 't3twtew', 'Apple@gmail.com', NULL, 'A');
INSERT INTO `mydb`.`Company` (`Company_ID`, `CompanyName`, `CompanyPassword`, `CompanyEmailId`, `TypeV`, `TypeA`) VALUES (14, 'HTC', '3543tew454', 'HTC@gmail.com', NULL, 'A');
INSERT INTO `mydb`.`Company` (`Company_ID`, `CompanyName`, `CompanyPassword`, `CompanyEmailId`, `TypeV`, `TypeA`) VALUES (15, 'Honda', 't432t4w', 'Honda@gmail.com', NULL, 'A');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`AccountDetails`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`AccountDetails` (`Account_ID`, `AccountNumber`, `BankName`, `RoutingNumber`, `AccountType`, `CheckingNumber`) VALUES (1, 'HU562811894337769840', 'Santander', '755086360', 'Savings', '3113147979');
INSERT INTO `mydb`.`AccountDetails` (`Account_ID`, `AccountNumber`, `BankName`, `RoutingNumber`, `AccountType`, `CheckingNumber`) VALUES (2, 'AZ08256573226043314', 'Santander', '775966688', 'Savings', '6532902267');
INSERT INTO `mydb`.`AccountDetails` (`Account_ID`, `AccountNumber`, `BankName`, `RoutingNumber`, `AccountType`, `CheckingNumber`) VALUES (3, 'MC8521973252450342625713967', 'Bank of China', '885668575', 'Savings', '1664459452');
INSERT INTO `mydb`.`AccountDetails` (`Account_ID`, `AccountNumber`, `BankName`, `RoutingNumber`, `AccountType`, `CheckingNumber`) VALUES (4, 'IT642DJANI88917903320447441', 'Bank of America', '440714648', 'Checking', '2637451748');
INSERT INTO `mydb`.`AccountDetails` (`Account_ID`, `AccountNumber`, `BankName`, `RoutingNumber`, `AccountType`, `CheckingNumber`) VALUES (5, 'AZ10238543312158869127301055', 'Santander', '766257664', 'Checking', '6722920464');
INSERT INTO `mydb`.`AccountDetails` (`Account_ID`, `AccountNumber`, `BankName`, `RoutingNumber`, `AccountType`, `CheckingNumber`) VALUES (6, 'VG8921586376843614280006', 'Bank of China', '415750980', 'Savings', '5797129016');
INSERT INTO `mydb`.`AccountDetails` (`Account_ID`, `AccountNumber`, `BankName`, `RoutingNumber`, `AccountType`, `CheckingNumber`) VALUES (7, 'FR5676380510227366893861421', 'Bank of China', '825634810', 'Checking', '5875415703');
INSERT INTO `mydb`.`AccountDetails` (`Account_ID`, `AccountNumber`, `BankName`, `RoutingNumber`, `AccountType`, `CheckingNumber`) VALUES (8, 'SE6149699401668390853180', 'Santander', '882815952', 'Checking', '2982907239');
INSERT INTO `mydb`.`AccountDetails` (`Account_ID`, `AccountNumber`, `BankName`, `RoutingNumber`, `AccountType`, `CheckingNumber`) VALUES (9, 'PK1980147228605490356591', 'Citibank', '108829146', 'Savings', '2846153560');
INSERT INTO `mydb`.`AccountDetails` (`Account_ID`, `AccountNumber`, `BankName`, `RoutingNumber`, `AccountType`, `CheckingNumber`) VALUES (10, 'TN4455014454617633023992', 'Bank of America', '457257118', 'Checking', '3586958358');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Employee`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Employee` (`Emp_ID`, `EmpName`, `EmpDept`, `EmpType`, `Salary`) VALUES (1, 'Ashwin', 'System Administrator', NULL, 100000);
INSERT INTO `mydb`.`Employee` (`Emp_ID`, `EmpName`, `EmpDept`, `EmpType`, `Salary`) VALUES (2, 'Vinay', 'Tester', 'T', 90000);
INSERT INTO `mydb`.`Employee` (`Emp_ID`, `EmpName`, `EmpDept`, `EmpType`, `Salary`) VALUES (3, 'Xingyang', 'Advertisement Manager', 'A', 80000);
INSERT INTO `mydb`.`Employee` (`Emp_ID`, `EmpName`, `EmpDept`, `EmpType`, `Salary`) VALUES (4, 'Shaine', 'Finance Manager', NULL, 70000);
INSERT INTO `mydb`.`Employee` (`Emp_ID`, `EmpName`, `EmpDept`, `EmpType`, `Salary`) VALUES (5, 'Tanmay', 'HR Manager', NULL, 60000);
INSERT INTO `mydb`.`Employee` (`Emp_ID`, `EmpName`, `EmpDept`, `EmpType`, `Salary`) VALUES (6, 'Prateek', 'Data Analyst', NULL, 80000);
INSERT INTO `mydb`.`Employee` (`Emp_ID`, `EmpName`, `EmpDept`, `EmpType`, `Salary`) VALUES (7, 'Mayuresh', 'Tester', 'T', 90000);
INSERT INTO `mydb`.`Employee` (`Emp_ID`, `EmpName`, `EmpDept`, `EmpType`, `Salary`) VALUES (8, 'Jack', 'Finance Manager', NULL, 70000);
INSERT INTO `mydb`.`Employee` (`Emp_ID`, `EmpName`, `EmpDept`, `EmpType`, `Salary`) VALUES (9, 'John', 'Data Analyst', NULL, 80000);
INSERT INTO `mydb`.`Employee` (`Emp_ID`, `EmpName`, `EmpDept`, `EmpType`, `Salary`) VALUES (10, 'Rose', 'HR Manager', NULL, 60000);
INSERT INTO `mydb`.`Employee` (`Emp_ID`, `EmpName`, `EmpDept`, `EmpType`, `Salary`) VALUES (11, 'Lucy', 'Finance Manager', NULL, 70000);
INSERT INTO `mydb`.`Employee` (`Emp_ID`, `EmpName`, `EmpDept`, `EmpType`, `Salary`) VALUES (12, 'Lily', 'Data Analyst', NULL, 80000);
INSERT INTO `mydb`.`Employee` (`Emp_ID`, `EmpName`, `EmpDept`, `EmpType`, `Salary`) VALUES (13, 'Arnold', 'Advertisement Manager', 'A', 80000);
INSERT INTO `mydb`.`Employee` (`Emp_ID`, `EmpName`, `EmpDept`, `EmpType`, `Salary`) VALUES (14, 'Tony', 'Data Analyst', NULL, 80000);
INSERT INTO `mydb`.`Employee` (`Emp_ID`, `EmpName`, `EmpDept`, `EmpType`, `Salary`) VALUES (15, 'Stuart', 'Tester', 'T', 90000);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Tester`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Tester` (`TEmp_ID`) VALUES (2);
INSERT INTO `mydb`.`Tester` (`TEmp_ID`) VALUES (7);
INSERT INTO `mydb`.`Tester` (`TEmp_ID`) VALUES (15);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`CategoryGenre`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (1, 'Utillities', 'AP');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (2, 'Lifestyle', 'AP');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (3, 'Productivity', 'AP');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (4, 'Social Networking', 'AP');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (5, 'Photos and Videos', 'AP');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (6, 'Health and Fitness', 'AP');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (7, 'Shopping', 'AP');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (8, 'Music', 'AP');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (9, 'Travel', 'AP');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (10, 'Action', 'GA');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (11, 'Adventure', 'GA');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (12, 'Racing', 'GA');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (13, 'Casino', 'GA');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (14, 'Puzzle', 'GA');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (15, 'Strategy', 'GA');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (16, 'Sports', 'GA');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (17, 'Word', 'GA');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (18, 'Educational', 'GA');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (19, 'Thriller', 'EB');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (20, 'Business', 'EB');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (21, 'Fiction', 'EB');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (22, 'Cooking', 'EB');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (23, 'Computer and Technology', 'EB');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (24, 'History', 'EB');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (25, 'Romance', 'EB');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (26, 'Classical', 'MU');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (27, 'Blues', 'MU');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (28, 'Hiphop', 'MU');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (29, 'Folk', 'MU');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (30, 'Jazz', 'MU');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (31, 'Metal', 'MU');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (32, 'Pop', 'MU');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (33, 'Action', 'MO');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (34, 'Animation', 'MO');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (35, 'Crime', 'MO');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (36, 'Comedy', 'MO');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (37, 'Drama', 'MO');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (38, 'Horror', 'MO');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (39, 'Family', 'MO');
INSERT INTO `mydb`.`CategoryGenre` (`Category_ID`, `CategoryName`, `TypeOfProduct`) VALUES (40, 'Short Films', 'MO');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Product`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (1, 3, 4, 2, 'approved', 'Hangout', '', '', 'Google talk app.', 0, 'galaxy/filesystem/multimedia/Hangout', 'AP');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (2, 4, 4, 7, 'approved', 'Skype', '', '', 'Video Chatiing application', 2.99, 'galaxy/filesystem/multimedia/Skype', 'AP');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (3, 3, 1, 15, 'waitlisted', 'Google Voice', '', '', 'Free calls via google', 3.99, 'galaxy/filesystem/multimedia/Google Voice', 'AP');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (4, 3, 9, 7, 'on hold', 'Google Maps', '', '', 'Navigation tool', 0, 'galaxy/filesystem/multimedia/Google Maps', 'AP');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (5, 3, 8, 2, 'rejected', 'Google Music', '', '', 'Free Music player by google', 0.99, 'galaxy/filesystem/multimedia/Google Music', 'AP');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (6, 4, 1, 15, 'approved', 'Outlook', '', '', 'Email application', 1.49, 'galaxy/filesystem/multimedia/Outlook', 'AP');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (7, 4, 3, 7, 'approved', 'Office Mobile', '', '', 'Microsoft Office on mobile platform', 1, 'galaxy/filesystem/multimedia/Office Mobile', 'AP');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (8, 4, 3, 2, 'approved', 'OneNote', '', '', 'Productivity app for taking notes', 0, 'galaxy/filesystem/multimedia/OneNote', 'AP');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (9, 1, 12, 2, 'approved', 'Asphalt', '', '', 'Leading racing game , available for multiplayer', 2.99, 'galaxy/filesystem/multimedia/Asphalt', 'GA');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (10, 2, 11, 7, 'approved', 'Minion', '', '', 'fun loving game based on famous characters from despicable me ', 1.99, 'galaxy/filesystem/multimedia/Minion', 'GA');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (11, 1, 10, 15, 'waitlisted', 'Robocop', '', '', 'Action game on the movie character robocop', 0.99, 'galaxy/filesystem/multimedia/Robocop', 'GA');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (12, 2, 10, 7, 'on hold', 'Killshot', '', '', 'Shooting game customized for snipers', 0, 'galaxy/filesystem/multimedia/Killshot', 'GA');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (13, 1, 14, 2, 'rejected', 'Candycrush', '', '', 'best puzzle game ever', 0, 'galaxy/filesystem/multimedia/Candycrush', 'GA');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (14, 2, 16, 15, 'approved', 'Fifa2015', '', '', 'best football game by ea sports', 9.99, 'galaxy/filesystem/multimedia/Fifa2015', 'GA');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (15, 1, 17, 7, 'approved', 'Wordpuzzle', '', '', 'puzzle game for words lovers', 0, 'galaxy/filesystem/multimedia/Wordpuzzle', 'GA');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (16, 2, 15, 2, 'approved', 'Clash Of Titans', '', '', 'Stretegic game aimed for multiplayer', 0.99, 'galaxy/filesystem/multimedia/Clash Of Titans', 'GA');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (17, 9, 23, 2, 'approved', 'Modern Database Management', '', '', 'Covers concepts of database management systems', 44.99, 'galaxy/filesystem/multimedia/Modern Database Management', 'EB');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (18, 9, 23, 7, 'approved', 'Beginning MySQL', '', '', 'learn mysql from experts', 15.99, 'galaxy/filesystem/multimedia/Beginning MySQL', 'EB');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (19, 9, 23, 15, 'waitlisted', 'Beginning SQL', '', '', 'best book for beginners using sql language', 9.99, 'galaxy/filesystem/multimedia/Beginning SQL', 'EB');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (20, 10, 20, 7, 'on hold', 'Zero to One', '', '', 'a business book aimed for entrepreneurs', 5.99, 'galaxy/filesystem/multimedia/Zero to One', 'EB');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (21, 9, 20, 2, 'rejected', 'How Google Works', '', '', 'a brief working of google company', 0, 'galaxy/filesystem/multimedia/How Google Works', 'EB');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (22, 10, 19, 15, 'approved', 'Game of Thrones', '', '', 'thrilling story of seven kingdoms', 99.99, 'galaxy/filesystem/multimedia/Game of Thrones', 'EB');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (23, 10, 25, 7, 'approved', 'Fifty Shades of Grey', '', '', 'a romantic novel.', 29.99, 'galaxy/filesystem/multimedia/Fifty Shades of Grey', 'EB');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (24, 10, 22, 2, 'approved', '50 Best Worldwide Recipies', '', '', 'a compilation of worlds top 50 recipes by sanjay kapoor', 0, 'galaxy/filesystem/multimedia/50 Best Worldwide Recipies', 'EB');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (25, 7, 26, 2, 'approved', 'Opera', '', '', 'grammy award winner', 1.29, 'galaxy/filesystem/multimedia/Opera', 'MU');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (26, 8, 26, 7, 'approved', 'Symphonie', '', '', 'oscar winner', 1.39, 'galaxy/filesystem/multimedia/Symphonie', 'MU');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (27, 8, 28, 15, 'waitlisted', 'Gotti', '', '', 'filmfare winner', 1.49, 'galaxy/filesystem/multimedia/Gotti', 'MU');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (28, 7, 28, 7, 'on hold', 'Lifestyle', '', '', 'stardust winner', 1.99, 'galaxy/filesystem/multimedia/Lifestyle', 'MU');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (29, 8, 31, 2, 'rejected', 'Now we die', '', '', 'starparivar winner', 0, 'galaxy/filesystem/multimedia/Now we die', 'MU');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (30, 7, 31, 15, 'approved', 'Dreams', '', '', 'best choice for yongsters', 2.19, 'galaxy/filesystem/multimedia/Dreams', 'MU');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (31, 8, 27, 7, 'approved', 'Different Shades of Blue', '', '', 'made for blue lovers', 0, 'galaxy/filesystem/multimedia/Different Shades of Blue', 'MU');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (32, 8, 32, 2, 'approved', 'For You', '', '', 'romantic music at its best', 1.59, 'galaxy/filesystem/multimedia/For You', 'MU');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (33, 5, 33, 2, 'approved', 'Fast and Furious', '', '', 'best car movie series of this age', 19.99, 'galaxy/filesystem/multimedia/Fast and Furious', 'MO');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (34, 5, 34, 7, 'approved', 'Despicable Me', '', '', 'animated movie based on the story of a guy named gru', 25.99, 'galaxy/filesystem/multimedia/Despicable Me', 'MO');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (35, 6, 35, 15, 'waitlisted', 'Shawshank Redemption', '', '', 'a prison break story', 30.99, 'galaxy/filesystem/multimedia/Shawshank Redemption', 'MO');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (36, 6, 36, 7, 'on hold', 'Hangover', '', '', 'a fun story of a bachelor party gone wrong', 5.99, 'galaxy/filesystem/multimedia/Hangover', 'MO');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (37, 5, 38, 2, 'rejected', 'Insidious', '', '', 'nerve breaking horror movie', 10.99, 'galaxy/filesystem/multimedia/Insidious', 'MO');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (38, 6, 38, 15, 'approved', 'Annabelle', '', '', 'a horror movie based on true story of a doll', 0, 'galaxy/filesystem/multimedia/Annabelle', 'MO');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (39, 5, 39, 7, 'approved', 'Father and the bride', '', '', 'family drama revolving around a marriage', 0, 'galaxy/filesystem/multimedia/Father and the bride', 'MO');
INSERT INTO `mydb`.`Product` (`Product_ID`, `Company_ID`, `Category_ID`, `Tester_ID`, `Status`, `Name`, `AvgRating`, `NumberOfDownloads`, `Description`, `Price`, `MultimediaLink`, `ProductType`) VALUES (40, 6, 35, 2, 'approved', 'The Judge', '', '', 'Drama on relationship between father and the son', 5.99, 'galaxy/filesystem/multimedia/The Judge', 'MO');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Details`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (1, 1, 1);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (2, 2, 2);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (3, 3, 3);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (4, 4, 4);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (5, 5, 5);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (6, 6, 6);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (7, 7, 7);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (8, 8, 8);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (9, 9, 9);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (10, 10, 10);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (11, 11, 11);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (12, 12, 12);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (13, 13, 13);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (14, 14, 14);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (15, 15, 15);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (16, 16, 16);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (17, 17, 17);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (18, 18, 18);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (19, 19, 19);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (20, 20, 20);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (21, 21, 21);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (22, 22, 22);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (23, 23, 23);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (24, 24, 24);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (25, 25, 25);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (26, 26, 26);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (27, 27, 27);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (28, 28, 28);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (29, 29, 29);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (30, 30, 30);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (31, 31, 31);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (32, 32, 32);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (33, 33, 33);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (34, 34, 34);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (35, 35, 35);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (36, 36, 36);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (37, 37, 37);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (38, 38, 38);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (39, 39, 39);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (40, 40, 40);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (41, 41, 41);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (42, 42, 42);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (43, 43, 43);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (44, 44, 44);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (45, 45, 45);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (46, 46, 46);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (47, 47, 47);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (48, 48, 48);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (49, 49, 49);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (50, 50, 50);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (51, 51, 51);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (52, 52, 52);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (53, 53, 53);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (54, 54, 54);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (55, 55, 55);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (56, 56, 56);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (57, 57, 57);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (58, 58, 58);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (59, 59, 59);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (60, 60, 60);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (61, 61, 61);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (62, 62, 62);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (63, 63, 63);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (64, 64, 64);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (65, 65, 65);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (66, 66, 66);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (67, 67, 67);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (68, 68, 68);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (69, 69, 69);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (70, 70, 70);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (71, 71, 71);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (72, 72, 72);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (73, 73, 73);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (74, 74, 74);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (75, 75, 75);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (76, 76, 76);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (77, 77, 77);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (78, 78, 78);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (79, 79, 79);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (80, 80, 80);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (81, 81, 81);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (82, 82, 82);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (83, 83, 83);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (84, 84, 84);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (85, 85, 85);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (86, 86, 86);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (87, 87, 87);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (88, 88, 88);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (89, 89, 89);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (90, 90, 90);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (91, 91, 91);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (92, 92, 92);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (93, 93, 93);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (94, 94, 94);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (95, 95, 95);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (96, 96, 1);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (97, 97, 2);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (98, 98, 3);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (99, 99, 4);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (100, 100, 5);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (101, 1, 96);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (102, 2, 97);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (103, 3, 98);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (104, 4, 99);
INSERT INTO `mydb`.`Details` (`Details_ID`, `User_ID`, `Card_ID`) VALUES (105, 5, 100);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Version`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (1, '1.1.0', 'Android', 5.84, 'galaxy/filesystem/product/1/1.1.0', 'original app', '2009-01-26', 1);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (2, '1.1.31', 'Android', 63.23, 'galaxy/filesystem/product/16/1.1.31', 'bug fixes', '2009-01-26', 16);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (3, '1.1.1', 'Android', 6.2, 'galaxy/filesystem/product/1/1.1.1', 'bug fixes', '2009-03-24', 1);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (4, '4.1', 'All Platforms', 71.63, 'galaxy/filesystem/product/25/4.1', 'original version', '2009-03-24', 25);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (5, '2.1.0', 'IOS', 3.4, 'galaxy/filesystem/product/1/2.1.0', 'original app', '2009-04-21', 1);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (6, '4.1', 'All Platforms', 73.56, 'galaxy/filesystem/product/28/4.1', 'original version', '2009-04-21', 28);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (7, '2.1.2', 'IOS', 3.6, 'galaxy/filesystem/product/1/2.1.2', 'bug fixes', '2009-04-29', 1);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (8, '4.1', 'All Platforms', 76.79, 'galaxy/filesystem/product/33/4.1', 'original version', '2009-04-29', 33);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (9, '3.1.0', 'WindowsPhone', 8.6, 'galaxy/filesystem/product/1/3.1.0', 'original app', '2009-06-11', 1);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (10, '4.1', 'All Platforms', 80.02, 'galaxy/filesystem/product/38/4.1', 'original version', '2009-06-11', 38);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (11, '3.1.1', 'WindowsPhone', 8.88, 'galaxy/filesystem/product/1/3.1.1', 'bug fixes', '2009-07-16', 1);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (12, '1.1.2', 'Android', 8.35, 'galaxy/filesystem/product/2/1.1.2', 'original app', '2009-08-15', 2);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (13, '1.1.3', 'Android', 8.99, 'galaxy/filesystem/product/2/1.1.3', 'bug fixes', '2009-08-26', 2);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (14, '2.1.4', 'IOS', 9.64, 'galaxy/filesystem/product/2/2.1.4', 'original app', '2009-09-30', 2);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (15, '2.1.6', 'IOS', 10.28, 'galaxy/filesystem/product/2/2.1.6', 'bug fixes', '2009-10-09', 2);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (16, '3.1.2', 'WindowsPhone', 10.93, 'galaxy/filesystem/product/2/3.1.2', 'original app', '2009-10-27', 2);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (17, '3.1.3', 'WindowsPhone', 11.58, 'galaxy/filesystem/product/2/3.1.3', 'bug fixes', '2009-11-20', 2);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (18, '1.1.4', 'Android', 12.22, 'galaxy/filesystem/product/3/1.1.4', 'original app', '2009-12-14', 3);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (19, '1.1.5', 'Android', 12.87, 'galaxy/filesystem/product/3/1.1.5', 'bug fixes', '2009-12-21', 3);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (20, '2.1.8', 'IOS', 13.51, 'galaxy/filesystem/product/3/2.1.8', 'original app', '2009-12-25', 3);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (21, '2.1.10', 'IOS', 14.16, 'galaxy/filesystem/product/3/2.1.10', 'bug fixes', '2009-12-27', 3);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (22, '3.1.4', 'WindowsPhone', 14.8, 'galaxy/filesystem/product/3/3.1.4', 'original app', '2010-01-14', 3);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (23, '3.1.5', 'WindowsPhone', 15.45, 'galaxy/filesystem/product/3/3.1.5', 'bug fixes', '2010-02-15', 3);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (24, '2.1.62', 'IOS', 64.52, 'galaxy/filesystem/product/16/2.1.62', 'bug fixes', '2010-02-15', 16);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (25, '1.1.6', 'Android', 16.1, 'galaxy/filesystem/product/4/1.1.6', 'original app', '2010-03-14', 4);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (26, '4.1', 'All Platforms', 68.4, 'galaxy/filesystem/product/20/4.1', 'original version', '2010-03-14', 20);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (27, '1.1.7', 'Android', 16.74, 'galaxy/filesystem/product/4/1.1.7', 'bug fixes', '2010-03-21', 4);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (28, '4.1', 'All Platforms', 70.34, 'galaxy/filesystem/product/23/4.1', 'original version', '2010-03-21', 23);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (29, '2.1.12', 'IOS', 17.39, 'galaxy/filesystem/product/4/2.1.12', 'original app', '2010-04-27', 4);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (30, '4.1', 'All Platforms', 74.86, 'galaxy/filesystem/product/30/4.1', 'original version', '2010-04-27', 30);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (31, '2.1.14', 'IOS', 18.03, 'galaxy/filesystem/product/4/2.1.14', 'bug fixes', '2010-05-02', 4);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (32, '4.1', 'All Platforms', 77.44, 'galaxy/filesystem/product/34/4.1', 'original version', '2010-05-02', 34);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (33, '3.1.6', 'WindowsPhone', 18.68, 'galaxy/filesystem/product/4/3.1.6', 'original app', '2010-07-17', 4);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (34, '3.1.7', 'WindowsPhone', 19.32, 'galaxy/filesystem/product/4/3.1.7', 'bug fixes', '2010-09-11', 4);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (35, '1.1.8', 'Android', 19.97, 'galaxy/filesystem/product/5/1.1.8', 'original app', '2010-09-24', 5);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (36, '1.1.9', 'Android', 20.62, 'galaxy/filesystem/product/5/1.1.9', 'bug fixes', '2010-10-03', 5);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (37, '2.1.16', 'IOS', 21.26, 'galaxy/filesystem/product/5/2.1.16', 'original app', '2010-10-17', 5);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (38, '2.1.18', 'IOS', 21.91, 'galaxy/filesystem/product/5/2.1.18', 'bug fixes', '2010-11-01', 5);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (39, '3.1.8', 'WindowsPhone', 22.55, 'galaxy/filesystem/product/5/3.1.8', 'original app', '2010-11-10', 5);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (40, '3.1.9', 'WindowsPhone', 23.2, 'galaxy/filesystem/product/5/3.1.9', 'bug fixes', '2010-12-20', 5);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (41, '1.1.10', 'Android', 23.84, 'galaxy/filesystem/product/6/1.1.10', 'original app', '2010-12-30', 6);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (42, '1.1.11', 'Android', 24.49, 'galaxy/filesystem/product/6/1.1.11', 'bug fixes', '2011-03-02', 6);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (43, '3.1.31', 'WindowsPhone', 65.82, 'galaxy/filesystem/product/16/3.1.31', 'bug fixes', '2011-03-02', 16);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (44, '2.1.20', 'IOS', 25.14, 'galaxy/filesystem/product/6/2.1.20', 'original app', '2011-03-06', 6);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (45, '4.1', 'All Platforms', 66.46, 'galaxy/filesystem/product/17/4.1', 'original version', '2011-03-06', 17);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (46, '2.1.22', 'IOS', 25.78, 'galaxy/filesystem/product/6/2.1.22', 'bug fixes', '2011-03-16', 6);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (47, '4.1', 'All Platforms', 69.04, 'galaxy/filesystem/product/21/4.1', 'original version', '2011-03-16', 21);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (48, '3.1.10', 'WindowsPhone', 26.43, 'galaxy/filesystem/product/6/3.1.10', 'original app', '2011-04-28', 6);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (49, '4.1', 'All Platforms', 76.15, 'galaxy/filesystem/product/32/4.1', 'original version', '2011-04-28', 32);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (50, '3.1.11', 'WindowsPhone', 27.07, 'galaxy/filesystem/product/6/3.1.11', 'bug fixes', '2011-07-12', 6);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (51, '1.1.12', 'Android', 27.72, 'galaxy/filesystem/product/7/1.1.12', 'original app', '2011-07-15', 7);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (52, '1.1.13', 'Android', 28.36, 'galaxy/filesystem/product/7/1.1.13', 'bug fixes', '2011-07-19', 7);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (53, '2.1.24', 'IOS', 29.01, 'galaxy/filesystem/product/7/2.1.24', 'original app', '2011-08-01', 7);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (54, '2.1.26', 'IOS', 29.66, 'galaxy/filesystem/product/7/2.1.26', 'bug fixes', '2011-08-18', 7);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (55, '3.1.12', 'WindowsPhone', 30.3, 'galaxy/filesystem/product/7/3.1.12', 'original app', '2011-08-28', 7);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (56, '3.1.13', 'WindowsPhone', 30.95, 'galaxy/filesystem/product/7/3.1.13', 'bug fixes', '2011-09-15', 7);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (57, '1.1.14', 'Android', 31.59, 'galaxy/filesystem/product/8/1.1.14', 'original app', '2011-09-24', 8);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (58, '1.1.15', 'Android', 32.24, 'galaxy/filesystem/product/8/1.1.15', 'bug fixes', '2011-10-14', 8);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (59, '2.1.28', 'IOS', 32.88, 'galaxy/filesystem/product/8/2.1.28', 'original app', '2011-11-29', 8);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (60, '2.1.30', 'IOS', 33.53, 'galaxy/filesystem/product/8/2.1.30', 'bug fixes', '2011-12-06', 8);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (61, '3.1.14', 'WindowsPhone', 34.18, 'galaxy/filesystem/product/8/3.1.14', 'original app', '2011-12-15', 8);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (62, '3.1.15', 'WindowsPhone', 34.82, 'galaxy/filesystem/product/8/3.1.15', 'bug fixes', '2012-01-01', 8);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (63, '1.1.16', 'Android', 35.47, 'galaxy/filesystem/product/9/1.1.16', 'original app', '2012-02-19', 9);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (64, '3.1.30', 'WindowsPhone', 65.17, 'galaxy/filesystem/product/16/3.1.30', 'original app', '2012-02-19', 16);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (65, '1.1.17', 'Android', 36.11, 'galaxy/filesystem/product/9/1.1.17', 'bug fixes', '2012-04-20', 9);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (66, '4.1', 'All Platforms', 72.92, 'galaxy/filesystem/product/27/4.1', 'original version', '2012-04-20', 27);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (67, '2.1.32', 'IOS', 36.76, 'galaxy/filesystem/product/9/2.1.32', 'original app', '2012-05-21', 9);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (68, '4.1', 'All Platforms', 78.73, 'galaxy/filesystem/product/36/4.1', 'original version', '2012-05-21', 36);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (69, '2.1.34', 'IOS', 37.4, 'galaxy/filesystem/product/9/2.1.34', 'bug fixes', '2012-05-24', 9);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (70, '4.1', 'All Platforms', 79.38, 'galaxy/filesystem/product/37/4.1', 'original version', '2012-05-24', 37);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (71, '3.1.16', 'WindowsPhone', 38.05, 'galaxy/filesystem/product/9/3.1.16', 'original app', '2012-06-16', 9);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (72, '4.1', 'All Platforms', 80.67, 'galaxy/filesystem/product/39/4.1', 'original version', '2012-06-16', 39);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (73, '3.1.17', 'WindowsPhone', 38.7, 'galaxy/filesystem/product/9/3.1.17', 'bug fixes', '2012-07-11', 9);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (74, '1.1.18', 'Android', 39.34, 'galaxy/filesystem/product/10/1.1.18', 'original app', '2012-08-13', 10);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (75, '1.1.19', 'Android', 39.99, 'galaxy/filesystem/product/10/1.1.19', 'bug fixes', '2012-08-21', 10);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (76, '2.1.36', 'IOS', 40.63, 'galaxy/filesystem/product/10/2.1.36', 'original app', '2012-09-02', 10);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (77, '2.1.38', 'IOS', 41.28, 'galaxy/filesystem/product/10/2.1.38', 'bug fixes', '2012-10-17', 10);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (78, '3.1.18', 'WindowsPhone', 41.92, 'galaxy/filesystem/product/10/3.1.18', 'original app', '2012-10-31', 10);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (79, '3.1.19', 'WindowsPhone', 42.57, 'galaxy/filesystem/product/10/3.1.19', 'bug fixes', '2012-11-01', 10);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (80, '1.1.20', 'Android', 43.22, 'galaxy/filesystem/product/11/1.1.20', 'original app', '2012-11-22', 11);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (81, '1.1.21', 'Android', 43.86, 'galaxy/filesystem/product/11/1.1.21', 'bug fixes', '2012-11-28', 11);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (82, '2.1.40', 'IOS', 44.51, 'galaxy/filesystem/product/11/2.1.40', 'original app', '2013-01-04', 11);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (83, '2.1.42', 'IOS', 45.15, 'galaxy/filesystem/product/11/2.1.42', 'bug fixes', '2013-02-04', 11);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (84, '2.1.60', 'IOS', 63.88, 'galaxy/filesystem/product/16/2.1.60', 'original app', '2013-02-04', 16);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (85, '3.1.20', 'WindowsPhone', 45.8, 'galaxy/filesystem/product/11/3.1.20', 'original app', '2013-03-22', 11);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (86, '4.1', 'All Platforms', 70.98, 'galaxy/filesystem/product/24/4.1', 'original version', '2013-03-22', 24);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (87, '3.1.21', 'WindowsPhone', 46.44, 'galaxy/filesystem/product/11/3.1.21', 'bug fixes', '2013-04-27', 11);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (88, '4.1', 'All Platforms', 75.5, 'galaxy/filesystem/product/31/4.1', 'original version', '2013-04-27', 31);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (89, '1.1.22', 'Android', 47.09, 'galaxy/filesystem/product/12/1.1.22', 'original app', '2013-07-20', 12);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (90, '1.1.23', 'Android', 47.74, 'galaxy/filesystem/product/12/1.1.23', 'bug fixes', '2013-07-28', 12);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (91, '2.1.44', 'IOS', 48.38, 'galaxy/filesystem/product/12/2.1.44', 'original app', '2013-07-29', 12);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (92, '2.1.46', 'IOS', 49.03, 'galaxy/filesystem/product/12/2.1.46', 'bug fixes', '2013-08-16', 12);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (93, '3.1.22', 'WindowsPhone', 49.67, 'galaxy/filesystem/product/12/3.1.22', 'original app', '2013-08-22', 12);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (94, '3.1.23', 'WindowsPhone', 50.32, 'galaxy/filesystem/product/12/3.1.23', 'bug fixes', '2013-09-10', 12);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (95, '1.1.24', 'Android', 50.96, 'galaxy/filesystem/product/13/1.1.24', 'original app', '2013-09-22', 13);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (96, '1.1.25', 'Android', 51.61, 'galaxy/filesystem/product/13/1.1.25', 'bug fixes', '2013-12-03', 13);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (97, '2.1.48', 'IOS', 52.26, 'galaxy/filesystem/product/13/2.1.48', 'original app', '2013-12-05', 13);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (98, '2.1.50', 'IOS', 52.9, 'galaxy/filesystem/product/13/2.1.50', 'bug fixes', '2013-12-20', 13);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (99, '3.1.24', 'WindowsPhone', 53.55, 'galaxy/filesystem/product/13/3.1.24', 'original app', '2013-12-22', 13);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (100, '3.1.25', 'WindowsPhone', 54.19, 'galaxy/filesystem/product/13/3.1.25', 'bug fixes', '2014-01-25', 13);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (101, '1.1.26', 'Android', 54.84, 'galaxy/filesystem/product/14/1.1.26', 'original app', '2014-03-08', 14);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (102, '4.1', 'All Platforms', 67.11, 'galaxy/filesystem/product/18/4.1', 'original version', '2014-03-08', 18);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (103, '4.1', 'All Platforms', 67.75, 'galaxy/filesystem/product/19/4.1', 'original version', '2014-03-08', 19);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (104, '4.1', 'All Platforms', 69.69, 'galaxy/filesystem/product/22/4.1', 'original version', '2014-03-20', 22);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (105, '1.1.27', 'Android', 55.48, 'galaxy/filesystem/product/14/1.1.27', 'bug fixes', '2014-03-26', 14);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (106, '4.1', 'All Platforms', 72.27, 'galaxy/filesystem/product/26/4.1', 'original version', '2014-03-26', 26);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (107, '2.1.52', 'IOS', 56.13, 'galaxy/filesystem/product/14/2.1.52', 'original app', '2014-04-22', 14);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (108, '4.1', 'All Platforms', 74.21, 'galaxy/filesystem/product/29/4.1', 'original version', '2014-04-22', 29);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (109, '2.1.54', 'IOS', 56.78, 'galaxy/filesystem/product/14/2.1.54', 'bug fixes', '2014-05-14', 14);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (110, '4.1', 'All Platforms', 78.08, 'galaxy/filesystem/product/35/4.1', 'original version', '2014-05-14', 35);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (111, '3.1.26', 'WindowsPhone', 57.42, 'galaxy/filesystem/product/14/3.1.26', 'original app', '2014-06-26', 14);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (112, '4.1', 'All Platforms', 81.31, 'galaxy/filesystem/product/40/4.1', 'original version', '2014-06-26', 40);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (113, '3.1.27', 'WindowsPhone', 58.07, 'galaxy/filesystem/product/14/3.1.27', 'bug fixes', '2014-07-01', 14);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (114, '1.1.28', 'Android', 58.71, 'galaxy/filesystem/product/15/1.1.28', 'original app', '2014-09-07', 15);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (115, '1.1.29', 'Android', 59.36, 'galaxy/filesystem/product/15/1.1.29', 'bug fixes', '2014-10-16', 15);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (116, '2.1.56', 'IOS', 60, 'galaxy/filesystem/product/15/2.1.56', 'original app', '2014-10-26', 15);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (117, '2.1.58', 'IOS', 60.65, 'galaxy/filesystem/product/15/2.1.58', 'bug fixes', '2014-11-21', 15);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (118, '3.1.28', 'WindowsPhone', 61.3, 'galaxy/filesystem/product/15/3.1.28', 'original app', '2014-11-28', 15);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (119, '3.1.29', 'WindowsPhone', 61.94, 'galaxy/filesystem/product/15/3.1.29', 'bug fixes', '2014-12-05', 15);
INSERT INTO `mydb`.`Version` (`Version_ID`, `VersionNumber`, `MobileOS`, `Size`, `ProductLink`, `WhatsNew`, `VersionDate`, `Product_ID`) VALUES (120, '1.1.30', 'Android', 62.59, 'galaxy/filesystem/product/16/1.1.30', 'original app', '2014-12-11', 16);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Transaction`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (1, 76, 5, 'success', '2009-05-04 17:22:52', 0, '2279684612701150');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (2, 98, 5, 'success', '2009-06-20 22:26:58', 0, '6568981889856330');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (3, 2, 6, 'success', '2009-07-05 03:49:24', 1.99, '7824213825463270');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (4, 10, 10, 'success', '2009-07-18 07:31:05', 0, '4021190952770340');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (5, 19, 3, 'success', '2009-08-26 15:41:56', 0, '4203651811075920');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (6, 60, 7, 'success', '2009-08-28 11:38:35', 0, '8227886970177670');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (7, 93, 9, 'success', '2009-10-02 16:30:06', 0, '8641597571616830');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (8, 102, 2, 'success', '2009-10-05 07:00:05', 0.99, '3486066268710570');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (9, 82, 11, 'failure', '2009-10-30 17:05:27', 0, '2145842807723450');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (10, 74, 10, 'success', '2009-11-17 16:33:13', 0, '9049730668666150');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (11, 12, 7, 'success', '2009-11-26 16:57:32', 0, '5056063192525520');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (12, 48, 21, 'success', '2010-01-25 12:22:33', 3.99, '2777174086370240');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (13, 4, 2, 'success', '2010-02-04 10:07:21', 0.99, '1568990211258480');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (14, 39, 17, 'success', '2010-02-11 04:20:17', 2.99, '3890071443644960');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (15, 56, 13, 'success', '2010-02-28 18:44:34', 2.99, '3861212504017420');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (16, 3, 18, 'success', '2010-04-17 00:47:06', 3.99, '9728011784274840');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (17, 28, 7, 'success', '2010-04-30 22:14:12', 0, '2190920295869680');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (18, 82, 1, 'success', '2010-05-04 08:47:38', 0, '7602588918975150');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (19, 34, 9, 'success', '2010-05-08 13:29:48', 0, '4936565324022270');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (20, 79, 19, 'deleted', '2010-05-30 08:48:58', 3.99, '2980596187478510');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (21, 73, 13, 'success', '2010-05-31 05:20:54', 2.99, '9501832920714530');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (22, 77, 13, 'success', '2010-06-19 08:58:35', 2.99, '1345974694343700');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (23, 11, 5, 'success', '2010-06-22 07:20:16', 0, '7685292943446850');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (24, 69, 16, 'success', '2010-06-24 16:36:38', 2.99, '3314528141030600');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (25, 86, 18, 'success', '2010-07-29 19:01:29', 3.99, '1345244628211630');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (26, 53, 33, 'success', '2010-08-06 07:51:06', 0, '3709847372181290');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (27, 61, 25, 'success', '2010-08-11 12:14:08', 0, '6047595949960380');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (28, 64, 15, 'success', '2010-09-08 14:32:46', 2.99, '8171942723130740');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (29, 74, 13, 'success', '2010-10-23 18:15:05', 2.99, '1032244992034530');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (30, 53, 35, 'success', '2010-11-08 02:28:17', 0.99, '4023179490293590');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (31, 21, 19, 'success', '2010-11-14 14:28:52', 3.99, '9938175965103710');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (32, 69, 10, 'success', '2010-11-20 23:44:37', 0, '6865992438286130');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (33, 61, 8, 'success', '2010-11-30 17:16:07', 19.99, '8069679452038220');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (34, 44, 36, 'success', '2010-12-10 03:06:28', 0.99, '1564461497585110');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (35, 46, 32, 'success', '2010-12-16 02:27:15', 25.99, '3727061520507390');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (36, 99, 3, 'success', '2010-12-20 00:46:13', 0, '1014566625975920');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (37, 65, 16, 'success', '2010-12-21 16:07:19', 2.99, '6391614534705480');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (38, 64, 12, 'success', '2010-12-24 03:33:58', 2.99, '1583802511157880');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (39, 72, 36, 'success', '2010-12-28 16:48:20', 0.99, '2897973809089180');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (40, 48, 40, 'success', '2010-12-28 12:23:42', 0.99, '2519127764732630');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (41, 23, 38, 'success', '2010-12-29 20:47:39', 0.99, '8321380080009310');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (42, 44, 34, 'success', '2011-01-14 21:27:27', 0, '7342715003945380');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (43, 36, 7, 'success', '2011-01-25 01:16:10', 0, '2918916310793200');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (44, 72, 20, 'success', '2011-02-23 08:49:30', 3.99, '6818196485028370');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (45, 33, 18, 'success', '2011-03-11 10:03:39', 3.99, '7558502707914600');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (46, 44, 30, 'success', '2011-03-15 08:45:30', 2.19, '7499381721924750');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (47, 73, 28, 'success', '2011-03-22 09:42:23', 29.99, '9149423639732430');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (48, 51, 43, 'success', '2011-03-26 02:32:12', 0.99, '3287312691588610');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (49, 100, 17, 'success', '2011-03-28 17:46:18', 2.99, '3338955978411300');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (50, 102, 38, 'success', '2011-03-30 11:33:19', 0.99, '7462201268688780');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (51, 43, 46, 'success', '2011-04-09 12:43:31', 1.49, '4778178745920360');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (52, 44, 31, 'success', '2011-04-15 09:55:22', 0, '1468758035298730');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (53, 100, 32, 'failure', '2011-04-24 20:29:23', 25.99, '9536804379113790');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (54, 104, 6, 'success', '2011-05-05 01:23:39', 1.99, '6908761076929930');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (55, 7, 11, 'success', '2011-05-09 09:00:00', 0, '3565753665810960');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (56, 18, 16, 'success', '2011-05-18 06:18:50', 2.99, '3534955880498460');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (57, 14, 39, 'success', '2011-05-19 10:37:57', 0.99, '5426497079995180');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (58, 66, 46, 'success', '2011-05-22 05:17:05', 1.49, '9065294592796330');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (59, 16, 7, 'success', '2011-05-27 08:05:28', 0, '9320030872145280');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (60, 14, 46, 'success', '2011-06-04 07:00:54', 1.49, '2562275658548530');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (61, 26, 28, 'success', '2011-06-18 14:16:04', 29.99, '8610966088320710');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (62, 32, 43, 'success', '2011-07-06 10:49:14', 0.99, '3815629143429330');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (63, 50, 42, 'success', '2011-07-10 17:10:43', 1.49, '5249156607721750');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (64, 78, 47, 'success', '2011-07-14 04:57:13', 0, '1987601176633640');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (65, 88, 7, 'success', '2011-07-30 04:15:10', 0, '8874508267135090');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (66, 38, 40, 'success', '2011-08-03 05:04:35', 0.99, '5057433580388120');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (67, 32, 53, 'success', '2011-08-04 21:49:14', 1, '4898944756153600');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (68, 71, 44, 'success', '2011-08-05 22:03:14', 1.49, '8119947527118590');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (69, 87, 29, 'success', '2011-08-05 09:39:24', 0, '7514572877824830');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (70, 54, 41, 'success', '2011-08-06 00:45:08', 1.49, '5169036852373980');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (71, 53, 40, 'success', '2011-08-12 17:02:56', 0.99, '7627792890577840');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (72, 69, 14, 'success', '2011-08-13 12:00:08', 2.99, '1135379618899650');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (73, 95, 55, 'success', '2011-09-14 23:49:42', 1, '4681671174201020');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (74, 27, 22, 'success', '2011-09-14 02:12:55', 3.99, '7666566994532280');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (75, 52, 37, 'success', '2011-09-24 22:34:46', 0.99, '9330108581815190');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (76, 37, 10, 'success', '2011-09-24 07:55:34', 0, '4112312896579240');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (77, 74, 20, 'success', '2011-09-29 12:06:46', 3.99, '7322179075408390');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (78, 72, 31, 'success', '2011-10-02 07:50:47', 0, '1388604608383200');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (79, 98, 26, 'success', '2011-10-05 18:49:38', 5.99, '3227391705262990');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (80, 43, 15, 'success', '2011-10-06 10:25:33', 2.99, '4867515993252910');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (81, 47, 12, 'success', '2011-10-07 01:05:07', 2.99, '6713843676279570');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (82, 47, 51, 'success', '2011-10-15 01:25:53', 1, '8344875095141510');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (83, 39, 34, 'success', '2011-10-23 07:01:33', 0, '5146017122856950');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (84, 40, 26, 'success', '2011-10-25 14:02:44', 5.99, '9581056377535360');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (85, 97, 57, 'success', '2011-11-02 12:34:25', 0, '9387642117174090');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (86, 7, 43, 'success', '2011-11-05 16:29:46', 0.99, '1403279972078940');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (87, 62, 45, 'success', '2011-11-07 00:46:01', 44.99, '7785387868623560');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (88, 17, 18, 'success', '2011-11-10 06:03:37', 3.99, '9752511523930760');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (89, 17, 47, 'success', '2011-11-16 10:01:44', 0, '6054848668421170');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (90, 46, 22, 'success', '2011-11-19 06:40:57', 3.99, '6967237915609530');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (91, 79, 23, 'success', '2011-11-23 21:21:24', 3.99, '1469241990554000');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (92, 75, 20, 'success', '2011-11-27 19:11:30', 3.99, '1104869524559170');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (93, 37, 1, 'success', '2011-11-29 05:49:51', 0, '2683835444548480');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (94, 45, 14, 'success', '2011-11-30 21:39:04', 2.99, '7260706196340300');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (95, 68, 54, 'failure', '2011-12-07 08:23:24', 1, '4928629043045060');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (96, 38, 2, 'success', '2011-12-10 23:38:29', 0.99, '9122439797966240');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (97, 55, 38, 'success', '2011-12-11 20:09:05', 0.99, '3551183208759190');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (98, 73, 34, 'success', '2011-12-24 04:39:45', 0, '9792793047032760');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (99, 42, 56, 'success', '2011-12-25 09:32:12', 1, '5853675451658310');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (100, 1, 59, 'success', '2012-01-01 22:22:19', 0, '4302155263294930');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (101, 65, 44, 'success', '2012-01-02 10:09:05', 1.49, '9759240696003780');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (102, 46, 14, 'success', '2012-01-08 14:07:59', 2.99, '9000082884880560');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (103, 33, 7, 'success', '2012-01-16 04:54:37', 0, '1935463997651280');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (104, 99, 19, 'success', '2012-01-17 22:32:50', 3.99, '3750391243228420');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (105, 70, 5, 'success', '2012-01-29 05:28:23', 0, '2984907786709170');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (106, 75, 26, 'success', '2012-02-02 04:30:29', 5.99, '3729495417761050');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (107, 14, 36, 'deleted', '2012-02-03 10:05:57', 0.99, '4344164462353500');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (108, 46, 44, 'success', '2012-02-10 16:07:12', 1.49, '4091243933743500');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (109, 78, 51, 'success', '2012-02-20 20:20:03', 1, '7619448784167880');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (110, 77, 2, 'success', '2012-02-21 11:46:27', 0.99, '5104291363092840');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (111, 9, 59, 'success', '2012-02-25 01:21:12', 0, '5120091177171040');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (112, 62, 37, 'success', '2012-03-03 10:34:13', 0.99, '6664587343756360');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (113, 95, 8, 'success', '2012-03-03 19:51:49', 19.99, '5131195540372790');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (114, 35, 45, 'success', '2012-03-05 00:00:00', 44.99, '7519651892831660');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (115, 78, 18, 'success', '2012-03-08 10:09:20', 3.99, '6893121799175900');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (116, 61, 63, 'success', '2012-03-11 07:37:25', 2.99, '9140209738027950');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (117, 69, 49, 'success', '2012-03-12 16:57:00', 1.59, '9816649783259660');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (118, 33, 26, 'failure', '2012-03-14 10:51:54', 5.99, '1910756431722460');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (119, 7, 2, 'success', '2012-03-16 13:14:39', 0.99, '9258554907236170');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (120, 22, 63, 'success', '2012-03-20 03:22:17', 2.99, '1419780246751140');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (121, 104, 3, 'success', '2012-03-29 12:39:58', 0, '2619868700147280');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (122, 14, 63, 'success', '2012-03-29 06:29:02', 2.99, '3728364720900240');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (123, 48, 43, 'success', '2012-04-01 18:53:39', 0.99, '7866313851167010');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (124, 18, 40, 'success', '2012-04-21 20:29:46', 0.99, '2704986672606280');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (125, 35, 65, 'success', '2012-04-26 01:25:23', 2.99, '6081756061278650');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (126, 77, 29, 'success', '2012-05-01 04:22:55', 0, '4279468970607540');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (127, 102, 55, 'success', '2012-05-03 08:33:45', 1, '9366236414566930');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (128, 7, 45, 'success', '2012-05-07 09:30:47', 44.99, '7692725712617920');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (129, 20, 30, 'success', '2012-05-10 21:15:47', 2.19, '3361577757846810');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (130, 78, 59, 'success', '2012-05-14 22:48:17', 0, '3082002996719130');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (131, 12, 65, 'success', '2012-05-23 17:57:54', 2.99, '5368794586511240');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (132, 64, 27, 'success', '2012-05-24 09:31:03', 0, '5400437671640170');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (133, 12, 16, 'success', '2012-05-25 19:11:38', 2.99, '6030186683999000');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (134, 25, 57, 'success', '2012-06-14 09:42:43', 0, '1591866827271440');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (135, 7, 61, 'success', '2012-06-23 21:53:03', 0, '6486088389968780');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (136, 47, 37, 'failure', '2012-06-24 19:47:43', 0.99, '3059215380630280');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (137, 61, 39, 'success', '2012-07-07 09:12:04', 0.99, '7270946713612760');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (138, 57, 11, 'success', '2012-07-09 16:07:30', 0, '4958945724459140');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (139, 86, 67, 'success', '2012-07-12 17:55:30', 2.99, '9787497146869500');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (140, 20, 56, 'success', '2012-07-30 10:49:51', 1, '2146068791565360');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (141, 69, 25, 'success', '2012-08-02 01:57:54', 0, '5045743521211280');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (142, 89, 58, 'success', '2012-08-02 21:08:46', 0, '8916139728996480');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (143, 65, 43, 'success', '2012-08-12 23:42:14', 0.99, '8016202932435770');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (144, 72, 8, 'success', '2012-08-15 16:39:55', 19.99, '2348783805109100');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (145, 16, 73, 'success', '2012-08-17 08:57:45', 2.99, '7061489788221470');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (146, 53, 34, 'success', '2012-08-22 08:35:01', 0, '1211684226226520');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (147, 3, 42, 'success', '2012-08-24 23:13:36', 1.49, '3137576113390810');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (148, 12, 24, 'success', '2012-09-01 11:00:06', 0.99, '7170034710695050');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (149, 67, 71, 'success', '2012-09-01 22:42:40', 2.99, '5654139485181580');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (150, 44, 42, 'success', '2012-09-14 15:39:25', 1.49, '2817974222096070');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (151, 98, 29, 'success', '2012-09-18 15:37:36', 0, '3225322998775790');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (152, 72, 75, 'success', '2012-09-23 14:16:02', 1.99, '8118878283067090');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (153, 61, 56, 'success', '2012-09-25 16:56:34', 1, '3922642376758340');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (154, 96, 38, 'success', '2012-09-26 03:16:21', 0.99, '3469868434252920');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (155, 37, 50, 'success', '2012-10-04 14:52:54', 1.49, '8515534010524420');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (156, 14, 24, 'success', '2012-10-05 10:59:46', 0.99, '9898472316966760');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (157, 33, 27, 'success', '2012-10-07 05:44:17', 0, '4504578365622250');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (158, 38, 39, 'success', '2012-10-14 12:44:45', 0.99, '1009951554637090');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (159, 97, 32, 'success', '2012-10-16 01:22:21', 25.99, '2044923022764430');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (160, 7, 46, 'failure', '2012-10-30 13:32:48', 1.49, '9624287991997700');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (161, 11, 25, 'success', '2012-11-02 13:22:29', 0, '7434046028453270');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (162, 70, 50, 'success', '2012-11-03 23:46:09', 1.49, '9592498812178460');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (163, 37, 13, 'success', '2012-11-16 08:47:45', 2.99, '8744347337459300');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (164, 62, 67, 'success', '2012-11-22 12:53:52', 2.99, '5633548399851650');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (165, 93, 8, 'success', '2012-11-25 07:11:22', 19.99, '4701527102606600');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (166, 101, 7, 'success', '2012-12-05 20:57:20', 0, '8773248270278730');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (167, 36, 23, 'success', '2012-12-05 23:34:44', 3.99, '4665726063622420');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (168, 103, 60, 'success', '2012-12-05 09:36:28', 0, '1517069201187500');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (169, 61, 26, 'success', '2012-12-06 05:45:20', 5.99, '9581725596889030');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (170, 24, 64, 'success', '2012-12-13 12:55:52', 0.99, '4774015033434300');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (171, 89, 21, 'success', '2012-12-14 17:48:59', 3.99, '3015702747719910');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (172, 32, 13, 'success', '2012-12-26 12:51:50', 2.99, '9871322299707460');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (173, 58, 30, 'success', '2012-12-27 19:52:06', 2.19, '8950041453427700');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (174, 21, 79, 'success', '2012-12-27 20:41:37', 1.99, '9894575944566540');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (175, 100, 16, 'success', '2012-12-31 22:32:32', 2.99, '2489266935745530');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (176, 86, 79, 'success', '2013-01-13 18:24:25', 1.99, '7294134767868650');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (177, 44, 11, 'success', '2013-01-25 17:02:39', 0, '2308336295680160');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (178, 9, 69, 'success', '2013-01-25 16:50:30', 2.99, '7028170555134320');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (179, 96, 49, 'success', '2013-01-30 05:13:06', 1.59, '5438835138554690');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (180, 1, 40, 'success', '2013-02-08 16:46:48', 0.99, '9002601496457920');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (181, 69, 46, 'success', '2013-02-11 17:22:08', 1.49, '8830246186793110');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (182, 78, 58, 'success', '2013-02-12 17:03:50', 0, '9349758846845850');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (183, 74, 44, 'success', '2013-02-15 22:56:19', 1.49, '2904634622648660');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (184, 95, 82, 'deleted', '2013-02-16 04:53:45', 0.99, '7770165665834920');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (185, 88, 79, 'success', '2013-03-04 10:38:06', 1.99, '1645277924576650');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (186, 21, 82, 'success', '2013-03-05 03:36:13', 0.99, '7338191414211740');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (187, 92, 84, 'success', '2013-03-08 08:40:56', 0.99, '5362676535519270');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (188, 46, 77, 'success', '2013-03-14 09:51:05', 1.99, '3234295931076250');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (189, 39, 8, 'success', '2013-03-16 15:55:37', 19.99, '4126052883167670');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (190, 55, 81, 'success', '2013-03-17 20:20:13', 0.99, '4463439253260850');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (191, 38, 47, 'success', '2013-03-24 10:54:56', 0, '6607802707941680');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (192, 98, 85, 'success', '2013-03-24 05:58:17', 0.99, '7081050174197450');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (193, 87, 13, 'success', '2013-03-25 18:29:52', 2.99, '5573208150665770');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (194, 64, 58, 'success', '2013-03-26 05:16:52', 0, '9857854276060190');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (195, 45, 65, 'success', '2013-03-26 13:35:21', 2.99, '6409095702934440');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (196, 22, 59, 'success', '2013-03-27 11:31:28', 0, '8101585113612750');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (197, 34, 25, 'success', '2013-03-28 06:28:24', 0, '2107228380200940');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (198, 60, 53, 'success', '2013-04-04 00:44:58', 1, '5898199247636350');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (199, 48, 70, 'success', '2013-04-10 04:36:12', 10.99, '8151870750981380');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (200, 79, 64, 'success', '2013-04-11 16:30:08', 0.99, '6646729881054810');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (201, 57, 84, 'success', '2013-04-12 10:29:09', 0.99, '8362402717463580');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (202, 76, 69, 'success', '2013-04-15 00:40:47', 2.99, '8048672124963230');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (203, 5, 52, 'success', '2013-04-16 15:26:33', 1, '8520084602683150');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (204, 9, 83, 'success', '2013-04-20 14:08:21', 0.99, '8752790530561220');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (205, 105, 38, 'success', '2013-04-23 07:01:28', 0.99, '1643579737419700');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (206, 54, 81, 'success', '2013-04-23 01:04:39', 0.99, '9085090935037740');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (207, 35, 78, 'success', '2013-04-25 21:46:18', 1.99, '1626055577651620');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (208, 83, 17, 'success', '2013-04-30 21:16:58', 2.99, '7135347790418000');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (209, 100, 87, 'success', '2013-05-02 13:28:13', 0.99, '9359131890574980');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (210, 75, 69, 'success', '2013-05-07 15:06:54', 2.99, '8036354476212700');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (211, 55, 69, 'success', '2013-05-08 00:27:31', 2.99, '1400011091728540');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (212, 27, 68, 'success', '2013-05-11 03:33:22', 5.99, '5447078476887820');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (213, 51, 13, 'success', '2013-05-27 23:43:19', 2.99, '1668579376682190');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (214, 57, 32, 'success', '2013-05-28 21:41:37', 25.99, '8566314951239450');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (215, 101, 78, 'success', '2013-05-28 19:11:05', 1.99, '7535656535927180');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (216, 51, 24, 'success', '2013-06-02 20:50:08', 0.99, '7928968786798010');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (217, 79, 45, 'success', '2013-06-06 17:49:02', 44.99, '7503852385033520');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (218, 6, 87, 'success', '2013-06-07 03:36:15', 0.99, '2005460494606790');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (219, 62, 78, 'success', '2013-06-07 01:22:47', 1.99, '9206280704631060');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (220, 27, 81, 'success', '2013-06-10 17:19:32', 0.99, '8727357307670670');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (221, 59, 79, 'success', '2013-06-12 23:18:01', 1.99, '7548210311148760');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (222, 76, 7, 'success', '2013-06-18 11:56:07', 0, '9499080413802950');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (223, 32, 49, 'success', '2013-06-19 03:10:32', 1.59, '2827670079794710');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (224, 9, 17, 'success', '2013-06-30 01:08:18', 2.99, '9364843548657780');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (225, 46, 61, 'success', '2013-06-30 09:11:59', 0, '7073855389230890');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (226, 75, 68, 'success', '2013-07-02 16:47:10', 5.99, '6917531071402490');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (227, 16, 68, 'success', '2013-07-09 20:09:58', 5.99, '6320798899293360');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (228, 25, 81, 'success', '2013-07-12 04:38:53', 0.99, '3961618981486460');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (229, 34, 83, 'success', '2013-07-12 21:01:02', 0.99, '8591056088363470');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (230, 19, 61, 'success', '2013-07-16 22:00:17', 0, '3159126615906080');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (231, 73, 87, 'success', '2013-07-20 08:29:57', 0.99, '5449060486685580');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (232, 60, 1, 'success', '2013-07-26 04:35:52', 0, '6166527511889510');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (233, 71, 68, 'success', '2013-07-28 01:25:42', 5.99, '3119769026555890');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (234, 68, 24, 'success', '2013-08-03 00:10:14', 0.99, '2049798711999910');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (235, 79, 73, 'success', '2013-08-04 14:38:47', 2.99, '2702847943538100');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (236, 35, 2, 'success', '2013-08-04 14:51:58', 0.99, '2541817253365310');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (237, 46, 69, 'success', '2013-08-05 04:48:57', 2.99, '3475917752575580');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (238, 25, 16, 'success', '2013-08-07 02:25:42', 2.99, '2863667599622800');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (239, 47, 18, 'success', '2013-08-07 01:43:59', 3.99, '8189973205794450');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (240, 6, 88, 'success', '2013-08-07 16:54:14', 0, '6632961389244170');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (241, 86, 42, 'success', '2013-08-11 05:00:06', 1.49, '9616186720707330');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (242, 33, 48, 'success', '2013-08-15 22:03:58', 1.49, '1699861261136570');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (243, 28, 81, 'success', '2013-08-16 08:55:36', 0.99, '2161166972535590');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (244, 82, 51, 'success', '2013-08-17 23:47:57', 1, '3181878307326780');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (245, 83, 81, 'success', '2013-08-17 04:40:34', 0.99, '6028116734150810');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (246, 40, 77, 'success', '2013-08-19 23:02:46', 1.99, '6271186817758990');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (247, 43, 39, 'success', '2013-08-23 15:47:34', 0.99, '4535751807239440');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (248, 98, 87, 'success', '2013-08-27 02:25:09', 0.99, '3477762271267980');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (249, 84, 62, 'success', '2013-08-29 15:08:55', 0, '9979142828270540');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (250, 46, 8, 'success', '2013-08-31 21:44:08', 19.99, '4664824303099070');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (251, 19, 64, 'success', '2013-09-03 02:05:55', 0.99, '9866631782746280');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (252, 104, 75, 'success', '2013-09-06 17:56:42', 1.99, '6083204924570690');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (253, 94, 49, 'success', '2013-09-09 00:56:42', 1.59, '2175076160255130');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (254, 94, 55, 'success', '2013-09-10 02:06:59', 1, '4972352384325260');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (255, 95, 89, 'success', '2013-09-10 13:20:32', 0, '1809451271160800');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (256, 78, 44, 'success', '2013-09-13 07:09:44', 1.49, '6106859614492020');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (257, 96, 7, 'success', '2013-09-19 22:58:54', 0, '1179471237404020');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (258, 52, 93, 'success', '2013-09-20 19:37:45', 0, '5097007418337830');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (259, 26, 42, 'success', '2013-09-22 00:55:46', 1.49, '3636476089766340');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (260, 51, 28, 'success', '2013-09-25 01:25:16', 29.99, '3524551638451240');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (261, 49, 95, 'success', '2013-09-29 23:31:31', 0, '1214264502671260');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (262, 49, 61, 'success', '2013-09-30 13:53:34', 0, '4918746995431710');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (263, 18, 33, 'success', '2013-10-01 17:52:28', 0, '7238008899774860');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (264, 35, 92, 'success', '2013-10-01 01:20:21', 0, '1227282824506470');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (265, 40, 29, 'failure', '2013-10-01 02:37:38', 0, '7656617998749100');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (266, 20, 8, 'success', '2013-10-07 16:51:27', 19.99, '9672823461395140');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (267, 51, 36, 'success', '2013-10-08 22:57:35', 0.99, '3688545700981610');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (268, 15, 82, 'success', '2013-10-09 20:34:26', 0.99, '5301716352946860');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (269, 7, 79, 'success', '2013-10-12 06:11:20', 1.99, '7594061642915990');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (270, 60, 20, 'success', '2013-10-13 13:07:44', 3.99, '9301615834385030');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (271, 105, 64, 'success', '2013-10-13 01:13:11', 0.99, '9565873983300340');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (272, 81, 93, 'success', '2013-10-15 06:15:04', 0, '1809642529736030');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (273, 92, 6, 'success', '2013-10-17 20:11:58', 1.99, '6200888702513040');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (274, 47, 89, 'success', '2013-10-19 22:02:47', 0, '4111019121739150');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (275, 74, 77, 'success', '2013-10-19 10:37:55', 1.99, '4883045213186170');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (276, 27, 39, 'success', '2013-10-22 01:00:27', 0.99, '4691820306413910');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (277, 26, 84, 'success', '2013-10-22 12:18:43', 0.99, '5143222616147840');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (278, 60, 68, 'success', '2013-10-27 10:40:56', 5.99, '9087643859464050');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (279, 17, 11, 'success', '2013-11-02 16:15:48', 0, '2023289114890390');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (280, 74, 5, 'success', '2013-11-07 23:47:34', 0, '9937173811632580');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (281, 103, 88, 'success', '2013-11-08 02:48:54', 0, '1692208673185430');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (282, 100, 49, 'success', '2013-11-08 03:31:55', 1.59, '9005720841042450');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (283, 96, 84, 'success', '2013-11-10 01:46:17', 0.99, '4169900367012870');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (284, 98, 6, 'success', '2013-11-11 02:11:13', 1.99, '2519383529619500');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (285, 19, 14, 'success', '2013-11-12 03:43:17', 2.99, '6333245408156660');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (286, 37, 60, 'success', '2013-11-13 10:55:36', 0, '7911222424630350');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (287, 70, 72, 'success', '2013-11-16 12:17:34', 0, '9410646933590560');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (288, 54, 53, 'success', '2013-11-28 02:56:41', 1, '3680334052024510');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (289, 75, 94, 'success', '2013-12-05 10:29:12', 0, '2822241819052480');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (290, 72, 23, 'success', '2013-12-10 14:45:18', 3.99, '2683728921177970');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (291, 1, 33, 'success', '2013-12-13 12:20:26', 0, '5906092194580970');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (292, 104, 48, 'success', '2013-12-17 17:10:12', 1.49, '2096477990310290');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (293, 70, 89, 'success', '2013-12-18 23:57:26', 0, '5595261174464400');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (294, 86, 64, 'success', '2013-12-18 11:24:34', 0.99, '2363653191212800');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (295, 44, 56, 'success', '2013-12-18 13:17:44', 1, '8500367210539340');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (296, 10, 20, 'success', '2013-12-18 12:02:56', 3.99, '9736754195547670');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (297, 20, 25, 'success', '2013-12-23 16:04:13', 0, '6857521181592810');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (298, 81, 78, 'success', '2013-12-23 10:39:53', 1.99, '2901607170599740');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (299, 75, 23, 'success', '2013-12-25 21:41:16', 3.99, '9034420262926540');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (300, 88, 60, 'success', '2013-12-27 06:00:36', 0, '1351573039471400');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (301, 63, 42, 'success', '2013-12-29 12:27:06', 1.49, '7084955657223750');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (302, 74, 31, 'success', '2014-01-01 02:56:34', 0, '3559648265364090');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (303, 29, 67, 'success', '2014-01-05 18:45:58', 2.99, '7269101871974660');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (304, 50, 89, 'success', '2014-01-08 04:47:12', 0, '3514701881665080');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (305, 74, 27, 'success', '2014-01-09 04:04:19', 0, '5271563963389740');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (306, 14, 65, 'success', '2014-01-09 05:43:52', 2.99, '1986969196757080');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (307, 87, 21, 'success', '2014-01-13 17:17:39', 3.99, '8194536969166740');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (308, 18, 41, 'success', '2014-01-14 15:01:09', 1.49, '3511829500909050');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (309, 52, 27, 'success', '2014-01-16 14:46:54', 0, '1477728804006840');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (310, 59, 59, 'success', '2014-01-17 04:53:17', 0, '1876356464873370');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (311, 101, 95, 'deleted', '2014-01-25 01:46:20', 0, '9667487473088280');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (312, 90, 28, 'success', '2014-01-25 01:24:59', 29.99, '3857183545301450');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (313, 13, 40, 'success', '2014-01-28 15:18:54', 0.99, '5998456979122580');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (314, 46, 100, 'success', '2014-02-01 02:02:39', 0, '9156384583880320');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (315, 11, 89, 'success', '2014-02-04 10:38:00', 0, '8105832415489740');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (316, 95, 71, 'success', '2014-02-06 11:16:16', 2.99, '3645433775354610');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (317, 90, 86, 'success', '2014-02-07 06:04:44', 0, '7568323435857080');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (318, 67, 37, 'success', '2014-02-08 09:00:56', 0.99, '6151210895799750');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (319, 20, 91, 'success', '2014-02-09 10:40:04', 0, '7757972039881910');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (320, 54, 26, 'success', '2014-02-11 08:10:02', 5.99, '5899183804169960');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (321, 100, 33, 'success', '2014-02-16 23:44:48', 0, '6326470416215960');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (322, 105, 95, 'success', '2014-02-18 22:37:23', 0, '8662510942915590');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (323, 21, 29, 'success', '2014-02-21 00:15:17', 0, '1671039953588810');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (324, 26, 73, 'success', '2014-02-23 18:03:39', 2.99, '4070175257093210');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (325, 27, 100, 'success', '2014-02-27 00:39:14', 0, '3599639605548350');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (326, 18, 76, 'success', '2014-02-28 11:50:14', 1.99, '1972861609450370');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (327, 83, 26, 'success', '2014-03-01 00:47:20', 5.99, '2603330095034840');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (328, 20, 39, 'success', '2014-03-10 14:12:20', 0.99, '9001168491381730');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (329, 9, 94, 'success', '2014-03-11 12:02:19', 0, '4349614611213140');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (330, 37, 70, 'success', '2014-03-14 13:20:10', 10.99, '2219454936335520');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (331, 39, 38, 'success', '2014-03-15 17:12:58', 0.99, '4846672648494430');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (332, 98, 81, 'success', '2014-03-20 09:54:11', 0.99, '5495581003933650');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (333, 17, 101, 'success', '2014-03-22 04:09:11', 9.99, '3138274985973320');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (334, 79, 72, 'success', '2014-03-22 03:19:49', 0, '9400124276797940');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (335, 76, 67, 'success', '2014-03-26 13:53:47', 2.99, '6437682016277400');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (336, 2, 70, 'success', '2014-03-26 12:28:24', 10.99, '5412567287900700');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (337, 30, 38, 'success', '2014-03-27 16:44:29', 0.99, '7954708214207410');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (338, 56, 77, 'success', '2014-03-28 20:52:39', 1.99, '7585942327639810');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (339, 25, 92, 'success', '2014-04-01 09:27:54', 0, '5137401940308350');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (340, 98, 101, 'success', '2014-04-01 22:49:48', 9.99, '9056867989225300');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (341, 82, 42, 'success', '2014-04-03 09:33:05', 1.49, '4626591255045880');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (342, 101, 105, 'success', '2014-04-03 13:53:35', 9.99, '6265384344484190');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (343, 87, 11, 'success', '2014-04-04 09:41:14', 0, '4905409212475200');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (344, 105, 96, 'success', '2014-04-04 19:16:38', 0, '5678176155606010');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (345, 17, 71, 'success', '2014-04-07 06:24:36', 2.99, '4815596968201840');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (346, 92, 56, 'success', '2014-04-08 18:37:15', 1, '6059288766830920');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (347, 7, 70, 'success', '2014-04-09 19:01:37', 10.99, '8726863999412440');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (348, 104, 97, 'success', '2014-04-10 04:45:14', 0, '9133994163624280');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (349, 22, 106, 'success', '2014-04-12 02:11:24', 1.39, '1318990076843630');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (350, 34, 99, 'success', '2014-04-12 03:43:57', 0, '1145617570561950');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (351, 83, 80, 'success', '2014-04-13 20:05:44', 0.99, '5431306599152870');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (352, 33, 14, 'success', '2014-04-15 16:54:02', 2.99, '7455642559876870');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (353, 68, 3, 'success', '2014-04-19 03:32:07', 0, '7895791290412280');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (354, 44, 103, 'success', '2014-04-21 21:30:48', 9.99, '6979394064949080');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (355, 25, 67, 'success', '2014-04-22 12:42:01', 2.99, '6611098461544500');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (356, 65, 93, 'success', '2014-04-22 03:02:48', 0, '9415404804881470');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (357, 24, 81, 'success', '2014-04-23 04:39:25', 0.99, '3934849503783960');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (358, 62, 93, 'success', '2014-04-25 23:32:20', 0, '7075275674014350');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (359, 90, 3, 'success', '2014-04-26 08:46:47', 0, '3680976390500060');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (360, 34, 35, 'success', '2014-04-26 02:25:48', 0.99, '5846283139727610');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (361, 2, 63, 'success', '2014-04-30 14:10:56', 2.99, '6628326376353100');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (362, 64, 107, 'success', '2014-05-03 05:46:07', 9.99, '1638091181148720');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (363, 24, 59, 'success', '2014-05-04 06:09:09', 0, '6392106743875060');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (364, 26, 77, 'success', '2014-05-06 21:15:52', 1.99, '5459840277622090');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (365, 9, 67, 'success', '2014-05-07 17:25:52', 2.99, '1871187497352900');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (366, 93, 107, 'failure', '2014-05-08 19:46:24', 9.99, '5195536559833200');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (367, 73, 51, 'success', '2014-05-08 20:14:22', 1, '2569199688982910');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (368, 23, 98, 'success', '2014-05-08 21:28:06', 0, '9019625586745050');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (369, 61, 95, 'success', '2014-05-14 10:00:07', 0, '6507326127103310');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (370, 4, 85, 'success', '2014-05-15 11:59:00', 0.99, '1760115591914290');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (371, 57, 106, 'success', '2014-05-17 13:10:51', 1.39, '9218740145950240');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (372, 90, 54, 'success', '2014-05-17 05:17:13', 1, '8067535612164460');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (373, 28, 86, 'success', '2014-05-17 12:04:20', 0, '6594589226500960');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (374, 63, 92, 'success', '2014-05-17 08:17:22', 0, '7249421845113890');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (375, 92, 72, 'success', '2014-05-20 01:02:02', 0, '1770884741339750');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (376, 70, 60, 'success', '2014-05-21 17:38:56', 0, '6693110063934420');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (377, 41, 110, 'success', '2014-05-21 07:56:13', 30.99, '8527483357440090');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (378, 83, 108, 'success', '2014-05-22 20:36:11', 0, '4542063380054990');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (379, 85, 36, 'success', '2014-05-22 05:55:58', 0.99, '7202877386973020');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (380, 35, 47, 'success', '2014-05-24 13:42:34', 0, '1062727280298310');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (381, 52, 90, 'success', '2014-05-26 04:39:22', 0, '1134689509983450');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (382, 28, 78, 'success', '2014-05-28 06:54:52', 1.99, '5754640078090930');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (383, 21, 107, 'success', '2014-05-29 15:33:45', 9.99, '4215263813854220');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (384, 32, 100, 'success', '2014-05-31 03:43:26', 0, '6382103877694330');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (385, 54, 92, 'success', '2014-05-31 10:27:16', 0, '1639406163963870');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (386, 11, 92, 'success', '2014-06-01 15:27:42', 0, '9068058968959780');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (387, 49, 93, 'success', '2014-06-04 12:02:07', 0, '1566114981100310');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (388, 75, 82, 'deleted', '2014-06-04 12:51:19', 0.99, '2513103203806710');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (389, 26, 60, 'success', '2014-06-05 00:59:16', 0, '8168900937013580');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (390, 48, 64, 'success', '2014-06-06 06:15:01', 0.99, '5797741812341820');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (391, 76, 22, 'success', '2014-06-09 17:02:18', 3.99, '9434046012321530');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (392, 84, 107, 'success', '2014-06-10 03:37:19', 9.99, '1685136059810960');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (393, 5, 100, 'success', '2014-06-10 05:26:40', 0, '9311162186366770');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (394, 38, 100, 'success', '2014-06-18 11:06:58', 0, '6443703183105770');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (395, 51, 109, 'success', '2014-06-21 06:55:49', 9.99, '9600305038217510');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (396, 94, 71, 'success', '2014-06-21 20:48:02', 2.99, '6979628837871850');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (397, 99, 93, 'success', '2014-06-21 04:56:42', 0, '5062653541857230');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (398, 91, 79, 'success', '2014-06-22 08:34:02', 1.99, '9043002573965640');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (399, 23, 96, 'success', '2014-06-23 22:33:25', 0, '3409029073828280');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (400, 92, 98, 'success', '2014-06-24 08:55:02', 0, '7817860362122410');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (401, 2, 8, 'success', '2014-06-24 04:13:14', 19.99, '7838630406818450');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (402, 13, 69, 'success', '2014-06-25 20:05:12', 2.99, '8748933103023000');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (403, 34, 44, 'success', '2014-06-27 02:44:07', 1.49, '3064088430728730');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (404, 26, 95, 'success', '2014-06-28 03:52:16', 0, '3387963204162590');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (405, 64, 91, 'success', '2014-07-02 17:27:15', 0, '7391550062105740');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (406, 5, 35, 'success', '2014-07-02 00:43:30', 0.99, '7916147465396170');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (407, 39, 61, 'success', '2014-07-03 01:32:49', 0, '7047358476505330');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (408, 87, 108, 'success', '2014-07-04 19:53:41', 0, '1959327860034620');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (409, 79, 112, 'success', '2014-07-04 04:20:55', 5.99, '2478476038453450');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (410, 77, 106, 'success', '2014-07-05 09:40:07', 1.39, '4163613591709470');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (411, 91, 104, 'success', '2014-07-05 04:31:06', 99.99, '9245095859842800');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (412, 18, 53, 'success', '2014-07-07 09:15:21', 1, '5025528506938340');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (413, 94, 103, 'success', '2014-07-08 21:10:07', 9.99, '4869921668257610');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (414, 81, 103, 'success', '2014-07-08 23:51:58', 9.99, '6334069024174230');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (415, 22, 54, 'success', '2014-07-09 18:36:47', 1, '8987545824515280');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (416, 40, 111, 'success', '2014-07-09 22:05:04', 9.99, '9650391729120460');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (417, 31, 77, 'success', '2014-07-09 16:53:10', 1.99, '3494505665223830');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (418, 13, 113, 'success', '2014-07-09 01:50:38', 9.99, '9792049511764560');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (419, 54, 77, 'success', '2014-07-10 09:11:29', 1.99, '8490127458912450');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (420, 102, 62, 'failure', '2014-07-10 12:51:05', 0, '4867756560548140');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (421, 51, 113, 'success', '2014-07-13 18:46:47', 9.99, '8802786855245570');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (422, 64, 97, 'success', '2014-07-14 09:13:26', 0, '9417172098395100');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (423, 23, 5, 'success', '2014-07-15 10:11:28', 0, '9016713568547680');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (424, 92, 55, 'success', '2014-07-15 17:12:40', 1, '6093134299547200');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (425, 33, 107, 'success', '2014-07-16 11:56:00', 9.99, '2707045804043290');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (426, 69, 107, 'success', '2014-07-18 00:49:23', 9.99, '4777075735820910');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (427, 79, 104, 'success', '2014-07-19 23:03:17', 99.99, '7261664665318530');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (428, 95, 110, 'success', '2014-07-19 03:13:09', 30.99, '2573043079530110');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (429, 17, 91, 'success', '2014-07-21 18:00:28', 0, '5224809641055430');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (430, 90, 99, 'success', '2014-07-22 16:16:01', 0, '4233381769346060');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (431, 76, 45, 'success', '2014-07-23 07:22:40', 44.99, '6523060608725850');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (432, 43, 47, 'success', '2014-07-23 10:28:19', 0, '6043468111580450');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (433, 12, 106, 'success', '2014-07-23 18:05:31', 1.39, '4431967222432270');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (434, 86, 98, 'success', '2014-07-24 00:15:07', 0, '2912279938945320');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (435, 99, 113, 'success', '2014-07-26 23:11:03', 9.99, '3210207685639110');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (436, 99, 13, 'success', '2014-07-30 09:48:50', 2.99, '2794179642657240');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (437, 5, 50, 'success', '2014-07-31 07:26:13', 1.49, '4137102248991320');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (438, 61, 12, 'success', '2014-08-01 06:14:17', 2.99, '1911812039997200');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (439, 12, 85, 'success', '2014-08-01 18:52:03', 0.99, '5756002694469700');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (440, 9, 56, 'success', '2014-08-02 12:39:27', 1, '5054480527346510');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (441, 69, 108, 'success', '2014-08-06 08:41:24', 0, '4296373877873510');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (442, 96, 107, 'success', '2014-08-07 09:44:40', 9.99, '6051651157515830');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (443, 88, 109, 'success', '2014-08-08 15:13:37', 9.99, '5636468747888850');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (444, 89, 15, 'success', '2014-08-08 20:15:07', 2.99, '4027547245914450');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (445, 84, 93, 'success', '2014-08-08 12:48:48', 0, '5513981344883310');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (446, 14, 41, 'success', '2014-08-09 15:53:46', 1.49, '5079976311287920');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (447, 13, 95, 'success', '2014-08-09 02:51:11', 0, '7281501704487300');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (448, 60, 112, 'success', '2014-08-15 00:29:26', 5.99, '8914389709444390');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (449, 8, 10, 'success', '2014-08-16 22:20:46', 0, '3410272279820010');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (450, 79, 39, 'success', '2014-08-18 23:47:08', 0.99, '7533413919932230');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (451, 94, 113, 'success', '2014-08-20 12:30:52', 9.99, '6697920889481900');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (452, 99, 14, 'success', '2014-08-21 08:57:43', 2.99, '2917996317595360');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (453, 17, 2, 'success', '2014-08-23 07:24:16', 0.99, '3718550479248470');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (454, 102, 113, 'success', '2014-08-27 15:38:52', 9.99, '6412865695954840');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (455, 105, 89, 'success', '2014-08-29 16:39:02', 0, '1857443754235300');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (456, 74, 89, 'success', '2014-08-31 22:59:09', 0, '8671786352776950');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (457, 25, 83, 'success', '2014-09-03 01:04:39', 0.99, '7318239695392670');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (458, 17, 65, 'success', '2014-09-04 10:02:24', 2.99, '1896838796506010');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (459, 93, 50, 'success', '2014-09-04 01:18:45', 1.49, '7259195345312840');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (460, 46, 73, 'success', '2014-09-05 14:20:49', 2.99, '3067162341354560');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (461, 33, 93, 'success', '2014-09-06 16:33:30', 0, '9788257710229800');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (462, 48, 49, 'success', '2014-09-07 03:52:35', 1.59, '5514491997467880');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (463, 8, 82, 'success', '2014-09-07 03:09:51', 0.99, '3083984452031580');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (464, 48, 110, 'success', '2014-09-09 03:23:35', 30.99, '4739070263541630');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (465, 64, 111, 'success', '2014-09-10 13:25:53', 9.99, '4743629387314570');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (466, 68, 22, 'success', '2014-09-10 12:02:42', 3.99, '8265049025332690');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (467, 30, 107, 'success', '2014-09-11 23:21:02', 9.99, '6850450912962310');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (468, 66, 94, 'success', '2014-09-11 09:30:07', 0, '2357239404937540');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (469, 24, 110, 'success', '2014-09-11 07:19:07', 30.99, '2137490763055910');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (470, 59, 5, 'success', '2014-09-12 02:19:09', 0, '6621890000971300');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (471, 73, 38, 'success', '2014-09-16 18:52:06', 0.99, '7905810973736180');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (472, 39, 107, 'success', '2014-09-17 07:31:44', 9.99, '8533774532796320');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (473, 1, 105, 'success', '2014-09-19 20:15:14', 9.99, '6147360912155540');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (474, 98, 25, 'success', '2014-09-20 04:37:28', 0, '4358238454611740');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (475, 77, 114, 'success', '2014-09-22 22:07:18', 0, '5853335974895810');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (476, 25, 90, 'success', '2014-09-25 23:20:08', 0, '5188679082724060');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (477, 74, 83, 'success', '2014-09-25 00:49:34', 0.99, '7563865694055820');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (478, 34, 66, 'success', '2014-09-26 03:17:59', 1.49, '1173844506787690');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (479, 29, 70, 'success', '2014-09-30 05:59:26', 10.99, '2106979745131680');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (480, 101, 96, 'success', '2014-09-30 04:10:51', 0, '1544822448790760');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (481, 70, 110, 'success', '2014-10-01 03:03:31', 30.99, '7007803030497640');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (482, 24, 95, 'success', '2014-10-01 00:55:36', 0, '6059340780108630');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (483, 57, 95, 'success', '2014-10-01 20:15:57', 0, '8454315264888180');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (484, 26, 87, 'success', '2014-10-03 18:52:09', 0.99, '6940646422585000');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (485, 40, 99, 'success', '2014-10-03 11:19:54', 0, '5363323548739120');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (486, 35, 113, 'success', '2014-10-04 02:01:36', 9.99, '5822675609354510');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (487, 60, 11, 'success', '2014-10-04 10:53:11', 0, '7990190464319900');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (488, 14, 96, 'success', '2014-10-05 06:22:02', 0, '1362694736812620');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (489, 64, 113, 'success', '2014-10-06 23:54:51', 9.99, '6597438724587500');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (490, 76, 79, 'success', '2014-10-06 06:42:20', 1.99, '5902769858162510');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (491, 43, 6, 'success', '2014-10-07 07:55:01', 1.99, '4389515801053570');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (492, 78, 88, 'success', '2014-10-07 20:35:06', 0, '2766705167377330');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (493, 84, 69, 'success', '2014-10-07 19:03:49', 2.99, '6289703738149260');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (494, 18, 90, 'success', '2014-10-08 11:43:08', 0, '6368482980169340');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (495, 31, 112, 'success', '2014-10-08 05:30:25', 5.99, '2573376604094360');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (496, 69, 20, 'success', '2014-10-09 03:34:34', 3.99, '6492524858366170');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (497, 43, 112, 'success', '2014-10-12 10:54:16', 5.99, '4296772019831940');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (498, 15, 86, 'success', '2014-10-13 13:32:20', 0, '5178727010213410');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (499, 84, 109, 'success', '2014-10-14 16:16:08', 9.99, '9446344765583280');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (500, 89, 102, 'success', '2014-10-15 20:17:39', 15.99, '3225391446200530');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (501, 52, 107, 'success', '2014-10-16 05:25:58', 9.99, '6582251021655300');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (502, 98, 78, 'success', '2014-10-16 01:43:27', 1.99, '2293485816233350');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (503, 37, 54, 'success', '2014-10-18 03:11:05', 1, '3244690941437140');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (504, 42, 58, 'success', '2014-10-21 19:02:18', 0, '8311963613515660');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (505, 72, 89, 'success', '2014-10-21 00:41:42', 0, '9897498744033030');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (506, 3, 115, 'success', '2014-10-22 16:32:41', 0, '5492740104868390');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (507, 27, 102, 'success', '2014-10-27 18:08:45', 15.99, '4190291113095600');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (508, 6, 27, 'success', '2014-10-30 08:17:35', 0, '4082157419265790');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (509, 17, 84, 'success', '2014-11-01 02:48:43', 0.99, '4261363871752890');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (510, 21, 64, 'success', '2014-11-02 06:01:40', 0.99, '9382129810854320');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (511, 17, 25, 'success', '2014-11-02 07:43:21', 0, '1365242873324350');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (512, 21, 84, 'success', '2014-11-02 22:45:28', 0.99, '4232686899116080');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (513, 85, 116, 'success', '2014-11-04 22:55:42', 0, '8544960453275140');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (514, 38, 111, 'success', '2014-11-04 02:08:47', 9.99, '5762288254030310');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (515, 30, 49, 'success', '2014-11-05 06:18:50', 1.59, '6187228845566140');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (516, 102, 11, 'success', '2014-11-06 03:54:40', 0, '6293909751383030');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (517, 45, 108, 'success', '2014-11-09 08:51:31', 0, '4824264543089900');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (518, 32, 115, 'success', '2014-11-11 12:59:36', 0, '7318907325227870');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (519, 28, 114, 'success', '2014-11-12 07:15:25', 0, '4392166855653740');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (520, 58, 111, 'success', '2014-11-13 18:02:27', 9.99, '8133498353578400');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (521, 86, 57, 'success', '2014-11-13 15:07:24', 0, '9415729289102500');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (522, 37, 111, 'success', '2014-11-14 09:35:30', 9.99, '3586308086115260');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (523, 74, 99, 'success', '2014-11-14 13:19:47', 0, '9924673089051220');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (524, 74, 23, 'success', '2014-11-15 04:12:29', 3.99, '3748866668923220');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (525, 22, 95, 'success', '2014-11-17 05:09:27', 0, '6949420135229340');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (526, 98, 68, 'success', '2014-11-18 22:45:20', 5.99, '7173386357802700');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (527, 65, 40, 'success', '2014-11-20 11:27:55', 0.99, '3417928276839180');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (528, 66, 63, 'success', '2014-11-21 18:07:24', 2.99, '3475170132149450');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (529, 58, 26, 'success', '2014-11-21 06:05:16', 5.99, '3997432973878310');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (530, 53, 99, 'success', '2014-11-22 18:07:10', 0, '7324776447929190');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (531, 62, 110, 'success', '2014-11-23 09:54:08', 30.99, '9626470031167090');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (532, 24, 86, 'failure', '2014-11-23 16:32:42', 0, '5363157464471770');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (533, 33, 111, 'success', '2014-11-25 01:04:00', 9.99, '9284221716588340');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (534, 2, 108, 'success', '2014-11-25 21:11:28', 0, '5650410756031630');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (535, 71, 41, 'success', '2014-11-26 20:17:16', 1.49, '7628783509488240');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (536, 94, 83, 'success', '2014-11-28 23:14:35', 0.99, '4714780420072330');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (537, 56, 68, 'success', '2014-11-28 01:26:41', 5.99, '6253669368106640');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (538, 85, 73, 'success', '2014-11-30 07:08:17', 2.99, '4227924408469790');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (539, 6, 42, 'success', '2014-11-30 05:14:35', 1.49, '5230984076917040');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (540, 74, 58, 'success', '2014-12-02 21:08:16', 0, '4739114460381210');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (541, 98, 91, 'success', '2014-12-02 22:34:49', 0, '2512315638803000');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (542, 81, 88, 'success', '2014-12-03 13:02:44', 0, '7136734681191700');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (543, 20, 114, 'success', '2014-12-03 19:45:13', 0, '3011728882779680');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (544, 17, 99, 'success', '2014-12-04 20:52:29', 0, '7391310409272000');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (545, 84, 51, 'success', '2014-12-04 21:48:35', 1, '7655642928215060');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (546, 31, 109, 'success', '2014-12-04 22:02:26', 9.99, '8800642120492350');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (547, 94, 61, 'success', '2014-12-05 06:14:26', 0, '2307259633334050');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (548, 58, 92, 'success', '2014-12-05 20:08:53', 0, '5768150176387070');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (549, 41, 101, 'success', '2014-12-05 13:14:50', 9.99, '2067873289407030');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (550, 61, 103, 'deleted', '2014-12-06 18:20:48', 9.99, '1161360441709740');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (551, 53, 102, 'success', '2014-12-06 02:21:05', 15.99, '6729558556055230');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (552, 46, 117, 'success', '2014-12-08 19:03:45', 0, '9487459981282440');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (553, 100, 110, 'success', '2014-12-09 23:06:21', 30.99, '1422506193067100');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (554, 76, 70, 'success', '2014-12-10 12:03:03', 10.99, '4824283478437550');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (555, 79, 58, 'success', '2014-12-10 19:13:55', 0, '2699812247955550');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (556, 73, 1, 'success', '2014-12-12 01:29:06', 0, '6546588328794500');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (557, 67, 119, 'success', '2014-12-13 18:52:17', 0, '5359969303606820');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (558, 88, 69, 'success', '2014-12-13 22:02:11', 2.99, '3789876443729610');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (559, 56, 119, 'success', '2014-12-14 02:42:49', 0, '9521532808412550');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (560, 24, 39, 'success', '2014-12-15 18:16:30', 0.99, '3797099580197930');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (561, 27, 120, 'success', '2014-12-15 14:44:02', 0.99, '9490937543803610');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (562, 46, 91, 'success', '2014-12-15 17:59:28', 0, '8530527080766300');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (563, 3, 106, 'success', '2014-12-15 22:28:37', 1.39, '2517416835403850');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (564, 55, 120, 'success', '2014-12-15 11:00:22', 0.99, '8301316423018440');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (565, 76, 113, 'success', '2014-12-16 18:17:19', 9.99, '8447936637632560');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (566, 69, 116, 'success', '2014-12-16 16:10:14', 0, '5138900303404610');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (567, 53, 120, 'success', '2014-12-16 03:22:33', 0.99, '4790390595422050');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (568, 83, 119, 'success', '2014-12-17 21:17:08', 0, '6065000919152600');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (569, 44, 87, 'success', '2014-12-18 23:09:45', 0.99, '2630768819716760');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (570, 39, 7, 'success', '2014-12-18 12:55:01', 0, '5322527145025350');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (571, 18, 36, 'success', '2014-12-19 22:08:52', 0.99, '8430691752033500');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (572, 53, 56, 'success', '2014-12-19 17:33:09', 1, '6051383236239240');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (573, 32, 120, 'success', '2014-12-19 09:33:30', 0.99, '1529533640162640');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (574, 1, 30, 'success', '2014-12-20 01:20:25', 2.19, '1894802095840910');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (575, 104, 118, 'success', '2014-12-23 14:02:21', 0, '3497209558171640');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (576, 14, 116, 'success', '2014-12-23 05:49:21', 0, '3602374288795460');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (577, 26, 108, 'success', '2014-12-23 06:16:28', 0, '2426453753959330');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (578, 87, 118, 'success', '2014-12-24 01:08:25', 0, '6316034207933050');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (579, 82, 40, 'success', '2014-12-24 14:35:44', 0.99, '3712379221904410');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (580, 70, 115, 'success', '2014-12-25 03:02:35', 0, '4818632297293270');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (581, 85, 79, 'success', '2014-12-25 16:05:37', 1.99, '8622064285780840');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (582, 65, 117, 'success', '2014-12-25 21:55:04', 0, '7317532689061940');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (583, 73, 119, 'success', '2014-12-26 05:42:02', 0, '5527869591387320');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (584, 41, 119, 'success', '2014-12-26 00:59:04', 0, '2128543918059780');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (585, 35, 119, 'success', '2014-12-27 19:56:38', 0, '5289228206855970');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (586, 95, 120, 'success', '2015-01-01 18:16:14', 0.99, '6200239572311510');
INSERT INTO `mydb`.`Transaction` (`Transaction_ID`, `Details_ID`, `Version_ID`, `Status`, `Timestamp`, `Amount`, `Gateway_ID`) VALUES (587, 102, 56, 'success', '2015-01-01 23:54:00', 1, '6942858756479740');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Game`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Game` (`GProduct_ID`) VALUES (9);
INSERT INTO `mydb`.`Game` (`GProduct_ID`) VALUES (10);
INSERT INTO `mydb`.`Game` (`GProduct_ID`) VALUES (11);
INSERT INTO `mydb`.`Game` (`GProduct_ID`) VALUES (12);
INSERT INTO `mydb`.`Game` (`GProduct_ID`) VALUES (13);
INSERT INTO `mydb`.`Game` (`GProduct_ID`) VALUES (14);
INSERT INTO `mydb`.`Game` (`GProduct_ID`) VALUES (15);
INSERT INTO `mydb`.`Game` (`GProduct_ID`) VALUES (16);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Movie`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Movie` (`MOProduct_ID`, `Length`, `Quality`) VALUES (33, 120, 720);
INSERT INTO `mydb`.`Movie` (`MOProduct_ID`, `Length`, `Quality`) VALUES (34, 129, 1080);
INSERT INTO `mydb`.`Movie` (`MOProduct_ID`, `Length`, `Quality`) VALUES (35, 189, 320);
INSERT INTO `mydb`.`Movie` (`MOProduct_ID`, `Length`, `Quality`) VALUES (36, 150, 1080);
INSERT INTO `mydb`.`Movie` (`MOProduct_ID`, `Length`, `Quality`) VALUES (37, 120, 320);
INSERT INTO `mydb`.`Movie` (`MOProduct_ID`, `Length`, `Quality`) VALUES (38, 130, 720);
INSERT INTO `mydb`.`Movie` (`MOProduct_ID`, `Length`, `Quality`) VALUES (39, 139, 1080);
INSERT INTO `mydb`.`Movie` (`MOProduct_ID`, `Length`, `Quality`) VALUES (40, 93, 1080);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Music`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Music` (`MUProduct_ID`, `Singer`, `Album`, `Length`, `SongQuality`) VALUES (25, 'Floetry', 'Floetic', 4.00, 190);
INSERT INTO `mydb`.`Music` (`MUProduct_ID`, `Singer`, `Album`, `Length`, `SongQuality`) VALUES (26, 'Dan Black', 'UN', 3.40, 320);
INSERT INTO `mydb`.`Music` (`MUProduct_ID`, `Singer`, `Album`, `Length`, `SongQuality`) VALUES (27, 'Lil Wayne', 'Gotti', 4.41, 320);
INSERT INTO `mydb`.`Music` (`MUProduct_ID`, `Singer`, `Album`, `Length`, `SongQuality`) VALUES (28, 'Rich Gang', 'Lifestyle', 4.29, 160);
INSERT INTO `mydb`.`Music` (`MUProduct_ID`, `Singer`, `Album`, `Length`, `SongQuality`) VALUES (29, 'Machine Head', 'Bloodstones and Diamond', 7.10, 310);
INSERT INTO `mydb`.`Music` (`MUProduct_ID`, `Singer`, `Album`, `Length`, `SongQuality`) VALUES (30, 'King Diamond', 'Dream of Horror', 3.39, 280);
INSERT INTO `mydb`.`Music` (`MUProduct_ID`, `Singer`, `Album`, `Length`, `SongQuality`) VALUES (31, 'Eminem', 'Different Shades of Blue', 5.56, 160);
INSERT INTO `mydb`.`Music` (`MUProduct_ID`, `Singer`, `Album`, `Length`, `SongQuality`) VALUES (32, 'Krewella', 'For You', 4.36, 360);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Ebooks`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Ebooks` (`EProduct_ID`, `ISBN`, `Author`, `Version`) VALUES (17, '456-345', 'V Ramesh', '10.1');
INSERT INTO `mydb`.`Ebooks` (`EProduct_ID`, `ISBN`, `Author`, `Version`) VALUES (18, '125-345', 'Robert Sheldon', '1.1');
INSERT INTO `mydb`.`Ebooks` (`EProduct_ID`, `ISBN`, `Author`, `Version`) VALUES (19, '325-24', 'Paul Wilton', '2.1');
INSERT INTO `mydb`.`Ebooks` (`EProduct_ID`, `ISBN`, `Author`, `Version`) VALUES (20, '468-35', 'Peter Thiel', '3.1');
INSERT INTO `mydb`.`Ebooks` (`EProduct_ID`, `ISBN`, `Author`, `Version`) VALUES (21, '165-234', 'Barnes', '4.1');
INSERT INTO `mydb`.`Ebooks` (`EProduct_ID`, `ISBN`, `Author`, `Version`) VALUES (22, '458-24', 'George Martin', '1.1');
INSERT INTO `mydb`.`Ebooks` (`EProduct_ID`, `ISBN`, `Author`, `Version`) VALUES (23, '238-234', 'E L James', '1.0');
INSERT INTO `mydb`.`Ebooks` (`EProduct_ID`, `ISBN`, `Author`, `Version`) VALUES (24, '138-64', 'Sanjay Kapoor', '1.0');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Advertiser`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Advertiser` (`Card_ID`, `ACompany_ID`) VALUES (101, 1);
INSERT INTO `mydb`.`Advertiser` (`Card_ID`, `ACompany_ID`) VALUES (102, 3);
INSERT INTO `mydb`.`Advertiser` (`Card_ID`, `ACompany_ID`) VALUES (103, 10);
INSERT INTO `mydb`.`Advertiser` (`Card_ID`, `ACompany_ID`) VALUES (104, 11);
INSERT INTO `mydb`.`Advertiser` (`Card_ID`, `ACompany_ID`) VALUES (105, 12);
INSERT INTO `mydb`.`Advertiser` (`Card_ID`, `ACompany_ID`) VALUES (106, 13);
INSERT INTO `mydb`.`Advertiser` (`Card_ID`, `ACompany_ID`) VALUES (107, 14);
INSERT INTO `mydb`.`Advertiser` (`Card_ID`, `ACompany_ID`) VALUES (108, 15);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`AdvertisementManager`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`AdvertisementManager` (`Manager_Emp_ID`) VALUES (3);
INSERT INTO `mydb`.`AdvertisementManager` (`Manager_Emp_ID`) VALUES (13);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Advertisement`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Advertisement` (`Advertisement_ID`, `AdvName`, `PricePerHour`, `DurationInHoursPerWeek`, `Date`, `MultimediaLink`, `AdvStatus`, `ACompany_ID`, `AdvertisementManager_Manager_Emp_ID`) VALUES (1, 'Candycrush', 50, 120, '2009-01-26', 'galaxy/advertisements/1/Candycrush', 'rejected', 1, 3);
INSERT INTO `mydb`.`Advertisement` (`Advertisement_ID`, `AdvName`, `PricePerHour`, `DurationInHoursPerWeek`, `Date`, `MultimediaLink`, `AdvStatus`, `ACompany_ID`, `AdvertisementManager_Manager_Emp_ID`) VALUES (2, 'Facebook Jobs', 80, 150, '2009-03-24', 'galaxy/advertisements/12/Facebook Jobs', 'approved', 12, 13);
INSERT INTO `mydb`.`Advertisement` (`Advertisement_ID`, `AdvName`, `PricePerHour`, `DurationInHoursPerWeek`, `Date`, `MultimediaLink`, `AdvStatus`, `ACompany_ID`, `AdvertisementManager_Manager_Emp_ID`) VALUES (3, 'iWatch', 80, 150, '2009-04-21', 'galaxy/advertisements/13/iWatch', 'approved', 13, 13);
INSERT INTO `mydb`.`Advertisement` (`Advertisement_ID`, `AdvName`, `PricePerHour`, `DurationInHoursPerWeek`, `Date`, `MultimediaLink`, `AdvStatus`, `ACompany_ID`, `AdvertisementManager_Manager_Emp_ID`) VALUES (4, 'Honda cars', 80, 150, '2009-04-29', 'galaxy/advertisements/15/Honda cars', 'approved', 15, 3);
INSERT INTO `mydb`.`Advertisement` (`Advertisement_ID`, `AdvName`, `PricePerHour`, `DurationInHoursPerWeek`, `Date`, `MultimediaLink`, `AdvStatus`, `ACompany_ID`, `AdvertisementManager_Manager_Emp_ID`) VALUES (5, 'Hangout', 50, 120, '2010-02-15', 'galaxy/advertisements/3/Hangout', 'approved', 3, 3);
INSERT INTO `mydb`.`Advertisement` (`Advertisement_ID`, `AdvName`, `PricePerHour`, `DurationInHoursPerWeek`, `Date`, `MultimediaLink`, `AdvStatus`, `ACompany_ID`, `AdvertisementManager_Manager_Emp_ID`) VALUES (6, 'walmart.com', 80, 150, '2010-03-14', 'galaxy/advertisements/11/walmart.com', 'approved', 11, 13);
INSERT INTO `mydb`.`Advertisement` (`Advertisement_ID`, `AdvName`, `PricePerHour`, `DurationInHoursPerWeek`, `Date`, `MultimediaLink`, `AdvStatus`, `ACompany_ID`, `AdvertisementManager_Manager_Emp_ID`) VALUES (7, 'Facebook Apps promotion', 80, 150, '2010-03-21', 'galaxy/advertisements/12/Facebook Apps promotion', 'approved', 12, 3);
INSERT INTO `mydb`.`Advertisement` (`Advertisement_ID`, `AdvName`, `PricePerHour`, `DurationInHoursPerWeek`, `Date`, `MultimediaLink`, `AdvStatus`, `ACompany_ID`, `AdvertisementManager_Manager_Emp_ID`) VALUES (8, 'HTC tablets', 80, 150, '2010-04-27', 'galaxy/advertisements/14/HTC tablets', 'rejected', 14, 13);
INSERT INTO `mydb`.`Advertisement` (`Advertisement_ID`, `AdvName`, `PricePerHour`, `DurationInHoursPerWeek`, `Date`, `MultimediaLink`, `AdvStatus`, `ACompany_ID`, `AdvertisementManager_Manager_Emp_ID`) VALUES (9, 'Honda engines', 80, 150, '2010-05-02', 'galaxy/advertisements/15/Honda engines', 'approved', 15, 3);
INSERT INTO `mydb`.`Advertisement` (`Advertisement_ID`, `AdvName`, `PricePerHour`, `DurationInHoursPerWeek`, `Date`, `MultimediaLink`, `AdvStatus`, `ACompany_ID`, `AdvertisementManager_Manager_Emp_ID`) VALUES (10, 'Google Maps', 50, 120, '2011-03-02', 'galaxy/advertisements/3/Google Maps', 'approved', 3, 13);
INSERT INTO `mydb`.`Advertisement` (`Advertisement_ID`, `AdvName`, `PricePerHour`, `DurationInHoursPerWeek`, `Date`, `MultimediaLink`, `AdvStatus`, `ACompany_ID`, `AdvertisementManager_Manager_Emp_ID`) VALUES (11, 'Zero to one', 50, 120, '2011-03-06', 'galaxy/advertisements/10/Zero to one', 'approved', 10, 13);
INSERT INTO `mydb`.`Advertisement` (`Advertisement_ID`, `AdvName`, `PricePerHour`, `DurationInHoursPerWeek`, `Date`, `MultimediaLink`, `AdvStatus`, `ACompany_ID`, `AdvertisementManager_Manager_Emp_ID`) VALUES (12, 'Christmas Offers', 80, 150, '2011-03-16', 'galaxy/advertisements/11/Christmas Offers', 'approved', 11, 3);
INSERT INTO `mydb`.`Advertisement` (`Advertisement_ID`, `AdvName`, `PricePerHour`, `DurationInHoursPerWeek`, `Date`, `MultimediaLink`, `AdvStatus`, `ACompany_ID`, `AdvertisementManager_Manager_Emp_ID`) VALUES (13, 'Honda bikes', 80, 150, '2011-04-28', 'galaxy/advertisements/15/Honda bikes', 'approved', 15, 13);
INSERT INTO `mydb`.`Advertisement` (`Advertisement_ID`, `AdvName`, `PricePerHour`, `DurationInHoursPerWeek`, `Date`, `MultimediaLink`, `AdvStatus`, `ACompany_ID`, `AdvertisementManager_Manager_Emp_ID`) VALUES (14, 'Google Voice', 50, 120, '2012-02-19', 'galaxy/advertisements/3/Google Voice', 'approved', 3, 3);
INSERT INTO `mydb`.`Advertisement` (`Advertisement_ID`, `AdvName`, `PricePerHour`, `DurationInHoursPerWeek`, `Date`, `MultimediaLink`, `AdvStatus`, `ACompany_ID`, `AdvertisementManager_Manager_Emp_ID`) VALUES (15, 'ipad Air', 80, 150, '2012-04-20', 'galaxy/advertisements/13/ipad Air', 'approved', 13, 3);
INSERT INTO `mydb`.`Advertisement` (`Advertisement_ID`, `AdvName`, `PricePerHour`, `DurationInHoursPerWeek`, `Date`, `MultimediaLink`, `AdvStatus`, `ACompany_ID`, `AdvertisementManager_Manager_Emp_ID`) VALUES (16, 'gameloft.com', 50, 120, '2013-02-04', 'galaxy/advertisements/1/gameloft.com', 'on hold', 1, 13);
INSERT INTO `mydb`.`Advertisement` (`Advertisement_ID`, `AdvName`, `PricePerHour`, `DurationInHoursPerWeek`, `Date`, `MultimediaLink`, `AdvStatus`, `ACompany_ID`, `AdvertisementManager_Manager_Emp_ID`) VALUES (17, 'Facebook.com', 80, 150, '2013-03-22', 'galaxy/advertisements/12/Facebook.com', 'rejected', 12, 3);
INSERT INTO `mydb`.`Advertisement` (`Advertisement_ID`, `AdvName`, `PricePerHour`, `DurationInHoursPerWeek`, `Date`, `MultimediaLink`, `AdvStatus`, `ACompany_ID`, `AdvertisementManager_Manager_Emp_ID`) VALUES (18, 'HTC offers', 80, 150, '2013-04-27', 'galaxy/advertisements/14/HTC offers', 'on hold', 14, 3);
INSERT INTO `mydb`.`Advertisement` (`Advertisement_ID`, `AdvName`, `PricePerHour`, `DurationInHoursPerWeek`, `Date`, `MultimediaLink`, `AdvStatus`, `ACompany_ID`, `AdvertisementManager_Manager_Emp_ID`) VALUES (19, 'Asphalt', 50, 120, '2014-01-25', 'galaxy/advertisements/1/Asphalt', 'approved', 1, 3);
INSERT INTO `mydb`.`Advertisement` (`Advertisement_ID`, `AdvName`, `PricePerHour`, `DurationInHoursPerWeek`, `Date`, `MultimediaLink`, `AdvStatus`, `ACompany_ID`, `AdvertisementManager_Manager_Emp_ID`) VALUES (20, 'Fifty Shades of grey', 50, 120, '2014-03-08', 'galaxy/advertisements/10/Fifty Shades of grey', 'rejected', 10, 13);
INSERT INTO `mydb`.`Advertisement` (`Advertisement_ID`, `AdvName`, `PricePerHour`, `DurationInHoursPerWeek`, `Date`, `MultimediaLink`, `AdvStatus`, `ACompany_ID`, `AdvertisementManager_Manager_Emp_ID`) VALUES (21, 'Beats', 80, 150, '2014-03-26', 'galaxy/advertisements/13/Beats', 'approved', 13, 13);
INSERT INTO `mydb`.`Advertisement` (`Advertisement_ID`, `AdvName`, `PricePerHour`, `DurationInHoursPerWeek`, `Date`, `MultimediaLink`, `AdvStatus`, `ACompany_ID`, `AdvertisementManager_Manager_Emp_ID`) VALUES (22, 'HTC Phones', 80, 150, '2014-04-22', 'galaxy/advertisements/14/HTC Phones', 'approved', 14, 3);
INSERT INTO `mydb`.`Advertisement` (`Advertisement_ID`, `AdvName`, `PricePerHour`, `DurationInHoursPerWeek`, `Date`, `MultimediaLink`, `AdvStatus`, `ACompany_ID`, `AdvertisementManager_Manager_Emp_ID`) VALUES (23, 'Amazon.com', 50, 120, '2014-03-08', 'galaxy/advertisements/10/Amazon.com', 'on hold', 10, 13);
INSERT INTO `mydb`.`Advertisement` (`Advertisement_ID`, `AdvName`, `PricePerHour`, `DurationInHoursPerWeek`, `Date`, `MultimediaLink`, `AdvStatus`, `ACompany_ID`, `AdvertisementManager_Manager_Emp_ID`) VALUES (24, 'Thanksgiving offers', 80, 150, '2014-03-20', 'galaxy/advertisements/11/Thanksgiving offers', 'approved', 11, 13);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Vendor`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Vendor` (`Account_ID`, `Company_Company_ID`) VALUES (1, 1);
INSERT INTO `mydb`.`Vendor` (`Account_ID`, `Company_Company_ID`) VALUES (2, 2);
INSERT INTO `mydb`.`Vendor` (`Account_ID`, `Company_Company_ID`) VALUES (3, 3);
INSERT INTO `mydb`.`Vendor` (`Account_ID`, `Company_Company_ID`) VALUES (4, 4);
INSERT INTO `mydb`.`Vendor` (`Account_ID`, `Company_Company_ID`) VALUES (5, 5);
INSERT INTO `mydb`.`Vendor` (`Account_ID`, `Company_Company_ID`) VALUES (6, 6);
INSERT INTO `mydb`.`Vendor` (`Account_ID`, `Company_Company_ID`) VALUES (7, 7);
INSERT INTO `mydb`.`Vendor` (`Account_ID`, `Company_Company_ID`) VALUES (8, 8);
INSERT INTO `mydb`.`Vendor` (`Account_ID`, `Company_Company_ID`) VALUES (9, 9);
INSERT INTO `mydb`.`Vendor` (`Account_ID`, `Company_Company_ID`) VALUES (10, 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`App`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`App` (`AProduct_ID`) VALUES (1);
INSERT INTO `mydb`.`App` (`AProduct_ID`) VALUES (2);
INSERT INTO `mydb`.`App` (`AProduct_ID`) VALUES (3);
INSERT INTO `mydb`.`App` (`AProduct_ID`) VALUES (4);
INSERT INTO `mydb`.`App` (`AProduct_ID`) VALUES (5);
INSERT INTO `mydb`.`App` (`AProduct_ID`) VALUES (6);
INSERT INTO `mydb`.`App` (`AProduct_ID`) VALUES (7);
INSERT INTO `mydb`.`App` (`AProduct_ID`) VALUES (8);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`ProductReview`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (1, 76, 1, 'Awesome', 'It is really Awesome', '2009-05-04 17:22:52', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (2, 98, 1, 'Good', 'It is really Good', '2009-06-20 22:26:58', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (3, 2, 28, 'Below Average', 'It is really Below Average', '2009-07-05 03:49:24', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (4, 10, 38, 'Bad', 'It is really Bad', '2009-07-18 07:31:05', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (5, 19, 1, 'Average', 'It is really Average', '2009-08-26 15:41:56', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (6, 60, 1, 'Awesome', 'It is really Awesome', '2009-08-28 11:38:35', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (7, 93, 1, 'Awesome', 'It is really Awesome', '2009-10-02 16:30:06', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (8, 2, 16, 'Bad', 'It is really Bad', '2009-10-05 07:00:05', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (9, 82, 1, 'Below Average', 'It is really Below Average', '2009-10-30 17:05:27', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (10, 74, 38, 'Bad', 'It is really Bad', '2009-11-17 16:33:13', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (11, 12, 1, 'Awesome', 'It is really Awesome', '2009-11-26 16:57:32', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (12, 48, 3, 'Below Average', 'It is really Below Average', '2010-01-25 12:22:33', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (13, 4, 16, 'Awesome', 'It is really Awesome', '2010-02-04 10:07:21', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (14, 39, 2, 'Below Average', 'It is really Below Average', '2010-02-11 04:20:17', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (15, 56, 2, 'Awesome', 'It is really Awesome', '2010-02-28 18:44:34', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (16, 3, 3, 'Awesome', 'It is really Awesome', '2010-04-17 00:47:06', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (17, 28, 1, 'Good', 'It is really Good', '2010-04-30 22:14:12', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (18, 34, 1, 'Awesome', 'It is really Awesome', '2010-05-04 08:47:38', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (19, 79, 3, 'Good', 'It is really Good', '2010-05-08 13:29:48', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (20, 73, 2, 'Bad', 'It is really Bad', '2010-05-30 08:48:58', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (21, 77, 2, 'Good', 'It is really Good', '2010-05-31 05:20:54', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (22, 11, 1, 'Bad', 'It is really Bad', '2010-06-19 08:58:35', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (23, 69, 2, 'Awesome', 'It is really Awesome', '2010-06-22 07:20:16', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (24, 86, 3, 'Below Average', 'It is really Below Average', '2010-06-24 16:36:38', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (25, 53, 4, 'Awesome', 'It is really Awesome', '2010-07-29 19:01:29', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (26, 61, 4, 'Below Average', 'It is really Below Average', '2010-08-06 07:51:06', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (27, 64, 2, 'Awesome', 'It is really Awesome', '2010-08-11 12:14:08', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (28, 74, 2, 'Bad', 'It is really Bad', '2010-09-08 14:32:46', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (29, 53, 5, 'Below Average', 'It is really Below Average', '2010-10-23 18:15:05', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (30, 21, 3, 'Good', 'It is really Good', '2010-11-08 02:28:17', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (31, 69, 38, 'Awesome', 'It is really Awesome', '2010-11-14 14:28:52', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (32, 61, 33, 'Bad', 'It is really Bad', '2010-11-20 23:44:37', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (33, 44, 5, 'Good', 'It is really Good', '2010-11-30 17:16:07', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (34, 46, 34, 'Awesome', 'It is really Awesome', '2010-12-10 03:06:28', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (35, 99, 1, 'Good', 'It is really Good', '2010-12-16 02:27:15', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (36, 65, 2, 'Awesome', 'It is really Awesome', '2010-12-20 00:46:13', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (37, 72, 5, 'Awesome', 'It is really Awesome', '2010-12-21 16:07:19', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (38, 48, 5, 'Bad', 'It is really Bad', '2010-12-24 03:33:58', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (39, 23, 5, 'Average', 'It is really Average', '2010-12-28 16:48:20', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (40, 44, 4, 'Good', 'It is really Good', '2010-12-28 12:23:42', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (41, 36, 1, 'Good', 'It is really Good', '2010-12-29 20:47:39', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (42, 72, 3, 'Awesome', 'It is really Awesome', '2011-01-14 21:27:27', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (43, 33, 3, 'Awesome', 'It is really Awesome', '2011-01-25 01:16:10', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (44, 44, 30, 'Bad', 'It is really Bad', '2011-02-23 08:49:30', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (45, 73, 23, 'Awesome', 'It is really Awesome', '2011-03-11 10:03:39', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (46, 51, 16, 'Average', 'It is really Average', '2011-03-15 08:45:30', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (47, 100, 2, 'Bad', 'It is really Bad', '2011-03-22 09:42:23', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (48, 2, 5, 'Below Average', 'It is really Below Average', '2011-03-26 02:32:12', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (49, 43, 6, 'Awesome', 'It is really Awesome', '2011-03-28 17:46:18', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (50, 100, 34, 'Good', 'It is really Good', '2011-03-30 11:33:19', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (51, 4, 28, 'Bad', 'It is really Bad', '2011-04-09 12:43:31', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (52, 7, 1, 'Bad', 'It is really Bad', '2011-04-15 09:55:22', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (53, 18, 2, 'Good', 'It is really Good', '2011-04-24 20:29:23', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (54, 14, 5, 'Below Average', 'It is really Below Average', '2011-05-05 01:23:39', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (55, 66, 6, 'Awesome', 'It is really Awesome', '2011-05-09 09:00:00', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (56, 16, 1, 'Bad', 'It is really Bad', '2011-05-18 06:18:50', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (57, 14, 6, 'Below Average', 'It is really Below Average', '2011-05-19 10:37:57', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (58, 26, 23, 'Below Average', 'It is really Below Average', '2011-05-22 05:17:05', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (59, 32, 16, 'Awesome', 'It is really Awesome', '2011-05-27 08:05:28', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (60, 50, 6, 'Bad', 'It is really Bad', '2011-06-04 07:00:54', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (61, 78, 21, 'Average', 'It is really Average', '2011-06-18 14:16:04', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (62, 88, 1, 'Bad', 'It is really Bad', '2011-07-06 10:49:14', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (63, 38, 5, 'Good', 'It is really Good', '2011-07-10 17:10:43', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (64, 32, 7, 'Average', 'It is really Average', '2011-07-14 04:57:13', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (65, 71, 6, 'Below Average', 'It is really Below Average', '2011-07-30 04:15:10', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (66, 87, 4, 'Good', 'It is really Good', '2011-08-03 05:04:35', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (67, 54, 6, 'Average', 'It is really Average', '2011-08-04 21:49:14', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (68, 95, 7, 'Good', 'It is really Good', '2011-08-05 22:03:14', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (69, 27, 3, 'Below Average', 'It is really Below Average', '2011-08-05 09:39:24', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (70, 52, 5, 'Awesome', 'It is really Awesome', '2011-08-06 00:45:08', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (71, 37, 38, 'Average', 'It is really Average', '2011-08-12 17:02:56', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (72, 74, 3, 'Awesome', 'It is really Awesome', '2011-08-13 12:00:08', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (73, 72, 4, 'Good', 'It is really Good', '2011-09-14 23:49:42', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (74, 98, 20, 'Below Average', 'It is really Below Average', '2011-09-14 02:12:55', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (75, 43, 2, 'Bad', 'It is really Bad', '2011-09-24 22:34:46', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (76, 47, 2, 'Below Average', 'It is really Below Average', '2011-09-24 07:55:34', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (77, 47, 7, 'Bad', 'It is really Bad', '2011-09-29 12:06:46', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (78, 39, 4, 'Bad', 'It is really Bad', '2011-10-02 07:50:47', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (79, 40, 20, 'Average', 'It is really Average', '2011-10-05 18:49:38', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (80, 97, 8, 'Bad', 'It is really Bad', '2011-10-06 10:25:33', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (81, 7, 16, 'Good', 'It is really Good', '2011-10-07 01:05:07', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (82, 62, 17, 'Average', 'It is really Average', '2011-10-15 01:25:53', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (83, 17, 3, 'Below Average', 'It is really Below Average', '2011-10-23 07:01:33', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (84, 17, 21, 'Good', 'It is really Good', '2011-10-25 14:02:44', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (85, 46, 3, 'Good', 'It is really Good', '2011-11-02 12:34:25', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (86, 75, 3, 'Awesome', 'It is really Awesome', '2011-11-05 16:29:46', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (87, 37, 1, 'Average', 'It is really Average', '2011-11-07 00:46:01', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (88, 45, 2, 'Average', 'It is really Average', '2011-11-10 06:03:37', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (89, 68, 7, 'Good', 'It is really Good', '2011-11-16 10:01:44', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (90, 38, 16, 'Bad', 'It is really Bad', '2011-11-19 06:40:57', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (91, 55, 5, 'Below Average', 'It is really Below Average', '2011-11-23 21:21:24', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (92, 73, 4, 'Average', 'It is really Average', '2011-11-27 19:11:30', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (93, 42, 7, 'Below Average', 'It is really Below Average', '2011-11-29 05:49:51', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (94, 1, 8, 'Awesome', 'It is really Awesome', '2011-11-30 21:39:04', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (95, 65, 6, 'Bad', 'It is really Bad', '2011-12-07 08:23:24', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (96, 46, 2, 'Good', 'It is really Good', '2011-12-10 23:38:29', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (97, 33, 1, 'Average', 'It is really Average', '2011-12-11 20:09:05', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (98, 99, 3, 'Below Average', 'It is really Below Average', '2011-12-24 04:39:45', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (99, 70, 1, 'Awesome', 'It is really Awesome', '2011-12-25 09:32:12', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (100, 75, 20, 'Average', 'It is really Average', '2012-01-01 22:22:19', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (101, 46, 6, 'Good', 'It is really Good', '2012-01-02 10:09:05', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (102, 78, 7, 'Average', 'It is really Average', '2012-01-08 14:07:59', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (103, 77, 16, 'Below Average', 'It is really Below Average', '2012-01-16 04:54:37', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (104, 9, 8, 'Bad', 'It is really Bad', '2012-01-17 22:32:50', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (105, 62, 5, 'Good', 'It is really Good', '2012-01-29 05:28:23', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (106, 95, 33, 'Awesome', 'It is really Awesome', '2012-02-02 04:30:29', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (107, 35, 17, 'Awesome', 'It is really Awesome', '2012-02-03 10:05:57', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (108, 78, 3, 'Below Average', 'It is really Below Average', '2012-02-10 16:07:12', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (109, 61, 9, 'Awesome', 'It is really Awesome', '2012-02-20 20:20:03', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (110, 69, 32, 'Awesome', 'It is really Awesome', '2012-02-21 11:46:27', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (111, 33, 20, 'Bad', 'It is really Bad', '2012-02-25 01:21:12', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (112, 22, 9, 'Awesome', 'It is really Awesome', '2012-03-03 10:34:13', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (113, 4, 1, 'Below Average', 'It is really Below Average', '2012-03-03 19:51:49', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (114, 14, 9, 'Good', 'It is really Good', '2012-03-05 00:00:00', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (115, 48, 16, 'Below Average', 'It is really Below Average', '2012-03-08 10:09:20', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (116, 18, 5, 'Good', 'It is really Good', '2012-03-11 07:37:25', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (117, 35, 9, 'Good', 'It is really Good', '2012-03-12 16:57:00', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (118, 77, 4, 'Bad', 'It is really Bad', '2012-03-14 10:51:54', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (119, 2, 7, 'Good', 'It is really Good', '2012-03-16 13:14:39', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (120, 7, 17, 'Below Average', 'It is really Below Average', '2012-03-20 03:22:17', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (121, 20, 30, 'Awesome', 'It is really Awesome', '2012-03-29 12:39:58', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (122, 78, 8, 'Bad', 'It is really Bad', '2012-03-29 06:29:02', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (123, 12, 9, 'Bad', 'It is really Bad', '2012-04-01 18:53:39', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (124, 64, 4, 'Bad', 'It is really Bad', '2012-04-21 20:29:46', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (125, 12, 2, 'Awesome', 'It is really Awesome', '2012-04-26 01:25:23', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (126, 25, 8, 'Awesome', 'It is really Awesome', '2012-05-01 04:22:55', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (127, 7, 8, 'Awesome', 'It is really Awesome', '2012-05-03 08:33:45', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (128, 47, 5, 'Awesome', 'It is really Awesome', '2012-05-07 09:30:47', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (129, 61, 5, 'Good', 'It is really Good', '2012-05-10 21:15:47', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (130, 57, 1, 'Awesome', 'It is really Awesome', '2012-05-14 22:48:17', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (131, 86, 9, 'Bad', 'It is really Bad', '2012-05-23 17:57:54', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (132, 20, 7, 'Average', 'It is really Average', '2012-05-24 09:31:03', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (133, 69, 4, 'Bad', 'It is really Bad', '2012-05-25 19:11:38', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (134, 89, 8, 'Bad', 'It is really Bad', '2012-06-14 09:42:43', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (135, 65, 16, 'Bad', 'It is really Bad', '2012-06-23 21:53:03', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (136, 72, 33, 'Awesome', 'It is really Awesome', '2012-06-24 19:47:43', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (137, 16, 9, 'Bad', 'It is really Bad', '2012-07-07 09:12:04', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (138, 3, 6, 'Bad', 'It is really Bad', '2012-07-09 16:07:30', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (139, 12, 16, 'Awesome', 'It is really Awesome', '2012-07-12 17:55:30', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (140, 67, 9, 'Awesome', 'It is really Awesome', '2012-07-30 10:49:51', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (141, 44, 6, 'Below Average', 'It is really Below Average', '2012-08-02 01:57:54', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (142, 98, 4, 'Awesome', 'It is really Awesome', '2012-08-02 21:08:46', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (143, 72, 10, 'Below Average', 'It is really Below Average', '2012-08-12 23:42:14', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (144, 61, 7, 'Awesome', 'It is really Awesome', '2012-08-15 16:39:55', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (145, 96, 5, 'Awesome', 'It is really Awesome', '2012-08-17 08:57:45', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (146, 37, 6, 'Bad', 'It is really Bad', '2012-08-22 08:35:01', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (147, 14, 16, 'Awesome', 'It is really Awesome', '2012-08-24 23:13:36', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (148, 33, 4, 'Awesome', 'It is really Awesome', '2012-09-01 11:00:06', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (149, 97, 34, 'Awesome', 'It is really Awesome', '2012-09-01 22:42:40', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (150, 7, 6, 'Below Average', 'It is really Below Average', '2012-09-14 15:39:25', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (151, 11, 4, 'Average', 'It is really Average', '2012-09-18 15:37:36', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (152, 70, 6, 'Awesome', 'It is really Awesome', '2012-09-23 14:16:02', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (153, 37, 2, 'Good', 'It is really Good', '2012-09-25 16:56:34', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (154, 62, 9, 'Awesome', 'It is really Awesome', '2012-09-26 03:16:21', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (155, 93, 33, 'Below Average', 'It is really Below Average', '2012-10-04 14:52:54', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (156, 1, 1, 'Average', 'It is really Average', '2012-10-05 10:59:46', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (157, 36, 3, 'Below Average', 'It is really Below Average', '2012-10-07 05:44:17', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (158, 3, 8, 'Average', 'It is really Average', '2012-10-14 12:44:45', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (159, 61, 20, 'Awesome', 'It is really Awesome', '2012-10-16 01:22:21', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (160, 24, 16, 'Good', 'It is really Good', '2012-10-30 13:32:48', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (161, 89, 3, 'Awesome', 'It is really Awesome', '2012-11-02 13:22:29', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (162, 32, 2, 'Bad', 'It is really Bad', '2012-11-03 23:46:09', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (163, 58, 30, 'Below Average', 'It is really Below Average', '2012-11-16 08:47:45', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (164, 21, 10, 'Bad', 'It is really Bad', '2012-11-22 12:53:52', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (165, 86, 10, 'Good', 'It is really Good', '2012-11-25 07:11:22', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (166, 44, 1, 'Bad', 'It is really Bad', '2012-12-05 20:57:20', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (167, 9, 9, 'Average', 'It is really Average', '2012-12-05 23:34:44', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (168, 96, 32, 'Average', 'It is really Average', '2012-12-05 09:36:28', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (169, 1, 5, 'Bad', 'It is really Bad', '2012-12-06 05:45:20', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (170, 69, 6, 'Below Average', 'It is really Below Average', '2012-12-13 12:55:52', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (171, 74, 6, 'Below Average', 'It is really Below Average', '2012-12-14 17:48:59', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (172, 95, 11, 'Below Average', 'It is really Below Average', '2012-12-26 12:51:50', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (173, 88, 10, 'Bad', 'It is really Bad', '2012-12-27 19:52:06', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (174, 21, 11, 'Awesome', 'It is really Awesome', '2012-12-27 20:41:37', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (175, 92, 16, 'Below Average', 'It is really Below Average', '2012-12-31 22:32:32', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (176, 46, 10, 'Awesome', 'It is really Awesome', '2013-01-13 18:24:25', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (177, 39, 33, 'Good', 'It is really Good', '2013-01-25 17:02:39', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (178, 55, 11, 'Average', 'It is really Average', '2013-01-25 16:50:30', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (179, 38, 21, 'Awesome', 'It is really Awesome', '2013-01-30 05:13:06', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (180, 98, 11, 'Awesome', 'It is really Awesome', '2013-02-08 16:46:48', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (181, 87, 2, 'Average', 'It is really Average', '2013-02-11 17:22:08', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (182, 64, 8, 'Bad', 'It is really Bad', '2013-02-12 17:03:50', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (183, 45, 9, 'Average', 'It is really Average', '2013-02-15 22:56:19', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (184, 22, 8, 'Awesome', 'It is really Awesome', '2013-02-16 04:53:45', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (185, 34, 4, 'Good', 'It is really Good', '2013-03-04 10:38:06', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (186, 60, 7, 'Awesome', 'It is really Awesome', '2013-03-05 03:36:13', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (187, 48, 37, 'Bad', 'It is really Bad', '2013-03-08 08:40:56', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (188, 79, 16, 'Good', 'It is really Good', '2013-03-14 09:51:05', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (189, 57, 16, 'Average', 'It is really Average', '2013-03-16 15:55:37', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (190, 76, 9, 'Good', 'It is really Good', '2013-03-17 20:20:13', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (191, 5, 7, 'Below Average', 'It is really Below Average', '2013-03-24 10:54:56', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (192, 9, 11, 'Below Average', 'It is really Below Average', '2013-03-24 05:58:17', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (193, 5, 5, 'Awesome', 'It is really Awesome', '2013-03-25 18:29:52', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (194, 54, 11, 'Good', 'It is really Good', '2013-03-26 05:16:52', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (195, 35, 10, 'Average', 'It is really Average', '2013-03-26 13:35:21', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (196, 83, 2, 'Good', 'It is really Good', '2013-03-27 11:31:28', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (197, 100, 11, 'Bad', 'It is really Bad', '2013-03-28 06:28:24', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (198, 75, 9, 'Below Average', 'It is really Below Average', '2013-04-04 00:44:58', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (199, 55, 9, 'Awesome', 'It is really Awesome', '2013-04-10 04:36:12', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (200, 27, 36, 'Good', 'It is really Good', '2013-04-11 16:30:08', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (201, 51, 2, 'Awesome', 'It is really Awesome', '2013-04-12 10:29:09', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (202, 57, 34, 'Bad', 'It is really Bad', '2013-04-15 00:40:47', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (203, 1, 10, 'Average', 'It is really Average', '2013-04-16 15:26:33', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (204, 79, 17, 'Average', 'It is really Average', '2013-04-20 14:08:21', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (205, 6, 11, 'Average', 'It is really Average', '2013-04-23 07:01:28', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (206, 62, 10, 'Average', 'It is really Average', '2013-04-23 01:04:39', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (207, 27, 11, 'Bad', 'It is really Bad', '2013-04-25 21:46:18', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (208, 59, 10, 'Good', 'It is really Good', '2013-04-30 21:16:58', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (209, 32, 32, 'Average', 'It is really Average', '2013-05-02 13:28:13', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (210, 9, 2, 'Awesome', 'It is really Awesome', '2013-05-07 15:06:54', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (211, 46, 8, 'Bad', 'It is really Bad', '2013-05-08 00:27:31', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (212, 75, 36, 'Bad', 'It is really Bad', '2013-05-11 03:33:22', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (213, 16, 36, 'Average', 'It is really Average', '2013-05-27 23:43:19', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (214, 25, 11, 'Awesome', 'It is really Awesome', '2013-05-28 21:41:37', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (215, 34, 11, 'Below Average', 'It is really Below Average', '2013-05-28 19:11:05', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (216, 19, 8, 'Awesome', 'It is really Awesome', '2013-06-02 20:50:08', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (217, 73, 11, 'Good', 'It is really Good', '2013-06-06 17:49:02', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (218, 71, 36, 'Bad', 'It is really Bad', '2013-06-07 03:36:15', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (219, 68, 16, 'Bad', 'It is really Bad', '2013-06-07 01:22:47', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (220, 79, 9, 'Good', 'It is really Good', '2013-06-10 17:19:32', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (221, 35, 16, 'Bad', 'It is really Bad', '2013-06-12 23:18:01', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (222, 46, 9, 'Awesome', 'It is really Awesome', '2013-06-18 11:56:07', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (223, 25, 2, 'Awesome', 'It is really Awesome', '2013-06-19 03:10:32', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (224, 47, 3, 'Awesome', 'It is really Awesome', '2013-06-30 01:08:18', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (225, 6, 31, 'Awesome', 'It is really Awesome', '2013-06-30 09:11:59', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (226, 86, 6, 'Bad', 'It is really Bad', '2013-07-02 16:47:10', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (227, 33, 6, 'Awesome', 'It is really Awesome', '2013-07-09 20:09:58', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (228, 28, 11, 'Below Average', 'It is really Below Average', '2013-07-12 04:38:53', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (229, 82, 7, 'Good', 'It is really Good', '2013-07-12 21:01:02', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (230, 83, 11, 'Average', 'It is really Average', '2013-07-16 22:00:17', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (231, 40, 10, 'Bad', 'It is really Bad', '2013-07-20 08:29:57', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (232, 43, 5, 'Below Average', 'It is really Below Average', '2013-07-26 04:35:52', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (233, 84, 8, 'Below Average', 'It is really Below Average', '2013-07-28 01:25:42', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (234, 46, 33, 'Average', 'It is really Average', '2013-08-03 00:10:14', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (235, 19, 16, 'Below Average', 'It is really Below Average', '2013-08-04 14:38:47', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (236, 4, 10, 'Awesome', 'It is really Awesome', '2013-08-04 14:51:58', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (237, 94, 32, 'Bad', 'It is really Bad', '2013-08-05 04:48:57', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (238, 94, 7, 'Good', 'It is really Good', '2013-08-07 02:25:42', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (239, 95, 12, 'Awesome', 'It is really Awesome', '2013-08-07 01:43:59', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (240, 78, 6, 'Average', 'It is really Average', '2013-08-07 16:54:14', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (241, 96, 1, 'Below Average', 'It is really Below Average', '2013-08-11 05:00:06', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (242, 52, 12, 'Awesome', 'It is really Awesome', '2013-08-15 22:03:58', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (243, 26, 6, 'Awesome', 'It is really Awesome', '2013-08-16 08:55:36', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (244, 51, 23, 'Below Average', 'It is really Below Average', '2013-08-17 23:47:57', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (245, 49, 13, 'Average', 'It is really Average', '2013-08-17 04:40:34', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (246, 49, 8, 'Awesome', 'It is really Awesome', '2013-08-19 23:02:46', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (247, 18, 4, 'Bad', 'It is really Bad', '2013-08-23 15:47:34', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (248, 35, 12, 'Average', 'It is really Average', '2013-08-27 02:25:09', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (249, 40, 4, 'Below Average', 'It is really Below Average', '2013-08-29 15:08:55', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (250, 20, 33, 'Awesome', 'It is really Awesome', '2013-08-31 21:44:08', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (251, 51, 5, 'Awesome', 'It is really Awesome', '2013-09-03 02:05:55', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (252, 15, 11, 'Awesome', 'It is really Awesome', '2013-09-06 17:56:42', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (253, 7, 10, 'Below Average', 'It is really Below Average', '2013-09-09 00:56:42', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (254, 60, 3, 'Average', 'It is really Average', '2013-09-10 02:06:59', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (255, 5, 16, 'Below Average', 'It is really Below Average', '2013-09-10 13:20:32', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (256, 81, 12, 'Bad', 'It is really Bad', '2013-09-13 07:09:44', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (257, 92, 28, 'Average', 'It is really Average', '2013-09-19 22:58:54', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (258, 47, 12, 'Awesome', 'It is really Awesome', '2013-09-20 19:37:45', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (259, 74, 10, 'Below Average', 'It is really Below Average', '2013-09-22 00:55:46', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (260, 27, 5, 'Below Average', 'It is really Below Average', '2013-09-25 01:25:16', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (261, 26, 16, 'Average', 'It is really Average', '2013-09-29 23:31:31', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (262, 60, 36, 'Average', 'It is really Average', '2013-09-30 13:53:34', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (263, 17, 1, 'Average', 'It is really Average', '2013-10-01 17:52:28', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (264, 74, 1, 'Good', 'It is really Good', '2013-10-01 01:20:21', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (265, 3, 31, 'Below Average', 'It is really Below Average', '2013-10-01 02:37:38', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (266, 100, 32, 'Good', 'It is really Good', '2013-10-07 16:51:27', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (267, 96, 16, 'Awesome', 'It is really Awesome', '2013-10-08 22:57:35', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (268, 98, 28, 'Awesome', 'It is really Awesome', '2013-10-09 20:34:26', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (269, 19, 2, 'Awesome', 'It is really Awesome', '2013-10-12 06:11:20', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (270, 37, 8, 'Below Average', 'It is really Below Average', '2013-10-13 13:07:44', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (271, 70, 39, 'Below Average', 'It is really Below Average', '2013-10-13 01:13:11', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (272, 54, 7, 'Below Average', 'It is really Below Average', '2013-10-15 06:15:04', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (273, 75, 12, 'Good', 'It is really Good', '2013-10-17 20:11:58', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (274, 1, 4, 'Below Average', 'It is really Below Average', '2013-10-19 22:02:47', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (275, 4, 6, 'Bad', 'It is really Bad', '2013-10-19 10:37:55', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (276, 70, 12, 'Good', 'It is really Good', '2013-10-22 01:00:27', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (277, 86, 16, 'Awesome', 'It is really Awesome', '2013-10-22 12:18:43', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (278, 44, 7, 'Good', 'It is really Good', '2013-10-27 10:40:56', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (279, 10, 3, 'Below Average', 'It is really Below Average', '2013-11-02 16:15:48', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (280, 20, 4, 'Below Average', 'It is really Below Average', '2013-11-07 23:47:34', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (281, 81, 10, 'Awesome', 'It is really Awesome', '2013-11-08 02:48:54', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (282, 88, 8, 'Good', 'It is really Good', '2013-11-08 03:31:55', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (283, 63, 6, 'Bad', 'It is really Bad', '2013-11-10 01:46:17', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (284, 74, 4, 'Bad', 'It is really Bad', '2013-11-11 02:11:13', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (285, 29, 9, 'Awesome', 'It is really Awesome', '2013-11-12 03:43:17', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (286, 50, 12, 'Good', 'It is really Good', '2013-11-13 10:55:36', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (287, 87, 3, 'Bad', 'It is really Bad', '2013-11-16 12:17:34', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (288, 18, 6, 'Bad', 'It is really Bad', '2013-11-28 02:56:41', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (289, 52, 4, 'Bad', 'It is really Bad', '2013-12-05 10:29:12', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (290, 59, 8, 'Below Average', 'It is really Below Average', '2013-12-10 14:45:18', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (291, 1, 13, 'Average', 'It is really Average', '2013-12-13 12:20:26', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (292, 90, 23, 'Bad', 'It is really Bad', '2013-12-17 17:10:12', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (293, 13, 5, 'Average', 'It is really Average', '2013-12-18 23:57:26', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (294, 46, 13, 'Average', 'It is really Average', '2013-12-18 11:24:34', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (295, 11, 12, 'Below Average', 'It is really Below Average', '2013-12-18 13:17:44', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (296, 95, 9, 'Awesome', 'It is really Awesome', '2013-12-18 12:02:56', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (297, 90, 24, 'Average', 'It is really Average', '2013-12-23 16:04:13', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (298, 67, 5, 'Average', 'It is really Average', '2013-12-23 10:39:53', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (299, 20, 12, 'Bad', 'It is really Bad', '2013-12-25 21:41:16', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (300, 54, 20, 'Average', 'It is really Average', '2013-12-27 06:00:36', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (301, 100, 4, 'Awesome', 'It is really Awesome', '2013-12-29 12:27:06', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (302, 5, 13, 'Below Average', 'It is really Below Average', '2014-01-01 02:56:34', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (303, 21, 4, 'Below Average', 'It is really Below Average', '2014-01-05 18:45:58', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (304, 26, 9, 'Bad', 'It is really Bad', '2014-01-08 04:47:12', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (305, 27, 13, 'Good', 'It is really Good', '2014-01-09 04:04:19', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (306, 18, 10, 'Awesome', 'It is really Awesome', '2014-01-09 05:43:52', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (307, 83, 20, 'Awesome', 'It is really Awesome', '2014-01-13 17:17:39', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (308, 20, 5, 'Awesome', 'It is really Awesome', '2014-01-14 15:01:09', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (309, 9, 12, 'Good', 'It is really Good', '2014-01-16 14:46:54', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (310, 37, 37, 'Bad', 'It is really Bad', '2014-01-17 04:53:17', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (311, 39, 5, 'Awesome', 'It is really Awesome', '2014-01-25 01:46:20', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (312, 17, 14, 'Average', 'It is really Average', '2014-01-25 01:24:59', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (313, 79, 39, 'Good', 'It is really Good', '2014-01-28 15:18:54', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (314, 2, 37, 'Good', 'It is really Good', '2014-02-01 02:02:39', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (315, 30, 5, 'Below Average', 'It is really Below Average', '2014-02-04 10:38:00', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (316, 56, 10, 'Good', 'It is really Good', '2014-02-06 11:16:16', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (317, 25, 12, 'Good', 'It is really Good', '2014-02-07 06:04:44', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (318, 98, 14, 'Awesome', 'It is really Awesome', '2014-02-08 09:00:56', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (319, 82, 6, 'Good', 'It is really Good', '2014-02-09 10:40:04', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (320, 1, 14, 'Bad', 'It is really Bad', '2014-02-11 08:10:02', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (321, 87, 1, 'Average', 'It is really Average', '2014-02-16 23:44:48', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (322, 17, 9, 'Below Average', 'It is really Below Average', '2014-02-18 22:37:23', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (323, 92, 7, 'Average', 'It is really Average', '2014-02-21 00:15:17', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (324, 7, 37, 'Average', 'It is really Average', '2014-02-23 18:03:39', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (325, 4, 13, 'Awesome', 'It is really Awesome', '2014-02-27 00:39:14', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (326, 22, 26, 'Awesome', 'It is really Awesome', '2014-02-28 11:50:14', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (327, 34, 13, 'Good', 'It is really Good', '2014-03-01 00:47:20', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (328, 33, 2, 'Average', 'It is really Average', '2014-03-10 14:12:20', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (329, 68, 1, 'Average', 'It is really Average', '2014-03-11 12:02:19', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (330, 44, 19, 'Bad', 'It is really Bad', '2014-03-14 13:20:10', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (331, 25, 9, 'Bad', 'It is really Bad', '2014-03-15 17:12:58', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (332, 65, 12, 'Awesome', 'It is really Awesome', '2014-03-20 09:54:11', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (333, 24, 11, 'Bad', 'It is really Bad', '2014-03-22 04:09:11', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (334, 62, 12, 'Awesome', 'It is really Awesome', '2014-03-22 03:19:49', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (335, 90, 1, 'Good', 'It is really Good', '2014-03-26 13:53:47', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (336, 34, 5, 'Bad', 'It is really Bad', '2014-03-26 12:28:24', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (337, 2, 9, 'Awesome', 'It is really Awesome', '2014-03-27 16:44:29', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (338, 64, 14, 'Below Average', 'It is really Below Average', '2014-03-28 20:52:39', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (339, 24, 8, 'Bad', 'It is really Bad', '2014-04-01 09:27:54', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (340, 26, 10, 'Awesome', 'It is really Awesome', '2014-04-01 22:49:48', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (341, 93, 14, 'Good', 'It is really Good', '2014-04-03 09:33:05', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (342, 73, 7, 'Good', 'It is really Good', '2014-04-03 13:53:35', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (343, 23, 13, 'Good', 'It is really Good', '2014-04-04 09:41:14', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (344, 61, 13, 'Bad', 'It is really Bad', '2014-04-04 19:16:38', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (345, 4, 11, 'Below Average', 'It is really Below Average', '2014-04-07 06:24:36', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (346, 57, 26, 'Bad', 'It is really Bad', '2014-04-08 18:37:15', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (347, 90, 7, 'Awesome', 'It is really Awesome', '2014-04-09 19:01:37', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (348, 28, 24, 'Average', 'It is really Average', '2014-04-10 04:45:14', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (349, 63, 12, 'Bad', 'It is really Bad', '2014-04-12 02:11:24', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (350, 92, 39, 'Average', 'It is really Average', '2014-04-12 03:43:57', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (351, 70, 8, 'Awesome', 'It is really Awesome', '2014-04-13 20:05:44', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (352, 41, 35, 'Below Average', 'It is really Below Average', '2014-04-15 16:54:02', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (353, 83, 29, 'Below Average', 'It is really Below Average', '2014-04-19 03:32:07', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (354, 85, 5, 'Good', 'It is really Good', '2014-04-21 21:30:48', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (355, 35, 21, 'Good', 'It is really Good', '2014-04-22 12:42:01', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (356, 28, 10, 'Below Average', 'It is really Below Average', '2014-04-22 03:02:48', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (357, 21, 14, 'Bad', 'It is really Bad', '2014-04-23 04:39:25', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (358, 32, 13, 'Below Average', 'It is really Below Average', '2014-04-25 23:32:20', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (359, 54, 12, 'Good', 'It is really Good', '2014-04-26 08:46:47', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (360, 49, 12, 'Bad', 'It is really Bad', '2014-04-26 02:25:48', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (361, 75, 11, 'Below Average', 'It is really Below Average', '2014-04-30 14:10:56', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (362, 26, 8, 'Awesome', 'It is really Awesome', '2014-05-03 05:46:07', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (363, 76, 3, 'Awesome', 'It is really Awesome', '2014-05-04 06:09:09', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (364, 84, 14, 'Good', 'It is really Good', '2014-05-06 21:15:52', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (365, 38, 13, 'Bad', 'It is really Bad', '2014-05-07 17:25:52', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (366, 51, 14, 'Bad', 'It is really Bad', '2014-05-08 19:46:24', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (367, 94, 9, 'Awesome', 'It is really Awesome', '2014-05-08 20:14:22', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (368, 99, 12, 'Bad', 'It is really Bad', '2014-05-08 21:28:06', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (369, 91, 10, 'Awesome', 'It is really Awesome', '2014-05-14 10:00:07', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (370, 92, 13, 'Awesome', 'It is really Awesome', '2014-05-15 11:59:00', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (371, 2, 33, 'Bad', 'It is really Bad', '2014-05-17 13:10:51', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (372, 13, 9, 'Good', 'It is really Good', '2014-05-17 05:17:13', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (373, 34, 6, 'Bad', 'It is really Bad', '2014-05-17 12:04:20', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (374, 26, 13, 'Awesome', 'It is really Awesome', '2014-05-17 08:17:22', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (375, 64, 12, 'Average', 'It is really Average', '2014-05-20 01:02:02', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (376, 39, 8, 'Good', 'It is really Good', '2014-05-21 17:38:56', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (377, 87, 29, 'Average', 'It is really Average', '2014-05-21 07:56:13', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (378, 79, 40, 'Average', 'It is really Average', '2014-05-22 20:36:11', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (379, 77, 26, 'Good', 'It is really Good', '2014-05-22 05:55:58', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (380, 91, 22, 'Bad', 'It is really Bad', '2014-05-24 13:42:34', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (381, 18, 7, 'Average', 'It is really Average', '2014-05-26 04:39:22', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (382, 94, 19, 'Good', 'It is really Good', '2014-05-28 06:54:52', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (383, 81, 19, 'Average', 'It is really Average', '2014-05-29 15:33:45', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (384, 22, 7, 'Below Average', 'It is really Below Average', '2014-05-31 03:43:26', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (385, 40, 14, 'Below Average', 'It is really Below Average', '2014-05-31 10:27:16', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (386, 31, 10, 'Below Average', 'It is really Below Average', '2014-06-01 15:27:42', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (387, 13, 14, 'Awesome', 'It is really Awesome', '2014-06-04 12:02:07', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (388, 54, 10, 'Awesome', 'It is really Awesome', '2014-06-04 12:51:19', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (389, 2, 8, 'Awesome', 'It is really Awesome', '2014-06-05 00:59:16', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (390, 64, 13, 'Average', 'It is really Average', '2014-06-06 06:15:01', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (391, 23, 1, 'Average', 'It is really Average', '2014-06-09 17:02:18', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (392, 33, 14, 'Awesome', 'It is really Awesome', '2014-06-10 03:37:19', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (393, 69, 14, 'Awesome', 'It is really Awesome', '2014-06-10 05:26:40', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (394, 79, 22, 'Good', 'It is really Good', '2014-06-18 11:06:58', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (395, 95, 35, 'Awesome', 'It is really Awesome', '2014-06-21 06:55:49', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (396, 17, 12, 'Average', 'It is really Average', '2014-06-21 20:48:02', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (397, 90, 13, 'Good', 'It is really Good', '2014-06-21 04:56:42', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (398, 76, 17, 'Below Average', 'It is really Below Average', '2014-06-22 08:34:02', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (399, 43, 21, 'Awesome', 'It is really Awesome', '2014-06-23 22:33:25', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (400, 12, 26, 'Below Average', 'It is really Below Average', '2014-06-24 08:55:02', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (401, 86, 13, 'Average', 'It is really Average', '2014-06-24 04:13:14', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (402, 99, 14, 'Awesome', 'It is really Awesome', '2014-06-25 20:05:12', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (403, 99, 2, 'Good', 'It is really Good', '2014-06-27 02:44:07', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (404, 5, 6, 'Awesome', 'It is really Awesome', '2014-06-28 03:52:16', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (405, 61, 2, 'Awesome', 'It is really Awesome', '2014-07-02 17:27:15', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (406, 12, 11, 'Awesome', 'It is really Awesome', '2014-07-02 00:43:30', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (407, 9, 7, 'Good', 'It is really Good', '2014-07-03 01:32:49', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (408, 69, 29, 'Bad', 'It is really Bad', '2014-07-04 19:53:41', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (409, 96, 14, 'Good', 'It is really Good', '2014-07-04 04:20:55', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (410, 88, 14, 'Below Average', 'It is really Below Average', '2014-07-05 09:40:07', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (411, 89, 2, 'Bad', 'It is really Bad', '2014-07-05 04:31:06', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (412, 84, 12, 'Below Average', 'It is really Below Average', '2014-07-07 09:15:21', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (413, 13, 13, 'Awesome', 'It is really Awesome', '2014-07-08 21:10:07', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (414, 60, 40, 'Good', 'It is really Good', '2014-07-08 23:51:58', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (415, 8, 38, 'Good', 'It is really Good', '2014-07-09 18:36:47', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (416, 79, 5, 'Bad', 'It is really Bad', '2014-07-09 22:05:04', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (417, 94, 14, 'Below Average', 'It is really Below Average', '2014-07-09 16:53:10', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (418, 17, 16, 'Below Average', 'It is really Below Average', '2014-07-09 01:50:38', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (419, 2, 14, 'Bad', 'It is really Bad', '2014-07-10 09:11:29', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (420, 5, 12, 'Awesome', 'It is really Awesome', '2014-07-10 12:51:05', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (421, 74, 12, 'Awesome', 'It is really Awesome', '2014-07-13 18:46:47', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (422, 93, 6, 'Awesome', 'It is really Awesome', '2014-07-14 09:13:26', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (423, 33, 12, 'Below Average', 'It is really Below Average', '2014-07-15 10:11:28', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (424, 48, 32, 'Average', 'It is really Average', '2014-07-15 17:12:40', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (425, 8, 11, 'Below Average', 'It is really Below Average', '2014-07-16 11:56:00', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (426, 48, 35, 'Good', 'It is really Good', '2014-07-18 00:49:23', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (427, 68, 3, 'Awesome', 'It is really Awesome', '2014-07-19 23:03:17', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (428, 30, 14, 'Awesome', 'It is really Awesome', '2014-07-19 03:13:09', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (429, 66, 12, 'Awesome', 'It is really Awesome', '2014-07-21 18:00:28', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (430, 24, 35, 'Bad', 'It is really Bad', '2014-07-22 16:16:01', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (431, 59, 1, 'Good', 'It is really Good', '2014-07-23 07:22:40', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (432, 73, 5, 'Average', 'It is really Average', '2014-07-23 10:28:19', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (433, 39, 14, 'Awesome', 'It is really Awesome', '2014-07-23 18:05:31', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (434, 77, 15, 'Good', 'It is really Good', '2014-07-24 00:15:07', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (435, 74, 11, 'Awesome', 'It is really Awesome', '2014-07-26 23:11:03', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (436, 34, 27, 'Awesome', 'It is really Awesome', '2014-07-30 09:48:50', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (437, 29, 37, 'Good', 'It is really Good', '2014-07-31 07:26:13', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (438, 70, 35, 'Good', 'It is really Good', '2014-08-01 06:14:17', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (439, 24, 13, 'Below Average', 'It is really Below Average', '2014-08-01 18:52:03', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (440, 57, 13, 'Bad', 'It is really Bad', '2014-08-02 12:39:27', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (441, 26, 11, 'Bad', 'It is really Bad', '2014-08-06 08:41:24', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (442, 40, 13, 'Bad', 'It is really Bad', '2014-08-07 09:44:40', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (443, 35, 14, 'Average', 'It is really Average', '2014-08-08 15:13:37', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (444, 14, 13, 'Awesome', 'It is really Awesome', '2014-08-08 20:15:07', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (445, 76, 10, 'Good', 'It is really Good', '2014-08-08 12:48:48', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (446, 43, 28, 'Bad', 'It is really Bad', '2014-08-09 15:53:46', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (447, 78, 31, 'Awesome', 'It is really Awesome', '2014-08-09 02:51:11', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (448, 84, 9, 'Good', 'It is really Good', '2014-08-15 00:29:26', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (449, 18, 12, 'Below Average', 'It is really Below Average', '2014-08-16 22:20:46', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (450, 31, 40, 'Below Average', 'It is really Below Average', '2014-08-18 23:47:08', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (451, 69, 3, 'Bad', 'It is really Bad', '2014-08-20 12:30:52', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (452, 43, 40, 'Below Average', 'It is really Below Average', '2014-08-21 08:57:43', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (453, 15, 24, 'Awesome', 'It is really Awesome', '2014-08-23 07:24:16', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (454, 89, 18, 'Bad', 'It is really Bad', '2014-08-27 15:38:52', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (455, 52, 14, 'Awesome', 'It is really Awesome', '2014-08-29 16:39:02', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (456, 98, 10, 'Awesome', 'It is really Awesome', '2014-08-31 22:59:09', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (457, 37, 7, 'Average', 'It is really Average', '2014-09-03 01:04:39', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (458, 42, 8, 'Awesome', 'It is really Awesome', '2014-09-04 10:02:24', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (459, 72, 12, 'Awesome', 'It is really Awesome', '2014-09-04 01:18:45', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (460, 3, 15, 'Average', 'It is really Average', '2014-09-05 14:20:49', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (461, 27, 18, 'Below Average', 'It is really Below Average', '2014-09-06 16:33:30', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (462, 6, 4, 'Bad', 'It is really Bad', '2014-09-07 03:52:35', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (463, 21, 16, 'Awesome', 'It is really Awesome', '2014-09-07 03:09:51', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (464, 17, 4, 'Good', 'It is really Good', '2014-09-09 03:23:35', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (465, 85, 15, 'Below Average', 'It is really Below Average', '2014-09-10 13:25:53', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (466, 38, 14, 'Bad', 'It is really Bad', '2014-09-10 12:02:42', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (467, 30, 32, 'Bad', 'It is really Bad', '2014-09-11 23:21:02', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (468, 2, 1, 'Good', 'It is really Good', '2014-09-11 09:30:07', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (469, 45, 29, 'Awesome', 'It is really Awesome', '2014-09-11 07:19:07', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (470, 32, 15, 'Awesome', 'It is really Awesome', '2014-09-12 02:19:09', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (471, 28, 15, 'Awesome', 'It is really Awesome', '2014-09-16 18:52:06', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (472, 58, 14, 'Bad', 'It is really Bad', '2014-09-17 07:31:44', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (473, 86, 8, 'Bad', 'It is really Bad', '2014-09-19 20:15:14', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (474, 37, 14, 'Bad', 'It is really Bad', '2014-09-20 04:37:28', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (475, 74, 13, 'Average', 'It is really Average', '2014-09-22 22:07:18', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (476, 22, 13, 'Below Average', 'It is really Below Average', '2014-09-25 23:20:08', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (477, 98, 36, 'Average', 'It is really Average', '2014-09-25 00:49:34', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (478, 65, 5, 'Bad', 'It is really Bad', '2014-09-26 03:17:59', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (479, 66, 9, 'Bad', 'It is really Bad', '2014-09-30 05:59:26', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (480, 58, 20, 'Bad', 'It is really Bad', '2014-09-30 04:10:51', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (481, 53, 13, 'Bad', 'It is really Bad', '2014-10-01 03:03:31', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (482, 62, 35, 'Awesome', 'It is really Awesome', '2014-10-01 00:55:36', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (483, 24, 24, 'Good', 'It is really Good', '2014-10-01 20:15:57', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (484, 2, 29, 'Good', 'It is really Good', '2014-10-03 18:52:09', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (485, 94, 11, 'Bad', 'It is really Bad', '2014-10-03 11:19:54', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (486, 56, 36, 'Good', 'It is really Good', '2014-10-04 02:01:36', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (487, 85, 9, 'Average', 'It is really Average', '2014-10-04 10:53:11', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (488, 6, 6, 'Awesome', 'It is really Awesome', '2014-10-05 06:22:02', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (489, 74, 8, 'Awesome', 'It is really Awesome', '2014-10-06 23:54:51', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (490, 98, 12, 'Below Average', 'It is really Below Average', '2014-10-06 06:42:20', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (491, 81, 31, 'Bad', 'It is really Bad', '2014-10-07 07:55:01', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (492, 20, 15, 'Below Average', 'It is really Below Average', '2014-10-07 20:35:06', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (493, 17, 13, 'Bad', 'It is really Bad', '2014-10-07 19:03:49', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (494, 84, 7, 'Good', 'It is really Good', '2014-10-08 11:43:08', 3);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (495, 31, 14, 'Average', 'It is really Average', '2014-10-08 05:30:25', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (496, 94, 8, 'Below Average', 'It is really Below Average', '2014-10-09 03:34:34', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (497, 58, 12, 'Bad', 'It is really Bad', '2014-10-12 10:54:16', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (498, 41, 14, 'Awesome', 'It is really Awesome', '2014-10-13 13:32:20', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (499, 61, 19, 'Awesome', 'It is really Awesome', '2014-10-14 16:16:08', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (500, 53, 18, 'Bad', 'It is really Bad', '2014-10-15 20:17:39', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (501, 46, 15, 'Below Average', 'It is really Below Average', '2014-10-16 05:25:58', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (502, 100, 35, 'Bad', 'It is really Bad', '2014-10-16 01:43:27', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (503, 76, 37, 'Bad', 'It is really Bad', '2014-10-18 03:11:05', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (504, 79, 8, 'Average', 'It is really Average', '2014-10-21 19:02:18', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (505, 73, 1, 'Below Average', 'It is really Below Average', '2014-10-21 00:41:42', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (506, 67, 15, 'Average', 'It is really Average', '2014-10-22 16:32:41', 2.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (507, 88, 9, 'Bad', 'It is really Bad', '2014-10-27 18:08:45', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (508, 56, 15, 'Below Average', 'It is really Below Average', '2014-10-30 08:17:35', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (509, 24, 5, 'Below Average', 'It is really Below Average', '2014-11-01 02:48:43', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (510, 27, 16, 'Awesome', 'It is really Awesome', '2014-11-02 06:01:40', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (511, 46, 12, 'Average', 'It is really Average', '2014-11-02 07:43:21', 2);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (512, 3, 26, 'Below Average', 'It is really Below Average', '2014-11-02 22:45:28', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (513, 55, 16, 'Awesome', 'It is really Awesome', '2014-11-04 22:55:42', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (514, 76, 14, 'Below Average', 'It is really Below Average', '2014-11-04 02:08:47', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (515, 69, 15, 'Below Average', 'It is really Below Average', '2014-11-05 06:18:50', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (516, 53, 16, 'Below Average', 'It is really Below Average', '2014-11-06 03:54:40', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (517, 83, 15, 'Awesome', 'It is really Awesome', '2014-11-09 08:51:31', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (518, 44, 11, 'Bad', 'It is really Bad', '2014-11-11 12:59:36', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (519, 39, 1, 'Awesome', 'It is really Awesome', '2014-11-12 07:15:25', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (520, 53, 7, 'Awesome', 'It is really Awesome', '2014-11-13 18:02:27', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (521, 1, 30, 'Awesome', 'It is really Awesome', '2014-11-13 15:07:24', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (522, 4, 15, 'Below Average', 'It is really Below Average', '2014-11-14 09:35:30', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (523, 14, 15, 'Awesome', 'It is really Awesome', '2014-11-14 13:19:47', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (524, 26, 29, 'Below Average', 'It is really Below Average', '2014-11-15 04:12:29', 1);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (525, 87, 15, 'Awesome', 'It is really Awesome', '2014-11-17 05:09:27', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (526, 82, 5, 'Awesome', 'It is really Awesome', '2014-11-18 22:45:20', 4.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (527, 70, 15, 'Bad', 'It is really Bad', '2014-11-20 11:27:55', 0);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (528, 85, 10, 'Awesome', 'It is really Awesome', '2014-11-21 18:07:24', 5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (529, 65, 15, 'Bad', 'It is really Bad', '2014-11-21 06:05:16', 0.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (530, 73, 15, 'Below Average', 'It is really Below Average', '2014-11-22 18:07:10', 1.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (531, 41, 15, 'Awesome', 'It is really Awesome', '2014-11-23 09:54:08', 4);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (532, 35, 15, 'Good', 'It is really Good', '2014-11-23 16:32:42', 3.5);
INSERT INTO `mydb`.`ProductReview` (`Review_ID`, `User_ID`, `Product_ID`, `ReviewTitle`, `ReviewDescription`, `ReviewDate`, `ProdRating`) VALUES (533, 95, 16, 'Awesome', 'It is really Awesome', '2014-11-25 01:04:00', 5);

COMMIT;

