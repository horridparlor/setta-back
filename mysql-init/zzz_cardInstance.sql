-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3310
-- Generation Time: Jun 24, 2024 at 06:16 PM
-- Server version: 8.0.37-0ubuntu0.24.04.1
-- PHP Version: 8.2.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `setta`
--

-- --------------------------------------------------------

--
-- Table structure for table `cardInstance`
--

CREATE TABLE `cardInstance` (
                                `id` int NOT NULL,
                                `ownerId` int NOT NULL,
                                `controllerId` int NOT NULL,
                                `cardId` int NOT NULL,
                                `sessionId` int NOT NULL,
                                `zoneId` int NOT NULL,
                                `slot` int NOT NULL,
                                `isRevealed` tinyint NOT NULL DEFAULT '0',
                                `isHidden` tinyint NOT NULL DEFAULT '1',
                                `attachedToId` int DEFAULT NULL,
                                `positionId` int DEFAULT NULL,
                                `canBeSummoned` tinyint NOT NULL DEFAULT '0',
                                `canBeActivated` tinyint NOT NULL DEFAULT '0',
                                `canAttack` tinyint NOT NULL DEFAULT '0',
                                `canChangePosition` tinyint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cardInstance`
--
ALTER TABLE `cardInstance`
    ADD PRIMARY KEY (`id`),
  ADD KEY `cardId` (`cardId`),
  ADD KEY `attachedToId` (`attachedToId`),
  ADD KEY `sessionId` (`sessionId`),
  ADD KEY `zoneId` (`zoneId`),
  ADD KEY `ownerId` (`ownerId`),
  ADD KEY `controllerId` (`controllerId`),
  ADD KEY `positionId` (`positionId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cardInstance`
--
ALTER TABLE `cardInstance`
    MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cardInstance`
--
ALTER TABLE `cardInstance`
    ADD CONSTRAINT `cardInstance_ibfk_1` FOREIGN KEY (`cardId`) REFERENCES `card` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `cardInstance_ibfk_2` FOREIGN KEY (`attachedToId`) REFERENCES `card` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `cardInstance_ibfk_3` FOREIGN KEY (`sessionId`) REFERENCES `gameSession` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `cardInstance_ibfk_4` FOREIGN KEY (`zoneId`) REFERENCES `zone` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `cardInstance_ibfk_5` FOREIGN KEY (`ownerId`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `cardInstance_ibfk_6` FOREIGN KEY (`controllerId`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `cardInstance_ibfk_7` FOREIGN KEY (`positionId`) REFERENCES `monsterPosition` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;