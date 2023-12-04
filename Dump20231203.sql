-- MySQL dump 10.13  Distrib 8.0.34, for macos13 (arm64)
--
-- Host: 127.0.0.1    Database: filmnest-db
-- ------------------------------------------------------
-- Server version	8.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Account`
--

DROP TABLE IF EXISTS `Account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Account` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `DateOpened` date NOT NULL,
  `Type` enum('Limited','Unlimited-1','Unlimited-2','Unlimited-3') NOT NULL DEFAULT 'Limited',
  `Customer` int NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Id_UNIQUE` (`Id`),
  UNIQUE KEY `Customer_UNIQUE` (`Customer`),
  KEY `account_ibfk_1` (`Customer`),
  CONSTRAINT `account_ibfk_1` FOREIGN KEY (`Customer`) REFERENCES `Customer` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Account`
--

LOCK TABLES `Account` WRITE;
/*!40000 ALTER TABLE `Account` DISABLE KEYS */;
INSERT INTO `Account` VALUES (1,'2006-10-01','Unlimited-2',444444444),(2,'2006-10-15','Limited',222222222),(3,'2007-01-12','Unlimited-3',111111111),(4,'2007-02-20','Unlimited-3',333333333),(5,'2023-11-30','Limited',321214321);
/*!40000 ALTER TABLE `Account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AccountHistory`
--

DROP TABLE IF EXISTS `AccountHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AccountHistory` (
  `AccountId` int NOT NULL,
  `Type` enum('Limited','Unlimited-1','Unlimited-2','Unlimited-3') NOT NULL,
  `ChangeDate` date NOT NULL,
  PRIMARY KEY (`AccountId`,`ChangeDate`),
  CONSTRAINT `AccountHistory_ibfk_1` FOREIGN KEY (`AccountId`) REFERENCES `Account` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AccountHistory`
--

