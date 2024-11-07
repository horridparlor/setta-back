-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 07, 2024 at 04:00 PM
-- Server version: 10.6.19-MariaDB-cll-lve
-- PHP Version: 8.3.13

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
-- Table structure for table `format`
--

CREATE TABLE `format` (
  `id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `isActive` tinyint(4) NOT NULL DEFAULT 1,
  `mainDeckSize` int(11) NOT NULL DEFAULT 60,
  `hasExtraDeck` tinyint(4) NOT NULL DEFAULT 1,
  `maxCopies` int(11) NOT NULL DEFAULT 3,
  `hasSideDeck` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `format`
--

INSERT INTO `format` (`id`, `name`, `isActive`, `mainDeckSize`, `hasExtraDeck`, `maxCopies`, `hasSideDeck`) VALUES
(1, 'Classic', 1, 60, 1, 3, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `format`
--
ALTER TABLE `format`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `format`
--
ALTER TABLE `format`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;