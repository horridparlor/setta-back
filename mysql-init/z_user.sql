-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 30, 2024 at 09:22 AM
-- Server version: 10.6.19-MariaDB-cll-lve
-- PHP Version: 8.3.12

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
-- Table structure for table `user`
--

CREATE TABLE `user` (
                        `id` int(11) NOT NULL,
                        `username` varchar(16) NOT NULL,
                        `firstname` varchar(16) NOT NULL,
                        `lastname` varchar(16) NOT NULL,
                        `penName` varchar(32) DEFAULT NULL,
                        `email` varchar(32) DEFAULT NULL,
                        `phoneNumber` varchar(32) DEFAULT NULL,
                        `isActive` tinyint(4) NOT NULL DEFAULT 1,
                        `roleId` int(11) DEFAULT NULL,
                        `accessRights` text DEFAULT NULL,
                        `passwordHash` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `firstname`, `lastname`, `penName`, `email`, `phoneNumber`, `isActive`, `roleId`, `accessRights`, `passwordHash`) VALUES
                                                                                                                                                            (0, 'null', 'null', 'null', NULL, 'null', NULL, 1, 1, NULL, 'null'),
                                                                                                                                                            (1, 'metaRakuel', 'Eero', 'Laine', NULL, 'eero.laine.posti@gmail.com', NULL, 1, 2, NULL, '$2y$10$t.H.Gz0ZJ3MB2VLoYa8H0OB5EPSOPH0ySucULCDimOL3hVJz62dPe'),
                                                                                                                                                            (2, 'tuomas', 'Tuomas', 'Lehtonen', NULL, 'munEmail@gmail.com', NULL, 1, 1, NULL, '$2y$10$0NYZ73qlRqAHz1sSOfUS0.fYVdXJnvvu/uSf7BbTaG67ryV6mFbRe');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `user`
--
ALTER TABLE `user`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`,`email`),
  ADD KEY `roleId` (`roleId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `user`
--
ALTER TABLE `user`
    ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `userRole` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
