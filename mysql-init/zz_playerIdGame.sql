-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 23, 2024 at 09:00 PM
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
-- Table structure for table `playerInGame`
--

CREATE TABLE `playerInGame` (
  `id` int(11) NOT NULL,
  `playerId` int(11) NOT NULL,
  `gameId` int(11) NOT NULL,
  `index` tinyint(4) NOT NULL,
  `lifePoints` int(11) NOT NULL DEFAULT 6000,
  `decklistJson` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `playerInGame`
--
ALTER TABLE `playerInGame`
  ADD PRIMARY KEY (`id`),
  ADD KEY `playerId` (`playerId`),
  ADD KEY `gameId` (`gameId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `playerInGame`
--
ALTER TABLE `playerInGame`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `playerInGame`
--
ALTER TABLE `playerInGame`
  ADD CONSTRAINT `playerInGame_ibfk_1` FOREIGN KEY (`playerId`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `playerInGame_ibfk_2` FOREIGN KEY (`gameId`) REFERENCES `gameSession` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;