LOCK TABLES `AccountHistory` WRITE;
/*!40000 ALTER TABLE `AccountHistory` DISABLE KEYS */;
INSERT INTO `AccountHistory` VALUES (1,'Unlimited-2','2006-10-01'),(1,'Unlimited-3','2007-01-01'),(2,'Limited','2006-10-15'),(2,'Unlimited-1','2007-03-15'),(3,'Unlimited-1','2007-01-12'),(3,'Unlimited-3','2023-12-01'),(4,'Unlimited-3','2007-02-20');
/*!40000 ALTER TABLE `AccountHistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Actor`
--

DROP TABLE IF EXISTS `Actor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Actor` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` char(50) NOT NULL,
  `Age` int DEFAULT NULL,
  `Gender` enum('M','F') DEFAULT NULL,
  `Rating` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Id_UNIQUE` (`Id`),
  CONSTRAINT `actor_chk_1` CHECK ((`Gender` in (_utf8mb4'M',_utf8mb4'F'))),
  CONSTRAINT `CHK_ActorRating_Range` CHECK ((`Rating` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Actor`
--

LOCK TABLES `Actor` WRITE;
/*!40000 ALTER TABLE `Actor` DISABLE KEYS */;
INSERT INTO `Actor` VALUES (1,'Al Pacino',63,'M',1),(2,'Tim Robbins',53,'M',1);
/*!40000 ALTER TABLE `Actor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ActorRating`
--

DROP TABLE IF EXISTS `ActorRating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ActorRating` (
  `AccountId` int NOT NULL,
  `ActorId` int NOT NULL,
  `Rating` int NOT NULL,
  PRIMARY KEY (`AccountId`,`ActorId`),
  KEY `FK_ActorRating_Actor` (`ActorId`),
  CONSTRAINT `FK_ActorRating_Account` FOREIGN KEY (`AccountId`) REFERENCES `Account` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_ActorRating_Actor` FOREIGN KEY (`ActorId`) REFERENCES `Actor` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `CHK_Rating_Range` CHECK (((`Rating` >= 1) and (`Rating` <= 5)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ActorRating`
--

LOCK TABLES `ActorRating` WRITE;
/*!40000 ALTER TABLE `ActorRating` DISABLE KEYS */;
/*!40000 ALTER TABLE `ActorRating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AppearedIn`
--

DROP TABLE IF EXISTS `AppearedIn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AppearedIn` (
  `ActorId` int NOT NULL,
  `MovieId` int NOT NULL,
  PRIMARY KEY (`ActorId`,`MovieId`),
  KEY `appearedin_ibfk_2` (`MovieId`),
  KEY `appearedin_ibfk_1` (`ActorId`),
  CONSTRAINT `appearedin_ibfk_1` FOREIGN KEY (`ActorId`) REFERENCES `Actor` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `appearedin_ibfk_2` FOREIGN KEY (`MovieId`) REFERENCES `Movie` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AppearedIn`
--

LOCK TABLES `AppearedIn` WRITE;
/*!40000 ALTER TABLE `AppearedIn` DISABLE KEYS */;
INSERT INTO `AppearedIn` VALUES (1,1),(2,1),(1,3);
/*!40000 ALTER TABLE `AppearedIn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customer` (
  `Id` int NOT NULL,
  `Rating` int NOT NULL DEFAULT '1',
  `CreditCardNumber` bigint NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Id_UNIQUE` (`Id`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`Id`) REFERENCES `Person` (`SSN`) ON UPDATE CASCADE,
  CONSTRAINT `customer_chk_1` CHECK (((`Rating` >= 1) and (`Rating` <= 5)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
INSERT INTO `Customer` VALUES (111111111,1,1234567812345678),(222222222,1,5678123456781234),(321214321,1,1234567890987654),(333333333,1,2345678923456789),(444444444,1,6789234567892345);
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Employee`
--

DROP TABLE IF EXISTS `Employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Employee` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `SSN` int NOT NULL,
  `StartDate` date NOT NULL,
  `HourlyRate` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`),
  UNIQUE KEY `SSN_UNIQUE` (`SSN`),
  KEY `SSN` (`SSN`),
  CONSTRAINT `Employee_ibfk_1` FOREIGN KEY (`SSN`) REFERENCES `Person` (`SSN`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employee`
--

LOCK TABLES `Employee` WRITE;
/*!40000 ALTER TABLE `Employee` DISABLE KEYS */;
INSERT INTO `Employee` VALUES (1,123456789,'2005-11-01',60),(2,789123456,'2006-02-02',50),(3,234567891,'2020-01-01',90);
/*!40000 ALTER TABLE `Employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Location`
--

DROP TABLE IF EXISTS `Location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Location` (
  `ZipCode` int NOT NULL,
  `City` char(20) NOT NULL,
  `State` char(20) NOT NULL,
  PRIMARY KEY (`ZipCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Location`
--

LOCK TABLES `Location` WRITE;
/*!40000 ALTER TABLE `Location` DISABLE KEYS */;
INSERT INTO `Location` VALUES (11790,'Stony Brook','NY'),(11794,'Stony Brook','NY'),(17093,'West New York','NY'),(17100,'New City','NS'),(72050,'Suluktu','Batkern'),(93536,'Los Angeles','CA');
/*!40000 ALTER TABLE `Location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Login`
--

DROP TABLE IF EXISTS `Login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Login` (
  `Username` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `Role` enum('manager','customerRepresentative','customer') NOT NULL DEFAULT 'customer',
  PRIMARY KEY (`Username`),
  UNIQUE KEY `Usename_UNIQUE` (`Username`),
  CONSTRAINT `Username` FOREIGN KEY (`Username`) REFERENCES `Person` (`Email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Login`
--

LOCK TABLES `Login` WRITE;
/*!40000 ALTER TABLE `Login` DISABLE KEYS */;
INSERT INTO `Login` VALUES ('admin@example.com','abc123','manager'),('person007@gmail.com','abc123','customer'),('person1@example.com','abc123','customer'),('person2@example.com','abc123','customerRepresentative'),('person3@example.com','abc123','customer'),('person5@example.com','abc123','customer'),('person6@example.com','abc123','customer'),('person7@example.com','abc123','customerRepresentative');
/*!40000 ALTER TABLE `Login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Movie`
--

DROP TABLE IF EXISTS `Movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Movie` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` char(50) NOT NULL,
  `Type` char(36) NOT NULL,
  `Rating` int NOT NULL DEFAULT '1',
  `DistrFee` int NOT NULL DEFAULT '0',
  `NumCopies` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Id_UNIQUE` (`Id`),
  CONSTRAINT `movie_chk_1` CHECK ((`Rating` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Movie`
--

LOCK TABLES `Movie` WRITE;
/*!40000 ALTER TABLE `Movie` DISABLE KEYS */;
INSERT INTO `Movie` VALUES (1,'The Godfather','Drama',5,10000,3),(2,'Shawshank Redemption','Drama',4,1000,2),(3,'Borat','Comedy',3,500,1);
/*!40000 ALTER TABLE `Movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MovieQ`
--

DROP TABLE IF EXISTS `MovieQ`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MovieQ` (
  `AccountId` int NOT NULL,
  `MovieId` int NOT NULL,
  PRIMARY KEY (`AccountId`,`MovieId`),
  KEY `movieq_movie_idx` (`MovieId`),
  CONSTRAINT `movieq_account` FOREIGN KEY (`AccountId`) REFERENCES `Account` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `movieq_movie` FOREIGN KEY (`MovieId`) REFERENCES `Movie` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MovieQ`
--

LOCK TABLES `MovieQ` WRITE;
/*!40000 ALTER TABLE `MovieQ` DISABLE KEYS */;
INSERT INTO `MovieQ` VALUES (1,1),(2,2),(1,3),(2,3);
/*!40000 ALTER TABLE `MovieQ` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MovieRating`
--

DROP TABLE IF EXISTS `MovieRating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MovieRating` (
  `AccountId` int NOT NULL,
  `MovieId` int NOT NULL,
  `Rating` int NOT NULL,
  PRIMARY KEY (`AccountId`,`MovieId`),
  KEY `Fk_MovieRating_Movie_idx` (`MovieId`),
  CONSTRAINT `Fk_MovieRating_Movie` FOREIGN KEY (`MovieId`) REFERENCES `Movie` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `movierating_account` FOREIGN KEY (`AccountId`) REFERENCES `Account` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `CHK_MovieRating_Range` CHECK (((`Rating` >= 1) and (`Rating` <= 5)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MovieRating`
--

LOCK TABLES `MovieRating` WRITE;
/*!40000 ALTER TABLE `MovieRating` DISABLE KEYS */;
/*!40000 ALTER TABLE `MovieRating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Order`
--

DROP TABLE IF EXISTS `Order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Order` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `DateTime` datetime NOT NULL,
  `ReturnDate` date DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Id_UNIQUE` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Order`
--

LOCK TABLES `Order` WRITE;
/*!40000 ALTER TABLE `Order` DISABLE KEYS */;
INSERT INTO `Order` VALUES (1,'2009-11-11 10:00:00','2009-11-14'),(2,'2009-11-11 18:15:00',NULL),(3,'2009-11-12 09:30:00',NULL),(4,'2009-11-21 22:22:00',NULL);
/*!40000 ALTER TABLE `Order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Person`
--

DROP TABLE IF EXISTS `Person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Person` (
  `SSN` int NOT NULL,
  `LastName` char(36) NOT NULL,
  `FirstName` char(36) NOT NULL,
  `Address` char(50) NOT NULL,
  `ZipCode` int DEFAULT NULL,
  `Telephone` bigint NOT NULL,
  `Email` varchar(50) NOT NULL,
  PRIMARY KEY (`SSN`),
  UNIQUE KEY `SSN_UNIQUE` (`SSN`),
  UNIQUE KEY `Email_UNIQUE` (`Email`),
  KEY `ZipCode` (`ZipCode`),
  CONSTRAINT `person_ibfk_1` FOREIGN KEY (`ZipCode`) REFERENCES `Location` (`ZipCode`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `CHK_SSN_Range` CHECK (((`SSN` > 0) and (`SSN` < 1000000000)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Person`
--

LOCK TABLES `Person` WRITE;
/*!40000 ALTER TABLE `Person` DISABLE KEYS */;
INSERT INTO `Person` VALUES (111111111,'Yang','Shang','123 Success Street',11790,5166328959,'person1@example.com'),(123456789,'Smith','David','123 College road',11790,5162152345,'person2@example.com'),(222222222,'Du','Victor','456 Fortune Road',11790,5166324360,'person3@example.com'),(234567891,'biniiiiiaw2','Biniiiqw','anything',17093,6316329999,'admin@example.com'),(321214321,'Deep','Jonh','T. Rustamov 07',72050,6313528939,'person007@gmail.com'),(333333333,'Smith','John','789 Peace Blvd.',93536,3154434321,'person5@example.com'),(444444444,'Philip','Lewis','135',11794,5166668888,'person6@example.com'),(789123456,'Warren','David','456 Sunken Street',11794,6316329987,'person7@example.com');
/*!40000 ALTER TABLE `Person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Rental`
--

DROP TABLE IF EXISTS `Rental`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Rental` (
  `AccountId` int NOT NULL,
  `CustRepId` int NOT NULL,
  `OrderId` int NOT NULL,
  `MovieId` int NOT NULL,
  PRIMARY KEY (`AccountId`,`CustRepId`,`OrderId`,`MovieId`),
  KEY `rental_ibfk_4_idx` (`MovieId`),
  KEY `rental_ibfk_3_idx` (`OrderId`),
  KEY `rental_ibfk_2_idx` (`CustRepId`),
  CONSTRAINT `rental_ibfk_1` FOREIGN KEY (`AccountId`) REFERENCES `Account` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rental_ibfk_2` FOREIGN KEY (`CustRepId`) REFERENCES `Employee` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rental_ibfk_3` FOREIGN KEY (`OrderId`) REFERENCES `Order` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rental_ibfk_4` FOREIGN KEY (`MovieId`) REFERENCES `Movie` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rental`
--

LOCK TABLES `Rental` WRITE;
/*!40000 ALTER TABLE `Rental` DISABLE KEYS */;
INSERT INTO `Rental` VALUES (1,1,1,1),(2,1,4,2),(1,1,3,3),(2,1,2,3);
/*!40000 ALTER TABLE `Rental` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-03 23:44:41
