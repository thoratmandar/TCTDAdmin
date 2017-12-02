-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
SHOW WARNINGS;
-- -----------------------------------------------------
-- Schema tatacenterdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `tatacenterdb` ;

-- -----------------------------------------------------
-- Schema tatacenterdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tatacenterdb` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `tatacenterdb` ;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`userprofile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`userprofile` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`userprofile` (
  `UserId` CHAR(38) NOT NULL,
  `UserRefId` INT(11) NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(50) NULL DEFAULT NULL,
  `MiddleName` VARCHAR(50) NULL DEFAULT NULL,
  `LastName` VARCHAR(50) NULL DEFAULT NULL,
  `DateOfBirth` DATE NULL DEFAULT NULL,
  `IsActive` BIT(1) NULL DEFAULT NULL,
  `IsDelete` BIT(1) NULL DEFAULT NULL,
  `EmailId` VARCHAR(150) NULL DEFAULT NULL,
  `Photo` VARCHAR(500) NULL DEFAULT NULL,
  `ContactNumber` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`UserId`),
  UNIQUE INDEX `UserRefId_UNIQUE` (`UserRefId` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`master_professor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`master_professor` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`master_professor` (
  `Pr_Id` INT(11) NOT NULL AUTO_INCREMENT,
  `Description` VARCHAR(100) NULL DEFAULT NULL,
  `OrderBy` INT(11) NULL DEFAULT NULL,
  `IsActive` BIT(1) NULL DEFAULT NULL,
  `IsDelete` BIT(1) NULL DEFAULT NULL,
  `AddedBy` CHAR(38) NULL DEFAULT NULL,
  `AddedDate` DATETIME NULL DEFAULT NULL,
  `UpdatedBy` CHAR(38) NULL DEFAULT NULL,
  `UpdatedDate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`Pr_Id`),
  INDEX `master_professor_userprofile_addedby_idx` (`AddedBy` ASC),
  INDEX `master_professor_userprofile_updatedby_idx` (`UpdatedBy` ASC),
  CONSTRAINT `master_professor_userprofile_addedby`
    FOREIGN KEY (`AddedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `master_professor_userprofile_updatedby`
    FOREIGN KEY (`UpdatedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`master_department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`master_department` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`master_department` (
  `Dept_Id` INT NOT NULL AUTO_INCREMENT,
  `Dept_Name` VARCHAR(250) NULL,
  `OrderBy` INT NULL,
  `IsActive` BIT NULL,
  `IsDelete` BIT NULL,
  `AddedBy` CHAR(38) NULL,
  `AddedDate` DATETIME NULL,
  `UpdatedBy` CHAR(38) NULL,
  `UpdatedDate` DATETIME NULL,
  PRIMARY KEY (`Dept_Id`),
  INDEX `masterdepartment_userprofile_addedby_idx` (`AddedBy` ASC),
  INDEX `masterdepartment_userprofile_updatedby_idx` (`UpdatedBy` ASC),
  CONSTRAINT `masterdepartment_userprofile_addedby`
    FOREIGN KEY (`AddedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `masterdepartment_userprofile_updatedby`
    FOREIGN KEY (`UpdatedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`professor_detail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`professor_detail` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`professor_detail` (
  `Id` CHAR(38) NOT NULL,
  `Title` VARCHAR(10) NULL DEFAULT NULL,
  `FirstName` VARCHAR(50) NULL DEFAULT NULL,
  `MiddleName` VARCHAR(50) NULL DEFAULT NULL,
  `LastName` VARCHAR(50) NULL DEFAULT NULL,
  `ProfileImage` VARCHAR(250) NULL DEFAULT NULL,
  `Pr_Id` INT(11) NULL DEFAULT NULL,
  `ProfileLink` VARCHAR(500) NULL DEFAULT NULL,
  `RoleInTCTD` VARCHAR(250) NULL DEFAULT NULL,
  `RoleInIITB` VARCHAR(500) NULL DEFAULT NULL,
  `ContactNumber` VARCHAR(15) NULL DEFAULT NULL,
  `EmailId` VARCHAR(50) NULL DEFAULT NULL,
  `Fax` VARCHAR(15) NULL DEFAULT NULL,
  `DeptId` INT(11) NULL DEFAULT NULL,
  `IsDelete` BIT(1) NULL DEFAULT NULL,
  `AddedBy` CHAR(38) NULL DEFAULT NULL,
  `AddedDate` DATETIME NULL DEFAULT NULL,
  `UpdatedBy` CHAR(38) NULL DEFAULT NULL,
  `UpdatedDate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `professordetail_masterprofessor_prid_idx` (`Pr_Id` ASC),
  INDEX `professordetail_userprofile_addedby_idx` (`AddedBy` ASC),
  INDEX `professordetail_userprofile_updatedby_idx` (`UpdatedBy` ASC),
  INDEX `professordetail_masterdepartment_deptid_idx` (`DeptId` ASC),
  CONSTRAINT `professordetail_masterprofessor_prid`
    FOREIGN KEY (`Pr_Id`)
    REFERENCES `tatacenterdb`.`master_professor` (`Pr_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `professordetail_userprofile_addedby`
    FOREIGN KEY (`AddedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `professordetail_userprofile_updatedby`
    FOREIGN KEY (`UpdatedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `professordetail_masterdepartment_deptid`
    FOREIGN KEY (`DeptId`)
    REFERENCES `tatacenterdb`.`master_department` (`Dept_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`staff_detail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`staff_detail` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`staff_detail` (
  `Id` CHAR(38) NOT NULL,
  `Title` VARCHAR(5) NULL DEFAULT NULL,
  `FirstName` VARCHAR(50) NULL DEFAULT NULL,
  `MiddleName` VARCHAR(50) NULL DEFAULT NULL,
  `LastName` VARCHAR(50) NULL DEFAULT NULL,
  `EmployeeCode` VARCHAR(15) NULL DEFAULT NULL,
  `Designation` VARCHAR(100) NULL DEFAULT NULL,
  `Achievements` VARCHAR(1000) NULL DEFAULT NULL,
  `ProfileImage` VARCHAR(250) NULL DEFAULT NULL,
  `ContactNumber` VARCHAR(15) NULL DEFAULT NULL,
  `EmailId` VARCHAR(50) NULL DEFAULT NULL,
  `Fax` VARCHAR(15) NULL DEFAULT NULL,
  `Hobbies` VARCHAR(500) NULL DEFAULT NULL,
  `JobDescription` VARCHAR(1000) NULL DEFAULT NULL,
  `IsDelete` BIT(1) NULL DEFAULT NULL,
  `AddedBy` CHAR(38) NULL DEFAULT NULL,
  `AddedDate` DATETIME NULL DEFAULT NULL,
  `UpdatedBy` BIT(1) NULL DEFAULT NULL,
  `UpdatedDate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`master_people`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`master_people` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`master_people` (
  `Pl_Id` INT(11) NOT NULL AUTO_INCREMENT,
  `Description` VARCHAR(100) NULL DEFAULT NULL,
  `OrderBy` INT(11) NULL DEFAULT NULL,
  `IsActive` BIT(1) NULL DEFAULT NULL,
  `IsDelete` BIT(1) NULL DEFAULT NULL,
  `AddedBy` CHAR(38) NULL DEFAULT NULL,
  `AddedDate` DATETIME NULL DEFAULT NULL,
  `UpdatedBy` CHAR(38) NULL DEFAULT NULL,
  `UpdatedDate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`Pl_Id`),
  INDEX `master_people_userprofile_updatedby_idx` (`UpdatedBy` ASC),
  INDEX `master_people_userprofile_addedby_idx` (`AddedBy` ASC),
  CONSTRAINT `master_people_userprofile_addedby`
    FOREIGN KEY (`AddedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `master_people_userprofile_updatedby`
    FOREIGN KEY (`UpdatedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`academicbackground_people`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`academicbackground_people` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`academicbackground_people` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `P_Id` CHAR(38) NULL DEFAULT NULL,
  `AcademicRecord` VARCHAR(500) NULL DEFAULT NULL,
  `Pl_Id` INT(11) NULL DEFAULT NULL,
  `IsDelete` BIT(1) NULL DEFAULT NULL,
  `AddedBy` CHAR(38) NULL DEFAULT NULL,
  `AddedDate` DATETIME NULL DEFAULT NULL,
  `UpdatedBy` CHAR(38) NULL DEFAULT NULL,
  `UpdatedDate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `academicbackgroundpeople_professordetail_pid_idx` (`P_Id` ASC),
  INDEX `academicbackgroundpeople_masterpeople_plid_idx` (`Pl_Id` ASC),
  INDEX `academicbackgroundpeople_userprofile_addedby_idx` (`AddedBy` ASC),
  INDEX `academicbackgroundpeople_userprofile_updatedby_idx` (`UpdatedBy` ASC),
  CONSTRAINT `academicbackgroundpeople_professordetail_pid`
    FOREIGN KEY (`P_Id`)
    REFERENCES `tatacenterdb`.`professor_detail` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `academicbackgroundpeople_staffdetail_pid`
    FOREIGN KEY (`P_Id`)
    REFERENCES `tatacenterdb`.`staff_detail` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `academicbackgroundpeople_masterpeople_plid`
    FOREIGN KEY (`Pl_Id`)
    REFERENCES `tatacenterdb`.`master_people` (`Pl_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `academicbackgroundpeople_userprofile_addedby`
    FOREIGN KEY (`AddedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `academicbackgroundpeople_userprofile_updatedby`
    FOREIGN KEY (`UpdatedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`awards_honours_professor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`awards_honours_professor` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`awards_honours_professor` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `Pr_Id` CHAR(38) NULL DEFAULT NULL,
  `Description` VARCHAR(1000) NULL DEFAULT NULL,
  `IsDelete` BIT(1) NULL DEFAULT NULL,
  `AddedBy` CHAR(38) NULL DEFAULT NULL,
  `AddedDate` DATETIME NULL DEFAULT NULL,
  `UpdatedBy` CHAR(38) NULL DEFAULT NULL,
  `UpdatedDate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `awardshonoursprofessor_professordetail_prid_idx` (`Pr_Id` ASC),
  INDEX `awardshonoursprofessor_userprofile_addedby_idx` (`AddedBy` ASC),
  INDEX `awardshonoursprofessor_userprofile_updatedby_idx` (`UpdatedBy` ASC),
  CONSTRAINT `awardshonoursprofessor_professordetail_prid`
    FOREIGN KEY (`Pr_Id`)
    REFERENCES `tatacenterdb`.`professor_detail` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `awardshonoursprofessor_userprofile_addedby`
    FOREIGN KEY (`AddedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `awardshonoursprofessor_userprofile_updatedby`
    FOREIGN KEY (`UpdatedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`master_projectdomain`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`master_projectdomain` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`master_projectdomain` (
  `Pd_Id` INT(11) NOT NULL AUTO_INCREMENT,
  `Description` VARCHAR(150) NULL DEFAULT NULL,
  `TextColor` VARCHAR(45) NULL DEFAULT NULL,
  `OrderBy` INT(11) NULL DEFAULT NULL,
  `IsActive` BIT(1) NULL DEFAULT NULL,
  `IsDelete` BIT(1) NULL DEFAULT NULL,
  `Addedby` CHAR(38) NULL DEFAULT NULL,
  `AddedDate` DATETIME NULL DEFAULT NULL,
  `UpdatedBy` CHAR(38) NULL DEFAULT NULL,
  `UpdatedDate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`Pd_Id`),
  INDEX `master_projectdomain_userprofile_addedby_idx` (`Addedby` ASC),
  INDEX `master_projectdomain_userprofile_updatedby_idx` (`UpdatedBy` ASC),
  CONSTRAINT `master_projectdomain_userprofile_addedby`
    FOREIGN KEY (`Addedby`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `master_projectdomain_userprofile_updatedby`
    FOREIGN KEY (`UpdatedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`master_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`master_status` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`master_status` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Description` VARCHAR(45) NULL,
  `IsActive` BIT NULL,
  `IsDelete` BIT NULL,
  `AddedBy` CHAR(38) NULL,
  `AddedDate` DATETIME NULL,
  `UpdatedBy` CHAR(38) NULL,
  `UpdatedDate` DATETIME NULL,
  PRIMARY KEY (`Id`),
  INDEX `masterstatus_userprofile_addedby_idx` (`AddedBy` ASC),
  INDEX `masterstatus_userprofile_updatedby_idx` (`UpdatedBy` ASC),
  CONSTRAINT `masterstatus_userprofile_addedby`
    FOREIGN KEY (`AddedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `masterstatus_userprofile_updatedby`
    FOREIGN KEY (`UpdatedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`project_detail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`project_detail` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`project_detail` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `ProjectName` VARCHAR(500) NULL DEFAULT NULL,
  `ProjectDomain_Id` INT(11) NULL DEFAULT NULL,
  `Project_Brief` LONGTEXT NULL DEFAULT NULL,
  `Grant` VARCHAR(50) NULL DEFAULT NULL,
  `ProjectStartDate` DATE NULL DEFAULT NULL,
  `ProjectEndDate` DATE NULL DEFAULT NULL,
  `Status` INT(11) NULL DEFAULT NULL,
  `Project_Date` DATE NULL DEFAULT NULL,
  `AddedBy` CHAR(38) NULL DEFAULT NULL,
  `AddedDate` DATETIME NULL DEFAULT NULL,
  `UpdatedBy` CHAR(38) NULL DEFAULT NULL,
  `UpdatedDate` DATETIME NULL DEFAULT NULL,
  `IsDelete` BIT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `projectdetail_masterprojectdomain_projectdomainid_idx` (`ProjectDomain_Id` ASC),
  INDEX `projectdetail_userprofile_addedby_idx` (`AddedBy` ASC),
  INDEX `projectdetail_userprofile_updatedby_idx` (`UpdatedBy` ASC),
  INDEX `projectdetail_masterstatus_statusid_idx` (`Status` ASC),
  CONSTRAINT `projectdetail_masterprojectdomain_projectdomainid`
    FOREIGN KEY (`ProjectDomain_Id`)
    REFERENCES `tatacenterdb`.`master_projectdomain` (`Pd_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `projectdetail_userprofile_addedby`
    FOREIGN KEY (`AddedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `projectdetail_userprofile_updatedby`
    FOREIGN KEY (`UpdatedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `projectdetail_masterstatus_statusid`
    FOREIGN KEY (`Status`)
    REFERENCES `tatacenterdb`.`master_status` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`copyrights_project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`copyrights_project` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`copyrights_project` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(500) NULL DEFAULT NULL,
  `Copyright_Detail` TEXT NULL DEFAULT NULL,
  `Copyright_Image` VARCHAR(500) NULL DEFAULT NULL,
  `Project_Id` INT(11) NULL DEFAULT NULL,
  `AddedDate` DATETIME NULL DEFAULT NULL,
  `AddedBy` CHAR(38) NULL DEFAULT NULL,
  `UpdatedDate` DATETIME NULL DEFAULT NULL,
  `UpdatedBy` CHAR(38) NULL DEFAULT NULL,
  `IsDelete` BIT(1) NULL DEFAULT NULL,
  `Copyright_Date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `copyrightsproject_projectdetail_projectid_idx` (`Project_Id` ASC),
  INDEX `copyrightsproject_userprofilel_projectid_idx` (`AddedBy` ASC),
  INDEX `copyrightsproject_userprofile_updatedby_idx` (`UpdatedBy` ASC),
  CONSTRAINT `copyrightsproject_projectdetail_projectid`
    FOREIGN KEY (`Project_Id`)
    REFERENCES `tatacenterdb`.`project_detail` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `copyrightsproject_userprofile_addedby`
    FOREIGN KEY (`AddedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `copyrightsproject_userprofile_updatedby`
    FOREIGN KEY (`UpdatedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`master_fellow_year`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`master_fellow_year` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`master_fellow_year` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `StartYear` VARCHAR(45) NULL DEFAULT NULL,
  `EndYear` VARCHAR(45) NULL DEFAULT NULL,
  `OrderBy` INT(11) NULL DEFAULT NULL,
  `IsActive` BIT(1) NULL DEFAULT NULL,
  `IsDelete` BIT(1) NULL DEFAULT NULL,
  `AddedBy` CHAR(38) NULL DEFAULT NULL,
  `AddedDate` DATETIME NULL DEFAULT NULL,
  `UpdatedBy` CHAR(38) NULL DEFAULT NULL,
  `UpdatedDate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `master_fellow_year_userprofile_addedby_idx` (`AddedBy` ASC),
  INDEX `master_fellow_year_userprofile_updatedby_idx` (`UpdatedBy` ASC),
  CONSTRAINT `master_fellow_year_userprofile_addedby`
    FOREIGN KEY (`AddedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `master_fellow_year_userprofile_updatedby`
    FOREIGN KEY (`UpdatedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`fellow_detail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`fellow_detail` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`fellow_detail` (
  `Id` CHAR(38) NOT NULL,
  `Title` VARCHAR(10) NULL DEFAULT NULL,
  `FirstName` VARCHAR(50) NULL DEFAULT NULL,
  `MiddleName` VARCHAR(50) NULL DEFAULT NULL,
  `LastName` VARCHAR(50) NULL DEFAULT NULL,
  `ProfileImage` VARCHAR(250) NULL DEFAULT NULL,
  `EmailId` VARCHAR(50) NULL DEFAULT NULL,
  `ContactNumber` VARCHAR(15) NULL DEFAULT NULL,
  `Fax` VARCHAR(15) NULL DEFAULT NULL,
  `ProjectDomain_Id` INT(11) NULL DEFAULT NULL,
  `Year_Id` INT(11) NULL DEFAULT NULL,
  `IsDelete` BIT(1) NULL DEFAULT NULL,
  `AddedBy` CHAR(38) NULL DEFAULT NULL,
  `AddedDate` DATETIME NULL DEFAULT NULL,
  `UpdatedBy` CHAR(38) NULL DEFAULT NULL,
  `UpdatedDate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fellowdetail_masterprojectdomain_projectdomainid_idx` (`ProjectDomain_Id` ASC),
  INDEX `fellowdetail_masterfellowyear_yearid_idx` (`Year_Id` ASC),
  INDEX `fellowdetail_userprofile_addedby_idx` (`AddedBy` ASC),
  INDEX `fellowdetail_userprofile_updatedby_idx` (`UpdatedBy` ASC),
  CONSTRAINT `fellowdetail_masterprojectdomain_projectdomainid`
    FOREIGN KEY (`ProjectDomain_Id`)
    REFERENCES `tatacenterdb`.`master_projectdomain` (`Pd_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fellowdetail_masterfellowyear_yearid`
    FOREIGN KEY (`Year_Id`)
    REFERENCES `tatacenterdb`.`master_fellow_year` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fellowdetail_userprofile_addedby`
    FOREIGN KEY (`AddedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fellowdetail_userprofile_updatedby`
    FOREIGN KEY (`UpdatedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`fellow_project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`fellow_project` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`fellow_project` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `F_Id` CHAR(38) NULL DEFAULT NULL,
  `Project_Id` INT(11) NULL DEFAULT NULL,
  `IsDelete` BIT(1) NULL DEFAULT NULL,
  `AddedBy` CHAR(38) NULL DEFAULT NULL,
  `UpdatedBy` CHAR(38) NULL DEFAULT NULL,
  `UpdatedDate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fellowproject_fellowdetail_fid_idx` (`F_Id` ASC),
  INDEX `fellowproject_projectdetail_projectid_idx` (`Project_Id` ASC),
  INDEX `fellowproject_userprofile_addedby_idx` (`AddedBy` ASC),
  INDEX `fellowproject_userprofile_updatedby_idx` (`UpdatedBy` ASC),
  CONSTRAINT `fellowproject_fellowdetail_fid`
    FOREIGN KEY (`F_Id`)
    REFERENCES `tatacenterdb`.`fellow_detail` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fellowproject_projectdetail_projectid`
    FOREIGN KEY (`Project_Id`)
    REFERENCES `tatacenterdb`.`project_detail` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fellowproject_userprofile_addedby`
    FOREIGN KEY (`AddedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fellowproject_userprofile_updatedby`
    FOREIGN KEY (`UpdatedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`master_fellow`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`master_fellow` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`master_fellow` (
  `Fl_Id` INT(11) NOT NULL AUTO_INCREMENT,
  `Description` VARCHAR(100) NULL DEFAULT NULL,
  `OrderBy` INT(11) NULL DEFAULT NULL,
  `IsActive` BIT(1) NULL DEFAULT NULL,
  `IsDelete` BIT(1) NULL DEFAULT NULL,
  `AddedBy` CHAR(38) NULL DEFAULT NULL,
  `AddedDate` DATETIME NULL DEFAULT NULL,
  `UpdatedBy` CHAR(38) NULL DEFAULT NULL,
  `UpdatedDate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`Fl_Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`master_staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`master_staff` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`master_staff` (
  `Sf_Id` INT(11) NOT NULL AUTO_INCREMENT,
  `Description` VARCHAR(100) NULL DEFAULT NULL,
  `OrderBy` INT(11) NULL DEFAULT NULL,
  `IsActive` BIT(1) NULL DEFAULT NULL,
  `IsDelete` BIT(1) NULL DEFAULT NULL,
  `AddedBy` CHAR(38) NULL DEFAULT NULL,
  `AddedDate` DATETIME NULL DEFAULT NULL,
  `UpdatedBy` CHAR(38) NULL DEFAULT NULL,
  `UpdatedDate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`Sf_Id`),
  INDEX `masterstaff_userprofile_addedby_idx` (`AddedBy` ASC),
  INDEX `masterstaff_userprofile_updatedby_idx` (`UpdatedBy` ASC),
  CONSTRAINT `masterstaff_userprofile_addedby`
    FOREIGN KEY (`AddedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `masterstaff_userprofile_updatedby`
    FOREIGN KEY (`UpdatedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`newsletter_project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`newsletter_project` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`newsletter_project` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(500) NULL DEFAULT NULL,
  `NewsLetter_Link` VARCHAR(500) NULL DEFAULT NULL,
  `Project_Id` INT(11) NULL DEFAULT NULL,
  `IsDelete` BIT(1) NULL DEFAULT NULL,
  `AddedDate` DATETIME NULL DEFAULT NULL,
  `AddedBy` CHAR(38) NULL DEFAULT NULL,
  `UpdatedDate` DATETIME NULL DEFAULT NULL,
  `UpdateBy` CHAR(38) NULL DEFAULT NULL,
  `Newsletter_Date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `newsletterproject_projectdetail_projectid_idx` (`Project_Id` ASC),
  INDEX `newsletterproject_userprofilel_addedby_idx` (`AddedBy` ASC),
  INDEX `newsletterproject_userprofilel_updatedby_idx` (`UpdateBy` ASC),
  CONSTRAINT `newsletterproject_projectdetail_projectid`
    FOREIGN KEY (`Project_Id`)
    REFERENCES `tatacenterdb`.`project_detail` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `newsletterproject_userprofilel_addedby`
    FOREIGN KEY (`AddedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `newsletterproject_userprofilel_updatedby`
    FOREIGN KEY (`UpdateBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`newsupdate_project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`newsupdate_project` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`newsupdate_project` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(500) NULL DEFAULT NULL,
  `Detail` LONGTEXT NULL DEFAULT NULL,
  `Project_Id` INT(11) NULL DEFAULT NULL,
  `AddedDate` DATETIME NULL DEFAULT NULL,
  `AddedBy` CHAR(38) NULL DEFAULT NULL,
  `UpdatedDate` DATETIME NULL DEFAULT NULL,
  `UpdatedBy` CHAR(38) NULL DEFAULT NULL,
  `NewsUpdate_Date` DATE NULL DEFAULT NULL,
  `IsDelete` BIT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `newsupdateproject_projectdetail_projectid_idx` (`Project_Id` ASC),
  INDEX `newsupdateproject_userprofile_addedby_idx` (`AddedBy` ASC),
  INDEX `newsupdateproject_userprofile_updatedby_idx` (`UpdatedBy` ASC),
  CONSTRAINT `newsupdateproject_projectdetail_projectid`
    FOREIGN KEY (`Project_Id`)
    REFERENCES `tatacenterdb`.`project_detail` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `newsupdateproject_userprofile_addedby`
    FOREIGN KEY (`AddedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `newsupdateproject_userprofile_updatedby`
    FOREIGN KEY (`UpdatedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`newsupdate_link`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`newsupdate_link` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`newsupdate_link` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `NU_Id` INT(11) NULL DEFAULT NULL,
  `Post_Link` VARCHAR(500) NULL DEFAULT NULL,
  `IsDelete` BIT(1) NULL DEFAULT NULL,
  `AddedBy` CHAR(38) NULL DEFAULT NULL,
  `AddedDate` DATETIME NULL DEFAULT NULL,
  `UpdatedBy` CHAR(38) NULL DEFAULT NULL,
  `UpdatedDate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `newsupdatelink_newsupdateproject_nuid_idx` (`NU_Id` ASC),
  INDEX `newsupdatelink_userprofile_addedby_idx` (`AddedBy` ASC),
  INDEX `newsupdatelink_userprofile_updatedby_idx` (`UpdatedBy` ASC),
  CONSTRAINT `newsupdatelink_newsupdateproject_nuid`
    FOREIGN KEY (`NU_Id`)
    REFERENCES `tatacenterdb`.`newsupdate_project` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `newsupdatelink_userprofile_addedby`
    FOREIGN KEY (`AddedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `newsupdatelink_userprofile_updatedby`
    FOREIGN KEY (`UpdatedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`page`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`page` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`page` (
  `Page_Id` INT(11) NOT NULL AUTO_INCREMENT,
  `PageName` VARCHAR(50) NULL DEFAULT NULL,
  `Description` VARCHAR(500) NULL DEFAULT NULL,
  `Path` VARCHAR(2000) NULL DEFAULT NULL,
  `IsActive` BIT(1) NULL DEFAULT NULL,
  `IsDelete` BIT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`Page_Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`patent_people`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`patent_people` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`patent_people` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `P_Id` CHAR(38) NULL DEFAULT NULL,
  `Pl_Id` INT(11) NULL DEFAULT NULL,
  `Description` VARCHAR(1000) NULL DEFAULT NULL,
  `IsDelete` BIT(1) NULL DEFAULT NULL,
  `AddedBy` CHAR(38) NULL DEFAULT NULL,
  `AddedDate` DATETIME NULL DEFAULT NULL,
  `UpdatedBy` CHAR(38) NULL DEFAULT NULL,
  `UpdatedDate` DATETIME NULL DEFAULT NULL,
  `Patent_Date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `patentpeople_professordetail_pid_idx` (`P_Id` ASC),
  INDEX `patentpeople_userprofile_addedby_idx` (`AddedBy` ASC),
  INDEX `patentpeople_userprofile_updatedby_idx` (`UpdatedBy` ASC),
  INDEX `patentpeople_masterpeople_addedby_idx` (`Pl_Id` ASC),
  CONSTRAINT `patentpeople_professordetail_pid`
    FOREIGN KEY (`P_Id`)
    REFERENCES `tatacenterdb`.`professor_detail` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `patentpeople_staffdetail_pid`
    FOREIGN KEY (`P_Id`)
    REFERENCES `tatacenterdb`.`staff_detail` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `patentpeople_userprofile_addedby`
    FOREIGN KEY (`AddedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `patentpeople_userprofile_updatedby`
    FOREIGN KEY (`UpdatedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `patentpeople_masterpeople_addedby`
    FOREIGN KEY (`Pl_Id`)
    REFERENCES `tatacenterdb`.`master_people` (`Pl_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`patent_project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`patent_project` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`patent_project` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `Patent_Title` VARCHAR(500) NULL DEFAULT NULL,
  `Patent_Detail` LONGTEXT NULL DEFAULT NULL,
  `Project_Id` INT(11) NULL DEFAULT NULL,
  `AddedDate` DATETIME NULL DEFAULT NULL,
  `AddedBy` CHAR(38) NULL DEFAULT NULL,
  `UpdatedDate` DATETIME NULL DEFAULT NULL,
  `UpdatedBy` CHAR(38) NULL DEFAULT NULL,
  `IsDelete` BIT(1) NULL DEFAULT NULL,
  `Patent_Date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `patentproject_projectdetail_projectid_idx` (`Project_Id` ASC),
  INDEX `patentproject_userprofile_addedby_idx` (`AddedBy` ASC),
  INDEX `patentproject_userprofile_updatedby_idx` (`UpdatedBy` ASC),
  CONSTRAINT `patentproject_projectdetail_projectid`
    FOREIGN KEY (`Project_Id`)
    REFERENCES `tatacenterdb`.`project_detail` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `patentproject_userprofile_addedby`
    FOREIGN KEY (`AddedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `patentproject_userprofile_updatedby`
    FOREIGN KEY (`UpdatedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`patent_project_media`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`patent_project_media` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`patent_project_media` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `link` VARCHAR(500) NULL DEFAULT NULL,
  `Pp_Id` INT(11) NULL DEFAULT NULL,
  `AddedBy` CHAR(38) NULL DEFAULT NULL,
  `AddedDate` DATETIME NULL DEFAULT NULL,
  `UpdatedBy` CHAR(38) NULL DEFAULT NULL,
  `UpdatedDate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `patentprojectmedia_patentproject_ppid_idx` (`Pp_Id` ASC),
  INDEX `patentprojectmedia_userprofile_addedby_idx` (`AddedBy` ASC),
  INDEX `patentprojectmedia_userprofile_updatedby_idx` (`UpdatedBy` ASC),
  CONSTRAINT `patentprojectmedia_patentproject_ppid`
    FOREIGN KEY (`Pp_Id`)
    REFERENCES `tatacenterdb`.`patent_project` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `patentprojectmedia_userprofile_addedby`
    FOREIGN KEY (`AddedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `patentprojectmedia_userprofile_updatedby`
    FOREIGN KEY (`UpdatedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`professional_experience_people`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`professional_experience_people` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`professional_experience_people` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `P_Id` CHAR(38) NULL DEFAULT NULL,
  `Pl_Id` INT(11) NULL DEFAULT NULL,
  `Description` VARCHAR(1000) NULL DEFAULT NULL,
  `AddedBy` CHAR(38) NULL DEFAULT NULL,
  `AddedDate` DATETIME NULL DEFAULT NULL,
  `UpdatedBy` CHAR(38) NULL DEFAULT NULL,
  `UpdatedDate` DATETIME NULL DEFAULT NULL,
  `IsDelete` BIT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `professionalexperiencepeople_professordetail_pid_idx` (`P_Id` ASC),
  INDEX `professionalexperiencepeople_userprofile_addedby_idx` (`AddedBy` ASC),
  INDEX `professionalexperiencepeople_userprofile_updatedby_idx` (`UpdatedBy` ASC),
  INDEX `professionalexperiencepeople_masterpeople_plid_idx` (`Pl_Id` ASC),
  CONSTRAINT `professionalexperiencepeople_professordetail_pid`
    FOREIGN KEY (`P_Id`)
    REFERENCES `tatacenterdb`.`professor_detail` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `professionalexperiencepeople_staffdetail_pid`
    FOREIGN KEY (`P_Id`)
    REFERENCES `tatacenterdb`.`staff_detail` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `professionalexperiencepeople_userprofile_addedby`
    FOREIGN KEY (`AddedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `professionalexperiencepeople_userprofile_updatedby`
    FOREIGN KEY (`UpdatedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `professionalexperiencepeople_masterpeople_plid`
    FOREIGN KEY (`Pl_Id`)
    REFERENCES `tatacenterdb`.`master_people` (`Pl_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`professor_projects_tctd`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`professor_projects_tctd` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`professor_projects_tctd` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `Project_Id` INT(11) NULL DEFAULT NULL,
  `Pr_Id` CHAR(38) NULL DEFAULT NULL,
  `Pf_Id` INT(11) NULL DEFAULT NULL,
  `IsDelete` BIT(1) NULL DEFAULT NULL,
  `AddedBy` CHAR(38) NULL DEFAULT NULL,
  `AddedDate` DATETIME NULL DEFAULT NULL,
  `UpdatedBy` CHAR(38) NULL DEFAULT NULL,
  `UpdatedDate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `professorprojectstctd_projectdetail_projectid_idx` (`Project_Id` ASC),
  INDEX `professorprojectstctd_professordetail_prid_idx` (`Pr_Id` ASC),
  INDEX `professorprojectstctd_masterprofessor_pfid_idx` (`Pf_Id` ASC),
  INDEX `professorprojectstctd_userprofile_addedby_idx` (`AddedBy` ASC),
  INDEX `professorprojectstctd_userprofile_updatedby_idx` (`UpdatedBy` ASC),
  CONSTRAINT `professorprojectstctd_projectdetail_projectid`
    FOREIGN KEY (`Project_Id`)
    REFERENCES `tatacenterdb`.`project_detail` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `professorprojectstctd_professordetail_prid`
    FOREIGN KEY (`Pr_Id`)
    REFERENCES `tatacenterdb`.`professor_detail` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `professorprojectstctd_masterprofessor_pfid`
    FOREIGN KEY (`Pf_Id`)
    REFERENCES `tatacenterdb`.`master_professor` (`Pr_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `professorprojectstctd_userprofile_addedby`
    FOREIGN KEY (`AddedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `professorprojectstctd_userprofile_updatedby`
    FOREIGN KEY (`UpdatedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`project_photo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`project_photo` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`project_photo` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `BigImage_Path` VARCHAR(500) NULL DEFAULT NULL,
  `SmallImage_Path` VARCHAR(500) NULL DEFAULT NULL,
  `Project_Id` INT(11) NULL DEFAULT NULL,
  `IsDelete` BIT(1) NULL DEFAULT NULL,
  `AddedBy` CHAR(38) NULL DEFAULT NULL,
  `AddedDate` DATETIME NULL DEFAULT NULL,
  `UpdatedBy` CHAR(38) NULL DEFAULT NULL,
  `UpdatedDate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `projectphoto_projectdetail_projectid_idx` (`Project_Id` ASC),
  INDEX `projectphoto_userprofile_addedby_idx` (`AddedBy` ASC),
  INDEX `projectphoto_userprofile_updatedby_idx` (`UpdatedBy` ASC),
  CONSTRAINT `projectphoto_projectdetail_projectid`
    FOREIGN KEY (`Project_Id`)
    REFERENCES `tatacenterdb`.`project_detail` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `projectphoto_userprofile_addedby`
    FOREIGN KEY (`AddedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `projectphoto_userprofile_updatedby`
    FOREIGN KEY (`UpdatedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`project_video`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`project_video` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`project_video` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `Video_Path` VARCHAR(500) NULL DEFAULT NULL,
  `Project_Id` INT(11) NULL DEFAULT NULL,
  `IsDelete` BIT(1) NULL DEFAULT NULL,
  `AddedBy` CHAR(38) NULL DEFAULT NULL,
  `AddedDate` DATETIME NULL DEFAULT NULL,
  `UpdatedBy` CHAR(38) NULL DEFAULT NULL,
  `UpdatedDate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `projectvideo_projectdetail_projectid_idx` (`Project_Id` ASC),
  INDEX `projectvideo_userprofile_addedby_idx` (`AddedBy` ASC),
  INDEX `projectvideo_userprofile_updatedby_idx` (`UpdatedBy` ASC),
  CONSTRAINT `projectvideo_projectdetail_projectid`
    FOREIGN KEY (`Project_Id`)
    REFERENCES `tatacenterdb`.`project_detail` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `projectvideo_userprofile_addedby`
    FOREIGN KEY (`AddedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `projectvideo_userprofile_updatedby`
    FOREIGN KEY (`UpdatedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`publication_project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`publication_project` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`publication_project` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(500) NULL DEFAULT NULL,
  `Publication_Detail` LONGTEXT NULL DEFAULT NULL,
  `Publication_Link` VARCHAR(500) NULL DEFAULT NULL,
  `Publication_Image` VARCHAR(250) NULL DEFAULT NULL,
  `IsDelete` BIT(1) NULL DEFAULT NULL,
  `Project_Id` INT(11) NULL DEFAULT NULL,
  `AddedBy` CHAR(38) NULL DEFAULT NULL,
  `AddedDate` DATETIME NULL DEFAULT NULL,
  `UpdatedBy` CHAR(38) NULL DEFAULT NULL,
  `UpdatedDate` DATETIME NULL DEFAULT NULL,
  `PublishedDate` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `publicationproject_projectdetail_projectid_idx` (`Project_Id` ASC),
  INDEX `publicationproject_userprofile_addedby_idx` (`AddedBy` ASC),
  INDEX `publicationproject_userprofile_updatedby_idx` (`UpdatedBy` ASC),
  CONSTRAINT `publicationproject_projectdetail_projectid`
    FOREIGN KEY (`Project_Id`)
    REFERENCES `tatacenterdb`.`project_detail` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `publicationproject_userprofile_addedby`
    FOREIGN KEY (`AddedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `publicationproject_userprofile_updatedby`
    FOREIGN KEY (`UpdatedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`research_interest_professor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`research_interest_professor` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`research_interest_professor` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `Pr_Id` CHAR(38) NULL DEFAULT NULL,
  `Description` VARCHAR(1000) NULL DEFAULT NULL,
  `AddedBy` CHAR(38) NULL DEFAULT NULL,
  `AddedDate` DATETIME NULL DEFAULT NULL,
  `UpdatedBy` CHAR(38) NULL DEFAULT NULL,
  `UpdatedDate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `researchinterestprofessor_professordetail_prid_idx` (`Pr_Id` ASC),
  INDEX `researchinterestprofessor_userprofile_addedby_idx` (`AddedBy` ASC),
  INDEX `researchinterestprofessor_userprofile_updatedby_idx` (`UpdatedBy` ASC),
  CONSTRAINT `researchinterestprofessor_professordetail_prid`
    FOREIGN KEY (`Pr_Id`)
    REFERENCES `tatacenterdb`.`professor_detail` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `researchinterestprofessor_userprofile_addedby`
    FOREIGN KEY (`AddedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `researchinterestprofessor_userprofile_updatedby`
    FOREIGN KEY (`UpdatedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`research_publication_professor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`research_publication_professor` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`research_publication_professor` (
  `Rp_Id` INT(11) NOT NULL AUTO_INCREMENT,
  `Pr_Id` CHAR(38) NULL DEFAULT NULL,
  `Description` VARCHAR(1000) NULL DEFAULT NULL,
  `IsDelete` BIT(1) NULL DEFAULT NULL,
  `AddedBy` CHAR(38) NULL DEFAULT NULL,
  `AddedDate` DATETIME NULL DEFAULT NULL,
  `UpdatedBy` CHAR(38) NULL DEFAULT NULL,
  `UpdatedDate` DATETIME NULL DEFAULT NULL,
  `PublishedDate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`Rp_Id`),
  INDEX `researchpublicationprofessor_professordetail_prid_idx` (`Pr_Id` ASC),
  INDEX `researchpublicationprofessor_userprofilel_addedby_idx` (`AddedBy` ASC),
  INDEX `researchpublicationprofessor_userprofilel_updatedby_idx` (`UpdatedBy` ASC),
  CONSTRAINT `researchpublicationprofessor_professordetail_prid`
    FOREIGN KEY (`Pr_Id`)
    REFERENCES `tatacenterdb`.`professor_detail` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `researchpublicationprofessor_userprofilel_addedby`
    FOREIGN KEY (`AddedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `researchpublicationprofessor_userprofilel_updatedby`
    FOREIGN KEY (`UpdatedBy`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`role` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`role` (
  `RoleId` INT(11) NOT NULL AUTO_INCREMENT,
  `RoleName` VARCHAR(45) NULL DEFAULT NULL,
  `Description` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`RoleId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`userlogin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`userlogin` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`userlogin` (
  `UserLoginId` INT(11) NOT NULL AUTO_INCREMENT,
  `UserRefId` INT(11) NULL DEFAULT NULL,
  `UserName` VARCHAR(150) NULL DEFAULT NULL,
  `Password` VARCHAR(500) NULL DEFAULT NULL,
  `HashKey` VARCHAR(500) NULL DEFAULT NULL,
  `LoggedIn` BIT(1) NULL DEFAULT NULL,
  `LastLoggedIn` DATETIME NULL DEFAULT NULL,
  `Location` VARCHAR(150) NULL DEFAULT NULL,
  PRIMARY KEY (`UserLoginId`),
  UNIQUE INDEX `UserLoginId_UNIQUE` (`UserLoginId` ASC),
  INDEX `UserProfile_UserRefId_idx` (`UserRefId` ASC),
  CONSTRAINT `UserProfile_UserRefId`
    FOREIGN KEY (`UserRefId`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserRefId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `tatacenterdb`.`userrolepage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tatacenterdb`.`userrolepage` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `tatacenterdb`.`userrolepage` (
  `URA_Id` INT(11) NOT NULL AUTO_INCREMENT,
  `UserRef_Id` INT(11) NULL DEFAULT NULL,
  `Role_Id` INT(11) NULL DEFAULT NULL,
  `Page_Id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`URA_Id`),
  INDEX `UserProfile_UserRefId_idx` (`UserRef_Id` ASC),
  INDEX `Role_RoleId_idx` (`Role_Id` ASC),
  INDEX `Page_PageId_idx` (`Page_Id` ASC),
  CONSTRAINT `Page_PageId`
    FOREIGN KEY (`Page_Id`)
    REFERENCES `tatacenterdb`.`page` (`Page_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Role_RoleId`
    FOREIGN KEY (`Role_Id`)
    REFERENCES `tatacenterdb`.`role` (`RoleId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `UserProfile_UserRefId_URP`
    FOREIGN KEY (`UserRef_Id`)
    REFERENCES `tatacenterdb`.`userprofile` (`UserRefId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
