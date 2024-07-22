-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 22, 2024 at 09:35 AM
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
-- Table structure for table `cardSupertype`
--

CREATE TABLE `cardSupertype` (
                                 `id` int(11) NOT NULL,
                                 `name` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cardSupertype`
--

INSERT INTO `cardSupertype` (`id`, `name`) VALUES
                                               (5, 'Domain'),
                                               (2, 'Hand Trap'),
                                               (3, 'Maximum'),
                                               (1, 'None'),
                                               (4, 'Pendulum');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cardSupertype`
--
ALTER TABLE `cardSupertype`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `name_2` (`name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cardSupertype`
--
ALTER TABLE `cardSupertype`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
