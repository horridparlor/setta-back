-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3310
-- Generation Time: Jun 24, 2024 at 04:01 PM
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
-- Table structure for table `format`
--

CREATE TABLE `format` (
                          `id` int NOT NULL,
                          `ownerId` int NOT NULL,
                          `name` varchar(32) NOT NULL,
                          `mainDeckSize` smallint NOT NULL DEFAULT '80',
                          `extraDeckSize` smallint NOT NULL DEFAULT '30',
                          `duplicates` tinyint NOT NULL DEFAULT '3',
                          `limitAces` tinyint NOT NULL DEFAULT '1',
                          `mainDeckMinSize` smallint DEFAULT NULL,
                          `isReleased` tinyint NOT NULL DEFAULT '0',
                          `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                          `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `format`
--

INSERT INTO `format` (`id`, `ownerId`, `name`, `mainDeckSize`, `extraDeckSize`, `duplicates`, `limitAces`, `mainDeckMinSize`, `isReleased`, `created_at`, `updated_at`) VALUES
    (1, 1, 'Standard', 80, 30, 3, 1, NULL, 1, '2024-06-24 15:51:34', '2024-06-24 15:51:34');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `format`
--
ALTER TABLE `format`
    ADD PRIMARY KEY (`id`),
  ADD KEY `ownerId` (`ownerId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `format`
--
ALTER TABLE `format`
    MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `format`
--
ALTER TABLE `format`
    ADD CONSTRAINT `format_ibfk_1` FOREIGN KEY (`ownerId`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;