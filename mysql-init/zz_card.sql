-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 12, 2024 at 01:27 PM
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

INSERT INTO `card` (`id`, `ownerId`, `cardName`, `isAce`, `cardClassId`, `cardTypeId`, `subtypeId`, `supertypeId`, `maximumPieceId`, `level`, `atk`, `def`, `primaryMaterialId`, `secondaryMaterialId`, `tertiaryMaterialId`, `costText`, `effectText`, `flavourText`, `countsAsId`, `artScale`, `artXOffset`, `artYOffset`, `nameSize`, `materialsSize`, `effectsSize`, `expansionId`, `isDeleted`, `modifiedBy`, `created_at`, `updated_at`) VALUES
                                                                                                                                                                                                                                                                                                                                                                                                                                                   (15, 1, 'Undead Catalyst', 0, 4, 1, 4, 1, 1, 6, 1800, 200, 17, 18, NULL, '', '', 'Welcome the slime titan! If someone licks his juice, he turns them into a capybara.', NULL, 4, 0, 13, 2, 3, 5, 2, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
                                                                                                                                                                                                                                                                                                                                                                                                                                                   (16, 1, 'Hammer Waifu', 0, 2, 1, 2, 1, 1, 3, 1200, 0, NULL, NULL, NULL, 'Discard a card.{i}Hand{/i}', 'Target monster loses {sb}200{/sb} {b}atk{/b}.{i}All stat changes only last until the end of the turn{/i}', '', NULL, 0, 0, 3, 4, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
                                                                                                                                                                                                                                                                                                                                                                                                                                                   (17, 1, '{i}The{/i}Guildmaster', 0, 4, 1, 2, 1, 1, 7, 2100, 0, NULL, NULL, NULL, 'Mill {sb}2{/sb}.{i}From your deck{/i}', 'Gains {sb}400{/sb} {b}atk{/b} for each level-{sb}5{/sb} and {sb}higher{/sb} {sb}normal{/sb} {b}Slime{/b} in your grave.{i}Yellow{/i}', '', NULL, 0, 0, 0, 3, 5, 5, 2, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
                                                                                                                                                                                                                                                                                                                                                                                                                                                   (18, 1, 'Pitch-Black Ooze', 0, 4, 1, 1, 1, 1, 5, 1300, 0, NULL, NULL, NULL, '', '', 'Monsters so black that everyone fears them. They eat all the light, making them even darker than yo\' asshole.', NULL, 1, 0, 14, 2, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(19, 1, 'Cute Lady Anis', 0, 3, 1, 2, 1, 1, 6, 1600, 1600, NULL, NULL, NULL, 'None.{i}Tribute 1 monster to summon a level-5 or 6{/i}', 'Deal {sb}600{/sb} damage.{i}Opponent loses 600 life{/i}', '', NULL, 3, 9, 0, 4, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(20, 1, 'Apocalypse!', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'Level-{sb}7{/sb} or {sb}8{/sb} attacks.', 'Reborn a {sb}normal{/sb} {b}Zombie{/b}.{i}Traps can only be used on the opponent\'s turn{/i}', '', NULL, 0, 0, 0, 4, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
                                                                                                                                                                                                                                                                                                                                                                                                                                                   (21, 1, 'Fernir\'s Curse', 0, 6, 1, 1, 1, 1, 5, 1700, 0, NULL, NULL, NULL, '', '', 'It has fangs so sharp that it can bite panties off highschool girls without them even noticing the rising wind.', NULL, 4, 9, 6, 4, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(22, 1, 'Pet of Misery', 0, 6, 1, 1, 1, 1, 2, 200, 1200, NULL, NULL, NULL, '', '', 'Dan got depressed after reincarnating as a pidgeon in a zombie apocalypse where cute girls are long since dead.', NULL, 0, 0, 0, 4, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(23, 1, 'Furry Chicken', 0, 6, 1, 3, 1, 1, 7, 2100, 0, 21, 22, NULL, 'None.{i}This is a Fusion{/i}', 'Opponent discards their hand.{i}All cards in their hand{/i}', '', NULL, 2, 2, 0, 4, 4, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(24, 1, 'Venom Pit', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'Summons a level-{sb}2{/sb} or {sb}lower{/sb}; pay {sb}500{/sb}.{i}Life points when opponent summons{/i}', 'Destroy it.{i}To grave{/i}', '', NULL, 3, 8, 8, 4, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(25, 1, 'Greedy Treasure', 0, 1, 2, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'You control {sb}2{/sb} level-{sb}2{/sb} {sb}normal{/sb} monsters.{i}Face-up{/i}', 'Draw {sb}2{/sb} cards.{i}Place 2 cards from your deck to hand{/i}', '', NULL, 5, 12, 15, 2, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(26, 1, 'Sugar Bomb', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'Attacks.{i}Opponent does{/i}', 'Opponent mills {sb}3{/sb}.{i}They send cards from the top of their deck to their grave{/i}', '', NULL, 6, 13, 14, 4, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(27, 1, 'Mariam, Sheep', 0, 3, 1, 1, 1, 1, 1, 100, 1100, NULL, NULL, NULL, '', '', 'She travelled half the world to find her best friend, Benny the horse. But Benny was not a little boy anymore, oh no...', NULL, 3, 6, 7, 4, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(28, 1, 'Dotted Alive', 0, 6, 1, 2, 1, 1, 2, 1100, 0, NULL, NULL, NULL, 'Mill {sb}2{/sb}.{i}From your deck{/i}', 'Counts as {sb}2{/sb} tributes for a level-{sb}7{/sb} {b}Zombie{/b} with {sb}0{/sb} {b}def{/b}.{i}During this turn{/i}', '', NULL, 2, 6, 5, 4, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(29, 1, 'Dotted Alive', 0, 6, 1, 2, 1, 1, 2, 1100, 0, NULL, NULL, NULL, 'Mill {sb}2{/sb}.{i}From your deck{/i}', 'Counts as {sb}2{/sb} tributes for a level-{sb}7{/sb} {b}Zombie{/b} with {sb}0{/sb} {b}def{/b}.{i}During this turn{/i}', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(30, 1, 'Fallen Mantista', 0, 6, 1, 2, 1, 1, 7, 1900, 0, NULL, NULL, NULL, 'Mill {sb}2{/sb}{i}From your deck{/i}', 'Reborn a {sb}normal{/sb} {b}Zombie{/b} with {sb}0{/sb} {b}def{/b}. It gains {sb}1000{/sb} {b}atk{/b}.{i}From your grave{/i}', '', NULL, 0, 0, 0, 4, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(31, 1, 'Time to Isekai!', 1, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'Level-{sb}6{/sb} or {sb}7{/sb} attacks.', 'Destroy it. Opponent reveals {sb}top{/sb} card, and {sb}may{/sb} summon it.{i}Of their deck{/i}', '', NULL, 1, 5, 1, 4, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(32, 1, 'Thousand-Fold', 0, 6, 1, 1, 1, 1, 4, 1300, 0, NULL, NULL, NULL, '', '', 'Giant sea urchins love to eat mermaids from bottom up. If you enjoy tentacles, then wait what you can do with spikes...', NULL, 4, 11, 11, 4, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(33, 1, 'Spawn of Evil', 1, 6, 1, 1, 1, 1, 5, 2300, 0, NULL, NULL, NULL, '', '', 'From the infernos rose a man with a mission, to have his revenge on the n**ger who never read. Read n**ga, read!', NULL, 8, 13, 6, 4, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(34, 1, 'Poison Scales', 0, 6, 1, 1, 1, 1, 2, 900, 300, NULL, NULL, NULL, '', '', 'These snakes hunt ogres at the swamp, their scales blown up from all the times they were used as balloons.', NULL, 0, 0, 0, 4, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(35, 1, 'Fallen in Death', 0, 6, 1, 1, 1, 1, 3, 1100, 300, NULL, NULL, NULL, '', '', 'They say that naughty girls who fall in love with pirates, get cursed to live an eternity as mermaids with them.', NULL, 5, 10, 8, 4, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(36, 1, 'Giant Blue Ogre', 0, 6, 1, 1, 1, 1, 7, 2100, 0, NULL, NULL, NULL, '', '', 'Their skin became blue after the ogres inhaled all the nitrogen in the air, beginning the zombie apocalypse.', NULL, 1, 3, 0, 3, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(37, 1, 'Grandson\'s Fate', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'Level-{sb}7{/sb} or {sb}lower{/sb} attacks.', 'Attacker loses {sb}100{/sb} {b}atk{/b} for each card with same {sb}class{/sb} in their grave.{i}Opponent\'s{/i}', '', NULL, 0, 0, 0, 3, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(38, 1, 'Evolved Hydra', 0, 6, 1, 3, 1, 1, 7, 2000, 300, 36, 34, NULL, 'Mill {sb}1{/sb}.{i}From your deck{/i}', 'Gains {sb}200{/sb} {b}atk{/b} for each {sb}normal{/sb} {b}Zombie{/b} in your grave.', '', NULL, 2, 6, 0, 4, 3, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(39, 1, 'Insect Priestess', 0, 6, 1, 3, 1, 1, 7, 2600, 0, 30, 28, NULL, 'Summoned {sb}this{/sb} turn; you have {sb}10{/sb} {b}Zombies{/b} in grave.', 'Retrieve a {b}Spell{/b}.{i}Grave{/i}', '', NULL, 6, 18, 5, 3, 4, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(40, 1, 'Spinal Urchin', 0, 6, 1, 3, 1, 1, 5, 1600, 300, 32, 35, NULL, 'Reshuffle a {b}Zombie{/b}.{i}Shuffle from grave to deck{/i}', 'Opponent mills {sb}3{/sb}.', '', NULL, 3, 6, 1, 4, 3, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(41, 1, 'wqeqwe', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(42, 1, '11222222', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(43, 1, 'Spider Eggs', 0, 4, 1, 1, 1, 1, 5, 1600, 200, NULL, NULL, NULL, '', '', 'Hello Methew, I will not be home for a while because I found one... The chokolate arachnids, they are real!', NULL, 0, 0, 0, 4, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(44, 2, 'Lolo', 0, 2, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', NULL, 1, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(45, 2, 'Apocalypse!', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'Level-{sb}7{/sb} or {sb}8{/sb} attacks.', 'Reborn a {sb}normal{/sb} {b}Zombie{/b}.{i}Traps can only be used on the opponent\'s turn{/i}', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(46, 2, 'Apocalypse!', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'Level-{sb}7{/sb} or {sb}8{/sb} attacks.', 'Reborn a {sb}normal{/sb} {b}Zombie{/b}.{i}Traps can only be used on the opponent\'s turn{/i}', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(47, 2, 'Apocalypse!', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'Level-{sb}7{/sb} or {sb}8{/sb} attacks.', 'Reborn a {sb}normal{/sb} {b}Zombie{/b}.{i}Traps can only be used on the opponent\'s turn{/i}', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(48, 2, 'Apocalypse', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(49, 2, 'gffdgd', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(50, 2, 'Ramibn', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(51, 1, 'req', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(52, 2, 'rrr', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(53, 2, 'Tuomas Jees', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(54, 2, 'Tuomas Jees', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(55, 2, 'Tuomas jee', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(56, 2, 'rerew', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(57, 2, 'gfdg', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(58, 2, 'ram', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(59, 2, 'Giraffe', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(60, 2, 'Giraffe3', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(61, 2, 'Giraffe2', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(62, 1, 'Ashers of Azure', 0, 2, 1, 1, 1, 1, 4, 1500, 0, NULL, NULL, NULL, '', '', 'The gemhive dragons lost to the black oozes. They had to join in battle with the white elves, not just to survive but...', NULL, 0, 0, 0, 3, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(63, 1, 'Stone Basilisk', 0, 2, 1, 1, 1, 1, 6, 1600, 2100, NULL, NULL, NULL, '', '', 'Monsters lurking deep underground, these giant behemoths eat all the turds you flush down.', NULL, 2, 6, 8, 4, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(64, 1, 'Sleeping Wyvern', 0, 2, 1, 2, 1, 1, 5, 0, 1600, NULL, NULL, NULL, 'Flipped when attacked.{i}Triggers if this card was face-down before it was attacked{/i}', 'Gains {sb}1000{/sb} {b}def{/b}.', '', NULL, 0, 0, 9, 2, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(65, 1, 'Pierce Through!', 0, 1, 2, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'None.{i}Your turn only{/i}', 'Target creature gains {sb}piercing{/sb}.{i}It deals damage when attacking defense{/i}', '', NULL, 0, 0, 0, 3, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(66, 1, 'Ordinary Sword', 0, 1, 2, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'None.{i}Your turn only{/i}', 'Target {b}Dragon{/b} gains {sb}300{/sb} {b}atk{/b}.{i}All stat changes only last until the end of the turn{/i}', '', NULL, 0, 0, 0, 3, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(67, 1, 'My Excalibur!', 1, 1, 2, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'None.{i}This is an ace{/i}', 'Target monster gains {sb}1000{/sb} {b}atk{/b}.{i}You can only have 1 ace of each card type in deck{/i}', '', NULL, 3, 6, 3, 4, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(68, 1, 'Heaven\'s Fall', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'Level-{sb}7{/sb} or {sb}lower{/sb} attacks; reshuffle a monster. {i}Shuffle from your grave to your deck{/i}', 'Attacker loses {sb}300{/sb} {b}atk{/b}.', '', NULL, 0, 0, 0, 4, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(69, 1, 'Evilia, the Sealed', 0, 2, 1, 2, 1, 1, 3, 1100, 0, NULL, NULL, NULL, 'None.{i}Don\'t tribute for level-4 or lower monsters{/i}', 'Target {b}Dragon{/b} gains {sb}200{/sb} {b}atk{/b}.{i}Until the end of turn{/i}', '', NULL, 0, 0, 9, 2, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(70, 1, 'Sludgefest Legs', 0, 4, 1, 3, 1, 1, 8, 2200, 2400, 18, 43, NULL, 'Mill {sb}3{/sb}.{i}From your deck{/i}', 'Restack {sb}2{/sb} {b}Slimes{/b}.{i}Place from the grave on top of deck{/i}', '', NULL, 0, 0, 0, 3, 3, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(71, 1, 'Brothers in War', 0, 2, 1, 3, 1, 1, 8, 2000, 2500, 16, 63, NULL, 'Mill {sb}2{/sb}.{i}From your deck{/i}', 'Target monster loses {sb}1000{/sb} {b}atk{/b}.{i}Until end of turn{/i}', '', NULL, 4, 5, 9, 3, 3, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(72, 1, 'Awakened Evilia', 0, 2, 1, 3, 1, 1, 5, 1900, 0, 69, 64, NULL, 'Summoned {sb}this{/sb} turn.', 'Flip target monster {sb}face-down{/sb}, then draw a card.', '', NULL, 19, 17, 14, 2, 2, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(73, 1, 'Azure Skyblade', 0, 1, 3, 7, 1, 1, 1, 0, 0, 62, 66, NULL, 'Level-{sb}8{/sb} or {sb}lower{/sb} attacks.', 'It loses {sb}1100{/sb} {b}atk{/b}.{i}Send the Spell to grave to activate{/i}', '', NULL, 4, 10, 0, 3, 3, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(74, 2, 'Giraffe4', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(75, 1, 'Qwerty', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', NULL, 0, 0, 0, 4, 5, 5, 1, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(76, 1, 'Qwerty', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', NULL, 0, 0, 0, 4, 5, 5, 8, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(77, 1, 'Qwerty', 0, 1, 1, 3, 1, 1, 3, 0, 0, NULL, NULL, NULL, '', '', '', NULL, 6, 17, 8, 4, 5, 5, 8, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(78, 1, 'Nitropus', 1, 5, 1, 2, 3, 3, 7, 2500, 0, NULL, NULL, NULL, 'Maximum summoned {sb}this{/sb} turn.{i}[L], [M], [R] as one{/i}', 'Destroy target {sb}face-up{/sb} monster.{i}Field to the grave{/i}', '', NULL, 29, 104, 27, 4, 5, 5, 4, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(79, 1, 'Big-Arms Jelly', 0, 4, 1, 1, 1, 1, 4, 1400, 0, NULL, NULL, NULL, '', '', 'He is the strongest slime in the world of oozes. He even killed the demon queen. He is no simp for love!', NULL, 5, 9, 13, 4, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(80, 1, 'Dasher Waterloo', 0, 4, 1, 2, 1, 1, 1, 300, 200, NULL, NULL, NULL, 'You control only this.', 'Retrieve a level-{sb}4{/sb} {sb}normal{/sb} {b}Slime{/b}.{i}Return from your grave to your hand{/i}', '', NULL, 5, 10, 2, 2, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(81, 1, 'Oozepression', 0, 4, 1, 1, 1, 1, 4, 1000, 1100, NULL, NULL, NULL, '', '', 'He had no ice cream, so our cute little slime decided to rob Alice the Cat\'s store with a loaded shotgun. Ka-chunk!', NULL, 7, 12, 22, 4, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(82, 1, 'Pee Cream', 0, 4, 1, 2, 1, 1, 3, 1000, 300, NULL, NULL, NULL, 'Discard a {b}Slime{/b}.{i}Send a card with \"Slime\" on top-right from your hand to grave{/i}', 'Draw a card.{i}Deck{/i}', '', NULL, 5, 11, 14, 4, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(83, 1, 'Poopy!', 0, 4, 1, 2, 1, 1, 2, 600, 200, NULL, NULL, NULL, 'Summoned {sb}this{/sb} turn.', 'Reborn a level-{sb}5{/sb} {sb}normal{/sb} {b}Slime{/b} with {sb}200{/sb} {b}def{/b} in {sb}defense{/sb}-position.{i}From grave to field{/i}', '', NULL, 0, 0, 0, 4, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(84, 1, 'Big-Ass Slime', 0, 4, 1, 3, 1, 1, 5, 2000, 0, 81, 79, NULL, 'Sacrifice {sb}2{/sb} {b}Slimes{/b}.{i}Field{/i}', 'Double this card\'s {b}atk{/b}.{i}Gains atk until end of turn{/i}', '', NULL, 2, 5, 2, 4, 4, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(85, 1, 'Femme de la Vie', 0, 4, 1, 3, 1, 1, 7, 2300, 200, 18, 18, NULL, 'Discard a card.{i}Hand{/i}', 'Gain control of target level-{sb}6{/sb} or {sb}lower{/sb} monster.', '', NULL, 9, 20, 2, 2, 2, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(86, 1, 'Nougat Sorbet', 0, 4, 1, 3, 1, 1, 4, 1500, 1500, 83, 82, NULL, 'Mill {sb}10{/sb}.{i}Send materials from your field to summon{/i}', 'Draw {sb}2{/sb}. (From deck.)', '', NULL, 3, 9, 8, 4, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(87, 1, 'Terror Menthol', 0, 4, 1, 3, 1, 1, 4, 1700, 0, 81, 80, NULL, 'Discard a card.{i}Hand{/i}', 'Destroy target level-{sb}3{/sb} or {sb}lower{/sb} monster.{i}Field to grave{/i}', '', NULL, 4, 7, 18, 4, 3, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(88, 1, 'True Believer', 0, 4, 1, 3, 1, 1, 5, 0, 2100, 79, 81, NULL, 'Continuous.{i}Is a Fusion{/i}', 'Gains {sb}100{/sb} {b}atk{/b} for each {b}Slime{/b} in your grave.{i}Attack{/i}', '', NULL, 4, 6, 11, 4, 4, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(89, 1, 'Stand, Brother!', 0, 1, 2, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'None.{i}Your turn only{/i}', 'Change {sb}1{/sb} of your monsters to {sb}attack{/sb}-position.{i}It can be face-down before this{/i}', '', NULL, 12, 34, 1, 4, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(90, 1, 'Benny the Horse', 0, 3, 1, 1, 1, 1, 3, 1300, 0, NULL, NULL, NULL, '', '', 'Best defined by his insatiable lust for his childhood friend. Oh, if one day he could drag Mariam to the stables...', NULL, 8, 19, 2, 2, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(91, 1, 'Bunny Buttler', 0, 3, 1, 2, 1, 1, 2, 0, 1000, NULL, NULL, NULL, 'Flipped when attacked.{i}Face-down before attacked{/i}', 'Gains {sb}100{/sb} {b}def{/b} for each {sb}normal{/sb} {b}Kawaii{/b} in your grave.', '', NULL, 10, 33, 9, 4, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(92, 1, 'Cotton, Assassin', 0, 3, 1, 2, 1, 1, 3, 0, 1400, NULL, NULL, NULL, 'Pay {sb}1000{/sb}.{i}Life points{/i}', 'Destroy target level-{sb}5{/sb} monster. This turn, you {b}cannot{/b} attack {sb}directly{/sb}.{i}Level in star{/i}', '', NULL, 0, 0, 3, 2, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(93, 1, 'Lapin Lazarus', 0, 3, 1, 3, 1, 1, 5, 2000, 0, 91, 92, NULL, 'Mill {sb}3{/sb}.{i}This is a Fusion{/i}', 'Switch with opponent\'s level-{sb}7{/sb} monster.{i}They get this{/i}', '', NULL, 10, 17, 0, 4, 3, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(94, 1, 'Liberator Hare', 0, 3, 1, 3, 1, 1, 6, 1600, 2300, 92, 19, NULL, 'None.{i}This is a Fusion{/i}', 'Switch the {b}atk{/b} and {b}def{/b} of all monsters.{i}On the field{/i}', '', NULL, 0, 0, 9, 4, 3, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(95, 1, 'Pretty-Boy Robin', 0, 3, 1, 3, 1, 1, 6, 1800, 0, 19, 91, NULL, 'Reshuffle {sb}2{/sb} {b}Kawaii{/b}.', 'Gains {sb}100{/sb} {b}atk{/b} for the combined {sb}level{/sb} of the cards.', '', NULL, 4, 13, 6, 2, 3, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(96, 1, 'Sheep Buster', 0, 3, 1, 3, 1, 1, 7, 2300, 0, 27, 90, NULL, '', '', 'Their daughter united the two races, forming the most powerful military in Japan.', NULL, 5, 10, 5, 4, 3, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(97, 1, 'Delicious Runa', 0, 5, 1, 1, 1, 1, 2, 600, 700, NULL, NULL, NULL, '', '', 'She cooked for the whole tribe until they joined the Great War. She was promoted as the \"Head of Rations\".', NULL, 0, 0, 0, 4, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(98, 1, 'Dolpher Horus', 0, 5, 1, 1, 1, 1, 1, 0, 1400, NULL, NULL, NULL, '', '', 'He sees the past and the future. He knows when your little sister is taking a shower, and he can see everything.', NULL, 7, 18, 12, 4, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(99, 1, 'Soul Exhaustion', 0, 1, 2, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'No monsters. {i}You don\'t control any monsters{/i}', 'Destroy {sb}1{/sb} {b}Spell{/b}/{b}Trap{/b}.{i}You may target a set card{/i}', '', NULL, 9, 16, 3, 3, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(100, 1, 'Thoth of the Sea', 0, 5, 1, 2, 1, 1, 7, 2100, 1400, NULL, NULL, NULL, 'Mill {sb}1{/sb}.{i}Send the top card of your deck to your grave{/i}', 'Gains {sb}400{/sb} {b}atk{/b} for each other {b}Sparks{/b} you control.', '', NULL, 3, 10, 9, 2, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(101, 1, 'Fräulein Thor', 0, 5, 1, 2, 1, 1, 4, 1400, 0, NULL, NULL, NULL, 'Mill {sb}1{/sb}.{i}From your deck{/i}', 'If {sb}normal{/sb} {b}Sparks{/b}, reborn it in {sb}defense{/sb}-position.{i}The card you milled for the cost{/i}', '', NULL, 8, 13, 2, 4, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(102, 1, 'Einarsdottir Eir', 0, 5, 1, 1, 1, 1, 3, 1200, 0, NULL, NULL, NULL, '', '', 'Einar ruled the frozen seas for over fifty years. In his death, he left the kingdom to be ruled by his four daughters.', NULL, 3, 7, 0, 4, 5, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(103, 1, 'Champion Runa', 0, 5, 1, 3, 1, 1, 7, 2200, 1100, 101, 102, NULL, '', '', 'After she had mastered the art of cooking, Runa decided to enslave the whole world.', NULL, 0, 0, 0, 3, 4, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(104, 1, 'Great Warchef', 0, 5, 1, 3, 1, 1, 5, 1900, 0, 97, 102, NULL, 'None.{i}Send materials from your field to summon{/i}', 'Gain {sb}500{/sb}.{i}Life points{/i}', '', NULL, 1, 0, 0, 4, 3, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(105, 1, 'Skyhold-Ruler Eir', 0, 5, 1, 3, 1, 1, 7, 2100, 0, 101, 102, NULL, 'Mill {sb}1{/sb}.{i}This is a Fusion{/i}', 'Gains {sb}chain-attack{/sb}.{i}If successful, can attack 2nd{/i}', '', NULL, 0, 0, 1, 2, 4, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(106, 1, 'Great Egyptian', 0, 5, 1, 3, 1, 1, 7, 2600, 1700, 98, 100, NULL, 'Summoned {sb}this{/sb} turn.', 'Destroy all level-{sb}6{/sb} and {sb}lower{/sb} monsters.{i}From field{/i}', '', NULL, 3, 6, 4, 4, 3, 5, 1, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(107, 1, 'Why Choose me?', 0, 4, 1, 2, 1, 1, 3, 1000, 300, NULL, NULL, NULL, ' Flipped when attacked.', 'Switch the target.{i}Of the attack to one of your other monsters immediately{/i}', '', NULL, 3, 10, 6, 2, 5, 5, 4, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(108, 1, 'Nitropus', 0, 5, 1, 2, 3, 2, 4, 1100, 1000, NULL, NULL, NULL, 'Mill {sb}3{/sb}.{i}From your deck{/i}', 'Gains {sb}piercing{/sb}.{i}Deals damage when attacking defense-position monsters{/i}', '', NULL, 29, 10, 27, 4, 5, 5, 4, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(109, 1, 'Nitropus', 0, 5, 1, 2, 3, 4, 4, 1000, 1100, NULL, NULL, NULL, 'Continuous.{i}On field{/i}', 'Gains {sb}1000{/sb} {b}atk{/b} while you control {b}only{/b} {sb}maximum{/sb} monsters.{i}[L], [M], [R] as one{/i}', '', NULL, 29, 203, 27, 4, 5, 5, 4, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(110, 1, 'Capybara-Mikasa', 0, 3, 1, 1, 1, 1, 4, 1400, 200, NULL, NULL, NULL, '', '', 'She was ordered to kill the shogun. Mikasa did it in two seconds, then spent rest of the mission stalking her onii-chan.', NULL, 1, 2, 4, 2, 5, 5, 2, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(111, 1, 'Eat These Nuts!', 0, 1, 2, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'None.{i}Your turn only{/i}', 'Gain {sb}500{/sb}.{i}Life points, you start the game with 8000. You lose game if they reach 0{/i}', '', NULL, 2, 4, 1, 3, 5, 5, 2, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(112, 1, 'Emergency Pod', 0, 5, 1, 1, 1, 1, 1, 200, 200, NULL, NULL, NULL, '', '', 'The greatest juggernaut-sized flagship seen in the Empire\'s history, Legion, was greatly damaged by the Furry-aliens.', NULL, 0, 0, 11, 3, 5, 5, 2, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(113, 1, 'Eren, Capybara', 0, 3, 1, 1, 1, 1, 3, 1000, 0, NULL, NULL, NULL, '', '', 'After a long journey, baby finally found the ocean, his everdream. But dark waters brought back memories...', NULL, 1, 1, 4, 4, 5, 5, 2, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(114, 1, 'Gleam Viscount', 0, 4, 1, 2, 1, 1, 1, 300, 200, NULL, NULL, NULL, 'You have {sb}10{/sb} or {sb}more{/sb} with {sb}200{/sb} {b}def{/b} in your grave.{i}Cards{/i}', 'Reshuffle a {b}Slime{/b} with {sb}200{/sb} {b}def{/b}.{i}From grave to deck{/i}', '', NULL, 2, 5, 0, 3, 5, 5, 2, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(115, 1, 'Icky Hatchling', 0, 2, 1, 2, 1, 1, 1, 100, 0, NULL, NULL, NULL, 'You control {sb}2{/sb} {b}Dragons{/b} with {sb}different{/sb} levels.{i}The star{/i}', 'Decrease target monster\'s level by {sb}1{/sb}.{i}This turn{/i}', '', NULL, 0, 0, 6, 4, 5, 5, 2, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(116, 1, 'Luminausea', 0, 2, 1, 2, 1, 1, 3, 1000, 0, NULL, NULL, NULL, 'You control {sb}2{/sb} {b}Dragons{/b} with {sb}different{/sb} levels.{i}The star{/i}', 'Increase target monster\'s level by {sb}1{/sb}.{i}This turn{/i}', '', NULL, 5, 13, 9, 4, 5, 5, 2, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(117, 1, 'Magibari Exhale', 0, 6, 1, 2, 1, 1, 6, 0, 2000, NULL, NULL, NULL, 'Change any of your monsters to {sb}defense{/sb}-position.', 'They gain {sb}sleeptalk{/sb}.{i}Can attack from the defense{/i}', '', NULL, 16, 51, 40, 3, 5, 5, 2, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(118, 1, 'Seasoned Sprite', 0, 2, 1, 2, 1, 1, 6, 2000, 0, NULL, NULL, NULL, 'You control {sb}2{/sb} {b}Dragons{/b} with {sb}different{/sb} levels.{i}The star{/i}', 'Increase target monster\'s level by {sb}2{/sb}.{i}This turn{/i}', '', NULL, 3, 6, 8, 3, 5, 5, 2, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(119, 1, 'Starship Legion', 0, 5, 1, 2, 1, 1, 7, 2100, 0, NULL, NULL, NULL, 'Fights {sb}normal{/sb} monster.{i}Attacking or being attacked{/i}', 'Destroy it.{i}No damage is dealt from the battle{/i}', '', NULL, 0, 0, 4, 3, 5, 5, 2, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(120, 1, 'We can Sing!', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'Level-{sb}7{/sb} or {sb}higher{/sb} attacks.', 'Your level-{sb}6{/sb} and {sb}lower{/sb} monsters gain {sb}1000{/sb} {b}def{/b}. {i}Stat changes last until turn ends{/i}', '', NULL, 0, 0, 0, 4, 5, 5, 2, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(121, 1, 'Adamantium', 1, 2, 1, 3, 1, 1, 6, 1700, 2300, 115, 63, NULL, 'Change target monster to {sb}defense{/sb}-position.{i}Sideways{/i}', ' If it has {sb}0{/sb} {b}def{/b}, this gains {sb}piercing{/sb}.{i}Damage{/i}', '', NULL, 0, 0, 10, 4, 4, 4, 2, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(122, 1, 'Cowpoke Benny', 0, 3, 1, 4, 1, 1, 5, 1700, 0, 90, 90, NULL, '', '', 'After learning to play the world\'s smallest violin, Benny forgot his childhood crush.', NULL, 4, 7, 0, 3, 2, 5, 2, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(123, 1, 'Jelly Requiem', 0, 4, 1, 4, 1, 1, 2, 1000, 200, 83, 114, NULL, 'Mill {sb}2{/sb}.{i}From your deck{/i}', 'Destroy all monsters with less {b}atk{/b} than this.{i}Has{/i}', '', NULL, 0, 0, 12, 4, 5, 5, 2, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(124, 1, 'Turn Black!', 1, 1, 2, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'None.{i}Your turn only{/i}', 'Target monster gains {sb}100{/sb} {b}atk{/b} times its level, and {sb}piercing{/sb}.{i}Until end of turn{/i}', '', NULL, 0, 0, 0, 4, 5, 5, 2, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(125, 1, 'Frolic Sundae', 0, 4, 1, 3, 1, 1, 5, 1200, 0, 126, 82, NULL, 'You have {sb}more{/sb} cards in grave than opponent. {i}In theirs{/i}', 'Gains {b}atk{/b} equal to the difference times {sb}200{/sb}.', '', NULL, 1, 0, 0, 4, 5, 4, 4, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(126, 1, 'Uneven Terror', 0, 4, 1, 2, 1, 1, 1, 200, 300, NULL, NULL, NULL, 'You have {sb}3{/sb} or {sb}less{/sb} with {sb}300{/sb} {b}def{/b} in your grave.{i}Cards{/i}', 'Reborn a level-{sb}3{/sb} {b}Slime{/b} with {sb}300{/sb} {b}def{/b}.{i}Your grave{/i}', '', NULL, 2, 5, 0, 4, 5, 5, 3, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(127, 1, 'Snack-Rumbling', 0, 3, 1, 4, 1, 1, 4, 1400, 200, 110, 113, NULL, 'Ruler-effect.{i}Next turn{/i}', 'Normal monsters in all graves are {b}Kawaii{/b}.{i}Instead of{/i}', '', NULL, 10, 17, 9, 2, 3, 5, 2, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(128, 1, 'Triangulate', 0, 4, 1, 1, 4, 1, 1, 600, 200, NULL, NULL, NULL, 'No monsters.', '', 'Who trolled me? Why am I a pyramid? I am not allowed to enter Italy like this, wryyyy!', NULL, 4, 8, 14, 4, 5, 5, 5, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(129, 1, 'Death Korona', 0, 4, 1, 5, 1, 1, 7, 2400, 200, 18, 18, 18, 'Discard a {b}Slime{/b}.{i}Hand{/i}', 'Destroy all {sb}set{/sb} monsters. Take {sb}1000{/sb} for each.', '', NULL, 3, 4, 12, 4, 4, 4, 5, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(130, 1, 'Love-Kill Rakuel', 0, 2, 1, 1, 1, 1, 2, 600, 900, NULL, NULL, NULL, '', '', 'Raku is the most powerful mage in school as other students have no protection against incineration.', NULL, 3, 10, 8, 3, 5, 5, 3, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(131, 1, 'Why wanna Die?', 0, 1, 3, 7, 1, 1, 1, 0, 0, 130, 68, NULL, 'Level-{sb}7{/sb} or {sb}8{/sb} attacks.', '{bi}Love-Kill Rakuel{/bi} gains {sb}2000{/sb} {b}atk{/b}, switch target to it.', '', NULL, 0, 0, 0, 2, 3, 5, 5, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(132, 1, 'Cracked Scythe', 0, 6, 1, 3, 1, 1, 7, 2300, 0, 111, 30, NULL, 'You have {sb}3{/sb} or {sb}more{/sb} {sb}life-gain{/sb} {b}Spells{/b} in your grave.', 'Destroy {sb}1{/sb} {b}Spell{/b}/{b}Trap{/b}.', '', NULL, 0, 0, 0, 3, 3, 5, 2, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(133, 1, 'Eir, Automata', 0, 5, 1, 4, 1, 1, 4, 1400, 200, 102, 112, NULL, 'Discard a {b}Sparks{/b}.', 'Gains {sb}chain-attack{/sb}.{i}If successful, can attack 2nd{/i}', '', NULL, 0, 0, 0, 4, 3, 5, 2, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(134, 1, 'Legion-Repaired', 0, 5, 1, 3, 1, 1, 7, 2600, 200, 112, 119, NULL, '', '', 'The Empire never surrenders! After suffering an utter loss, the broken Legion was fixed, and Furry race annihilated to the very last one.', NULL, 0, 0, 12, 2, 3, 3, 2, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(135, 1, 'Levi, Bunnybara', 1, 3, 1, 3, 1, 1, 4, 1500, 0, 113, 91, NULL, 'Change target monster to {sb}attack{/sb}-position.{i}Move it upright{/i}', 'If it has {sb}0{/sb} {b}atk{/b}, this gains {sb}triple-attack{/sb}.{i}Chain{/i}', '', NULL, 0, 0, 7, 3, 4, 4, 2, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(136, 1, 'Moribund Dry', 0, 2, 1, 3, 1, 1, 7, 2200, 0, 116, 118, NULL, 'Summoned {sb}this{/sb} turn.', 'Destroy target level-{sb}6{/sb} monster.{i}Field to the grave{/i}', '', NULL, 0, 0, 0, 4, 4, 5, 2, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(137, 1, 'Runa, {i}Maid-Form{/i}', 0, 5, 1, 4, 1, 1, 5, 1500, 700, NULL, NULL, NULL, 'You have {sb}5{/sb} or {sb}more{/sb} {b}Sparks{/b} in your grave; reshuffle {sb}1{/sb} of them.', 'Destroy target level-{sb}5{/b} monster.{i}Anyone\'s{/i}', '', NULL, 3, 9, 3, 2, 5, 4, 2, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(138, 1, 'Seal Foil', 0, 1, 3, 7, 1, 1, 1, 0, 0, 72, 66, NULL, 'Level-{sb}7{/sb} or {sb}lower{/sb} attacks.', 'Send it {sb}bottom{/sb}.{i}Of its owner\'s deck or extra deck{/i}', '', NULL, 0, 0, 0, 4, 2, 5, 2, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(139, 1, 'Stuffed Full', 0, 1, 3, 7, 1, 1, 1, 0, 0, 113, 111, NULL, 'Level-{sb}7{/sb} or {sb}lower{/sb} attacks.', 'Gain {sb}2000{/sb}.{i}Life points, you start game with 8000{/i}', '', NULL, 0, 0, 0, 4, 3, 5, 2, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(140, 1, 'Tatzelwurm', 0, 2, 1, 3, 1, 1, 7, 2300, 0, 118, 64, NULL, 'Target a monster with level {sb}equal{/sb} to count of cards on field.', 'It loses {sb}100{/sb} {b}atk{/b} times its level.{i}Level in star{/i}', '', NULL, 0, 0, 4, 4, 2, 4, 2, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(141, 1, 'Verdant Fae', 0, 2, 1, 3, 1, 1, 6, 2100, 0, 115, 118, NULL, 'Summoned {sb}this{/sb} turn.', 'Change target level-{sb}7{/sb} monster to {sb}defense{/sb}-position.', '', NULL, 0, 0, 1, 4, 3, 5, 2, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(142, 1, 'Youthful Sylph', 0, 2, 1, 3, 1, 1, 4, 1500, 0, 115, 116, NULL, 'Target a level-{sb}8{/sb} monster.{i}On anyone\'s side of the field{/i}', 'It loses {sb}1000{/sb} {b}atk{/b}.{i}Turn{/i}', '', NULL, 3, 4, 7, 4, 4, 5, 2, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(143, 1, 'Zero-Burden', 0, 4, 1, 3, 1, 1, 8, 2300, 200, 114, 43, NULL, '', '', 'After Viscount tasted the gentle chokolate of the arachnid, he decided to marry.', NULL, 2, 2, 7, 4, 4, 5, 2, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(144, 1, 'Cybertech Lion', 0, 5, 1, 1, 1, 1, 5, 1700, 200, NULL, NULL, NULL, '', '', 'Dr. Blackfinger came up with many genious monsters in order to defeat god. The first one stole the divine hair...', NULL, 2, 6, 3, 4, 5, 5, 3, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(145, 1, 'Paw-Paw Lily', 0, 3, 1, 1, 1, 1, 2, 400, 400, NULL, NULL, NULL, '', '', 'Born a boy, but Liam always knew he was really a cat girl. He started to lick his friends, drinking their milk like a cat...', NULL, 1, 3, 9, 4, 5, 5, 3, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(146, 1, 'Guild-Secretary', 0, 4, 1, 2, 1, 1, 3, 900, 300, NULL, NULL, NULL, 'Discard a level-{sb}5{/sb} or {sb}higher{/sb} {sb}normal{/sb} {b}Slime{/b}.{i}Hand{/i}', 'Target monster loses {sb}300{/sb} {b}atk{/b}.{i}Until the end of turn{/i}', '', NULL, 3, 7, 8, 3, 5, 5, 3, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(147, 1, 'Mega Snakestar', 0, 2, 1, 2, 1, 1, 7, 1500, 0, NULL, NULL, NULL, 'Summoned {sb}this{/sb} turn; reborn {sb}2{/sb} level-{sb}3{/sb} {b}Dragons{/b} in {sb}defense{/sb}-position.{i}No less{/i}', 'Double this card\'s {b}atk{/b}.', '', NULL, 3, 5, 2, 3, 5, 5, 3, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(148, 1, 'Pot of Bricks', 0, 1, 2, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'Reshuffle {sb}5{/sb} {sb}normal{/sb} monsters with different levels.{i}Yellow vanilla monster cards{/i}', 'Draw {sb}2{/sb}.{i}From deck{/i}', '', NULL, 1, 3, 10, 4, 5, 5, 3, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(149, 1, 'Rellosaurus Rem', 0, 3, 1, 2, 1, 1, 3, 0, 1300, NULL, NULL, NULL, 'Summon a {sb}fusion{/sb} using cards in hand as material.', 'Destroy {sb}1{/sb} set {b}Spell{/b}/{b}Trap{/b}. If {b}Trap{/b}, destroy this.{i}Pink card{/i}', '', NULL, 0, 0, 11, 2, 5, 5, 3, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(150, 1, 'Scale Gatling', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'Attacks a {b}Dragon{/b}; discard your hand.{i}All cards in hand{/i}', 'Attacker loses {sb}400{/sb} {b}atk{/b} for each card discarded.', '', NULL, 1, 0, 4, 4, 5, 5, 3, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(151, 1, '{i}Sexy{/i} Mouse Trap', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'Summons a monster.', 'It becomes level-{sb}1{/sb} and loses {sb}500{/sb} {b}atk{/b}/{b}def{/b}.{i}Attack and defense, until the end of turn{/i}', '', NULL, 14, 36, 16, 2, 5, 5, 3, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(152, 1, 'Sweet lil Ooze', 0, 1, 2, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'Equip to with {sb}200{/sb} {b}def{/b}.{i}Equip to anyone\'s monster{/i}', 'It loses {sb}1000{/sb} {b}atk{/b} and can attack {sb}directly{/sb}. {i}Attack{/i}', '', NULL, 2, 7, 0, 4, 5, 5, 3, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(153, 1, 'Horse-Raven', 0, 6, 1, 2, 3, 3, 4, 1400, 0, NULL, NULL, NULL, 'Continuous.{i}On field{/i}', 'While in {sb}maximum{/sb} mode, level is increased by {sb}5{/sb} and gains {sb}1000{/sb} {b}atk{/b}.{i}[L], [R]{/i}', '', NULL, 40, 129, 20, 2, 5, 5, 3, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(154, 1, 'Horse-Raven', 0, 6, 1, 2, 3, 2, 3, 0, 1300, NULL, NULL, NULL, 'Change any of your monsters to {sb}defense{/sb}-position.', 'They gain {sb}sleeptalk{/sb}.{i}Can attack from defense{/i}', '', NULL, 40, 19, 52, 3, 5, 5, 3, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(155, 1, 'Horse-Raven', 0, 6, 1, 2, 3, 4, 3, 1300, 0, NULL, NULL, NULL, 'Discard a card.{i}Hand{/i}', 'Gains {sb}piercing{/sb}.{i}Deals damage when attacking defense-position monsters{/i}', '', NULL, 40, 230, 31, 3, 5, 5, 3, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(156, 1, 'Rice', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', NULL, 4, 12, 0, 4, 5, 5, 8, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(157, 1, 'Picnic', 0, 1, 1, 2, 3, 2, 1, 0, 0, NULL, NULL, NULL, '', '', '', NULL, 0, 37, 4, 4, 5, 5, 8, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(158, 1, 'Flotton, Wrath', 0, 3, 1, 5, 1, 1, 6, 2200, 0, 92, 110, 27, 'Continuous. {i}Is a Royal{/i}', 'Unaffected by effects.', '', NULL, 5, 6, 3, 4, 5, 5, 7, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(159, 1, 'Mind Moth', 0, 6, 1, 3, 1, 1, 7, 2400, 0, 28, 33, NULL, 'None. {i}This is a Fusion{/i}', 'Shoot for each card in opponent\'s hand. {i}Damage{/i}', '', NULL, 2, 2, 8, 4, 4, 5, 7, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(160, 1, 'Freedom...', 0, 6, 1, 2, 1, 1, 2, 0, 600, NULL, NULL, NULL, 'Flipped when attacked. {i}Face-down before attacked{/i}', 'Gains {sb}100{/sb} {b}def{/b} for each level-{sb}1{/sb} in your grave. {i}Turn{/i}', '', NULL, 5, 16, 25, 4, 5, 5, 7, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(161, 1, 'Happiness...', 0, 6, 1, 2, 1, 1, 1, 0, 400, NULL, NULL, NULL, 'Flipped when attacked.', 'If the attacker has {sb}piercing{/sb}, destroy it. {i}Attack is negated, no damage dealt{/i}', '', NULL, 7, 23, 11, 4, 5, 5, 7, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(162, 1, 'Who is Smiling?', 0, 6, 1, 4, 1, 1, 2, 0, 1000, 160, 161, NULL, 'Sacrifice this; turn ends.', 'Resettle {sb}3{/sb} level-{sb}1{/sb} or {sb}2{/sb} {b}Zombies{/b}, then shuffle them.', '', NULL, 0, 0, 0, 3, 5, 5, 7, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(163, 2, 'Nitropus Knight', 0, 6, 1, 3, 1, 1, 7, 2200, 0, 78, 153, NULL, 'Change to {sb}defense{/sb}; mill {sb}2{/sb}.', 'Maximum summon from grave.{i}Full maximum{/i}', '', NULL, 8, 54, 3, 3, 3, 5, 9, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(164, 2, 'AAA', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', 'jji', '', NULL, 0, 0, 0, 4, 5, 5, 8, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(165, 2, 'BBB', 0, 1, 1, 3, 1, 1, 1, 0, 0, NULL, NULL, NULL, '', '', '', NULL, 0, 0, 0, 4, 5, 5, 8, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(166, 2, 'CCC', 0, 1, 1, 3, 1, 1, 4, 200, 200, NULL, NULL, NULL, '', '', '', NULL, 0, 0, 0, 4, 5, 5, 8, 1, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(167, 1, 'Berserker Pistol', 1, 1, 2, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'Opponent controls {sb}3{/sb} set monsters. {i}Face-down{/i}', 'Shoot. If monster, {sb}repeat{/sb} effect. {i}Until is not{/i}', '', NULL, 0, 0, 3, 3, 5, 5, 3, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(168, 1, 'Black Magic', 1, 1, 3, 7, 1, 1, 1, 0, 0, 18, 152, NULL, 'Level-{sb}4{/sb} or {sb}higher{/sb} attacks.', 'It loses {sb}1000{/sb} {b}def{/b}. Then if it has {sb}0{/sb} {b}def{/b}, destroy it. {i}Grave{/i}', '', NULL, 2, 1, 8, 4, 3, 5, 3, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(169, 1, 'Dictator Ooze', 0, 4, 1, 3, 1, 1, 7, 2200, 300, 146, 17, NULL, 'Discard a {b}Slime{/b}. {i}Hand{/i}', 'Reborn it on any field. {i}Even on opponent\'s field{/i}', '', NULL, 3, 4, 0, 4, 4, 5, 3, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(170, 1, 'Eir\'s Chimera', 0, 5, 1, 3, 1, 1, 7, 2300, 200, 102, 144, NULL, 'Mill {sb}2{/sb}. {i}From your deck{/i}', 'Gains {sb}chain-attack{/sb}. {i}If successful, can attack 2nd{/i}', '', NULL, 2, 0, 7, 4, 3, 5, 3, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(171, 1, 'End of Journey', 1, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'With {sb}0{/sb} {b}def{/b} attacks. {i}Opponent\'s monster does{/i}', 'Change attacker to {sb}defense{/sb}-position. {i}Sideways{/i}', '', NULL, 0, 0, 0, 4, 5, 5, 3, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(172, 1, 'Fire-Breath Milf', 0, 2, 1, 3, 1, 1, 6, 1700, 900, 130, 69, NULL, 'Mill {sb}2{/sb}. {i}From your deck{/i}', 'Resettle a level-{sb}5{/sb} {b}Dragon{/b}. {i}Set from the grave{/i}', '', NULL, 0, 0, 0, 3, 2, 5, 3, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(173, 1, 'Gunner Consort', 0, 2, 1, 4, 1, 1, 5, 1500, 0, 16, 150, NULL, 'Discard up to {sb}2{/sb} {b}Dragons{/b}.', 'Target monster loses {sb}400{/sb} {b}atk{/b} for each card you have discarded this turn.', '', NULL, 5, 14, 3, 3, 4, 4, 3, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(174, 1, 'Muck-Prone Toro', 1, 4, 1, 2, 1, 1, 6, 2000, 0, NULL, NULL, NULL, 'Shoot twice. {i}Opponent mills 2. Damage levels x 100.{/i}', 'If {sb}10{/sb} or {sb}more{/sb}, flip target monster {sb}face-down{/sb}.{i}Level is{/i}', '', NULL, 3, 10, 6, 2, 5, 5, 3, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(175, 1, 'My Princess!', 0, 1, 3, 7, 1, 1, 1, 0, 0, 145, 89, NULL, 'Level-{sb}3{/sb} or {sb}higher{/sb} attacks.', 'Change all level-{sb}2{/sb} monsters to {sb}defense{/sb}-position. They gain {sb}2000{/sb} {b}def{/b}. {i}For turn{/i}', '', NULL, 0, 0, 0, 4, 3, 4, 3, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(176, 1, 'Rakuel, {i}the 69th{/i}', 0, 2, 1, 4, 1, 1, 6, 1600, 900, 130, 67, NULL, 'Discard a {b}Dragon{/b}. {i}Hand{/i}', 'Destroy {sb}1{/sb} set {b}Spell{/b}/{b}Trap{/b}. If {b}Trap{/b}, gains {sb}900{/sb} {b}atk{/b}. {i}Turn{/i}', '', NULL, 0, 0, 0, 3, 3, 5, 3, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(177, 1, 'Spiralverse', 0, 1, 3, 7, 1, 1, 1, 0, 0, 101, 99, NULL, 'Level-{sb}6{/sb} or {sb}7{/sb} attacks.', 'Switch its {b}atk{/b} and {b}def{/b}. {i}Attack and defense, this turn{/i}', '', NULL, 0, 0, 11, 4, 3, 5, 3, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(178, 1, 'Star-Blossom', 0, 4, 1, 3, 1, 1, 2, 500, 500, 114, 126, NULL, 'Mill {sb}1{/sb}. {i}Top of your deck{/i}', 'Gains {sb}200{/sb} {b}atk{/b} for each level-{sb}1{/sb} in your grave. {i}Card{/i}', '', NULL, 0, 0, 0, 4, 3, 5, 3, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(179, 1, 'Android Magia', 0, 2, 1, 1, 1, 1, 3, 1200, 500, NULL, NULL, NULL, '', '', 'Terracore stole the founder AI and made it his personal maid. Fitting fate for the smartest being in existence...', NULL, 5, 8, 7, 4, 5, 5, 4, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(180, 1, 'Bamboo Katana', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'Level-{sb}7{/sb} or {sb}lower{/sb} attacks; reshuffle a monster. {i}Shuffle from your grave to your deck{/i}', 'Attacker loses {sb}300{/sb} {b}atk{/b}.', '', NULL, 0, 0, 0, 3, 5, 5, 4, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(181, 1, 'Blade-Maid', 0, 3, 1, 1, 1, 1, 5, 1700, 200, NULL, NULL, NULL, '', '', 'Did you know that maids are equipped with deadly-sharp scissors under their flesh – well, you are already dead...', NULL, 0, 0, 0, 4, 5, 5, 4, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(182, 1, 'Booster Squid', 0, 5, 1, 1, 4, 1, 2, 400, 600, NULL, NULL, NULL, 'You have a {bi}Nitropus{/bi} piece in your grave.', '', 'Nitropus used the gold from Black-Luffy to hire Squidward.', NULL, 3, 3, 7, 4, 5, 5, 4, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(183, 1, 'Coronation Day', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'Level-{sb}7{/sb} or {sb}8{/sb} attacks. {i}Opponent\'s monster does{/i}', 'It steals {sb}2000{/sb} {b}atk{/b} from each other monster. {i}Gains{/i}', '', NULL, 5, 5, 7, 3, 5, 5, 4, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(184, 1, 'Elvish Twerking', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'Level-{sb}7{/sb} or {sb}lower{/sb} attacks. {i}Opponent\'s monster does{/i}', 'Attacker loses {sb}300{/sb} {b}atk{/b} and {sb}piercing{/sb}. {i}End of the turn{/i}', '', NULL, 4, 8, 4, 3, 5, 5, 4, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(185, 1, 'Harley\'s Sickle', 0, 3, 1, 2, 1, 1, 7, 2100, 0, NULL, NULL, NULL, 'Continuous. {i}On field{/i}', 'If a monster gains {b}atk{/b}, {sb}except{/sb} by its own effect, it loses that much {b}atk{/b} instead.', '', NULL, 2, 0, 5, 4, 5, 5, 4, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(186, 1, 'Nipper Fiend', 0, 6, 1, 2, 1, 1, 3, 0, 1400, NULL, NULL, NULL, 'Mill {sb}1{/sb}. {i}Top of your deck{/i}', 'The next monster you summon gains {sb}400{/sb} {b}def{/b}. {i}Defense, until end of turn{/i}', '', NULL, 0, 0, 0, 4, 5, 5, 4, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(187, 1, 'Pear-Flavour', 0, 4, 1, 1, 1, 1, 6, 2000, 1700, NULL, NULL, NULL, '', '', 'Children chase slimemons when they fall from the trees. One to catch them all becomes the fruit master...', NULL, 19, 76, 25, 4, 5, 5, 4, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(188, 1, 'Surprise Tenties!', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'Level-{sb}7{/sb} or {sb}8{/sb} attacks.', 'Reborn a {bi}Nitropus{/bi} piece in {sb}defense{/sb}-position or full {bi}Nitropus{/bi}. {i}[L], [M] and [R]{/i}', '', NULL, 3, 10, 0, 2, 5, 5, 4, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(189, 1, 'Igloomaiden', 0, 2, 1, 2, 1, 1, 5, 0, 2000, NULL, NULL, NULL, 'Change to {sb}defense{/sb}.', 'Gains {sb}sleeptalk{/sb}, and {b}Traps{/b} {sb}cannot{/sb} be activated if this attacks from {sb}defense{/sb}.', '', NULL, 3, 0, 1, 4, 5, 5, 4, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(190, 1, 'Amalgamation', 0, 4, 1, 3, 1, 1, 5, 1900, 0, 126, 107, NULL, 'Summoned {sb}this{/sb} turn.', 'Target {b}Slime{/b} gains {sb}500{/sb} {b}atk{/b}. {i}Until the end of this turn{/i}', '', NULL, 0, 0, 2, 4, 3, 5, 4, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(191, 1, 'Bunnyclaw', 0, 3, 1, 3, 1, 1, 6, 1500, 2100, NULL, NULL, NULL, 'Switch to {sb}defense{/sb}.', 'Destroy target monster. If {sb}set{/sb}, shoot. {i}Mills 1, damage{/i}', '', NULL, 3, 8, 0, 4, 5, 5, 4, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(192, 1, 'Cubiform Vamp', 0, 4, 1, 3, 1, 1, 7, 2100, 0, 79, 187, NULL, 'Mill {sb}2{/sb}. {i}From your deck{/i}', 'Target monster loses {sb}1000{/sb} {b}atk{/b}. {i}Until end of turn{/i}', '', NULL, 3, 39, 1, 3, 4, 5, 4, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(193, 1, 'Guffing Gulper', 0, 4, 1, 4, 1, 1, 4, 1600, 200, 87, 18, NULL, 'Continuous. {i}On field{/i}', 'You {sb}don\'t{/sb} have to tribute for level-{sb}5{/sb} or {sb}6{/sb} {b}Slimes{/b}.', '', NULL, 2, 4, 0, 4, 3, 5, 4, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(194, 1, 'Lapin Thrust', 0, 1, 3, 7, 1, 1, 1, 0, 0, 19, 180, NULL, 'Summons a monster.', 'It loses {sb}300{/sb} {b}def{/b}. Then if it has {sb}0{/sb} {b}def{/b}, destroy it.{i}Grave{/i}', '', NULL, 3, 0, 0, 4, 3, 5, 4, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(195, 1, '{i}The{/i}Momentum', 0, 6, 1, 3, 1, 1, 5, 200, 1700, 22, 186, NULL, 'Summoned {sb}this{/sb} turn.', 'Retrieve a {b}Zombie{/b} with {sb}0{/sb} {b}atk{/b}. {i}From grave to hand{/i}', '', NULL, 1, 1, 0, 3, 4, 5, 4, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(196, 1, 'Nameless Entity', 0, 3, 1, 4, 1, 1, 6, 1500, 200, 185, 181, NULL, 'Pay {sb}1000{/sb}. {i}Life points{/i}', 'Can be any material for a level-{sb}6{/sb} {b}Kawaii{/b} {sb}fusion{/sb}.', '', NULL, 5, 13, 6, 3, 4, 5, 4, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(197, 1, 'Snowow-Magia', 0, 2, 1, 3, 1, 1, 6, 1400, 2100, 189, 179, NULL, 'Reshuffle a {b}Dragon{/b}; {sb}ruler{/sb}-effect.{i}Until the end of next turn{/i}', 'Gains {sb}500{/sb} {b}atk{/b} and {sb}goaded{/sb}.', '', NULL, 2, 2, 6, 3, 4, 4, 4, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(198, 1, '{i}Squid{/i}-Loving Eir', 0, 5, 1, 3, 1, 1, 5, 1500, 600, 102, 182, NULL, 'Restack a {bi}Nitropus{/bi} piece. {i}From grave to top of deck{/i}', 'Gains its {b}atk{/b}. {i}For turn{/i}', '', NULL, 3, 10, 12, 2, 3, 5, 4, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(199, 1, 'You Traded me!', 0, 1, 3, 7, 1, 1, 1, 0, 0, 93, 184, NULL, 'Attacks {bi}Lapin Lazarus{/bi}; you {sb}may{/sb} change its position.', 'Gains {sb}1400{/sb} {b}atk{/b}. {i}Turn{/i}', '', NULL, 2, 3, 0, 3, 3, 5, 4, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(200, 1, 'Paper-Guildlord', 0, 4, 1, 2, 1, 1, 7, 0, 2300, NULL, NULL, NULL, 'In grave. {i}Continuous{/i}', 'You {sb}don\'t{/sb} have to tribute for level-{sb}5{/sb} {sb}normal{/sb} {b}Slimes{/b}. {i}To summon them{/i}', '', NULL, 10, 13, 42, 3, 5, 5, 6, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49');
INSERT INTO `card` (`id`, `ownerId`, `cardName`, `isAce`, `cardClassId`, `cardTypeId`, `subtypeId`, `supertypeId`, `maximumPieceId`, `level`, `atk`, `def`, `primaryMaterialId`, `secondaryMaterialId`, `tertiaryMaterialId`, `costText`, `effectText`, `flavourText`, `countsAsId`, `artScale`, `artXOffset`, `artYOffset`, `nameSize`, `materialsSize`, `effectsSize`, `expansionId`, `isDeleted`, `modifiedBy`, `created_at`, `updated_at`) VALUES
(201, 1, 'Pot-Burglar Nila', 0, 3, 1, 2, 1, 1, 1, 200, 0, NULL, NULL, NULL, 'Opponent has {sb}3{/sb} copies of the {sb}same{/sb} {b}Spell{/b} in their grave.', 'Draw {sb}2{/sb}. {i}Place the top 2 cards of your deck to hand{/i}', '', NULL, 3, 9, 11, 3, 5, 5, 6, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(202, 1, 'Prospector Seed', 0, 2, 1, 1, 4, 1, 1, 0, 1200, NULL, NULL, NULL, 'No monsters.', '', 'Sometimes pregnant dragons get a really bad diarrhea, and their eggs become diamonds.', NULL, 4, 13, 17, 2, 5, 5, 6, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(203, 1, 'Nullity-Germ', 0, 2, 1, 1, 4, 1, 1, 100, 1000, NULL, NULL, NULL, 'No monsters.', '', 'True dragons do not give birth! They grow until they become eggs in another dimension...', NULL, 5, 14, 16, 4, 5, 5, 6, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(204, 1, 'Magma Ovule', 0, 2, 1, 1, 4, 1, 1, 300, 0, NULL, NULL, NULL, 'No monsters.', '', 'Darkness crows collect all things shiny, even dragon eggs are not off their table.', NULL, 8, 12, 26, 4, 5, 5, 6, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(205, 1, 'We are Warriors!', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'Level-{sb}4{/sb} or {sb}higher{/sb} attacks.', 'Your level-{sb}3{/sb} and {sb}lower{/sb} monsters gain {sb}1000{/sb} {b}atk{/b}. {i}Use only on the opponent\'s turn{/i}', '', NULL, 3, 8, 6, 2, 5, 5, 6, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(206, 1, 'Tequila-Teresa', 0, 1, 1, 2, 1, 1, 5, 2000, 0, NULL, NULL, NULL, 'Mill {sb}1{/sb}. {i}From your deck{/i}', 'Armor-up. {i}Place top card as armor. You cannot look. Flipped when attacked{/i}', '', NULL, 4, 11, 0, 4, 5, 5, 6, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(207, 1, 'Donaldo, Duck', 0, 3, 1, 1, 1, 1, 2, 1000, 0, NULL, NULL, NULL, '', '', 'Quack, lads! We are furries, we will win always win! Can you feel the wind in your feathers? We will fly... SKY HIGH!', NULL, 3, 10, 3, 4, 5, 5, 6, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(208, 1, 'Egg Gathering', 0, 1, 2, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'None. {i}Your turn only{/i}', 'Rescale a level-{sb}1{/sb} {sb}pendulum{/sb} {b}Dragon{/b}. {i}From grave onto pendulum scale{/i}', '', NULL, 5, 9, 10, 4, 5, 5, 6, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49'),
(209, 1, 'Killed Piglet?', 0, 1, 3, 1, 1, 1, 1, 0, 0, NULL, NULL, NULL, 'Destroys your {sb}normal{/sb} monster with {sb}attack{/sb}. {i}Yellow{/i}', 'Change attacker to {sb}defense{/sb}-position. {i}Sideways{/i}', '', NULL, 4, 7, 1, 4, 5, 5, 6, 0, 0, '2024-05-12 10:27:49', '2024-05-12 10:27:49');

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
  ADD KEY `userId` (`ownerId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `card`
--
ALTER TABLE `card`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=210;

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
  ADD CONSTRAINT `card_ibfk_6` FOREIGN KEY (`ownerId`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;