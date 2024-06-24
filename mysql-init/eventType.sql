-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3310
-- Generation Time: Jun 24, 2024 at 06:43 PM
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
-- Table structure for table `eventType`
--

CREATE TABLE `eventType` (
                             `id` int NOT NULL,
                             `name` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `eventType`
--

INSERT INTO `eventType` (`id`, `name`) VALUES
                                           (5, 'Ask response'),
                                           (9, 'Attack'),
                                           (7, 'Change turn phase'),
                                           (4, 'Count cards'),
                                           (17, 'Count stat'),
                                           (13, 'Counts as tributes'),
                                           (14, 'Gains keyword'),
                                           (15, 'Has keyword'),
                                           (16, 'Loses keyword'),
                                           (2, 'Move card'),
                                           (11, 'Needs material'),
                                           (12, 'Needs tributes'),
                                           (1, 'Player wins'),
                                           (18, 'Replace value'),
                                           (10, 'Reveal card'),
                                           (6, 'Shuffle deck'),
                                           (3, 'Stat change'),
                                           (8, 'Wait for player');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `eventType`
--
ALTER TABLE `eventType`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `eventType`
--
ALTER TABLE `eventType`
    MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;