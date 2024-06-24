-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3310
-- Generation Time: Jun 24, 2024 at 04:05 PM
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
-- Table structure for table `cardInDecklist`
--

CREATE TABLE `cardInDecklist` (
                                  `id` int NOT NULL,
                                  `cardId` int NOT NULL,
                                  `deckId` int NOT NULL,
                                  `amount` tinyint NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `cardInDecklist`
--

INSERT INTO `cardInDecklist` (`id`, `cardId`, `deckId`, `amount`) VALUES
    (1, 20, 1, 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cardInDecklist`
--
ALTER TABLE `cardInDecklist`
    ADD PRIMARY KEY (`id`),
  ADD KEY `cardId` (`cardId`),
  ADD KEY `deckId` (`deckId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cardInDecklist`
--
ALTER TABLE `cardInDecklist`
    MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cardInDecklist`
--
ALTER TABLE `cardInDecklist`
    ADD CONSTRAINT `cardInDecklist_ibfk_1` FOREIGN KEY (`cardId`) REFERENCES `card` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `cardInDecklist_ibfk_2` FOREIGN KEY (`deckId`) REFERENCES `decklist` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;