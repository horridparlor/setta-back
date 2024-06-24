-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3310
-- Generation Time: Jun 24, 2024 at 04:02 PM
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
-- Table structure for table `decklist`
--

CREATE TABLE `decklist` (
                            `id` int NOT NULL,
                            `ownerId` int NOT NULL,
                            `formatId` int NOT NULL,
                            `name` varchar(32) NOT NULL,
                            `isValid` tinyint NOT NULL DEFAULT '1',
                            `isArchived` tinyint NOT NULL DEFAULT '0',
                            `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                            `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `decklist`
--

INSERT INTO `decklist` (`id`, `ownerId`, `formatId`, `name`, `isValid`, `isArchived`, `created_at`, `updated_at`) VALUES
    (1, 1, 1, 'First deck', 1, 0, '2024-06-24 15:53:38', '2024-06-24 15:53:38');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `decklist`
--
ALTER TABLE `decklist`
    ADD PRIMARY KEY (`id`),
  ADD KEY `ownerId` (`ownerId`),
  ADD KEY `formatId` (`formatId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `decklist`
--
ALTER TABLE `decklist`
    MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `decklist`
--
ALTER TABLE `decklist`
    ADD CONSTRAINT `decklist_ibfk_1` FOREIGN KEY (`ownerId`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `decklist_ibfk_2` FOREIGN KEY (`formatId`) REFERENCES `format` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;