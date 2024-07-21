-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 21, 2024 at 07:22 PM
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
-- Table structure for table `card`
--

CREATE TABLE `card` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `errataOfId` int(11) DEFAULT NULL,
  `cardName` varchar(32) NOT NULL,
  `serializedName` varchar(32) NOT NULL,
  `isAce` tinyint(4) NOT NULL,
  `cardClassId` int(11) NOT NULL,
  `cardTypeId` int(11) NOT NULL,
  `subtypeId` int(11) NOT NULL,
  `supertypeId` int(11) NOT NULL,
  `maximumPieceId` int(11) NOT NULL,
  `level` tinyint(4) NOT NULL,
  `atk` smallint(6) NOT NULL,
  `def` smallint(6) NOT NULL,
  `primaryMaterialId` int(11) DEFAULT NULL,
  `secondaryMaterialId` int(11) DEFAULT NULL,
  `tertiaryMaterialId` int(11) DEFAULT NULL,
  `materialsReminder` varchar(32) NOT NULL,
  `costText` varchar(256) NOT NULL,
  `effectText` varchar(256) NOT NULL,
  `flavourText` varchar(256) NOT NULL,
  `countsAsId` int(11) DEFAULT NULL,
  `specialCountsAsId` int(11) DEFAULT NULL,
  `artScale` smallint(6) NOT NULL,
  `artXOffset` smallint(6) NOT NULL,
  `artYOffset` smallint(6) NOT NULL,
  `nameSize` tinyint(4) NOT NULL,
  `materialsSize` tinyint(4) NOT NULL,
  `effectsSize` tinyint(4) NOT NULL,
  `expansionId` int(11) NOT NULL,
  `isDeleted` smallint(6) NOT NULL,
  `modifiedBy` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `card`
--

