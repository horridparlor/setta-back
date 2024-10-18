-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 23, 2024 at 06:32 PM
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
-- Table structure for table `expansion`
--

CREATE TABLE `expansion` (
                             `id` int(11) NOT NULL,
                             `ownerId` int(11) NOT NULL,
                             `name` varchar(32) NOT NULL,
                             `releaseYear` int(11) NOT NULL DEFAULT 2024,
                             `isReleased` tinyint(4) NOT NULL DEFAULT 0,
                             `isReleasedForGame` tinyint(4) NOT NULL DEFAULT 0,
                             `modifiedBy` int(11) NOT NULL,
                             `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
                             `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `expansion`
--

INSERT INTO `expansion` (`id`, `ownerId`, `name`, `releaseYear`, `isReleased`, `isReleasedForGame`, `modifiedBy`, `createdAt`, `updatedAt`) VALUES
                                                                                                                                                  (1, 1, 'Set 1', 2023, 1, 0, 0, '2024-05-12 10:29:42', '2024-06-21 06:28:59'),
                                                                                                                                                  (2, 1, 'Mini 1', 2024, 1, 0, 0, '2024-05-12 10:29:42', '2024-06-23 10:56:26'),
                                                                                                                                                  (3, 1, 'Mini 2', 2024, 1, 0, 0, '2024-05-12 10:29:42', '2024-07-10 14:23:19'),
                                                                                                                                                  (4, 1, 'Mini 3', 2024, 1, 0, 0, '2024-05-12 10:29:42', '2024-06-21 06:44:14'),
                                                                                                                                                  (5, 1, 'Mini 4', 2024, 1, 0, 0, '2024-05-12 10:29:42', '2024-07-14 08:30:31'),
                                                                                                                                                  (6, 1, 'Mini 5', 2024, 1, 0, 0, '2024-05-12 10:29:42', '2024-06-21 06:51:45'),
                                                                                                                                                  (7, 1, 'Set 2', 2024, 1, 0, 0, '2024-05-12 10:29:42', '2024-07-10 14:23:47'),
                                                                                                                                                  (8, 0, 'Unreleased', 2024, 0, 0, 0, '2024-05-12 10:29:42', '2024-05-14 20:52:35'),
                                                                                                                                                  (9, 1, 'Mini 6', 2024, 1, 0, 0, '2024-05-12 10:29:42', '2024-06-21 07:04:57'),
                                                                                                                                                  (10, 1, 'Set 3', 2024, 1, 0, 1, '2024-06-05 08:00:25', '2024-07-14 08:25:43'),
                                                                                                                                                  (11, 1, 'Test', 2024, 0, 0, 1, '2024-06-05 18:58:40', '2024-06-05 20:16:43'),
                                                                                                                                                  (12, 1, 'Set 4', 2024, 0, 0, 1, '2024-06-28 20:51:30', '2024-06-30 10:11:21'),
                                                                                                                                                  (13, 1, 'Set 5', 2024, 0, 0, 1, '2024-07-08 06:26:35', '2024-07-08 06:26:35');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `expansion`
--
ALTER TABLE `expansion`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `ownerId` (`ownerId`),
  ADD KEY `modifiedBy` (`modifiedBy`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `expansion`
--
ALTER TABLE `expansion`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `expansion`
--
ALTER TABLE `expansion`
    ADD CONSTRAINT `expansion_ibfk_1` FOREIGN KEY (`ownerId`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `expansion_ibfk_2` FOREIGN KEY (`modifiedBy`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
