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
-- Table structure for table `gameSession`
--

CREATE TABLE `gameSession` (
                               `id` int NOT NULL,
                               `formatId` int NOT NULL,
                               `leagueId` int DEFAULT NULL,
                               `challengerId` int NOT NULL,
                               `opponentId` int NOT NULL,
                               `turn` smallint NOT NULL DEFAULT '0',
                               `turnPlayerId` int DEFAULT NULL,
                               `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                               `started_at` timestamp NULL DEFAULT NULL,
                               `ended_at` timestamp NULL DEFAULT NULL,
                               `winnerId` int DEFAULT NULL,
                               `isArchived` tinyint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `gameSession`
--
ALTER TABLE `gameSession`
    ADD PRIMARY KEY (`id`),
  ADD KEY `formatId` (`formatId`),
  ADD KEY `turnPlayerId` (`turnPlayerId`),
  ADD KEY `winnerId` (`winnerId`),
  ADD KEY `leagueId` (`leagueId`),
  ADD KEY `challengerId` (`challengerId`),
  ADD KEY `opponentId` (`opponentId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `gameSession`
--
ALTER TABLE `gameSession`
    MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `gameSession`
--
ALTER TABLE `gameSession`
    ADD CONSTRAINT `gameSession_ibfk_1` FOREIGN KEY (`formatId`) REFERENCES `format` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `gameSession_ibfk_2` FOREIGN KEY (`turnPlayerId`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `gameSession_ibfk_3` FOREIGN KEY (`winnerId`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `gameSession_ibfk_4` FOREIGN KEY (`leagueId`) REFERENCES `league` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `gameSession_ibfk_5` FOREIGN KEY (`challengerId`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `gameSession_ibfk_6` FOREIGN KEY (`opponentId`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;