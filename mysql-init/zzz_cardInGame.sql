-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 24, 2024 at 01:17 AM
-- Server version: 10.6.20-MariaDB-cll-lve
-- PHP Version: 8.3.14

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
-- Table structure for table `cardInGame`
--

CREATE TABLE `cardInGame` (
  `id` int(11) NOT NULL,
  `cardId` int(11) NOT NULL,
  `gameId` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `controllerId` int(11) NOT NULL,
  `zoneId` int(11) NOT NULL,
  `index` int(11) NOT NULL,
  `isSet` tinyint(4) NOT NULL DEFAULT 0,
  `isHidden` tinyint(4) NOT NULL DEFAULT 1,
  `inDefense` tinyint(4) NOT NULL DEFAULT 0,
  `inMaximumMode` tinyint(4) NOT NULL DEFAULT 0,
  `attachedToId` int(11) DEFAULT NULL,
  `levelGain` int(11) NOT NULL DEFAULT 0,
  `atkGain` int(11) NOT NULL DEFAULT 0,
  `defGain` int(11) NOT NULL DEFAULT 0,
  `canBePlayed` tinyint(4) NOT NULL DEFAULT 0,
  `canBeMaximumSummoned` tinyint(4) NOT NULL DEFAULT 0,
  `canBeActivated` tinyint(4) NOT NULL DEFAULT 0,
  `canChangePosition` tinyint(4) NOT NULL DEFAULT 0,
  `summonedThisTurn` tinyint(4) DEFAULT 0,
  `summonedFromId` int(11) DEFAULT NULL,
  `keywordsJson` text DEFAULT NULL,
  `effectsJson` text DEFAULT NULL,
  `rulerEffectsJson` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cardInGame`
--
ALTER TABLE `cardInGame`
  ADD PRIMARY KEY (`id`),
  ADD KEY `gameId` (`gameId`),
  ADD KEY `ownerId` (`ownerId`),
  ADD KEY `controllerId` (`controllerId`),
  ADD KEY `cardId` (`cardId`),
  ADD KEY `zoneId` (`zoneId`),
  ADD KEY `attachedToId` (`attachedToId`),
  ADD KEY `summonedFromId` (`summonedFromId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cardInGame`
--
ALTER TABLE `cardInGame`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cardInGame`
--
ALTER TABLE `cardInGame`
  ADD CONSTRAINT `cardInGame_ibfk_1` FOREIGN KEY (`gameId`) REFERENCES `gameSession` (`id`),
  ADD CONSTRAINT `cardInGame_ibfk_2` FOREIGN KEY (`ownerId`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `cardInGame_ibfk_3` FOREIGN KEY (`controllerId`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `cardInGame_ibfk_4` FOREIGN KEY (`cardId`) REFERENCES `card` (`id`),
  ADD CONSTRAINT `cardInGame_ibfk_5` FOREIGN KEY (`zoneId`) REFERENCES `zone` (`id`),
  ADD CONSTRAINT `cardInGame_ibfk_6` FOREIGN KEY (`attachedToId`) REFERENCES `cardInGame` (`id`),
  ADD CONSTRAINT `cardInGame_ibfk_7` FOREIGN KEY (`summonedFromId`) REFERENCES `zone` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;