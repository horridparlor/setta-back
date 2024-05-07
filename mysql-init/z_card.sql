-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 07, 2024 at 06:22 AM
-- Server version: 10.6.17-MariaDB-cll-lve
-- PHP Version: 8.1.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `zdccdlji_setta`
--

-- --------------------------------------------------------

--
-- Table structure for table `card`
--

CREATE TABLE `card` (
                        `id` int(11) NOT NULL,
                        `cardName` varchar(32) NOT NULL,
                        `isAce` tinyint(4) NOT NULL,
                        `cardClassId` int(11) NOT NULL,
                        `cardTypeId` int(11) NOT NULL,
                        `subtypeId` int(11) NOT NULL,
                        `supertypeId` int(11) NOT NULL,
                        `maximumPieceId` int(11) NOT NULL,
                        `level` int(11) NOT NULL,
                        `atk` int(11) NOT NULL,
                        `def` int(11) NOT NULL,
                        `primaryMaterialId` int(11) DEFAULT NULL,
                        `secondaryMaterialId` int(11) DEFAULT NULL,
                        `tertiaryMaterialId` int(11) DEFAULT NULL,
                        `costText` varchar(256) NOT NULL,
                        `effectText` varchar(256) NOT NULL,
                        `flavourText` varchar(256) NOT NULL,
                        `countsAsId` int(11) DEFAULT NULL,
                        `artScale` int(11) NOT NULL,
                        `artXOffset` int(11) NOT NULL,
                        `artYOffset` int(11) NOT NULL,
                        `nameSize` int(11) NOT NULL,
                        `materialsSize` int(11) NOT NULL,
                        `effectsSize` int(11) NOT NULL,
                        `expansionId` int(11) NOT NULL,
                        `isDeleted` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `card`
--
ALTER TABLE `card`
    ADD PRIMARY KEY (`id`),
  ADD KEY `primaryMaterialId` (`primaryMaterialId`),
  ADD KEY `secondaryMaterialId` (`secondaryMaterialId`),
  ADD KEY `tertiaryMaterialId` (`tertiaryMaterialId`),
  ADD KEY `countsAsId` (`countsAsId`),
  ADD KEY `expansionId` (`expansionId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `card`
--
ALTER TABLE `card`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `card`
--
ALTER TABLE `card`
    ADD CONSTRAINT `card_ibfk_1` FOREIGN KEY (`primaryMaterialId`) REFERENCES `card` (`id`),
  ADD CONSTRAINT `card_ibfk_2` FOREIGN KEY (`secondaryMaterialId`) REFERENCES `card` (`id`),
  ADD CONSTRAINT `card_ibfk_3` FOREIGN KEY (`tertiaryMaterialId`) REFERENCES `card` (`id`),
  ADD CONSTRAINT `card_ibfk_4` FOREIGN KEY (`countsAsId`) REFERENCES `card` (`id`),
  ADD CONSTRAINT `card_ibfk_5` FOREIGN KEY (`expansionId`) REFERENCES `expansion` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;