-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3310
-- Generation Time: Jun 24, 2024 at 06:45 PM
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
-- Table structure for table `stackEvent`
--

CREATE TABLE `stackEvent` (
                              `id` int NOT NULL,
                              `ownerId` int NOT NULL,
                              `sessionId` int NOT NULL,
                              `slot` int NOT NULL,
                              `eventTypeId` int NOT NULL,
                              `isContinuous` tinyint NOT NULL DEFAULT '0',
                              `isAutomatic` tinyint NOT NULL DEFAULT '1',
                              `sourceId` int DEFAULT NULL,
                              `targetId` int DEFAULT NULL,
                              `zoneId` int DEFAULT NULL,
                              `amount` int DEFAULT NULL,
                              `doReveal` tinyint DEFAULT NULL,
                              `referencedEvent` int DEFAULT NULL,
                              `endsAfterTurn` int DEFAULT NULL,
                              `message` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
                              `hasResolved` tinyint NOT NULL DEFAULT '0',
                              `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `stackEvent`
--
ALTER TABLE `stackEvent`
    ADD PRIMARY KEY (`id`),
  ADD KEY `ownerId` (`ownerId`),
  ADD KEY `referencedEvent` (`referencedEvent`),
  ADD KEY `sessionId` (`sessionId`),
  ADD KEY `sourceId` (`sourceId`),
  ADD KEY `zoneId` (`zoneId`),
  ADD KEY `targetId` (`targetId`),
  ADD KEY `eventTypeId` (`eventTypeId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `stackEvent`
--
ALTER TABLE `stackEvent`
    MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `stackEvent`
--
ALTER TABLE `stackEvent`
    ADD CONSTRAINT `stackEvent_ibfk_1` FOREIGN KEY (`ownerId`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `stackEvent_ibfk_2` FOREIGN KEY (`referencedEvent`) REFERENCES `stackEvent` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `stackEvent_ibfk_3` FOREIGN KEY (`sessionId`) REFERENCES `gameSession` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `stackEvent_ibfk_4` FOREIGN KEY (`sourceId`) REFERENCES `cardInstance` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `stackEvent_ibfk_5` FOREIGN KEY (`zoneId`) REFERENCES `zone` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `stackEvent_ibfk_6` FOREIGN KEY (`targetId`) REFERENCES `eventTarget` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `stackEvent_ibfk_7` FOREIGN KEY (`eventTypeId`) REFERENCES `eventType` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

--
-- Constraints for table `eventTarget`
--
ALTER TABLE `eventTarget`
    ADD CONSTRAINT `eventTarget_ibfk_1` FOREIGN KEY (`cardClassId`) REFERENCES `cardClass` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `eventTarget_ibfk_10` FOREIGN KEY (`positionId`) REFERENCES `monsterPosition` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `eventTarget_ibfk_11` FOREIGN KEY (`statId`) REFERENCES `stat` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `eventTarget_ibfk_12` FOREIGN KEY (`keywordId`) REFERENCES `keyword` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `eventTarget_ibfk_13` FOREIGN KEY (`eventId`) REFERENCES `stackEvent` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `eventTarget_ibfk_2` FOREIGN KEY (`cardId`) REFERENCES `card` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `eventTarget_ibfk_3` FOREIGN KEY (`cardInstanceId`) REFERENCES `cardInstance` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `eventTarget_ibfk_4` FOREIGN KEY (`cardSubtypeId`) REFERENCES `cardSubtype` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `eventTarget_ibfk_5` FOREIGN KEY (`cardSupertypeId`) REFERENCES `cardSupertype` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `eventTarget_ibfk_6` FOREIGN KEY (`cardTypeId`) REFERENCES `cardType` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `eventTarget_ibfk_7` FOREIGN KEY (`playerId`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `eventTarget_ibfk_8` FOREIGN KEY (`turnPhaseId`) REFERENCES `turnPhase` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `eventTarget_ibfk_9` FOREIGN KEY (`zoneId`) REFERENCES `zone` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;