-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3310
-- Generation Time: Jun 24, 2024 at 07:31 PM
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
-- Table structure for table `eventTarget`
--

CREATE TABLE `eventTarget` (
                               `id` int NOT NULL,
                               `eventId` int DEFAULT NULL,
                               `playerId` int DEFAULT NULL,
                               `cardId` int DEFAULT NULL,
                               `cardInstanceId` int DEFAULT NULL,
                               `isSet` tinyint DEFAULT NULL,
                               `zoneId` int DEFAULT NULL,
                               `statId` int DEFAULT NULL,
                               `cardClassId` int DEFAULT NULL,
                               `cardTypeId` int DEFAULT NULL,
                               `cardSubtypeId` int DEFAULT NULL,
                               `cardSupertypeId` int DEFAULT NULL,
                               `keywordId` int DEFAULT NULL,
                               `turnPhaseId` int DEFAULT NULL,
                               `positionId` int DEFAULT NULL,
                               `amount` smallint DEFAULT NULL,
                               `referencesSelf` tinyint DEFAULT NULL,
                               `nextEventTypeId` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `eventTarget`
--
ALTER TABLE `eventTarget`
    ADD PRIMARY KEY (`id`),
  ADD KEY `cardClassId` (`cardClassId`),
  ADD KEY `eventTarget_ibfk_2` (`cardId`),
  ADD KEY `cardInstanceId` (`cardInstanceId`),
  ADD KEY `cardSubtypeId` (`cardSubtypeId`),
  ADD KEY `cardSupertypeId` (`cardSupertypeId`),
  ADD KEY `cardTypeId` (`cardTypeId`),
  ADD KEY `playerId` (`playerId`),
  ADD KEY `turnPhaseId` (`turnPhaseId`),
  ADD KEY `zoneId` (`zoneId`),
  ADD KEY `positionId` (`positionId`),
  ADD KEY `statId` (`statId`),
  ADD KEY `eventTarget_ibfk_12` (`keywordId`),
  ADD KEY `eventId` (`eventId`),
  ADD KEY `nextEventTypeId` (`nextEventTypeId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `eventTarget`
--
ALTER TABLE `eventTarget`
    MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;