-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versione server:              10.1.16-MariaDB - mariadb.org binary distribution
-- S.O. server:                  Win32
-- HeidiSQL Versione:            9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dump della struttura del database appartamento
DROP DATABASE IF EXISTS `appartamento`;
CREATE DATABASE IF NOT EXISTS `appartamento` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `appartamento`;

-- Dump della struttura di tabella appartamento.affitti
CREATE TABLE IF NOT EXISTS `affitti` (
  `idAffitto` int(10) NOT NULL AUTO_INCREMENT,
  `data` date DEFAULT NULL,
  `importo` int(11) DEFAULT NULL,
  `codAppartamento` int(11) DEFAULT NULL,
  PRIMARY KEY (`idAffitto`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella appartamento.affitti: ~8 rows (circa)
/*!40000 ALTER TABLE `affitti` DISABLE KEYS */;
INSERT INTO `affitti` (`idAffitto`, `data`, `importo`, `codAppartamento`) VALUES
	(1, '2011-01-24', 400, 1),
	(2, '2011-02-24', 400, 1),
	(3, '2011-07-09', 500, 2),
	(4, '2011-01-24', 750, 3),
	(5, '2011-01-25', 700, 5),
	(6, '2021-05-09', 350, 6),
	(7, '2010-05-09', 450, 1),
	(8, '2010-05-09', 700, 3);
/*!40000 ALTER TABLE `affitti` ENABLE KEYS */;

-- Dump della struttura di tabella appartamento.appartamenti
CREATE TABLE IF NOT EXISTS `appartamenti` (
  `codAppartamento` int(10) NOT NULL AUTO_INCREMENT,
  `superficie` int(10) DEFAULT '0',
  `vani` tinyint(4) DEFAULT '0',
  `citta` varchar(50) DEFAULT '0',  
  `codProprietario` varchar(50) DEFAULT '0',
  PRIMARY KEY (`codAppartamento`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella appartamento.appartamenti: ~7 rows (circa)
/*!40000 ALTER TABLE `appartamenti` DISABLE KEYS */;
INSERT INTO `appartamenti` (`codAppartamento`, `superficie`, `vani`, `citta`,  `codProprietario`) VALUES
	(1, 80, 2, 'Monza',  'rsma'),
	(2, 150, 4, 'Milano',  'rsma'),
	(3, 120, 4, 'Lecco',  'bcgv'),
	(4, 70, 3, 'Lecco',  'nrmc'),
	(5, 300, 6, 'Milano', 'rsma'),
	(6, 40, 3, 'Lecco',  'glcm'),
	(7, 300, 3, 'Milano',  'vrdl');
/*!40000 ALTER TABLE `appartamenti` ENABLE KEYS */;

-- Dump della struttura di tabella appartamento.proprietari
CREATE TABLE IF NOT EXISTS `proprietari` (
  `codProprietario` varchar(50) NOT NULL DEFAULT '',
  `nome` varchar(50) DEFAULT NULL,
  `cognome` varchar(50) DEFAULT NULL,
  `citta` varchar(50) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`codProprietario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump dei dati della tabella appartamento.proprietari: ~5 rows (circa)
/*!40000 ALTER TABLE `proprietari` DISABLE KEYS */;
INSERT INTO `proprietari` (`codProprietario`, `nome`, `cognome`, `citta`, `telefono`) VALUES
	('bcgv', 'Giovanni', 'Bianchi', 'Lecco', '556677'),
	('glcm', 'Michele', 'Gialli', 'Lecco', '445566'),
	('nrmc', 'Michele', 'Neri', 'Milano', '889900'),
	('rsma', 'Mario', 'Rossi', 'Milano', '004455'),
	('vrdl', 'Luca', 'Verdi', 'Lecco', '112233');
/*!40000 ALTER TABLE `proprietari` ENABLE KEYS */;


/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
