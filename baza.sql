CREATE DATABASE  IF NOT EXISTS `mydb` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mydb`;
-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.25

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
-- Table structure for table `administrator`
--

DROP TABLE IF EXISTS `administrator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `administrator` (
  `idAdministratora` int NOT NULL AUTO_INCREMENT,
  `Nazwa` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idAdministratora`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrator`
--

LOCK TABLES `administrator` WRITE;
/*!40000 ALTER TABLE `administrator` DISABLE KEYS */;
INSERT INTO `administrator` VALUES (1,'Adam'),(2,'Badam'),(3,'Cadam'),(4,'Dadam'),(5,'Edam'),(6,'Fadam');
/*!40000 ALTER TABLE `administrator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `administruje_uzytkownika`
--

DROP TABLE IF EXISTS `administruje_uzytkownika`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `administruje_uzytkownika` (
  `Administrator_idAdministratora` int NOT NULL,
  `UzytkownikZarejestrowany_idZUzytkownika` int NOT NULL,
  PRIMARY KEY (`Administrator_idAdministratora`,`UzytkownikZarejestrowany_idZUzytkownika`),
  KEY `fk_Administrator_has_UzytkownikZarejestrowany_UzytkownikZar_idx` (`UzytkownikZarejestrowany_idZUzytkownika`),
  KEY `fk_Administrator_has_UzytkownikZarejestrowany_Administrator_idx` (`Administrator_idAdministratora`),
  CONSTRAINT `fk_Administrator_has_UzytkownikZarejestrowany_Administrator1` FOREIGN KEY (`Administrator_idAdministratora`) REFERENCES `administrator` (`idAdministratora`),
  CONSTRAINT `fk_Administrator_has_UzytkownikZarejestrowany_UzytkownikZarej1` FOREIGN KEY (`UzytkownikZarejestrowany_idZUzytkownika`) REFERENCES `uzytkownikzarejestrowany` (`idZUzytkownika`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administruje_uzytkownika`
--

LOCK TABLES `administruje_uzytkownika` WRITE;
/*!40000 ALTER TABLE `administruje_uzytkownika` DISABLE KEYS */;
INSERT INTO `administruje_uzytkownika` VALUES (1,1),(1,2),(2,3),(1,4),(2,5),(1,6),(1,7),(1,8),(2,9),(3,10);
/*!40000 ALTER TABLE `administruje_uzytkownika` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dzial`
--

DROP TABLE IF EXISTS `dzial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dzial` (
  `idDzialu` int NOT NULL,
  `Nazwa` varchar(45) NOT NULL,
  `Kurs_idKursu` int NOT NULL,
  PRIMARY KEY (`idDzialu`),
  KEY `fk_Dzial_Kurs1_idx` (`Kurs_idKursu`),
  KEY `idx_dzial_Nazwa` (`Nazwa`),
  CONSTRAINT `fk_Dzial_Kurs1` FOREIGN KEY (`Kurs_idKursu`) REFERENCES `kurs` (`idKursu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dzial`
--

LOCK TABLES `dzial` WRITE;
/*!40000 ALTER TABLE `dzial` DISABLE KEYS */;
INSERT INTO `dzial` VALUES (1,'Dzial1',1),(2,'Dzial2',1),(3,'Dzial3',1),(4,'Dzial4',1),(5,'Dzial5',1),(6,'Dzial6',1);
/*!40000 ALTER TABLE `dzial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filminstruktarzowy`
--

DROP TABLE IF EXISTS `filminstruktarzowy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `filminstruktarzowy` (
  `idFilmuInstruktarzowego` int NOT NULL AUTO_INCREMENT,
  `LinkPodstawowy` longtext NOT NULL,
  `LinkZaawansowany` longtext NOT NULL,
  `Lekcja_idLekcja` int NOT NULL,
  PRIMARY KEY (`idFilmuInstruktarzowego`),
  KEY `fk_FilmInstruktarzowy_Lekcja1_idx` (`Lekcja_idLekcja`),
  CONSTRAINT `fk_FilmInstruktarzowy_Lekcja1` FOREIGN KEY (`Lekcja_idLekcja`) REFERENCES `lekcja` (`idLekcja`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filminstruktarzowy`
--

LOCK TABLES `filminstruktarzowy` WRITE;
/*!40000 ALTER TABLE `filminstruktarzowy` DISABLE KEYS */;
INSERT INTO `filminstruktarzowy` VALUES (1,'https://www.youtube.com/embed/dQw4w9WgXcQ','https://www.youtube.com/embed/G1IbRujko-A',1),(2,'https://www.youtube.com/embed/dQw4w9WgXcQ','https://www.youtube.com/embed/G1IbRujko-A',2),(3,'https://www.youtube.com/embed/dQw4w9WgXcQ','https://www.youtube.com/embed/G1IbRujko-A',3),(4,'https://www.youtube.com/embed/dQw4w9WgXcQ','https://www.youtube.com/embed/G1IbRujko-A',4),(5,'https://www.youtube.com/embed/dQw4w9WgXcQ','https://www.youtube.com/embed/G1IbRujko-A',5),(6,'https://www.youtube.com/embed/dQw4w9WgXcQ','https://www.youtube.com/embed/G1IbRujko-A',6);
/*!40000 ALTER TABLE `filminstruktarzowy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `korepetytor`
--

DROP TABLE IF EXISTS `korepetytor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `korepetytor` (
  `idZUzytkownik` int NOT NULL,
  PRIMARY KEY (`idZUzytkownik`),
  KEY `fk_Korepetytor_UzytkownikZarejestrowany1_idx` (`idZUzytkownik`),
  CONSTRAINT `fk_Korepetytor_UzytkownikZarejestrowany1` FOREIGN KEY (`idZUzytkownik`) REFERENCES `uzytkownikzarejestrowany` (`idZUzytkownika`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `korepetytor`
--

LOCK TABLES `korepetytor` WRITE;
/*!40000 ALTER TABLE `korepetytor` DISABLE KEYS */;
INSERT INTO `korepetytor` VALUES (1),(2);
/*!40000 ALTER TABLE `korepetytor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `korepetytor_uczy_na`
--

DROP TABLE IF EXISTS `korepetytor_uczy_na`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `korepetytor_uczy_na` (
  `Korepetytor_idZUzytkownik` int NOT NULL,
  `Kurs_idKursu` int NOT NULL,
  PRIMARY KEY (`Korepetytor_idZUzytkownik`,`Kurs_idKursu`),
  KEY `fk_Korepetytor_has_Kurs_Kurs1_idx` (`Kurs_idKursu`),
  KEY `fk_Korepetytor_has_Kurs_Korepetytor1_idx` (`Korepetytor_idZUzytkownik`),
  CONSTRAINT `fk_Korepetytor_has_Kurs_Korepetytor1` FOREIGN KEY (`Korepetytor_idZUzytkownik`) REFERENCES `korepetytor` (`idZUzytkownik`),
  CONSTRAINT `fk_Korepetytor_has_Kurs_Kurs1` FOREIGN KEY (`Kurs_idKursu`) REFERENCES `kurs` (`idKursu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `korepetytor_uczy_na`
--

LOCK TABLES `korepetytor_uczy_na` WRITE;
/*!40000 ALTER TABLE `korepetytor_uczy_na` DISABLE KEYS */;
INSERT INTO `korepetytor_uczy_na` VALUES (1,1),(2,2),(2,3),(1,4),(1,5),(1,6);
/*!40000 ALTER TABLE `korepetytor_uczy_na` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ksztalci`
--

DROP TABLE IF EXISTS `ksztalci`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ksztalci` (
  `Lekcja_idLekcja` int NOT NULL,
  `Umiejetnosc_idUmiejetnosci` int NOT NULL,
  PRIMARY KEY (`Lekcja_idLekcja`,`Umiejetnosc_idUmiejetnosci`),
  KEY `fk_Lekcja_has_Umiejetnosc_Umiejetnosc2_idx` (`Umiejetnosc_idUmiejetnosci`),
  KEY `fk_Lekcja_has_Umiejetnosc_Lekcja2_idx` (`Lekcja_idLekcja`),
  CONSTRAINT `fk_Lekcja_has_Umiejetnosc_Lekcja2` FOREIGN KEY (`Lekcja_idLekcja`) REFERENCES `lekcja` (`idLekcja`),
  CONSTRAINT `fk_Lekcja_has_Umiejetnosc_Umiejetnosc2` FOREIGN KEY (`Umiejetnosc_idUmiejetnosci`) REFERENCES `umiejetnosc` (`idUmiejetnosci`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ksztalci`
--

LOCK TABLES `ksztalci` WRITE;
/*!40000 ALTER TABLE `ksztalci` DISABLE KEYS */;
INSERT INTO `ksztalci` VALUES (1,13),(1,14),(2,15),(3,15),(3,16),(4,16),(4,17);
/*!40000 ALTER TABLE `ksztalci` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kurs`
--

DROP TABLE IF EXISTS `kurs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kurs` (
  `idKursu` int NOT NULL,
  `Nazwa` varchar(45) NOT NULL,
  `Opis` longtext,
  `Cena` float DEFAULT NULL,
  `RokWydania` int DEFAULT NULL,
  `Przedmiot_idPrzedmiotu` int NOT NULL,
  PRIMARY KEY (`idKursu`),
  UNIQUE KEY `idx_kurs_Nazwa` (`Nazwa`),
  KEY `fk_Kurs_Przedmiot1_idx` (`Przedmiot_idPrzedmiotu`),
  CONSTRAINT `fk_Kurs_Przedmiot1` FOREIGN KEY (`Przedmiot_idPrzedmiotu`) REFERENCES `przedmiot` (`idPrzedmiotu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kurs`
--

LOCK TABLES `kurs` WRITE;
/*!40000 ALTER TABLE `kurs` DISABLE KEYS */;
INSERT INTO `kurs` VALUES (1,'Kurs1','Uczy um1',10,2010,1),(2,'Kurs2','Uczy um2',20,2020,2),(3,'Kurs3','Uczy um3',30,2030,3),(4,'Kurs4','Uczy um4',40,2050,4),(5,'Kurs5','Uczy um 5',50,2050,5),(6,'Kurs6','Uczy um 69',60,2060,6);
/*!40000 ALTER TABLE `kurs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lekcja`
--

DROP TABLE IF EXISTS `lekcja`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lekcja` (
  `idLekcja` int NOT NULL,
  `Tytul` varchar(45) DEFAULT NULL,
  `Dzial_idDzialu` int NOT NULL,
  PRIMARY KEY (`idLekcja`),
  KEY `fk_Lekcja_Dzial1_idx` (`Dzial_idDzialu`),
  KEY `idx_lekcja_Tytul` (`Tytul`),
  CONSTRAINT `fk_Lekcja_Dzial1` FOREIGN KEY (`Dzial_idDzialu`) REFERENCES `dzial` (`idDzialu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lekcja`
--

LOCK TABLES `lekcja` WRITE;
/*!40000 ALTER TABLE `lekcja` DISABLE KEYS */;
INSERT INTO `lekcja` VALUES (1,'Zastosowanie calek',1),(2,'Potegowanie',1),(3,'Dodawanie',1),(4,'Pochodne niewymierno dyskretne',2),(5,'Wyliczanie delty wstecz',2),(6,'Zapytania SQL',3);
/*!40000 ALTER TABLE `lekcja` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mozliweodpowiedzi`
--

DROP TABLE IF EXISTS `mozliweodpowiedzi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mozliweodpowiedzi` (
  `idMozliwejOdpowiedzi` int NOT NULL AUTO_INCREMENT,
  `Tresc` longtext NOT NULL,
  `Zadanie_idZadania` int NOT NULL,
  PRIMARY KEY (`idMozliwejOdpowiedzi`),
  KEY `fk_MozliweOdpowiedzi_Zadanie1_idx` (`Zadanie_idZadania`),
  CONSTRAINT `fk_MozliweOdpowiedzi_Zadanie1` FOREIGN KEY (`Zadanie_idZadania`) REFERENCES `zadanie` (`idZadania`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mozliweodpowiedzi`
--

LOCK TABLES `mozliweodpowiedzi` WRITE;
/*!40000 ALTER TABLE `mozliweodpowiedzi` DISABLE KEYS */;
INSERT INTO `mozliweodpowiedzi` VALUES (1,'Prostokątna',1),(2,'Kwadratowa',1),(3,'Liniowa',1),(4,'Wykładnicza',1),(5,'Jeden',2),(6,'Dwa',2),(7,'Trzy',2),(8,'Cztery',2),(9,'x=-3',3),(10,'x=-2',3),(11,'x=0',3),(12,'x=2',3),(13,'8',4),(14,'6',4),(15,'2',4),(16,'5',4),(17,'180',5),(18,'240',5),(19,'360',5),(20,'540',5);
/*!40000 ALTER TABLE `mozliweodpowiedzi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `odpowiedz`
--

DROP TABLE IF EXISTS `odpowiedz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `odpowiedz` (
  `idOdpowiedzi` int NOT NULL AUTO_INCREMENT,
  `Ocena` int DEFAULT NULL,
  `OdpowiedzUcznia` int NOT NULL,
  `Zadanie_idZadania` int NOT NULL,
  `Korepetytor_idZUzytkownik` int DEFAULT NULL,
  `Uczen_idUcznia` int NOT NULL,
  PRIMARY KEY (`idOdpowiedzi`),
  KEY `fk_Odpowiedz_Zadanie1_idx` (`Zadanie_idZadania`),
  KEY `fk_Odpowiedz_Korepetytor1_idx` (`Korepetytor_idZUzytkownik`),
  KEY `fk_Odpowiedz_Uczen1_idx` (`Uczen_idUcznia`),
  CONSTRAINT `fk_Odpowiedz_Korepetytor1` FOREIGN KEY (`Korepetytor_idZUzytkownik`) REFERENCES `korepetytor` (`idZUzytkownik`),
  CONSTRAINT `fk_Odpowiedz_Uczen1` FOREIGN KEY (`Uczen_idUcznia`) REFERENCES `uczen` (`idUzytkownika`),
  CONSTRAINT `fk_Odpowiedz_Zadanie1` FOREIGN KEY (`Zadanie_idZadania`) REFERENCES `zadanie` (`idZadania`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `odpowiedz`
--

LOCK TABLES `odpowiedz` WRITE;
/*!40000 ALTER TABLE `odpowiedz` DISABLE KEYS */;
INSERT INTO `odpowiedz` VALUES (1,0,2,1,1,5),(2,1,1,1,2,6),(3,1,1,1,1,7),(4,1,8,2,1,7),(5,0,7,2,1,8),(6,1,9,3,2,5),(7,0,10,3,1,9),(8,0,14,4,2,7),(9,1,15,4,2,6),(10,0,16,4,2,8),(11,0,18,5,1,5),(12,1,19,5,2,9);
/*!40000 ALTER TABLE `odpowiedz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opiekun`
--

DROP TABLE IF EXISTS `opiekun`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opiekun` (
  `idZUzytkownik` int NOT NULL,
  PRIMARY KEY (`idZUzytkownik`),
  UNIQUE KEY `idZUzytkownik_UNIQUE` (`idZUzytkownik`),
  KEY `fk_Opiekun_UzytkownikZarejestrowany1_idx` (`idZUzytkownik`),
  CONSTRAINT `fk_Opiekun_UzytkownikZarejestrowany1` FOREIGN KEY (`idZUzytkownik`) REFERENCES `uzytkownikzarejestrowany` (`idZUzytkownika`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opiekun`
--

LOCK TABLES `opiekun` WRITE;
/*!40000 ALTER TABLE `opiekun` DISABLE KEYS */;
INSERT INTO `opiekun` VALUES (3),(4);
/*!40000 ALTER TABLE `opiekun` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opiekun_nadzoruje_uczen`
--

DROP TABLE IF EXISTS `opiekun_nadzoruje_uczen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opiekun_nadzoruje_uczen` (
  `Opiekun_idZUzytkownik` int NOT NULL,
  `Uczen_idUcznia` int NOT NULL,
  `Stan` tinyint DEFAULT NULL,
  PRIMARY KEY (`Opiekun_idZUzytkownik`,`Uczen_idUcznia`),
  KEY `fk_Opiekun_has_Uczen_Uczen1_idx` (`Uczen_idUcznia`),
  KEY `fk_Opiekun_has_Uczen_Opiekun1_idx` (`Opiekun_idZUzytkownik`),
  CONSTRAINT `fk_Opiekun_has_Uczen_Opiekun1` FOREIGN KEY (`Opiekun_idZUzytkownik`) REFERENCES `opiekun` (`idZUzytkownik`),
  CONSTRAINT `fk_Opiekun_has_Uczen_Uczen1` FOREIGN KEY (`Uczen_idUcznia`) REFERENCES `uczen` (`idUzytkownika`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opiekun_nadzoruje_uczen`
--

LOCK TABLES `opiekun_nadzoruje_uczen` WRITE;
/*!40000 ALTER TABLE `opiekun_nadzoruje_uczen` DISABLE KEYS */;
INSERT INTO `opiekun_nadzoruje_uczen` VALUES (3,5,0),(3,6,1),(4,7,1),(4,8,1);
/*!40000 ALTER TABLE `opiekun_nadzoruje_uczen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opinia`
--

DROP TABLE IF EXISTS `opinia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opinia` (
  `idOpinii` int NOT NULL AUTO_INCREMENT,
  `Tresc` longtext NOT NULL,
  `Data` tinytext NOT NULL,
  `Ocena` int NOT NULL,
  `Kurs_idKursu` int NOT NULL,
  `Uczen_idUzytkownika` int NOT NULL,
  PRIMARY KEY (`idOpinii`),
  KEY `fk_Opinia_Kurs1_idx` (`Kurs_idKursu`),
  KEY `fk_Opinia_Uczen1_idx` (`Uczen_idUzytkownika`),
  CONSTRAINT `fk_Opinia_Kurs1` FOREIGN KEY (`Kurs_idKursu`) REFERENCES `kurs` (`idKursu`),
  CONSTRAINT `fk_Opinia_Uczen1` FOREIGN KEY (`Uczen_idUzytkownika`) REFERENCES `uczen` (`idUzytkownika`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opinia`
--

LOCK TABLES `opinia` WRITE;
/*!40000 ALTER TABLE `opinia` DISABLE KEYS */;
INSERT INTO `opinia` VALUES (1,'Nie lubię','2001-11-20',1,1,5),(2,'Słabo, nie polecam','2020-12-12',2,1,6),(3,'Super sprawa, lubię wszystko','2014-05-20',3,1,7),(4,'Bardzo fajnie, mama zdała maturę','2019-06-11',4,2,8),(5,'Sztos! Dzięki wam dostałem pracę','2017-04-21',5,3,9),(11,'Lipton','2021-06-11',2,2,5),(13,'Taki se','2021-06-11',3,2,6),(14,'Kurde faja, ten to jest dobry','2021-06-11',5,3,6),(19,'Giga','2021-06-12',5,1,6),(20,'ddddddddd','2021-06-12',5,1,6),(21,'ddddddddd','2021-06-12',5,1,6),(22,'ddddddddd','2021-06-12',5,1,6),(23,'wwww','2021-06-12',2,1,6),(24,'Super kurs','2021-06-17',5,1,6);
/*!40000 ALTER TABLE `opinia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `przedmiot`
--

DROP TABLE IF EXISTS `przedmiot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `przedmiot` (
  `idPrzedmiotu` int NOT NULL AUTO_INCREMENT,
  `Nazwa` varchar(45) NOT NULL,
  PRIMARY KEY (`idPrzedmiotu`),
  UNIQUE KEY `idx_przedmiot_Nazwa` (`Nazwa`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `przedmiot`
--

LOCK TABLES `przedmiot` WRITE;
/*!40000 ALTER TABLE `przedmiot` DISABLE KEYS */;
INSERT INTO `przedmiot` VALUES (3,'Angielski'),(4,'Geografia'),(5,'Historia'),(1,'Matematyka'),(2,'Polski'),(6,'Programowanie');
/*!40000 ALTER TABLE `przedmiot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test` (
  `idTestu` int NOT NULL AUTO_INCREMENT,
  `Lekcja_idLekcja` int NOT NULL,
  PRIMARY KEY (`idTestu`),
  KEY `fk_Test_Lekcja1_idx` (`Lekcja_idLekcja`),
  CONSTRAINT `fk_Test_Lekcja1` FOREIGN KEY (`Lekcja_idLekcja`) REFERENCES `lekcja` (`idLekcja`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` VALUES (1,1),(2,2),(3,3),(4,4),(5,5);
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test_zawiera_zadanie`
--

DROP TABLE IF EXISTS `test_zawiera_zadanie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test_zawiera_zadanie` (
  `Zadanie_idZadania` int NOT NULL,
  `Test_idTestu` int NOT NULL,
  PRIMARY KEY (`Zadanie_idZadania`,`Test_idTestu`),
  KEY `fk_Zadanie_has_Test_Test1_idx` (`Test_idTestu`),
  KEY `fk_Zadanie_has_Test_Zadanie1_idx` (`Zadanie_idZadania`),
  CONSTRAINT `fk_Zadanie_has_Test_Test1` FOREIGN KEY (`Test_idTestu`) REFERENCES `test` (`idTestu`),
  CONSTRAINT `fk_Zadanie_has_Test_Zadanie1` FOREIGN KEY (`Zadanie_idZadania`) REFERENCES `zadanie` (`idZadania`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_zawiera_zadanie`
--

LOCK TABLES `test_zawiera_zadanie` WRITE;
/*!40000 ALTER TABLE `test_zawiera_zadanie` DISABLE KEYS */;
INSERT INTO `test_zawiera_zadanie` VALUES (1,1),(2,1),(3,1),(4,2),(5,2);
/*!40000 ALTER TABLE `test_zawiera_zadanie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testuje`
--

DROP TABLE IF EXISTS `testuje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `testuje` (
  `Zadanie_idZadania` int NOT NULL,
  `Umiejetnosc_idUmiejetnosci` int NOT NULL,
  PRIMARY KEY (`Zadanie_idZadania`,`Umiejetnosc_idUmiejetnosci`),
  KEY `fk_Zadanie_has_Umiejetnosc_Umiejetnosc1_idx` (`Umiejetnosc_idUmiejetnosci`),
  KEY `fk_Zadanie_has_Umiejetnosc_Zadanie1_idx` (`Zadanie_idZadania`),
  CONSTRAINT `fk_Zadanie_has_Umiejetnosc_Umiejetnosc1` FOREIGN KEY (`Umiejetnosc_idUmiejetnosci`) REFERENCES `umiejetnosc` (`idUmiejetnosci`),
  CONSTRAINT `fk_Zadanie_has_Umiejetnosc_Zadanie1` FOREIGN KEY (`Zadanie_idZadania`) REFERENCES `zadanie` (`idZadania`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testuje`
--

LOCK TABLES `testuje` WRITE;
/*!40000 ALTER TABLE `testuje` DISABLE KEYS */;
INSERT INTO `testuje` VALUES (2,11),(3,11),(5,11),(1,12),(1,13),(3,13),(5,13),(3,14),(4,14),(5,14);
/*!40000 ALTER TABLE `testuje` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tresclekcji`
--

DROP TABLE IF EXISTS `tresclekcji`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tresclekcji` (
  `idTrescLekcji` int NOT NULL AUTO_INCREMENT,
  `Wstep` longtext NOT NULL,
  `Ilustracje` longtext,
  `CzasTrwania` int NOT NULL,
  `LinkiDoPodobnych` longtext,
  `Lekcja_idLekcja` int NOT NULL,
  PRIMARY KEY (`idTrescLekcji`),
  KEY `fk_TrescLekcji_Lekcja1_idx` (`Lekcja_idLekcja`),
  CONSTRAINT `fk_TrescLekcji_Lekcja1` FOREIGN KEY (`Lekcja_idLekcja`) REFERENCES `lekcja` (`idLekcja`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tresclekcji`
--

LOCK TABLES `tresclekcji` WRITE;
/*!40000 ALTER TABLE `tresclekcji` DISABLE KEYS */;
INSERT INTO `tresclekcji` VALUES (1,'Dzisiaj nauczymy się dzielić liczby naturalne','https://skrr.pl/wp-content/uploads/2020/09/Astley.jpg',30,'coursea albo coś',1),(2,'Tutaj nauczysz się o Piastach','https://www.banknotyonline.pl/images/6368.jpg',60,'narodowy bank polski',2),(3,'Lekcja biologii- mitochondria to elektrownia komórki','https://i.redd.it/huha7rmq8h121.jpg',20,'nie ma nic podobnego',3),(4,'Obróbka skrawaniem','https://metalltechnik.me/wp-content/uploads/2020/10/obrobka-skrawaniem.jpg',40,'PW',4),(5,'Istnienie memów w spółczesnej kulturze','https://www.youtube.com',999,'https://www.youtube.com/channel/UCaHT88aobpcvRFEuy4v5Clg',5),(6,'Twoja przygoda kulinarna zaczyna się tutaj!','https://i.iplsc.com/przepisy-przyprawy-fikusne-ozdoby-stolu-duzo-robimy-zamiesza/000784HSAPRQETVX-C122-F4.jpg',120,'https://kuchnialidla.pl',6);
/*!40000 ALTER TABLE `tresclekcji` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tworzy/modyfikuje`
--

DROP TABLE IF EXISTS `tworzy/modyfikuje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tworzy/modyfikuje` (
  `Administrator_idAdministratora` int NOT NULL,
  `Kurs_idKursu` int NOT NULL,
  PRIMARY KEY (`Administrator_idAdministratora`,`Kurs_idKursu`),
  KEY `fk_Administrator_has_Kurs_Kurs1_idx` (`Kurs_idKursu`),
  KEY `fk_Administrator_has_Kurs_Administrator1_idx` (`Administrator_idAdministratora`),
  CONSTRAINT `fk_Administrator_has_Kurs_Administrator1` FOREIGN KEY (`Administrator_idAdministratora`) REFERENCES `administrator` (`idAdministratora`),
  CONSTRAINT `fk_Administrator_has_Kurs_Kurs1` FOREIGN KEY (`Kurs_idKursu`) REFERENCES `kurs` (`idKursu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tworzy/modyfikuje`
--

LOCK TABLES `tworzy/modyfikuje` WRITE;
/*!40000 ALTER TABLE `tworzy/modyfikuje` DISABLE KEYS */;
INSERT INTO `tworzy/modyfikuje` VALUES (1,1),(1,2),(2,3),(1,4),(2,5),(3,6);
/*!40000 ALTER TABLE `tworzy/modyfikuje` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uczen`
--

DROP TABLE IF EXISTS `uczen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `uczen` (
  `idUzytkownika` int NOT NULL,
  PRIMARY KEY (`idUzytkownika`),
  UNIQUE KEY `idUcznia_UNIQUE` (`idUzytkownika`),
  KEY `fk_Uczen_UzytkownikZarejestrowany1_idx` (`idUzytkownika`),
  CONSTRAINT `fk_Uczen_UzytkownikZarejestrowany1` FOREIGN KEY (`idUzytkownika`) REFERENCES `uzytkownikzarejestrowany` (`idZUzytkownika`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uczen`
--

LOCK TABLES `uczen` WRITE;
/*!40000 ALTER TABLE `uczen` DISABLE KEYS */;
INSERT INTO `uczen` VALUES (5),(6),(7),(8),(9),(10);
/*!40000 ALTER TABLE `uczen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uczen_has_kurs`
--

DROP TABLE IF EXISTS `uczen_has_kurs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `uczen_has_kurs` (
  `Kurs_idKursu` int NOT NULL,
  `Uczen_idUzytkownika` int NOT NULL,
  PRIMARY KEY (`Kurs_idKursu`,`Uczen_idUzytkownika`),
  KEY `fk_Kurs_has_Uczen_Uczen1_idx` (`Uczen_idUzytkownika`),
  KEY `fk_Kurs_has_Uczen_Kurs1_idx` (`Kurs_idKursu`),
  CONSTRAINT `fk_Kurs_has_Uczen_Kurs1` FOREIGN KEY (`Kurs_idKursu`) REFERENCES `kurs` (`idKursu`),
  CONSTRAINT `fk_Kurs_has_Uczen_Uczen1` FOREIGN KEY (`Uczen_idUzytkownika`) REFERENCES `uczen` (`idUzytkownika`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uczen_has_kurs`
--

LOCK TABLES `uczen_has_kurs` WRITE;
/*!40000 ALTER TABLE `uczen_has_kurs` DISABLE KEYS */;
INSERT INTO `uczen_has_kurs` VALUES (1,5),(1,6),(1,7),(1,8),(1,9);
/*!40000 ALTER TABLE `uczen_has_kurs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uczen_has_lekcja`
--

DROP TABLE IF EXISTS `uczen_has_lekcja`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `uczen_has_lekcja` (
  `Uczen_idUcznia` int NOT NULL,
  `Lekcja_idLekcja` int NOT NULL,
  `CzySkonczona` tinyint DEFAULT NULL,
  PRIMARY KEY (`Uczen_idUcznia`,`Lekcja_idLekcja`),
  KEY `fk_Uczen_has_Lekcja_Lekcja1_idx` (`Lekcja_idLekcja`),
  KEY `fk_Uczen_has_Lekcja_Uczen1_idx` (`Uczen_idUcznia`),
  CONSTRAINT `fk_Uczen_has_Lekcja_Lekcja1` FOREIGN KEY (`Lekcja_idLekcja`) REFERENCES `lekcja` (`idLekcja`),
  CONSTRAINT `fk_Uczen_has_Lekcja_Uczen1` FOREIGN KEY (`Uczen_idUcznia`) REFERENCES `uczen` (`idUzytkownika`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uczen_has_lekcja`
--

LOCK TABLES `uczen_has_lekcja` WRITE;
/*!40000 ALTER TABLE `uczen_has_lekcja` DISABLE KEYS */;
INSERT INTO `uczen_has_lekcja` VALUES (5,1,1),(5,2,1),(5,3,0),(6,2,0),(6,3,1),(7,1,1),(8,1,1),(8,3,1),(8,4,0),(9,4,1);
/*!40000 ALTER TABLE `uczen_has_lekcja` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `umiejetnosc`
--

DROP TABLE IF EXISTS `umiejetnosc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `umiejetnosc` (
  `idUmiejetnosci` int NOT NULL,
  `Nazwa` varchar(45) NOT NULL,
  PRIMARY KEY (`idUmiejetnosci`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `umiejetnosc`
--

LOCK TABLES `umiejetnosc` WRITE;
/*!40000 ALTER TABLE `umiejetnosc` DISABLE KEYS */;
INSERT INTO `umiejetnosc` VALUES (11,'Zamiana potęg, pierwiastków, ułamków'),(12,'Liczenie rozbudowanych ułamków'),(13,'Działania na pierwiastkach'),(14,'Działania na potęgach'),(15,'Wykorzystanie własności potęg'),(16,'Działania na logarytmach'),(17,'Błąd względny i bezwzględny'),(18,'Działania na przedziałach i zbiorach'),(19,'Procenty i lokaty');
/*!40000 ALTER TABLE `umiejetnosc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uzytkownikzarejestrowany`
--

DROP TABLE IF EXISTS `uzytkownikzarejestrowany`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `uzytkownikzarejestrowany` (
  `idZUzytkownika` int NOT NULL AUTO_INCREMENT,
  `Imie` varchar(45) DEFAULT NULL,
  `Nazwisko` varchar(45) DEFAULT NULL,
  `Haslo` varchar(45) NOT NULL,
  `Email` varchar(45) NOT NULL,
  PRIMARY KEY (`idZUzytkownika`),
  UNIQUE KEY `idx_uzytkownikzarejestrowany_Email` (`Email`),
  KEY `idx_uzytkownikzarejestrowany_Nazwisko` (`Nazwisko`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uzytkownikzarejestrowany`
--

LOCK TABLES `uzytkownikzarejestrowany` WRITE;
/*!40000 ALTER TABLE `uzytkownikzarejestrowany` DISABLE KEYS */;
INSERT INTO `uzytkownikzarejestrowany` VALUES (1,'Kuba','Kowalski','haslo','o@wp.pl'),(2,'Buba','Na ','haslo1','kuku@gmail.com'),(3,'Skuba','Wozie','haslo2','czesio@wp.pl'),(4,'Chruba','Raz','hasloo','adam@wp.pl'),(5,'Marek','Pod','XxHaslo','gamer@o2.pl'),(6,'Czarek','Ryk','sdg','czaro@wp.pl'),(7,'Arek','Byk','agsdga','aro@gmail.com'),(8,'Darek','Smyk','adsg','daro@hej.pl'),(9,'Ola','Krzyk','adsgggsd','ola@o2.pl'),(10,'Asia','Fik','sdsdg','kosia@pl.com');
/*!40000 ALTER TABLE `uzytkownikzarejestrowany` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wymaga`
--

DROP TABLE IF EXISTS `wymaga`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wymaga` (
  `Lekcja_idLekcja` int NOT NULL,
  `Umiejetnosc_idUmiejetnosci` int NOT NULL,
  PRIMARY KEY (`Lekcja_idLekcja`,`Umiejetnosc_idUmiejetnosci`),
  KEY `fk_Lekcja_has_Umiejetnosc_Umiejetnosc1_idx` (`Umiejetnosc_idUmiejetnosci`),
  KEY `fk_Lekcja_has_Umiejetnosc_Lekcja1_idx` (`Lekcja_idLekcja`),
  CONSTRAINT `fk_Lekcja_has_Umiejetnosc_Lekcja1` FOREIGN KEY (`Lekcja_idLekcja`) REFERENCES `lekcja` (`idLekcja`),
  CONSTRAINT `fk_Lekcja_has_Umiejetnosc_Umiejetnosc1` FOREIGN KEY (`Umiejetnosc_idUmiejetnosci`) REFERENCES `umiejetnosc` (`idUmiejetnosci`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wymaga`
--

LOCK TABLES `wymaga` WRITE;
/*!40000 ALTER TABLE `wymaga` DISABLE KEYS */;
INSERT INTO `wymaga` VALUES (1,11),(1,12),(2,13),(2,14),(3,14),(4,14);
/*!40000 ALTER TABLE `wymaga` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zadanie`
--

DROP TABLE IF EXISTS `zadanie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zadanie` (
  `idZadania` int NOT NULL AUTO_INCREMENT,
  `Podpowiedz` longtext NOT NULL,
  `Tresc` longtext NOT NULL,
  `OdpowiedzPoprawna` int NOT NULL,
  `Komentarz` longtext,
  PRIMARY KEY (`idZadania`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zadanie`
--

LOCK TABLES `zadanie` WRITE;
/*!40000 ALTER TABLE `zadanie` DISABLE KEYS */;
INSERT INTO `zadanie` VALUES (1,'Pomyśl...','Która z tych funkcji nie istnieje?',1,'Komentarz chyba nie jest potrzebny.'),(2,'Przeczytaj pierwsze 4 litery tego słowa','Ile kątów ma trójkąt?',7,'Jeśli tego nie wiesz, wróć do podstawówki.'),(3,'Działaj na obie strony równania.','Rozwiąż: x+2=0',10,'Odejmij obustronnie 2.'),(4,'Potęga to nie mnożenie!','Oblicz 2^3',13,'Potęgowanie było w lekcji 3.'),(5,'Trochę więcej niż w trójkącie.','Jaka jest suma kątów czworokąta?',19,'Więcej w geometrii (L12).');
/*!40000 ALTER TABLE `zadanie` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-06-17 12:16:54
