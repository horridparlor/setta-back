-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 23, 2024 at 11:14 PM
-- Server version: 10.6.20-MariaDB-cll-lve
-- PHP Version: 8.3.14

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
-- Table structure for table `actionType`
--

CREATE TABLE `actionType` (
  `id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `requiresInput` tinyint(4) NOT NULL DEFAULT 0,
  `isMetaAction` tinyint(4) NOT NULL DEFAULT 0,
  `timeout` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `actionType`
--

INSERT INTO `actionType` (`id`, `name`, `requiresInput`, `isMetaAction`, `timeout`) VALUES
(1, 'drawCards', 0, 1, NULL),
(2, 'startTurn', 0, 1, NULL),
(3, 'startMain', 0, 1, NULL),
(4, 'startBattle', 0, 1, NULL),
(5, 'endTurn', 0, 0, NULL),
(6, 'mainPhase', 1, 1, NULL),
(7, 'battlePhase', 1, 1, NULL),
(8, 'cancelAction', 0, 1, NULL),
(9, 'setCard', 0, 1, NULL),
(10, 'summonMonster', 0, 0, NULL),
(11, 'activateTrap', 0, 1, NULL),
(12, 'activateSpell', 0, 0, NULL),
(13, 'activateEffect', 0, 0, NULL),
(14, 'activateHandTrap', 0, 1, NULL),
(15, 'anytimeEffect', 0, 1, NULL),
(16, 'timeTravel', 0, 1, NULL),
(17, 'reshuffleCards', 0, 1, NULL),
(18, 'attackCard', 0, 0, NULL),
(19, 'destroyCards', 0, 1, NULL),
(20, 'millCards', 0, 1, NULL),
(21, 'voidCards', 0, 1, NULL),
(22, 'purgeCards', 0, 1, NULL),
(23, 'cardsDestroyed', 0, 0, NULL),
(24, 'shootPlayers', 0, 1, NULL),
(25, 'gainStats', 0, 1, NULL),
(26, 'gainLife', 0, 1, NULL),
(27, 'selectTargets', 1, 1, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `actionType`
--
ALTER TABLE `actionType`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `actionType`
--
ALTER TABLE `actionType`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;