INSERT INTO `card` (`id`, `ownerId`, `errataOfId`, `cardName`, `serializedName`, `isAce`, `cardClassId`, `cardTypeId`, `subtypeId`, `supertypeId`, `maximumPieceId`, `level`, `atk`, `def`, `primaryMaterialId`, `secondaryMaterialId`, `tertiaryMaterialId`, `materialsReminder`, `costText`, `effectText`, `flavourText`, `countsAsId`, `specialCountsAsId`, `artScale`, `artXOffset`, `artYOffset`, `nameSize`, `materialsSize`, `effectsSize`, `expansionId`, `isDeleted`, `modifiedBy`, `created_at`, `updated_at`) VALUES
(15, 1, NULL, 'Undead Catalyst', '', 0, 4, 1, 4, 1, 1, 6, 1800, 200, 17, 18, NULL, '', '', '', 'Welcome the slime titan! If someone licks his juice, he turns them into a capybara.', NULL, NULL, 4, 0, 13, 2, 3, 5, 2, 0, 1, '2024-05-12 07:27:49', '2024-06-05 16:08:19'),
(16, 1, NULL, 'Hammer Waifu', 'HammerWaifu', 0, 2, 1, 2, 1, 1, 3, 1200, 0, NULL, NULL, NULL, '', 'Discard a card.{i}Hand{/i}', 'Target monster loses {sb}200{/sb} {b}atk{/b}.{i}All stat changes only last until the end of turn{/i}', '', NULL, NULL, 0, 0, 3, 4, 5, 5, 1, 0, 1, '2024-05-12 07:27:49', '2024-06-21 03:24:20'),
(17, 1, 17, '{i}The{/i}Guildmaster', 'Guildmaster', 0, 4, 1, 2, 1, 1, 7, 2100, 0, NULL, NULL, NULL, '', 'Mill {sb}2{/sb}.{i}From your deck{/i}', 'Gains {sb}400{/sb} {b}atk{/b} for each level-{sb}5{/sb} and {sb}higher{/sb} {sb}normal{/sb} {b}Slime{/b} in your grave.{i}Yellow{/i}', '', NULL, NULL, 0, 0, 0, 3, 5, 5, 2, 0, 1, '2024-05-12 07:27:49', '2024-06-25 12:55:04'),
(18, 1, NULL, 'Pitch-Black Ooze', '', 0, 4, 1, 1, 1, 1, 5, 1300, 0, NULL, NULL, NULL, '', '', '', 'Monsters so black that everyone fears them. They eat all the light, making them even darker than yo\' asshole.', NULL, NULL, 1, 0, 14, 2, 5, 5, 1, 0, 1, '2024-05-12 07:27:49', '2024-06-05 16:08:19'),
(19, 1, NULL, 'Cute Lady Anis', '', 0, 3, 1, 2, 1, 1, 6, 1600, 1600, NULL, NULL, NULL, '', 'None.{i}Tribute 1 monster to summon a level-5 or 6{/i}', 'Deal {sb}600{/sb} damage.{i}Opponent loses 600 life{/i}', '', NULL, NULL, 3, 9, 0, 4, 5, 5, 1, 0, 1, '2024-05-12 07:27:49', '2024-06-05 16:08:19'),
(20, 1, NULL, 'Apocalypse!', '', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', 'Level-{sb}7{/sb} or {sb}8{/sb} attacks.', 'Reborn a {sb}normal{/sb} {b}Zombie{/b}.{i}Traps can only be used on the opponent\'s turn{/i}', '', NULL, NULL, 0, 0, 0, 4, 5, 5, 1, 0, 1, '2024-05-12 07:27:49', '2024-06-05 16:08:19'),
(21, 1, NULL, 'Fernir\'s Curse', '', 0, 6, 1, 1, 1, 1, 5, 1700, 0, NULL, NULL, NULL, '', '', '', 'It has fangs so sharp that it can bite panties off highschool girls without them even noticing the rising wind.', NULL, NULL, 4, 9, 6, 4, 5, 5, 1, 0, 1, '2024-05-12 07:27:49', '2024-06-05 16:08:19'),
(22, 1, NULL, 'Pet of Misery', '', 0, 6, 1, 1, 1, 1, 2, 200, 1200, NULL, NULL, NULL, '', '', '', 'Dan got depressed after reincarnating as a pidgeon in a zombie apocalypse where cute girls are long since dead.', NULL, NULL, 0, 0, 0, 4, 5, 5, 1, 0, 1, '2024-05-12 07:27:49', '2024-06-05 16:08:19'),
(23, 1, NULL, 'Furry Chicken', 'FurryChicken', 0, 6, 1, 3, 1, 1, 7, 2100, 0, 21, 22, NULL, '', 'None.{i}This is a Fusion{/i}', 'Opponent discards their hand.{i}All cards in hand{/i}', '', NULL, NULL, 2, 2, 0, 4, 4, 5, 1, 0, 1, '2024-05-12 07:27:49', '2024-06-21 03:23:26'),
(24, 1, NULL, 'Venom Pit', '', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', 'Summons a level-{sb}2{/sb} or {sb}lower{/sb}; pay {sb}500{/sb}.{i}Life points when opponent summons{/i}', 'Destroy it.{i}To grave{/i}', '', NULL, NULL, 3, 8, 8, 4, 5, 5, 1, 0, 1, '2024-05-12 07:27:49', '2024-06-05 16:08:19'),
(25, 1, NULL, 'Greedy Treasure', 'GreedyTreasure', 0, 1, 2, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', 'You control {sb}2{/sb} level-{sb}2{/sb} {sb}normal{/sb} monsters.{i}Face-up{/i}', 'Draw {sb}2{/sb} cards.{i}Place 2 cards from deck to hand{/i}', '', NULL, NULL, 5, 12, 15, 2, 5, 5, 1, 0, 1, '2024-05-12 07:27:49', '2024-06-21 03:24:05'),
(26, 1, NULL, 'Sugar Bomb', 'SugarBomb', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', 'Attacks.{i}Opponent{/i}', 'Opponent mills {sb}3{/sb}.{i}They send cards from the top of their deck to their grave{/i}', '', NULL, NULL, 6, 13, 14, 4, 5, 5, 1, 0, 1, '2024-05-12 07:27:49', '2024-06-21 03:28:03'),
(27, 1, NULL, 'Mariam, Sheep', '', 0, 3, 1, 1, 1, 1, 1, 100, 1100, NULL, NULL, NULL, '', '', '', 'She travelled half the world to find her best friend, Benny the horse. But Benny was not a little boy anymore, oh no...', NULL, NULL, 3, 6, 7, 4, 5, 5, 1, 0, 1, '2024-05-12 07:27:49', '2024-06-05 16:08:19'),
(28, 1, NULL, 'Dotted Alive', 'DottedAlive', 0, 6, 1, 2, 1, 1, 2, 1100, 0, NULL, NULL, NULL, '', 'Mill {sb}2{/sb}.{i}From your deck{/i}', 'Counts as {sb}2{/sb} tributes for a level-{sb}7{/sb} {b}Zombie{/b} with {sb}0{/sb} {b}def{/b}.{i}During this turn, optional{/i}', '', NULL, NULL, 2, 6, 5, 4, 5, 5, 1, 0, 1, '2024-05-12 07:27:49', '2024-06-21 03:22:54'),
(29, 1, NULL, 'Dotted Alive', '', 0, 6, 1, 2, 1, 1, 2, 1100, 0, NULL, NULL, NULL, '', 'Mill {sb}2{/sb}.{i}From your deck{/i}', 'Counts as {sb}2{/sb} tributes for a level-{sb}7{/sb} {b}Zombie{/b} with {sb}0{/sb} {b}def{/b}.{i}During this turn{/i}', '', NULL, NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 07:27:49', '2024-06-05 16:08:19'),
(30, 1, NULL, 'Fallen Mantista', '', 0, 6, 1, 2, 1, 1, 7, 1900, 0, NULL, NULL, NULL, '', 'Mill {sb}2{/sb}{i}From your deck{/i}', 'Reborn a {sb}normal{/sb} {b}Zombie{/b} with {sb}0{/sb} {b}def{/b}. It gains {sb}1000{/sb} {b}atk{/b}.{i}From your grave{/i}', '', NULL, NULL, 0, 0, 0, 4, 5, 5, 1, 0, 1, '2024-05-12 07:27:49', '2024-06-05 16:08:19'),
(31, 1, NULL, 'Time to Isekai!', '', 1, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', 'Level-{sb}6{/sb} or {sb}7{/sb} attacks.', 'Destroy it. Opponent reveals {sb}top{/sb} card, and {sb}may{/sb} summon it.{i}Of their deck{/i}', '', NULL, NULL, 1, 5, 1, 4, 5, 5, 1, 0, 1, '2024-05-12 07:27:49', '2024-06-05 16:08:19'),
(32, 1, NULL, 'Thousand-Fold', '', 0, 6, 1, 1, 1, 1, 4, 1300, 0, NULL, NULL, NULL, '', '', '', 'Giant sea urchins love to eat mermaids from bottom up. If you enjoy tentacles, then wait what you can do with spikes...', NULL, NULL, 4, 11, 11, 4, 5, 5, 1, 0, 1, '2024-05-12 07:27:49', '2024-06-05 16:08:19'),
(33, 1, NULL, 'Spawn of Evil', 'SpawnOfEvil', 1, 6, 1, 1, 1, 1, 5, 2300, 0, NULL, NULL, NULL, '', '', '', 'From infernos rose a man with a mission – have his revenge on the illiterate pagans. Read heathen, read!', NULL, NULL, 8, 13, 6, 4, 5, 5, 1, 0, 1, '2024-05-12 07:27:49', '2024-06-21 03:27:50'),
(34, 1, NULL, 'Poison Scales', '', 0, 6, 1, 1, 1, 1, 2, 900, 300, NULL, NULL, NULL, '', '', '', 'These snakes hunt ogres at the swamp, their scales blown up from all the times they were used as balloons.', NULL, NULL, 0, 0, 0, 4, 5, 5, 1, 0, 1, '2024-05-12 07:27:49', '2024-06-05 16:08:19'),
(35, 1, NULL, 'Fallen in Death', '', 0, 6, 1, 1, 1, 1, 3, 1100, 300, NULL, NULL, NULL, '', '', '', 'They say that naughty girls who fall in love with pirates, get cursed to live an eternity as mermaids with them.', NULL, NULL, 5, 10, 8, 4, 5, 5, 1, 0, 1, '2024-05-12 07:27:49', '2024-06-05 16:08:19'),
(36, 1, NULL, 'Giant Blue Ogre', '', 0, 6, 1, 1, 1, 1, 7, 2100, 0, NULL, NULL, NULL, '', '', '', 'Their skin became blue after the ogres inhaled all the nitrogen in the air, beginning the zombie apocalypse.', NULL, NULL, 1, 3, 0, 3, 5, 5, 1, 0, 1, '2024-05-12 07:27:49', '2024-06-05 16:08:19'),
(37, 1, 37, 'Grandson\'s Fate', 'GrandsonsFate', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', 'Level-{sb}7{/sb} or {sb}lower{/sb} attacks.', 'Attacker loses {sb}100{/sb} {b}atk{/b} for each card with same {sb}class{/sb} in their grave.{i}Opponent\'s{/i}', '', NULL, NULL, 0, 0, 0, 3, 5, 5, 1, 0, 1, '2024-05-12 07:27:49', '2024-06-05 17:17:34'),
(38, 1, NULL, 'Evolved Hydra', '', 0, 6, 1, 3, 1, 1, 7, 2000, 300, 36, 34, NULL, '', 'Mill {sb}1{/sb}.{i}From your deck{/i}', 'Gains {sb}200{/sb} {b}atk{/b} for each {sb}normal{/sb} {b}Zombie{/b} in your grave.', '', NULL, NULL, 2, 6, 0, 4, 3, 5, 1, 0, 1, '2024-05-12 07:27:49', '2024-06-05 16:08:19'),
(39, 1, NULL, 'Insect Priestess', 'InsectPriestess', 0, 6, 1, 3, 1, 1, 7, 2600, 0, 30, 28, NULL, '', 'Summoned {sb}this{/sb} turn; have {sb}10{/sb} {b}Zombies{/b} in grave.', 'Retrieve a {b}Spell{/b}.', '', NULL, NULL, 6, 18, 5, 3, 3, 5, 1, 0, 1, '2024-05-12 07:27:49', '2024-06-21 03:23:52'),
(40, 1, NULL, 'Spinal Urchin', '', 0, 6, 1, 3, 1, 1, 5, 1600, 300, 32, 35, NULL, '', 'Reshuffle a {b}Zombie{/b}.{i}Shuffle from grave to deck{/i}', 'Opponent mills {sb}3{/sb}.', '', NULL, NULL, 3, 6, 1, 4, 3, 5, 1, 0, 1, '2024-05-12 07:27:49', '2024-06-05 16:08:19'),
(41, 1, NULL, 'wqeqwe', '', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', '', NULL, NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 07:27:49', '2024-06-05 16:08:19'),
(42, 1, NULL, '11222222', '', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', '', NULL, NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 07:27:49', '2024-06-05 16:08:19'),
(43, 1, 43, 'Spider Eggs', 'SpiderEggs', 0, 4, 1, 1, 1, 1, 5, 1600, 200, NULL, NULL, NULL, '', '', '', 'Hello Methew, I will not be home for a while because I found one... The chokolate arachnids, they are real!', NULL, NULL, 0, 0, 0, 4, 5, 5, 1, 0, 1, '2024-05-12 07:27:49', '2024-06-06 11:25:16'),
(44, 2, NULL, 'Lolo', '', 0, 2, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', '', NULL, NULL, 1, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 07:27:49', '2024-06-05 16:08:19'),
(45, 2, NULL, 'Apocalypse!', '', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', 'Level-{sb}7{/sb} or {sb}8{/sb} attacks.', 'Reborn a {sb}normal{/sb} {b}Zombie{/b}.{i}Traps can only be used on the opponent\'s turn{/i}', '', NULL, NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 07:27:49', '2024-06-05 16:08:19'),
(46, 2, NULL, 'Apocalypse!', '', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', 'Level-{sb}7{/sb} or {sb}8{/sb} attacks.', 'Reborn a {sb}normal{/sb} {b}Zombie{/b}.{i}Traps can only be used on the opponent\'s turn{/i}', '', NULL, NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 07:27:49', '2024-06-05 16:08:19'),
(47, 2, NULL, 'Apocalypse!', '', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', 'Level-{sb}7{/sb} or {sb}8{/sb} attacks.', 'Reborn a {sb}normal{/sb} {b}Zombie{/b}.{i}Traps can only be used on the opponent\'s turn{/i}', '', NULL, NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 07:27:49', '2024-06-05 16:08:19'),
(48, 2, NULL, 'Apocalypse', '', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', '', NULL, NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 07:27:49', '2024-06-05 16:08:19'),
(49, 2, NULL, 'gffdgd', '', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', '', NULL, NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 07:27:49', '2024-06-05 16:08:19'),
(50, 2, NULL, 'Ramibn', '', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', '', NULL, NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 07:27:49', '2024-06-05 16:08:19'),
(51, 1, NULL, 'req', '', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', '', NULL, NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 07:27:49', '2024-06-05 16:08:19'),
(52, 2, NULL, 'rrr', '', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', '', NULL, NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 07:27:49', '2024-06-05 16:08:19'),
(53, 2, NULL, 'Tuomas Jees', '', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', '', NULL, NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 07:27:49', '2024-06-05 16:08:19'),
(54, 2, NULL, 'Tuomas Jees', '', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', '', NULL, NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 07:27:49', '2024-06-05 16:08:19');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `card`
--
ALTER TABLE `card`
  ADD PRIMARY KEY (`id`),
  ADD KEY `primaryMaterialId` (`primaryMaterialId`),
  ADD KEY `secondaryMaterialId` (`secondaryMaterialId`),
  ADD KEY `tertiaryMaterialId` (`tertiaryMaterialId`),
  ADD KEY `countsAsId` (`countsAsId`),
  ADD KEY `expansionId` (`expansionId`),
  ADD KEY `userId` (`ownerId`),
  ADD KEY `modifiedBy` (`modifiedBy`),
  ADD KEY `errataOfId` (`errataOfId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `card`
--
ALTER TABLE `card`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=548;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `card`
--
ALTER TABLE `card`
  ADD CONSTRAINT `card_ibfk_10` FOREIGN KEY (`secondaryMaterialId`) REFERENCES `card` (`id`),
  ADD CONSTRAINT `card_ibfk_11` FOREIGN KEY (`tertiaryMaterialId`) REFERENCES `card` (`id`),
  ADD CONSTRAINT `card_ibfk_12` FOREIGN KEY (`countsAsId`) REFERENCES `card` (`id`),
  ADD CONSTRAINT `card_ibfk_5` FOREIGN KEY (`expansionId`) REFERENCES `expansion` (`id`),
  ADD CONSTRAINT `card_ibfk_6` FOREIGN KEY (`ownerId`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `card_ibfk_7` FOREIGN KEY (`modifiedBy`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `card_ibfk_8` FOREIGN KEY (`errataOfId`) REFERENCES `card` (`id`),
  ADD CONSTRAINT `card_ibfk_9` FOREIGN KEY (`primaryMaterialId`) REFERENCES `card` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;