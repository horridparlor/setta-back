-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 14, 2024 at 08:10 PM
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
-- Table structure for table `card`
--

CREATE TABLE `card` (
                        `id` int(11) NOT NULL,
                        `ownerId` int(11) NOT NULL,
                        `cardName` varchar(32) NOT NULL,
                        `isAce` tinyint(4) NOT NULL,
                        `cardClassId` int(11) NOT NULL,
                        `cardTypeId` int(11) NOT NULL,
                        `subtypeId` int(11) NOT NULL,
                        `supertypeId` int(11) NOT NULL,
                        `maximumPieceId` int(11) NOT NULL,
                        `level` int(11) NOT NULL,
                        `atk` int(11) NOT NULL,
                        `def` int(11) NOT NULL,
                        `primaryMaterialId` int(11) DEFAULT NULL,
                        `secondaryMaterialId` int(11) DEFAULT NULL,
                        `tertiaryMaterialId` int(11) DEFAULT NULL,
                        `materialsReminder` varchar(32) NOT NULL,
                        `costText` varchar(256) NOT NULL,
                        `effectText` varchar(256) NOT NULL,
                        `flavourText` varchar(256) NOT NULL,
                        `countsAsId` int(11) DEFAULT NULL,
                        `artScale` int(11) NOT NULL,
                        `artXOffset` int(11) NOT NULL,
                        `artYOffset` int(11) NOT NULL,
                        `nameSize` int(11) NOT NULL,
                        `materialsSize` int(11) NOT NULL,
                        `effectsSize` int(11) NOT NULL,
                        `expansionId` int(11) NOT NULL,
                        `isDeleted` smallint(6) NOT NULL,
                        `modifiedBy` int(11) NOT NULL,
                        `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
                        `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `card`
--

INSERT INTO `card` (`id`, `ownerId`, `cardName`, `isAce`, `cardClassId`, `cardTypeId`, `subtypeId`, `supertypeId`, `maximumPieceId`, `level`, `atk`, `def`, `primaryMaterialId`, `secondaryMaterialId`, `tertiaryMaterialId`, `materialsReminder`, `costText`, `effectText`, `flavourText`, `countsAsId`, `artScale`, `artXOffset`, `artYOffset`, `nameSize`, `materialsSize`, `effectsSize`, `expansionId`, `isDeleted`, `modifiedBy`, `created_at`, `updated_at`) VALUES
                                                                                                                                                                                                                                                                                                                                                                                                                                                                        (15, 1, 'Undead Catalyst', 0, 4, 1, 4, 1, 1, 6, 1800, 200, 17, 18, NULL, '', '', '', 'Welcome the slime titan! If someone licks his juice, he turns them into a capybara.', NULL, 4, 0, 13, 2, 3, 5, 2, 0, 1, '2024-05-12 10:27:49', '2024-05-13 08:02:44'),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                        (16, 1, 'Hammer Waifu', 0, 2, 1, 2, 1, 1, 3, 1200, 0, NULL, NULL, NULL, '', 'Discard a card.{i}Hand{/i}', 'Target monster loses {sb}200{/sb} {b}atk{/b}.{i}All stat changes only last until the end of the turn{/i}', '', NULL, 0, 0, 3, 4, 5, 5, 1, 0, 1, '2024-05-12 10:27:49', '2024-05-13 07:43:07'),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                        (17, 1, '{i}The{/i}Guildmaster', 0, 4, 1, 2, 1, 1, 7, 2100, 0, NULL, NULL, NULL, '', 'Mill {sb}2{/sb}.{i}From your deck{/i}', 'Gains {sb}400{/sb} {b}atk{/b} for each level-{sb}5{/sb} and {sb}higher{/sb} {sb}normal{/sb} {b}Slime{/b} in your grave.{i}Yellow{/i}', '', NULL, 0, 0, 0, 3, 5, 5, 2, 0, 1, '2024-05-12 10:27:49', '2024-05-13 08:00:32'),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                        (18, 1, 'Pitch-Black Ooze', 0, 4, 1, 1, 1, 1, 5, 1300, 0, NULL, NULL, NULL, '', '', '', 'Monsters so black that everyone fears them. They eat all the light, making them even darker than yo\' asshole.', NULL, 1, 0, 14, 2, 5, 5, 1, 0, 1, '2024-05-12 10:27:49', '2024-05-13 07:44:48'),
(19, 1, 'Cute Lady Anis', 0, 3, 1, 2, 1, 1, 6, 1600, 1600, NULL, NULL, NULL, '', 'None.{i}Tribute 1 monster to summon a level-5 or 6{/i}', 'Deal {sb}600{/sb} damage.{i}Opponent loses 600 life{/i}', '', NULL, 3, 9, 0, 4, 5, 5, 1, 0, 1, '2024-05-12 10:27:49', '2024-05-13 07:29:55'),
(20, 1, 'Apocalypse!', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', 'Level-{sb}7{/sb} or {sb}8{/sb} attacks.', 'Reborn a {sb}normal{/sb} {b}Zombie{/b}.{i}Traps can only be used on the opponent\'s turn{/i}', '', NULL, 0, 0, 0, 4, 5, 5, 1, 0, 1, '2024-05-12 10:27:49', '2024-05-13 07:27:42'),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                        (21, 1, 'Fernir\'s Curse', 0, 6, 1, 1, 1, 1, 5, 1700, 0, NULL, NULL, NULL, '', '', '', 'It has fangs so sharp that it can bite panties off highschool girls without them even noticing the rising wind.', NULL, 4, 9, 6, 4, 5, 5, 1, 0, 1, '2024-05-12 10:27:49', '2024-05-13 07:41:40'),
(22, 1, 'Pet of Misery', 0, 6, 1, 1, 1, 1, 2, 200, 1200, NULL, NULL, NULL, '', '', '', 'Dan got depressed after reincarnating as a pidgeon in a zombie apocalypse where cute girls are long since dead.', NULL, 0, 0, 0, 4, 5, 5, 1, 0, 1, '2024-05-12 10:27:49', '2024-05-13 07:44:34'),
(23, 1, 'Furry Chicken', 0, 6, 1, 3, 1, 1, 7, 2100, 0, 21, 22, NULL, '', 'None.{i}This is a Fusion{/i}', 'Opponent discards their hand.{i}All cards in their hand{/i}', '', NULL, 2, 2, 0, 4, 4, 5, 1, 0, 1, '2024-05-12 10:27:49', '2024-05-13 07:41:58'),
(24, 1, 'Venom Pit', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', 'Summons a level-{sb}2{/sb} or {sb}lower{/sb}; pay {sb}500{/sb}.{i}Life points when opponent summons{/i}', 'Destroy it.{i}To grave{/i}', '', NULL, 3, 8, 8, 4, 5, 5, 1, 0, 1, '2024-05-12 10:27:49', '2024-05-13 07:48:54'),
(25, 1, 'Greedy Treasure', 0, 1, 2, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', 'You control {sb}2{/sb} level-{sb}2{/sb} {sb}normal{/sb} monsters.{i}Face-up{/i}', 'Draw {sb}2{/sb} cards.{i}Place 2 cards from your deck to hand{/i}', '', NULL, 5, 12, 15, 2, 5, 5, 1, 0, 1, '2024-05-12 10:27:49', '2024-05-13 07:42:57'),
(26, 1, 'Sugar Bomb', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', 'Attacks.{i}Opponent does{/i}', 'Opponent mills {sb}3{/sb}.{i}They send cards from the top of their deck to their grave{/i}', '', NULL, 6, 13, 14, 4, 5, 5, 1, 0, 1, '2024-05-12 10:27:49', '2024-05-13 07:48:09'),
(27, 1, 'Mariam, Sheep', 0, 3, 1, 1, 1, 1, 1, 100, 1100, NULL, NULL, NULL, '', '', '', 'She travelled half the world to find her best friend, Benny the horse. But Benny was not a little boy anymore, oh no...', NULL, 3, 6, 7, 4, 5, 5, 1, 0, 1, '2024-05-12 10:27:49', '2024-05-13 07:43:48'),
(28, 1, 'Dotted Alive', 0, 6, 1, 2, 1, 1, 2, 1100, 0, NULL, NULL, NULL, '', 'Mill {sb}2{/sb}.{i}From your deck{/i}', 'Counts as {sb}2{/sb} tributes for a level-{sb}7{/sb} {b}Zombie{/b} with {sb}0{/sb} {b}def{/b}.{i}During this turn{/i}', '', NULL, 2, 6, 5, 4, 5, 5, 1, 0, 1, '2024-05-12 10:27:49', '2024-05-13 07:30:24'),
(29, 1, 'Dotted Alive', 0, 6, 1, 2, 1, 1, 2, 1100, 0, NULL, NULL, NULL, '', 'Mill {sb}2{/sb}.{i}From your deck{/i}', 'Counts as {sb}2{/sb} tributes for a level-{sb}7{/sb} {b}Zombie{/b} with {sb}0{/sb} {b}def{/b}.{i}During this turn{/i}', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(30, 1, 'Fallen Mantista', 0, 6, 1, 2, 1, 1, 7, 1900, 0, NULL, NULL, NULL, '', 'Mill {sb}2{/sb}{i}From your deck{/i}', 'Reborn a {sb}normal{/sb} {b}Zombie{/b} with {sb}0{/sb} {b}def{/b}. It gains {sb}1000{/sb} {b}atk{/b}.{i}From your grave{/i}', '', NULL, 0, 0, 0, 4, 5, 5, 1, 0, 1, '2024-05-12 10:27:49', '2024-05-13 07:41:24'),
(31, 1, 'Time to Isekai!', 1, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', 'Level-{sb}6{/sb} or {sb}7{/sb} attacks.', 'Destroy it. Opponent reveals {sb}top{/sb} card, and {sb}may{/sb} summon it.{i}Of their deck{/i}', '', NULL, 1, 5, 1, 4, 5, 5, 1, 0, 1, '2024-05-12 10:27:49', '2024-05-13 07:48:39'),
(32, 1, 'Thousand-Fold', 0, 6, 1, 1, 1, 1, 4, 1300, 0, NULL, NULL, NULL, '', '', '', 'Giant sea urchins love to eat mermaids from bottom up. If you enjoy tentacles, then wait what you can do with spikes...', NULL, 4, 11, 11, 4, 5, 5, 1, 0, 1, '2024-05-12 10:27:49', '2024-05-13 07:48:31'),
(33, 1, 'Spawn of Evil', 1, 6, 1, 1, 1, 1, 5, 2300, 0, NULL, NULL, NULL, '', '', '', 'From infernos rose a man with a mission, to have his revenge on the pagans who never read. Read heathen, read!', NULL, 8, 13, 6, 4, 5, 5, 1, 0, 1, '2024-05-12 10:27:49', '2024-05-13 07:47:26'),
(34, 1, 'Poison Scales', 0, 6, 1, 1, 1, 1, 2, 900, 300, NULL, NULL, NULL, '', '', '', 'These snakes hunt ogres at the swamp, their scales blown up from all the times they were used as balloons.', NULL, 0, 0, 0, 4, 5, 5, 1, 0, 1, '2024-05-12 10:27:49', '2024-05-13 07:44:58'),
(35, 1, 'Fallen in Death', 0, 6, 1, 1, 1, 1, 3, 1100, 300, NULL, NULL, NULL, '', '', '', 'They say that naughty girls who fall in love with pirates, get cursed to live an eternity as mermaids with them.', NULL, 5, 10, 8, 4, 5, 5, 1, 0, 1, '2024-05-12 10:27:49', '2024-05-13 07:41:15'),
(36, 1, 'Giant Blue Ogre', 0, 6, 1, 1, 1, 1, 7, 2100, 0, NULL, NULL, NULL, '', '', '', 'Their skin became blue after the ogres inhaled all the nitrogen in the air, beginning the zombie apocalypse.', NULL, 1, 3, 0, 3, 5, 5, 1, 0, 1, '2024-05-12 10:27:49', '2024-05-13 07:42:09'),
(37, 1, 'Grandson\'s Fate', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', 'Level-{sb}7{/sb} or {sb}lower{/sb} attacks.', 'Attacker loses {sb}100{/sb} {b}atk{/b} for each card with same {sb}class{/sb} in their grave.{i}Opponent\'s{/i}', '', NULL, 0, 0, 0, 3, 5, 5, 1, 0, 1, '2024-05-12 10:27:49', '2024-05-13 07:42:17'),
(38, 1, 'Evolved Hydra', 0, 6, 1, 3, 1, 1, 7, 2000, 300, 36, 34, NULL, '', 'Mill {sb}1{/sb}.{i}From your deck{/i}', 'Gains {sb}200{/sb} {b}atk{/b} for each {sb}normal{/sb} {b}Zombie{/b} in your grave.', '', NULL, 2, 6, 0, 4, 3, 5, 1, 0, 1, '2024-05-12 10:27:49', '2024-05-13 07:41:06'),
(39, 1, 'Insect Priestess', 0, 6, 1, 3, 1, 1, 7, 2600, 0, 30, 28, NULL, '', 'Summoned {sb}this{/sb} turn; you have {sb}10{/sb} {b}Zombies{/b} in grave.', 'Retrieve a {b}Spell{/b}.{i}Grave{/i}', '', NULL, 6, 18, 5, 3, 4, 5, 1, 0, 1, '2024-05-12 10:27:49', '2024-05-13 07:43:24'),
(40, 1, 'Spinal Urchin', 0, 6, 1, 3, 1, 1, 5, 1600, 300, 32, 35, NULL, '', 'Reshuffle a {b}Zombie{/b}.{i}Shuffle from grave to deck{/i}', 'Opponent mills {sb}3{/sb}.', '', NULL, 3, 6, 1, 4, 3, 5, 1, 0, 1, '2024-05-12 10:27:49', '2024-05-13 07:47:45'),
(41, 1, 'wqeqwe', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(42, 1, '11222222', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(43, 1, 'Spider Eggs', 0, 4, 1, 1, 1, 1, 5, 1600, 200, NULL, NULL, NULL, '', '', '', 'Hello Methew, I will not be home for a while because I found one... The chokolate arachnids, they are real!', NULL, 0, 0, 0, 4, 5, 5, 1, 0, 1, '2024-05-12 10:27:49', '2024-05-13 07:47:37'),
(44, 2, 'Lolo', 0, 2, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', '', NULL, 1, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(45, 2, 'Apocalypse!', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', 'Level-{sb}7{/sb} or {sb}8{/sb} attacks.', 'Reborn a {sb}normal{/sb} {b}Zombie{/b}.{i}Traps can only be used on the opponent\'s turn{/i}', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(46, 2, 'Apocalypse!', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', 'Level-{sb}7{/sb} or {sb}8{/sb} attacks.', 'Reborn a {sb}normal{/sb} {b}Zombie{/b}.{i}Traps can only be used on the opponent\'s turn{/i}', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(47, 2, 'Apocalypse!', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', 'Level-{sb}7{/sb} or {sb}8{/sb} attacks.', 'Reborn a {sb}normal{/sb} {b}Zombie{/b}.{i}Traps can only be used on the opponent\'s turn{/i}', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(48, 2, 'Apocalypse', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(49, 2, 'gffdgd', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(50, 2, 'Ramibn', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(51, 1, 'req', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(52, 2, 'rrr', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(53, 2, 'Tuomas Jees', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(54, 2, 'Tuomas Jees', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49');

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
  ADD KEY `modifiedBy` (`modifiedBy`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `card`
--
ALTER TABLE `card`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=305;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `card`
--
ALTER TABLE `card`
    ADD CONSTRAINT `card_ibfk_1` FOREIGN KEY (`primaryMaterialId`) REFERENCES `card` (`id`),
  ADD CONSTRAINT `card_ibfk_2` FOREIGN KEY (`secondaryMaterialId`) REFERENCES `card` (`id`),
  ADD CONSTRAINT `card_ibfk_3` FOREIGN KEY (`tertiaryMaterialId`) REFERENCES `card` (`id`),
  ADD CONSTRAINT `card_ibfk_4` FOREIGN KEY (`countsAsId`) REFERENCES `card` (`id`),
  ADD CONSTRAINT `card_ibfk_5` FOREIGN KEY (`expansionId`) REFERENCES `expansion` (`id`),
  ADD CONSTRAINT `card_ibfk_6` FOREIGN KEY (`ownerId`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `card_ibfk_7` FOREIGN KEY (`modifiedBy`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;