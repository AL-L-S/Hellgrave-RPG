-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : ven. 21 mai 2021 à 14:14
-- Version du serveur :  8.0.18
-- Version de PHP : 7.4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `data1260`
--

-- --------------------------------------------------------

--
-- Structure de la table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(32) NOT NULL,
  `password` char(40) NOT NULL,
  `email` varchar(255) NOT NULL DEFAULT '',
  `premdays` int(11) NOT NULL DEFAULT '0',
  `lastday` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `type` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  `coins` int(12) UNSIGNED NOT NULL DEFAULT '0',
  `creation` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `recruiter` int(6) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `accounts`
--

INSERT INTO `accounts` (`id`, `name`, `password`, `email`, `premdays`, `lastday`, `type`, `coins`, `creation`, `recruiter`) VALUES
(1, 'god', '21298df8a3277357ee55b01df9530b535cf08ec1', '@god', 0, 0, 5, 6699, 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `account_bans`
--

CREATE TABLE `account_bans` (
  `account_id` int(11) UNSIGNED NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expires_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `account_ban_history`
--

CREATE TABLE `account_ban_history` (
  `id` int(11) NOT NULL,
  `account_id` int(11) UNSIGNED NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expired_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `account_viplist`
--

CREATE TABLE `account_viplist` (
  `account_id` int(11) UNSIGNED NOT NULL COMMENT 'id of account whose viplist entry it is',
  `player_id` int(11) NOT NULL COMMENT 'id of target player of viplist entry',
  `description` varchar(128) NOT NULL DEFAULT '',
  `icon` tinyint(2) UNSIGNED NOT NULL DEFAULT '0',
  `notify` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `boosted_creature`
--

CREATE TABLE `boosted_creature` (
  `looktype` int(11) NOT NULL DEFAULT '136',
  `lookfeet` int(11) NOT NULL DEFAULT '0',
  `looklegs` int(11) NOT NULL DEFAULT '0',
  `lookhead` int(11) NOT NULL DEFAULT '0',
  `lookbody` int(11) NOT NULL DEFAULT '0',
  `lookaddons` int(11) NOT NULL DEFAULT '0',
  `lookmount` int(11) DEFAULT '0',
  `date` varchar(250) NOT NULL DEFAULT '',
  `boostname` text,
  `raceid` varchar(250) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `boosted_creature`
--

INSERT INTO `boosted_creature` (`looktype`, `lookfeet`, `looklegs`, `lookhead`, `lookbody`, `lookaddons`, `lookmount`, `date`, `boostname`, `raceid`) VALUES
(138, 76, 52, 95, 114, 0, 0, '21', 'Sorcerer\'s Apparition', '1949');

-- --------------------------------------------------------

--
-- Structure de la table `coins_transactions`
--

CREATE TABLE `coins_transactions` (
  `id` int(11) UNSIGNED NOT NULL,
  `account_id` int(11) UNSIGNED NOT NULL,
  `type` tinyint(1) UNSIGNED NOT NULL,
  `amount` int(12) UNSIGNED NOT NULL,
  `description` varchar(3500) NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `daily_reward_history`
--

CREATE TABLE `daily_reward_history` (
  `id` int(11) NOT NULL,
  `daystreak` smallint(2) NOT NULL DEFAULT '0',
  `player_id` int(11) NOT NULL,
  `timestamp` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `global_storage`
--

CREATE TABLE `global_storage` (
  `key` varchar(32) NOT NULL,
  `value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `guilds`
--

CREATE TABLE `guilds` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `ownerid` int(11) NOT NULL,
  `creationdata` int(11) NOT NULL,
  `motd` varchar(255) NOT NULL DEFAULT '',
  `residence` int(11) NOT NULL DEFAULT '0',
  `balance` bigint(20) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déclencheurs `guilds`
--
DELIMITER $$
CREATE TRIGGER `oncreate_guilds` AFTER INSERT ON `guilds` FOR EACH ROW BEGIN
		INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('The Leader', 3, NEW.`id`);
		INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('Vice-Leader', 2, NEW.`id`);
		INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('Member', 1, NEW.`id`);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `guildwar_kills`
--

CREATE TABLE `guildwar_kills` (
  `id` int(11) NOT NULL,
  `killer` varchar(50) NOT NULL,
  `target` varchar(50) NOT NULL,
  `killerguild` int(11) NOT NULL DEFAULT '0',
  `targetguild` int(11) NOT NULL DEFAULT '0',
  `warid` int(11) NOT NULL DEFAULT '0',
  `time` bigint(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `guild_invites`
--

CREATE TABLE `guild_invites` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `guild_id` int(11) NOT NULL DEFAULT '0',
  `date` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `guild_membership`
--

CREATE TABLE `guild_membership` (
  `player_id` int(11) NOT NULL,
  `guild_id` int(11) NOT NULL,
  `rank_id` int(11) NOT NULL,
  `nick` varchar(15) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `guild_ranks`
--

CREATE TABLE `guild_ranks` (
  `id` int(11) NOT NULL,
  `guild_id` int(11) NOT NULL COMMENT 'guild',
  `name` varchar(255) NOT NULL COMMENT 'rank name',
  `level` int(11) NOT NULL COMMENT 'rank level - leader, vice, member, maybe something else'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `guild_wars`
--

CREATE TABLE `guild_wars` (
  `id` int(11) NOT NULL,
  `guild1` int(11) NOT NULL DEFAULT '0',
  `guild2` int(11) NOT NULL DEFAULT '0',
  `name1` varchar(255) NOT NULL,
  `name2` varchar(255) NOT NULL,
  `status` tinyint(2) NOT NULL DEFAULT '0',
  `started` bigint(15) NOT NULL DEFAULT '0',
  `ended` bigint(15) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `houses`
--

CREATE TABLE `houses` (
  `id` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `paid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `warnings` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `rent` int(11) NOT NULL DEFAULT '0',
  `town_id` int(11) NOT NULL DEFAULT '0',
  `bid` int(11) NOT NULL DEFAULT '0',
  `bid_end` int(11) NOT NULL DEFAULT '0',
  `last_bid` int(11) NOT NULL DEFAULT '0',
  `highest_bidder` int(11) NOT NULL DEFAULT '0',
  `size` int(11) NOT NULL DEFAULT '0',
  `guildid` int(11) DEFAULT NULL,
  `beds` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `houses`
--

INSERT INTO `houses` (`id`, `owner`, `paid`, `warnings`, `name`, `rent`, `town_id`, `bid`, `bid_end`, `last_bid`, `highest_bidder`, `size`, `guildid`, `beds`) VALUES
(2628, 0, 0, 0, 'Castle of the Winds', 500000, 5, 0, 0, 0, 0, 863, NULL, 36),
(2629, 0, 0, 0, 'Ab\'Dendriel Clanhall', 250000, 5, 0, 0, 0, 0, 456, NULL, 20),
(2630, 0, 0, 0, 'Underwood 9', 50000, 5, 0, 0, 0, 0, 29, NULL, 2),
(2631, 0, 0, 0, 'Treetop 13', 100000, 5, 0, 0, 0, 0, 45, NULL, 4),
(2632, 0, 0, 0, 'Underwood 8', 50000, 5, 0, 0, 0, 0, 33, NULL, 4),
(2633, 0, 0, 0, 'Treetop 11', 50000, 5, 0, 0, 0, 0, 34, NULL, 4),
(2635, 0, 0, 0, 'Great Willow 2a', 50000, 5, 0, 0, 0, 0, 34, NULL, 2),
(2637, 0, 0, 0, 'Great Willow 2b', 50000, 5, 0, 0, 0, 0, 29, NULL, 2),
(2638, 0, 0, 0, 'Great Willow Western Wing', 100000, 5, 0, 0, 0, 0, 90, NULL, 10),
(2640, 0, 0, 0, 'Great Willow 1', 100000, 5, 0, 0, 0, 0, 55, NULL, 4),
(2642, 0, 0, 0, 'Great Willow 3a', 50000, 5, 0, 0, 0, 0, 33, NULL, 2),
(2644, 0, 0, 0, 'Great Willow 3b', 80000, 5, 0, 0, 0, 0, 52, NULL, 4),
(2645, 0, 0, 0, 'Great Willow 4a', 25000, 5, 0, 0, 0, 0, 27, NULL, 4),
(2648, 0, 0, 0, 'Great Willow 4b', 25000, 5, 0, 0, 0, 0, 31, NULL, 4),
(2649, 0, 0, 0, 'Underwood 6', 100000, 5, 0, 0, 0, 0, 55, NULL, 6),
(2650, 0, 0, 0, 'Underwood 3', 100000, 5, 0, 0, 0, 0, 56, NULL, 6),
(2651, 0, 0, 0, 'Underwood 5', 80000, 5, 0, 0, 0, 0, 49, NULL, 6),
(2652, 0, 0, 0, 'Underwood 2', 100000, 5, 0, 0, 0, 0, 53, NULL, 4),
(2653, 0, 0, 0, 'Underwood 1', 100000, 5, 0, 0, 0, 0, 54, NULL, 4),
(2654, 0, 0, 0, 'Prima Arbor', 400000, 5, 0, 0, 0, 0, 316, NULL, 6),
(2655, 0, 0, 0, 'Underwood 7', 200000, 5, 0, 0, 0, 0, 52, NULL, 4),
(2656, 0, 0, 0, 'Underwood 10', 25000, 5, 0, 0, 0, 0, 30, NULL, 2),
(2657, 0, 0, 0, 'Underwood 4', 100000, 5, 0, 0, 0, 0, 72, NULL, 8),
(2658, 0, 0, 0, 'Treetop 9', 50000, 5, 0, 0, 0, 0, 35, NULL, 4),
(2659, 0, 0, 0, 'Treetop 10', 80000, 5, 0, 0, 0, 0, 42, NULL, 4),
(2660, 0, 0, 0, 'Treetop 8', 25000, 5, 0, 0, 0, 0, 35, NULL, 2),
(2661, 0, 0, 0, 'Treetop 7', 50000, 5, 0, 0, 0, 0, 28, NULL, 2),
(2662, 0, 0, 0, 'Treetop 6', 25000, 5, 0, 0, 0, 0, 24, NULL, 2),
(2663, 0, 0, 0, 'Treetop 5 (Shop)', 80000, 5, 0, 0, 0, 0, 54, NULL, 2),
(2664, 0, 0, 0, 'Treetop 12 (Shop)', 100000, 5, 0, 0, 0, 0, 56, NULL, 2),
(2665, 0, 0, 0, 'Treetop 4 (Shop)', 80000, 5, 0, 0, 0, 0, 48, NULL, 2),
(2666, 0, 0, 0, 'Treetop 3 (Shop)', 80000, 5, 0, 0, 0, 0, 60, NULL, 2),
(2687, 0, 0, 0, 'Northern Street 1a', 100000, 6, 0, 0, 0, 0, 42, NULL, 4),
(2688, 0, 0, 0, 'Park Lane 3a', 100000, 6, 0, 0, 0, 0, 48, NULL, 4),
(2689, 0, 0, 0, 'Park Lane 1a', 150000, 6, 0, 0, 0, 0, 53, NULL, 4),
(2690, 0, 0, 0, 'Park Lane 4', 150000, 6, 0, 0, 0, 0, 42, NULL, 4),
(2691, 0, 0, 0, 'Park Lane 2', 150000, 6, 0, 0, 0, 0, 42, NULL, 4),
(2692, 0, 0, 0, 'Theater Avenue 7, Flat 04', 50000, 6, 0, 0, 0, 0, 20, NULL, 2),
(2693, 0, 0, 0, 'Theater Avenue 7, Flat 03', 25000, 6, 0, 0, 0, 0, 19, NULL, 2),
(2694, 0, 0, 0, 'Theater Avenue 7, Flat 05', 50000, 6, 0, 0, 0, 0, 20, NULL, 2),
(2695, 0, 0, 0, 'Theater Avenue 7, Flat 06', 25000, 6, 0, 0, 0, 0, 20, NULL, 2),
(2696, 0, 0, 0, 'Theater Avenue 7, Flat 02', 25000, 6, 0, 0, 0, 0, 20, NULL, 2),
(2697, 0, 0, 0, 'Theater Avenue 7, Flat 01', 25000, 6, 0, 0, 0, 0, 20, NULL, 2),
(2698, 0, 0, 0, 'Northern Street 5', 200000, 6, 0, 0, 0, 0, 68, NULL, 4),
(2699, 0, 0, 0, 'Northern Street 7', 150000, 6, 0, 0, 0, 0, 59, NULL, 4),
(2700, 0, 0, 0, 'Theater Avenue 6e', 80000, 6, 0, 0, 0, 0, 31, NULL, 4),
(2701, 0, 0, 0, 'Theater Avenue 6c', 25000, 6, 0, 0, 0, 0, 12, NULL, 2),
(2702, 0, 0, 0, 'Theater Avenue 6a', 80000, 6, 0, 0, 0, 0, 35, NULL, 4),
(2703, 0, 0, 0, 'Theater Avenue, Tower', 300000, 6, 0, 0, 0, 0, 125, NULL, 0),
(2705, 0, 0, 0, 'East Lane 2', 300000, 6, 0, 0, 0, 0, 111, NULL, 4),
(2706, 0, 0, 0, 'Harbour Lane 2a (Shop)', 80000, 6, 0, 0, 0, 0, 32, NULL, 0),
(2707, 0, 0, 0, 'Harbour Lane 2b (Shop)', 80000, 6, 0, 0, 0, 0, 40, NULL, 0),
(2708, 0, 0, 0, 'Harbour Lane 3', 400000, 6, 0, 0, 0, 0, 113, NULL, 6),
(2709, 0, 0, 0, 'Magician\'s Alley 8', 150000, 6, 0, 0, 0, 0, 49, NULL, 4),
(2710, 0, 0, 0, 'Lonely Sea Side Hostel', 400000, 6, 0, 0, 0, 0, 397, NULL, 16),
(2711, 0, 0, 0, 'Suntower', 500000, 6, 0, 0, 0, 0, 451, NULL, 14),
(2712, 0, 0, 0, 'House of Recreation', 500000, 6, 0, 0, 0, 0, 687, NULL, 32),
(2713, 0, 0, 0, 'Carlin Clanhall', 250000, 6, 0, 0, 0, 0, 374, NULL, 20),
(2714, 0, 0, 0, 'Magician\'s Alley 4', 200000, 6, 0, 0, 0, 0, 96, NULL, 8),
(2715, 0, 0, 0, 'Theater Avenue 14 (Shop)', 200000, 6, 0, 0, 0, 0, 83, NULL, 2),
(2716, 0, 0, 0, 'Theater Avenue 12', 80000, 6, 0, 0, 0, 0, 28, NULL, 4),
(2717, 0, 0, 0, 'Magician\'s Alley 1', 100000, 6, 0, 0, 0, 0, 35, NULL, 4),
(2718, 0, 0, 0, 'Theater Avenue 10', 100000, 6, 0, 0, 0, 0, 45, NULL, 4),
(2719, 0, 0, 0, 'Magician\'s Alley 1b', 25000, 6, 0, 0, 0, 0, 24, NULL, 4),
(2720, 0, 0, 0, 'Magician\'s Alley 1a', 25000, 6, 0, 0, 0, 0, 28, NULL, 4),
(2721, 0, 0, 0, 'Magician\'s Alley 1c', 25000, 6, 0, 0, 0, 0, 20, NULL, 2),
(2722, 0, 0, 0, 'Magician\'s Alley 1d', 25000, 6, 0, 0, 0, 0, 24, NULL, 2),
(2723, 0, 0, 0, 'Magician\'s Alley 5c', 100000, 6, 0, 0, 0, 0, 35, NULL, 4),
(2724, 0, 0, 0, 'Magician\'s Alley 5f', 80000, 6, 0, 0, 0, 0, 42, NULL, 4),
(2725, 0, 0, 0, 'Magician\'s Alley 5b', 50000, 6, 0, 0, 0, 0, 40, NULL, 4),
(2727, 0, 0, 0, 'Magician\'s Alley 5a', 50000, 6, 0, 0, 0, 0, 45, NULL, 4),
(2729, 0, 0, 0, 'Central Plaza 3 (Shop)', 50000, 6, 0, 0, 0, 0, 24, NULL, 0),
(2730, 0, 0, 0, 'Central Plaza 2 (Shop)', 25000, 6, 0, 0, 0, 0, 24, NULL, 0),
(2731, 0, 0, 0, 'Central Plaza 1 (Shop)', 50000, 6, 0, 0, 0, 0, 24, NULL, 0),
(2732, 0, 0, 0, 'Theater Avenue 8b', 100000, 6, 0, 0, 0, 0, 49, NULL, 4),
(2733, 0, 0, 0, 'Harbour Lane 1 (Shop)', 100000, 6, 0, 0, 0, 0, 54, NULL, 0),
(2734, 0, 0, 0, 'Theater Avenue 6f', 80000, 6, 0, 0, 0, 0, 31, NULL, 4),
(2735, 0, 0, 0, 'Theater Avenue 6d', 25000, 6, 0, 0, 0, 0, 12, NULL, 2),
(2736, 0, 0, 0, 'Theater Avenue 6b', 50000, 6, 0, 0, 0, 0, 35, NULL, 4),
(2737, 0, 0, 0, 'Northern Street 3a', 80000, 6, 0, 0, 0, 0, 34, NULL, 4),
(2738, 0, 0, 0, 'Northern Street 3b', 80000, 6, 0, 0, 0, 0, 36, NULL, 4),
(2739, 0, 0, 0, 'Northern Street 1b', 80000, 6, 0, 0, 0, 0, 37, NULL, 4),
(2740, 0, 0, 0, 'Northern Street 1c', 80000, 6, 0, 0, 0, 0, 35, NULL, 4),
(2741, 0, 0, 0, 'Theater Avenue 7, Flat 14', 25000, 6, 0, 0, 0, 0, 20, NULL, 2),
(2742, 0, 0, 0, 'Theater Avenue 7, Flat 13', 25000, 6, 0, 0, 0, 0, 20, NULL, 2),
(2743, 0, 0, 0, 'Theater Avenue 7, Flat 15', 25000, 6, 0, 0, 0, 0, 20, NULL, 2),
(2744, 0, 0, 0, 'Theater Avenue 7, Flat 12', 25000, 6, 0, 0, 0, 0, 20, NULL, 2),
(2745, 0, 0, 0, 'Theater Avenue 7, Flat 11', 50000, 6, 0, 0, 0, 0, 24, NULL, 2),
(2746, 0, 0, 0, 'Theater Avenue 7, Flat 16', 25000, 6, 0, 0, 0, 0, 24, NULL, 2),
(2747, 0, 0, 0, 'Theater Avenue 5', 200000, 6, 0, 0, 0, 0, 165, NULL, 6),
(2751, 0, 0, 0, 'Harbour Flats, Flat 11', 25000, 6, 0, 0, 0, 0, 24, NULL, 2),
(2752, 0, 0, 0, 'Harbour Flats, Flat 13', 25000, 6, 0, 0, 0, 0, 24, NULL, 2),
(2753, 0, 0, 0, 'Harbour Flats, Flat 15', 50000, 6, 0, 0, 0, 0, 38, NULL, 4),
(2755, 0, 0, 0, 'Harbour Flats, Flat 12', 50000, 6, 0, 0, 0, 0, 40, NULL, 4),
(2757, 0, 0, 0, 'Harbour Flats, Flat 16', 50000, 6, 0, 0, 0, 0, 45, NULL, 4),
(2759, 0, 0, 0, 'Harbour Flats, Flat 21', 50000, 6, 0, 0, 0, 0, 35, NULL, 4),
(2760, 0, 0, 0, 'Harbour Flats, Flat 22', 80000, 6, 0, 0, 0, 0, 45, NULL, 4),
(2761, 0, 0, 0, 'Harbour Flats, Flat 23', 25000, 6, 0, 0, 0, 0, 25, NULL, 2),
(2763, 0, 0, 0, 'Park Lane 1b', 200000, 6, 0, 0, 0, 0, 54, NULL, 4),
(2764, 0, 0, 0, 'Theater Avenue 8a', 100000, 6, 0, 0, 0, 0, 49, NULL, 6),
(2765, 0, 0, 0, 'Theater Avenue 11a', 100000, 6, 0, 0, 0, 0, 48, NULL, 4),
(2767, 0, 0, 0, 'Theater Avenue 11b', 100000, 6, 0, 0, 0, 0, 54, NULL, 4),
(2768, 0, 0, 0, 'Caretaker\'s Residence', 600000, 6, 0, 0, 0, 0, 423, NULL, 0),
(2769, 0, 0, 0, 'Moonkeep', 250000, 6, 0, 0, 0, 0, 518, NULL, 32),
(2770, 0, 0, 0, 'Mangrove 1', 80000, 5, 0, 0, 0, 0, 56, NULL, 6),
(2771, 0, 0, 0, 'Coastwood 2', 50000, 5, 0, 0, 0, 0, 28, NULL, 4),
(2772, 0, 0, 0, 'Coastwood 1', 50000, 5, 0, 0, 0, 0, 35, NULL, 4),
(2773, 0, 0, 0, 'Coastwood 3', 50000, 5, 0, 0, 0, 0, 37, NULL, 4),
(2774, 0, 0, 0, 'Coastwood 4', 50000, 5, 0, 0, 0, 0, 42, NULL, 4),
(2775, 0, 0, 0, 'Mangrove 4', 50000, 5, 0, 0, 0, 0, 36, NULL, 4),
(2776, 0, 0, 0, 'Coastwood 10', 80000, 5, 0, 0, 0, 0, 49, NULL, 6),
(2777, 0, 0, 0, 'Coastwood 5', 50000, 5, 0, 0, 0, 0, 49, NULL, 4),
(2778, 0, 0, 0, 'Coastwood 6 (Shop)', 80000, 5, 0, 0, 0, 0, 48, NULL, 2),
(2779, 0, 0, 0, 'Coastwood 7', 25000, 5, 0, 0, 0, 0, 29, NULL, 2),
(2780, 0, 0, 0, 'Coastwood 8', 50000, 5, 0, 0, 0, 0, 42, NULL, 4),
(2781, 0, 0, 0, 'Coastwood 9', 50000, 5, 0, 0, 0, 0, 36, NULL, 2),
(2782, 0, 0, 0, 'Treetop 2', 25000, 5, 0, 0, 0, 0, 24, NULL, 2),
(2783, 0, 0, 0, 'Treetop 1', 25000, 5, 0, 0, 0, 0, 30, NULL, 2),
(2784, 0, 0, 0, 'Mangrove 3', 80000, 5, 0, 0, 0, 0, 42, NULL, 4),
(2785, 0, 0, 0, 'Mangrove 2', 50000, 5, 0, 0, 0, 0, 48, NULL, 4),
(2786, 0, 0, 0, 'The Hideout', 250000, 5, 0, 0, 0, 0, 584, NULL, 40),
(2787, 0, 0, 0, 'Shadow Towers', 250000, 5, 0, 0, 0, 0, 708, NULL, 36),
(2788, 0, 0, 0, 'Druids Retreat A', 50000, 6, 0, 0, 0, 0, 60, NULL, 4),
(2789, 0, 0, 0, 'Druids Retreat C', 50000, 6, 0, 0, 0, 0, 45, NULL, 4),
(2790, 0, 0, 0, 'Druids Retreat B', 50000, 6, 0, 0, 0, 0, 56, NULL, 4),
(2791, 0, 0, 0, 'Druids Retreat D', 80000, 6, 0, 0, 0, 0, 51, NULL, 4),
(2792, 0, 0, 0, 'East Lane 1b', 150000, 6, 0, 0, 0, 0, 53, NULL, 4),
(2793, 0, 0, 0, 'East Lane 1a', 200000, 6, 0, 0, 0, 0, 87, NULL, 4),
(2794, 0, 0, 0, 'Senja Village 11', 80000, 6, 0, 0, 0, 0, 92, NULL, 4),
(2795, 0, 0, 0, 'Senja Village 10', 50000, 6, 0, 0, 0, 0, 72, NULL, 2),
(2796, 0, 0, 0, 'Senja Village 9', 80000, 6, 0, 0, 0, 0, 112, NULL, 4),
(2797, 0, 0, 0, 'Senja Village 8', 50000, 6, 0, 0, 0, 0, 72, NULL, 4),
(2798, 0, 0, 0, 'Senja Village 7', 25000, 6, 0, 0, 0, 0, 36, NULL, 4),
(2799, 0, 0, 0, 'Senja Village 6b', 25000, 6, 0, 0, 0, 0, 30, NULL, 2),
(2800, 0, 0, 0, 'Senja Village 6a', 50000, 6, 0, 0, 0, 0, 30, NULL, 2),
(2801, 0, 0, 0, 'Senja Village 5', 50000, 6, 0, 0, 0, 0, 48, NULL, 4),
(2802, 0, 0, 0, 'Senja Village 4', 50000, 6, 0, 0, 0, 0, 66, NULL, 4),
(2803, 0, 0, 0, 'Senja Village 3', 50000, 6, 0, 0, 0, 0, 72, NULL, 4),
(2804, 0, 0, 0, 'Senja Village 1b', 50000, 6, 0, 0, 0, 0, 66, NULL, 4),
(2805, 0, 0, 0, 'Senja Village 1a', 25000, 6, 0, 0, 0, 0, 36, NULL, 2),
(2806, 0, 0, 0, 'Rosebud C', 100000, 6, 0, 0, 0, 0, 70, NULL, 0),
(2807, 0, 0, 0, 'Rosebud B', 80000, 6, 0, 0, 0, 0, 60, NULL, 2),
(2808, 0, 0, 0, 'Rosebud A', 50000, 6, 0, 0, 0, 0, 60, NULL, 2),
(2809, 0, 0, 0, 'Park Lane 3b', 100000, 6, 0, 0, 0, 0, 48, NULL, 4),
(2810, 0, 0, 0, 'Northport Village 6', 80000, 6, 0, 0, 0, 0, 64, NULL, 4),
(2811, 0, 0, 0, 'Northport Village 5', 80000, 6, 0, 0, 0, 0, 56, NULL, 4),
(2812, 0, 0, 0, 'Northport Village 4', 100000, 6, 0, 0, 0, 0, 92, NULL, 4),
(2813, 0, 0, 0, 'Northport Village 3', 150000, 6, 0, 0, 0, 0, 119, NULL, 4),
(2814, 0, 0, 0, 'Northport Village 2', 50000, 6, 0, 0, 0, 0, 40, NULL, 4),
(2815, 0, 0, 0, 'Northport Village 1', 50000, 6, 0, 0, 0, 0, 48, NULL, 4),
(2816, 0, 0, 0, 'Nautic Observer', 200000, 6, 0, 0, 0, 0, 226, NULL, 8),
(2817, 0, 0, 0, 'Nordic Stronghold', 250000, 6, 0, 0, 0, 0, 809, NULL, 42),
(2818, 0, 0, 0, 'Senja Clanhall', 250000, 6, 0, 0, 0, 0, 396, NULL, 18),
(2819, 0, 0, 0, 'Seawatch', 250000, 6, 0, 0, 0, 0, 749, NULL, 38),
(2820, 0, 0, 0, 'Dwarven Magnate\'s Estate', 300000, 7, 0, 0, 0, 0, 395, NULL, 0),
(2821, 0, 0, 0, 'Forge Master\'s Quarters', 300000, 7, 0, 0, 0, 0, 117, NULL, 0),
(2822, 0, 0, 0, 'Upper Barracks 13', 25000, 7, 0, 0, 0, 0, 24, NULL, 4),
(2823, 0, 0, 0, 'Upper Barracks 5', 80000, 7, 0, 0, 0, 0, 50, NULL, 6),
(2824, 0, 0, 0, 'Upper Barracks 3', 80000, 7, 0, 0, 0, 0, 24, NULL, 4),
(2825, 0, 0, 0, 'Upper Barracks 4', 50000, 7, 0, 0, 0, 0, 35, NULL, 4),
(2826, 0, 0, 0, 'Upper Barracks 2', 80000, 7, 0, 0, 0, 0, 50, NULL, 6),
(2827, 0, 0, 0, 'Upper Barracks 1', 50000, 7, 0, 0, 0, 0, 35, NULL, 4),
(2828, 0, 0, 0, 'Tunnel Gardens 9', 150000, 7, 0, 0, 0, 0, 145, NULL, 14),
(2829, 0, 0, 0, 'Tunnel Gardens 8', 25000, 7, 0, 0, 0, 0, 42, NULL, 4),
(2830, 0, 0, 0, 'Tunnel Gardens 7', 50000, 7, 0, 0, 0, 0, 35, NULL, 4),
(2831, 0, 0, 0, 'Tunnel Gardens 6', 25000, 7, 0, 0, 0, 0, 42, NULL, 4),
(2832, 0, 0, 0, 'Tunnel Gardens 5', 25000, 7, 0, 0, 0, 0, 35, NULL, 4),
(2835, 0, 0, 0, 'Tunnel Gardens 4', 80000, 7, 0, 0, 0, 0, 58, NULL, 6),
(2836, 0, 0, 0, 'Tunnel Gardens 2', 80000, 7, 0, 0, 0, 0, 54, NULL, 6),
(2837, 0, 0, 0, 'Tunnel Gardens 1', 80000, 7, 0, 0, 0, 0, 47, NULL, 6),
(2838, 0, 0, 0, 'Tunnel Gardens 3', 80000, 7, 0, 0, 0, 0, 65, NULL, 6),
(2839, 0, 0, 0, 'The Market 4 (Shop)', 80000, 7, 0, 0, 0, 0, 63, NULL, 2),
(2840, 0, 0, 0, 'The Market 3 (Shop)', 80000, 7, 0, 0, 0, 0, 54, NULL, 2),
(2841, 0, 0, 0, 'The Market 2 (Shop)', 50000, 7, 0, 0, 0, 0, 45, NULL, 2),
(2842, 0, 0, 0, 'The Market 1 (Shop)', 25000, 7, 0, 0, 0, 0, 25, NULL, 2),
(2843, 0, 0, 0, 'The Farms 6, Fishing Hut', 50000, 7, 0, 0, 0, 0, 42, NULL, 4),
(2844, 0, 0, 0, 'The Farms 5', 50000, 7, 0, 0, 0, 0, 49, NULL, 4),
(2845, 0, 0, 0, 'The Farms 4', 25000, 7, 0, 0, 0, 0, 49, NULL, 4),
(2846, 0, 0, 0, 'The Farms 3', 80000, 7, 0, 0, 0, 0, 49, NULL, 4),
(2847, 0, 0, 0, 'The Farms 2', 50000, 7, 0, 0, 0, 0, 49, NULL, 4),
(2849, 0, 0, 0, 'The Farms 1', 80000, 7, 0, 0, 0, 0, 78, NULL, 6),
(2850, 0, 0, 0, 'Outlaw Camp 14 (Shop)', 25000, 7, 0, 0, 0, 0, 35, NULL, 0),
(2852, 0, 0, 0, 'Outlaw Camp 13 (Shop)', 50000, 7, 0, 0, 0, 0, 40, NULL, 0),
(2853, 0, 0, 0, 'Outlaw Camp 9', 80000, 7, 0, 0, 0, 0, 40, NULL, 4),
(2854, 0, 0, 0, 'Outlaw Camp 7', 25000, 7, 0, 0, 0, 0, 38, NULL, 4),
(2855, 0, 0, 0, 'Outlaw Camp 4', 50000, 7, 0, 0, 0, 0, 40, NULL, 2),
(2856, 0, 0, 0, 'Outlaw Camp 2', 50000, 7, 0, 0, 0, 0, 40, NULL, 2),
(2857, 0, 0, 0, 'Outlaw Camp 3', 50000, 7, 0, 0, 0, 0, 35, NULL, 4),
(2858, 0, 0, 0, 'Outlaw Camp 1', 80000, 7, 0, 0, 0, 0, 54, NULL, 4),
(2859, 0, 0, 0, 'Nobility Quarter 5', 100000, 7, 0, 0, 0, 0, 143, NULL, 8),
(2860, 0, 0, 0, 'Nobility Quarter 4', 50000, 7, 0, 0, 0, 0, 66, NULL, 4),
(2861, 0, 0, 0, 'Nobility Quarter 3', 80000, 7, 0, 0, 0, 0, 56, NULL, 6),
(2862, 0, 0, 0, 'Nobility Quarter 2', 50000, 7, 0, 0, 0, 0, 61, NULL, 6),
(2863, 0, 0, 0, 'Nobility Quarter 1', 80000, 7, 0, 0, 0, 0, 64, NULL, 6),
(2864, 0, 0, 0, 'Lower Barracks 10', 80000, 7, 0, 0, 0, 0, 50, NULL, 4),
(2865, 0, 0, 0, 'Lower Barracks 9', 80000, 7, 0, 0, 0, 0, 50, NULL, 4),
(2866, 0, 0, 0, 'Lower Barracks 8', 80000, 7, 0, 0, 0, 0, 50, NULL, 4),
(2867, 0, 0, 0, 'Lower Barracks 1', 80000, 7, 0, 0, 0, 0, 50, NULL, 4),
(2868, 0, 0, 0, 'Lower Barracks 2', 80000, 7, 0, 0, 0, 0, 50, NULL, 4),
(2869, 0, 0, 0, 'Lower Barracks 3', 80000, 7, 0, 0, 0, 0, 50, NULL, 4),
(2870, 0, 0, 0, 'Lower Barracks 4', 50000, 7, 0, 0, 0, 0, 50, NULL, 2),
(2871, 0, 0, 0, 'Lower Barracks 5', 100000, 7, 0, 0, 0, 0, 100, NULL, 2),
(2872, 0, 0, 0, 'Lower Barracks 6', 100000, 7, 0, 0, 0, 0, 100, NULL, 4),
(2873, 0, 0, 0, 'Lower Barracks 7', 80000, 7, 0, 0, 0, 0, 50, NULL, 2),
(2874, 0, 0, 0, 'Wolftower', 500000, 7, 0, 0, 0, 0, 680, NULL, 46),
(2875, 0, 0, 0, 'Riverspring', 250000, 7, 0, 0, 0, 0, 632, NULL, 36),
(2876, 0, 0, 0, 'Outlaw Castle', 250000, 7, 0, 0, 0, 0, 356, NULL, 18),
(2877, 0, 0, 0, 'Marble Guildhall', 250000, 7, 0, 0, 0, 0, 612, NULL, 34),
(2878, 0, 0, 0, 'Iron Guildhall', 250000, 7, 0, 0, 0, 0, 534, NULL, 34),
(2879, 0, 0, 0, 'Hill Hideout', 250000, 7, 0, 0, 0, 0, 395, NULL, 30),
(2880, 0, 0, 0, 'Granite Guildhall', 250000, 7, 0, 0, 0, 0, 627, NULL, 34),
(2881, 0, 0, 0, 'Alai Flats, Flat 01', 50000, 8, 0, 0, 0, 0, 25, NULL, 2),
(2882, 0, 0, 0, 'Alai Flats, Flat 02', 50000, 8, 0, 0, 0, 0, 35, NULL, 2),
(2883, 0, 0, 0, 'Alai Flats, Flat 03', 50000, 8, 0, 0, 0, 0, 36, NULL, 2),
(2884, 0, 0, 0, 'Alai Flats, Flat 04', 80000, 8, 0, 0, 0, 0, 30, NULL, 2),
(2885, 0, 0, 0, 'Alai Flats, Flat 05', 100000, 8, 0, 0, 0, 0, 42, NULL, 4),
(2886, 0, 0, 0, 'Alai Flats, Flat 06', 100000, 8, 0, 0, 0, 0, 42, NULL, 4),
(2887, 0, 0, 0, 'Alai Flats, Flat 07', 25000, 8, 0, 0, 0, 0, 30, NULL, 2),
(2888, 0, 0, 0, 'Alai Flats, Flat 08', 50000, 8, 0, 0, 0, 0, 36, NULL, 2),
(2889, 0, 0, 0, 'Alai Flats, Flat 11', 80000, 8, 0, 0, 0, 0, 30, NULL, 2),
(2890, 0, 0, 0, 'Alai Flats, Flat 12', 25000, 8, 0, 0, 0, 0, 30, NULL, 2),
(2891, 0, 0, 0, 'Alai Flats, Flat 13', 50000, 8, 0, 0, 0, 0, 36, NULL, 2),
(2892, 0, 0, 0, 'Alai Flats, Flat 14', 80000, 8, 0, 0, 0, 0, 32, NULL, 2),
(2893, 0, 0, 0, 'Alai Flats, Flat 15', 100000, 8, 0, 0, 0, 0, 46, NULL, 4),
(2894, 0, 0, 0, 'Alai Flats, Flat 16', 100000, 8, 0, 0, 0, 0, 46, NULL, 4),
(2895, 0, 0, 0, 'Alai Flats, Flat 17', 80000, 8, 0, 0, 0, 0, 32, NULL, 2),
(2896, 0, 0, 0, 'Alai Flats, Flat 18', 50000, 8, 0, 0, 0, 0, 38, NULL, 2),
(2897, 0, 0, 0, 'Alai Flats, Flat 21', 50000, 8, 0, 0, 0, 0, 30, NULL, 2),
(2898, 0, 0, 0, 'Alai Flats, Flat 22', 50000, 8, 0, 0, 0, 0, 30, NULL, 2),
(2899, 0, 0, 0, 'Alai Flats, Flat 23', 25000, 8, 0, 0, 0, 0, 36, NULL, 2),
(2900, 0, 0, 0, 'Alai Flats, Flat 28', 80000, 8, 0, 0, 0, 0, 32, NULL, 2),
(2901, 0, 0, 0, 'Alai Flats, Flat 27', 80000, 8, 0, 0, 0, 0, 32, NULL, 2),
(2902, 0, 0, 0, 'Alai Flats, Flat 26', 100000, 8, 0, 0, 0, 0, 46, NULL, 4),
(2903, 0, 0, 0, 'Alai Flats, Flat 25', 100000, 8, 0, 0, 0, 0, 46, NULL, 4),
(2904, 0, 0, 0, 'Alai Flats, Flat 24', 80000, 8, 0, 0, 0, 0, 39, NULL, 2),
(2905, 0, 0, 0, 'Beach Home Apartments, Flat 01', 50000, 8, 0, 0, 0, 0, 25, NULL, 2),
(2906, 0, 0, 0, 'Beach Home Apartments, Flat 02', 80000, 8, 0, 0, 0, 0, 30, NULL, 2),
(2907, 0, 0, 0, 'Beach Home Apartments, Flat 03', 80000, 8, 0, 0, 0, 0, 24, NULL, 2),
(2908, 0, 0, 0, 'Beach Home Apartments, Flat 04', 50000, 8, 0, 0, 0, 0, 24, NULL, 2),
(2909, 0, 0, 0, 'Beach Home Apartments, Flat 05', 80000, 8, 0, 0, 0, 0, 30, NULL, 2),
(2910, 0, 0, 0, 'Beach Home Apartments, Flat 06', 100000, 8, 0, 0, 0, 0, 40, NULL, 4),
(2911, 0, 0, 0, 'Beach Home Apartments, Flat 11', 25000, 8, 0, 0, 0, 0, 25, NULL, 2),
(2912, 0, 0, 0, 'Beach Home Apartments, Flat 12', 50000, 8, 0, 0, 0, 0, 30, NULL, 2),
(2913, 0, 0, 0, 'Beach Home Apartments, Flat 13', 80000, 8, 0, 0, 0, 0, 30, NULL, 2),
(2914, 0, 0, 0, 'Beach Home Apartments, Flat 14', 25000, 8, 0, 0, 0, 0, 15, NULL, 2),
(2915, 0, 0, 0, 'Beach Home Apartments, Flat 15', 25000, 8, 0, 0, 0, 0, 20, NULL, 2),
(2916, 0, 0, 0, 'Beach Home Apartments, Flat 16', 80000, 8, 0, 0, 0, 0, 40, NULL, 4),
(2917, 0, 0, 0, 'Demon Tower', 100000, 8, 0, 0, 0, 0, 150, NULL, 4),
(2918, 0, 0, 0, 'Farm Lane, 1st floor (Shop)', 80000, 8, 0, 0, 0, 0, 36, NULL, 0),
(2919, 0, 0, 0, 'Farm Lane, 2nd Floor (Shop)', 50000, 8, 0, 0, 0, 0, 36, NULL, 0),
(2920, 0, 0, 0, 'Farm Lane, Basement (Shop)', 50000, 8, 0, 0, 0, 0, 42, NULL, 0),
(2921, 0, 0, 0, 'Fibula Village 1', 25000, 8, 0, 0, 0, 0, 30, NULL, 2),
(2922, 0, 0, 0, 'Fibula Village 2', 25000, 8, 0, 0, 0, 0, 30, NULL, 2),
(2923, 0, 0, 0, 'Fibula Village 4', 25000, 8, 0, 0, 0, 0, 42, NULL, 4),
(2924, 0, 0, 0, 'Fibula Village 5', 50000, 8, 0, 0, 0, 0, 49, NULL, 4),
(2925, 0, 0, 0, 'Fibula Village 3', 80000, 8, 0, 0, 0, 0, 110, NULL, 8),
(2926, 0, 0, 0, 'Fibula Village, Tower Flat', 100000, 8, 0, 0, 0, 0, 156, NULL, 4),
(2927, 0, 0, 0, 'Guildhall of the Red Rose', 250000, 8, 0, 0, 0, 0, 597, NULL, 30),
(2928, 0, 0, 0, 'Fibula Village, Bar (Shop)', 100000, 8, 0, 0, 0, 0, 127, NULL, 4),
(2929, 0, 0, 0, 'Fibula Village, Villa', 200000, 8, 0, 0, 0, 0, 397, NULL, 10),
(2930, 0, 0, 0, 'Greenshore Village 1', 80000, 8, 0, 0, 0, 0, 64, NULL, 6),
(2931, 0, 0, 0, 'Greenshore Clanhall', 250000, 8, 0, 0, 0, 0, 312, NULL, 20),
(2932, 0, 0, 0, 'Castle of Greenshore', 250000, 8, 0, 0, 0, 0, 474, NULL, 24),
(2933, 0, 0, 0, 'Greenshore Village, Shop', 80000, 8, 0, 0, 0, 0, 64, NULL, 2),
(2934, 0, 0, 0, 'Greenshore Village, Villa', 300000, 8, 0, 0, 0, 0, 262, NULL, 8),
(2935, 0, 0, 0, 'Greenshore Village 7', 25000, 8, 0, 0, 0, 0, 42, NULL, 2),
(2936, 0, 0, 0, 'Greenshore Village 3', 50000, 8, 0, 0, 0, 0, 55, NULL, 4),
(2939, 0, 0, 0, 'Greenshore Village 2', 50000, 8, 0, 0, 0, 0, 55, NULL, 4),
(2940, 0, 0, 0, 'Greenshore Village 6', 150000, 8, 0, 0, 0, 0, 112, NULL, 4),
(2941, 0, 0, 0, 'Harbour Place 1 (Shop)', 800000, 8, 0, 0, 0, 0, 48, NULL, 2),
(2942, 0, 0, 0, 'Harbour Place 2 (Shop)', 600000, 8, 0, 0, 0, 0, 54, NULL, 2),
(2943, 0, 0, 0, 'Harbour Place 3', 800000, 8, 0, 0, 0, 0, 138, NULL, 2),
(2944, 0, 0, 0, 'Harbour Place 4', 80000, 8, 0, 0, 0, 0, 36, NULL, 2),
(2945, 0, 0, 0, 'Lower Swamp Lane 1', 400000, 8, 0, 0, 0, 0, 156, NULL, 8),
(2946, 0, 0, 0, 'Lower Swamp Lane 3', 400000, 8, 0, 0, 0, 0, 156, NULL, 8),
(2947, 0, 0, 0, 'Main Street 9, 1st floor (Shop)', 200000, 8, 0, 0, 0, 0, 63, NULL, 0),
(2948, 0, 0, 0, 'Main Street 9a, 2nd floor (Shop)', 100000, 8, 0, 0, 0, 0, 30, NULL, 0),
(2949, 0, 0, 0, 'Main Street 9b, 2nd floor (Shop)', 150000, 8, 0, 0, 0, 0, 57, NULL, 0),
(2950, 0, 0, 0, 'Mill Avenue 1 (Shop)', 200000, 8, 0, 0, 0, 0, 54, NULL, 2),
(2951, 0, 0, 0, 'Mill Avenue 2 (Shop)', 200000, 8, 0, 0, 0, 0, 100, NULL, 4),
(2952, 0, 0, 0, 'Mill Avenue 3', 100000, 8, 0, 0, 0, 0, 49, NULL, 4),
(2953, 0, 0, 0, 'Mill Avenue 4', 100000, 8, 0, 0, 0, 0, 49, NULL, 4),
(2954, 0, 0, 0, 'Mill Avenue 5', 300000, 8, 0, 0, 0, 0, 116, NULL, 8),
(2955, 0, 0, 0, 'Open-Air Theatre', 150000, 8, 0, 0, 0, 0, 111, NULL, 2),
(2956, 0, 0, 0, 'Smuggler\'s Den', 400000, 8, 0, 0, 0, 0, 298, NULL, 0),
(2957, 0, 0, 0, 'Sorcerer\'s Avenue 1a', 100000, 8, 0, 0, 0, 0, 42, NULL, 4),
(2958, 0, 0, 0, 'Sorcerer\'s Avenue 5 (Shop)', 150000, 8, 0, 0, 0, 0, 96, NULL, 2),
(2959, 0, 0, 0, 'Sorcerer\'s Avenue 1b', 80000, 8, 0, 0, 0, 0, 30, NULL, 4),
(2960, 0, 0, 0, 'Sorcerer\'s Avenue 1c', 100000, 8, 0, 0, 0, 0, 42, NULL, 4),
(2961, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2a', 50000, 8, 0, 0, 0, 0, 54, NULL, 4),
(2962, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2c', 50000, 8, 0, 0, 0, 0, 48, NULL, 4),
(2963, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2b', 50000, 8, 0, 0, 0, 0, 54, NULL, 4),
(2964, 0, 0, 0, 'Sunset Homes, Flat 01', 100000, 8, 0, 0, 0, 0, 25, NULL, 2),
(2965, 0, 0, 0, 'Sunset Homes, Flat 02', 80000, 8, 0, 0, 0, 0, 30, NULL, 2),
(2966, 0, 0, 0, 'Sunset Homes, Flat 03', 80000, 8, 0, 0, 0, 0, 30, NULL, 2),
(2967, 0, 0, 0, 'Sunset Homes, Flat 11', 80000, 8, 0, 0, 0, 0, 25, NULL, 2),
(2968, 0, 0, 0, 'Sunset Homes, Flat 12', 50000, 8, 0, 0, 0, 0, 26, NULL, 2),
(2969, 0, 0, 0, 'Sunset Homes, Flat 13', 100000, 8, 0, 0, 0, 0, 35, NULL, 4),
(2970, 0, 0, 0, 'Sunset Homes, Flat 14', 50000, 8, 0, 0, 0, 0, 30, NULL, 2),
(2971, 0, 0, 0, 'Sunset Homes, Flat 21', 50000, 8, 0, 0, 0, 0, 25, NULL, 2),
(2972, 0, 0, 0, 'Sunset Homes, Flat 22', 50000, 8, 0, 0, 0, 0, 26, NULL, 2),
(2973, 0, 0, 0, 'Sunset Homes, Flat 23', 80000, 8, 0, 0, 0, 0, 35, NULL, 4),
(2974, 0, 0, 0, 'Sunset Homes, Flat 24', 50000, 8, 0, 0, 0, 0, 30, NULL, 2),
(2975, 0, 0, 0, 'Thais Hostel', 200000, 8, 0, 0, 0, 0, 171, NULL, 48),
(2976, 0, 0, 0, 'The City Wall 1a', 150000, 8, 0, 0, 0, 0, 49, NULL, 4),
(2977, 0, 0, 0, 'The City Wall 1b', 100000, 8, 0, 0, 0, 0, 49, NULL, 4),
(2978, 0, 0, 0, 'The City Wall 3a', 100000, 8, 0, 0, 0, 0, 35, NULL, 4),
(2979, 0, 0, 0, 'The City Wall 3b', 100000, 8, 0, 0, 0, 0, 35, NULL, 4),
(2980, 0, 0, 0, 'The City Wall 3c', 100000, 8, 0, 0, 0, 0, 42, NULL, 4),
(2981, 0, 0, 0, 'The City Wall 3d', 100000, 8, 0, 0, 0, 0, 35, NULL, 4),
(2982, 0, 0, 0, 'The City Wall 3e', 100000, 8, 0, 0, 0, 0, 35, NULL, 4),
(2983, 0, 0, 0, 'The City Wall 3f', 100000, 8, 0, 0, 0, 0, 42, NULL, 4),
(2984, 0, 0, 0, 'Upper Swamp Lane 12', 300000, 8, 0, 0, 0, 0, 124, NULL, 6),
(2985, 0, 0, 0, 'Upper Swamp Lane 10', 150000, 8, 0, 0, 0, 0, 70, NULL, 6),
(2986, 0, 0, 0, 'Upper Swamp Lane 8', 600000, 8, 0, 0, 0, 0, 206, NULL, 6),
(2987, 0, 0, 0, 'Upper Swamp Lane 4', 600000, 8, 0, 0, 0, 0, 176, NULL, 8),
(2988, 0, 0, 0, 'Upper Swamp Lane 2', 600000, 8, 0, 0, 0, 0, 176, NULL, 8),
(2989, 0, 0, 0, 'The City Wall 9', 80000, 8, 0, 0, 0, 0, 50, NULL, 4),
(2990, 0, 0, 0, 'The City Wall 7h', 50000, 8, 0, 0, 0, 0, 30, NULL, 2),
(2991, 0, 0, 0, 'The City Wall 7b', 25000, 8, 0, 0, 0, 0, 30, NULL, 2),
(2992, 0, 0, 0, 'The City Wall 7d', 50000, 8, 0, 0, 0, 0, 36, NULL, 4),
(2993, 0, 0, 0, 'The City Wall 7f', 80000, 8, 0, 0, 0, 0, 36, NULL, 4),
(2994, 0, 0, 0, 'The City Wall 7c', 80000, 8, 0, 0, 0, 0, 36, NULL, 4),
(2995, 0, 0, 0, 'The City Wall 7a', 80000, 8, 0, 0, 0, 0, 30, NULL, 2),
(2996, 0, 0, 0, 'The City Wall 7g', 50000, 8, 0, 0, 0, 0, 30, NULL, 2),
(2997, 0, 0, 0, 'The City Wall 7e', 80000, 8, 0, 0, 0, 0, 36, NULL, 4),
(2998, 0, 0, 0, 'The City Wall 5b', 50000, 8, 0, 0, 0, 0, 24, NULL, 2),
(2999, 0, 0, 0, 'The City Wall 5d', 50000, 8, 0, 0, 0, 0, 24, NULL, 2),
(3000, 0, 0, 0, 'The City Wall 5f', 25000, 8, 0, 0, 0, 0, 30, NULL, 2),
(3001, 0, 0, 0, 'The City Wall 5a', 50000, 8, 0, 0, 0, 0, 24, NULL, 2),
(3002, 0, 0, 0, 'The City Wall 5c', 50000, 8, 0, 0, 0, 0, 24, NULL, 2),
(3003, 0, 0, 0, 'The City Wall 5e', 50000, 8, 0, 0, 0, 0, 30, NULL, 2),
(3004, 6, 0, 0, 'Warriors\' Guildhall', 5000000, 8, 0, 0, 0, 0, 535, NULL, 22),
(3005, 0, 0, 0, 'The Tibianic', 500000, 8, 0, 0, 0, 0, 824, NULL, 44),
(3006, 0, 0, 0, 'Bloodhall', 500000, 8, 0, 0, 0, 0, 539, NULL, 30),
(3007, 0, 0, 0, 'Fibula Clanhall', 250000, 8, 0, 0, 0, 0, 305, NULL, 20),
(3008, 0, 0, 0, 'Dark Mansion', 1000000, 8, 0, 0, 0, 0, 590, NULL, 34),
(3009, 0, 0, 0, 'Halls of the Adventurers', 250000, 8, 0, 0, 0, 0, 512, NULL, 36),
(3010, 0, 0, 0, 'Mercenary Tower', 250000, 8, 0, 0, 0, 0, 982, NULL, 52),
(3011, 0, 0, 0, 'Snake Tower', 500000, 8, 0, 0, 0, 0, 1041, NULL, 42),
(3012, 0, 0, 0, 'Southern Thais Guildhall', 1000000, 8, 0, 0, 0, 0, 635, NULL, 32),
(3013, 0, 0, 0, 'Spiritkeep', 500000, 8, 0, 0, 0, 0, 564, NULL, 26),
(3014, 0, 0, 0, 'Thais Clanhall', 500000, 8, 0, 0, 0, 0, 380, NULL, 20),
(3015, 0, 0, 0, 'The Lair', 200000, 9, 0, 0, 0, 0, 335, NULL, 6),
(3016, 0, 0, 0, 'Silver Street 4', 300000, 9, 0, 0, 0, 0, 153, NULL, 4),
(3017, 0, 0, 0, 'Dream Street 1 (Shop)', 600000, 9, 0, 0, 0, 0, 178, NULL, 4),
(3018, 0, 0, 0, 'Dagger Alley 1', 200000, 9, 0, 0, 0, 0, 126, NULL, 4),
(3019, 0, 0, 0, 'Dream Street 2', 400000, 9, 0, 0, 0, 0, 138, NULL, 4),
(3020, 0, 0, 0, 'Dream Street 3', 300000, 9, 0, 0, 0, 0, 126, NULL, 4),
(3021, 0, 0, 0, 'Elm Street 1', 300000, 9, 0, 0, 0, 0, 114, NULL, 4),
(3022, 0, 0, 0, 'Elm Street 3', 300000, 9, 0, 0, 0, 0, 120, NULL, 6),
(3023, 0, 0, 0, 'Elm Street 2', 300000, 9, 0, 0, 0, 0, 120, NULL, 4),
(3024, 0, 0, 0, 'Elm Street 4', 300000, 9, 0, 0, 0, 0, 126, NULL, 4),
(3025, 0, 0, 0, 'Seagull Walk 1', 800000, 9, 0, 0, 0, 0, 202, NULL, 4),
(3026, 0, 0, 0, 'Seagull Walk 2', 300000, 9, 0, 0, 0, 0, 132, NULL, 6),
(3027, 0, 0, 0, 'Dream Street 4', 400000, 9, 0, 0, 0, 0, 168, NULL, 8),
(3028, 0, 0, 0, 'Old Lighthouse', 200000, 9, 0, 0, 0, 0, 177, NULL, 4),
(3029, 0, 0, 0, 'Market Street 1', 600000, 9, 0, 0, 0, 0, 258, NULL, 6),
(3030, 0, 0, 0, 'Market Street 3', 600000, 9, 0, 0, 0, 0, 150, NULL, 4),
(3031, 0, 0, 0, 'Market Street 4 (Shop)', 800000, 9, 0, 0, 0, 0, 209, NULL, 6),
(3032, 0, 0, 0, 'Market Street 5 (Shop)', 800000, 9, 0, 0, 0, 0, 243, NULL, 8),
(3033, 0, 0, 0, 'Market Street 2', 600000, 9, 0, 0, 0, 0, 200, NULL, 6),
(3034, 0, 0, 0, 'Loot Lane 1 (Shop)', 600000, 9, 0, 0, 0, 0, 198, NULL, 6),
(3035, 0, 0, 0, 'Mystic Lane 1', 300000, 9, 0, 0, 0, 0, 110, NULL, 6),
(3036, 0, 0, 0, 'Mystic Lane 2', 200000, 9, 0, 0, 0, 0, 139, NULL, 4),
(3037, 0, 0, 0, 'Lucky Lane 2 (Tower)', 600000, 9, 0, 0, 0, 0, 240, NULL, 4),
(3038, 0, 0, 0, 'Apartement 1', 0, 1, 0, 0, 0, 0, 15, NULL, 2),
(3039, 0, 0, 0, 'Apartement 2', 0, 1, 0, 0, 0, 0, 15, NULL, 2),
(3040, 0, 0, 0, 'Apartement 3', 0, 1, 0, 0, 0, 0, 15, NULL, 2),
(3041, 0, 0, 0, 'Apartement 4', 0, 1, 0, 0, 0, 0, 18, NULL, 2),
(3042, 0, 0, 0, 'Apartement 5', 0, 1, 0, 0, 0, 0, 15, NULL, 2),
(3043, 0, 0, 0, 'Apartement 6', 0, 1, 0, 0, 0, 0, 20, NULL, 2),
(3044, 0, 0, 0, 'Apartement 7', 0, 1, 0, 0, 0, 0, 18, NULL, 2),
(3045, 0, 0, 0, 'Apartement 8', 0, 1, 0, 0, 0, 0, 15, NULL, 2),
(3046, 0, 0, 0, 'Apartement 9', 0, 1, 0, 0, 0, 0, 15, NULL, 2),
(3047, 0, 0, 0, 'Apartement 10', 0, 1, 0, 0, 0, 0, 16, NULL, 2),
(3048, 0, 0, 0, 'Apartement 11', 0, 1, 0, 0, 0, 0, 20, NULL, 2),
(3049, 0, 0, 0, 'Apartement 12', 0, 1, 0, 0, 0, 0, 20, NULL, 2),
(3050, 0, 0, 0, 'Mordragor Street 7', 0, 1, 0, 0, 0, 0, 138, NULL, 4),
(3051, 0, 0, 0, 'Mordragor Street 8', 0, 1, 0, 0, 0, 0, 138, NULL, 4),
(3052, 0, 0, 0, 'Melenthil House 1', 0, 1, 0, 0, 0, 0, 56, NULL, 4),
(3053, 0, 0, 0, 'Melenthil House 2', 0, 1, 0, 0, 0, 0, 56, NULL, 4),
(3054, 0, 0, 0, 'Melenthil House 3', 0, 1, 0, 0, 0, 0, 64, NULL, 4),
(3055, 0, 0, 0, 'Melenthil House 4', 0, 1, 0, 0, 0, 0, 56, NULL, 4),
(3056, 0, 0, 0, 'Melenthil House 5', 0, 1, 0, 0, 0, 0, 49, NULL, 4),
(3057, 0, 0, 0, 'Melenthil House 6', 0, 1, 0, 0, 0, 0, 56, NULL, 6),
(3058, 0, 0, 0, 'Melenthil House 7', 0, 1, 0, 0, 0, 0, 81, NULL, 4),
(3059, 0, 0, 0, 'Melenthil House 8', 0, 1, 0, 0, 0, 0, 54, NULL, 4),
(3060, 0, 0, 0, 'Melenthil House 9', 0, 1, 0, 0, 0, 0, 110, NULL, 4),
(3061, 0, 0, 0, 'Melenthil House 10', 0, 1, 0, 0, 0, 0, 39, NULL, 4),
(3062, 0, 0, 0, 'Melenthil House 11', 0, 1, 0, 0, 0, 0, 45, NULL, 4),
(3063, 0, 0, 0, 'Melenthil House 12', 0, 1, 0, 0, 0, 0, 35, NULL, 4),
(3064, 0, 0, 0, 'Melenthil House 13', 0, 1, 0, 0, 0, 0, 35, NULL, 4),
(3065, 0, 0, 0, 'Mordragor Castle', 0, 1, 0, 0, 0, 0, 635, NULL, 4),
(3066, 0, 0, 0, 'Paupers Palace, Flat 21', 25000, 9, 0, 0, 0, 0, 20, NULL, 2),
(3067, 0, 0, 0, 'Feraflen House', 0, 2, 0, 0, 0, 0, 163, NULL, 0),
(3068, 0, 0, 0, 'Feraflen House 2', 0, 2, 0, 0, 0, 0, 71, NULL, 0),
(3069, 0, 0, 0, 'Feraflen House 3', 0, 2, 0, 0, 0, 0, 121, NULL, 0),
(3070, 0, 0, 0, 'Feraflen House 4', 0, 2, 0, 0, 0, 0, 189, NULL, 0),
(3071, 0, 0, 0, 'Feraflen House 5', 0, 2, 0, 0, 0, 0, 154, NULL, 0),
(3072, 0, 0, 0, 'Feraflen Mansion', 0, 2, 0, 0, 0, 0, 889, NULL, 0),
(3073, 0, 0, 0, 'Feraflen House 6', 0, 2, 0, 0, 0, 0, 111, NULL, 0),
(3074, 0, 0, 0, 'Feraflen Tower', 0, 2, 0, 0, 0, 0, 215, NULL, 8),
(3075, 0, 0, 0, 'Feraflen House 7', 0, 2, 0, 0, 0, 0, 35, NULL, 0),
(3076, 0, 0, 0, 'Feraflen House 8', 0, 2, 0, 0, 0, 0, 20, NULL, 2),
(3077, 0, 0, 0, 'Feraflen House 9', 0, 2, 0, 0, 0, 0, 36, NULL, 2),
(3078, 0, 0, 0, 'Feraflen House 10', 0, 2, 0, 0, 0, 0, 36, NULL, 2),
(3079, 0, 0, 0, 'Feraflen House 11', 0, 2, 0, 0, 0, 0, 54, NULL, 2),
(3080, 0, 0, 0, 'Paupers Palace, Flat 04', 25000, 9, 0, 0, 0, 0, 25, NULL, 2),
(3081, 0, 0, 0, 'Feraflen Forest Mansion', 0, 2, 0, 0, 0, 0, 980, NULL, 22),
(3082, 0, 0, 0, 'Dolwatha Flats', 0, 3, 0, 0, 0, 0, 35, NULL, 0),
(3083, 0, 0, 0, 'Dolwatha House', 0, 3, 0, 0, 0, 0, 137, NULL, 0),
(3084, 0, 0, 0, 'Dolwatha Flats 2', 0, 3, 0, 0, 0, 0, 27, NULL, 0),
(3085, 0, 0, 0, 'Dolwatha Flats 3', 0, 3, 0, 0, 0, 0, 22, NULL, 0),
(3086, 0, 0, 0, 'Dolwatha Flats 4', 0, 3, 0, 0, 0, 0, 46, NULL, 0),
(3087, 0, 0, 0, 'Dolwatha Flats 5', 0, 3, 0, 0, 0, 0, 102, NULL, 0),
(3088, 0, 0, 0, 'Dolwatha Flats 6', 0, 3, 0, 0, 0, 0, 33, NULL, 0),
(3089, 0, 0, 0, 'Dolwatha Flats 7', 0, 3, 0, 0, 0, 0, 44, NULL, 0),
(3090, 0, 0, 0, 'Dolwatha Flats 8', 0, 3, 0, 0, 0, 0, 35, NULL, 0),
(3091, 0, 0, 0, 'Dolwatha House 2', 0, 3, 0, 0, 0, 0, 123, NULL, 0),
(3092, 0, 0, 0, 'Dolwatha Mansion', 0, 3, 0, 0, 0, 0, 169, NULL, 0),
(3093, 0, 0, 0, 'Dolwatha House 3', 0, 3, 0, 0, 0, 0, 122, NULL, 0),
(3094, 0, 0, 0, 'Dolwatha House 4', 0, 3, 0, 0, 0, 0, 172, NULL, 0),
(3095, 0, 0, 0, 'Dolwatha Flats 9', 0, 3, 0, 0, 0, 0, 49, NULL, 0),
(3096, 0, 0, 0, 'Dolwatha Flats 10', 0, 3, 0, 0, 0, 0, 115, NULL, 0),
(3097, 0, 0, 0, 'Dolwatha Flats 11', 0, 3, 0, 0, 0, 0, 40, NULL, 0),
(3098, 0, 0, 0, 'Dolwatha Mansion 2', 0, 3, 0, 0, 0, 0, 212, NULL, 0),
(3099, 0, 0, 0, 'Castle, 4th Floor, Flat 05', 80000, 11, 0, 0, 0, 0, 30, NULL, 2),
(3100, 0, 0, 0, 'Dolwatha Flats 12', 0, 3, 0, 0, 0, 0, 30, NULL, 0),
(3101, 0, 0, 0, 'Dolwatha Flats 13', 0, 3, 0, 0, 0, 0, 80, NULL, 0),
(3102, 0, 0, 0, 'Dolwatha Flats 14', 0, 3, 0, 0, 0, 0, 84, NULL, 0),
(3103, 0, 0, 0, 'Castle Street 3', 150000, 11, 0, 0, 0, 0, 64, NULL, 4),
(3104, 0, 0, 0, 'Dolwatha Mansion 3', 0, 3, 0, 0, 0, 0, 119, NULL, 0),
(3105, 0, 0, 0, 'Dolwatha Flats 15', 0, 3, 0, 0, 0, 0, 34, NULL, 0),
(3106, 0, 0, 0, 'Dolwatha Flats 16', 0, 3, 0, 0, 0, 0, 101, NULL, 0),
(3107, 0, 0, 0, 'Dolwatha Flats 17', 0, 3, 0, 0, 0, 0, 75, NULL, 0),
(3108, 0, 0, 0, 'Dolwatha Flats 18', 0, 3, 0, 0, 0, 0, 106, NULL, 0),
(3109, 0, 0, 0, 'Dolwatha Flats 19', 0, 3, 0, 0, 0, 0, 33, NULL, 0),
(3110, 0, 0, 0, 'Dolwatha Flats 20', 0, 3, 0, 0, 0, 0, 71, NULL, 0),
(3111, 0, 0, 0, 'Dolwatha House 5', 0, 3, 0, 0, 0, 0, 145, NULL, 0),
(3112, 0, 0, 0, 'Dolwatha Flats 21', 0, 3, 0, 0, 0, 0, 83, NULL, 0),
(3113, 0, 0, 0, 'Dolwatha Flats 22', 0, 3, 0, 0, 0, 0, 71, NULL, 0),
(3114, 0, 0, 0, 'Edron Flats, Flat 02', 100000, 11, 0, 0, 0, 0, 40, NULL, 4),
(3115, 0, 0, 0, 'Boat House', 0, 1, 0, 0, 0, 0, 128, NULL, 2),
(3116, 0, 0, 0, 'Boat House 2', 0, 1, 0, 0, 0, 0, 74, NULL, 2),
(3118, 0, 0, 0, 'Boat Mansion', 0, 1, 0, 0, 0, 0, 222, NULL, 8),
(3119, 0, 0, 0, 'Edron Flats, Flat 13', 80000, 11, 0, 0, 0, 0, 45, NULL, 4),
(3120, 0, 0, 0, 'Mordragor Street 10', 0, 1, 0, 0, 0, 0, 162, NULL, 4),
(3121, 0, 0, 0, 'Mordragor Street 9', 0, 1, 0, 0, 0, 0, 76, NULL, 2),
(3122, 0, 0, 0, 'Dolwatha Flats 23', 0, 3, 0, 0, 0, 0, 28, NULL, 0),
(3123, 0, 0, 0, 'Mordragor House', 0, 1, 0, 0, 0, 0, 153, NULL, 8),
(3124, 0, 0, 0, 'Mordragor House 2', 0, 1, 0, 0, 0, 0, 64, NULL, 2),
(3125, 0, 0, 0, 'Mordragor House 3', 0, 1, 0, 0, 0, 0, 149, NULL, 4),
(3126, 0, 0, 0, 'Mordragor Quai 1', 0, 1, 0, 0, 0, 0, 45, NULL, 2),
(3127, 0, 0, 0, 'Mordragor Quai 2', 0, 1, 0, 0, 0, 0, 47, NULL, 2),
(3128, 0, 0, 0, 'Mordragor Quai 3', 0, 1, 0, 0, 0, 0, 52, NULL, 2),
(3129, 0, 0, 0, 'Mordragor Quai 4', 0, 1, 0, 0, 0, 0, 39, NULL, 2),
(3130, 0, 0, 0, 'Mordragor Quai 5', 0, 1, 0, 0, 0, 0, 65, NULL, 2),
(3131, 0, 0, 0, 'Mordragor Quai 6', 0, 1, 0, 0, 0, 0, 41, NULL, 2),
(3132, 0, 0, 0, 'Mordragor Quai 7', 0, 1, 0, 0, 0, 0, 20, NULL, 2),
(3133, 0, 0, 0, 'Mordragor Quai 8', 0, 1, 0, 0, 0, 0, 36, NULL, 0),
(3134, 0, 0, 0, 'Mordragor Quai 9', 0, 1, 0, 0, 0, 0, 47, NULL, 0),
(3135, 0, 0, 0, 'Mordragor House 4', 0, 1, 0, 0, 0, 0, 117, NULL, 4),
(3136, 0, 0, 0, 'Mordragor House 5', 0, 1, 0, 0, 0, 0, 109, NULL, 4),
(3137, 0, 0, 0, 'Mistfall House', 0, 4, 0, 0, 0, 0, 23, NULL, 2),
(3138, 0, 0, 0, 'Mistfall House 2', 0, 4, 0, 0, 0, 0, 24, NULL, 0),
(3139, 0, 0, 0, 'Mistfall House 3', 0, 4, 0, 0, 0, 0, 17, NULL, 2),
(3140, 0, 0, 0, 'Mistfall House 4', 0, 4, 0, 0, 0, 0, 25, NULL, 4),
(3141, 0, 0, 0, 'Mistfall House 5', 0, 4, 0, 0, 0, 0, 30, NULL, 4),
(3142, 0, 0, 0, 'Mistfall House 6', 0, 4, 0, 0, 0, 0, 24, NULL, 2),
(3143, 0, 0, 0, 'Mistfall House 7', 0, 4, 0, 0, 0, 0, 33, NULL, 4),
(3144, 0, 0, 0, 'Mistfall House 8', 0, 4, 0, 0, 0, 0, 23, NULL, 2),
(3145, 0, 0, 0, 'Mistfall House 9', 0, 4, 0, 0, 0, 0, 72, NULL, 8),
(3146, 0, 0, 0, 'Mistfall House 10', 0, 4, 0, 0, 0, 0, 48, NULL, 6),
(3147, 0, 0, 0, 'Mistfall House 11', 0, 4, 0, 0, 0, 0, 33, NULL, 4),
(3148, 0, 0, 0, 'Sky Lane, Guild 3', 1000000, 11, 0, 0, 0, 0, 507, NULL, 36),
(3149, 0, 0, 0, 'Sky Lane, Guild 2', 1000000, 11, 0, 0, 0, 0, 653, NULL, 28),
(3150, 0, 0, 0, 'Wood Avenue 11', 600000, 11, 0, 0, 0, 0, 245, NULL, 12),
(3151, 0, 0, 0, 'Wood Avenue 8', 800000, 11, 0, 0, 0, 0, 218, NULL, 6),
(3152, 0, 0, 0, 'Wood Avenue 7', 800000, 11, 0, 0, 0, 0, 232, NULL, 6),
(3153, 0, 0, 0, 'Wood Avenue 10a', 200000, 11, 0, 0, 0, 0, 56, NULL, 4),
(3154, 0, 0, 0, 'Wood Avenue 9a', 200000, 11, 0, 0, 0, 0, 56, NULL, 4),
(3155, 0, 0, 0, 'Wood Avenue 6a', 300000, 11, 0, 0, 0, 0, 64, NULL, 4),
(3156, 0, 0, 0, 'Wood Avenue 6b', 200000, 11, 0, 0, 0, 0, 56, NULL, 4),
(3157, 0, 0, 0, 'Wood Avenue 9b', 200000, 11, 0, 0, 0, 0, 56, NULL, 4),
(3158, 0, 0, 0, 'Wood Avenue 10b', 200000, 11, 0, 0, 0, 0, 64, NULL, 6),
(3159, 0, 0, 0, 'Stronghold', 800000, 11, 0, 0, 0, 0, 285, NULL, 0),
(3160, 0, 0, 0, 'Wood Avenue 5', 300000, 11, 0, 0, 0, 0, 64, NULL, 4),
(3161, 0, 0, 0, 'Wood Avenue 3', 200000, 11, 0, 0, 0, 0, 52, NULL, 4),
(3162, 0, 0, 0, 'Wood Avenue 4', 200000, 11, 0, 0, 0, 0, 60, NULL, 4),
(3163, 0, 0, 0, 'Wood Avenue 2', 200000, 11, 0, 0, 0, 0, 64, NULL, 4),
(3164, 0, 0, 0, 'Wood Avenue 1', 200000, 11, 0, 0, 0, 0, 64, NULL, 4),
(3165, 0, 0, 0, 'Wood Avenue 4c', 200000, 11, 0, 0, 0, 0, 57, NULL, 4),
(3166, 0, 0, 0, 'Wood Avenue 4a', 150000, 11, 0, 0, 0, 0, 56, NULL, 4),
(3167, 0, 0, 0, 'Wood Avenue 4b', 150000, 11, 0, 0, 0, 0, 56, NULL, 4),
(3168, 0, 0, 0, 'Stonehome Village 1', 150000, 11, 0, 0, 0, 0, 77, NULL, 4),
(3169, 0, 0, 0, 'Stonehome Flats, Flat 04', 80000, 11, 0, 0, 0, 0, 45, NULL, 4),
(3170, 0, 0, 0, 'Freewind House ', 0, 5, 0, 0, 0, 0, 80, NULL, 6),
(3171, 0, 0, 0, 'Freewind House 2', 0, 5, 0, 0, 0, 0, 70, NULL, 4),
(3172, 0, 0, 0, 'Freewind House 3', 0, 5, 0, 0, 0, 0, 54, NULL, 6),
(3173, 0, 0, 0, 'Freewind House 4', 0, 5, 0, 0, 0, 0, 84, NULL, 6),
(3174, 0, 0, 0, 'Freewind House 5', 0, 5, 0, 0, 0, 0, 68, NULL, 4),
(3175, 0, 0, 0, 'Freewind House 6', 0, 5, 0, 0, 0, 0, 81, NULL, 6),
(3176, 0, 0, 0, 'Freewind House 7', 0, 5, 0, 0, 0, 0, 165, NULL, 8),
(3177, 0, 0, 0, 'Freewind House 8', 0, 5, 0, 0, 0, 0, 127, NULL, 8),
(3178, 0, 0, 0, 'Freewind House 9', 0, 5, 0, 0, 0, 0, 100, NULL, 8),
(3179, 0, 0, 0, 'Freewind House 10', 0, 5, 0, 0, 0, 0, 96, NULL, 8),
(3180, 0, 0, 0, 'Freewind House 11', 0, 5, 0, 0, 0, 0, 168, NULL, 8),
(3181, 0, 0, 0, 'Mordragor Street 3', 0, 1, 0, 0, 0, 0, 61, NULL, 2),
(3182, 0, 0, 0, 'Mordragor Street 4', 0, 1, 0, 0, 0, 0, 54, NULL, 2),
(3183, 0, 0, 0, 'Mordragor Street 5', 0, 1, 0, 0, 0, 0, 63, NULL, 2),
(3184, 0, 0, 0, 'Mordragor Street 6', 0, 1, 0, 0, 0, 0, 54, NULL, 2),
(3185, 0, 0, 0, 'Mordragor Forest House', 0, 1, 0, 0, 0, 0, 15, NULL, 2),
(3186, 0, 0, 0, 'Stonehome Village 7', 100000, 11, 0, 0, 0, 0, 49, NULL, 4),
(3187, 0, 0, 0, 'Stonehome Village 8', 25000, 11, 0, 0, 0, 0, 36, NULL, 2),
(3188, 0, 0, 0, 'Stonehome Village 9', 50000, 11, 0, 0, 0, 0, 36, NULL, 2),
(3189, 0, 0, 0, 'Stonehome Clanhall', 250000, 11, 0, 0, 0, 0, 364, NULL, 18),
(3190, 0, 0, 0, 'Mad Scientist\'s Lab', 600000, 17, 0, 0, 0, 0, 115, NULL, 0),
(3191, 0, 0, 0, 'Radiant Plaza 4', 800000, 17, 0, 0, 0, 0, 361, NULL, 6),
(3192, 0, 0, 0, 'Radiant Plaza 3', 800000, 17, 0, 0, 0, 0, 245, NULL, 4),
(3193, 0, 0, 0, 'Radiant Plaza 2', 600000, 17, 0, 0, 0, 0, 153, NULL, 4),
(3194, 0, 0, 0, 'Radiant Plaza 1', 800000, 17, 0, 0, 0, 0, 257, NULL, 8),
(3195, 0, 0, 0, 'Aureate Court 3', 400000, 17, 0, 0, 0, 0, 226, NULL, 4),
(3196, 0, 0, 0, 'Aureate Court 4', 400000, 17, 0, 0, 0, 0, 185, NULL, 8),
(3197, 0, 0, 0, 'Aureate Court 5', 600000, 17, 0, 0, 0, 0, 201, NULL, 0),
(3198, 0, 0, 0, 'Aureate Court 2', 400000, 17, 0, 0, 0, 0, 176, NULL, 4),
(3199, 0, 0, 0, 'Aureate Court 1', 600000, 17, 0, 0, 0, 0, 264, NULL, 6),
(3205, 0, 0, 0, 'Halls of Serenity', 5000000, 17, 0, 0, 0, 0, 1026, NULL, 66),
(3206, 0, 0, 0, 'Fortune Wing 3', 600000, 17, 0, 0, 0, 0, 235, NULL, 4),
(3207, 0, 0, 0, 'Fortune Wing 4', 600000, 17, 0, 0, 0, 0, 252, NULL, 8),
(3208, 0, 0, 0, 'Fortune Wing 2', 600000, 17, 0, 0, 0, 0, 260, NULL, 4),
(3209, 0, 0, 0, 'Fortune Wing 1', 800000, 17, 0, 0, 0, 0, 400, NULL, 8),
(3211, 0, 0, 0, 'Cascade Towers', 5000000, 17, 0, 0, 0, 0, 739, NULL, 66),
(3212, 0, 0, 0, 'Luminous Arc 5', 800000, 17, 0, 0, 0, 0, 196, NULL, 0),
(3213, 0, 0, 0, 'Luminous Arc 2', 600000, 17, 0, 0, 0, 0, 298, NULL, 8),
(3214, 0, 0, 0, 'Luminous Arc 1', 800000, 17, 0, 0, 0, 0, 341, NULL, 4),
(3215, 0, 0, 0, 'Luminous Arc 3', 600000, 17, 0, 0, 0, 0, 228, NULL, 6),
(3216, 0, 0, 0, 'Luminous Arc 4', 800000, 17, 0, 0, 0, 0, 326, NULL, 10),
(3217, 0, 0, 0, 'Harbour Promenade 1', 800000, 17, 0, 0, 0, 0, 205, NULL, 0),
(3218, 0, 0, 0, 'Sun Palace', 5000000, 17, 0, 0, 0, 0, 926, NULL, 54),
(3219, 0, 0, 0, 'Haggler\'s Hangout 3', 300000, 15, 0, 0, 0, 0, 241, NULL, 8),
(3220, 0, 0, 0, 'Haggler\'s Hangout 7', 400000, 15, 0, 0, 0, 0, 240, NULL, 0),
(3221, 0, 0, 0, 'Big Game Hunter\'s Lodge', 600000, 15, 0, 0, 0, 0, 257, NULL, 0),
(3222, 0, 0, 0, 'Haggler\'s Hangout 6', 400000, 15, 0, 0, 0, 0, 188, NULL, 8),
(3223, 0, 0, 0, 'Haggler\'s Hangout 5 (Shop)', 200000, 15, 0, 0, 0, 0, 56, NULL, 2),
(3224, 0, 0, 0, 'Haggler\'s Hangout 4b (Shop)', 150000, 15, 0, 0, 0, 0, 48, NULL, 2),
(3225, 0, 0, 0, 'Haggler\'s Hangout 4a (Shop)', 200000, 15, 0, 0, 0, 0, 64, NULL, 2),
(3226, 0, 0, 0, 'Haggler\'s Hangout 2', 100000, 15, 0, 0, 0, 0, 49, NULL, 2),
(3227, 0, 0, 0, 'Haggler\'s Hangout 1', 100000, 15, 0, 0, 0, 0, 49, NULL, 4),
(3228, 0, 0, 0, 'Bamboo Garden 3', 150000, 15, 0, 0, 0, 0, 63, NULL, 4),
(3229, 0, 0, 0, 'Bamboo Fortress', 500000, 15, 0, 0, 0, 0, 762, NULL, 40),
(3230, 0, 0, 0, 'Bamboo Garden 2', 80000, 15, 0, 0, 0, 0, 42, NULL, 4),
(3231, 0, 0, 0, 'Bamboo Garden 1', 100000, 15, 0, 0, 0, 0, 63, NULL, 6),
(3232, 0, 0, 0, 'Banana Bay 4', 25000, 15, 0, 0, 0, 0, 25, NULL, 2),
(3233, 0, 0, 0, 'Banana Bay 2', 50000, 15, 0, 0, 0, 0, 36, NULL, 2),
(3234, 0, 0, 0, 'Banana Bay 3', 50000, 15, 0, 0, 0, 0, 25, NULL, 2),
(3235, 0, 0, 0, 'Banana Bay 1', 25000, 15, 0, 0, 0, 0, 25, NULL, 2),
(3236, 0, 0, 0, 'Crocodile Bridge 1', 80000, 15, 0, 0, 0, 0, 42, NULL, 4),
(3237, 0, 0, 0, 'Crocodile Bridge 2', 80000, 15, 0, 0, 0, 0, 36, NULL, 4),
(3238, 0, 0, 0, 'Crocodile Bridge 3', 100000, 15, 0, 0, 0, 0, 49, NULL, 4),
(3239, 0, 0, 0, 'Crocodile Bridge 4', 300000, 15, 0, 0, 0, 0, 158, NULL, 8),
(3240, 0, 0, 0, 'Crocodile Bridge 5', 200000, 15, 0, 0, 0, 0, 137, NULL, 4),
(3241, 0, 0, 0, 'Woodway 1', 80000, 15, 0, 0, 0, 0, 25, NULL, 2),
(3242, 0, 0, 0, 'Woodway 2', 50000, 15, 0, 0, 0, 0, 20, NULL, 2),
(3243, 0, 0, 0, 'Woodway 3', 150000, 15, 0, 0, 0, 0, 65, NULL, 4),
(3244, 0, 0, 0, 'Woodway 4', 25000, 15, 0, 0, 0, 0, 24, NULL, 2),
(3245, 0, 0, 0, 'Flamingo Flats 5', 150000, 15, 0, 0, 0, 0, 72, NULL, 2),
(3246, 0, 0, 0, 'Flamingo Flats 4', 80000, 15, 0, 0, 0, 0, 36, NULL, 4),
(3247, 0, 0, 0, 'Flamingo Flats 1', 50000, 15, 0, 0, 0, 0, 30, NULL, 4),
(3248, 0, 0, 0, 'Flamingo Flats 2', 80000, 15, 0, 0, 0, 0, 42, NULL, 4),
(3249, 0, 0, 0, 'Flamingo Flats 3', 50000, 15, 0, 0, 0, 0, 30, NULL, 4),
(3250, 0, 0, 0, 'Jungle Edge 1', 200000, 15, 0, 0, 0, 0, 85, NULL, 6),
(3251, 0, 0, 0, 'Jungle Edge 2', 200000, 15, 0, 0, 0, 0, 128, NULL, 6),
(3252, 0, 0, 0, 'Jungle Edge 4', 80000, 15, 0, 0, 0, 0, 36, NULL, 4),
(3253, 0, 0, 0, 'Jungle Edge 5', 80000, 15, 0, 0, 0, 0, 36, NULL, 4),
(3254, 0, 0, 0, 'Jungle Edge 6', 25000, 15, 0, 0, 0, 0, 25, NULL, 2),
(3255, 0, 0, 0, 'Jungle Edge 3', 80000, 15, 0, 0, 0, 0, 36, NULL, 4),
(3256, 0, 0, 0, 'River Homes 3', 200000, 15, 0, 0, 0, 0, 140, NULL, 14),
(3257, 0, 0, 0, 'River Homes 2b', 150000, 15, 0, 0, 0, 0, 49, NULL, 6),
(3258, 0, 0, 0, 'River Homes 2a', 100000, 15, 0, 0, 0, 0, 49, NULL, 4),
(3259, 0, 0, 0, 'River Homes 1', 300000, 15, 0, 0, 0, 0, 128, NULL, 6),
(3260, 0, 0, 0, 'Coconut Quay 4', 150000, 15, 0, 0, 0, 0, 72, NULL, 6),
(3261, 0, 0, 0, 'Coconut Quay 3', 200000, 15, 0, 0, 0, 0, 70, NULL, 8),
(3262, 0, 0, 0, 'Coconut Quay 2', 100000, 15, 0, 0, 0, 0, 42, NULL, 4),
(3263, 0, 0, 0, 'Coconut Quay 1', 150000, 15, 0, 0, 0, 0, 64, NULL, 4),
(3264, 0, 0, 0, 'Shark Manor', 250000, 15, 0, 0, 0, 0, 240, NULL, 30),
(3265, 0, 0, 0, 'Glacier Side 2', 300000, 16, 0, 0, 0, 0, 154, NULL, 6),
(3266, 0, 0, 0, 'Glacier Side 1', 150000, 16, 0, 0, 0, 0, 65, NULL, 4),
(3267, 0, 0, 0, 'Glacier Side 3', 150000, 16, 0, 0, 0, 0, 75, NULL, 4),
(3268, 0, 0, 0, 'Glacier Side 4', 150000, 16, 0, 0, 0, 0, 70, NULL, 2),
(3269, 0, 0, 0, 'Shelf Site', 300000, 16, 0, 0, 0, 0, 145, NULL, 6),
(3270, 0, 0, 0, 'Spirit Homes 5', 150000, 16, 0, 0, 0, 0, 56, NULL, 4),
(3271, 0, 0, 0, 'Spirit Homes 4', 80000, 16, 0, 0, 0, 0, 49, NULL, 2),
(3272, 0, 0, 0, 'Spirit Homes 1', 150000, 16, 0, 0, 0, 0, 56, NULL, 4),
(3273, 0, 0, 0, 'Spirit Homes 2', 150000, 16, 0, 0, 0, 0, 72, NULL, 4),
(3274, 0, 0, 0, 'Spirit Homes 3', 300000, 16, 0, 0, 0, 0, 128, NULL, 6),
(3275, 0, 0, 0, 'Arena Walk 3', 300000, 16, 0, 0, 0, 0, 126, NULL, 6),
(3276, 0, 0, 0, 'Arena Walk 2', 150000, 16, 0, 0, 0, 0, 54, NULL, 4),
(3277, 0, 0, 0, 'Arena Walk 1', 300000, 16, 0, 0, 0, 0, 128, NULL, 6),
(3278, 0, 0, 0, 'Bears Paw 2', 300000, 16, 0, 0, 0, 0, 98, NULL, 4),
(3279, 0, 0, 0, 'Bears Paw 1', 200000, 16, 0, 0, 0, 0, 72, NULL, 4),
(3280, 0, 0, 0, 'Crystal Glance', 1000000, 16, 0, 0, 0, 0, 550, NULL, 48),
(3281, 0, 0, 0, 'Shady Rocks 2', 200000, 16, 0, 0, 0, 0, 77, NULL, 8),
(3282, 0, 0, 0, 'Shady Rocks 1', 300000, 16, 0, 0, 0, 0, 116, NULL, 8),
(3283, 0, 0, 0, 'Shady Rocks 3', 300000, 16, 0, 0, 0, 0, 137, NULL, 6),
(3284, 0, 0, 0, 'Shady Rocks 4 (Shop)', 200000, 16, 0, 0, 0, 0, 95, NULL, 4),
(3285, 0, 0, 0, 'Shady Rocks 5', 300000, 16, 0, 0, 0, 0, 110, NULL, 4),
(3286, 0, 0, 0, 'Tusk Flats 2', 80000, 16, 0, 0, 0, 0, 42, NULL, 4),
(3287, 0, 0, 0, 'Tusk Flats 1', 80000, 16, 0, 0, 0, 0, 40, NULL, 4),
(3288, 0, 0, 0, 'Tusk Flats 3', 80000, 16, 0, 0, 0, 0, 35, NULL, 4),
(3289, 0, 0, 0, 'Tusk Flats 4', 25000, 16, 0, 0, 0, 0, 24, NULL, 2),
(3290, 0, 0, 0, 'Tusk Flats 6', 50000, 16, 0, 0, 0, 0, 35, NULL, 4),
(3291, 0, 0, 0, 'Tusk Flats 5', 25000, 16, 0, 0, 0, 0, 30, NULL, 2),
(3292, 0, 0, 0, 'Corner Shop (Shop)', 200000, 16, 0, 0, 0, 0, 88, NULL, 4),
(3293, 0, 0, 0, 'Bears Paw 5', 200000, 16, 0, 0, 0, 0, 81, NULL, 6),
(3294, 0, 0, 0, 'Bears Paw 4', 400000, 16, 0, 0, 0, 0, 185, NULL, 8),
(3295, 0, 0, 0, 'Trout Plaza 2', 150000, 16, 0, 0, 0, 0, 64, NULL, 4),
(3296, 0, 0, 0, 'Trout Plaza 1', 200000, 16, 0, 0, 0, 0, 112, NULL, 4),
(3297, 0, 0, 0, 'Trout Plaza 5 (Shop)', 300000, 16, 0, 0, 0, 0, 135, NULL, 4),
(3298, 0, 0, 0, 'Trout Plaza 3', 80000, 16, 0, 0, 0, 0, 36, NULL, 2),
(3299, 0, 0, 0, 'Trout Plaza 4', 80000, 16, 0, 0, 0, 0, 45, NULL, 2),
(3300, 0, 0, 0, 'Skiffs End 2', 80000, 16, 0, 0, 0, 0, 42, NULL, 4),
(3301, 0, 0, 0, 'Skiffs End 1', 100000, 16, 0, 0, 0, 0, 70, NULL, 4),
(3302, 0, 0, 0, 'Furrier Quarter 3', 100000, 16, 0, 0, 0, 0, 54, NULL, 4),
(3303, 0, 0, 0, 'Fimbul Shelf 4', 100000, 16, 0, 0, 0, 0, 56, NULL, 4),
(3304, 0, 0, 0, 'Fimbul Shelf 3', 100000, 16, 0, 0, 0, 0, 66, NULL, 4),
(3305, 0, 0, 0, 'Furrier Quarter 2', 80000, 16, 0, 0, 0, 0, 56, NULL, 4),
(3306, 0, 0, 0, 'Furrier Quarter 1', 150000, 16, 0, 0, 0, 0, 84, NULL, 6),
(3307, 0, 0, 0, 'Fimbul Shelf 2', 100000, 16, 0, 0, 0, 0, 56, NULL, 4),
(3308, 0, 0, 0, 'Fimbul Shelf 1', 80000, 16, 0, 0, 0, 0, 48, NULL, 4),
(3309, 0, 0, 0, 'Bears Paw 3', 200000, 16, 0, 0, 0, 0, 82, NULL, 6),
(3310, 0, 0, 0, 'Raven Corner 2', 150000, 16, 0, 0, 0, 0, 60, NULL, 6),
(3311, 0, 0, 0, 'Raven Corner 1', 80000, 16, 0, 0, 0, 0, 45, NULL, 2),
(3312, 0, 0, 0, 'Raven Corner 3', 100000, 16, 0, 0, 0, 0, 45, NULL, 2),
(3313, 0, 0, 0, 'Mammoth Belly', 1000000, 16, 0, 0, 0, 0, 634, NULL, 60),
(3314, 0, 0, 0, 'Darashia 3, Flat 01', 150000, 13, 0, 0, 0, 0, 42, NULL, 4),
(3315, 0, 0, 0, 'Darashia 3, Flat 05', 150000, 13, 0, 0, 0, 0, 42, NULL, 2),
(3316, 0, 0, 0, 'Darashia 3, Flat 02', 200000, 13, 0, 0, 0, 0, 66, NULL, 4),
(3317, 0, 0, 0, 'Darashia 3, Flat 04', 150000, 13, 0, 0, 0, 0, 66, NULL, 4),
(3318, 0, 0, 0, 'Darashia 3, Flat 03', 150000, 13, 0, 0, 0, 0, 48, NULL, 4),
(3319, 0, 0, 0, 'Darashia 3, Flat 12', 200000, 13, 0, 0, 0, 0, 90, NULL, 10),
(3320, 0, 0, 0, 'Darashia 3, Flat 11', 100000, 13, 0, 0, 0, 0, 42, NULL, 2),
(3321, 0, 0, 0, 'Darashia 3, Flat 14', 200000, 13, 0, 0, 0, 0, 96, NULL, 6),
(3322, 0, 0, 0, 'Darashia 3, Flat 13', 100000, 13, 0, 0, 0, 0, 48, NULL, 4),
(3323, 0, 0, 0, 'Darashia 8, Flat 01', 300000, 13, 0, 0, 0, 0, 82, NULL, 4),
(3325, 0, 0, 0, 'Darashia 8, Flat 05', 300000, 13, 0, 0, 0, 0, 92, NULL, 4),
(3326, 0, 0, 0, 'Darashia 8, Flat 04', 200000, 13, 0, 0, 0, 0, 90, NULL, 4),
(3327, 0, 0, 0, 'Darashia 8, Flat 03', 300000, 13, 0, 0, 0, 0, 171, NULL, 6),
(3328, 0, 0, 0, 'Darashia 8, Flat 12', 150000, 13, 0, 0, 0, 0, 60, NULL, 4),
(3329, 0, 0, 0, 'Darashia 8, Flat 11', 200000, 13, 0, 0, 0, 0, 72, NULL, 4),
(3330, 0, 0, 0, 'Darashia 8, Flat 14', 150000, 13, 0, 0, 0, 0, 66, NULL, 4),
(3331, 0, 0, 0, 'Darashia 8, Flat 13', 150000, 13, 0, 0, 0, 0, 78, NULL, 4),
(3332, 0, 0, 0, 'Darashia, Villa', 800000, 13, 0, 0, 0, 0, 233, NULL, 8),
(3333, 0, 0, 0, 'Darashia, Eastern Guildhall', 1000000, 13, 0, 0, 0, 0, 456, NULL, 32),
(3334, 0, 0, 0, 'Darashia, Western Guildhall', 500000, 13, 0, 0, 0, 0, 376, NULL, 28),
(3335, 0, 0, 0, 'Darashia 2, Flat 03', 100000, 13, 0, 0, 0, 0, 42, NULL, 2),
(3336, 0, 0, 0, 'Darashia 2, Flat 02', 100000, 13, 0, 0, 0, 0, 42, NULL, 2),
(3337, 0, 0, 0, 'Darashia 2, Flat 01', 150000, 13, 0, 0, 0, 0, 48, NULL, 2),
(3338, 0, 0, 0, 'Darashia 2, Flat 04', 80000, 13, 0, 0, 0, 0, 24, NULL, 2),
(3339, 0, 0, 0, 'Darashia 2, Flat 05', 150000, 13, 0, 0, 0, 0, 48, NULL, 4),
(3340, 0, 0, 0, 'Darashia 2, Flat 06', 80000, 13, 0, 0, 0, 0, 24, NULL, 2),
(3341, 0, 0, 0, 'Darashia 2, Flat 07', 150000, 13, 0, 0, 0, 0, 48, NULL, 2),
(3342, 0, 0, 0, 'Darashia 2, Flat 13', 100000, 13, 0, 0, 0, 0, 42, NULL, 2),
(3343, 0, 0, 0, 'Darashia 2, Flat 14', 50000, 13, 0, 0, 0, 0, 24, NULL, 2),
(3344, 0, 0, 0, 'Darashia 2, Flat 15', 100000, 13, 0, 0, 0, 0, 48, NULL, 4),
(3345, 0, 0, 0, 'Darashia 2, Flat 16', 80000, 13, 0, 0, 0, 0, 30, NULL, 2),
(3346, 0, 0, 0, 'Darashia 2, Flat 17', 100000, 13, 0, 0, 0, 0, 42, NULL, 2),
(3347, 0, 0, 0, 'Darashia 2, Flat 18', 100000, 13, 0, 0, 0, 0, 30, NULL, 2),
(3348, 0, 0, 0, 'Darashia 2, Flat 11', 100000, 13, 0, 0, 0, 0, 42, NULL, 2),
(3349, 0, 0, 0, 'Darashia 2, Flat 12', 80000, 13, 0, 0, 0, 0, 30, NULL, 2),
(3350, 0, 0, 0, 'Darashia 1, Flat 03', 300000, 13, 0, 0, 0, 0, 96, NULL, 8),
(3351, 0, 0, 0, 'Darashia 1, Flat 04', 100000, 13, 0, 0, 0, 0, 42, NULL, 2),
(3352, 0, 0, 0, 'Darashia 1, Flat 02', 100000, 13, 0, 0, 0, 0, 42, NULL, 2),
(3353, 0, 0, 0, 'Darashia 1, Flat 01', 100000, 13, 0, 0, 0, 0, 48, NULL, 4),
(3354, 0, 0, 0, 'Darashia 1, Flat 05', 100000, 13, 0, 0, 0, 0, 48, NULL, 4),
(3355, 0, 0, 0, 'Darashia 1, Flat 12', 150000, 13, 0, 0, 0, 0, 66, NULL, 4),
(3356, 0, 0, 0, 'Darashia 1, Flat 13', 150000, 13, 0, 0, 0, 0, 72, NULL, 4),
(3357, 0, 0, 0, 'Darashia 1, Flat 14', 200000, 13, 0, 0, 0, 0, 102, NULL, 10),
(3358, 0, 0, 0, 'Darashia 1, Flat 11', 100000, 13, 0, 0, 0, 0, 48, NULL, 4),
(3359, 0, 0, 0, 'Darashia 5, Flat 02', 150000, 13, 0, 0, 0, 0, 60, NULL, 4),
(3360, 0, 0, 0, 'Darashia 5, Flat 01', 150000, 13, 0, 0, 0, 0, 48, NULL, 2),
(3361, 0, 0, 0, 'Darashia 5, Flat 05', 100000, 13, 0, 0, 0, 0, 42, NULL, 2),
(3362, 0, 0, 0, 'Darashia 5, Flat 04', 150000, 13, 0, 0, 0, 0, 66, NULL, 4),
(3363, 0, 0, 0, 'Darashia 5, Flat 03', 150000, 13, 0, 0, 0, 0, 48, NULL, 2),
(3364, 0, 0, 0, 'Darashia 5, Flat 11', 150000, 13, 0, 0, 0, 0, 66, NULL, 4),
(3365, 0, 0, 0, 'Darashia 5, Flat 12', 150000, 13, 0, 0, 0, 0, 66, NULL, 4),
(3366, 0, 0, 0, 'Darashia 5, Flat 13', 150000, 13, 0, 0, 0, 0, 72, NULL, 4),
(3367, 0, 0, 0, 'Darashia 5, Flat 14', 150000, 13, 0, 0, 0, 0, 72, NULL, 4),
(3368, 0, 0, 0, 'Darashia 6a', 300000, 13, 0, 0, 0, 0, 117, NULL, 4),
(3369, 0, 0, 0, 'Darashia 6b', 300000, 13, 0, 0, 0, 0, 139, NULL, 4),
(3370, 0, 0, 0, 'Darashia 4, Flat 02', 200000, 13, 0, 0, 0, 0, 66, NULL, 4),
(3371, 0, 0, 0, 'Darashia 4, Flat 03', 150000, 13, 0, 0, 0, 0, 42, NULL, 2),
(3372, 0, 0, 0, 'Darashia 4, Flat 04', 200000, 13, 0, 0, 0, 0, 72, NULL, 4),
(3373, 0, 0, 0, 'Darashia 4, Flat 05', 150000, 13, 0, 0, 0, 0, 48, NULL, 4),
(3374, 0, 0, 0, 'Darashia 4, Flat 01', 100000, 13, 0, 0, 0, 0, 48, NULL, 2),
(3375, 0, 0, 0, 'Darashia 4, Flat 12', 200000, 13, 0, 0, 0, 0, 96, NULL, 6),
(3376, 0, 0, 0, 'Darashia 4, Flat 11', 100000, 13, 0, 0, 0, 0, 42, NULL, 2),
(3377, 0, 0, 0, 'Darashia 4, Flat 13', 200000, 13, 0, 0, 0, 0, 72, NULL, 4),
(3378, 0, 0, 0, 'Darashia 4, Flat 14', 150000, 13, 0, 0, 0, 0, 78, NULL, 4);
INSERT INTO `houses` (`id`, `owner`, `paid`, `warnings`, `name`, `rent`, `town_id`, `bid`, `bid_end`, `last_bid`, `highest_bidder`, `size`, `guildid`, `beds`) VALUES
(3379, 0, 0, 0, 'Darashia 7, Flat 01', 100000, 13, 0, 0, 0, 0, 42, NULL, 2),
(3380, 0, 0, 0, 'Darashia 7, Flat 02', 100000, 13, 0, 0, 0, 0, 42, NULL, 2),
(3381, 0, 0, 0, 'Darashia 7, Flat 03', 200000, 13, 0, 0, 0, 0, 102, NULL, 8),
(3382, 0, 0, 0, 'Darashia 7, Flat 05', 150000, 13, 0, 0, 0, 0, 42, NULL, 4),
(3383, 0, 0, 0, 'Darashia 7, Flat 04', 150000, 13, 0, 0, 0, 0, 48, NULL, 2),
(3384, 0, 0, 0, 'Darashia 7, Flat 12', 200000, 13, 0, 0, 0, 0, 96, NULL, 8),
(3385, 0, 0, 0, 'Darashia 7, Flat 11', 100000, 13, 0, 0, 0, 0, 42, NULL, 2),
(3386, 0, 0, 0, 'Darashia 7, Flat 14', 200000, 13, 0, 0, 0, 0, 102, NULL, 8),
(3387, 0, 0, 0, 'Darashia 7, Flat 13', 100000, 13, 0, 0, 0, 0, 48, NULL, 2),
(3388, 0, 0, 0, 'Pirate Shipwreck 1', 800000, 13, 0, 0, 0, 0, 205, NULL, 0),
(3389, 0, 0, 0, 'Pirate Shipwreck 2', 800000, 13, 0, 0, 0, 0, 294, NULL, 0),
(3390, 0, 0, 0, 'The Shelter', 250000, 14, 0, 0, 0, 0, 560, NULL, 62),
(3391, 0, 0, 0, 'Litter Promenade 1', 25000, 14, 0, 0, 0, 0, 25, NULL, 4),
(3392, 0, 0, 0, 'Litter Promenade 2', 50000, 14, 0, 0, 0, 0, 25, NULL, 2),
(3394, 0, 0, 0, 'Litter Promenade 3', 25000, 14, 0, 0, 0, 0, 36, NULL, 2),
(3395, 0, 0, 0, 'Litter Promenade 4', 25000, 14, 0, 0, 0, 0, 30, NULL, 2),
(3396, 0, 0, 0, 'Rum Alley 3', 25000, 14, 0, 0, 0, 0, 28, NULL, 2),
(3397, 0, 0, 0, 'Straycat\'s Corner 5', 80000, 14, 0, 0, 0, 0, 48, NULL, 4),
(3398, 0, 0, 0, 'Straycat\'s Corner 6', 25000, 14, 0, 0, 0, 0, 25, NULL, 2),
(3399, 0, 0, 0, 'Litter Promenade 5', 25000, 14, 0, 0, 0, 0, 35, NULL, 4),
(3401, 0, 0, 0, 'Straycat\'s Corner 4', 50000, 14, 0, 0, 0, 0, 40, NULL, 4),
(3402, 0, 0, 0, 'Straycat\'s Corner 2', 50000, 14, 0, 0, 0, 0, 49, NULL, 2),
(3403, 0, 0, 0, 'Straycat\'s Corner 1', 25000, 14, 0, 0, 0, 0, 25, NULL, 2),
(3404, 0, 0, 0, 'Rum Alley 2', 25000, 14, 0, 0, 0, 0, 25, NULL, 2),
(3405, 0, 0, 0, 'Rum Alley 1', 25000, 14, 0, 0, 0, 0, 36, NULL, 2),
(3406, 0, 0, 0, 'Smuggler Backyard 3', 50000, 14, 0, 0, 0, 0, 40, NULL, 4),
(3407, 0, 0, 0, 'Shady Trail 3', 25000, 14, 0, 0, 0, 0, 25, NULL, 2),
(3408, 0, 0, 0, 'Shady Trail 1', 100000, 14, 0, 0, 0, 0, 48, NULL, 10),
(3409, 0, 0, 0, 'Shady Trail 2', 25000, 14, 0, 0, 0, 0, 30, NULL, 4),
(3410, 0, 0, 0, 'Smuggler Backyard 4', 25000, 14, 0, 0, 0, 0, 30, NULL, 2),
(3411, 0, 0, 0, 'Smuggler Backyard 2', 25000, 14, 0, 0, 0, 0, 40, NULL, 4),
(3412, 0, 0, 0, 'Smuggler Backyard 1', 25000, 14, 0, 0, 0, 0, 40, NULL, 4),
(3413, 0, 0, 0, 'Smuggler Backyard 5', 25000, 14, 0, 0, 0, 0, 35, NULL, 4),
(3414, 0, 0, 0, 'Sugar Street 1', 200000, 14, 0, 0, 0, 0, 84, NULL, 6),
(3415, 0, 0, 0, 'Sugar Street 2', 150000, 14, 0, 0, 0, 0, 84, NULL, 6),
(3416, 0, 0, 0, 'Sugar Street 3a', 100000, 14, 0, 0, 0, 0, 48, NULL, 6),
(3417, 0, 0, 0, 'Sugar Street 3b', 150000, 14, 0, 0, 0, 0, 66, NULL, 6),
(3418, 0, 0, 0, 'Sugar Street 4d', 50000, 14, 0, 0, 0, 0, 24, NULL, 4),
(3419, 0, 0, 0, 'Sugar Street 4c', 25000, 14, 0, 0, 0, 0, 24, NULL, 2),
(3420, 0, 0, 0, 'Sugar Street 4b', 100000, 14, 0, 0, 0, 0, 30, NULL, 4),
(3421, 0, 0, 0, 'Sugar Street 4a', 80000, 14, 0, 0, 0, 0, 36, NULL, 4),
(3422, 0, 0, 0, 'Harvester\'s Haven, Flat 01', 50000, 14, 0, 0, 0, 0, 30, NULL, 4),
(3423, 0, 0, 0, 'Harvester\'s Haven, Flat 03', 50000, 14, 0, 0, 0, 0, 30, NULL, 4),
(3424, 0, 0, 0, 'Harvester\'s Haven, Flat 05', 50000, 14, 0, 0, 0, 0, 36, NULL, 4),
(3425, 0, 0, 0, 'Harvester\'s Haven, Flat 06', 50000, 14, 0, 0, 0, 0, 30, NULL, 4),
(3426, 0, 0, 0, 'Harvester\'s Haven, Flat 04', 50000, 14, 0, 0, 0, 0, 30, NULL, 4),
(3427, 0, 0, 0, 'Harvester\'s Haven, Flat 02', 50000, 14, 0, 0, 0, 0, 36, NULL, 4),
(3428, 0, 0, 0, 'Harvester\'s Haven, Flat 07', 80000, 14, 0, 0, 0, 0, 30, NULL, 4),
(3429, 0, 0, 0, 'Harvester\'s Haven, Flat 09', 50000, 14, 0, 0, 0, 0, 30, NULL, 4),
(3430, 0, 0, 0, 'Harvester\'s Haven, Flat 11', 25000, 14, 0, 0, 0, 0, 36, NULL, 4),
(3431, 0, 0, 0, 'Harvester\'s Haven, Flat 08', 50000, 14, 0, 0, 0, 0, 30, NULL, 4),
(3432, 0, 0, 0, 'Harvester\'s Haven, Flat 10', 50000, 14, 0, 0, 0, 0, 30, NULL, 4),
(3433, 0, 0, 0, 'Harvester\'s Haven, Flat 12', 25000, 14, 0, 0, 0, 0, 36, NULL, 4),
(3434, 0, 0, 0, 'Marble Lane 3', 600000, 14, 0, 0, 0, 0, 240, NULL, 8),
(3435, 0, 0, 0, 'Marble Lane 2', 400000, 14, 0, 0, 0, 0, 200, NULL, 6),
(3436, 0, 0, 0, 'Marble Lane 4', 400000, 14, 0, 0, 0, 0, 192, NULL, 8),
(3437, 0, 0, 0, 'Admiral\'s Avenue 1', 400000, 14, 0, 0, 0, 0, 176, NULL, 4),
(3438, 0, 0, 0, 'Admiral\'s Avenue 2', 400000, 14, 0, 0, 0, 0, 183, NULL, 8),
(3439, 0, 0, 0, 'Admiral\'s Avenue 3', 300000, 14, 0, 0, 0, 0, 144, NULL, 4),
(3440, 0, 0, 0, 'Ivory Circle 1', 400000, 14, 0, 0, 0, 0, 160, NULL, 4),
(3441, 0, 0, 0, 'Sugar Street 5', 150000, 14, 0, 0, 0, 0, 48, NULL, 4),
(3442, 0, 0, 0, 'Freedom Street 1', 200000, 14, 0, 0, 0, 0, 84, NULL, 4),
(3443, 0, 0, 0, 'Trader\'s Point 1', 200000, 14, 0, 0, 0, 0, 77, NULL, 4),
(3444, 0, 0, 0, 'Trader\'s Point 2 (Shop)', 600000, 14, 0, 0, 0, 0, 195, NULL, 4),
(3445, 0, 0, 0, 'Trader\'s Point 3 (Shop)', 600000, 14, 0, 0, 0, 0, 198, NULL, 4),
(3446, 0, 0, 0, 'Ivory Mansion', 800000, 14, 0, 0, 0, 0, 455, NULL, 0),
(3447, 0, 0, 0, 'Ivory Circle 2', 400000, 14, 0, 0, 0, 0, 196, NULL, 4),
(3448, 0, 0, 0, 'Ivy Cottage', 500000, 14, 0, 0, 0, 0, 876, NULL, 52),
(3449, 0, 0, 0, 'Marble Lane 1', 600000, 14, 0, 0, 0, 0, 320, NULL, 12),
(3450, 0, 0, 0, 'Freedom Street 2', 400000, 14, 0, 0, 0, 0, 208, NULL, 8),
(3452, 0, 0, 0, 'Meriana Beach', 150000, 14, 0, 0, 0, 0, 219, NULL, 6),
(3453, 0, 0, 0, 'The Tavern 1a', 150000, 14, 0, 0, 0, 0, 73, NULL, 8),
(3454, 0, 0, 0, 'The Tavern 1b', 100000, 14, 0, 0, 0, 0, 54, NULL, 4),
(3455, 0, 0, 0, 'The Tavern 1c', 200000, 14, 0, 0, 0, 0, 126, NULL, 6),
(3456, 0, 0, 0, 'The Tavern 1d', 100000, 14, 0, 0, 0, 0, 54, NULL, 4),
(3457, 0, 0, 0, 'The Tavern 2a', 300000, 14, 0, 0, 0, 0, 163, NULL, 10),
(3458, 0, 0, 0, 'The Tavern 2b', 100000, 14, 0, 0, 0, 0, 57, NULL, 4),
(3459, 0, 0, 0, 'The Tavern 2d', 100000, 14, 0, 0, 0, 0, 40, NULL, 4),
(3460, 0, 0, 0, 'The Tavern 2c', 50000, 14, 0, 0, 0, 0, 40, NULL, 2),
(3461, 0, 0, 0, 'The Yeah Beach Project', 150000, 14, 0, 0, 0, 0, 202, NULL, 6),
(3462, 0, 0, 0, 'Mountain Hideout', 500000, 14, 0, 0, 0, 0, 511, NULL, 34),
(3463, 0, 0, 0, 'Darashia 8, Flat 02', 300000, 13, 0, 0, 0, 0, 135, NULL, 4),
(3464, 0, 0, 0, 'Castle, Basement, Flat 01', 50000, 11, 0, 0, 0, 0, 30, NULL, 2),
(3465, 0, 0, 0, 'Castle, Basement, Flat 02', 50000, 11, 0, 0, 0, 0, 24, NULL, 2),
(3466, 0, 0, 0, 'Castle, Basement, Flat 03', 50000, 11, 0, 0, 0, 0, 24, NULL, 2),
(3467, 0, 0, 0, 'Castle, Basement, Flat 05', 50000, 11, 0, 0, 0, 0, 24, NULL, 2),
(3468, 0, 0, 0, 'Castle, Basement, Flat 04', 50000, 11, 0, 0, 0, 0, 24, NULL, 2),
(3469, 0, 0, 0, 'Castle, Basement, Flat 06', 50000, 11, 0, 0, 0, 0, 24, NULL, 2),
(3470, 0, 0, 0, 'Castle, Basement, Flat 07', 50000, 11, 0, 0, 0, 0, 24, NULL, 2),
(3471, 0, 0, 0, 'Castle, Basement, Flat 09', 25000, 11, 0, 0, 0, 0, 30, NULL, 2),
(3472, 0, 0, 0, 'Castle, Basement, Flat 08', 50000, 11, 0, 0, 0, 0, 30, NULL, 2),
(3473, 0, 0, 0, 'Cormaya 1', 150000, 11, 0, 0, 0, 0, 49, NULL, 4),
(3474, 0, 0, 0, 'Cormaya Flats, Flat 01', 25000, 11, 0, 0, 0, 0, 20, NULL, 2),
(3475, 0, 0, 0, 'Cormaya Flats, Flat 02', 25000, 11, 0, 0, 0, 0, 20, NULL, 2),
(3476, 0, 0, 0, 'Cormaya Flats, Flat 03', 50000, 11, 0, 0, 0, 0, 35, NULL, 4),
(3477, 0, 0, 0, 'Cormaya Flats, Flat 06', 25000, 11, 0, 0, 0, 0, 20, NULL, 2),
(3478, 0, 0, 0, 'Cormaya Flats, Flat 05', 25000, 11, 0, 0, 0, 0, 20, NULL, 2),
(3479, 0, 0, 0, 'Cormaya Flats, Flat 04', 50000, 11, 0, 0, 0, 0, 35, NULL, 4),
(3480, 0, 0, 0, 'Cormaya Flats, Flat 11', 100000, 11, 0, 0, 0, 0, 45, NULL, 4),
(3482, 0, 0, 0, 'Cormaya Flats, Flat 13', 25000, 11, 0, 0, 0, 0, 30, NULL, 4),
(3483, 0, 0, 0, 'Cormaya Flats, Flat 12', 100000, 11, 0, 0, 0, 0, 45, NULL, 4),
(3485, 0, 0, 0, 'Cormaya Flats, Flat 14', 25000, 11, 0, 0, 0, 0, 30, NULL, 4),
(3486, 0, 0, 0, 'Cormaya 2', 300000, 11, 0, 0, 0, 0, 144, NULL, 6),
(3487, 0, 0, 0, 'Cormaya 4', 150000, 11, 0, 0, 0, 0, 63, NULL, 4),
(3488, 0, 0, 0, 'Cormaya 3', 200000, 11, 0, 0, 0, 0, 72, NULL, 4),
(3489, 0, 0, 0, 'Cormaya 6', 200000, 11, 0, 0, 0, 0, 84, NULL, 4),
(3490, 0, 0, 0, 'Cormaya 7', 200000, 11, 0, 0, 0, 0, 84, NULL, 4),
(3491, 0, 0, 0, 'Cormaya 8', 200000, 11, 0, 0, 0, 0, 106, NULL, 4),
(3492, 0, 0, 0, 'Cormaya 5', 300000, 11, 0, 0, 0, 0, 165, NULL, 6),
(3493, 0, 0, 0, 'Castle of the White Dragon', 1000000, 11, 0, 0, 0, 0, 888, NULL, 38),
(3494, 0, 0, 0, 'Cormaya 9b', 150000, 11, 0, 0, 0, 0, 88, NULL, 4),
(3495, 0, 0, 0, 'Cormaya 9a', 80000, 11, 0, 0, 0, 0, 48, NULL, 4),
(3496, 0, 0, 0, 'Cormaya 9d', 150000, 11, 0, 0, 0, 0, 88, NULL, 4),
(3497, 0, 0, 0, 'Cormaya 9c', 80000, 11, 0, 0, 0, 0, 48, NULL, 4),
(3498, 0, 0, 0, 'Cormaya 10', 300000, 11, 0, 0, 0, 0, 144, NULL, 6),
(3499, 0, 0, 0, 'Cormaya 11', 150000, 11, 0, 0, 0, 0, 72, NULL, 4),
(3500, 0, 0, 0, 'Edron Flats, Flat 22', 50000, 11, 0, 0, 0, 0, 25, NULL, 2),
(3501, 0, 0, 0, 'Magic Academy, Shop', 150000, 11, 0, 0, 0, 0, 48, NULL, 2),
(3502, 0, 0, 0, 'Magic Academy, Flat 1', 100000, 11, 0, 0, 0, 0, 55, NULL, 6),
(3503, 0, 0, 0, 'Magic Academy, Guild', 500000, 11, 0, 0, 0, 0, 401, NULL, 28),
(3504, 0, 0, 0, 'Magic Academy, Flat 2', 80000, 11, 0, 0, 0, 0, 53, NULL, 4),
(3505, 0, 0, 0, 'Magic Academy, Flat 3', 100000, 11, 0, 0, 0, 0, 53, NULL, 2),
(3506, 0, 0, 0, 'Magic Academy, Flat 4', 100000, 11, 0, 0, 0, 0, 50, NULL, 4),
(3507, 0, 0, 0, 'Magic Academy, Flat 5', 80000, 11, 0, 0, 0, 0, 53, NULL, 2),
(3508, 0, 0, 0, 'Oskahl I f', 100000, 10, 0, 0, 0, 0, 35, NULL, 2),
(3509, 0, 0, 0, 'Oskahl I g', 100000, 10, 0, 0, 0, 0, 42, NULL, 4),
(3510, 0, 0, 0, 'Oskahl I h', 150000, 10, 0, 0, 0, 0, 74, NULL, 6),
(3511, 0, 0, 0, 'Oskahl I i', 80000, 10, 0, 0, 0, 0, 36, NULL, 2),
(3512, 0, 0, 0, 'Oskahl I j', 80000, 10, 0, 0, 0, 0, 36, NULL, 2),
(3513, 0, 0, 0, 'Oskahl I b', 80000, 10, 0, 0, 0, 0, 30, NULL, 2),
(3514, 0, 0, 0, 'Oskahl I d', 100000, 10, 0, 0, 0, 0, 42, NULL, 4),
(3515, 0, 0, 0, 'Oskahl I e', 80000, 10, 0, 0, 0, 0, 36, NULL, 2),
(3516, 0, 0, 0, 'Oskahl I c', 80000, 10, 0, 0, 0, 0, 36, NULL, 2),
(3517, 0, 0, 0, 'Chameken I', 100000, 10, 0, 0, 0, 0, 36, NULL, 2),
(3518, 0, 0, 0, 'Chameken II', 80000, 10, 0, 0, 0, 0, 36, NULL, 2),
(3519, 0, 0, 0, 'Charsirakh III', 50000, 10, 0, 0, 0, 0, 36, NULL, 2),
(3520, 0, 0, 0, 'Charsirakh II', 100000, 10, 0, 0, 0, 0, 49, NULL, 4),
(3521, 0, 0, 0, 'Murkhol I a', 80000, 10, 0, 0, 0, 0, 48, NULL, 4),
(3523, 0, 0, 0, 'Murkhol I c', 50000, 10, 0, 0, 0, 0, 24, NULL, 2),
(3524, 0, 0, 0, 'Murkhol I b', 50000, 10, 0, 0, 0, 0, 24, NULL, 2),
(3525, 0, 0, 0, 'Charsirakh I b', 150000, 10, 0, 0, 0, 0, 64, NULL, 4),
(3526, 0, 0, 0, 'Harrah I', 250000, 10, 0, 0, 0, 0, 232, NULL, 20),
(3527, 0, 0, 0, 'Thanah I d', 200000, 10, 0, 0, 0, 0, 84, NULL, 8),
(3528, 0, 0, 0, 'Thanah I c', 200000, 10, 0, 0, 0, 0, 112, NULL, 6),
(3529, 0, 0, 0, 'Thanah I b', 150000, 10, 0, 0, 0, 0, 100, NULL, 6),
(3530, 0, 0, 0, 'Thanah I a', 25000, 10, 0, 0, 0, 0, 36, NULL, 2),
(3531, 0, 0, 0, 'Othehothep I c', 150000, 10, 0, 0, 0, 0, 60, NULL, 6),
(3532, 0, 0, 0, 'Othehothep I d', 150000, 10, 0, 0, 0, 0, 84, NULL, 8),
(3533, 0, 0, 0, 'Othehothep I b', 100000, 10, 0, 0, 0, 0, 64, NULL, 4),
(3534, 0, 0, 0, 'Othehothep II c', 80000, 10, 0, 0, 0, 0, 30, NULL, 2),
(3535, 0, 0, 0, 'Othehothep II d', 80000, 10, 0, 0, 0, 0, 35, NULL, 2),
(3536, 0, 0, 0, 'Othehothep II e', 150000, 10, 0, 0, 0, 0, 48, NULL, 4),
(3537, 0, 0, 0, 'Othehothep II f', 100000, 10, 0, 0, 0, 0, 56, NULL, 4),
(3538, 0, 0, 0, 'Othehothep II b', 150000, 10, 0, 0, 0, 0, 81, NULL, 6),
(3539, 0, 0, 0, 'Othehothep II a', 25000, 10, 0, 0, 0, 0, 25, NULL, 2),
(3540, 0, 0, 0, 'Mothrem I', 80000, 10, 0, 0, 0, 0, 49, NULL, 4),
(3541, 0, 0, 0, 'Arakmehn I', 100000, 10, 0, 0, 0, 0, 56, NULL, 6),
(3542, 0, 0, 0, 'Arakmehn II', 80000, 10, 0, 0, 0, 0, 49, NULL, 2),
(3543, 0, 0, 0, 'Arakmehn III', 100000, 10, 0, 0, 0, 0, 49, NULL, 4),
(3544, 0, 0, 0, 'Arakmehn IV', 100000, 10, 0, 0, 0, 0, 56, NULL, 4),
(3545, 0, 0, 0, 'Unklath II b', 50000, 10, 0, 0, 0, 0, 25, NULL, 2),
(3546, 0, 0, 0, 'Unklath II c', 50000, 10, 0, 0, 0, 0, 30, NULL, 2),
(3547, 0, 0, 0, 'Unklath II d', 100000, 10, 0, 0, 0, 0, 66, NULL, 4),
(3548, 0, 0, 0, 'Unklath II a', 50000, 10, 0, 0, 0, 0, 49, NULL, 2),
(3549, 0, 0, 0, 'Rathal I b', 50000, 10, 0, 0, 0, 0, 25, NULL, 2),
(3550, 0, 0, 0, 'Rathal I c', 25000, 10, 0, 0, 0, 0, 30, NULL, 2),
(3551, 0, 0, 0, 'Rathal I d', 50000, 10, 0, 0, 0, 0, 30, NULL, 4),
(3552, 0, 0, 0, 'Rathal I e', 50000, 10, 0, 0, 0, 0, 36, NULL, 4),
(3553, 0, 0, 0, 'Rathal I a', 80000, 10, 0, 0, 0, 0, 49, NULL, 4),
(3554, 0, 0, 0, 'Rathal II b', 50000, 10, 0, 0, 0, 0, 25, NULL, 2),
(3555, 0, 0, 0, 'Rathal II c', 50000, 10, 0, 0, 0, 0, 30, NULL, 2),
(3556, 0, 0, 0, 'Rathal II d', 100000, 10, 0, 0, 0, 0, 66, NULL, 4),
(3557, 0, 0, 0, 'Rathal II a', 80000, 10, 0, 0, 0, 0, 49, NULL, 2),
(3558, 0, 0, 0, 'Esuph I', 50000, 10, 0, 0, 0, 0, 36, NULL, 2),
(3559, 0, 0, 0, 'Esuph II b', 100000, 10, 0, 0, 0, 0, 64, NULL, 4),
(3560, 0, 0, 0, 'Esuph II a', 25000, 10, 0, 0, 0, 0, 20, NULL, 2),
(3561, 0, 0, 0, 'Esuph III b', 100000, 10, 0, 0, 0, 0, 64, NULL, 4),
(3562, 0, 0, 0, 'Esuph III a', 25000, 10, 0, 0, 0, 0, 20, NULL, 2),
(3564, 0, 0, 0, 'Esuph IV c', 80000, 10, 0, 0, 0, 0, 43, NULL, 4),
(3565, 0, 0, 0, 'Esuph IV d', 25000, 10, 0, 0, 0, 0, 38, NULL, 2),
(3566, 0, 0, 0, 'Esuph IV a', 25000, 10, 0, 0, 0, 0, 25, NULL, 2),
(3567, 0, 0, 0, 'Horakhal', 250000, 10, 0, 0, 0, 0, 332, NULL, 28),
(3568, 0, 0, 0, 'Botham II d', 100000, 10, 0, 0, 0, 0, 49, NULL, 4),
(3569, 0, 0, 0, 'Botham II e', 100000, 10, 0, 0, 0, 0, 49, NULL, 4),
(3570, 0, 0, 0, 'Botham II f', 80000, 10, 0, 0, 0, 0, 49, NULL, 4),
(3571, 0, 0, 0, 'Botham II g', 80000, 10, 0, 0, 0, 0, 49, NULL, 4),
(3572, 0, 0, 0, 'Botham II c', 100000, 10, 0, 0, 0, 0, 40, NULL, 4),
(3573, 0, 0, 0, 'Botham II b', 100000, 10, 0, 0, 0, 0, 60, NULL, 4),
(3574, 0, 0, 0, 'Botham II a', 25000, 10, 0, 0, 0, 0, 36, NULL, 2),
(3575, 0, 0, 0, 'Botham III f', 150000, 10, 0, 0, 0, 0, 56, NULL, 6),
(3576, 0, 0, 0, 'Botham III h', 200000, 10, 0, 0, 0, 0, 113, NULL, 6),
(3577, 0, 0, 0, 'Botham III g', 100000, 10, 0, 0, 0, 0, 56, NULL, 4),
(3578, 0, 0, 0, 'Botham III b', 50000, 10, 0, 0, 0, 0, 25, NULL, 4),
(3579, 0, 0, 0, 'Botham III c', 25000, 10, 0, 0, 0, 0, 30, NULL, 2),
(3581, 0, 0, 0, 'Botham III e', 100000, 10, 0, 0, 0, 0, 66, NULL, 4),
(3582, 0, 0, 0, 'Botham III a', 80000, 10, 0, 0, 0, 0, 49, NULL, 4),
(3583, 0, 0, 0, 'Botham IV f', 100000, 10, 0, 0, 0, 0, 49, NULL, 4),
(3584, 0, 0, 0, 'Botham IV h', 100000, 10, 0, 0, 0, 0, 56, NULL, 2),
(3585, 0, 0, 0, 'Botham IV i', 150000, 10, 0, 0, 0, 0, 56, NULL, 6),
(3586, 0, 0, 0, 'Botham IV g', 100000, 10, 0, 0, 0, 0, 64, NULL, 4),
(3587, 0, 0, 0, 'Botham IV e', 100000, 10, 0, 0, 0, 0, 121, NULL, 8),
(3591, 0, 0, 0, 'Botham IV a', 100000, 10, 0, 0, 0, 0, 49, NULL, 4),
(3592, 0, 0, 0, 'Ramen Tah', 250000, 10, 0, 0, 0, 0, 227, NULL, 32),
(3593, 0, 0, 0, 'Botham I c', 150000, 10, 0, 0, 0, 0, 49, NULL, 4),
(3594, 0, 0, 0, 'Botham I e', 80000, 10, 0, 0, 0, 0, 49, NULL, 4),
(3595, 0, 0, 0, 'Botham I d', 150000, 10, 0, 0, 0, 0, 98, NULL, 6),
(3596, 0, 0, 0, 'Botham I b', 150000, 10, 0, 0, 0, 0, 100, NULL, 6),
(3597, 0, 0, 0, 'Botham I a', 50000, 10, 0, 0, 0, 0, 40, NULL, 2),
(3598, 0, 0, 0, 'Charsirakh I a', 25000, 10, 0, 0, 0, 0, 20, NULL, 2),
(3599, 0, 0, 0, 'Low Waters Observatory', 400000, 10, 0, 0, 0, 0, 743, NULL, 10),
(3600, 0, 0, 0, 'Oskahl I a', 150000, 10, 0, 0, 0, 0, 64, NULL, 4),
(3601, 0, 0, 0, 'Othehothep I a', 25000, 10, 0, 0, 0, 0, 20, NULL, 2),
(3602, 0, 0, 0, 'Othehothep III a', 25000, 10, 0, 0, 0, 0, 20, NULL, 2),
(3603, 0, 0, 0, 'Othehothep III b', 80000, 10, 0, 0, 0, 0, 64, NULL, 4),
(3604, 0, 0, 0, 'Othehothep III c', 80000, 10, 0, 0, 0, 0, 30, NULL, 4),
(3605, 0, 0, 0, 'Othehothep III d', 80000, 10, 0, 0, 0, 0, 42, NULL, 2),
(3606, 0, 0, 0, 'Othehothep III e', 50000, 10, 0, 0, 0, 0, 35, NULL, 2),
(3607, 0, 0, 0, 'Othehothep III f', 50000, 10, 0, 0, 0, 0, 37, NULL, 2),
(3608, 0, 0, 0, 'Unklath I f', 100000, 10, 0, 0, 0, 0, 49, NULL, 4),
(3609, 0, 0, 0, 'Unklath I g', 100000, 10, 0, 0, 0, 0, 56, NULL, 2),
(3610, 0, 0, 0, 'Unklath I d', 150000, 10, 0, 0, 0, 0, 56, NULL, 6),
(3611, 0, 0, 0, 'Unklath I e', 150000, 10, 0, 0, 0, 0, 64, NULL, 4),
(3612, 0, 0, 0, 'Unklath I b', 100000, 10, 0, 0, 0, 0, 55, NULL, 4),
(3613, 0, 0, 0, 'Unklath I c', 100000, 10, 0, 0, 0, 0, 66, NULL, 4),
(3614, 0, 0, 0, 'Unklath I a', 100000, 10, 0, 0, 0, 0, 49, NULL, 4),
(3615, 0, 0, 0, 'Thanah II a', 25000, 10, 0, 0, 0, 0, 36, NULL, 2),
(3616, 0, 0, 0, 'Thanah II b', 50000, 10, 0, 0, 0, 0, 20, NULL, 2),
(3617, 0, 0, 0, 'Thanah II d', 50000, 10, 0, 0, 0, 0, 20, NULL, 2),
(3618, 0, 0, 0, 'Thanah II e', 25000, 10, 0, 0, 0, 0, 16, NULL, 2),
(3619, 0, 0, 0, 'Thanah II c', 25000, 10, 0, 0, 0, 0, 24, NULL, 2),
(3620, 0, 0, 0, 'Thanah II f', 150000, 10, 0, 0, 0, 0, 86, NULL, 6),
(3621, 0, 0, 0, 'Thanah II g', 100000, 10, 0, 0, 0, 0, 51, NULL, 4),
(3622, 0, 0, 0, 'Thanah II h', 100000, 10, 0, 0, 0, 0, 55, NULL, 4),
(3623, 0, 0, 0, 'Thrarhor I a (Shop)', 50000, 10, 0, 0, 0, 0, 32, NULL, 2),
(3624, 0, 0, 0, 'Thrarhor I c (Shop)', 50000, 10, 0, 0, 0, 0, 32, NULL, 2),
(3625, 0, 0, 0, 'Thrarhor I d (Shop)', 80000, 10, 0, 0, 0, 0, 32, NULL, 2),
(3626, 0, 0, 0, 'Thrarhor I b (Shop)', 50000, 10, 0, 0, 0, 0, 28, NULL, 2),
(3627, 0, 0, 0, 'Uthemath I a', 25000, 10, 0, 0, 0, 0, 20, NULL, 2),
(3628, 0, 0, 0, 'Uthemath I b', 50000, 10, 0, 0, 0, 0, 36, NULL, 2),
(3629, 0, 0, 0, 'Uthemath I c', 80000, 10, 0, 0, 0, 0, 45, NULL, 4),
(3630, 0, 0, 0, 'Uthemath I d', 80000, 10, 0, 0, 0, 0, 30, NULL, 2),
(3631, 0, 0, 0, 'Uthemath I e', 80000, 10, 0, 0, 0, 0, 35, NULL, 4),
(3632, 0, 0, 0, 'Uthemath I f', 150000, 10, 0, 0, 0, 0, 104, NULL, 6),
(3633, 0, 0, 0, 'Uthemath II', 250000, 10, 0, 0, 0, 0, 170, NULL, 16),
(3634, 0, 0, 0, 'Marketplace 1', 400000, 22, 0, 0, 0, 0, 137, NULL, 2),
(3635, 0, 0, 0, 'Marketplace 2', 400000, 22, 0, 0, 0, 0, 148, NULL, 4),
(3636, 0, 0, 0, 'Quay 1', 200000, 22, 0, 0, 0, 0, 124, NULL, 4),
(3637, 0, 0, 0, 'Quay 2', 200000, 22, 0, 0, 0, 0, 185, NULL, 6),
(3638, 0, 0, 0, 'Halls of Sun and Sea', 1000000, 22, 0, 0, 0, 0, 536, NULL, 18),
(3639, 0, 0, 0, 'Palace Vicinity', 200000, 22, 0, 0, 0, 0, 198, NULL, 4),
(3640, 0, 0, 0, 'Wave Tower', 400000, 22, 0, 0, 0, 0, 341, NULL, 8),
(3641, 0, 0, 0, 'Old Sanctuary of God King Qjell', 300000, 18, 0, 0, 0, 0, 701, NULL, 12),
(3642, 0, 0, 0, 'Old Heritage Estate', 600000, 20, 0, 0, 0, 0, 435, NULL, 14),
(3643, 0, 0, 0, 'Rathleton Plaza 4', 400000, 20, 0, 0, 0, 0, 200, NULL, 4),
(3644, 0, 0, 0, 'Rathleton Plaza 3', 400000, 20, 0, 0, 0, 0, 224, NULL, 6),
(3645, 0, 0, 0, 'Rathleton Plaza 2', 400000, 20, 0, 0, 0, 0, 112, NULL, 4),
(3646, 0, 0, 0, 'Rathleton Plaza 1', 300000, 20, 0, 0, 0, 0, 120, NULL, 4),
(3647, 0, 0, 0, 'Antimony Lane 2', 400000, 20, 0, 0, 0, 0, 196, NULL, 6),
(3648, 0, 0, 0, 'Antimony Lane 1', 400000, 20, 0, 0, 0, 0, 265, NULL, 10),
(3649, 0, 0, 0, 'Wallside Residence', 400000, 20, 0, 0, 0, 0, 264, NULL, 8),
(3650, 0, 0, 0, 'Wallside Lane 1', 800000, 20, 0, 0, 0, 0, 286, NULL, 8),
(3651, 0, 0, 0, 'Wallside Lane 2', 600000, 20, 0, 0, 0, 0, 312, NULL, 8),
(3652, 0, 0, 0, 'Vanward Flats B', 400000, 20, 0, 0, 0, 0, 243, NULL, 8),
(3653, 0, 0, 0, 'Vanward Flats A', 400000, 20, 0, 0, 0, 0, 276, NULL, 8),
(3654, 0, 0, 0, 'Bronze Brothers Bastion', 5000000, 20, 0, 0, 0, 0, 1231, NULL, 30),
(3655, 0, 0, 0, 'Cistern Ave', 300000, 20, 0, 0, 0, 0, 156, NULL, 4),
(3656, 0, 0, 0, 'Antimony Lane 4', 400000, 20, 0, 0, 0, 0, 218, NULL, 6),
(3657, 0, 0, 0, 'Antimony Lane 3', 400000, 20, 0, 0, 0, 0, 140, NULL, 6),
(3658, 0, 0, 0, 'Rathleton Hills Residence', 400000, 20, 0, 0, 0, 0, 252, NULL, 6),
(3659, 0, 0, 0, 'Rathleton Hills Estate', 1000000, 20, 0, 0, 0, 0, 710, NULL, 26),
(3687, 0, 0, 0, 'Freewind House 1', 0, 26, 0, 0, 0, 0, 62, NULL, 6),
(3688, 0, 0, 0, 'Freewind House 2', 0, 26, 0, 0, 0, 0, 92, NULL, 6),
(3689, 0, 0, 0, 'Freewind House 3', 0, 26, 0, 0, 0, 0, 68, NULL, 4),
(3690, 0, 0, 0, 'Freewind House 4', 0, 26, 0, 0, 0, 0, 88, NULL, 6),
(3691, 0, 0, 0, 'Freewind House 5', 0, 26, 0, 0, 0, 0, 76, NULL, 4),
(3692, 0, 0, 0, 'Freewind Manoir 1', 0, 26, 0, 0, 0, 0, 124, NULL, 8),
(3693, 0, 0, 0, 'Freewind Manoir 2', 0, 26, 0, 0, 0, 0, 127, NULL, 8),
(3694, 0, 0, 0, 'Freewind Mansion', 0, 26, 0, 0, 0, 0, 164, NULL, 8),
(3695, 0, 0, 0, 'Freewind House 6', 0, 26, 0, 0, 0, 0, 82, NULL, 6),
(3696, 0, 0, 0, 'Darashia House 1', 0, 13, 0, 0, 0, 0, 208, NULL, 8),
(3697, 0, 0, 0, 'Darashia House 2', 0, 13, 0, 0, 0, 0, 416, NULL, 32),
(3698, 0, 0, 0, 'Darashia House 3', 0, 13, 0, 0, 0, 0, 349, NULL, 28),
(3699, 0, 0, 0, 'Darashia House 4', 0, 13, 0, 0, 0, 0, 90, NULL, 4),
(3700, 0, 0, 0, 'Darashia House 5', 0, 13, 0, 0, 0, 0, 89, NULL, 4),
(3702, 0, 0, 0, 'Darashia House 6', 0, 13, 0, 0, 0, 0, 106, NULL, 4),
(3703, 0, 0, 0, 'Darashia House 7', 0, 13, 0, 0, 0, 0, 140, NULL, 6),
(3704, 0, 0, 0, 'Darashia House 8', 0, 13, 0, 0, 0, 0, 81, NULL, 4),
(3705, 0, 0, 0, 'Darashia House 9', 0, 13, 0, 0, 0, 0, 58, NULL, 4),
(3706, 0, 0, 0, 'Darashia House 10', 0, 13, 0, 0, 0, 0, 66, NULL, 4),
(3707, 0, 0, 0, 'Darashia House 11', 0, 13, 0, 0, 0, 0, 55, NULL, 4),
(3708, 0, 0, 0, 'Darashia House 12', 0, 13, 0, 0, 0, 0, 69, NULL, 4),
(3709, 0, 0, 0, 'Darashia House 13', 0, 13, 0, 0, 0, 0, 48, NULL, 4),
(3710, 0, 0, 0, 'Darashia House 15', 0, 13, 0, 0, 0, 0, 48, NULL, 2),
(3711, 0, 0, 0, 'Darashia House 16', 0, 13, 0, 0, 0, 0, 66, NULL, 4),
(3712, 0, 0, 0, 'Darashia House 17', 0, 13, 0, 0, 0, 0, 35, NULL, 4),
(3713, 0, 0, 0, 'Darashia House 18', 0, 13, 0, 0, 0, 0, 60, NULL, 4),
(3714, 0, 0, 0, 'Darashia House 19', 0, 13, 0, 0, 0, 0, 85, NULL, 10),
(3715, 0, 0, 0, 'Darashia House 20', 0, 13, 0, 0, 0, 0, 30, NULL, 2),
(3716, 0, 0, 0, 'Darashia House 21', 0, 13, 0, 0, 0, 0, 89, NULL, 6),
(3717, 0, 0, 0, 'Darashia House 23', 0, 13, 0, 0, 0, 0, 38, NULL, 4),
(3718, 0, 0, 0, 'Darashia House 24', 0, 13, 0, 0, 0, 0, 40, NULL, 2),
(3719, 0, 0, 0, 'Darashia House 25', 0, 13, 0, 0, 0, 0, 43, NULL, 2),
(3720, 0, 0, 0, 'Darashia House 26', 0, 13, 0, 0, 0, 0, 35, NULL, 2),
(3721, 0, 0, 0, 'Darashia House 27', 0, 13, 0, 0, 0, 0, 54, NULL, 2),
(3722, 0, 0, 0, 'Darashia House 28', 0, 13, 0, 0, 0, 0, 23, NULL, 2),
(3723, 0, 0, 0, 'Darashia House 29', 0, 13, 0, 0, 0, 0, 45, NULL, 4),
(3724, 0, 0, 0, 'Darashia House 30', 0, 13, 0, 0, 0, 0, 26, NULL, 2),
(3725, 0, 0, 0, 'Darashia House 31', 0, 13, 0, 0, 0, 0, 42, NULL, 2),
(3726, 0, 0, 0, 'Darashia House 32', 0, 13, 0, 0, 0, 0, 20, NULL, 2),
(3727, 0, 0, 0, 'Darashia House 33', 0, 13, 0, 0, 0, 0, 40, NULL, 4),
(3728, 0, 0, 0, 'Darashia House 34', 0, 13, 0, 0, 0, 0, 26, NULL, 2),
(3729, 0, 0, 0, 'Darashia House 35', 0, 13, 0, 0, 0, 0, 39, NULL, 2),
(3730, 0, 0, 0, 'Darashia House 36', 0, 13, 0, 0, 0, 0, 26, NULL, 2),
(3731, 0, 0, 0, 'Darashia House 37', 0, 13, 0, 0, 0, 0, 15, NULL, 2),
(3732, 0, 0, 0, 'Darashia House 38', 0, 13, 0, 0, 0, 0, 36, NULL, 2),
(3733, 0, 0, 0, 'Darashia House 39', 0, 13, 0, 0, 0, 0, 40, NULL, 4),
(3734, 0, 0, 0, 'Darashia House 40', 0, 13, 0, 0, 0, 0, 42, NULL, 4),
(3735, 0, 0, 0, 'Darashia House 41', 0, 13, 0, 0, 0, 0, 41, NULL, 2),
(3736, 0, 0, 0, 'Darashia House 42', 0, 13, 0, 0, 0, 0, 105, NULL, 8),
(3737, 0, 0, 0, 'Darashia House 43', 0, 13, 0, 0, 0, 0, 45, NULL, 2),
(3738, 0, 0, 0, 'Darashia House 44', 0, 13, 0, 0, 0, 0, 60, NULL, 4),
(3739, 0, 0, 0, 'Darashia House 45', 0, 13, 0, 0, 0, 0, 33, NULL, 4),
(3740, 0, 0, 0, 'Darashia House 46', 0, 13, 0, 0, 0, 0, 86, NULL, 9),
(3741, 0, 0, 0, 'Darashia House 47', 0, 13, 0, 0, 0, 0, 61, NULL, 4),
(3742, 0, 0, 0, 'Darashia House 48', 0, 13, 0, 0, 0, 0, 72, NULL, 4),
(3743, 0, 0, 0, 'Darashia House 49', 0, 13, 0, 0, 0, 0, 39, NULL, 2),
(3744, 0, 0, 0, 'Darashia House 50', 0, 13, 0, 0, 0, 0, 72, NULL, 4),
(3745, 0, 0, 0, 'Darashia House 51', 0, 13, 0, 0, 0, 0, 40, NULL, 4),
(3746, 0, 0, 0, 'Darashia House 52', 0, 13, 0, 0, 0, 0, 48, NULL, 2),
(3747, 0, 0, 0, 'Darashia House 53', 0, 13, 0, 0, 0, 0, 48, NULL, 2),
(3748, 0, 0, 0, 'Darashia House 54', 0, 13, 0, 0, 0, 0, 48, NULL, 4),
(3749, 0, 0, 0, 'Darashia House 55', 0, 13, 0, 0, 0, 0, 36, NULL, 2),
(3750, 0, 0, 0, 'Darashia House 56', 0, 13, 0, 0, 0, 0, 40, NULL, 2),
(3751, 0, 0, 0, 'Darashia House 57', 0, 13, 0, 0, 0, 0, 100, NULL, 8),
(3752, 0, 0, 0, 'Darashia House 58', 0, 13, 0, 0, 0, 0, 93, NULL, 6),
(3753, 0, 0, 0, 'Darashia House 59', 0, 13, 0, 0, 0, 0, 30, NULL, 2),
(3754, 0, 0, 0, 'Darashia House 60', 0, 13, 0, 0, 0, 0, 66, NULL, 4),
(3755, 0, 0, 0, 'Darashia House 61', 0, 13, 0, 0, 0, 0, 64, NULL, 4),
(3756, 0, 0, 0, 'Darashia House 62', 0, 13, 0, 0, 0, 0, 101, NULL, 8),
(3757, 0, 0, 0, 'Darashia House 63', 0, 13, 0, 0, 0, 0, 30, NULL, 2),
(3758, 0, 0, 0, 'Darashia House 64', 0, 13, 0, 0, 0, 0, 93, NULL, 8),
(3759, 0, 0, 0, 'Darashia House 65', 0, 13, 0, 0, 0, 0, 36, NULL, 2),
(3760, 0, 0, 0, 'Darashia Boat', 0, 13, 0, 0, 0, 0, 492, NULL, 0),
(3761, 0, 0, 0, 'Darashia House 66', 0, 13, 0, 0, 0, 0, 48, NULL, 2),
(3762, 0, 0, 0, 'Darashia House 67', 0, 13, 0, 0, 0, 0, 40, NULL, 2),
(3763, 0, 0, 0, 'Darashia House 68', 0, 13, 0, 0, 0, 0, 65, NULL, 4),
(3764, 0, 0, 0, 'Darashia House 69', 0, 13, 0, 0, 0, 0, 41, NULL, 2),
(3765, 0, 0, 0, 'Darashia House 70', 0, 13, 0, 0, 0, 0, 65, NULL, 4),
(3766, 0, 0, 0, 'Darashia House 71', 0, 13, 0, 0, 0, 0, 111, NULL, 4),
(3767, 0, 0, 0, 'Darashia House 72', 0, 13, 0, 0, 0, 0, 118, NULL, 4),
(3768, 0, 0, 0, 'Darashia House 73', 0, 13, 0, 0, 0, 0, 64, NULL, 4),
(3769, 0, 0, 0, 'Darashia House 74', 0, 13, 0, 0, 0, 0, 55, NULL, 4),
(3770, 0, 0, 0, 'Darashia House 75', 0, 13, 0, 0, 0, 0, 61, NULL, 4),
(3771, 0, 0, 0, 'Darashia House 76', 0, 13, 0, 0, 0, 0, 63, NULL, 4),
(3772, 0, 0, 0, 'Ankrahmun House 1', 0, 10, 0, 0, 0, 0, 69, NULL, 6),
(3773, 0, 0, 0, 'Ankrahmun House 2', 0, 10, 0, 0, 0, 0, 125, NULL, 6),
(3774, 0, 0, 0, 'Ankrahmun House 3', 0, 10, 0, 0, 0, 0, 51, NULL, 4),
(3775, 0, 0, 0, 'Ankrahmun House 4', 0, 10, 0, 0, 0, 0, 28, NULL, 4),
(3776, 0, 0, 0, 'Ankrahmun House 5', 0, 10, 0, 0, 0, 0, 55, NULL, 4),
(3777, 0, 0, 0, 'Ankrahmun House 6', 0, 10, 0, 0, 0, 0, 33, NULL, 2),
(3778, 0, 0, 0, 'Ankrahmun House 8', 0, 10, 0, 0, 0, 0, 82, NULL, 8),
(3779, 0, 0, 0, 'Ankrahmun House 7', 0, 10, 0, 0, 0, 0, 36, NULL, 4),
(3780, 0, 0, 0, 'Ankrahmun House 9', 0, 10, 0, 0, 0, 0, 36, NULL, 4),
(3781, 0, 0, 0, 'Ankrahmun House 10', 0, 10, 0, 0, 0, 0, 48, NULL, 4),
(3782, 0, 0, 0, 'Ankrahmun House 11', 0, 10, 0, 0, 0, 0, 57, NULL, 4),
(3783, 0, 0, 0, 'Ankrahmun House 12', 0, 10, 0, 0, 0, 0, 32, NULL, 4),
(3784, 0, 0, 0, 'Ankrahmun House 13', 0, 10, 0, 0, 0, 0, 31, NULL, 2),
(3785, 0, 0, 0, 'Ankrahmun House 14', 0, 10, 0, 0, 0, 0, 52, NULL, 2),
(3786, 0, 0, 0, 'Ankrahmun House 15', 0, 10, 0, 0, 0, 0, 42, NULL, 6),
(3787, 0, 0, 0, 'Ankrahmun House 16', 0, 10, 0, 0, 0, 0, 48, NULL, 4),
(3788, 0, 0, 0, 'Ankrahmun House 18', 0, 10, 0, 0, 0, 0, 45, NULL, 4),
(3789, 0, 0, 0, 'Ankrahmun House 19', 0, 10, 0, 0, 0, 0, 112, NULL, 8),
(3790, 0, 0, 0, 'Ankrahmun House 20', 0, 10, 0, 0, 0, 0, 41, NULL, 4),
(3791, 0, 0, 0, 'Ankrahmun House 21', 0, 10, 0, 0, 0, 0, 33, NULL, 4),
(3792, 0, 0, 0, 'Ankrahmun House 22', 0, 10, 0, 0, 0, 0, 31, NULL, 2),
(3793, 0, 0, 0, 'Ankrahmun House 23', 0, 10, 0, 0, 0, 0, 23, NULL, 2),
(3794, 0, 0, 0, 'Ankrahmun House 24', 0, 10, 0, 0, 0, 0, 280, NULL, 28),
(3795, 0, 0, 0, 'Ankrahmun House 25', 0, 10, 0, 0, 0, 0, 48, NULL, 4),
(3796, 0, 0, 0, 'Ankrahmun House 26', 0, 10, 0, 0, 0, 0, 36, NULL, 4),
(3797, 0, 0, 0, 'Ankrahmun House 27', 0, 10, 0, 0, 0, 0, 94, NULL, 6),
(3798, 0, 0, 0, 'Ankrahmun House 28', 0, 10, 0, 0, 0, 0, 89, NULL, 6),
(3799, 0, 0, 0, 'Ankrahmun House 29', 0, 10, 0, 0, 0, 0, 37, NULL, 2),
(3800, 0, 0, 0, 'Ankrahmun House 30', 0, 10, 0, 0, 0, 0, 165, NULL, 32),
(3801, 0, 0, 0, 'Ankrahmun House 31', 0, 10, 0, 0, 0, 0, 45, NULL, 4),
(3802, 0, 0, 0, 'Ankrahmun House 32', 0, 10, 0, 0, 0, 0, 21, NULL, 2),
(3803, 0, 0, 0, 'Ankrahmun House 33', 0, 10, 0, 0, 0, 0, 49, NULL, 4),
(3804, 0, 0, 0, 'Ankrahmun House 34', 0, 10, 0, 0, 0, 0, 18, NULL, 2),
(3805, 0, 0, 0, 'Ankrahmun House 35', 0, 10, 0, 0, 0, 0, 133, NULL, 16),
(3806, 0, 0, 0, 'Ankrahmun House 36', 0, 10, 0, 0, 0, 0, 24, NULL, 2),
(3807, 0, 0, 0, 'Ankrahmun House 37', 0, 10, 0, 0, 0, 0, 50, NULL, 4),
(3808, 0, 0, 0, 'Ankrahmun House 38', 0, 10, 0, 0, 0, 0, 25, NULL, 2),
(3809, 0, 0, 0, 'Ankrahmun House 39', 0, 10, 0, 0, 0, 0, 29, NULL, 2),
(3810, 0, 0, 0, 'Ankrahmun House 40', 0, 10, 0, 0, 0, 0, 42, NULL, 2),
(3811, 0, 0, 0, 'Ankrahmun House 41', 0, 10, 0, 0, 0, 0, 45, NULL, 4),
(3812, 0, 0, 0, 'Ankrahmun House 42', 0, 10, 0, 0, 0, 0, 23, NULL, 4),
(3813, 0, 0, 0, 'Ankrahmun House 43', 0, 10, 0, 0, 0, 0, 23, NULL, 4),
(3814, 0, 0, 0, 'Ankrahmun House 44', 0, 10, 0, 0, 0, 0, 23, NULL, 2),
(3815, 0, 0, 0, 'Ankrahmun House 45', 0, 10, 0, 0, 0, 0, 29, NULL, 2),
(3816, 0, 0, 0, 'Ankrahmun House 46', 0, 10, 0, 0, 0, 0, 24, NULL, 2),
(3817, 0, 0, 0, 'Ankrahmun House 47', 0, 10, 0, 0, 0, 0, 25, NULL, 2),
(3818, 0, 0, 0, 'Ankrahmun House 48', 0, 10, 0, 0, 0, 0, 50, NULL, 4),
(3819, 0, 0, 0, 'Ankrahmun House 49', 0, 10, 0, 0, 0, 0, 45, NULL, 2),
(3820, 0, 0, 0, 'Ankrahmun House 50', 0, 10, 0, 0, 0, 0, 50, NULL, 4),
(3821, 0, 0, 0, 'Ankrahmun House 51', 0, 10, 0, 0, 0, 0, 40, NULL, 4),
(3822, 0, 0, 0, 'Ankrahmun House 52', 0, 10, 0, 0, 0, 0, 42, NULL, 2),
(3823, 0, 0, 0, 'Ankrahmun House 53', 0, 10, 0, 0, 0, 0, 41, NULL, 6),
(3824, 0, 0, 0, 'Ankrahmun House 54', 0, 10, 0, 0, 0, 0, 49, NULL, 6),
(3825, 0, 0, 0, 'Ankrahmun House 55', 0, 10, 0, 0, 0, 0, 43, NULL, 4),
(3826, 0, 0, 0, 'Ankrahmun House 56', 0, 10, 0, 0, 0, 0, 42, NULL, 4),
(3827, 0, 0, 0, 'Ankrahmun House 57', 0, 10, 0, 0, 0, 0, 52, NULL, 2),
(3828, 0, 0, 0, 'Ankrahmun House 58', 0, 10, 0, 0, 0, 0, 62, NULL, 4),
(3829, 0, 0, 0, 'Ankrahmun House 59', 0, 10, 0, 0, 0, 0, 54, NULL, 4),
(3830, 0, 0, 0, 'Ankrahmun House 60', 0, 10, 0, 0, 0, 0, 38, NULL, 4),
(3831, 0, 0, 0, 'Ankrahmun House 61', 0, 10, 0, 0, 0, 0, 33, NULL, 4),
(3832, 0, 0, 0, 'Ankrahmun House 62', 0, 10, 0, 0, 0, 0, 36, NULL, 2),
(3833, 0, 0, 0, 'Ankrahmun House 63', 0, 10, 0, 0, 0, 0, 28, NULL, 2),
(3834, 0, 0, 0, 'Ankrahmun House 64', 0, 10, 0, 0, 0, 0, 28, NULL, 2),
(3835, 0, 0, 0, 'Ankrahmun House 65', 0, 10, 0, 0, 0, 0, 51, NULL, 4),
(3836, 0, 0, 0, 'Ankrahmun House 66', 0, 10, 0, 0, 0, 0, 19, NULL, 2),
(3837, 0, 0, 0, 'Ankrahmun House 67', 0, 10, 0, 0, 0, 0, 19, NULL, 2),
(3838, 0, 0, 0, 'Ankrahmun House 68', 0, 10, 0, 0, 0, 0, 67, NULL, 6),
(3839, 0, 0, 0, 'Ankrahmun House 69', 0, 10, 0, 0, 0, 0, 35, NULL, 2),
(3840, 0, 0, 0, 'Ankrahmun House 70', 0, 10, 0, 0, 0, 0, 39, NULL, 2),
(3841, 0, 0, 0, 'Ankrahmun House 71', 0, 10, 0, 0, 0, 0, 42, NULL, 4),
(3842, 0, 0, 0, 'Ankrahmun House 72', 0, 10, 0, 0, 0, 0, 42, NULL, 4),
(3843, 0, 0, 0, 'Ankrahmun House 73', 0, 10, 0, 0, 0, 0, 41, NULL, 4),
(3844, 0, 0, 0, 'Ankrahmun House 74', 0, 10, 0, 0, 0, 0, 51, NULL, 4),
(3845, 0, 0, 0, 'Ankrahmun House 75', 0, 10, 0, 0, 0, 0, 18, NULL, 2),
(3846, 0, 0, 0, 'Ankrahmun House 76', 0, 10, 0, 0, 0, 0, 63, NULL, 6),
(3847, 0, 0, 0, 'Ankrahmun House 77', 0, 10, 0, 0, 0, 0, 66, NULL, 8),
(3848, 0, 0, 0, 'Ankrahmun House 78', 0, 10, 0, 0, 0, 0, 49, NULL, 4),
(3849, 0, 0, 0, 'Ankrahmun House 79', 0, 10, 0, 0, 0, 0, 20, NULL, 2),
(3851, 0, 0, 0, 'Ankrahmun House 80', 0, 10, 0, 0, 0, 0, 190, NULL, 20),
(3852, 0, 0, 0, 'Ankrahmun House 81', 0, 10, 0, 0, 0, 0, 82, NULL, 6),
(3853, 0, 0, 0, 'Ankrahmun House 82', 0, 10, 0, 0, 0, 0, 83, NULL, 8),
(3854, 0, 0, 0, 'Ankrahmun House 83', 0, 10, 0, 0, 0, 0, 74, NULL, 6),
(3855, 0, 0, 0, 'Ankrahmun House 84', 0, 10, 0, 0, 0, 0, 34, NULL, 2),
(3856, 0, 0, 0, 'Ankrahmun House 85', 0, 10, 0, 0, 0, 0, 28, NULL, 2),
(3857, 0, 0, 0, 'Ankrahmun House 86', 0, 10, 0, 0, 0, 0, 13, NULL, 2),
(3858, 0, 0, 0, 'Ankrahmun House 87', 0, 10, 0, 0, 0, 0, 18, NULL, 2),
(3859, 0, 0, 0, 'Ankrahmun House 88', 0, 10, 0, 0, 0, 0, 12, NULL, 2),
(3860, 0, 0, 0, 'Ankrahmun House 89', 0, 10, 0, 0, 0, 0, 19, NULL, 2),
(3861, 0, 0, 0, 'Ankrahmun House 90', 0, 10, 0, 0, 0, 0, 87, NULL, 6),
(3862, 0, 0, 0, 'Ankrahmun House 91', 0, 10, 0, 0, 0, 0, 36, NULL, 4),
(3863, 0, 0, 0, 'Ankrahmun House 92', 0, 10, 0, 0, 0, 0, 36, NULL, 4),
(3864, 0, 0, 0, 'Ankrahmun House 93', 0, 10, 0, 0, 0, 0, 27, NULL, 4),
(3865, 0, 0, 0, 'Ankrahmun House 94', 0, 10, 0, 0, 0, 0, 21, NULL, 2),
(3866, 0, 0, 0, 'Ankrahmun House 95', 0, 10, 0, 0, 0, 0, 20, NULL, 2),
(3867, 0, 0, 0, 'Ankrahmun House 96', 0, 10, 0, 0, 0, 0, 28, NULL, 2),
(3868, 0, 0, 0, 'Ankrahmun House 97', 0, 10, 0, 0, 0, 0, 42, NULL, 4),
(3869, 0, 0, 0, 'Ankrahmun House 98', 0, 10, 0, 0, 0, 0, 35, NULL, 2),
(3870, 0, 0, 0, 'Ankrahmun House 99', 0, 10, 0, 0, 0, 0, 28, NULL, 2),
(3871, 0, 0, 0, 'Ankrahmun House 100', 0, 10, 0, 0, 0, 0, 61, NULL, 6),
(3872, 0, 0, 0, 'Ankrahmun House 101', 0, 10, 0, 0, 0, 0, 42, NULL, 4),
(3873, 0, 0, 0, 'Ankrahmun House 102', 0, 10, 0, 0, 0, 0, 30, NULL, 2),
(3874, 0, 0, 0, 'Ankrahmun House 103', 0, 10, 0, 0, 0, 0, 35, NULL, 2),
(3875, 0, 0, 0, 'Ankrahmun House 104', 0, 10, 0, 0, 0, 0, 34, NULL, 2),
(3876, 0, 0, 0, 'Ankrahmun House 105', 0, 10, 0, 0, 0, 0, 31, NULL, 2),
(3877, 0, 0, 0, 'Ankrahmun House 106', 0, 10, 0, 0, 0, 0, 28, NULL, 2),
(3878, 0, 0, 0, 'Ankrahmun House 107', 0, 10, 0, 0, 0, 0, 40, NULL, 4),
(3879, 0, 0, 0, 'Ankrahmun House 108', 0, 10, 0, 0, 0, 0, 30, NULL, 2),
(3880, 0, 0, 0, 'Ankrahmun House 109', 0, 10, 0, 0, 0, 0, 51, NULL, 4),
(3882, 0, 0, 0, 'Ankrahmun House 110', 0, 10, 0, 0, 0, 0, 21, NULL, 2),
(3883, 0, 0, 0, 'Ankrahmun House 111', 0, 10, 0, 0, 0, 0, 25, NULL, 2),
(3884, 0, 0, 0, 'Ankrahmun House 112', 0, 10, 0, 0, 0, 0, 21, NULL, 2),
(3885, 0, 0, 0, 'Ankrahmun House 113', 0, 10, 0, 0, 0, 0, 21, NULL, 2),
(3886, 0, 0, 0, 'Ankrahmun House 114', 0, 10, 0, 0, 0, 0, 33, NULL, 2),
(3887, 0, 0, 0, 'Ankrahmun House 115', 0, 10, 0, 0, 0, 0, 82, NULL, 6),
(3888, 0, 0, 0, 'Ankrahmun House 116', 0, 10, 0, 0, 0, 0, 33, NULL, 4),
(3889, 0, 0, 0, 'Ankrahmun House 117', 0, 10, 0, 0, 0, 0, 35, NULL, 2),
(3890, 0, 0, 0, 'Ankrahmun House 118', 0, 10, 0, 0, 0, 0, 29, NULL, 4),
(3891, 0, 0, 0, 'Ankrahmun House 120', 0, 10, 0, 0, 0, 0, 18, NULL, 2),
(3892, 0, 0, 0, 'Liberty Bay House 1', 0, 14, 0, 0, 0, 0, 403, NULL, 0),
(3893, 0, 0, 0, 'Liberty Bay House 2', 0, 14, 0, 0, 0, 0, 179, NULL, 4),
(3894, 0, 0, 0, 'Liberty Bay House 3', 0, 14, 0, 0, 0, 0, 157, NULL, 4),
(3895, 0, 0, 0, 'Liberty Bay House 4', 0, 14, 0, 0, 0, 0, 150, NULL, 4),
(3896, 0, 0, 0, 'Liberty Bay House 5', 0, 14, 0, 0, 0, 0, 189, NULL, 8),
(3897, 0, 0, 0, 'Liberty Bay House 6', 0, 14, 0, 0, 0, 0, 146, NULL, 4),
(3898, 0, 0, 0, 'Liberty Bay House 7', 0, 14, 0, 0, 0, 0, 123, NULL, 4),
(3899, 0, 0, 0, 'Liberty Bay House 8', 0, 14, 0, 0, 0, 0, 163, NULL, 8),
(3900, 0, 0, 0, 'Liberty Bay House 10', 0, 14, 0, 0, 0, 0, 156, NULL, 4),
(3901, 0, 0, 0, 'Liberty Bay House 11', 0, 14, 0, 0, 0, 0, 48, NULL, 4),
(3902, 0, 0, 0, 'Liberty Bay House 12', 0, 14, 0, 0, 0, 0, 82, NULL, 4),
(3903, 0, 0, 0, 'Liberty Bay House 13', 0, 14, 0, 0, 0, 0, 77, NULL, 4),
(3904, 0, 0, 0, 'Liberty Bay House 14', 0, 14, 0, 0, 0, 0, 69, NULL, 8),
(3905, 0, 0, 0, 'Liberty Bay House 15', 0, 14, 0, 0, 0, 0, 48, NULL, 4),
(3906, 0, 0, 0, 'Liberty Bay House 16', 0, 14, 0, 0, 0, 0, 46, NULL, 4),
(3907, 0, 0, 0, 'Liberty Bay House 17', 0, 14, 0, 0, 0, 0, 115, NULL, 6),
(3908, 0, 0, 0, 'Liberty Bay House 18', 0, 14, 0, 0, 0, 0, 129, NULL, 10),
(3909, 0, 0, 0, 'Liberty Bay House 19', 0, 14, 0, 0, 0, 0, 33, NULL, 4),
(3910, 0, 0, 0, 'Liberty Bay House 20', 0, 14, 0, 0, 0, 0, 29, NULL, 2),
(3911, 0, 0, 0, 'Liberty Bay House 22', 0, 14, 0, 0, 0, 0, 63, NULL, 4),
(3912, 0, 0, 0, 'Liberty Bay House 23', 0, 14, 0, 0, 0, 0, 473, NULL, 62),
(3913, 0, 0, 0, 'Liberty Bay House 24', 0, 14, 0, 0, 0, 0, 25, NULL, 4),
(3914, 0, 0, 0, 'Liberty Bay House 25', 0, 14, 0, 0, 0, 0, 20, NULL, 2),
(3915, 0, 0, 0, 'Liberty Bay House 26', 0, 14, 0, 0, 0, 0, 35, NULL, 2),
(3916, 0, 0, 0, 'Liberty Bay House 27', 0, 14, 0, 0, 0, 0, 30, NULL, 2),
(3917, 0, 0, 0, 'Liberty Bay House 28', 0, 14, 0, 0, 0, 0, 35, NULL, 4),
(3918, 0, 0, 0, 'Liberty Bay House 29', 0, 14, 0, 0, 0, 0, 25, NULL, 2),
(3919, 0, 0, 0, 'Liberty Bay House 30', 0, 14, 0, 0, 0, 0, 46, NULL, 4),
(3920, 0, 0, 0, 'Liberty Bay House 31', 0, 14, 0, 0, 0, 0, 28, NULL, 2),
(3921, 0, 0, 0, 'Liberty Bay House 32', 0, 14, 0, 0, 0, 0, 30, NULL, 4),
(3922, 0, 0, 0, 'Liberty Bay House 34', 0, 14, 0, 0, 0, 0, 48, NULL, 2),
(3923, 0, 0, 0, 'Liberty Bay House 35', 0, 14, 0, 0, 0, 0, 24, NULL, 2),
(3924, 0, 0, 0, 'Liberty Bay House 36', 0, 14, 0, 0, 0, 0, 23, NULL, 2),
(3925, 0, 0, 0, 'Liberty Bay House 37', 0, 14, 0, 0, 0, 0, 33, NULL, 2),
(3926, 0, 0, 0, 'Liberty Bay House 38', 0, 14, 0, 0, 0, 0, 34, NULL, 4),
(3927, 0, 0, 0, 'Liberty Bay House 39', 0, 14, 0, 0, 0, 0, 24, NULL, 2),
(3928, 0, 0, 0, 'Liberty Bay House 40', 0, 14, 0, 0, 0, 0, 48, NULL, 10),
(3929, 0, 0, 0, 'Liberty Bay House 41', 0, 14, 0, 0, 0, 0, 30, NULL, 4),
(3930, 0, 0, 0, 'Liberty Bay House 42', 0, 14, 0, 0, 0, 0, 30, NULL, 2),
(3931, 0, 0, 0, 'Liberty Bay House 43', 0, 14, 0, 0, 0, 0, 38, NULL, 4),
(3932, 0, 0, 0, 'Liberty Bay House 44', 0, 14, 0, 0, 0, 0, 40, NULL, 4),
(3933, 0, 0, 0, 'Liberty Bay House 45', 0, 14, 0, 0, 0, 0, 33, NULL, 4),
(3934, 0, 0, 0, 'Liberty Bay House 46', 0, 14, 0, 0, 0, 0, 93, NULL, 6),
(3935, 0, 0, 0, 'Liberty Bay House 47', 0, 14, 0, 0, 0, 0, 65, NULL, 6),
(3936, 0, 0, 0, 'Liberty Bay House 48', 0, 14, 0, 0, 0, 0, 57, NULL, 6),
(3937, 0, 0, 0, 'Liberty Bay House 49', 0, 14, 0, 0, 0, 0, 51, NULL, 6),
(3938, 0, 0, 0, 'Liberty Bay House 50', 0, 14, 0, 0, 0, 0, 30, NULL, 4),
(3939, 0, 0, 0, 'Liberty Bay House 51', 0, 14, 0, 0, 0, 0, 28, NULL, 4),
(3940, 0, 0, 0, 'Liberty Bay House 52', 0, 14, 0, 0, 0, 0, 27, NULL, 4),
(3941, 0, 0, 0, 'Liberty Bay House 53', 0, 14, 0, 0, 0, 0, 27, NULL, 2),
(3942, 0, 0, 0, 'Liberty Bay House 54', 0, 14, 0, 0, 0, 0, 165, NULL, 8),
(3943, 0, 0, 0, 'Liberty Bay House 55', 0, 14, 0, 0, 0, 0, 181, NULL, 6),
(3944, 0, 0, 0, 'Liberty Bay House 56', 0, 14, 0, 0, 0, 0, 214, NULL, 8),
(3945, 0, 0, 0, 'Liberty Bay House 57', 0, 14, 0, 0, 0, 0, 29, NULL, 4),
(3946, 0, 0, 0, 'Liberty Bay House 58', 0, 14, 0, 0, 0, 0, 30, NULL, 4),
(3947, 0, 0, 0, 'Liberty Bay House 59', 0, 14, 0, 0, 0, 0, 28, NULL, 4),
(3948, 0, 0, 0, 'Liberty Bay House 60', 0, 14, 0, 0, 0, 0, 23, NULL, 4),
(3949, 0, 0, 0, 'Liberty Bay House 61', 0, 14, 0, 0, 0, 0, 36, NULL, 4),
(3950, 0, 0, 0, 'Liberty Bay House 62', 0, 14, 0, 0, 0, 0, 30, NULL, 4),
(3951, 0, 0, 0, 'Liberty Bay House 63', 0, 14, 0, 0, 0, 0, 25, NULL, 4),
(3952, 0, 0, 0, 'Liberty Bay House 64', 0, 14, 0, 0, 0, 0, 25, NULL, 4),
(3953, 0, 0, 0, 'Liberty Bay House 65', 0, 14, 0, 0, 0, 0, 25, NULL, 4),
(3954, 0, 0, 0, 'Liberty Bay House 66', 0, 14, 0, 0, 0, 0, 35, NULL, 4),
(3955, 0, 0, 0, 'Liberty Bay House 67', 0, 14, 0, 0, 0, 0, 27, NULL, 4),
(3956, 0, 0, 0, 'Liberty Bay House 68', 0, 14, 0, 0, 0, 0, 31, NULL, 4),
(3957, 0, 0, 0, 'Liberty Bay House 69', 0, 14, 0, 0, 0, 0, 292, NULL, 12),
(3958, 0, 0, 0, 'Liberty Bay House 70', 0, 14, 0, 0, 0, 0, 794, NULL, 52),
(3959, 0, 0, 0, 'Liberty Bay House 71', 0, 14, 0, 0, 0, 0, 472, NULL, 33),
(3960, 0, 0, 0, 'Port Hope House 1', 0, 19, 0, 0, 0, 0, 29, NULL, 2),
(3961, 0, 0, 0, 'Port Hope House 2', 0, 19, 0, 0, 0, 0, 25, NULL, 2),
(3962, 0, 0, 0, 'Port Hope House 3', 0, 19, 0, 0, 0, 0, 25, NULL, 2),
(3963, 0, 0, 0, 'Port Hope House 4', 0, 19, 0, 0, 0, 0, 25, NULL, 2),
(3964, 0, 0, 0, 'Port Hope House 5', 0, 19, 0, 0, 0, 0, 38, NULL, 4),
(3965, 0, 0, 0, 'Port Hope House 6', 0, 19, 0, 0, 0, 0, 30, NULL, 4),
(3966, 0, 0, 0, 'Port Hope House 7', 0, 19, 0, 0, 0, 0, 49, NULL, 4),
(3967, 0, 0, 0, 'Port Hope House 8', 0, 19, 0, 0, 0, 0, 183, NULL, 8),
(3968, 0, 0, 0, 'Port Hope House 9', 0, 19, 0, 0, 0, 0, 138, NULL, 4),
(3969, 0, 0, 0, 'Port Hope House 10', 0, 19, 0, 0, 0, 0, 34, NULL, 2),
(3970, 0, 0, 0, 'Port Hope House 11', 0, 19, 0, 0, 0, 0, 29, NULL, 2),
(3971, 0, 0, 0, 'Port Hope House 12', 0, 19, 0, 0, 0, 0, 62, NULL, 4),
(3972, 0, 0, 0, 'Port Hope House 13', 0, 19, 0, 0, 0, 0, 18, NULL, 2),
(3973, 0, 0, 0, 'Port Hope House 14', 0, 19, 0, 0, 0, 0, 71, NULL, 2),
(3974, 0, 0, 0, 'Port Hope House 15', 0, 19, 0, 0, 0, 0, 851, NULL, 40),
(3975, 0, 0, 0, 'Port Hope House 16', 0, 19, 0, 0, 0, 0, 63, NULL, 4),
(3976, 0, 0, 0, 'Port Hope House 17', 0, 19, 0, 0, 0, 0, 35, NULL, 4),
(3977, 0, 0, 0, 'Port Hope House 18', 0, 19, 0, 0, 0, 0, 25, NULL, 4),
(3978, 0, 0, 0, 'Port Hope House 19', 0, 19, 0, 0, 0, 0, 42, NULL, 4),
(3979, 0, 0, 0, 'Port Hope House 20', 0, 19, 0, 0, 0, 0, 30, NULL, 4),
(3980, 0, 0, 0, 'Port Hope House 21', 0, 19, 0, 0, 0, 0, 80, NULL, 6),
(3981, 0, 0, 0, 'Port Hope House 22', 0, 19, 0, 0, 0, 0, 114, NULL, 6),
(3982, 0, 0, 0, 'Port Hope House 27', 0, 19, 0, 0, 0, 0, 36, NULL, 4),
(3983, 0, 0, 0, 'Port Hope House 23', 0, 19, 0, 0, 0, 0, 35, NULL, 4),
(3984, 0, 0, 0, 'Port Hope House 24', 0, 19, 0, 0, 0, 0, 36, NULL, 4),
(3986, 0, 0, 0, 'Port Hope House 25', 0, 19, 0, 0, 0, 0, 25, NULL, 2),
(3987, 0, 0, 0, 'Port Hope House 26', 0, 19, 0, 0, 0, 0, 168, NULL, 14),
(3988, 0, 0, 0, 'Port Hope House 28', 0, 19, 0, 0, 0, 0, 49, NULL, 4),
(3989, 0, 0, 0, 'Port Hope House 29', 0, 19, 0, 0, 0, 0, 49, NULL, 6),
(3990, 0, 0, 0, 'Port Hope House 30', 0, 19, 0, 0, 0, 0, 108, NULL, 6),
(3991, 0, 0, 0, 'Port Hope House 31', 0, 19, 0, 0, 0, 0, 69, NULL, 6),
(3992, 0, 0, 0, 'Port Hope House 32', 0, 19, 0, 0, 0, 0, 57, NULL, 8),
(3993, 0, 0, 0, 'Port Hope House 33', 0, 19, 0, 0, 0, 0, 42, NULL, 4),
(3994, 0, 0, 0, 'Port Hope House 34', 0, 19, 0, 0, 0, 0, 61, NULL, 4),
(3995, 0, 0, 0, 'Port Hope House 35', 0, 19, 0, 0, 0, 0, 234, NULL, 30),
(3996, 0, 0, 0, 'Port Hope House 36', 0, 19, 0, 0, 0, 0, 57, NULL, 2),
(3997, 0, 0, 0, 'Port Hope House 37', 0, 19, 0, 0, 0, 0, 48, NULL, 2),
(3998, 0, 0, 0, 'Port Hope House 38', 0, 19, 0, 0, 0, 0, 48, NULL, 2),
(3999, 0, 0, 0, 'Port Hope House 39', 0, 19, 0, 0, 0, 0, 49, NULL, 4),
(4000, 0, 0, 0, 'Port Hope House 40', 0, 19, 0, 0, 0, 0, 215, NULL, 8),
(4001, 0, 0, 0, 'Port Hope House 41', 0, 19, 0, 0, 0, 0, 219, NULL, 0),
(4002, 0, 0, 0, 'Port Hope House 42', 0, 19, 0, 0, 0, 0, 253, NULL, 0),
(4003, 0, 0, 0, 'Port Hope House 43', 0, 19, 0, 0, 0, 0, 184, NULL, 8),
(4004, 0, 0, 0, 'Port Hope House 44', 0, 19, 0, 0, 0, 0, 49, NULL, 2),
(4005, 0, 0, 0, 'Svargrond House 1', 0, 16, 0, 0, 0, 0, 34, NULL, 4),
(4006, 0, 0, 0, 'Svargrond House 2', 0, 16, 0, 0, 0, 0, 24, NULL, 2),
(4007, 0, 0, 0, 'Svargrond House 3', 0, 16, 0, 0, 0, 0, 30, NULL, 2),
(4008, 0, 0, 0, 'Svargrond House 4', 0, 16, 0, 0, 0, 0, 35, NULL, 4),
(4009, 0, 0, 0, 'Svargrond House 5', 0, 16, 0, 0, 0, 0, 42, NULL, 4),
(4010, 0, 0, 0, 'Svargrond House 6', 0, 16, 0, 0, 0, 0, 40, NULL, 4),
(4011, 0, 0, 0, 'Svargrond House 7', 0, 16, 0, 0, 0, 0, 89, NULL, 4),
(4012, 0, 0, 0, 'Svargrond House 8', 0, 16, 0, 0, 0, 0, 212, NULL, 0),
(4013, 0, 0, 0, 'Svargrond House 9', 0, 16, 0, 0, 0, 0, 109, NULL, 4),
(4014, 0, 0, 0, 'Svargrond House 11', 0, 16, 0, 0, 0, 0, 94, NULL, 4),
(4015, 0, 0, 0, 'Svargrond House 12', 0, 16, 0, 0, 0, 0, 137, NULL, 6),
(4016, 0, 0, 0, 'Svargrond House 13', 0, 16, 0, 0, 0, 0, 119, NULL, 8),
(4017, 0, 0, 0, 'Svargrond House 14', 0, 16, 0, 0, 0, 0, 77, NULL, 8),
(4018, 0, 0, 0, 'Svargrond House 16', 0, 16, 0, 0, 0, 0, 71, NULL, 4),
(4019, 0, 0, 0, 'Svargrond House 17', 0, 16, 0, 0, 0, 0, 85, NULL, 4),
(4020, 0, 0, 0, 'Svargrond House 18', 0, 16, 0, 0, 0, 0, 582, NULL, 40),
(4021, 0, 0, 0, 'Svargrond House 19', 0, 16, 0, 0, 0, 0, 109, NULL, 6),
(4022, 0, 0, 0, 'Svargrond House 20', 0, 16, 0, 0, 0, 0, 54, NULL, 4),
(4023, 0, 0, 0, 'Svargrond House 21', 0, 16, 0, 0, 0, 0, 120, NULL, 4),
(4024, 0, 0, 0, 'Svargrond House 22', 0, 16, 0, 0, 0, 0, 56, NULL, 4),
(4025, 0, 0, 0, 'Svargrond House 24', 0, 16, 0, 0, 0, 0, 48, NULL, 2),
(4026, 0, 0, 0, 'Svargrond House 23', 0, 16, 0, 0, 0, 0, 42, NULL, 4),
(4027, 0, 0, 0, 'Svargrond House 25', 0, 16, 0, 0, 0, 0, 68, NULL, 4),
(4028, 0, 0, 0, 'Svargrond House 26', 0, 16, 0, 0, 0, 0, 107, NULL, 6),
(4029, 0, 0, 0, 'Svargrond House 27', 0, 16, 0, 0, 0, 0, 64, NULL, 4),
(4030, 0, 0, 0, 'Svargrond House 28', 0, 16, 0, 0, 0, 0, 134, NULL, 6),
(4031, 0, 0, 0, 'Svargrond House 29', 0, 16, 0, 0, 0, 0, 74, NULL, 4),
(4032, 0, 0, 0, 'Svargrond House 30', 0, 16, 0, 0, 0, 0, 62, NULL, 2),
(4033, 0, 0, 0, 'Svargrond House 31', 0, 16, 0, 0, 0, 0, 139, NULL, 6),
(4034, 0, 0, 0, 'Svargrond House 32', 0, 16, 0, 0, 0, 0, 65, NULL, 6),
(4035, 0, 0, 0, 'Svargrond House 33', 0, 16, 0, 0, 0, 0, 43, NULL, 2),
(4036, 0, 0, 0, 'Svargrond House 34', 0, 16, 0, 0, 0, 0, 40, NULL, 2),
(4037, 0, 0, 0, 'Svargrond House 35', 0, 16, 0, 0, 0, 0, 79, NULL, 6),
(4038, 0, 0, 0, 'Svargrond House 36', 0, 16, 0, 0, 0, 0, 167, NULL, 8),
(4039, 0, 0, 0, 'Svargrond House 37', 0, 16, 0, 0, 0, 0, 78, NULL, 6),
(4040, 0, 0, 0, 'Svargrond House 38', 0, 16, 0, 0, 0, 0, 25, NULL, 4),
(4041, 0, 0, 0, 'Svargrond House 39', 0, 16, 0, 0, 0, 0, 24, NULL, 2),
(4042, 0, 0, 0, 'Svargrond House 40', 0, 16, 0, 0, 0, 0, 24, NULL, 2),
(4043, 0, 0, 0, 'Svargrond House 41', 0, 16, 0, 0, 0, 0, 24, NULL, 4),
(4044, 0, 0, 0, 'Svargrond House 42', 0, 16, 0, 0, 0, 0, 26, NULL, 4),
(4045, 0, 0, 0, 'Svargrond House 43', 0, 16, 0, 0, 0, 0, 18, NULL, 2),
(4046, 0, 0, 0, 'Svargrond House 44', 0, 16, 0, 0, 0, 0, 20, NULL, 2),
(4047, 0, 0, 0, 'Svargrond House 45', 0, 16, 0, 0, 0, 0, 20, NULL, 4),
(4048, 0, 0, 0, 'Svargrond House 46', 0, 16, 0, 0, 0, 0, 18, NULL, 2),
(4049, 0, 0, 0, 'Svargrond House 47', 0, 16, 0, 0, 0, 0, 15, NULL, 2),
(4050, 0, 0, 0, 'Svargrond House 48', 0, 16, 0, 0, 0, 0, 99, NULL, 4),
(4051, 0, 0, 0, 'Svargrond House 49', 0, 16, 0, 0, 0, 0, 63, NULL, 4),
(4052, 0, 0, 0, 'Svargrond House 50', 0, 16, 0, 0, 0, 0, 135, NULL, 4),
(4053, 0, 0, 0, 'Svargrond House 51', 0, 16, 0, 0, 0, 0, 36, NULL, 2),
(4054, 0, 0, 0, 'Svargrond House 52', 0, 16, 0, 0, 0, 0, 45, NULL, 2),
(4055, 0, 0, 0, 'Svargrond House 53', 0, 16, 0, 0, 0, 0, 42, NULL, 4),
(4056, 0, 0, 0, 'Svargrond House 54', 0, 16, 0, 0, 0, 0, 68, NULL, 4),
(4057, 0, 0, 0, 'Svargrond House 55', 0, 16, 0, 0, 0, 0, 574, NULL, 60),
(4058, 0, 0, 0, 'Svargrond House 56', 0, 16, 0, 0, 0, 0, 56, NULL, 4),
(4059, 0, 0, 0, 'Svargrond House 57', 0, 16, 0, 0, 0, 0, 54, NULL, 4),
(4060, 0, 0, 0, 'Svargrond House 58', 0, 16, 0, 0, 0, 0, 65, NULL, 4),
(4061, 0, 0, 0, 'Svargrond House 59', 0, 16, 0, 0, 0, 0, 56, NULL, 4),
(4062, 0, 0, 0, 'Svargrond House 60', 0, 16, 0, 0, 0, 0, 84, NULL, 6),
(4063, 0, 0, 0, 'Svargrond House 61', 0, 16, 0, 0, 0, 0, 56, NULL, 4),
(4064, 0, 0, 0, 'Svargrond House 62', 0, 16, 0, 0, 0, 0, 48, NULL, 4),
(4065, 0, 0, 0, 'Svargrond House 63', 0, 16, 0, 0, 0, 0, 736, NULL, 48),
(4066, 0, 0, 0, 'Yalahar House 1', 0, 17, 0, 0, 0, 0, 196, NULL, 0),
(4067, 0, 0, 0, 'Yalahar House 2', 0, 17, 0, 0, 0, 0, 414, NULL, 10),
(4068, 0, 0, 0, 'Yalahar House 3', 0, 17, 0, 0, 0, 0, 309, NULL, 4),
(4069, 0, 0, 0, 'Yalahar House 4', 0, 17, 0, 0, 0, 0, 238, NULL, 6),
(4070, 0, 0, 0, 'Yalahar House 5', 0, 17, 0, 0, 0, 0, 258, NULL, 8),
(4071, 0, 0, 0, 'Yalahar House 6', 0, 17, 0, 0, 0, 0, 185, NULL, 0),
(4072, 0, 0, 0, 'Yalahar House 7', 0, 17, 0, 0, 0, 0, 549, NULL, 50),
(4073, 0, 0, 0, 'Yalahar House 8', 0, 17, 0, 0, 0, 0, 140, NULL, 16),
(4074, 0, 0, 0, 'Yalahar House 9', 0, 17, 0, 0, 0, 0, 376, NULL, 8),
(4075, 0, 0, 0, 'Yalahar House 10', 0, 17, 0, 0, 0, 0, 211, NULL, 4),
(4076, 0, 0, 0, 'Yalahar House 11', 0, 17, 0, 0, 0, 0, 224, NULL, 4),
(4077, 0, 0, 0, 'Yalahar House 12', 0, 17, 0, 0, 0, 0, 249, NULL, 8),
(4078, 0, 0, 0, 'Yalahar House 13', 0, 17, 0, 0, 0, 0, 53, NULL, 8),
(4079, 0, 0, 0, 'Yalahar House 14', 0, 17, 0, 0, 0, 0, 147, NULL, 0),
(4080, 0, 0, 0, 'Yalahar House 15', 0, 17, 0, 0, 0, 0, 555, NULL, 50),
(4081, 0, 0, 0, 'Yalahar House 16', 0, 17, 0, 0, 0, 0, 52, NULL, 0),
(4082, 0, 0, 0, 'Yalahar House 17', 0, 17, 0, 0, 0, 0, 60, NULL, 8),
(4083, 0, 0, 0, 'Yalahar House 18', 0, 17, 0, 0, 0, 0, 112, NULL, 2),
(4084, 0, 0, 0, 'Yalahar House 19', 0, 17, 0, 0, 0, 0, 133, NULL, 4),
(4085, 0, 0, 0, 'Yalahar House 20', 0, 17, 0, 0, 0, 0, 174, NULL, 4),
(4086, 0, 0, 0, 'Yalahar House 21', 0, 17, 0, 0, 0, 0, 203, NULL, 0),
(4087, 0, 0, 0, 'Yalahar House 22', 0, 17, 0, 0, 0, 0, 189, NULL, 8),
(4088, 0, 0, 0, 'Yalahar House 23', 0, 17, 0, 0, 0, 0, 212, NULL, 4),
(4089, 0, 0, 0, 'Yalahar House 24', 0, 17, 0, 0, 0, 0, 862, NULL, 54),
(4090, 0, 0, 0, 'Yalahar House 25', 0, 17, 0, 0, 0, 0, 228, NULL, 4),
(4091, 0, 0, 0, 'Yalahar House 26', 0, 17, 0, 0, 0, 0, 303, NULL, 6),
(4092, 0, 0, 0, 'Yalahar House 27', 0, 17, 0, 0, 0, 0, 153, NULL, 4),
(4093, 0, 0, 0, 'Yalahar House 28', 0, 17, 0, 0, 0, 0, 242, NULL, 8),
(4094, 0, 0, 0, 'Gray Beach House 1', 0, 18, 0, 0, 0, 0, 47, NULL, 2),
(4095, 0, 0, 0, 'Gray Beach House 2', 0, 18, 0, 0, 0, 0, 45, NULL, 2),
(4096, 0, 0, 0, 'Gray Beach House 3', 0, 18, 0, 0, 0, 0, 41, NULL, 2),
(4097, 0, 0, 0, 'Gray Beach House 4', 0, 18, 0, 0, 0, 0, 48, NULL, 2),
(4098, 0, 0, 0, 'Gray Beach House 5', 0, 18, 0, 0, 0, 0, 42, NULL, 2),
(4099, 0, 0, 0, 'Gray Beach House 6', 0, 18, 0, 0, 0, 0, 45, NULL, 2),
(4100, 0, 0, 0, 'Gray Beach House 7', 0, 18, 0, 0, 0, 0, 33, NULL, 0),
(4101, 0, 0, 0, 'Gray Beach House 8', 0, 18, 0, 0, 0, 0, 29, NULL, 0),
(4102, 0, 0, 0, 'Rathleton House 1', 0, 20, 0, 0, 0, 0, 139, NULL, 4),
(4103, 0, 0, 0, 'Rathleton House 2', 0, 20, 0, 0, 0, 0, 1104, NULL, 30),
(4104, 0, 0, 0, 'Rathleton House 3', 0, 20, 0, 0, 0, 0, 361, NULL, 14),
(4105, 0, 0, 0, 'Rathleton House 4', 0, 20, 0, 0, 0, 0, 176, NULL, 4),
(4106, 0, 0, 0, 'Rathleton House 5', 0, 20, 0, 0, 0, 0, 193, NULL, 6),
(4107, 0, 0, 0, 'Rathleton House 6', 0, 20, 0, 0, 0, 0, 170, NULL, 6),
(4108, 0, 0, 0, 'Rathleton House 7', 0, 20, 0, 0, 0, 0, 229, NULL, 8),
(4109, 0, 0, 0, 'Rathleton House 8', 0, 20, 0, 0, 0, 0, 230, NULL, 8),
(4110, 0, 0, 0, 'Rathleton House 9', 0, 20, 0, 0, 0, 0, 273, NULL, 8),
(4111, 0, 0, 0, 'Rathleton House 11', 0, 20, 0, 0, 0, 0, 258, NULL, 8),
(4112, 0, 0, 0, 'Rathleton House 12', 0, 20, 0, 0, 0, 0, 215, NULL, 8),
(4113, 0, 0, 0, 'Rathleton House 13', 0, 20, 0, 0, 0, 0, 212, NULL, 10),
(4114, 0, 0, 0, 'Rathleton House 14', 0, 20, 0, 0, 0, 0, 615, NULL, 26),
(4115, 0, 0, 0, 'Rathleton House 15', 0, 20, 0, 0, 0, 0, 211, NULL, 6),
(4116, 0, 0, 0, 'Rathleton House 16', 0, 20, 0, 0, 0, 0, 159, NULL, 6),
(4117, 0, 0, 0, 'Rathleton House 17', 0, 20, 0, 0, 0, 0, 117, NULL, 6),
(4118, 0, 0, 0, 'Rathleton House 18', 0, 20, 0, 0, 0, 0, 95, NULL, 4),
(4119, 0, 0, 0, 'Rathleton House 19', 0, 20, 0, 0, 0, 0, 110, NULL, 4),
(4120, 0, 0, 0, 'Issavi House 1', 0, 22, 0, 0, 0, 0, 118, NULL, 2),
(4121, 0, 0, 0, 'Issavi House 2', 0, 22, 0, 0, 0, 0, 126, NULL, 4),
(4123, 0, 0, 0, 'Issavi House 4', 0, 22, 0, 0, 0, 0, 490, NULL, 18),
(4124, 0, 0, 0, 'Issavi House 5', 0, 22, 0, 0, 0, 0, 109, NULL, 4),
(4125, 0, 0, 0, 'Issavi House 6', 0, 22, 0, 0, 0, 0, 135, NULL, 6),
(4126, 0, 0, 0, 'Issavi House 7', 0, 22, 0, 0, 0, 0, 281, NULL, 8),
(4127, 0, 0, 0, 'Issavi House 8', 0, 22, 0, 0, 0, 0, 188, NULL, 4),
(4128, 0, 0, 0, 'Mordragor House 1', 0, 27, 0, 0, 0, 0, 63, NULL, 4),
(4129, 0, 0, 0, 'Mordragor House 2', 0, 27, 0, 0, 0, 0, 56, NULL, 4),
(4130, 0, 0, 0, 'Mordragor House 3', 0, 27, 0, 0, 0, 0, 54, NULL, 4),
(4131, 0, 0, 0, 'Edron House 9', 0, 11, 0, 0, 0, 0, 606, NULL, 46),
(4132, 0, 0, 0, 'Edron House 10', 0, 11, 0, 0, 0, 0, 33, NULL, 4),
(4133, 0, 0, 0, 'Edron House 11', 0, 11, 0, 0, 0, 0, 30, NULL, 4),
(4134, 0, 0, 0, 'Edron House 12', 0, 11, 0, 0, 0, 0, 150, NULL, 10),
(4135, 0, 0, 0, 'Edron House 13', 0, 11, 0, 0, 0, 0, 130, NULL, 4);
INSERT INTO `houses` (`id`, `owner`, `paid`, `warnings`, `name`, `rent`, `town_id`, `bid`, `bid_end`, `last_bid`, `highest_bidder`, `size`, `guildid`, `beds`) VALUES
(4136, 0, 0, 0, 'Edron House 14', 0, 11, 0, 0, 0, 0, 142, NULL, 4),
(4137, 0, 0, 0, 'Edron House 15', 0, 11, 0, 0, 0, 0, 139, NULL, 4),
(4138, 0, 0, 0, 'Edron House 16', 0, 11, 0, 0, 0, 0, 150, NULL, 10),
(4139, 0, 0, 0, 'Edron House 17', 0, 11, 0, 0, 0, 0, 91, NULL, 4),
(4140, 0, 0, 0, 'Edron House 20', 0, 11, 0, 0, 0, 0, 102, NULL, 4),
(4141, 0, 0, 0, 'Edron House 21', 0, 11, 0, 0, 0, 0, 145, NULL, 12),
(4142, 0, 0, 0, 'Edron House 22', 0, 11, 0, 0, 0, 0, 329, NULL, 28),
(4143, 0, 0, 0, 'Edron House 23', 0, 11, 0, 0, 0, 0, 54, NULL, 4),
(4144, 0, 0, 0, 'Edron House 24', 0, 11, 0, 0, 0, 0, 52, NULL, 6),
(4145, 0, 0, 0, 'Edron House 25', 0, 11, 0, 0, 0, 0, 45, NULL, 2),
(4146, 0, 0, 0, 'Edron House 26', 0, 11, 0, 0, 0, 0, 45, NULL, 4),
(4147, 0, 0, 0, 'Edron House 28', 0, 11, 0, 0, 0, 0, 30, NULL, 2),
(4148, 0, 0, 0, 'Edron House 29', 0, 11, 0, 0, 0, 0, 36, NULL, 2),
(4149, 0, 0, 0, 'Edron House 30', 0, 11, 0, 0, 0, 0, 322, NULL, 18),
(4150, 0, 0, 0, 'Edron House 31', 0, 11, 0, 0, 0, 0, 28, NULL, 2),
(4151, 0, 0, 0, 'Edron House 32', 0, 11, 0, 0, 0, 0, 48, NULL, 4),
(4152, 0, 0, 0, 'Edron House 33', 0, 11, 0, 0, 0, 0, 42, NULL, 4),
(4153, 0, 0, 0, 'Edron House 34', 0, 11, 0, 0, 0, 0, 33, NULL, 4),
(4154, 0, 0, 0, 'Edron House 37', 0, 11, 0, 0, 0, 0, 30, NULL, 4),
(4155, 0, 0, 0, 'Edron House 42', 0, 11, 0, 0, 0, 0, 24, NULL, 4),
(4156, 0, 0, 0, 'Venore House 2', 0, 9, 0, 0, 0, 0, 45, NULL, 8),
(4157, 0, 0, 0, 'Venore House 3', 0, 9, 0, 0, 0, 0, 48, NULL, 10),
(4158, 0, 0, 0, 'Venore House 4', 0, 9, 0, 0, 0, 0, 75, NULL, 4),
(4159, 0, 0, 0, 'Venore House 5', 0, 9, 0, 0, 0, 0, 20, NULL, 2),
(4160, 0, 0, 0, 'Venore House 6', 0, 9, 0, 0, 0, 0, 15, NULL, 4),
(4161, 0, 0, 0, 'Venore House 7', 0, 9, 0, 0, 0, 0, 23, NULL, 2),
(4162, 0, 0, 0, 'Venore House 8', 0, 9, 0, 0, 0, 0, 40, NULL, 0),
(4163, 0, 0, 0, 'Venore House 9', 0, 9, 0, 0, 0, 0, 35, NULL, 0),
(4164, 0, 0, 0, 'Venore House 10', 0, 9, 0, 0, 0, 0, 335, NULL, 24),
(4165, 0, 0, 0, 'Venore House 11', 0, 9, 0, 0, 0, 0, 337, NULL, 20),
(4166, 0, 0, 0, 'Venore House 12', 0, 9, 0, 0, 0, 0, 468, NULL, 18),
(4167, 0, 0, 0, 'Venore House 13', 0, 9, 0, 0, 0, 0, 61, NULL, 2),
(4168, 0, 0, 0, 'Venore House 15', 0, 9, 0, 0, 0, 0, 72, NULL, 2),
(4169, 0, 0, 0, 'Venore House 16', 0, 9, 0, 0, 0, 0, 160, NULL, 10),
(4170, 0, 0, 0, 'Venore House 17', 0, 9, 0, 0, 0, 0, 218, NULL, 8),
(4171, 0, 0, 0, 'Venore House 18', 0, 9, 0, 0, 0, 0, 206, NULL, 8),
(4172, 0, 0, 0, 'Venore House 19', 0, 9, 0, 0, 0, 0, 123, NULL, 4),
(4173, 0, 0, 0, 'Venore House 20', 0, 9, 0, 0, 0, 0, 129, NULL, 4),
(4174, 0, 0, 0, 'Mordragor House 4', 0, 27, 0, 0, 0, 0, 56, NULL, 4),
(4175, 0, 0, 0, 'Mordragor House 5', 0, 27, 0, 0, 0, 0, 33, NULL, 2),
(4176, 0, 0, 0, 'Mordragor House 6', 0, 27, 0, 0, 0, 0, 39, NULL, 2),
(4177, 0, 0, 0, 'Mordragor House 7', 0, 27, 0, 0, 0, 0, 46, NULL, 2),
(4178, 0, 0, 0, 'Mordragor House 8', 0, 27, 0, 0, 0, 0, 91, NULL, 4),
(4179, 0, 0, 0, 'Mordragor House 9', 0, 27, 0, 0, 0, 0, 28, NULL, 2),
(4180, 0, 0, 0, 'Mordragor House 10', 0, 27, 0, 0, 0, 0, 58, NULL, 2),
(4181, 0, 0, 0, 'Mordragor House 11', 0, 27, 0, 0, 0, 0, 42, NULL, 2),
(4182, 0, 0, 0, 'Mordragor House 12', 0, 27, 0, 0, 0, 0, 19, NULL, 2),
(4183, 0, 0, 0, 'Falanaar House 1', 0, 28, 0, 0, 0, 0, 15, NULL, 2),
(4184, 0, 0, 0, 'Falanaar House 2', 0, 28, 0, 0, 0, 0, 18, NULL, 2),
(4185, 0, 0, 0, 'Falanaar House 3', 0, 28, 0, 0, 0, 0, 15, NULL, 2),
(4186, 0, 0, 0, 'Falanaar House 4', 0, 28, 0, 0, 0, 0, 23, NULL, 4),
(4187, 0, 0, 0, 'Falanaar House 5', 0, 28, 0, 0, 0, 0, 29, NULL, 4),
(4188, 0, 0, 0, 'Falanaar House 6', 0, 28, 0, 0, 0, 0, 21, NULL, 2),
(4189, 0, 0, 0, 'Falanaar House 7', 0, 28, 0, 0, 0, 0, 36, NULL, 4),
(4190, 0, 0, 0, 'Falanaar House 8', 0, 28, 0, 0, 0, 0, 30, NULL, 6),
(4191, 0, 0, 0, 'Falanaar House 9', 0, 28, 0, 0, 0, 0, 72, NULL, 8),
(4192, 0, 0, 0, 'Falanaar House 10', 0, 28, 0, 0, 0, 0, 29, NULL, 2),
(4193, 0, 0, 0, 'Falanaar House 11', 0, 28, 0, 0, 0, 0, 36, NULL, 4),
(4194, 0, 0, 0, 'Mordragor Boat 1', 0, 27, 0, 0, 0, 0, 238, NULL, 8),
(4195, 0, 0, 0, 'Mordragor Boat 2', 0, 27, 0, 0, 0, 0, 113, NULL, 2),
(4196, 0, 0, 0, 'Mordragor Boat 3', 0, 27, 0, 0, 0, 0, 70, NULL, 2),
(4197, 0, 0, 0, 'Mordragor House 13', 0, 27, 0, 0, 0, 0, 140, NULL, 4),
(4198, 0, 0, 0, 'Mordragor House 14', 0, 27, 0, 0, 0, 0, 136, NULL, 4),
(4199, 0, 0, 0, 'Mordragor House 15', 0, 27, 0, 0, 0, 0, 84, NULL, 4),
(4200, 0, 0, 0, 'Mordragor House 16', 0, 27, 0, 0, 0, 0, 66, NULL, 2),
(4201, 0, 0, 0, 'Mordragor House 17', 0, 27, 0, 0, 0, 0, 148, NULL, 4),
(4202, 0, 0, 0, 'Mordragor House 18', 0, 27, 0, 0, 0, 0, 61, NULL, 4),
(4203, 0, 0, 0, 'Mordragor House 19', 0, 27, 0, 0, 0, 0, 130, NULL, 4),
(4204, 0, 0, 0, 'Mordragor House 20', 0, 27, 0, 0, 0, 0, 40, NULL, 4),
(4205, 0, 0, 0, 'Mordragor House 21', 0, 27, 0, 0, 0, 0, 45, NULL, 4),
(4206, 0, 0, 0, 'Mordragor House 22', 0, 27, 0, 0, 0, 0, 121, NULL, 4),
(4207, 0, 0, 0, 'Mordragor Castle', 0, 27, 0, 0, 0, 0, 664, NULL, 4),
(4208, 0, 0, 0, 'Mordragor House 23', 0, 27, 0, 0, 0, 0, 15, NULL, 2),
(4209, 0, 0, 0, 'Mordragor House 24', 0, 27, 0, 0, 0, 0, 15, NULL, 2),
(4210, 0, 0, 0, 'Mordragor House 26', 0, 27, 0, 0, 0, 0, 15, NULL, 2),
(4211, 0, 0, 0, 'Mordragor House 27', 0, 27, 0, 0, 0, 0, 18, NULL, 2),
(4212, 0, 0, 0, 'Mordragor House 28', 0, 27, 0, 0, 0, 0, 15, NULL, 2),
(4213, 0, 0, 0, 'Mordragor House 29', 0, 27, 0, 0, 0, 0, 15, NULL, 2),
(4214, 0, 0, 0, 'Mordragor House 30', 0, 27, 0, 0, 0, 0, 12, NULL, 2),
(4215, 0, 0, 0, 'Mordragor House 31', 0, 27, 0, 0, 0, 0, 24, NULL, 2),
(4216, 0, 0, 0, 'Mordragor House 32', 0, 27, 0, 0, 0, 0, 21, NULL, 2),
(4217, 0, 0, 0, 'Mordragor House 33', 0, 27, 0, 0, 0, 0, 15, NULL, 2),
(4218, 0, 0, 0, 'Mordragor House 34', 0, 27, 0, 0, 0, 0, 15, NULL, 2),
(4219, 0, 0, 0, 'Mordragor House 35', 0, 27, 0, 0, 0, 0, 15, NULL, 2),
(4220, 0, 0, 0, 'Mordragor House 36', 0, 27, 0, 0, 0, 0, 154, NULL, 8),
(4221, 0, 0, 0, 'Mordragor House 37', 0, 27, 0, 0, 0, 0, 63, NULL, 2),
(4222, 0, 0, 0, 'Mordragor House 38', 0, 27, 0, 0, 0, 0, 63, NULL, 2),
(4223, 0, 0, 0, 'Mordragor House 39', 0, 27, 0, 0, 0, 0, 54, NULL, 2),
(4224, 0, 0, 0, 'Mordragor House 40', 0, 27, 0, 0, 0, 0, 63, NULL, 2),
(4225, 0, 0, 0, 'Mordragor House 41', 0, 27, 0, 0, 0, 0, 54, NULL, 2),
(4226, 0, 0, 0, 'Mordragor House 42', 0, 27, 0, 0, 0, 0, 38, NULL, 4),
(4227, 0, 0, 0, 'Mordragor House 43', 0, 27, 0, 0, 0, 0, 38, NULL, 4),
(4228, 0, 0, 0, 'Mordragor Forest', 0, 27, 0, 0, 0, 0, 25, NULL, 2),
(4229, 0, 0, 0, 'Thais Boat', 0, 8, 0, 0, 0, 0, 212, NULL, 4),
(4230, 0, 0, 0, 'Mistfall House 1', 0, 31, 0, 0, 0, 0, 128, NULL, 0),
(4231, 0, 0, 0, 'Mistfall House 2', 0, 31, 0, 0, 0, 0, 87, NULL, 0),
(4232, 0, 0, 0, 'Mistfall House 3', 0, 31, 0, 0, 0, 0, 172, NULL, 0),
(4233, 0, 0, 0, 'Mistfall House 4', 0, 31, 0, 0, 0, 0, 181, NULL, 0),
(4234, 0, 0, 0, 'Mistfall House 5', 0, 31, 0, 0, 0, 0, 159, NULL, 0),
(4235, 0, 0, 0, 'Mistfall Castle', 0, 31, 0, 0, 0, 0, 929, NULL, 0),
(4236, 0, 0, 0, 'Mistfall House 6', 0, 31, 0, 0, 0, 0, 219, NULL, 8),
(4237, 0, 0, 0, 'Mistfall House 7', 0, 31, 0, 0, 0, 0, 27, NULL, 0),
(4238, 0, 0, 0, 'Mistfall House 8', 0, 31, 0, 0, 0, 0, 23, NULL, 2),
(4239, 0, 0, 0, 'Mistfall House 9', 0, 31, 0, 0, 0, 0, 36, NULL, 2),
(4240, 0, 0, 0, 'Mistfall House 10', 0, 31, 0, 0, 0, 0, 36, NULL, 2),
(4241, 0, 0, 0, 'Mistfall House 11', 0, 31, 0, 0, 0, 0, 50, NULL, 2),
(4242, 0, 0, 0, 'Mistfall House 12', 0, 31, 0, 0, 0, 0, 125, NULL, 0),
(4243, 0, 0, 0, 'Giant Mistfall Forest House', 0, 31, 0, 0, 0, 0, 906, NULL, 22),
(4244, 0, 0, 0, 'Dolwatha House 1', 0, 30, 0, 0, 0, 0, 45, NULL, 0),
(4245, 0, 0, 0, 'Dolwatha House 2', 0, 30, 0, 0, 0, 0, 36, NULL, 0),
(4246, 0, 0, 0, 'Dolwatha House 3', 0, 30, 0, 0, 0, 0, 32, NULL, 0),
(4247, 0, 0, 0, 'Dolwatha House 4', 0, 30, 0, 0, 0, 0, 46, NULL, 0),
(4248, 0, 0, 0, 'Dolwatha House 5', 0, 30, 0, 0, 0, 0, 100, NULL, 0),
(4249, 0, 0, 0, 'Dolwatha House 6', 0, 30, 0, 0, 0, 0, 24, NULL, 0),
(4250, 0, 0, 0, 'Dolwatha House 7', 0, 30, 0, 0, 0, 0, 28, NULL, 0),
(4251, 0, 0, 0, 'Dolwatha House 8', 0, 30, 0, 0, 0, 0, 139, NULL, 0),
(4252, 0, 0, 0, 'Dolwatha House 9', 0, 30, 0, 0, 0, 0, 38, NULL, 0),
(4253, 0, 0, 0, 'Dolwatha House 10', 0, 30, 0, 0, 0, 0, 124, NULL, 0),
(4254, 0, 0, 0, 'Dolwatha House 12', 0, 30, 0, 0, 0, 0, 172, NULL, 0),
(4255, 0, 0, 0, 'Dolwatha House 11', 0, 30, 0, 0, 0, 0, 125, NULL, 0),
(4256, 0, 0, 0, 'Dolwatha House 13', 0, 30, 0, 0, 0, 0, 236, NULL, 0),
(4257, 0, 0, 0, 'Dolwatha House 14', 0, 30, 0, 0, 0, 0, 109, NULL, 0),
(4258, 0, 0, 0, 'Dolwatha House 15', 0, 30, 0, 0, 0, 0, 40, NULL, 0),
(4259, 0, 0, 0, 'Dolwatha House 16', 0, 30, 0, 0, 0, 0, 74, NULL, 0),
(4260, 0, 0, 0, 'Dolwatha House 17', 0, 30, 0, 0, 0, 0, 109, NULL, 0),
(4261, 0, 0, 0, 'Dolwatha House 18', 0, 30, 0, 0, 0, 0, 99, NULL, 0),
(4262, 0, 0, 0, 'Dolwatha House 19', 0, 30, 0, 0, 0, 0, 33, NULL, 0),
(4263, 0, 0, 0, 'Dolwatha House 20', 0, 30, 0, 0, 0, 0, 67, NULL, 0),
(4264, 0, 0, 0, 'Dolwatha House 21', 0, 30, 0, 0, 0, 0, 196, NULL, 0),
(4265, 0, 0, 0, 'Dolwatha House 22', 0, 30, 0, 0, 0, 0, 73, NULL, 0),
(4266, 0, 0, 0, 'Dolwatha House 23', 0, 30, 0, 0, 0, 0, 65, NULL, 0),
(4267, 0, 0, 0, 'Dolwatha House 24', 0, 30, 0, 0, 0, 0, 57, NULL, 0),
(4268, 0, 0, 0, 'Dolwatha House 25', 0, 30, 0, 0, 0, 0, 114, NULL, 0),
(4269, 0, 0, 0, 'Dolwatha House 26', 0, 30, 0, 0, 0, 0, 199, NULL, 0),
(4270, 0, 0, 0, 'Dolwatha House 27', 0, 30, 0, 0, 0, 0, 72, NULL, 0),
(4271, 0, 0, 0, 'Dolwatha House 28', 0, 30, 0, 0, 0, 0, 85, NULL, 0),
(4272, 0, 0, 0, 'Dolwatha House 29', 0, 30, 0, 0, 0, 0, 29, NULL, 0),
(4273, 0, 0, 0, 'Dolwatha House 30', 0, 30, 0, 0, 0, 0, 48, NULL, 0),
(4274, 0, 0, 0, 'Dolwatha House 31', 0, 30, 0, 0, 0, 0, 35, NULL, 0),
(4275, 0, 0, 0, 'Dolwatha House 32', 0, 30, 0, 0, 0, 0, 268, NULL, 0),
(4276, 0, 0, 0, 'Cormaya House 1', 0, 32, 0, 0, 0, 0, 49, NULL, 4),
(4277, 0, 0, 0, 'Cormaya House 2', 0, 32, 0, 0, 0, 0, 131, NULL, 6),
(4278, 0, 0, 0, 'Cormaya House 3', 0, 32, 0, 0, 0, 0, 63, NULL, 4),
(4279, 0, 0, 0, 'Cormaya House 4', 0, 32, 0, 0, 0, 0, 72, NULL, 4),
(4280, 0, 0, 0, 'Cormaya Appartement 1', 0, 32, 0, 0, 0, 0, 20, NULL, 2),
(4281, 0, 0, 0, 'Cormaya Appartement 2', 0, 32, 0, 0, 0, 0, 20, NULL, 2),
(4282, 0, 0, 0, 'Cormaya Appartement 3', 0, 32, 0, 0, 0, 0, 35, NULL, 4),
(4283, 0, 0, 0, 'Cormaya Appartement 5', 0, 32, 0, 0, 0, 0, 23, NULL, 2),
(4284, 0, 0, 0, 'Cormaya Appartement 6', 0, 32, 0, 0, 0, 0, 20, NULL, 2),
(4285, 0, 0, 0, 'Cormaya Appartement 7', 0, 32, 0, 0, 0, 0, 30, NULL, 4),
(4286, 0, 0, 0, 'Cormaya Appartement 8', 0, 32, 0, 0, 0, 0, 44, NULL, 4),
(4287, 0, 0, 0, 'Cormaya Appartement 9', 0, 32, 0, 0, 0, 0, 30, NULL, 4),
(4288, 0, 0, 0, 'Cormaya Appartement 10', 0, 32, 0, 0, 0, 0, 40, NULL, 4),
(4290, 0, 0, 0, 'Cormaya Appartement 11', 0, 32, 0, 0, 0, 0, 30, NULL, 4),
(4291, 0, 0, 0, 'Cormaya House 5', 0, 32, 0, 0, 0, 0, 114, NULL, 2),
(4292, 0, 0, 0, 'Cormaya House 6', 0, 32, 0, 0, 0, 0, 87, NULL, 4),
(4293, 0, 0, 0, 'Cormaya House 7', 0, 32, 0, 0, 0, 0, 79, NULL, 4),
(4294, 0, 0, 0, 'Cormaya House 8', 0, 32, 0, 0, 0, 0, 100, NULL, 4),
(4295, 0, 0, 0, 'Cormaya House 9', 0, 32, 0, 0, 0, 0, 72, NULL, 4),
(4296, 0, 0, 0, 'Cormaya House 10', 0, 32, 0, 0, 0, 0, 48, NULL, 4),
(4297, 0, 0, 0, 'Cormaya House 12', 0, 32, 0, 0, 0, 0, 40, NULL, 4),
(4298, 0, 0, 0, 'Cormaya House 13', 0, 32, 0, 0, 0, 0, 80, NULL, 4),
(4299, 0, 0, 0, 'Cormaya House 14', 0, 32, 0, 0, 0, 0, 137, NULL, 6),
(4300, 0, 0, 0, 'Cormaya House 15', 0, 32, 0, 0, 0, 0, 72, NULL, 4),
(4302, 0, 0, 0, 'Cormaya GuildHall', 0, 32, 0, 0, 0, 0, 1051, NULL, 20);

-- --------------------------------------------------------

--
-- Structure de la table `house_lists`
--

CREATE TABLE `house_lists` (
  `house_id` int(11) NOT NULL,
  `listid` int(11) NOT NULL,
  `list` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `ip_bans`
--

CREATE TABLE `ip_bans` (
  `ip` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expires_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `market_history`
--

CREATE TABLE `market_history` (
  `id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `sale` tinyint(1) NOT NULL DEFAULT '0',
  `itemtype` int(10) UNSIGNED NOT NULL,
  `amount` smallint(5) UNSIGNED NOT NULL,
  `price` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `expires_at` bigint(20) UNSIGNED NOT NULL,
  `inserted` bigint(20) UNSIGNED NOT NULL,
  `state` tinyint(1) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `market_offers`
--

CREATE TABLE `market_offers` (
  `id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `sale` tinyint(1) NOT NULL DEFAULT '0',
  `itemtype` int(10) UNSIGNED NOT NULL,
  `amount` smallint(5) UNSIGNED NOT NULL,
  `created` bigint(20) UNSIGNED NOT NULL,
  `anonymous` tinyint(1) NOT NULL DEFAULT '0',
  `price` int(10) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `players`
--

CREATE TABLE `players` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `group_id` int(11) NOT NULL DEFAULT '1',
  `account_id` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '1',
  `vocation` int(11) NOT NULL DEFAULT '0',
  `health` int(11) NOT NULL DEFAULT '150',
  `healthmax` int(11) NOT NULL DEFAULT '150',
  `experience` bigint(20) NOT NULL DEFAULT '0',
  `lookbody` int(11) NOT NULL DEFAULT '0',
  `lookfeet` int(11) NOT NULL DEFAULT '0',
  `lookhead` int(11) NOT NULL DEFAULT '0',
  `looklegs` int(11) NOT NULL DEFAULT '0',
  `looktype` int(11) NOT NULL DEFAULT '136',
  `lookaddons` int(11) NOT NULL DEFAULT '0',
  `maglevel` int(11) NOT NULL DEFAULT '0',
  `mana` int(11) NOT NULL DEFAULT '0',
  `manamax` int(11) NOT NULL DEFAULT '0',
  `manaspent` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `soul` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `town_id` int(11) NOT NULL DEFAULT '1',
  `posx` int(11) NOT NULL DEFAULT '0',
  `posy` int(11) NOT NULL DEFAULT '0',
  `posz` int(11) NOT NULL DEFAULT '0',
  `conditions` blob NOT NULL,
  `cap` int(11) NOT NULL DEFAULT '0',
  `sex` int(11) NOT NULL DEFAULT '0',
  `lastlogin` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `lastip` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `save` tinyint(1) NOT NULL DEFAULT '1',
  `skull` tinyint(1) NOT NULL DEFAULT '0',
  `skulltime` bigint(20) NOT NULL DEFAULT '0',
  `lastlogout` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `blessings` tinyint(2) NOT NULL DEFAULT '0',
  `blessings1` tinyint(4) NOT NULL DEFAULT '0',
  `blessings2` tinyint(4) NOT NULL DEFAULT '0',
  `blessings3` tinyint(4) NOT NULL DEFAULT '0',
  `blessings4` tinyint(4) NOT NULL DEFAULT '0',
  `blessings5` tinyint(4) NOT NULL DEFAULT '0',
  `blessings6` tinyint(4) NOT NULL DEFAULT '0',
  `blessings7` tinyint(4) NOT NULL DEFAULT '0',
  `blessings8` tinyint(4) NOT NULL DEFAULT '0',
  `onlinetime` int(11) NOT NULL DEFAULT '0',
  `deletion` bigint(15) NOT NULL DEFAULT '0',
  `balance` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `offlinetraining_time` smallint(5) UNSIGNED NOT NULL DEFAULT '43200',
  `offlinetraining_skill` int(11) NOT NULL DEFAULT '-1',
  `stamina` smallint(5) UNSIGNED NOT NULL DEFAULT '2520',
  `skill_fist` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_fist_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_club` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_club_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_sword` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_sword_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_axe` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_axe_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_dist` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_dist_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_shielding` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_shielding_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_fishing` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_fishing_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_critical_hit_chance` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `skill_critical_hit_chance_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_critical_hit_damage` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `skill_critical_hit_damage_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_life_leech_chance` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `skill_life_leech_chance_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_life_leech_amount` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `skill_life_leech_amount_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_mana_leech_chance` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `skill_mana_leech_chance_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_mana_leech_amount` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `skill_mana_leech_amount_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_criticalhit_chance` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_criticalhit_damage` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_lifeleech_chance` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_lifeleech_amount` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_manaleech_chance` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_manaleech_amount` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `manashield` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `max_manashield` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `prey_stamina_1` int(11) DEFAULT NULL,
  `prey_stamina_2` int(11) DEFAULT NULL,
  `prey_stamina_3` int(11) DEFAULT NULL,
  `prey_column` smallint(6) NOT NULL DEFAULT '1',
  `xpboost_stamina` smallint(5) DEFAULT NULL,
  `xpboost_value` tinyint(4) DEFAULT NULL,
  `marriage_status` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `marriage_spouse` int(11) NOT NULL DEFAULT '-1',
  `bonus_rerolls` bigint(21) NOT NULL DEFAULT '0',
  `quickloot_fallback` tinyint(1) DEFAULT '0',
  `lookmountbody` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `lookmountfeet` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `lookmounthead` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `lookmountlegs` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `lookfamiliarstype` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `isreward` tinyint(1) NOT NULL DEFAULT '1',
  `istutorial` smallint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `players`
--

INSERT INTO `players` (`id`, `name`, `group_id`, `account_id`, `level`, `vocation`, `health`, `healthmax`, `experience`, `lookbody`, `lookfeet`, `lookhead`, `looklegs`, `looktype`, `lookaddons`, `maglevel`, `mana`, `manamax`, `manaspent`, `soul`, `town_id`, `posx`, `posy`, `posz`, `conditions`, `cap`, `sex`, `lastlogin`, `lastip`, `save`, `skull`, `skulltime`, `lastlogout`, `blessings`, `blessings1`, `blessings2`, `blessings3`, `blessings4`, `blessings5`, `blessings6`, `blessings7`, `blessings8`, `onlinetime`, `deletion`, `balance`, `offlinetraining_time`, `offlinetraining_skill`, `stamina`, `skill_fist`, `skill_fist_tries`, `skill_club`, `skill_club_tries`, `skill_sword`, `skill_sword_tries`, `skill_axe`, `skill_axe_tries`, `skill_dist`, `skill_dist_tries`, `skill_shielding`, `skill_shielding_tries`, `skill_fishing`, `skill_fishing_tries`, `skill_critical_hit_chance`, `skill_critical_hit_chance_tries`, `skill_critical_hit_damage`, `skill_critical_hit_damage_tries`, `skill_life_leech_chance`, `skill_life_leech_chance_tries`, `skill_life_leech_amount`, `skill_life_leech_amount_tries`, `skill_mana_leech_chance`, `skill_mana_leech_chance_tries`, `skill_mana_leech_amount`, `skill_mana_leech_amount_tries`, `skill_criticalhit_chance`, `skill_criticalhit_damage`, `skill_lifeleech_chance`, `skill_lifeleech_amount`, `skill_manaleech_chance`, `skill_manaleech_amount`, `manashield`, `max_manashield`, `prey_stamina_1`, `prey_stamina_2`, `prey_stamina_3`, `prey_column`, `xpboost_stamina`, `xpboost_value`, `marriage_status`, `marriage_spouse`, `bonus_rerolls`, `quickloot_fallback`, `lookmountbody`, `lookmountfeet`, `lookmounthead`, `lookmountlegs`, `lookfamiliarstype`, `isreward`, `istutorial`) VALUES
(1, 'Rook Sample', 1, 1, 2, 0, 155, 155, 100, 113, 115, 95, 39, 129, 0, 2, 60, 60, 5936, 0, 1, 0, 0, 0, '', 410, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43200, -1, 2520, 10, 0, 12, 155, 12, 155, 12, 155, 12, 93, 10, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 1, NULL, NULL, 0, -1, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(2, 'Sorcerer Sample', 1, 1, 8, 1, 185, 185, 4200, 113, 115, 95, 39, 129, 0, 0, 90, 90, 0, 0, 8, 0, 0, 0, '', 470, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 1, NULL, NULL, 0, -1, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(3, 'Druid Sample', 1, 1, 8, 2, 185, 185, 4200, 113, 115, 95, 39, 129, 0, 0, 90, 90, 0, 0, 8, 0, 0, 0, '', 470, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 1, NULL, NULL, 0, -1, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(4, 'Paladin Sample', 1, 1, 8, 3, 185, 185, 4200, 113, 115, 95, 39, 129, 0, 0, 90, 90, 0, 0, 8, 0, 0, 0, '', 470, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 1, NULL, NULL, 0, -1, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(5, 'Knight Sample', 1, 1, 8, 4, 185, 185, 4200, 113, 115, 95, 39, 129, 0, 0, 90, 90, 0, 0, 8, 0, 0, 0, '', 470, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 1, NULL, NULL, 0, -1, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(6, 'GOD', 6, 1, 2, 11, 155, 155, 100, 117, 78, 95, 98, 129, 0, 0, 60, 60, 0, 0, 1, 32370, 32239, 5, '', 410, 1, 1621601833, 16777343, 1, 0, 0, 1621602690, 0, 1, 1, 1, 1, 1, 1, 1, 1, 7718, 0, 0, 43200, -1, 2520, 10, 0, 10, 0, 12, 18, 10, 0, 12, 78, 10, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 1, 0);

--
-- Déclencheurs `players`
--
DELIMITER $$
CREATE TRIGGER `ondelete_players` BEFORE DELETE ON `players` FOR EACH ROW BEGIN
		UPDATE `houses` SET `owner` = 0 WHERE `owner` = OLD.`id`;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `players_online`
--

CREATE TABLE `players_online` (
  `player_id` int(11) NOT NULL
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `player_charms`
--

CREATE TABLE `player_charms` (
  `player_guid` int(250) NOT NULL,
  `charm_points` varchar(250) DEFAULT NULL,
  `charm_expansion` tinyint(1) DEFAULT NULL,
  `rune_wound` int(250) DEFAULT NULL,
  `rune_enflame` int(250) DEFAULT NULL,
  `rune_poison` int(250) DEFAULT NULL,
  `rune_freeze` int(250) DEFAULT NULL,
  `rune_zap` int(250) DEFAULT NULL,
  `rune_curse` int(250) DEFAULT NULL,
  `rune_cripple` int(250) DEFAULT NULL,
  `rune_parry` int(250) DEFAULT NULL,
  `rune_dodge` int(250) DEFAULT NULL,
  `rune_adrenaline` int(250) DEFAULT NULL,
  `rune_numb` int(250) DEFAULT NULL,
  `rune_cleanse` int(250) DEFAULT NULL,
  `rune_bless` int(250) DEFAULT NULL,
  `rune_scavenge` int(250) DEFAULT NULL,
  `rune_gut` int(250) DEFAULT NULL,
  `rune_low_blow` int(250) DEFAULT NULL,
  `rune_divine` int(250) DEFAULT NULL,
  `rune_vamp` int(250) DEFAULT NULL,
  `rune_void` int(250) DEFAULT NULL,
  `UsedRunesBit` varchar(250) DEFAULT NULL,
  `UnlockedRunesBit` varchar(250) DEFAULT NULL,
  `tracker list` blob
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `player_charms`
--

INSERT INTO `player_charms` (`player_guid`, `charm_points`, `charm_expansion`, `rune_wound`, `rune_enflame`, `rune_poison`, `rune_freeze`, `rune_zap`, `rune_curse`, `rune_cripple`, `rune_parry`, `rune_dodge`, `rune_adrenaline`, `rune_numb`, `rune_cleanse`, `rune_bless`, `rune_scavenge`, `rune_gut`, `rune_low_blow`, `rune_divine`, `rune_vamp`, `rune_void`, `UsedRunesBit`, `UnlockedRunesBit`, `tracker list`) VALUES
(6, '0', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0', '0', '');

-- --------------------------------------------------------

--
-- Structure de la table `player_deaths`
--

CREATE TABLE `player_deaths` (
  `player_id` int(11) NOT NULL,
  `time` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '1',
  `killed_by` varchar(255) NOT NULL,
  `is_player` tinyint(1) NOT NULL DEFAULT '1',
  `mostdamage_by` varchar(100) NOT NULL,
  `mostdamage_is_player` tinyint(1) NOT NULL DEFAULT '0',
  `unjustified` tinyint(1) NOT NULL DEFAULT '0',
  `mostdamage_unjustified` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `player_depotitems`
--

CREATE TABLE `player_depotitems` (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL COMMENT 'any given range eg 0-100 will be reserved for depot lockers and all > 100 will be then normal items inside depots',
  `pid` int(11) NOT NULL DEFAULT '0',
  `itemtype` int(11) NOT NULL DEFAULT '0',
  `count` int(11) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `player_hirelings`
--

CREATE TABLE `player_hirelings` (
  `id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `active` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `sex` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `posx` int(11) NOT NULL DEFAULT '0',
  `posy` int(11) NOT NULL DEFAULT '0',
  `posz` int(11) NOT NULL DEFAULT '0',
  `lookbody` int(11) NOT NULL DEFAULT '0',
  `lookfeet` int(11) NOT NULL DEFAULT '0',
  `lookhead` int(11) NOT NULL DEFAULT '0',
  `looklegs` int(11) NOT NULL DEFAULT '0',
  `looktype` int(11) NOT NULL DEFAULT '136'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `player_inboxitems`
--

CREATE TABLE `player_inboxitems` (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0',
  `itemtype` int(11) NOT NULL DEFAULT '0',
  `count` int(11) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `player_items`
--

CREATE TABLE `player_items` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `pid` int(11) NOT NULL DEFAULT '0',
  `sid` int(11) NOT NULL DEFAULT '0',
  `itemtype` int(11) NOT NULL DEFAULT '0',
  `count` int(11) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `player_items`
--

INSERT INTO `player_items` (`player_id`, `pid`, `sid`, `itemtype`, `count`, `attributes`) VALUES
(6, 1, 101, 2461, 1, ''),
(6, 3, 102, 1988, 1, 0x24012600000080),
(6, 6, 103, 2456, 1, ''),
(6, 7, 104, 2649, 1, ''),
(6, 8, 105, 2643, 1, ''),
(6, 11, 106, 26052, 1, 0x2402),
(6, 102, 107, 12654, 1, ''),
(6, 102, 108, 40397, 1, ''),
(6, 102, 109, 2649, 1, ''),
(6, 102, 110, 2643, 1, ''),
(6, 102, 111, 2467, 1, ''),
(6, 102, 112, 2461, 1, ''),
(6, 102, 113, 2448, 1, ''),
(6, 102, 114, 2386, 1, ''),
(6, 102, 115, 2406, 1, ''),
(6, 102, 116, 2389, 10, 0x0f0a),
(6, 102, 117, 2175, 1, ''),
(6, 102, 118, 2512, 1, ''),
(6, 102, 119, 2182, 1, ''),
(6, 102, 120, 2190, 1, ''),
(6, 106, 121, 32387, 498, 0x16f201),
(6, 106, 122, 40119, 1799, 0x160707),
(6, 106, 123, 8305, 27, 0x0f1b);

-- --------------------------------------------------------

--
-- Structure de la table `player_kills`
--

CREATE TABLE `player_kills` (
  `player_id` int(11) NOT NULL,
  `time` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `target` int(11) NOT NULL,
  `unavenged` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `player_misc`
--

CREATE TABLE `player_misc` (
  `player_id` int(11) NOT NULL,
  `info` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `player_misc`
--

INSERT INTO `player_misc` (`player_id`, `info`) VALUES
(6, 0x7b7d);

-- --------------------------------------------------------

--
-- Structure de la table `player_namelocks`
--

CREATE TABLE `player_namelocks` (
  `player_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `namelocked_at` bigint(20) NOT NULL,
  `namelocked_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `player_prey`
--

CREATE TABLE `player_prey` (
  `player_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `mindex` smallint(6) NOT NULL,
  `mcolumn` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `player_preytimes`
--

CREATE TABLE `player_preytimes` (
  `player_id` int(11) NOT NULL,
  `bonus_type1` int(11) NOT NULL,
  `bonus_value1` int(11) NOT NULL,
  `bonus_name1` varchar(50) NOT NULL,
  `bonus_type2` int(11) NOT NULL,
  `bonus_value2` int(11) NOT NULL,
  `bonus_name2` varchar(50) NOT NULL,
  `bonus_type3` int(11) NOT NULL,
  `bonus_value3` int(11) NOT NULL,
  `bonus_name3` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `player_preytimes`
--

INSERT INTO `player_preytimes` (`player_id`, `bonus_type1`, `bonus_value1`, `bonus_name1`, `bonus_type2`, `bonus_value2`, `bonus_name2`, `bonus_type3`, `bonus_value3`, `bonus_name3`) VALUES
(6, 0, 0, '', 0, 0, '', 0, 0, '');

-- --------------------------------------------------------

--
-- Structure de la table `player_rewards`
--

CREATE TABLE `player_rewards` (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0',
  `itemtype` int(11) NOT NULL DEFAULT '0',
  `count` int(11) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `player_spells`
--

CREATE TABLE `player_spells` (
  `player_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `player_stash`
--

CREATE TABLE `player_stash` (
  `player_id` int(16) NOT NULL,
  `item_id` int(16) NOT NULL,
  `item_count` int(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `player_storage`
--

CREATE TABLE `player_storage` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `key` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `value` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `player_storage`
--

INSERT INTO `player_storage` (`player_id`, `key`, `value`) VALUES
(6, 0, 2),
(6, 10128, 3),
(6, 10129, 3),
(6, 10130, 3),
(6, 10131, 3),
(6, 10132, 3),
(6, 10133, 3),
(6, 10134, 3),
(6, 10143, 3),
(6, 10144, 3),
(6, 10145, 3),
(6, 10146, 3),
(6, 10151, 3),
(6, 10152, 3),
(6, 10153, 3),
(6, 10154, 3),
(6, 10251, 3),
(6, 10268, 3),
(6, 10273, 3),
(6, 10278, 3),
(6, 10289, 3),
(6, 10325, 3),
(6, 10328, 3),
(6, 10335, 3),
(6, 10367, 3),
(6, 10430, 3),
(6, 10432, 3),
(6, 10463, 3),
(6, 10465, 3),
(6, 10472, 3),
(6, 10512, 3),
(6, 10516, 3),
(6, 10541, 3),
(6, 10574, 3),
(6, 10577, 3),
(6, 10610, 3),
(6, 10619, 3),
(6, 10633, 3),
(6, 10634, 3),
(6, 10637, 3),
(6, 10665, 3),
(6, 10667, 3),
(6, 10684, 3),
(6, 10695, 3),
(6, 10697, 3),
(6, 10699, 3),
(6, 10725, 3),
(6, 10733, 3),
(6, 10746, 3),
(6, 10750, 3),
(6, 10760, 3),
(6, 10846, 3),
(6, 10853, 3),
(6, 10873, 3),
(6, 10884, 3),
(6, 10899, 3),
(6, 10908, 3),
(6, 10931, 3),
(6, 10955, 3),
(6, 10957, 3),
(6, 10962, 3),
(6, 10964, 3),
(6, 10966, 3),
(6, 10968, 3),
(6, 10970, 3),
(6, 10972, 3),
(6, 10974, 3),
(6, 11021, 3),
(6, 11023, 3),
(6, 11042, 3),
(6, 11051, 3),
(6, 11056, 3),
(6, 11069, 3),
(6, 11094, 3),
(6, 11102, 3),
(6, 11127, 3),
(6, 11146, 3),
(6, 11161, 3),
(6, 11173, 3),
(6, 11186, 3),
(6, 11202, 3),
(6, 11204, 3),
(6, 11206, 3),
(6, 11210, 3),
(6, 11243, 3),
(6, 11245, 3),
(6, 11251, 3),
(6, 11270, 3),
(6, 11279, 3),
(6, 11282, 3),
(6, 11288, 3),
(6, 11292, 3),
(6, 11331, 3),
(6, 13413, 1),
(6, 13414, 5),
(6, 14903, 0),
(6, 17101, 0),
(6, 20000, 4),
(6, 20108, 2),
(6, 24324, 1),
(6, 24746, 1),
(6, 24756, 1),
(6, 30000, 0),
(6, 30002, 1621418127),
(6, 30023, 1),
(6, 30024, 1),
(6, 30029, 0),
(6, 30051, 1621548410),
(6, 50606, 1),
(6, 50620, 2),
(6, 50630, 4),
(6, 50631, 2),
(6, 50632, 2),
(6, 50633, 2),
(6, 50634, 3),
(6, 50640, 3),
(6, 50641, 3),
(6, 50642, 3),
(6, 50643, 3),
(6, 51091, 12),
(6, 51360, 6),
(6, 51361, 3),
(6, 51362, 3),
(6, 51363, 2),
(6, 51364, 4),
(6, 51365, 13),
(6, 51366, 8),
(6, 51367, 3),
(6, 51368, 4),
(6, 51369, 3),
(6, 51371, 1),
(6, 51590, 1),
(6, 51591, 1),
(6, 51592, 1),
(6, 51593, 1),
(6, 51594, 1),
(6, 51595, 1),
(6, 51596, 1),
(6, 51597, 1),
(6, 51598, 1),
(6, 52261, 1),
(6, 52262, 1),
(6, 52263, 1),
(6, 52264, 1),
(6, 52265, 1),
(6, 52266, 1),
(6, 52267, 1),
(6, 52268, 1),
(6, 52271, 1),
(6, 998899, 1);

-- --------------------------------------------------------

--
-- Structure de la table `prey_slots`
--

CREATE TABLE `prey_slots` (
  `player_id` int(11) NOT NULL,
  `num` smallint(2) NOT NULL,
  `state` smallint(2) NOT NULL DEFAULT '1',
  `unlocked` smallint(2) NOT NULL DEFAULT '0',
  `current` varchar(40) NOT NULL DEFAULT '',
  `monster_list` varchar(360) NOT NULL,
  `free_reroll_in` int(11) NOT NULL DEFAULT '0',
  `time_left` smallint(5) NOT NULL DEFAULT '0',
  `next_use` int(11) NOT NULL DEFAULT '0',
  `bonus_type` smallint(3) NOT NULL,
  `bonus_value` smallint(3) NOT NULL DEFAULT '0',
  `bonus_grade` smallint(3) NOT NULL DEFAULT '0',
  `tick` smallint(3) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `prey_slots`
--

INSERT INTO `prey_slots` (`player_id`, `num`, `state`, `unlocked`, `current`, `monster_list`, `free_reroll_in`, `time_left`, `next_use`, `bonus_type`, `bonus_value`, `bonus_grade`, `tick`) VALUES
(6, 0, 1, 2, '', '', 0, 0, 0, 0, 15, 5, 0),
(6, 1, 1, 2, '', '', 0, 0, 0, 0, 0, 0, 0),
(6, 2, 0, 1, '', '', 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `server_config`
--

CREATE TABLE `server_config` (
  `config` varchar(50) NOT NULL,
  `value` varchar(256) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `server_config`
--

INSERT INTO `server_config` (`config`, `value`) VALUES
('db_version', '17'),
('motd_hash', '617e4a8979b3ddcb8cfb639f0c166b4fa8dfcce5'),
('motd_num', '3'),
('players_record', '1');

-- --------------------------------------------------------

--
-- Structure de la table `store_history`
--

CREATE TABLE `store_history` (
  `id` int(11) NOT NULL,
  `account_id` int(11) UNSIGNED NOT NULL,
  `mode` smallint(2) NOT NULL DEFAULT '0',
  `description` varchar(3500) NOT NULL,
  `coin_amount` int(12) NOT NULL,
  `time` bigint(20) UNSIGNED NOT NULL,
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `coins` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `store_history`
--

INSERT INTO `store_history` (`id`, `account_id`, `mode`, `description`, `coin_amount`, `time`, `timestamp`, `coins`) VALUES
(1, 1, 0, 'Upgrade Tier 1', -25, 1621418313, 0, 0),
(2, 1, 0, 'Upgrade Tier 1', -25, 1621418317, 0, 0),
(3, 1, 0, 'Upgrade Tier 3', -75, 1621418374, 0, 0),
(4, 1, 0, 'Upgrade Tier 3', -75, 1621418411, 0, 0),
(5, 1, 0, 'Upgrade Tier 3', -75, 1621418441, 0, 0),
(6, 1, 0, 'Upgrade Tier 5', -125, 1621418593, 0, 0),
(7, 1, 0, 'Liombera Backpack', -150, 1621418685, 0, 0),
(8, 1, 0, 'Lasting Exercise Sword', -720, 1621548094, 0, 0),
(9, 1, 0, 'Lasting Exercise Sword', -720, 1621548189, 0, 0),
(10, 1, 0, 'Durable Exercise Wand', -90, 1621548417, 0, 0),
(11, 1, 0, 'Exercise Bow', -25, 1621548426, 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `tile_store`
--

CREATE TABLE `tile_store` (
  `house_id` int(11) NOT NULL,
  `data` longblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `tile_store`
--

INSERT INTO `tile_store` (`house_id`, `data`) VALUES
(3038, 0x7a7eee7d0701000000da0600),
(3038, 0x7a7eef7d0701000000db0600),
(3038, 0x7d7eef7d0701000000222800),
(3038, 0x7c7ef07d07010000002c1900),
(3039, 0x807eef7d0701000000222800),
(3039, 0x837eee7d0701000000da0600),
(3039, 0x837eef7d0701000000db0600),
(3039, 0x827ef07d07010000002c1900),
(3040, 0x7c7eeb7d0701000000222800),
(3040, 0x7a7eec7d0701000000e00600),
(3040, 0x7b7eec7d0701000000e10600),
(3041, 0x7a7ee77d0701000000e00600),
(3041, 0x7b7ee77d0701000000e10600),
(3041, 0x7e7ee87d0701000000242800),
(3042, 0x827ee77d0701000000e00600),
(3042, 0x837ee77d0701000000e10600),
(3042, 0x807ee87d0701000000242800),
(3043, 0x837ee97d0701000000da0600),
(3043, 0x837eea7d0701000000db0600),
(3043, 0x817eec7d0701000000222800),
(3044, 0x7a7ee67d0601000000da0600),
(3044, 0x7a7ee77d0601000000db0600),
(3044, 0x7e7ee87d0601000000242800),
(3045, 0x837ee67d0601000000da0600),
(3045, 0x837ee77d0601000000db0600),
(3045, 0x807ee87d0601000000242800),
(3046, 0x7a7ee97d0601000000da0600),
(3046, 0x7a7eea7d0601000000db0600),
(3046, 0x7c7eec7d0601000000222800),
(3047, 0x7a7eee7d0601000000da0600),
(3047, 0x7a7eef7d0601000000db0600),
(3047, 0x7d7eed7d0601000000242800),
(3048, 0x807eed7d0601000000242800),
(3048, 0x837eee7d0601000000da0600),
(3048, 0x837eef7d0601000000db0600),
(3049, 0x837ee97d0601000000da0600),
(3049, 0x837eea7d0601000000db0600),
(3049, 0x817eec7d0601000000222800),
(3050, 0x4f7efb7d0701000000241900),
(3050, 0x4d7efc7d0701000000da0600),
(3050, 0x4d7efd7d0701000000db0600),
(3050, 0x4e7efc7d0701000000da0600),
(3050, 0x4e7efd7d0701000000db0600),
(3050, 0x537efb7d0701000000c50400),
(3050, 0x517efd7d0601000000c30400),
(3050, 0x537efe7d0601000000241900),
(3050, 0x517efd7d0701000000c30400),
(3050, 0x537efe7d0701000000241900),
(3050, 0x4e7e027e0601000000241900),
(3050, 0x4f7e027e0701000000241900),
(3050, 0x517e007e0701000000c30400),
(3051, 0x5b7efb7d0701000000241900),
(3051, 0x5f7efb7d0701000000c50400),
(3051, 0x597efc7d0701000000da0600),
(3051, 0x597efd7d0701000000db0600),
(3051, 0x5a7efc7d0701000000da0600),
(3051, 0x5a7efd7d0701000000db0600),
(3051, 0x5d7efd7d0601000000c30400),
(3051, 0x5f7efe7d0601000000241900),
(3051, 0x5d7efd7d0701000000c30400),
(3051, 0x5f7efe7d0701000000241900),
(3051, 0x5a7e027e0601000000241900),
(3051, 0x5b7e027e0701000000241900),
(3051, 0x5d7e007e0701000000c30400),
(3052, 0x3c7ef47d0701000000251900),
(3052, 0x407ef67d0701000000da0600),
(3052, 0x407ef77d0701000000db0600),
(3052, 0x417ef57d0701000000c50400),
(3052, 0x427ef67d0701000000da0600),
(3052, 0x427ef77d0701000000db0600),
(3052, 0x437ef47d0701000000c30400),
(3052, 0x417ef87d0701000000241900),
(3052, 0x427ef87d0701000000241900),
(3053, 0x3c7eef7d0701000000251900),
(3053, 0x407eeb7d0701000000da0600),
(3053, 0x427eeb7d0701000000da0600),
(3053, 0x407eec7d0701000000db0600),
(3053, 0x417eed7d0701000000c50400),
(3053, 0x427eec7d0701000000db0600),
(3053, 0x437eef7d0701000000c30400),
(3054, 0x3f7ee37d0701000000241900),
(3054, 0x3d7ee47d0701000000da0600),
(3054, 0x3d7ee57d0701000000db0600),
(3054, 0x3d7ee77d0701000000da0600),
(3054, 0x3c7ee87d0701000000251900),
(3054, 0x3d7ee87d0701000000db0600),
(3054, 0x3f7ee87d0701000000251900),
(3054, 0x417ee37d0701000000c50400),
(3054, 0x407ee57d0701000000c30400),
(3054, 0x437ee77d0701000000251900),
(3054, 0x437ee87d0701000000251900),
(3055, 0x3d7ee47d0601000000da0600),
(3055, 0x3d7ee57d0601000000db0600),
(3055, 0x3d7ee77d0601000000da0600),
(3055, 0x3c7ee87d0601000000251900),
(3055, 0x3d7ee87d0601000000db0600),
(3055, 0x3f7ee87d0601000000c30400),
(3055, 0x407ee57d0601000000c30400),
(3055, 0x437ee47d0601000000c30400),
(3055, 0x437ee77d0601000000251900),
(3055, 0x437ee87d0601000000251900),
(3056, 0x437eeb7d0601000000c30400),
(3056, 0x407eef7d0601000000da0600),
(3056, 0x417eed7d0601000000c50400),
(3056, 0x427eef7d0601000000da0600),
(3056, 0x437eef7d0601000000251900),
(3056, 0x407ef07d0601000000db0600),
(3056, 0x427ef07d0601000000db0600),
(3057, 0x3c7ef57d0601000000251900),
(3057, 0x3e7ef67d0601000000da0600),
(3057, 0x3e7ef77d0601000000db0600),
(3057, 0x3f7ef67d0601000000da0600),
(3057, 0x3f7ef77d0601000000db0600),
(3057, 0x3e7ef87d0601000000241900),
(3057, 0x407ef37d0601000000c30400),
(3057, 0x437ef27d0601000000c30400),
(3057, 0x417ef77d0601000000e00600),
(3057, 0x427ef57d0601000000c50400),
(3057, 0x427ef77d0601000000e10600),
(3057, 0x437ef47d0601000000251900),
(3057, 0x437ef77d0601000000251900),
(3058, 0x4f7eef7d0701000000242800),
(3058, 0x497ef17d0701000000192800),
(3058, 0x4a7ef37d0701000000db0600),
(3058, 0x4b7ef37d0701000000da0600),
(3058, 0x4a7ef47d0701000000db0600),
(3058, 0x4b7ef47d0701000000db0600),
(3058, 0x4c7ef57d0701000000182800),
(3058, 0x4f7ef57d0701000000182800),
(3058, 0x517ef17d0701000000192800),
(3059, 0x4d7ef17d0601000000192800),
(3059, 0x4f7ef07d0601000000e00600),
(3059, 0x4f7ef17d0601000000e00600),
(3059, 0x507ef07d0601000000e10600),
(3059, 0x507ef17d0601000000e10600),
(3059, 0x517ef17d0601000000192800),
(3059, 0x517ef37d0601000000222800),
(3059, 0x507ef57d0601000000182800),
(3060, 0x597eef7d0701000000da0600),
(3060, 0x5a7eee7d0701000000182800),
(3060, 0x5a7eef7d0701000000da0600),
(3060, 0x567ef07d0701000000222800),
(3060, 0x567ef27d0701000000192800),
(3060, 0x597ef07d0701000000db0600),
(3060, 0x5a7ef07d0701000000db0600),
(3060, 0x5c7ef17d0701000000192800),
(3060, 0x5c7ef37d0701000000222800),
(3060, 0x587ef67d0701000000182800),
(3060, 0x5b7ef67d07010000001a2800),
(3060, 0x5c7ef57d0701000000192800),
(3061, 0x627eed7d0701000000da0600),
(3061, 0x627eee7d0701000000db0600),
(3061, 0x677eed7d0701000000da0600),
(3061, 0x677eee7d0701000000db0600),
(3061, 0x687eee7d0701000000192800),
(3061, 0x647ef07d0701000000242800),
(3062, 0x657ef27d0701000000242800),
(3062, 0x617ef47d0701000000da0600),
(3062, 0x617ef57d0701000000db0600),
(3062, 0x637ef67d0701000000182800),
(3062, 0x667ef57d0701000000e00600),
(3062, 0x667ef67d0701000000182800),
(3062, 0x677ef57d0701000000e10600),
(3062, 0x687ef47d0701000000192800),
(3063, 0x627eef7d0601000000222800),
(3063, 0x657eef7d0601000000da0600),
(3063, 0x667eef7d0601000000da0600),
(3063, 0x687eee7d0601000000192800),
(3063, 0x657ef07d0601000000db0600),
(3063, 0x667ef07d0601000000db0600),
(3063, 0x687ef07d0601000000192800),
(3064, 0x687ef37d0601000000192800),
(3064, 0x627ef47d0601000000222800),
(3064, 0x647ef67d0601000000182800),
(3064, 0x657ef47d0601000000da0600),
(3064, 0x657ef57d0601000000db0600),
(3064, 0x667ef47d0601000000da0600),
(3064, 0x667ef57d0601000000db0600),
(3064, 0x667ef67d0601000000182800),
(3064, 0x687ef57d0601000000192800),
(3065, 0x4e7ece7d0601000000da0600),
(3065, 0x4e7ecf7d0601000000db0600),
(3065, 0x4e7ece7d0701000000da0600),
(3065, 0x4e7ecf7d0701000000db0600),
(3065, 0x4c7ed37d07010000006d1800),
(3065, 0x4c7eda7d06010000006d1800),
(3065, 0x4c7edd7d0701000000a80900),
(3065, 0x4c7ede7d07020000006d1800a80900),
(3065, 0x4e7edd7d0701000000a80900),
(3065, 0x4e7ede7d0701000000a80900),
(3067, 0xa17d1c7f07010000003c1900),
(3067, 0x9d7d207f07010000003d1900),
(3067, 0x9d7d267f0701000000db0d00),
(3067, 0xa07d237f0601000000d20d00),
(3067, 0xa07d237f0701000000d20d00),
(3067, 0xa47d207f07010000003d1900),
(3067, 0xa07d287f07010000003c1900),
(3068, 0x977d227f07010000003c1900),
(3068, 0x987d227f0701000000d20d00),
(3068, 0x997d227f0701000000d20d00),
(3068, 0x9a7d227f07010000003c1900),
(3068, 0x9b7d207f07010000003d1900),
(3069, 0x8f7d1e7f07010000003c1900),
(3069, 0x8e7d227f0601000000d20d00),
(3069, 0x8c7d207f07010000003d1900),
(3069, 0x8e7d227f0701000000d20d00),
(3069, 0x8c7d257f07010000003d1900),
(3069, 0x8f7d287f07010000003c1900),
(3069, 0x907d207f07010000003d1900),
(3069, 0x927d257f07010000003d1900),
(3069, 0x927d267f0701000000db0d00),
(3069, 0x927d277f07010000003d1900),
(3070, 0x8a7d3b7f07010000003d1900),
(3070, 0x8e7d397f07010000003c1900),
(3070, 0x8f7d3b7f0701000000db0d00),
(3070, 0x8a7d3c7f06010000003d1900),
(3070, 0x8f7d3d7f06010000003d1900),
(3070, 0x8f7d3e7f0601000000db0d00),
(3070, 0x8f7d3f7f06010000003d1900),
(3070, 0x8d7d3d7f0701000000d20d00),
(3070, 0x8f7d3f7f0701000000db0d00),
(3070, 0x917d397f0701000000d20d00),
(3070, 0x937d3a7f07010000003d1900),
(3070, 0x937d3b7f0701000000db0d00),
(3070, 0x937d3f7f0701000000db0d00),
(3070, 0x8a7d407f07010000003d1900),
(3070, 0x8d7d427f06010000003c1900),
(3070, 0x8d7d427f07010000003c1900),
(3070, 0x927d427f07010000003c1900),
(3070, 0x937d407f07010000003d1900),
(3071, 0x977d457f07010000003c1900),
(3071, 0x987d457f0701000000d20d00),
(3071, 0x997d457f07010000003c1900),
(3071, 0x937d487f06010000003c1900),
(3071, 0x907d4a7f07010000003d1900),
(3071, 0x947d4a7f0601000000db0d00),
(3071, 0x947d4a7f0701000000db0d00),
(3071, 0x9b7d497f06010000003d1900),
(3071, 0x9b7d497f07010000003d1900),
(3071, 0x987d4c7f06010000003c1900),
(3071, 0x987d4c7f07010000003c1900),
(3072, 0xa17d3b7f07010000003c1900),
(3072, 0xa77d3b7f07010000003c1900),
(3072, 0xaa7d3f7f06010000003d1900),
(3072, 0x9e7d417f07010000003d1900),
(3072, 0x9e7d427f0701000000db0d00),
(3072, 0x9e7d437f0701000000db0d00),
(3072, 0x9e7d447f07010000003d1900),
(3072, 0xa07d417f0501000000db0d00),
(3072, 0xa37d427f0601000000db0d00),
(3072, 0xa07d407f0701000000d20d00),
(3072, 0xa37d427f0701000000db0d00),
(3072, 0xa37d437f0701000000db0d00),
(3072, 0xa77d417f0501000000db0d00),
(3072, 0xa67d407f0601000000db0d00),
(3072, 0xaa7d407f07010000003d1900),
(3072, 0xa07d467f0501000000db0d00),
(3072, 0xa07d457f0701000000d20d00),
(3072, 0xa77d467f0501000000db0d00),
(3072, 0xa67d447f0601000000db0d00),
(3072, 0xaa7d447f05010000003d1900),
(3072, 0xa37d487f0601000000db0d00),
(3072, 0xa17d4a7f07010000003c1900),
(3072, 0xa67d487f0601000000db0d00),
(3072, 0xa77d4a7f07010000003c1900),
(3073, 0xb87d2e7f0601000000d20d00),
(3073, 0xb97d2e7f0601000000d20d00),
(3073, 0xb87d327f0701000000d20d00),
(3073, 0xb97d327f0701000000d20d00),
(3074, 0xb57d3a7f0501000000e00600),
(3074, 0xb67d3a7f0501000000e10600),
(3074, 0xb67d3a7f0601000000de0600),
(3074, 0xb67d3b7f0601000000df0600),
(3074, 0xb77d3b7f07010000003d1900),
(3074, 0xb57d3f7f0501000000e00600),
(3074, 0xb67d3f7f0501000000e10600),
(3074, 0xb67d3e7f0601000000de0600),
(3074, 0xb67d3f7f0601000000df0600),
(3074, 0xb77d3c7f06010000003d1900),
(3074, 0xb77d3d7f0701000000db0d00),
(3074, 0xb77d3f7f07010000003b1900),
(3074, 0xb37d407f07010000003a1900),
(3074, 0xb67d407f06010000003c1900),
(3074, 0xb57d407f07010000003a1900),
(3075, 0xb27d467f07010000003c1900),
(3075, 0xb57d447f0701000000db0d00),
(3075, 0xb57d457f07010000003d1900),
(3076, 0xb07d457f0601000000fe0e00),
(3076, 0xb17d457f0601000000ff0e00),
(3076, 0xb37d447f0601000000db0d00),
(3077, 0xb97d487f0601000000d20d00),
(3077, 0xb77d4c7f0601000000fe0e00),
(3077, 0xb87d4c7f0601000000ff0e00),
(3077, 0xbb7d4c7f06010000003b1900),
(3078, 0xb87d487f0701000000d20d00),
(3078, 0xba7d497f0701000000fc0e00),
(3078, 0xba7d4a7f0701000000fd0e00),
(3078, 0xbb7d4b7f07010000003d1900),
(3078, 0xb77d4d7f07010000003c1900),
(3079, 0xc17d4b7f0601000000fe0e00),
(3079, 0xc27d4b7f0601000000ff0e00),
(3079, 0xc07d4a7f0701000000db0d00),
(3079, 0xc27d487f07010000003a1900),
(3079, 0xc57d4a7f07010000003d1900),
(3079, 0xc37d4c7f07010000003c1900),
(3081, 0x3e7d0a7f05010000003b1900),
(3081, 0x3f7d0b7f0501000000fe0e00),
(3081, 0x3f7d117f0501000000fe0e00),
(3081, 0x3e7d157f05010000003b1900),
(3081, 0x3f7d167f0501000000fe0e00),
(3081, 0x4c7d077f05010000003a1900),
(3081, 0x407d0b7f0501000000ff0e00),
(3081, 0x407d0b7f0601000000fe0e00),
(3081, 0x417d0b7f0601000000ff0e00),
(3081, 0x437d0b7f0601000000fe0e00),
(3081, 0x447d0b7f0501000000d20d00),
(3081, 0x447d0b7f0601000000ff0e00),
(3081, 0x497d087f0501000000fc0e00),
(3081, 0x497d097f0501000000fd0e00),
(3081, 0x4a7d0b7f05010000003a1900),
(3081, 0x4c7d0b7f0601000000fc0e00),
(3081, 0x4e7d0b7f0601000000fc0e00),
(3081, 0x417d0c7f05010000003a1900),
(3081, 0x4f7d0c7f0501000000d20d00),
(3081, 0x4c7d0c7f0601000000fd0e00),
(3081, 0x4e7d0c7f0601000000fd0e00),
(3081, 0x407d117f0501000000ff0e00),
(3081, 0x427d137f0501000000db0d00),
(3081, 0x407d167f0501000000ff0e00),
(3081, 0x417d177f05010000003a1900),
(3081, 0x417d147f0601000000fe0e00),
(3081, 0x417d177f0601000000fe0e00),
(3081, 0x427d147f0601000000ff0e00),
(3081, 0x427d177f0601000000ff0e00),
(3081, 0x497d177f0501000000fc0e00),
(3081, 0x4c7d157f0501000000d20d00),
(3081, 0x497d187f0501000000fd0e00),
(3081, 0x4c7d197f05010000003a1900),
(3081, 0x527d177f07010000003a1900),
(3081, 0x537d167f0701000000db0d00),
(3082, 0x977c8e7e0701000000391900),
(3082, 0x9d7c8d7e0701000000391900),
(3082, 0x9d7c8e7e0701000000d50400),
(3082, 0x9d7c8f7e0701000000391900),
(3083, 0xa77c867e0701000000381900),
(3083, 0xaa7c867e0701000000381900),
(3083, 0xa27c887e0701000000391900),
(3083, 0xa57c897e0701000000d50400),
(3083, 0xa27c8c7e0701000000391900),
(3083, 0xa47c8d7e0701000000381900),
(3083, 0xa87c8e7e0701000000381900),
(3083, 0xa97c8e7e0701000000d70400),
(3083, 0xaa7c8e7e0701000000381900),
(3084, 0xa77c917e0701000000d70400),
(3084, 0xa87c917e0701000000381900),
(3085, 0xa87c977e0701000000d70400),
(3085, 0xa97c977e0701000000381900),
(3086, 0xac7c907e0701000000d50400),
(3087, 0xae7c947e0601000000381900),
(3087, 0xaf7c947e0601000000d70400),
(3087, 0xaf7c977e0701000000381900),
(3087, 0xb37c907e0601000000391900),
(3087, 0xb37c937e0601000000391900),
(3087, 0xb27c947e0601000000381900),
(3087, 0xb07c977e0701000000d70400),
(3087, 0xb17c977e0701000000381900),
(3087, 0xb37c957e0701000000391900),
(3088, 0xbb7c8f7e0701000000391900),
(3088, 0xbe7c8c7e0701000000381900),
(3088, 0xbd7c917e0701000000381900),
(3088, 0xc07c8e7e0701000000d50400),
(3089, 0xc57c877e0701000000381900),
(3089, 0xc17c8a7e0701000000391900),
(3089, 0xc37c8b7e0701000000d70400),
(3089, 0xc67c8b7e0701000000d70400),
(3089, 0xc77c8a7e0701000000391900),
(3089, 0xc47c8d7e0701000000371900),
(3089, 0xc77c8d7e0701000000391900),
(3090, 0xc87c8f7e0701000000381900),
(3090, 0xc47c917e0701000000d50400),
(3090, 0xc47c927e0701000000391900),
(3090, 0xc97c927e0701000000381900),
(3090, 0xc67c947e0701000000381900),
(3091, 0x877c957e0701000000381900),
(3091, 0x897c957e0701000000381900),
(3091, 0x877c9b7e0601000000381900),
(3091, 0x877c9b7e0701000000381900),
(3091, 0x887c9b7e0601000000d70400),
(3091, 0x897c9b7e0601000000381900),
(3091, 0x887c9b7e0701000000d70400),
(3091, 0x897c9b7e0701000000381900),
(3091, 0x8c7c987e0601000000391900),
(3091, 0x8c7c997e0601000000d50400),
(3092, 0x6e7c9a7e0701000000391900),
(3092, 0x6f7c9e7e0601000000381900),
(3092, 0x6e7c9d7e0701000000391900),
(3092, 0x737c977e0601000000391900),
(3092, 0x727c967e0701000000381900),
(3092, 0x777c967e0701000000381900),
(3092, 0x737c987e0601000000d50400),
(3092, 0x737c9a7e0601000000391900),
(3092, 0x757c997e0701000000381900),
(3092, 0x777c997e0701000000d70400),
(3092, 0x737c9c7e0601000000391900),
(3092, 0x737c9e7e0601000000d50400),
(3092, 0x757c9e7e0701000000d50400),
(3093, 0x837ca27e0701000000381900),
(3093, 0x807ca67e0601000000d50400),
(3093, 0x807ca77e0601000000391900),
(3093, 0x807ca57e0701000000391900),
(3093, 0x807ca67e0701000000d50400),
(3093, 0x867ca67e0601000000391900),
(3093, 0x867ca57e0701000000391900),
(3093, 0x847caa7e0601000000381900),
(3093, 0x867ca87e0601000000391900),
(3093, 0x867ca97e0701000000391900),
(3094, 0x6d7cab7e0601000000391900),
(3094, 0x6d7cab7e0701000000391900),
(3094, 0x6d7cae7e0601000000391900),
(3094, 0x6d7cae7e0701000000391900),
(3094, 0x707ca87e0701000000381900),
(3094, 0x747ca87e0701000000381900),
(3094, 0x767cac7e0701000000d50400),
(3094, 0x767cae7e0701000000391900),
(3094, 0x717cb07e0601000000381900),
(3094, 0x737cb07e0601000000d70400),
(3094, 0x707cb07e0701000000381900),
(3094, 0x747cb07e0701000000381900),
(3095, 0x7b7caf7e0601000000391900),
(3095, 0x7d7cad7e0601000000381900),
(3095, 0x7b7cb07e0601000000391900),
(3095, 0x7d7cb27e0601000000381900),
(3095, 0x7e7cb27e0601000000d70400),
(3095, 0x817caf7e0601000000d50400),
(3096, 0x777cb67e0601000000381900),
(3096, 0x777cb67e0701000000381900),
(3096, 0x7b7cb67e0601000000381900),
(3096, 0x797cb67e0701000000d70400),
(3096, 0x7b7cb67e0701000000381900),
(3096, 0x747cb97e0601000000391900),
(3096, 0x747cb97e0701000000391900),
(3096, 0x7d7cb97e0601000000391900),
(3096, 0x7d7cb97e0701000000391900),
(3096, 0x797cbc7e0601000000381900),
(3096, 0x797cbc7e0701000000381900),
(3097, 0x807cb77e0701000000381900),
(3097, 0x817cb77e0701000000d70400),
(3097, 0x837cbb7e0701000000381900),
(3097, 0x847cb97e0701000000391900),
(3097, 0x807cbc7e0701000000381900),
(3098, 0xb47caf7e0701000000d70400),
(3098, 0xab7cb37e0701000000391900),
(3098, 0xad7cb17e0701000000381900),
(3098, 0xaf7cb37e0701000000d50400),
(3098, 0xab7cb67e0701000000391900),
(3098, 0xaf7cb77e0701000000381900),
(3098, 0xac7cb87e0601000000381900),
(3098, 0xb17cb17e0701000000381900),
(3098, 0xb27cb07e0701000000391900),
(3098, 0xb57cb07e0701000000391900),
(3098, 0xb27cb77e0701000000381900),
(3098, 0xb57cb57e0601000000d50400),
(3098, 0xb57cb67e0701000000d50400),
(3098, 0xb37cb87e0601000000381900),
(3100, 0x9e7cae7e0701000000d70400),
(3100, 0x9b7cb07e0701000000391900),
(3101, 0xa27cb07e0701000000381900),
(3101, 0xa67cb27e0601000000391900),
(3101, 0xa47cb07e0701000000d70400),
(3101, 0xa57cb07e0701000000381900),
(3101, 0xa27cb67e0701000000381900),
(3101, 0xa57cb67e0601000000d70400),
(3101, 0xa67cb57e0601000000391900),
(3101, 0xa67cb77e0701000000391900),
(3102, 0x9b7cb27e0601000000391900),
(3102, 0x9b7cb57e0601000000391900),
(3102, 0x9b7cb77e0701000000391900),
(3102, 0x9d7cb67e0601000000d70400),
(3102, 0xa07cb67e0701000000d70400),
(3104, 0xb97cbb7e0701000000d70400),
(3104, 0xba7cba7e0701000000391900),
(3104, 0xbd7cba7e0601000000391900),
(3104, 0xbe7cbb7e0601000000381900),
(3104, 0xbc7cb97e0701000000381900),
(3104, 0xb77cbd7e0701000000391900),
(3104, 0xb77cbf7e0701000000391900),
(3104, 0xbe7cbf7e0601000000381900),
(3104, 0xbf7cbc7e0601000000391900),
(3105, 0xa77cbb7e0701000000d70400),
(3106, 0x9d7cbb7e0701000000381900),
(3106, 0x9e7cbb7e0701000000d70400),
(3106, 0x9f7cbb7e0701000000381900),
(3106, 0xa07cbf7e0601000000381900),
(3107, 0x957cb97e0701000000381900),
(3107, 0x927cbc7e0701000000d50400),
(3107, 0x927cbd7e0701000000391900),
(3107, 0x947cbe7e0601000000381900),
(3107, 0x967cbe7e0601000000d70400),
(3107, 0x977cbe7e0601000000381900),
(3107, 0x987cbd7e0601000000391900),
(3108, 0x947cc37e0601000000391900),
(3108, 0x947cc37e0701000000d50400),
(3108, 0x967cc17e0701000000381900),
(3108, 0x9a7cc27e0601000000381900),
(3108, 0x987cc17e0701000000381900),
(3108, 0x9a7cc27e0701000000381900),
(3108, 0x957cc57e0701000000381900),
(3108, 0x997cc77e0601000000381900),
(3108, 0x9b7cc57e0601000000d50400),
(3108, 0x987cc77e0701000000381900),
(3108, 0x9a7cc77e0701000000381900),
(3108, 0x9c7cc67e0701000000381900),
(3109, 0x9e7cc87e0701000000391900),
(3109, 0xa07cc97e0701000000381900),
(3109, 0xa27cc97e0701000000d70400),
(3109, 0xa47cc87e0701000000391900),
(3110, 0xa27cce7e0701000000381900),
(3110, 0xa37cce7e0701000000d70400),
(3110, 0xa27cd27e0601000000d70400),
(3110, 0xa27cd27e0701000000d70400),
(3110, 0xa57cd07e0601000000391900),
(3110, 0xa57cd17e0601000000391900),
(3110, 0xa27cd47e0701000000381900),
(3110, 0xa37cd47e0701000000381900),
(3111, 0x987ccc7e0701000000381900),
(3111, 0x9a7ccc7e0701000000d70400),
(3111, 0x9b7ccc7e0701000000381900),
(3111, 0x9e7cce7e0601000000391900),
(3111, 0x977cd37e0601000000381900),
(3111, 0x9a7cd37e0701000000381900),
(3112, 0x8a7ccb7e0701000000391900),
(3112, 0x8c7cc97e0701000000d70400),
(3112, 0x8d7cc97e0701000000381900),
(3112, 0x8a7cce7e0701000000391900),
(3112, 0x8b7cd07e0701000000391900),
(3112, 0x8d7cd17e0601000000381900),
(3112, 0x8e7cd17e0601000000381900),
(3113, 0x917cca7e0701000000d70400),
(3113, 0x927cca7e0701000000381900),
(3113, 0x937ccd7e0601000000391900),
(3113, 0x937ccc7e0701000000391900),
(3113, 0x937cce7e0701000000391900),
(3113, 0x907cd17e0601000000381900),
(3113, 0x917cd17e0601000000381900),
(3113, 0x927cd07e0601000000391900),
(3113, 0x927cd07e0701000000391900),
(3115, 0x1f7e107e0601000000321300),
(3115, 0x1f7e117e0601000000321300),
(3115, 0x1c7e107e0701000000871e00),
(3115, 0x1c7e117e0701000000881e00),
(3116, 0x1a7e037e0701000000891e00),
(3116, 0x1b7e037e07010000008a1e00),
(3116, 0x207e047e0701000000c30400),
(3118, 0x2e7e197e0701000000da0600),
(3118, 0x2e7e1a7e0701000000db0600),
(3118, 0x307e167e0601000000321300),
(3118, 0x317e187e0601000000831e00),
(3118, 0x317e197e0601000000841e00),
(3118, 0x307e197e0701000000da0600),
(3118, 0x307e1a7e0701000000db0600),
(3118, 0x327e197e0701000000da0600),
(3118, 0x327e1a7e0701000000db0600),
(3120, 0x537ee37d0601000000182800),
(3120, 0x537ee37d0701000000182800),
(3120, 0x577ee37d0601000000182800),
(3120, 0x587ee37d0701000000182800),
(3120, 0x517ee67d0601000000192800),
(3120, 0x517ee67d0701000000192800),
(3120, 0x567ee47d06010000008b1e00),
(3120, 0x567ee57d06010000008c1e00),
(3120, 0x587ee47d0601000000871e00),
(3120, 0x587ee57d0601000000881e00),
(3120, 0x597ee67d0601000000192800),
(3120, 0x597ee67d0701000000192800),
(3120, 0x537ee87d0601000000242800),
(3120, 0x517eea7d0701000000192800),
(3120, 0x537ee87d0701000000242800),
(3120, 0x577ee87d0601000000242800),
(3120, 0x557ee87d0701000000242800),
(3120, 0x567eea7d0701000000192800),
(3120, 0x567eeb7d0701000000222800),
(3120, 0x587ee87d0601000000182800),
(3120, 0x587ee87d0701000000182800),
(3120, 0x537eec7d0601000000182800),
(3120, 0x537eec7d0701000000182800),
(3120, 0x557eec7d0701000000182800),
(3121, 0x4e7ee57d0601000000871e00),
(3121, 0x4e7ee67d0601000000881e00),
(3121, 0x4f7ee67d0701000000192800),
(3121, 0x4e7ee87d0601000000242800),
(3121, 0x4c7eeb7d0701000000182800),
(3121, 0x4d7ee87d0701000000640600),
(3121, 0x4e7eeb7d0701000000242800),
(3121, 0x4f7eea7d0701000000192800),
(3122, 0xae7caa7e0601000000391900),
(3122, 0xb57ca97e0601000000391900),
(3122, 0xb57caa7e0601000000d50400),
(3123, 0x797eff7d0601000000891e00),
(3123, 0x7a7eff7d06010000008a1e00),
(3123, 0x7e7eff7d0701000000871e00),
(3123, 0x7f7efe7d0701000000241900),
(3123, 0x807eff7d07010000008b1e00),
(3123, 0x797e017e06010000008d1e00),
(3123, 0x7a7e017e06010000008e1e00),
(3123, 0x7a7e027e0601000000261900),
(3123, 0x787e007e0701000000251900),
(3123, 0x7b7e027e0701000000bc0400),
(3123, 0x7c7e007e0601000000ba0400),
(3123, 0x7d7e027e0601000000bc0400),
(3123, 0x7e7e007e0701000000881e00),
(3123, 0x7e7e037e0701000000bc0400),
(3123, 0x7f7e037e0701000000130700),
(3123, 0x7a7e067e0701000000241900),
(3123, 0x7e7e067e0601000000241900),
(3123, 0x7c7e057e0701000000ba0400),
(3123, 0x7e7e067e0701000000241900),
(3123, 0x7f7e067e0701000000241900),
(3123, 0x807e007e07010000008c1e00),
(3123, 0x817e017e0701000000251900),
(3124, 0x7d7e0b7e06010000008b1e00),
(3124, 0x7c7e0a7e07010000001a2800),
(3124, 0x797e0c7e0701000000192800),
(3124, 0x7b7e0f7e0701000000242800),
(3124, 0x7c7e0f7e06010000001a2800),
(3124, 0x7d7e0c7e06010000008c1e00),
(3124, 0x7e7e0e7e06010000001b2800),
(3124, 0x7c7e0d7e0701000000660600),
(3124, 0x7c7e0f7e0701000000182800),
(3124, 0x7e7e0e7e0701000000192800),
(3125, 0x5e7ee57d06010000008b1e00),
(3125, 0x5e7ee67d06010000008c1e00),
(3125, 0x5d7ee77d0701000000192800),
(3125, 0x607ee47d0601000000182800),
(3125, 0x617ee77d0601000000222800),
(3125, 0x607ee47d0701000000182800),
(3125, 0x617ee77d0701000000222800),
(3125, 0x637ee77d0701000000222800),
(3125, 0x657ee47d0601000000182800),
(3125, 0x667ee57d0601000000871e00),
(3125, 0x667ee67d0601000000881e00),
(3125, 0x677ee77d0701000000192800),
(3125, 0x607ee97d0601000000182800),
(3125, 0x607ee97d0701000000182800),
(3125, 0x627ee97d0701000000242800),
(3125, 0x657ee97d0601000000182800),
(3125, 0x657ee97d0701000000182800),
(3126, 0x3a7e097e0701000000831e00),
(3126, 0x3a7e0a7e0701000000841e00),
(3126, 0x3b7e087e07010000001a2800),
(3126, 0x3c7e0a7e0701000000620600),
(3126, 0x3b7e0c7e0701000000251900),
(3126, 0x3f7e0d7e07010000001a2800),
(3126, 0x407e0b7e0701000000222800),
(3127, 0x447e0b7e0701000000222800),
(3127, 0x467e097e07010000001a2800),
(3127, 0x477e0b7e0701000000620600),
(3127, 0x497e097e07010000001a2800),
(3127, 0x4a7e0a7e0701000000871e00),
(3127, 0x4a7e0b7e0701000000881e00),
(3127, 0x497e0f7e07010000001a2800),
(3128, 0x4c7e087e07010000008b1e00),
(3128, 0x4c7e097e07010000008c1e00),
(3128, 0x4e7e0a7e0701000000620600),
(3128, 0x4d7e0c7e07010000001a2800),
(3128, 0x507e067e07010000001a2800),
(3128, 0x527e0b7e0701000000222800),
(3128, 0x517e0c7e07010000001a2800),
(3129, 0x3f7e097e06010000008b1e00),
(3129, 0x3f7e0a7e06010000008c1e00),
(3129, 0x3b7e0c7e0601000000251900),
(3129, 0x3d7e0d7e06010000001a2800),
(3130, 0x417e097e0601000000871e00),
(3130, 0x417e0a7e0601000000881e00),
(3130, 0x447e0b7e0601000000222800),
(3130, 0x427e0d7e06010000001a2800),
(3130, 0x467e0d7e0601000000242800),
(3130, 0x4a7e0f7e06010000001a2800),
(3131, 0x4c7e087e0601000000831e00),
(3131, 0x4c7e097e0601000000841e00),
(3131, 0x4e7e0c7e0601000000242800),
(3131, 0x4f7e0c7e0601000000251900),
(3131, 0x507e077e06010000001a2800),
(3132, 0x537e097e0601000000871e00),
(3132, 0x537e0a7e0601000000881e00),
(3132, 0x567e0a7e0601000000222800),
(3132, 0x567e0b7e06010000001b2800),
(3132, 0x547e0c7e06010000001a2800),
(3133, 0x3f7e0b7e0501000000222800),
(3133, 0x447e0b7e05010000001b2800),
(3134, 0x4b7e0b7e0501000000222800),
(3134, 0x4d7e0c7e05010000001a2800),
(3134, 0x527e0a7e05010000001b2800),
(3134, 0x507e0c7e05010000001a2800),
(3135, 0x5d7e057e0701000000182800),
(3135, 0x5a7e087e0601000000192800),
(3135, 0x5a7e087e0701000000192800),
(3135, 0x5b7e0b7e0701000000871e00),
(3135, 0x5c7e0a7e0601000000242800),
(3135, 0x5d7e0b7e06010000008b1e00),
(3135, 0x5c7e0a7e0701000000242800),
(3135, 0x5a7e0c7e0701000000192800),
(3135, 0x5b7e0c7e0701000000881e00),
(3135, 0x5c7e0e7e0601000000182800),
(3135, 0x5d7e0c7e06010000008c1e00),
(3135, 0x5e7e0c7e0601000000192800),
(3135, 0x5c7e0e7e0701000000182800),
(3135, 0x5e7e0c7e0701000000192800),
(3135, 0x5e7e0d7e0701000000222800),
(3135, 0x607e087e0601000000192800),
(3135, 0x607e087e0701000000192800),
(3136, 0x427efe7d0701000000871e00),
(3136, 0x427eff7d0701000000881e00),
(3136, 0x447efe7d0701000000871e00),
(3136, 0x447eff7d0701000000881e00),
(3136, 0x457efd7d07010000001a2800),
(3136, 0x487eff7d07010000001b2800),
(3136, 0x457e037e07010000001a2800),
(3136, 0x487e007e0701000000222800),
(3137, 0x857ecb7c0601000000de0600),
(3137, 0x877ec97c0601000000321900),
(3137, 0x857ecc7c0601000000df0600),
(3137, 0x867ece7c0601000000321900),
(3137, 0x877ece7c0601000000381800),
(3138, 0x8a7ece7c0601000000381800),
(3138, 0x8b7ece7c0601000000321900),
(3139, 0x8e7ec97c0601000000341900),
(3139, 0x8f7ecb7c0601000000de0600),
(3139, 0x8e7ece7c0601000000381800),
(3139, 0x8f7ecc7c0601000000df0600),
(3139, 0x8f7ece7c0601000000321900),
(3140, 0x907ee07c0601000000361800),
(3140, 0x907ee27c0601000000351900),
(3140, 0x927ee27c0601000000de0600),
(3140, 0x927ee37c0601000000df0600),
(3140, 0x937ee27c0601000000de0600),
(3140, 0x937ee37c0601000000df0600),
(3140, 0x947ee07c0601000000351900),
(3140, 0x947ee27c0601000000351900),
(3141, 0x917eef7c0601000000de0600),
(3141, 0x947eef7c0601000000de0600),
(3141, 0x917ef07c0601000000df0600),
(3141, 0x947ef07c0601000000df0600),
(3141, 0x947ef47c0601000000c50400),
(3142, 0x987eef7c0601000000de0600),
(3142, 0x987ef07c0601000000df0600),
(3142, 0x997ef07c0601000000331900),
(3142, 0x997ef27c0601000000331900),
(3142, 0x987ef47c0601000000c50400),
(3143, 0x8e7efc7c0601000000de0600),
(3143, 0x8e7efd7c0601000000df0600),
(3143, 0x8f7efc7c0601000000de0600),
(3143, 0x8f7efd7c0601000000df0600),
(3143, 0x907ef97c0601000000381800),
(3143, 0x927efe7c0601000000321900),
(3143, 0x937efc7c0601000000331900),
(3144, 0x8f7efa7c0701000000381800),
(3144, 0x917efb7c0701000000de0600),
(3144, 0x907efe7c0701000000321900),
(3144, 0x917efc7c0701000000df0600),
(3145, 0x917eee7c0701000000de0600),
(3145, 0x917eef7c0701000000df0600),
(3145, 0x937eed7c0701000000341900),
(3145, 0x957eee7c0701000000de0600),
(3145, 0x957eef7c0701000000df0600),
(3145, 0x917ef27c0701000000de0600),
(3145, 0x917ef37c0701000000df0600),
(3145, 0x927ef27c0701000000de0600),
(3145, 0x927ef37c0701000000df0600),
(3145, 0x987ef27c0701000000351900),
(3145, 0x947ef47c0701000000381800),
(3145, 0x977ef47c0701000000321900),
(3146, 0x857eec7c0701000000321900),
(3146, 0x867eed7c0701000000dc0600),
(3146, 0x877eed7c0701000000dd0600),
(3146, 0x847ef27c0701000000381800),
(3146, 0x857ef27c0701000000321900),
(3146, 0x867ef07c0701000000de0600),
(3146, 0x867ef17c0701000000df0600),
(3146, 0x877ef07c0701000000de0600),
(3146, 0x877ef17c0701000000df0600),
(3146, 0x887ef07c0701000000331900),
(3147, 0x907edf7c0701000000de0600),
(3147, 0x937edf7c0701000000de0600),
(3147, 0x8f7ee07c0701000000331900),
(3147, 0x907ee07c0701000000df0600),
(3147, 0x917ee37c0701000000381800),
(3147, 0x937ee07c0701000000df0600),
(3147, 0x937ee37c0701000000321900),
(3147, 0x947ee07c0701000000331900),
(3147, 0x947ee27c0701000000331900),
(3170, 0xe27e698007010000007e1500),
(3170, 0xe27e6a8007010000007f1500),
(3170, 0xe07e6c8007010000007a1b00),
(3170, 0xe47e6f800701000000831b00),
(3170, 0xdc7e718007010000007e1500),
(3170, 0xdc7e728007010000007f1500),
(3170, 0xdd7e738007010000007c1500),
(3170, 0xde7e738007010000007d1500),
(3171, 0xff7e678007010000007a1b00),
(3171, 0xfb7e6c800701000000831b00),
(3171, 0x007f688007010000007c1500),
(3171, 0x017f688007010000007d1500),
(3171, 0x017f698007010000007c1500),
(3171, 0x027f698007010000007d1500),
(3172, 0xf67e758007010000007a1b00),
(3172, 0xf97e778007010000007c1500),
(3172, 0xfa7e778007010000007d1500),
(3172, 0xfb7e788007010000007e1500),
(3172, 0xfb7e798007010000007f1500),
(3172, 0xfc7e7a8007010000007e1500),
(3172, 0xfc7e7b8007010000007f1500),
(3173, 0xe47e8f8007010000007e1500),
(3173, 0xe77e8d8007010000007a1b00),
(3173, 0xea7e8d8007010000007c1500),
(3173, 0xeb7e8d8007010000007d1500),
(3173, 0xee7e8c800701000000831b00),
(3173, 0xe47e908007010000007f1500),
(3173, 0xe97e928007010000007e1500),
(3173, 0xe97e938007010000007f1500),
(3174, 0xf17e8f8007010000007e1500),
(3174, 0xf27e8e8007010000007a1b00),
(3174, 0xf47e8e800701000000771b00),
(3174, 0xfb7e8f8007010000007e1500),
(3174, 0xf17e908007010000007f1500),
(3174, 0xf57e90800701000000831b00),
(3174, 0xfb7e908007010000007f1500),
(3175, 0xf47e5b8006010000007c1500),
(3175, 0xf57e5b8006010000007d1500),
(3175, 0xf67e5b8006010000007c1500),
(3175, 0xf77e5b8006010000007d1500),
(3175, 0xef7e628006010000007c1500),
(3175, 0xf07e628006010000007d1500),
(3175, 0xf77e61800601000000831b00),
(3176, 0xd77e628006010000007c1500),
(3176, 0xd87e628006010000007d1500),
(3176, 0xdd7e65800601000000831b00),
(3176, 0xd97e688006010000007c1500),
(3176, 0xda7e688006010000007d1500),
(3176, 0xe17e618006010000007e1500),
(3176, 0xe17e628006010000007f1500),
(3176, 0xe27e638006010000007a1b00),
(3176, 0xe67e628006010000007c1500),
(3176, 0xe77e628006010000007d1500),
(3176, 0xe37e698006010000007a1b00),
(3177, 0xd77e6f8006010000007c1500),
(3177, 0xd87e6f8006010000007d1500),
(3177, 0xda7e6d8006010000007c1500),
(3177, 0xdb7e6d8006010000007d1500),
(3177, 0xdb7e768006010000007e1500),
(3177, 0xdb7e778006010000007f1500),
(3177, 0xdc7e758006010000007a1b00),
(3177, 0xe27e728006010000007a1b00),
(3177, 0xe17e798006010000007c1500),
(3177, 0xe27e798006010000007d1500),
(3178, 0xee7e778006010000007a1b00),
(3178, 0xe47e798006010000007c1500),
(3178, 0xe57e798006010000007d1500),
(3178, 0xef7e788006010000007c1500),
(3178, 0xe67e7f8006010000007e1500),
(3178, 0xea7e7c800601000000831b00),
(3178, 0xf07e788006010000007d1500),
(3178, 0xf07e798006010000007e1500),
(3178, 0xf07e7a8006010000007f1500),
(3178, 0xe67e808006010000007f1500),
(3179, 0xdb7e638005010000007a1b00),
(3179, 0xde7e608005010000007c1500),
(3179, 0xdf7e608005010000007d1500),
(3179, 0xd67e668005010000007e1500),
(3179, 0xd67e678005010000007f1500),
(3179, 0xd67e698005010000007c1500),
(3179, 0xd77e698005010000007d1500),
(3179, 0xdd7e68800501000000831b00),
(3179, 0xe07e618005010000007e1500),
(3179, 0xe07e628005010000007f1500),
(3180, 0x2b7f7b8005010000007c1500),
(3180, 0x287f788006010000007a1b00),
(3180, 0x2c7f7b8005010000007d1500),
(3180, 0x2e7f7a8005010000007c1500),
(3180, 0x2f7f7a8005010000007d1500),
(3180, 0x2d7f7a8006010000007c1500),
(3180, 0x2e7f7a8006010000007d1500),
(3180, 0x2a7f7c800501000000831b00),
(3180, 0x297f7d8006010000007c1500),
(3180, 0x2a7f7d8006010000007d1500),
(3180, 0x2b7f7c800601000000831b00),
(3180, 0x317f7a800501000000781b00),
(3180, 0x317f7a800601000000781b00),
(3180, 0x317f7c800501000000781b00),
(3180, 0x2e7f80800501000000771b00),
(3180, 0x2e7f80800601000000771b00),
(3181, 0x5e7e177e0701000000192800),
(3181, 0x5f7e197e0701000000da0600),
(3181, 0x5f7e1a7e0701000000db0600),
(3181, 0x617e137e0701000000202800),
(3181, 0x637e137e0701000000182800),
(3181, 0x617e1b7e0701000000182800),
(3182, 0x677e137e0701000000202800),
(3182, 0x697e137e0701000000182800),
(3182, 0x6a7e177e0701000000192800),
(3182, 0x687e1b7e0701000000182800),
(3182, 0x697e197e0701000000da0600),
(3182, 0x697e1a7e0701000000db0600),
(3183, 0x727e137e0701000000202800),
(3183, 0x747e137e0701000000182800),
(3183, 0x707e197e0701000000da0600),
(3183, 0x707e1a7e0701000000db0600),
(3183, 0x707e1b7e0701000000182800),
(3183, 0x737e1b7e0701000000182800),
(3184, 0x787e137e0701000000202800),
(3184, 0x7a7e137e0701000000182800),
(3184, 0x7b7e177e0701000000192800),
(3184, 0x777e1b7e0701000000182800),
(3184, 0x7a7e197e0701000000da0600),
(3184, 0x7a7e1a7e0701000000db0600),
(3184, 0x7a7e1b7e0701000000182800),
(3185, 0x9f7e227e0701000000da0600),
(3185, 0x9f7e237e0701000000db0600),
(3185, 0xa27e237e0701000000192800),
(3185, 0xa07e257e0701000000202800);

-- --------------------------------------------------------

--
-- Structure de la table `znote`
--

CREATE TABLE `znote` (
  `id` int(11) NOT NULL,
  `version` varchar(30) NOT NULL COMMENT 'Znote AAC version',
  `installed` int(11) NOT NULL,
  `cached` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `znote`
--

INSERT INTO `znote` (`id`, `version`, `installed`, `cached`) VALUES
(1, '1.5_SVN', 1621202400, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `znote_accounts`
--

CREATE TABLE `znote_accounts` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `ip` bigint(20) UNSIGNED NOT NULL,
  `created` int(11) NOT NULL,
  `points` int(11) DEFAULT '0',
  `cooldown` int(11) DEFAULT '0',
  `active` tinyint(4) NOT NULL DEFAULT '0',
  `active_email` tinyint(4) NOT NULL DEFAULT '0',
  `activekey` int(11) NOT NULL DEFAULT '0',
  `flag` varchar(20) NOT NULL,
  `secret` char(16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `znote_accounts`
--

INSERT INTO `znote_accounts` (`id`, `account_id`, `ip`, `created`, `points`, `cooldown`, `active`, `active_email`, `activekey`, `flag`, `secret`) VALUES
(1, 1, 0, 1621202400, 0, 0, 0, 0, 0, '', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `znote_auction_player`
--

CREATE TABLE `znote_auction_player` (
  `id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `original_account_id` int(11) NOT NULL,
  `bidder_account_id` int(11) NOT NULL,
  `time_begin` int(11) NOT NULL,
  `time_end` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `bid` int(11) NOT NULL,
  `deposit` int(11) NOT NULL,
  `sold` tinyint(4) NOT NULL,
  `claimed` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `znote_changelog`
--

CREATE TABLE `znote_changelog` (
  `id` int(11) NOT NULL,
  `text` varchar(255) NOT NULL,
  `time` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `znote_deleted_characters`
--

CREATE TABLE `znote_deleted_characters` (
  `id` int(11) NOT NULL,
  `original_account_id` int(11) NOT NULL,
  `character_name` varchar(255) NOT NULL,
  `time` datetime NOT NULL,
  `done` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `znote_forum`
--

CREATE TABLE `znote_forum` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `access` tinyint(4) NOT NULL,
  `closed` tinyint(4) NOT NULL,
  `hidden` tinyint(4) NOT NULL,
  `guild_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `znote_forum`
--

INSERT INTO `znote_forum` (`id`, `name`, `access`, `closed`, `hidden`, `guild_id`) VALUES
(1, 'Staff Board', 4, 0, 0, 0),
(2, 'Tutors Board', 2, 0, 0, 0),
(3, 'Discussion', 1, 0, 0, 0),
(4, 'Feedback', 1, 0, 1, 0);

-- --------------------------------------------------------

--
-- Structure de la table `znote_forum_posts`
--

CREATE TABLE `znote_forum_posts` (
  `id` int(11) NOT NULL,
  `thread_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `player_name` varchar(50) NOT NULL,
  `text` text NOT NULL,
  `created` int(11) NOT NULL,
  `updated` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `znote_forum_threads`
--

CREATE TABLE `znote_forum_threads` (
  `id` int(11) NOT NULL,
  `forum_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `player_name` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `text` text NOT NULL,
  `created` int(11) NOT NULL,
  `updated` int(11) NOT NULL,
  `sticky` tinyint(4) NOT NULL,
  `hidden` tinyint(4) NOT NULL,
  `closed` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `znote_global_storage`
--

CREATE TABLE `znote_global_storage` (
  `key` varchar(32) NOT NULL,
  `value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `znote_global_storage`
--

INSERT INTO `znote_global_storage` (`key`, `value`) VALUES
('23856', '19');

-- --------------------------------------------------------

--
-- Structure de la table `znote_guild_wars`
--

CREATE TABLE `znote_guild_wars` (
  `id` int(11) NOT NULL,
  `limit` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `znote_images`
--

CREATE TABLE `znote_images` (
  `id` int(11) NOT NULL,
  `title` varchar(30) NOT NULL,
  `desc` text NOT NULL,
  `date` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `image` varchar(50) NOT NULL,
  `delhash` varchar(30) NOT NULL,
  `account_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `znote_news`
--

CREATE TABLE `znote_news` (
  `id` int(11) NOT NULL,
  `title` varchar(30) NOT NULL,
  `text` text NOT NULL,
  `date` int(11) NOT NULL,
  `pid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `znote_paygol`
--

CREATE TABLE `znote_paygol` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `points` int(11) NOT NULL,
  `message_id` varchar(255) NOT NULL,
  `service_id` varchar(255) NOT NULL,
  `shortcode` varchar(255) NOT NULL,
  `keyword` varchar(255) NOT NULL,
  `message` varchar(255) NOT NULL,
  `sender` varchar(255) NOT NULL,
  `operator` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `currency` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `znote_paypal`
--

CREATE TABLE `znote_paypal` (
  `id` int(11) NOT NULL,
  `txn_id` varchar(30) NOT NULL,
  `email` varchar(255) NOT NULL,
  `accid` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `points` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `znote_players`
--

CREATE TABLE `znote_players` (
  `id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `created` int(11) NOT NULL,
  `hide_char` tinyint(4) NOT NULL,
  `comment` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `znote_players`
--

INSERT INTO `znote_players` (`id`, `player_id`, `created`, `hide_char`, `comment`) VALUES
(1, 1, 1621202400, 0, ''),
(2, 2, 1621202400, 0, ''),
(3, 3, 1621202400, 0, ''),
(4, 4, 1621202400, 0, ''),
(5, 5, 1621202400, 0, ''),
(6, 6, 1621202400, 0, '');

-- --------------------------------------------------------

--
-- Structure de la table `znote_player_reports`
--

CREATE TABLE `znote_player_reports` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `posx` int(11) NOT NULL,
  `posy` int(11) NOT NULL,
  `posz` int(11) NOT NULL,
  `report_description` varchar(255) NOT NULL,
  `date` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `znote_shop`
--

CREATE TABLE `znote_shop` (
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `itemid` int(11) DEFAULT NULL,
  `count` int(11) NOT NULL DEFAULT '1',
  `description` varchar(255) NOT NULL,
  `points` int(11) NOT NULL DEFAULT '10'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `znote_shop_logs`
--

CREATE TABLE `znote_shop_logs` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `itemid` int(11) NOT NULL,
  `count` int(11) NOT NULL,
  `points` int(11) NOT NULL,
  `time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `znote_shop_orders`
--

CREATE TABLE `znote_shop_orders` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `itemid` int(11) NOT NULL,
  `count` int(11) NOT NULL,
  `time` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `znote_tickets`
--

CREATE TABLE `znote_tickets` (
  `id` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `username` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `subject` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `message` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ip` bigint(20) NOT NULL,
  `creation` int(11) NOT NULL,
  `status` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `znote_tickets_replies`
--

CREATE TABLE `znote_tickets_replies` (
  `id` int(11) NOT NULL,
  `tid` int(11) NOT NULL,
  `username` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `message` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `created` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `znote_visitors`
--

CREATE TABLE `znote_visitors` (
  `id` int(11) NOT NULL,
  `ip` bigint(20) NOT NULL,
  `value` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `znote_visitors_details`
--

CREATE TABLE `znote_visitors_details` (
  `id` int(11) NOT NULL,
  `ip` bigint(20) NOT NULL,
  `time` int(11) NOT NULL,
  `type` tinyint(4) NOT NULL,
  `account_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `accounts_unique` (`name`);

--
-- Index pour la table `account_bans`
--
ALTER TABLE `account_bans`
  ADD PRIMARY KEY (`account_id`),
  ADD KEY `banned_by` (`banned_by`);

--
-- Index pour la table `account_ban_history`
--
ALTER TABLE `account_ban_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_id` (`account_id`),
  ADD KEY `banned_by` (`banned_by`);

--
-- Index pour la table `account_viplist`
--
ALTER TABLE `account_viplist`
  ADD UNIQUE KEY `account_viplist_unique` (`account_id`,`player_id`),
  ADD KEY `account_id` (`account_id`),
  ADD KEY `player_id` (`player_id`);

--
-- Index pour la table `boosted_creature`
--
ALTER TABLE `boosted_creature`
  ADD PRIMARY KEY (`date`);

--
-- Index pour la table `coins_transactions`
--
ALTER TABLE `coins_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_id` (`account_id`);

--
-- Index pour la table `daily_reward_history`
--
ALTER TABLE `daily_reward_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `player_id` (`player_id`);

--
-- Index pour la table `global_storage`
--
ALTER TABLE `global_storage`
  ADD UNIQUE KEY `global_storage_unique` (`key`);

--
-- Index pour la table `guilds`
--
ALTER TABLE `guilds`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `guilds_name_unique` (`name`),
  ADD UNIQUE KEY `guilds_owner_unique` (`ownerid`);

--
-- Index pour la table `guildwar_kills`
--
ALTER TABLE `guildwar_kills`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `guildwar_kills_unique` (`warid`),
  ADD KEY `warid` (`warid`);

--
-- Index pour la table `guild_invites`
--
ALTER TABLE `guild_invites`
  ADD PRIMARY KEY (`player_id`,`guild_id`),
  ADD KEY `guild_id` (`guild_id`);

--
-- Index pour la table `guild_membership`
--
ALTER TABLE `guild_membership`
  ADD PRIMARY KEY (`player_id`),
  ADD KEY `guild_id` (`guild_id`),
  ADD KEY `rank_id` (`rank_id`);

--
-- Index pour la table `guild_ranks`
--
ALTER TABLE `guild_ranks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `guild_id` (`guild_id`);

--
-- Index pour la table `guild_wars`
--
ALTER TABLE `guild_wars`
  ADD PRIMARY KEY (`id`),
  ADD KEY `guild1` (`guild1`),
  ADD KEY `guild2` (`guild2`);

--
-- Index pour la table `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `owner` (`owner`),
  ADD KEY `town_id` (`town_id`);

--
-- Index pour la table `house_lists`
--
ALTER TABLE `house_lists`
  ADD KEY `house_id` (`house_id`);

--
-- Index pour la table `ip_bans`
--
ALTER TABLE `ip_bans`
  ADD PRIMARY KEY (`ip`),
  ADD KEY `banned_by` (`banned_by`);

--
-- Index pour la table `market_history`
--
ALTER TABLE `market_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `player_id` (`player_id`,`sale`);

--
-- Index pour la table `market_offers`
--
ALTER TABLE `market_offers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale` (`sale`,`itemtype`),
  ADD KEY `created` (`created`),
  ADD KEY `player_id` (`player_id`);

--
-- Index pour la table `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `players_unique` (`name`),
  ADD KEY `account_id` (`account_id`),
  ADD KEY `vocation` (`vocation`);

--
-- Index pour la table `players_online`
--
ALTER TABLE `players_online`
  ADD PRIMARY KEY (`player_id`);

--
-- Index pour la table `player_deaths`
--
ALTER TABLE `player_deaths`
  ADD KEY `player_id` (`player_id`),
  ADD KEY `killed_by` (`killed_by`),
  ADD KEY `mostdamage_by` (`mostdamage_by`);

--
-- Index pour la table `player_depotitems`
--
ALTER TABLE `player_depotitems`
  ADD UNIQUE KEY `player_depotitems_unique` (`player_id`,`sid`);

--
-- Index pour la table `player_hirelings`
--
ALTER TABLE `player_hirelings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `player_id` (`player_id`);

--
-- Index pour la table `player_inboxitems`
--
ALTER TABLE `player_inboxitems`
  ADD UNIQUE KEY `player_inboxitems_unique` (`player_id`,`sid`);

--
-- Index pour la table `player_items`
--
ALTER TABLE `player_items`
  ADD KEY `player_id` (`player_id`),
  ADD KEY `sid` (`sid`);

--
-- Index pour la table `player_namelocks`
--
ALTER TABLE `player_namelocks`
  ADD UNIQUE KEY `player_namelocks_unique` (`player_id`),
  ADD KEY `namelocked_by` (`namelocked_by`);

--
-- Index pour la table `player_rewards`
--
ALTER TABLE `player_rewards`
  ADD UNIQUE KEY `player_rewards_unique` (`player_id`,`sid`);

--
-- Index pour la table `player_spells`
--
ALTER TABLE `player_spells`
  ADD KEY `player_id` (`player_id`);

--
-- Index pour la table `player_storage`
--
ALTER TABLE `player_storage`
  ADD PRIMARY KEY (`player_id`,`key`);

--
-- Index pour la table `prey_slots`
--
ALTER TABLE `prey_slots`
  ADD KEY `player_id` (`player_id`);

--
-- Index pour la table `server_config`
--
ALTER TABLE `server_config`
  ADD PRIMARY KEY (`config`);

--
-- Index pour la table `store_history`
--
ALTER TABLE `store_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_id` (`account_id`);

--
-- Index pour la table `tile_store`
--
ALTER TABLE `tile_store`
  ADD KEY `house_id` (`house_id`);

--
-- Index pour la table `znote`
--
ALTER TABLE `znote`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `znote_accounts`
--
ALTER TABLE `znote_accounts`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `znote_auction_player`
--
ALTER TABLE `znote_auction_player`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `znote_changelog`
--
ALTER TABLE `znote_changelog`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `znote_deleted_characters`
--
ALTER TABLE `znote_deleted_characters`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `znote_forum`
--
ALTER TABLE `znote_forum`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `znote_forum_posts`
--
ALTER TABLE `znote_forum_posts`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `znote_forum_threads`
--
ALTER TABLE `znote_forum_threads`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `znote_global_storage`
--
ALTER TABLE `znote_global_storage`
  ADD UNIQUE KEY `key` (`key`);

--
-- Index pour la table `znote_guild_wars`
--
ALTER TABLE `znote_guild_wars`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `znote_images`
--
ALTER TABLE `znote_images`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `znote_news`
--
ALTER TABLE `znote_news`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `znote_paygol`
--
ALTER TABLE `znote_paygol`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `znote_paypal`
--
ALTER TABLE `znote_paypal`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `znote_players`
--
ALTER TABLE `znote_players`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `znote_player_reports`
--
ALTER TABLE `znote_player_reports`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `znote_shop`
--
ALTER TABLE `znote_shop`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `znote_shop_logs`
--
ALTER TABLE `znote_shop_logs`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `znote_shop_orders`
--
ALTER TABLE `znote_shop_orders`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `znote_tickets`
--
ALTER TABLE `znote_tickets`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `znote_tickets_replies`
--
ALTER TABLE `znote_tickets_replies`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `znote_visitors`
--
ALTER TABLE `znote_visitors`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `znote_visitors_details`
--
ALTER TABLE `znote_visitors_details`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `account_ban_history`
--
ALTER TABLE `account_ban_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `coins_transactions`
--
ALTER TABLE `coins_transactions`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `daily_reward_history`
--
ALTER TABLE `daily_reward_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `guilds`
--
ALTER TABLE `guilds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `guildwar_kills`
--
ALTER TABLE `guildwar_kills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `guild_ranks`
--
ALTER TABLE `guild_ranks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `guild_wars`
--
ALTER TABLE `guild_wars`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `houses`
--
ALTER TABLE `houses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4303;

--
-- AUTO_INCREMENT pour la table `market_history`
--
ALTER TABLE `market_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `market_offers`
--
ALTER TABLE `market_offers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `players`
--
ALTER TABLE `players`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `player_hirelings`
--
ALTER TABLE `player_hirelings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `store_history`
--
ALTER TABLE `store_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `znote`
--
ALTER TABLE `znote`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `znote_accounts`
--
ALTER TABLE `znote_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `znote_auction_player`
--
ALTER TABLE `znote_auction_player`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `znote_changelog`
--
ALTER TABLE `znote_changelog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `znote_deleted_characters`
--
ALTER TABLE `znote_deleted_characters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `znote_forum`
--
ALTER TABLE `znote_forum`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `znote_forum_posts`
--
ALTER TABLE `znote_forum_posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `znote_forum_threads`
--
ALTER TABLE `znote_forum_threads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `znote_guild_wars`
--
ALTER TABLE `znote_guild_wars`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `znote_images`
--
ALTER TABLE `znote_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `znote_news`
--
ALTER TABLE `znote_news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `znote_paygol`
--
ALTER TABLE `znote_paygol`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `znote_paypal`
--
ALTER TABLE `znote_paypal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `znote_players`
--
ALTER TABLE `znote_players`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `znote_player_reports`
--
ALTER TABLE `znote_player_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `znote_shop`
--
ALTER TABLE `znote_shop`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `znote_shop_logs`
--
ALTER TABLE `znote_shop_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `znote_shop_orders`
--
ALTER TABLE `znote_shop_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `znote_tickets`
--
ALTER TABLE `znote_tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `znote_tickets_replies`
--
ALTER TABLE `znote_tickets_replies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `znote_visitors`
--
ALTER TABLE `znote_visitors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `znote_visitors_details`
--
ALTER TABLE `znote_visitors_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `account_bans`
--
ALTER TABLE `account_bans`
  ADD CONSTRAINT `account_bans_account_fk` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `account_bans_player_fk` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `account_ban_history`
--
ALTER TABLE `account_ban_history`
  ADD CONSTRAINT `account_bans_history_account_fk` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `account_bans_history_player_fk` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `account_viplist`
--
ALTER TABLE `account_viplist`
  ADD CONSTRAINT `account_viplist_account_fk` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `account_viplist_player_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `coins_transactions`
--
ALTER TABLE `coins_transactions`
  ADD CONSTRAINT `coins_transactions_account_fk` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `daily_reward_history`
--
ALTER TABLE `daily_reward_history`
  ADD CONSTRAINT `daily_reward_history_player_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `guilds`
--
ALTER TABLE `guilds`
  ADD CONSTRAINT `guilds_ownerid_fk` FOREIGN KEY (`ownerid`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `guildwar_kills`
--
ALTER TABLE `guildwar_kills`
  ADD CONSTRAINT `guildwar_kills_warid_fk` FOREIGN KEY (`warid`) REFERENCES `guild_wars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `guild_invites`
--
ALTER TABLE `guild_invites`
  ADD CONSTRAINT `guild_invites_guild_fk` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `guild_invites_player_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `guild_membership`
--
ALTER TABLE `guild_membership`
  ADD CONSTRAINT `guild_membership_guild_fk` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `guild_membership_player_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `guild_membership_rank_fk` FOREIGN KEY (`rank_id`) REFERENCES `guild_ranks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `guild_ranks`
--
ALTER TABLE `guild_ranks`
  ADD CONSTRAINT `guild_ranks_fk` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `house_lists`
--
ALTER TABLE `house_lists`
  ADD CONSTRAINT `houses_list_house_fk` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `ip_bans`
--
ALTER TABLE `ip_bans`
  ADD CONSTRAINT `ip_bans_players_fk` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `market_history`
--
ALTER TABLE `market_history`
  ADD CONSTRAINT `market_history_players_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `market_offers`
--
ALTER TABLE `market_offers`
  ADD CONSTRAINT `market_offers_players_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `players`
--
ALTER TABLE `players`
  ADD CONSTRAINT `players_account_fk` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `player_deaths`
--
ALTER TABLE `player_deaths`
  ADD CONSTRAINT `player_deaths_players_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `player_depotitems`
--
ALTER TABLE `player_depotitems`
  ADD CONSTRAINT `player_depotitems_players_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `player_hirelings`
--
ALTER TABLE `player_hirelings`
  ADD CONSTRAINT `player_hirelings_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `player_inboxitems`
--
ALTER TABLE `player_inboxitems`
  ADD CONSTRAINT `player_inboxitems_players_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `player_items`
--
ALTER TABLE `player_items`
  ADD CONSTRAINT `player_items_players_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `player_namelocks`
--
ALTER TABLE `player_namelocks`
  ADD CONSTRAINT `player_namelocks_players2_fk` FOREIGN KEY (`namelocked_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `player_namelocks_players_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `player_rewards`
--
ALTER TABLE `player_rewards`
  ADD CONSTRAINT `player_rewards_players_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `player_spells`
--
ALTER TABLE `player_spells`
  ADD CONSTRAINT `player_spells_players_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `player_storage`
--
ALTER TABLE `player_storage`
  ADD CONSTRAINT `player_storage_players_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `prey_slots`
--
ALTER TABLE `prey_slots`
  ADD CONSTRAINT `prey_slots_players_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `store_history`
--
ALTER TABLE `store_history`
  ADD CONSTRAINT `store_history_account_fk` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `tile_store`
--
ALTER TABLE `tile_store`
  ADD CONSTRAINT `tile_store_account_fk` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
