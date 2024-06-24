-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3310
-- Generation Time: Jun 24, 2024 at 07:07 PM
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
-- Table structure for table `cardEffects`
--

CREATE TABLE `cardEffects` (
                               `id` int NOT NULL,
                               `cardId` int NOT NULL,
                               `isContinuous` tinyint NOT NULL DEFAULT '0',
                               `triggerEventId` int DEFAULT NULL,
                               `triggerTargetId` int DEFAULT NULL,
                               `costEventId` int DEFAULT NULL,
                               `costTargetId` int DEFAULT NULL,
                               `effectEventId` int DEFAULT NULL,
                               `effectTargetId` int DEFAULT NULL,
                               `equalsEventId` int DEFAULT NULL,
                               `equalsTargetId` int DEFAULT NULL,
                               `chaindId` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cardEffects`
--
ALTER TABLE `cardEffects`
    ADD PRIMARY KEY (`id`),
  ADD KEY `cardId` (`cardId`),
  ADD KEY `chaindId` (`chaindId`),
  ADD KEY `costEventId` (`costEventId`),
  ADD KEY `costTargetId` (`costTargetId`),
  ADD KEY `effectEventId` (`effectEventId`),
  ADD KEY `effectTargetId` (`effectTargetId`),
  ADD KEY `triggerEventId` (`triggerEventId`),
  ADD KEY `triggerTargetId` (`triggerTargetId`),
  ADD KEY `equalsEventId` (`equalsEventId`),
  ADD KEY `equalsTargetId` (`equalsTargetId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cardEffects`
--
ALTER TABLE `cardEffects`
    MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cardEffects`
--
ALTER TABLE `cardEffects`
    ADD CONSTRAINT `cardEffects_ibfk_1` FOREIGN KEY (`cardId`) REFERENCES `card` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `cardEffects_ibfk_10` FOREIGN KEY (`equalsTargetId`) REFERENCES `eventTarget` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `cardEffects_ibfk_2` FOREIGN KEY (`chaindId`) REFERENCES `cardEffects` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `cardEffects_ibfk_3` FOREIGN KEY (`costEventId`) REFERENCES `eventType` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `cardEffects_ibfk_4` FOREIGN KEY (`costTargetId`) REFERENCES `eventTarget` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `cardEffects_ibfk_5` FOREIGN KEY (`effectEventId`) REFERENCES `eventType` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `cardEffects_ibfk_6` FOREIGN KEY (`effectTargetId`) REFERENCES `eventTarget` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `cardEffects_ibfk_7` FOREIGN KEY (`triggerEventId`) REFERENCES `eventType` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `cardEffects_ibfk_8` FOREIGN KEY (`triggerTargetId`) REFERENCES `eventTarget` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `cardEffects_ibfk_9` FOREIGN KEY (`equalsEventId`) REFERENCES `eventType` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;