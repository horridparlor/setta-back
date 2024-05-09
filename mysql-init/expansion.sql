-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 09, 2024 at 12:11 PM
-- Server version: 10.6.17-MariaDB-cll-lve
-- PHP Version: 8.1.28

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
                             `name` varchar(32) NOT NULL,
                             `releaseYear` int(11) NOT NULL DEFAULT 2024,
                             `isReleased` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `expansion`
--

INSERT INTO `expansion` (`id`, `name`, `releaseYear`, `isReleased`) VALUES
                                                                        (1, 'Set 1', 2023, 1),
                                                                        (2, 'Mini 1', 2024, 1),
                                                                        (3, 'Mini 2', 2024, 1),
                                                                        (4, 'Mini 3', 2024, 1),
                                                                        (5, 'Mini 4', 2024, 1),
                                                                        (6, 'Mini 5', 2024, 1),
                                                                        (7, 'Set 2', 2024, 1),
                                                                        (8, 'Unreleased', 2024, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `expansion`
--
ALTER TABLE `expansion`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `expansion`
--
ALTER TABLE `expansion`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;