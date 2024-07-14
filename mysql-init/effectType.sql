-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 14, 2024 at 04:45 PM
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
-- Table structure for table `effectType`
--

CREATE TABLE `effectType` (
  `id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `effectType`
--

INSERT INTO `effectType` (`id`, `name`) VALUES
(1, 'Activate'),
(2, 'Armor-up'),
(50, 'Attacks'),
(3, 'Can attack directly'),
(4, 'Can be any material'),
(5, 'Can set face-up'),
(6, 'Cannot attack'),
(7, 'Cannot attack directly'),
(8, 'Cannot be activated'),
(9, 'Cannot face'),
(10, 'Change position'),
(11, 'Check if'),
(12, 'Count cards'),
(13, 'Counts as multiple tributes'),
(14, 'Destroy'),
(15, 'Discard'),
(16, 'Don\'t have to tribute'),
(17, 'Draw'),
(51, 'Ends turn'),
(52, 'Equip'),
(19, 'Exile'),
(18, 'Extramill'),
(53, 'Flipped when attacked'),
(20, 'Fuse from hand'),
(21, 'Gain control'),
(22, 'Give choice'),
(54, 'In maximum mode'),
(23, 'Instead'),
(24, 'Keyword'),
(55, 'Maximum summoned'),
(25, 'Mill'),
(26, 'Negate effects'),
(56, 'No monsters'),
(49, 'None'),
(27, 'Pay life'),
(28, 'Reborn'),
(29, 'Repeat'),
(30, 'Rescale'),
(31, 'Resettle'),
(32, 'Reshuffle'),
(33, 'Restack'),
(34, 'Retrieve'),
(35, 'Reverse stat-giving'),
(36, 'Sacrifice'),
(37, 'Send bottom'),
(38, 'Set'),
(39, 'Shoot'),
(40, 'Shuffle'),
(41, 'Shuffle-steal'),
(42, 'Stat'),
(43, 'Steals'),
(44, 'Summon'),
(57, 'Summoned this turn'),
(58, 'Summons'),
(45, 'Switch attack target'),
(59, 'Take damage'),
(46, 'Target'),
(47, 'Tokenize'),
(48, 'Top summon'),
(60, 'When equipped removed'),
(61, 'When removed'),
(62, 'Whenever'),
(63, 'You control only this');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `effectType`
--
ALTER TABLE `effectType`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `effectType`
--
ALTER TABLE `effectType`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;