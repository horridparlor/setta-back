-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 14, 2024 at 03:20 PM
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
-- Table structure for table `effectsEffect`
--

CREATE TABLE `effectsEffect` (
  `id` int(11) NOT NULL,
  `effectTypeId` int(11) NOT NULL,
  `relationId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `timingId` int(11) NOT NULL,
  `amount` int(11) DEFAULT NULL,
  `countedAmountId` int(11) DEFAULT NULL,
  `countedMin` int(11) DEFAULT NULL,
  `countedMax` int(11) DEFAULT NULL,
  `chainedEffectId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `effectsEffect`
--
ALTER TABLE `effectsEffect`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chainedEffectId` (`chainedEffectId`),
  ADD KEY `effectTypeId` (`effectTypeId`),
  ADD KEY `relationId` (`relationId`),
  ADD KEY `effectsEffect_ibfk_4` (`timingId`),
  ADD KEY `targetId` (`targetId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `effectsEffect`
--
ALTER TABLE `effectsEffect`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `effectsEffect`
--
ALTER TABLE `effectsEffect`
  ADD CONSTRAINT `effectsEffect_ibfk_1` FOREIGN KEY (`chainedEffectId`) REFERENCES `effectsEffect` (`id`),
  ADD CONSTRAINT `effectsEffect_ibfk_2` FOREIGN KEY (`effectTypeId`) REFERENCES `effectType` (`id`),
  ADD CONSTRAINT `effectsEffect_ibfk_3` FOREIGN KEY (`relationId`) REFERENCES `effectRelation` (`id`),
  ADD CONSTRAINT `effectsEffect_ibfk_4` FOREIGN KEY (`timingId`) REFERENCES `effectTiming` (`id`),
  ADD CONSTRAINT `effectsEffect_ibfk_5` FOREIGN KEY (`targetId`) REFERENCES `effectTarget` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;