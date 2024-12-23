-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 23, 2024 at 09:11 PM
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
-- Table structure for table `gameResult`
--

CREATE TABLE `gameResult` (
  `id` int(11) NOT NULL,
  `formatId` int(11) NOT NULL,
  `startingPlayer` tinyint(4) NOT NULL,
  `startedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `endedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `winningPlayer` tinyint(4) NOT NULL,
  `turnsPlayed` smallint(6) NOT NULL,
  `didSurrender` tinyint(4) NOT NULL,
  `isArchived` tinyint(4) NOT NULL DEFAULT 0,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `gameResult`
--
ALTER TABLE `gameResult`
  ADD PRIMARY KEY (`id`),
  ADD KEY `formatId` (`formatId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `gameResult`
--
ALTER TABLE `gameResult`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `gameResult`
--
ALTER TABLE `gameResult`
  ADD CONSTRAINT `gameResult_ibfk_1` FOREIGN KEY (`formatId`) REFERENCES `format` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;