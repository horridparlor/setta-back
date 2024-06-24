-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3310
-- Generation Time: Jun 24, 2024 at 05:23 PM
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
-- Table structure for table `bringsDecklist`
--

CREATE TABLE `bringsDecklist` (
                                  `id` int NOT NULL,
                                  `sessionId` int NOT NULL,
                                  `playerId` int NOT NULL,
                                  `decklistId` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bringsDecklist`
--
ALTER TABLE `bringsDecklist`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sessionId` (`sessionId`,`playerId`),
  ADD KEY `decklistId` (`decklistId`),
  ADD KEY `playerId` (`playerId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bringsDecklist`
--
ALTER TABLE `bringsDecklist`
    MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bringsDecklist`
--
ALTER TABLE `bringsDecklist`
    ADD CONSTRAINT `bringsDecklist_ibfk_1` FOREIGN KEY (`decklistId`) REFERENCES `decklist` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `bringsDecklist_ibfk_2` FOREIGN KEY (`playerId`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `bringsDecklist_ibfk_3` FOREIGN KEY (`sessionId`) REFERENCES `gameSession` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;