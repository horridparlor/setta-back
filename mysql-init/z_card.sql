-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 07, 2024 at 03:17 PM
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
-- Dumping data for table `card`
--

INSERT INTO `card` (`id`, `cardName`, `isAce`, `cardClassId`, `cardTypeId`, `subtypeId`, `supertypeId`, `maximumPieceId`, `level`, `atk`, `def`, `primaryMaterialId`, `secondaryMaterialId`, `tertiaryMaterialId`, `costText`, `effectText`, `flavourText`, `countsAsId`, `artScale`, `artXOffset`, `artYOffset`, `nameSize`, `materialsSize`, `effectsSize`, `expansionId`, `isDeleted`) VALUES
                                                                                                                                                                                                                                                                                                                                                                                              (15, 'Undead Catalyst', 0, 4, 1, 4, 1, 1, 6, 1800, 200, 17, 18, NULL, '', '', 'Welcome the slime titan! If someone licks his juice, he turns them into a capybara.', NULL, 4, 0, 13, 2, 3, 5, 2, 0),
                                                                                                                                                                                                                                                                                                                                                                                              (16, 'Hammer Waifu', 0, 2, 1, 2, 1, 1, 3, 1200, 0, NULL, NULL, NULL, 'Discard a card.{i}Hand{/i}', 'Target monster loses {sb}200{/sb} {b}atk{/b}.{i}All stat changes only last until the end of the turn{/i}', '', NULL, 0, 0, 3, 4, 5, 5, 1, 0),
                                                                                                                                                                                                                                                                                                                                                                                              (17, '{i}The{/i}Guildmaster', 0, 4, 1, 2, 1, 1, 7, 2100, 0, NULL, NULL, NULL, 'Mill {sb}2{/sb}.{i}From your deck{/i}', 'Gains {sb}400{/sb} {b}atk{/b} for each level-{sb}5{/sb} and {sb}higher{/sb} {sb}normal{/sb} {b}Slime{/b} in your grave.{i}Yellow{/i}', '', NULL, 0, 0, 0, 3, 5, 5, 2, 0),
                                                                                                                                                                                                                                                                                                                                                                                              (18, 'Pitch-Black Ooze', 0, 4, 1, 1, 1, 1, 5, 1300, 0, NULL, NULL, NULL, '', '', 'Monsters so black that everyone fears them. They eat all the light, making them even darker than yo\' asshole.', NULL, 1, 0, 14, 2, 5, 5, 1, 0);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

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