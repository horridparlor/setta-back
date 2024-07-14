-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 14, 2024 at 03:22 PM
-- Server version: 10.6.18-MariaDB-cll-lve
-- PHP Version: 8.3.8

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
-- Table structure for table `effectTarget`
--

CREATE TABLE `effectTarget` (
  `id` int(11) NOT NULL,
  `targetTypeId` int(11) DEFAULT NULL,
  `sourceTargetTypeId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `effectTarget`
--
ALTER TABLE `effectTarget`
  ADD PRIMARY KEY (`id`),
  ADD KEY `targetTypeId` (`targetTypeId`),
  ADD KEY `sourceTargetTypeId` (`sourceTargetTypeId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `effectTarget`
--
ALTER TABLE `effectTarget`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `effectTarget`
--
ALTER TABLE `effectTarget`
  ADD CONSTRAINT `effectTarget_ibfk_1` FOREIGN KEY (`targetTypeId`) REFERENCES `targetType` (`id`),
  ADD CONSTRAINT `effectTarget_ibfk_2` FOREIGN KEY (`sourceTargetTypeId`) REFERENCES `targetType` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;