-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 07, 2024 at 04:29 PM
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
-- Table structure for table `decklist`
--

CREATE TABLE `decklist` (
                            `id` int(11) NOT NULL,
                            `ownerId` int(11) NOT NULL,
                            `formatId` int(11) NOT NULL,
                            `name` varchar(64) NOT NULL,
                            `isValid` tinyint(4) NOT NULL,
                            `isPublished` int(11) NOT NULL,
                            `isDeleted` tinyint(4) DEFAULT 0,
                            `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
                            `updatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `decklist`
--
ALTER TABLE `decklist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `formatId` (`formatId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `decklist`
--
ALTER TABLE `decklist`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `decklist`
--
ALTER TABLE `decklist`
    ADD CONSTRAINT `decklist_ibfk_1` FOREIGN KEY (`ownerId`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `decklist_ibfk_2` FOREIGN KEY (`formatId`) REFERENCES `format` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
