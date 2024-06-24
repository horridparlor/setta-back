-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3310
-- Generation Time: Jun 24, 2024 at 04:31 PM
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
-- Table structure for table `league`
--

CREATE TABLE `league` (
                          `id` int NOT NULL,
                          `name` varchar(16) NOT NULL,
                          `rank` smallint DEFAULT NULL,
                          `divisions` tinyint NOT NULL DEFAULT '3',
                          `isReleased` tinyint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `league`
--

INSERT INTO `league` (`id`, `name`, `rank`, `divisions`, `isReleased`) VALUES
                                                                           (1, 'Poopy', 3, 4, 1),
                                                                           (2, 'Millionaire', 5, 6, 0),
                                                                           (3, 'Billionaire', 6, 7, 0),
                                                                           (4, 'Newbie', 1, 4, 1),
                                                                           (5, 'Loser', 2, 3, 1),
                                                                           (6, 'Masters', 4, 5, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `league`
--
ALTER TABLE `league`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `league`
--
ALTER TABLE `league`
    MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;