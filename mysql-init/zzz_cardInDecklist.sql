-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 19, 2024 at 05:27 PM
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
-- Table structure for table `cardInDecklist`
--

CREATE TABLE `cardInDecklist` (
  `id` int(11) NOT NULL,
  `deckId` int(11) NOT NULL,
  `cardId` int(11) NOT NULL,
  `copies` tinyint(4) NOT NULL,
  `deckBlockId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cardInDecklist`
--
ALTER TABLE `cardInDecklist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `deckId` (`deckId`),
  ADD KEY `cardId` (`cardId`),
  ADD KEY `deckBlockId` (`deckBlockId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cardInDecklist`
--
ALTER TABLE `cardInDecklist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cardInDecklist`
--
ALTER TABLE `cardInDecklist`
  ADD CONSTRAINT `cardInDecklist_ibfk_1` FOREIGN KEY (`deckId`) REFERENCES `decklist` (`id`),
  ADD CONSTRAINT `cardInDecklist_ibfk_2` FOREIGN KEY (`cardId`) REFERENCES `card` (`id`),
  ADD CONSTRAINT `cardInDecklist_ibfk_3` FOREIGN KEY (`deckBlockId`) REFERENCES `deckBlock` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;