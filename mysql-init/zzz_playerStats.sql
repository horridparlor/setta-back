-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3310
-- Generation Time: Jun 24, 2024 at 06:30 PM
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
-- Table structure for table `playerStats`
--

CREATE TABLE `playerStats` (
                               `id` int NOT NULL,
                               `sessionId` int NOT NULL,
                               `playerId` int NOT NULL,
                               `lifePoints` smallint NOT NULL,
                               `turnPhaseId` int DEFAULT NULL,
                               `cardsIdHand` smallint NOT NULL,
                               `cardInDeck` smallint NOT NULL,
                               `waitUntil` timestamp NULL DEFAULT NULL,
                               `timeOutsLeft` int NOT NULL DEFAULT '3'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `playerStats`
--
ALTER TABLE `playerStats`
    ADD PRIMARY KEY (`id`),
  ADD KEY `playerId` (`playerId`),
  ADD KEY `sessionId` (`sessionId`),
  ADD KEY `turnPhase` (`turnPhaseId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `playerStats`
--
ALTER TABLE `playerStats`
    MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `playerStats`
--
ALTER TABLE `playerStats`
    ADD CONSTRAINT `playerStats_ibfk_1` FOREIGN KEY (`playerId`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `playerStats_ibfk_2` FOREIGN KEY (`sessionId`) REFERENCES `gameSession` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `playerStats_ibfk_3` FOREIGN KEY (`turnPhaseId`) REFERENCES `turnPhase` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;