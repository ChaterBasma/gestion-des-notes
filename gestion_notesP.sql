-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : jeu. 22 mai 2025 à 16:33
-- Version du serveur : 10.4.21-MariaDB
-- Version de PHP : 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `gestion_notesP`
--

-- --------------------------------------------------------

--
-- Structure de la table `Admine`
--

CREATE TABLE `Admine` (
  `id_Admin` int(11) NOT NULL,
  `nom` varchar(100) DEFAULT NULL,
  `prenom` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `mot_de_passe` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `Admine`
--

INSERT INTO `Admine` (`id_Admin`, `nom`, `prenom`, `email`, `mot_de_passe`) VALUES
(1, 'El Idrissi', 'Karim', 'karim.elidrissi@example.com', 'admin2024'),
(2, 'Zahraoui', 'Imane', 'imane.zahraoui@example.com', 'superadmin'),
(3, 'Bennis', 'Hicham', 'hicham.bennis@example.com', 'azerty123');

-- --------------------------------------------------------

--
-- Structure de la table `Filiere`
--

CREATE TABLE `Filiere` (
  `id_Filiere` int(11) NOT NULL,
  `nom_filiere` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `Filiere`
--

INSERT INTO `Filiere` (`id_Filiere`, `nom_filiere`) VALUES
(2, 'Developement Digital-Tronc Commun (1A)'),
(3, 'Technicien Spécialisé en Gestion des Entreprises (1A)'),
(4, 'Developpement Digital - Option Web Full Stack'),
(5, 'Gestion des Entreprises-Option Commerce');

-- --------------------------------------------------------

--
-- Structure de la table `Formateur`
--

CREATE TABLE `Formateur` (
  `id_formateur` int(11) NOT NULL,
  `nom` varchar(100) DEFAULT NULL,
  `prenom` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `mot_de_passe` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `Formateur`
--

INSERT INTO `Formateur` (`id_formateur`, `nom`, `prenom`, `email`, `mot_de_passe`) VALUES
(1, 'Benhima', 'Said', 'said.benhima@example.com', 'motdepasse123'),
(2, 'Khadiri', 'Salma', 'salma.khadiri@example.com', 'azerty@2024'),
(3, 'Draoui', 'Omar', 'omar.draoui@example.com', 'welcome123');

-- --------------------------------------------------------

--
-- Structure de la table `formateur_groupe`
--

CREATE TABLE `formateur_groupe` (
  `id_formateur` int(11) NOT NULL,
  `id_groupe` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `formateur_groupe`
--

INSERT INTO `formateur_groupe` (`id_formateur`, `id_groupe`) VALUES
(1, 5),
(1, 8),
(1, 9),
(2, 2),
(2, 3),
(3, 4),
(3, 6),
(3, 7);

-- --------------------------------------------------------

--
-- Structure de la table `Groupe`
--

CREATE TABLE `Groupe` (
  `id_Groupe` int(11) NOT NULL,
  `nom_Groupe` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `Groupe`
--

INSERT INTO `Groupe` (`id_Groupe`, `nom_Groupe`) VALUES
(2, 'DEV101'),
(3, 'DEV102'),
(4, 'GE101'),
(5, 'WEBFS201'),
(6, 'GEC201'),
(7, 'GEC207'),
(8, 'DEV103'),
(9, 'WEBFS202');

-- --------------------------------------------------------

--
-- Structure de la table `Module`
--

CREATE TABLE `Module` (
  `id_module` int(11) NOT NULL,
  `nom_module` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `Module`
--

INSERT INTO `Module` (`id_module`, `nom_module`) VALUES
(101, 'Métier et formation en développement digital'),
(102, 'Les bases de l\'algorithmique'),
(103, 'Programmation Orienté Objet'),
(104, 'Sites Web statiques'),
(105, 'Programmation Javascript'),
(1022, 'Francais'),
(1033, 'Anglais technique'),
(1088, 'Entrepreneuriat-PIE 1');

-- --------------------------------------------------------

--
-- Structure de la table `Module_Filiere_Formateur`
--

CREATE TABLE `Module_Filiere_Formateur` (
  `id` int(11) NOT NULL,
  `id_module` int(11) DEFAULT NULL,
  `id_formateur` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `Module_Filiere_Formateur`
--

INSERT INTO `Module_Filiere_Formateur` (`id`, `id_module`, `id_formateur`) VALUES
(1, 1033, 3),
(2, 105, 1),
(3, 102, 2);

-- --------------------------------------------------------

--
-- Structure de la table `Note`
--

CREATE TABLE `Note` (
  `id_note` int(11) NOT NULL,
  `id_stagiaire` bigint(110) UNSIGNED DEFAULT NULL,
  `id_module` int(11) DEFAULT NULL,
  `id_formateur` int(11) DEFAULT NULL,
  `note1` decimal(5,2) DEFAULT NULL,
  `note2` decimal(5,2) DEFAULT NULL,
  `note3` decimal(5,2) DEFAULT NULL,
  `EFM` decimal(5,2) DEFAULT NULL,
  `Moyenne` decimal(5,2) DEFAULT NULL,
  `date_creation` datetime DEFAULT current_timestamp(),
  `date_modification` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `Note`
--

INSERT INTO `Note` (`id_note`, `id_stagiaire`, `id_module`, `id_formateur`, `note1`, `note2`, `note3`, `EFM`, `Moyenne`, `date_creation`, `date_modification`) VALUES
(272, 2003112600530, 105, 1, '15.00', '12.00', '12.00', '12.00', '12.50', '2025-05-20 09:19:10', '2025-05-22 15:00:38'),
(273, 2004020100570, 105, 1, '15.00', '12.00', '11.00', '18.00', '15.33', '2025-05-20 09:19:49', '2025-05-20 09:19:49'),
(274, 2005080600309, 105, 1, '16.00', '16.00', '11.00', '13.00', '13.67', '2025-05-20 09:25:05', '2025-05-20 09:25:05'),
(275, 1985042200013, 102, 2, '16.00', '17.00', '19.00', '11.00', '14.17', '2025-05-20 11:41:42', '2025-05-20 11:41:42'),
(276, 199610100307, 1033, 3, '12.00', '16.00', '17.00', '18.00', '16.50', '2025-05-20 20:12:00', '2025-05-20 20:12:00'),
(277, 199302030471, 1033, 3, '14.00', '12.00', '18.00', '12.00', '13.33', '2025-05-20 20:17:34', '2025-05-20 20:17:34'),
(278, 1998082000597, 102, 2, '12.00', '15.00', '11.00', '14.00', '13.33', '2025-05-20 20:20:55', '2025-05-20 20:20:55'),
(279, 2004061400375, 102, 2, '12.00', '15.00', '11.00', '14.00', '13.33', '2025-05-20 20:21:22', '2025-05-20 20:21:22'),
(282, 1999042500409, 105, 2, '19.00', '15.00', '12.00', '20.00', '17.67', '2025-05-20 20:26:12', '2025-05-20 20:26:12'),
(283, 2005052700268, 105, 1, '17.00', '14.00', '19.00', '12.00', '14.33', '2025-05-22 14:46:13', '2025-05-22 14:46:13'),
(284, 2004120400389, 105, 1, '13.00', '13.00', '13.00', '16.00', '14.50', '2025-05-22 14:47:59', '2025-05-22 14:50:13'),
(285, 2005050900238, 105, 1, '10.00', '15.00', '20.00', '16.00', '15.50', '2025-05-22 15:01:13', '2025-05-22 15:01:13');

-- --------------------------------------------------------

--
-- Structure de la table `Stagiaire`
--

CREATE TABLE `Stagiaire` (
  `id_stagiaire` bigint(110) UNSIGNED NOT NULL,
  `nom` varchar(100) DEFAULT NULL,
  `prenom` varchar(100) DEFAULT NULL,
  `genre` enum('F','H') DEFAULT NULL,
  `date_naissance` date DEFAULT NULL,
  `annee_etude` enum('1ere','2eme','3eme') DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `id_Filiere` int(11) DEFAULT NULL,
  `id_Groupe` int(11) DEFAULT NULL,
  `mot_de_passe` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `Stagiaire`
--

INSERT INTO `Stagiaire` (`id_stagiaire`, `nom`, `prenom`, `genre`, `date_naissance`, `annee_etude`, `email`, `id_Filiere`, `id_Groupe`, `mot_de_passe`) VALUES
(199009210072, 'ALAOUI', 'HAJAR', 'F', '2002-07-14', '2eme', 'raniagabbassi@gmail.com', 5, 6, '127455fc7624422bb1f27886363c2de224f6e341e49e70a9e616613202f4afaa'),
(199106180095, 'SALMI', 'REDOUANE', 'H', '2005-06-18', '2eme', 'redouanesalmi@gmail.com', 3, 4, 'a9b6e395f7ba04c4c01a719e3fff637e9493edb82139a3a0bcd86d447771a95e'),
(199302030471, 'RAJI', 'CHADIA', 'F', '2004-02-03', '2eme', 'radiael alaoui@gmail.com', 5, 6, 'e61b038b99d48aaed906b09f91cc08e9648de2e4727d4058d44e47ff0e77ac75'),
(199306040194, 'BOUHADI', 'AICHA', 'F', '2004-06-04', '1ere', 'aichabouhadi@gmail.com', 2, 2, '0c839a17c19647bcb1eda103d470a48bbf625222065b93af49fc9debe510a9b0'),
(199306210411, 'ZAHDI', 'SOUKAINA', 'F', '2004-06-21', '1ere', 'soukainazahdi@gmail.com', 2, 2, 'a7dac7c198ef00ff1d9339d4c71cee00275361c97f85b47fc414d901d03f9791'),
(199409090273, 'NAJI', 'HAJAR', 'F', '2002-09-09', '1ere', 'hajarnaji@gmail.com', 2, 2, '28d578116f19b7f1138ffbb0e884c7973e512c8b10038440ace67ca9e76d31e1'),
(199508140415, 'EL HADEF', 'NAJIA', 'F', '2004-08-14', '2eme', 'najiael hadef@gmail.com', 3, 4, 'a09d616f8367e11ba8cff4dc818b1e575fb6e0e4f67b36da6925fcf97b48861d'),
(199510010159, 'FATMI', 'NAJIA', 'F', '2004-10-01', '1ere', 'najiafatmi@gmail.com', 2, 2, 'cb98f3c941ba48719a6eaefb3eff884c0cdc788738a67f832689d2ac3cda1c64'),
(199610100307, 'TAKI', 'NADIA', 'F', '2005-05-08', '2eme', 'lailaes-salemy@gmail.com', 5, 6, 'c643bb2d72a2c814cfe95cbfb87fa9aad573e3bdba720fc0dd84aab6d465efe5'),
(199701016726, 'OUAKRACH', 'SAID', 'F', '2005-01-01', '1ere', 'saidouakrach@gmail.com', 2, 2, 'c337f1af86d3ba645fbacc23c7ab6cc03f989f2ff8e22abc6dede7ffa8ec761d'),
(199712160201, 'MOUSSAOUI-ZERHOUNI', 'SALIMA', 'F', '2005-12-16', '1ere', 'salimamoussaoui-zerhouni@gmail.com', 2, 3, 'd531ec4ab3bb4904afd38a83c6d31972dc41af4d0e9d18f28fc5d770b5ec0af2'),
(1971042300004, 'SABRI', 'MOHAMED', 'H', '2001-07-12', '1ere', 'mohamedsabri@gmail.com', 2, 2, '4c9f19b82be68288fa5d65c7a16964787ff2dfc5db071e3a40e7912b5be3aea6'),
(1979012400008, 'RAZI', 'GHIZLANE', 'F', '2002-07-14', '1ere', 'ghizlanerazi@gmail.com', 2, 2, '7b0e38c653b8afab97256e241df65d8c0e511cee2802f4f74e6d96b82b3ea29c'),
(1981090500006, 'DAFIR', 'FARID', 'H', '2001-07-12', '2eme', 'salmadariane@gmail.com', 5, 6, '97421cd89de9c8c0049e7d454901a55266d55294ca1ae149275113b765025edd'),
(1985042200013, 'RIZKI', 'NADIA', 'F', '2004-08-20', '1ere', 'nadiarizki@gmail.com', 2, 2, 'f7ef77d7704aafbd32594e57f22394a547e42982be16c0aadfc4cde10eab577a'),
(1986030600018, 'SAADI', 'AMAL', 'F', '2004-10-28', '1ere', 'amalsaadi@gmail.com', 2, 2, '22e863cb556d7e5d0f057cdebf78a1c05dd417a85757cd9a8b6837e5f396cd3e'),
(1988033000013, 'CHADLI', 'NIZAR', 'H', '2003-03-30', '1ere', 'nizarchadli@gmail.com', 2, 2, '2680deea3ddf894c1c543627170849e4a4f93657a594f2ae154f6889471cfe90'),
(1994071400084, 'ERRAOUI', 'FARIDA', 'F', '2002-07-14', '2eme', 'faridaerraoui@gmail.com', 3, 4, '3051c2bf85443f7cdcedc0e6cfad5dadf93c33ca83cc996195f859ceed54f5e9'),
(1996112800104, 'FOUHAMI', 'SARA', 'F', '2004-11-28', '2eme', 'ayahallaoui@gmail.com', 5, 6, '8fdb13f772081985b8281c4b4725c012efbc4936c2e6ff6521054ace459144a0'),
(1996122300195, 'NAIM', 'REDA', 'H', '2005-04-25', '2eme', 'tourianajih@gmail.com', 5, 7, '7742bdd8e0fc559d9391cb25bfcdfa431cdba9fc3cfd320e19275fdae6e7066b'),
(1997052300346, 'ABBASSI', 'HAJAR', 'F', '2005-05-23', '1ere', 'hajarabbassi@gmail.com', 2, 3, '591bd459cd18b5e55154d0009879b00e82bcfd87463fd4e84478cf2783c884d7'),
(1998082000597, 'DAIF', 'MUSTAPHA', 'H', '2004-08-20', '1ere', 'mustaphadaif@gmail.com', 2, 3, '58c28eecdee2a665868051257161742dd0f4579ea3273fa028e6666c68b0437e'),
(1998102800134, 'MOUKRIM', 'WISSAL', 'F', '2004-10-28', '1ere', 'wissalmoukrim@gmail.com', 2, 3, '51e98caf4c47125aab6a8318954a27b6525a252ee9d6698957a57993e3793c6b'),
(1998121400271, 'NACHITE', 'MEHDI', 'H', '2004-12-14', '1ere', 'mehdinachite@gmail.com', 2, 3, 'd83970ba8240f172e23afe2ac67de7c4a0908623e1ab1e3362730a3bb71bb4d4'),
(1999012400442, 'HILALI', 'IBTISSAM', 'F', '2005-01-24', '2eme', 'ibtissamhilali@gmail.com', 4, 5, '73b1224228461887845354c483e5e0f4c6c2130e6a9d909cc47fdb9918f7b1df'),
(1999020100749, 'SAYLANI', 'MERYEM', 'F', '2005-02-01', '2eme', 'meryemsaylani@gmail.com', 3, 4, '6dc004a94e5960df70d2a450679fbff45bb8b1db5f9be277cbb9fd75eec06f3f'),
(1999042500409, 'HARIRI', 'NORA', 'F', '2005-04-25', '1ere', 'norahariri@gmail.com', 2, 3, '0fa500927b7ed7dc89c3ece4a28085b83cb4155a9d87f0ca5b53cd4356fb7375'),
(1999050800389, 'CHETOUANI', 'HOSSAM', 'H', '2005-05-08', '1ere', 'hossamchetouani@gmail.com', 2, 3, '2263c64d9873449eff175edabda01a0ababa7678b57557c4dbdf5e7a3fbff6b0'),
(1999092600316, 'TILIOUINE', 'NOUHAILA', 'F', '2005-09-26', '1ere', 'nouhailatiliouine@gmail.com', 2, 3, 'f2488765b30e9e883fca434d52f8f4152239b7c098c1b47aef0a8ab5434b5a0c'),
(1999110500332, 'OUACHEN', 'ABDELHADI', 'F', '2005-11-05', '2eme', 'abdelhadiouachen@gmail.com', 3, 4, '752bb39b2a895c2792db39658f761055528591c778f9cb192d5ba392db4bd942'),
(2000031500444, 'ADLAOUI', 'MOURAD', 'F', '2000-03-15', '2eme', 'mouradadlaoui@gmail.com', 3, 4, '05db8b1374adb2f49f71fede5af27b7654ff8cd012f02aee944aea4d2f4ea7d1'),
(2000061200499, 'LOUAFY', 'MOHAMMED', 'H', '2000-06-12', '2eme', 'mohammedlouafy@gmail.com', 4, 9, '09f1936efcb6fdbffa7ba380ad4f4b4283e12ca62d559f864f6edc333c795de3'),
(2001010800207, 'ELBOUKHARI', 'KHALID', 'H', '2001-01-08', '2eme', 'khalidelboukhari@gmail.com', 3, 4, 'b7c668bd3bdbe0a43f519209c002a95125394df95e3df5b8f203b63628b7d9e8'),
(2001071200082, 'BENFSSAHI', 'NOUR-EDDINE', 'H', '2001-07-12', '1ere', 'nour-eddinebenfssahi@gmail.com', 2, 3, '4708ebbeaece91127fa4c9e6aae8786dc422b7b8eebde310599d32837e36878d'),
(2002011300422, 'CHAABANE', 'BOUTAINA', 'F', '2002-01-13', '2eme', 'boutainachaabane@gmail.com', 4, 5, '5cbf577b47d99a5e69f0e58d63b368f4209761749c4f099e6f5f862d7ec61130'),
(2002053100394, 'HNIBEL', 'RACHID', 'H', '2002-05-31', '1ere', 'rachidhnibel@gmail.com', 2, 3, '9b67fc0562c5e0a4e8853dfc5ff181bb4912d43bbaa85b2df681359fa4dfdf5a'),
(2002071400405, 'RHAZZI', 'SALMA', 'F', '2002-07-14', '1ere', 'salmarhazzi@gmail.com', 2, 3, '99a97c0a5c3b3ff7912a125a3f582e51e1576570e03dd27b00a6785ea435a068'),
(2002080900441, 'SABIRY', 'SOULTANE', 'H', '2002-08-09', '1ere', 'soultanesabiry@gmail.com', 2, 8, '6eec2c4012db42312a9e45e13bbd67c41edae2a317a33a7d0224912cdd5e12fa'),
(2003041000439, 'AMADAH', 'HIBA TALLAH', 'F', '2003-04-10', '2eme', 'hiba tallahamadah@gmail.com', 4, 5, 'f910fa788dfa4b045a5fd031a0cfbfe87537fe9d6a14a1ac5c219987c4573edf'),
(2003050900352, 'FATTAHI', 'ZAID', 'H', '2003-05-09', '2eme', 'zaidfattahi@gmail.com', 4, 9, '9e5d395bb2cb8a14863ece4efe949914bfd94f44278f48bcce4960765bad1640'),
(2003051000337, 'MANSOURI', 'FADWA', 'F', '2003-05-10', '2eme', 'fadwamansouri@gmail.com', 4, 5, 'ca5fc6bc1bb74c89ca252d7334dd7375167711ee61c3e7243085fb5ff7337c2b'),
(2003100500053, 'NAANAA', 'EL ALIA', 'F', '2003-10-05', '2eme', 'el alianaanaa@gmail.com', 4, 5, '6310757a1e71b55bc19a77bde2816fee958042890de8a74f169f832586395f72'),
(2003112600530, 'TAIKI', 'NOUHAILA', 'F', '2003-11-26', '1ere', 'nouhailataiki@gmail.com', 2, 8, '434259046de157a1c84d2fbef7f8113891c9eab6c3699025f7e89b7fb3070e85'),
(2003121400337, 'EL BILALI', 'HAMID', 'H', '2003-12-14', '1ere', 'hamidel bilali@gmail.com', 2, 3, '145cfeeddecdb7ca7fb3beef5ae8a9bdc8472ccabf4e43d6e5303563cf30f9d1'),
(2003121900387, 'KARIM', 'SALMA', 'F', '2003-12-19', '1ere', 'salmakarim@gmail.com', 2, 8, '359898e7d122c27da05166042f1b062e8b48c616aec66d0bddd17fef8730b917'),
(2003122000363, 'RIDAOUI', 'ZHOUR', 'F', '2003-12-20', '1ere', 'zhourridaoui@gmail.com', 2, 8, '321c171ece4cf03ef5a97f27b9cf6f87ce34c2719aa161a935653d27ab53a2c2'),
(2004010200489, 'YAHYAOUI', 'HAFSSA', 'F', '2004-01-02', '2eme', 'hafssayahyaoui@gmail.com', 4, 5, '95d6c224328b7cc8455af71d700976e71e69dcb20044bf38970b9f48102f84ac'),
(2004010200598, 'KARIMI', 'SAIDA', 'F', '2004-01-02', '1ere', 'saidakarimi@gmail.com', 2, 3, 'faeb33c36423d7cbb3e80baef053d8aaca7803997e99848609493342fdfe3719'),
(2004020100570, 'SNINA', 'AMIRA', 'F', '2004-02-01', '1ere', 'amirasnina@gmail.com', 2, 8, '0f41e11cfe9a247ac3ec102fccafdda53d01a098f134248383925a5f0600658c'),
(2004020900412, 'BALHA', 'SOUHAIL', 'H', '2004-02-09', '1ere', 'souhailbalha@gmail.com', 2, 3, '0d8967414bd4cb4e3791a03b07b73cfa4118b2654ba7a32ed9e83bd3c74f9689'),
(2004041600110, 'AADDAL', 'ILYASS', 'H', '2004-04-16', '2eme', 'ilyassaaddal@gmail.com', 4, 9, '9f2da647c685fa9657e7d2680d8518e0bd3f76fbc517c5e29974b93d0d935a83'),
(2004052000290, 'MELLOUK', 'OUMAIMA', 'F', '2004-05-20', '2eme', 'oumaimamellouk@gmail.com', 4, 9, 'fc8a841ce02771893ea439a2b7cbe5410d6c7c7b4c6eb82185044793a2369e72'),
(2004052300256, 'LAANYA', 'SALMA', 'F', '2004-05-23', '2eme', 'salmalaanya@gmail.com', 4, 5, '78998e10661c8fbb87ea1d3b2b1bc32416ddd5a0549757608b383d1ddeea070f'),
(2004060300205, 'KHEBBAB', 'AYA', 'F', '2004-06-03', '1ere', 'ayakhebbab@gmail.com', 2, 8, '666e9a23607d10c9161423d7d022f52cef7e6406c3d6cbf87634eb3f2026270a'),
(2004060800108, 'DYANI', 'MOHAMMED AMINE', 'H', '2004-06-08', '2eme', 'mohammed aminedyani@gmail.com', 4, 9, '301939f95c06f6dc350e1abc320e02fd0353931f76c9cfb4cc44af97b61efda8'),
(2004061400375, 'AHADAR', 'MERIEM', 'F', '2004-06-14', '1ere', 'meriemahadar@gmail.com', 2, 3, 'db79f9b8edf2f2c591c2230fd394b7be6e35e12e1fa576be10772d7fd33e454f'),
(2004061500454, 'NAITOUAHMAN', 'EYA', 'F', '2004-06-15', '1ere', 'eyanaitouahman@gmail.com', 2, 3, '89cb0b89751de197b22c832382bd9623c1f20c9658293aea615aa15edbcb3ba2'),
(2004081000497, 'KAAB', 'ASMAA', 'F', '2004-08-10', '1ere', 'asmaakaab@gmail.com', 2, 3, '7ce3c66a7fdbd544e3910d20a3d44bdf34ef77f9d9dd0353175d7c43ce3757bc'),
(2004083000439, 'AIT SALAH', 'NADYA', 'F', '2004-08-30', '1ere', 'nadyaait salah@gmail.com', 2, 8, 'f390b9d5475a9a9994c87e35bb6ea9687205006da9dcf55be25f86deceaf7307'),
(2004092100216, 'ELHAMDANI', 'SOUKAINA', 'F', '2004-09-21', '2eme', 'soukainaelhamdani@gmail.com', 4, 5, '4d2fa1f66eb5adbab873da1c71bc5d4d4b70600ab3f5a6b684b8e2a18c3d92f0'),
(2004110100263, 'IKLANE', 'SALMA', 'F', '2004-11-01', '2eme', 'salmaiklane@gmail.com', 4, 9, '847a0df322c5a0ff95f14deec39e6b9ef454f03f1d0b2f5cdbeb54d53c1ffc46'),
(2004110700102, 'ELBADAOUY', 'LAILA', 'F', '2004-11-07', '2eme', 'lailaelbadaouy@gmail.com', 4, 9, '5859c3e156e6fe25ffc1b305d641ff3f80bbf686788e46664fdca38037f5f6c5'),
(2004120400389, 'AFFANE', 'FATIMA-EZZAHRAA', 'F', '2004-12-04', '1ere', 'fatima-ezzahraaaffane@gmail.com', 2, 8, 'a6c0b376dcb8ba47d4873b416539db154eaee82053cf787927eb1d268159cc53'),
(2004121000395, 'OUARID', 'MOUNDIR', 'H', '2004-12-10', '1ere', 'moundirouarid@gmail.com', 2, 8, '9793bf5d8d2352dbf6e9ff57a09866e111dea747b4441c704ec904b9df2a8b40'),
(2005012600448, 'SAADAOUI', 'NAOUFAL', 'H', '2005-01-26', '1ere', 'naoufalsaadaoui@gmail.com', 2, 3, 'b4e0b18cb877cf8f859b73871b7bd608e18105ea69ca6d441e449038eae72a73'),
(2005021100160, 'DYBES', 'ILYAS', 'H', '2005-02-11', '2eme', 'ilyasdybes@gmail.com', 4, 9, '4d2d5a7a5fb07bad21934895a1ff59289bb38515c50bfaa8329861219fa1093b'),
(2005031200262, 'HERZALLA', 'AMIRA', 'F', '2005-03-12', '2eme', 'amiraherzalla@gmail.com', 4, 9, '29dc1740743e5670d20f9986e686f974dc2e14ad6a31ff8deb5ecf711d3ee877'),
(2005032100230, 'ABOULAHMADA', 'IKRAM', 'F', '2005-03-21', '1ere', 'ikramaboulahmada@gmail.com', 2, 8, '8c37003120914b1a25199ad92a97a8d61ae747aaa0a5e8569cae322edbbad38c'),
(2005033000191, 'ZIBAR', 'NISSRINE', 'F', '2005-03-30', '2eme', 'nissrinezibar@gmail.com', 4, 5, 'e62a428756f20ff84a3fd6977aabf04d2cad8af45dd790b39f69f83643acfbd8'),
(2005040200144, 'ZIADI', 'HIBA', 'F', '2005-04-02', '2eme', 'hibaziadi@gmail.com', 4, 5, '027e6e0ff6d47db8513aa41cdfd478d05eb3fc9964ff635d6392323d89ea3dcf'),
(2005040900126, 'BELOUKID', 'RACHID', 'H', '2005-04-09', '1ere', 'rachidbeloukid@gmail.com', 2, 3, '73d4eabef4dc844fdaddb20f7b0a48d70128132d478656c82d2f2c616845e33f'),
(2005041700211, 'SEFFANY', 'AYMAN', 'H', '2005-04-17', '1ere', 'aymanseffany@gmail.com', 2, 8, 'a4dc3976dac94ba902eefdb99213460602896d4783f4f89b6dc06e0b7a4d70e5'),
(2005050100254, 'AIT MANSOUR', 'ADNANE', 'H', '2005-05-01', '2eme', 'adnaneait mansour@gmail.com', 4, 9, 'f376ff4fd25a454118096584d61f594aa792a65016ec0711011a830fe8fdc6dc'),
(2005050900158, 'SAOUDI', 'IKRAM', 'F', '2005-05-09', '2eme', 'ikramsaoudi@gmail.com', 4, 9, 'de9b4627f7a6540a8667199b7f4e8e4b38eafd2f30f4f87c660c07874a7af961'),
(2005050900238, 'MEHDI', 'GATIFI', 'H', '2005-05-09', '1ere', 'gatifimehdi@gmail.com', 2, 8, 'bd307a543b1efc7f2f5c8dbd1a92c01e368886bcc5c119d92562f452dedcf366'),
(2005051100211, 'CHOUBANE', 'MALAK', 'F', '2005-05-11', '2eme', 'malakchoubane@gmail.com', 4, 9, '711182ba21571d4303d6f10ea58bf39be624b495d702e7ec90fc5f22fe8a333b'),
(2005052700268, 'MOUNAN', 'DOUAA', 'F', '2005-05-27', '1ere', 'douaamounan@gmail.com', 2, 8, 'c1af2f41dd560239514680db8e11a4c6cd2d561d54518531d55223ef6744d511'),
(2005060600143, 'ELMALIH', 'IBTISSAM', 'F', '2005-06-06', '2eme', 'ibtissamelmalih@gmail.com', 4, 5, 'a6ef1e54a617150d9c2638071bdaefe1c45efd5f779820eba7664055b583776f'),
(2005062200211, 'HADDAOUI', 'MARWA', 'F', '2005-06-22', '2eme', 'marwahaddaoui@gmail.com', 4, 9, 'a9ad526d83c0d976dfa13d2bbd18ed68848a503399b53bfec2e32a9700db35ce'),
(2005062700152, 'HETTAT', 'AYA', 'F', '2005-06-27', '2eme', 'ayahettat@gmail.com', 4, 5, '0f9d80513111bd4fbc4d750961e16ddf9e53d084e36efa0fe0c8e33ba8efe2d3'),
(2005070100194, 'JAADA', 'AYA', 'F', '2005-07-01', '2eme', 'ayajaada@gmail.com', 4, 9, '3e9cbc6adf8d23d0969dca0bd3348c2b59073b92aef717aa8ed97299ab941a87'),
(2005070700194, 'TARIQ', 'MARYAM', 'F', '2005-07-07', '2eme', 'maryamtariq@gmail.com', 4, 5, '14272fa1a9e6c048c2af37d12f483c84c2e48894617dd1cb571da52eaf26029b'),
(2005072800149, 'BENAICHOUR', 'DOUAA', 'F', '2005-07-28', '2eme', 'douaabenaichour@gmail.com', 4, 5, '13ab84b98161bb1e16fd717b3fd3f4d3b96401b9605f505cb2922572635b2a71'),
(2005073100097, 'BANHAR', 'HIBA', 'F', '2005-07-31', '2eme', 'hibabanhar@gmail.com', 4, 9, 'be86b418cd579ef9da13cac90e3b22b567b2f19337265716c2b61aa788d2c77e'),
(2005080600309, 'ASLAOUI', 'NADIA', 'F', '2005-08-06', '1ere', 'nadiaaslaoui@gmail.com', 2, 8, 'c12af2aed70840937184795d9ad89fdadc59700c70bb8bdb033edb6cea1aab7f'),
(2005091600209, 'LAGHLALI', 'NOUHAILA', 'F', '2005-09-16', '2eme', 'nouhailalaghlali@gmail.com', 4, 5, '2953d5412a566468a9513737dbd97afb4cda7a9da0c88bab9761732d351d318c'),
(2005092500138, 'EL HASNAOUI', 'RIHAB', 'F', '2005-09-25', '2eme', 'rihabel hasnaoui@gmail.com', 4, 5, 'e9f8e68a1649f66d06bd50a25028e2b08e020d5631ddde5a7659db990abf9393'),
(2005092500259, 'HADDI', 'EL MEHDI', 'H', '2005-09-25', '1ere', 'el mehdihaddi@gmail.com', 2, 8, '9ea158edf1af0092cc3a4bda2380e6b024f0b00031ad1510b9038ebd4eaeb029'),
(2005101200151, 'OUIHARDAN', 'WAFAA', 'F', '2005-10-12', '2eme', 'wafaaouihardan@gmail.com', 4, 9, 'c1d35b54142cd4603c62966b055902e7ffa6f0a1f7726ca196984c189d22f235'),
(2005101400355, 'LKAMEL', 'ZINA', 'F', '2005-10-14', '1ere', 'zinalkamel@gmail.com', 2, 3, '361b1e454379fd728f87a4caea12d6d4d66918fb48a05cce73fd4e00b5e7ee8b'),
(2005101600184, 'ABOURICHA', 'DOAA', 'F', '2005-10-16', '2eme', 'doaaabouricha@gmail.com', 4, 5, 'b3314bc7cd199e301c58e7a9db4b784cf4e8831130f912e1d2a30268b1124d3e'),
(2005110800169, 'HAMOS', 'KAMAL', 'H', '2005-11-08', '2eme', 'kamalhamos@gmail.com', 4, 9, 'dd2b1ef95e3b0c10884d544fd39db6808a430e1b4bcac418f1093239bd50d543'),
(2005110900321, 'LATMANI', 'TAHA', 'H', '2005-11-09', '1ere', 'tahalatmani@gmail.com', 2, 8, 'f63d18e44ba40addae7bf541bc2a5f610c690a48a02756ea205b54978ce5fc49'),
(2005112600144, 'FARID', 'SALMA', 'F', '2005-11-26', '2eme', 'salmafarid@gmail.com', 4, 5, 'bce2349b2f01319efe7e52dcbab56de77ff0e8b09095881eae955ac45f416b08'),
(2005112800327, 'EL HARCHI', 'ABDELMOGHIT', 'H', '2005-11-28', '1ere', 'abdelmoghitel harchi@gmail.com', 2, 8, 'b06f368ae4ed795fccd88be90f76bda30b3f2622e2b9f90fe73b0ee04e72ce6a'),
(2005120100297, 'SANBATI', 'KAWTAR', 'F', '2005-12-01', '1ere', 'kawtarsanbati@gmail.com', 2, 8, '8cec10a06be89babc96cf7d7a8314a22be58a1b5bd51003bcab3edd45b6f5357'),
(2005121200187, 'BARIJ', 'KHADIJA', 'F', '2005-12-12', '2eme', 'khadijabarij@gmail.com', 4, 5, 'e3fc442a542a926f79218872322ad18ff85e894a84bdf8e6e4de58dc6299f59b'),
(2006010100828, 'BENCHAMSI', 'AYA', 'F', '2006-01-01', '1ere', 'ayabenchamsi@gmail.com', 2, 8, '5a97cad80a43ef9849a31079f5558b215337131e36e08654f751d7426f94425e'),
(2006012700205, 'FARHAN', 'MOHAMMED-AMINE', 'H', '2006-01-27', '1ere', 'mohammed-aminefarhan@gmail.com', 2, 3, '38b5424412a9187d1c1f8d568b2b3c6e226793f3c80dcdd662beb9ea30fa6773'),
(2006012800246, 'AGOUD', 'KOSSAI', 'H', '2006-01-28', '1ere', 'kossaiagoud@gmail.com', 2, 8, 'e5a5f7ce959952a3ccf3bc3162c40c2390e6863348d33fc8045c6b0314e3936e'),
(2006012900279, 'KARMOUCH', 'MOHAMED AMINE', 'H', '2006-01-29', '1ere', 'mohamed aminekarmouch@gmail.com', 2, 3, '25c4b5e323cb123f722dea74d94454c5864194f569d137eaaebd8b6941f41f49'),
(2006021600091, 'MOUNIR', 'SALMA', 'F', '2006-02-16', '2eme', 'salmamounir@gmail.com', 4, 5, 'ddbe998259d2b883b78e8329cab93f3d541228ca6dc8fd2a2457035182abb143'),
(2006022100096, 'BALADI', 'LINA', 'F', '2006-02-21', '2eme', 'linabaladi@gmail.com', 4, 9, 'd2fe5e35fe86d6ee4fea975fb8bdd6d125f429b0195ac9770c547fe3707d4603'),
(2006030400179, 'ZEROUALI', 'HIBA', 'F', '2006-03-04', '1ere', 'hibazerouali@gmail.com', 2, 3, '3b5224ba3ca069395bd2fcc5d9f723f42f056c721d53f669d104d1076e9c204e'),
(2006032600112, 'ACHIK', 'MALAK', 'F', '2006-03-26', '2eme', 'malakachik@gmail.com', 4, 9, '94ec8c5b35e06697b4464189b87069fdcb85519a9d84bc682abc10bec374c8c1'),
(2006041800152, 'TRAI', 'SOUKAINA', 'F', '2006-04-18', '1ere', 'soukainatrai@gmail.com', 2, 8, 'ad9da89d17fe574745654ed598a2e077c0deb7c5a93d220b5ab516efab1ef8dd'),
(2006051800104, 'KARIN', 'RACHIDA', 'F', '2006-05-18', '1ere', 'rachidakarin@gmail.com', 2, 3, 'e94d5c890f269dac9357586980bde718dce69bd53833e5a46018512c2f4fe2c7'),
(2006051800218, 'ER-RAYS', 'ELHOUSSAINE', 'H', '2006-05-18', '1ere', 'elhoussaineer-rays@gmail.com', 2, 8, '251ffcc3955e06906c95fffe9a898d5f44b72351187147278881f543ed239e9e'),
(2006052800166, 'AMANSAGUE', 'SALMA', 'F', '2006-05-28', '1ere', 'salmaamansague@gmail.com', 2, 8, '4c4d5314f7ea384282d5c2ebfbbe0d1a141f32befdd502ec20082b63c8826287'),
(2006060100166, 'MRINY', 'MAROUA', 'F', '2006-06-01', '1ere', 'marouamriny@gmail.com', 2, 3, 'f1ea509b59953bd88e21673d76ba8b46a183aeeeb037f80d9198af8c45478373'),
(2006061300152, 'OUZBAD', 'MARYAM', 'F', '2006-06-13', '1ere', 'maryamouzbad@gmail.com', 2, 8, 'feca4732436b255039d41d7016b7e20de855fc4b7c9192da8b6d86a7c25f871f'),
(2006071200200, 'FAHSSI', 'NADA', 'F', '2006-07-11', '1ere', 'nadafahssi@gmail.com', 2, 8, 'f20d03f46da99bbedbc76164653e30bdac781a20dda2163ee3cfafe289c2a3be'),
(2006080100205, 'MOUMEN', 'AMINA', 'F', '2006-08-01', '1ere', 'aminamoumen@gmail.com', 2, 8, '55252f4dde9b573fea900bf741fd2c08c40b1a53b6bcc4ffd58c8de771311504'),
(2006080900169, 'BLOULBI', 'AICHA', 'F', '2006-08-09', '1ere', 'aichabloulbi@gmail.com', 2, 8, '9c4551a4d28f47e7f5c97e2cf2ea8ce210a2d500ef6b1ac22406a73a1b073e49'),
(2006081700121, 'JOUDI', 'ADAM', 'H', '2006-08-17', '1ere', 'adamjoudi@gmail.com', 2, 8, '8b28eb37d3bc245eec84c5d32448153d10d90d67796e7b60ca8f9fb78e985e76'),
(2006091600137, 'KHOULKHAL', 'FATIMAZAHRA', 'F', '2006-09-16', '1ere', 'fatimazahrakhoulkhal@gmail.com', 2, 3, 'd3f51e7be7c353f6c1cea17a01b7476cfe0c4d1c1c3e8f4b0c009d86a71376f8'),
(2006092400110, 'AHDAR', 'HAJAR', 'F', '2006-09-24', '1ere', 'hajarahdar@gmail.com', 2, 8, 'aaabb1371a048b02a233e941afc220894161ce5f49cd39874b56d88ee0b1d1df'),
(2006092400163, 'ZAID', 'FADWA', 'F', '2006-09-24', '1ere', 'fadwazaid@gmail.com', 2, 3, '848d92ed4bb3969c57fbc864b11b0f9966d4367a989a2a01a546efab7ec7d4a4'),
(2006100900105, 'ABOUZIN', 'LINA', 'F', '2006-10-09', '1ere', 'linaabouzin@gmail.com', 2, 8, '6fda3044bcd45ccd04f987b031e0a1792d339b12c55d5b161ac3b8a660e21c6c'),
(2006101800121, 'ZARHBOUCH', 'GHITA', 'F', '2006-10-18', '1ere', 'ghitazarhbouch@gmail.com', 2, 3, '39d3216ce7a6834ce66fd64014dedcfaf93ded5bfc95c0ce97e5b4a5dc5ccf94'),
(2006102000190, 'OULAIZ', 'RANIA', 'F', '2006-10-20', '1ere', 'raniaoulaiz@gmail.com', 2, 8, '4f531f353b0775ad08a918ac8eb4899aae0b88600f1c14f28ed6bbdfc0a8c334'),
(2006110900140, 'MOURCHID', 'ZAYNAB', 'F', '2006-11-09', '1ere', 'zaynabmourchid@gmail.com', 2, 8, '16475b1dcfa0fba8ae147f01593336ceafd9c7a74b8cfa7ee2b78b2cf445acd6'),
(2006111000131, 'CAWNI', 'MAHMOUD', 'H', '2006-11-10', '1ere', 'mahmoudcawni@gmail.com', 2, 3, 'ecee2f3b035ad41567fe723c31a356bf8aa6d12958066b49059fcf9b16da4336'),
(2006111300151, 'GHOUATI', 'SAAD', 'H', '2006-11-13', '1ere', 'saadghouati@gmail.com', 2, 3, 'a177dcef5cf9a9ef92e3fe3cfdda3fccbd4f8b451678efe19a7fc5c42b5a3257'),
(2006111900109, 'EL MEHRAOUI', 'RANIA', 'F', '2006-11-19', '1ere', 'raniael mehraoui@gmail.com', 2, 8, '990dfa19b7623b2b30a97bf971694aceb19f4c7efc3b02e0b1548ef8504424c4'),
(2006112600118, 'HAIM', 'OUSSAMA', 'H', '2006-11-26', '1ere', 'oussamahaim@gmail.com', 2, 8, 'b53346e056305722f909daa1680a180ee8622093475db50a4bf89557c1c7e26a'),
(2006122100118, 'HANNOUN', 'HAJAR', 'F', '2006-12-21', '1ere', 'hajarhannoun@gmail.com', 2, 8, 'fa152e7c98211ab24262657f2306457a2d8918f44621d18b303de80307f00ff7'),
(2006122100195, 'MOURID', 'SARA', 'F', '2006-12-21', '1ere', 'saramourid@gmail.com', 2, 3, '8527ecbe07ffda84e839883cfbaab82be6110c1cc7914fce5c612c1e0333ba93'),
(2006122300075, 'TBARKA', 'MAROUA', 'F', '2006-12-23', '1ere', 'marouatbarka@gmail.com', 2, 8, 'a74fb617b66e91799b8659255f44e5a0e334647aca75f1cff5e4f1cf555c3479'),
(2007010200092, 'BELLOURAK', 'SALMA', 'F', '2007-01-02', '1ere', 'salmabellourak@gmail.com', 2, 8, 'fc4dad103b3ad7aaee637146ca30ace716fb8f91034eaf0f3ef6a861ff1f370a'),
(2007011300116, 'WAHAB', 'AMINA', 'F', '2007-01-13', '1ere', 'aminawahab@gmail.com', 2, 3, '1eeddcca7de02ec8b93fadd29941c34d9b5e37c625577639c123ee573487ebba'),
(2007011700092, 'ASSAD', 'YAHYA', 'H', '2007-01-17', '1ere', 'yahyaassad@gmail.com', 2, 8, 'c1c8c6738dd6977977561622b8fe7df6540cb3d86f623a2fa8ece212a7a3e151'),
(2007012000082, 'NAJIH', 'NASSIRA', 'F', '2007-01-20', '1ere', 'nassiranajih@gmail.com', 2, 3, '9ed6ea832f395f9fe3323c68da98bbbddb1b7f5275a965b256ab78041da44d11'),
(2007020100102, 'AZLAG', 'BASSMA', 'F', '2007-02-01', '1ere', 'bassmaazlag@gmail.com', 2, 3, '339673526d8c70cc13fa3c15f9390d87c4a51e4f214b67bc56dff0790ec9b89d'),
(2007020500105, 'FAKID', 'SALSABIL', 'F', '2007-02-05', '1ere', 'salsabilfakid@gmail.com', 2, 8, '0cd621b4703a05ec623096afcc71b0ef655e18683450f88b542017693d53acb7'),
(2007020500131, 'KAMAL', 'NOUHAILA', 'F', '2007-02-05', '1ere', 'nouhailakamal@gmail.com', 2, 8, 'b6a69813c0bc9626b09b94426704052e0628c4da4abbff46df61c892476003bd'),
(2007021500146, 'CHAHBANE', 'SALMA', 'F', '2007-02-15', '1ere', 'salmachahbane@gmail.com', 2, 8, 'f228e679f275ac8536943b4d98d1504beb424d0277c7eb14f83147d7f33d809f'),
(2007021900105, 'GHALDOUNI', 'MERIEM', 'F', '2007-02-19', '1ere', 'meriemghaldouni@gmail.com', 2, 8, 'ef32d14f6eb21465dd0b9afd6dd053e2d3dde32f49570b49aee83ee6147b5c62'),
(2007021900121, 'SORI', 'CHAIMAA', 'F', '2007-02-19', '1ere', 'chaimaasori@gmail.com', 2, 8, '3cff6fd316c3e5ce9624b662652a3310c693086053d2f34e5ffd9ac077b9e35b'),
(2007022000106, 'BOUMASHOULE', 'MERIEM', 'F', '2007-02-20', '1ere', 'meriemboumashoule@gmail.com', 2, 8, '08dcd70ce9cb29fa506acb47642341baa29b1d34d066eeeb3a3cd06d19a54b44'),
(2007031400097, 'SAJI', 'MOHAMMED', 'H', '2007-03-14', '1ere', 'mohammedsaji@gmail.com', 2, 8, '032f0c56aa2dd6f26cdc09920e3ba18d688a4f1dac4159f779c233b772ada130'),
(2007031500014, 'BEROUANE', 'ZINEB', 'F', '2007-03-15', '1ere', 'zinebberouane@gmail.com', 2, 8, '1f5411a362496e5082fb2b3836592df90b46ae4bc9b43a9de5c7c4de9d0e1de6'),
(2007031700104, 'YASSIR', 'AYOUB', 'H', '2007-03-17', '1ere', 'ayoubyassir@gmail.com', 2, 8, '860659367e61567177c4c663f3da0633d3d9e9fb399e9f6b157f8f1b16bade18'),
(2007032200088, 'CHADI', 'YASSINE', 'H', '2007-03-22', '1ere', 'yassinechadi@gmail.com', 2, 3, '7513d3e41db6a56ed1ef9946d54b4b2c858d443cb428ff6782ef72fa9bd6c861');

-- --------------------------------------------------------

--
-- Structure de la table `temp_import_stagiaires`
--

CREATE TABLE `temp_import_stagiaires` (
  `id_stagiaire` bigint(100) UNSIGNED DEFAULT NULL,
  `Nom` varchar(100) DEFAULT NULL,
  `Prénom` varchar(100) DEFAULT NULL,
  `Genre` varchar(10) DEFAULT NULL,
  `Date_naissance` varchar(20) DEFAULT NULL,
  `Année_etude` varchar(20) DEFAULT NULL,
  `Filière` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Groupe` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `temp_import_stagiaires`
--

INSERT INTO `temp_import_stagiaires` (`id_stagiaire`, `Nom`, `Prénom`, `Genre`, `Date_naissance`, `Année_etude`, `Filière`, `Email`, `Groupe`) VALUES
(1971042300004, 'SABRI', 'MOHAMED', 'H', '7/12/2001', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'mohamedsabri@gmail.com', 'DEV101'),
(1979012400008, 'RAZI', 'GHIZLANE', 'F', '7/14/2002', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'ghizlanerazi@gmail.com', 'DEV101'),
(1985042200013, 'RIZKI', 'NADIA', 'F', '8/20/2004', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'nadiarizki@gmail.com', 'DEV101'),
(1986030600018, 'SAADI', 'AMAL', 'F', '10/28/2004', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'amalsaadi@gmail.com', 'DEV101'),
(1988033000013, 'CHADLI', 'NIZAR', 'H', '3/30/2003', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'nizarchadli@gmail.com', 'DEV101'),
(199306040194, 'BOUHADI', 'AICHA', 'F', '6/4/2004', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'aichabouhadi@gmail.com', 'DEV101'),
(199306210411, 'ZAHDI', 'SOUKAINA', 'F', '6/21/2004', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'soukainazahdi@gmail.com', 'DEV101'),
(199409090273, 'NAJI', 'HAJAR', 'F', '9/9/2002', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'hajarnaji@gmail.com', 'DEV101'),
(199510010159, 'FATMI', 'NAJIA', 'F', '10/1/2004', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'najiafatmi@gmail.com', 'DEV101'),
(199701016726, 'OUAKRACH', 'SAID', 'F', '1/1/2005', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'saidouakrach@gmail.com', 'DEV101'),
(1997052300346, 'ABBASSI', 'HAJAR', 'F', '5/23/2005', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'hajarabbassi@gmail.com', 'DEV102'),
(199712160201, 'MOUSSAOUI-ZERHOUNI', 'SALIMA', 'F', '12/16/2005', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'salimamoussaoui-zerhouni@gmail.com', 'DEV102'),
(1998082000597, 'DAIF', 'MUSTAPHA', 'H', '8/20/2004', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'mustaphadaif@gmail.com', 'DEV102'),
(1998102800134, 'MOUKRIM', 'WISSAL', 'F', '10/28/2004', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'wissalmoukrim@gmail.com', 'DEV102'),
(1998121400271, 'NACHITE', 'MEHDI', 'H', '12/14/2004', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'mehdinachite@gmail.com', 'DEV102'),
(1999042500409, 'HARIRI', 'NORA', 'F', '4/25/2005', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'norahariri@gmail.com', 'DEV102'),
(1999050800389, 'CHETOUANI', 'HOSSAM', 'H', '5/8/2005', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'hossamchetouani@gmail.com', 'DEV102'),
(1999092600316, 'TILIOUINE', 'NOUHAILA', 'F', '9/26/2005', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'nouhailatiliouine@gmail.com', 'DEV102'),
(2001071200082, 'BENFSSAHI', 'NOUR-EDDINE', 'H', '7/12/2001', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'nour-eddinebenfssahi@gmail.com', 'DEV102'),
(2002071400405, 'RHAZZI', 'SALMA', 'F', '7/14/2002', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'salmarhazzi@gmail.com', 'DEV102'),
(2003121400337, 'EL BILALI', 'HAMID', 'H', '12/14/2003', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'hamidel bilali@gmail.com', 'DEV102'),
(2004010200598, 'KARIMI', 'SAIDA', 'F', '1/2/2004', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'saidakarimi@gmail.com', 'DEV102'),
(199106180095, 'SALMI', 'REDOUANE', 'H', '6/18/2005', ' 2eme', 'Technicien Spécialisé en Gestion des Entreprises (1A)', 'redouanesalmi@gmail.com', 'GE101'),
(1994071400084, 'ERRAOUI', 'FARIDA', 'F', '7/14/2002', ' 2eme', 'Technicien Spécialisé en Gestion des Entreprises (1A)', 'faridaerraoui@gmail.com', 'GE101'),
(199508140415, 'EL HADEF', 'NAJIA', 'F', '8/14/2004', ' 2eme', 'Technicien Spécialisé en Gestion des Entreprises (1A)', 'najiael hadef@gmail.com', 'GE101'),
(1999020100749, 'SAYLANI', 'MERYEM', 'F', '2/1/2005', ' 2eme', 'Technicien Spécialisé en Gestion des Entreprises (1A)', 'meryemsaylani@gmail.com', 'GE101'),
(1999110500332, 'OUACHEN', 'ABDELHADI', 'F', '11/5/2005', ' 2eme', 'Technicien Spécialisé en Gestion des Entreprises (1A)', 'abdelhadiouachen@gmail.com', 'GE101'),
(2000031500444, 'ADLAOUI', 'MOURAD', 'F', '3/15/2000', ' 2eme', 'Technicien Spécialisé en Gestion des Entreprises (1A)', 'mouradadlaoui@gmail.com', 'GE101'),
(2001010800207, 'ELBOUKHARI', 'KHALID', 'H', '1/8/2001', ' 2eme', 'Technicien Spécialisé en Gestion des Entreprises (1A)', 'khalidelboukhari@gmail.com', 'GE101'),
(1981090500006, 'DARIANE', 'SALMA', 'F', '9/5/2002', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'salmadariane@gmail.com', 'WEBFS201'),
(199009210072, 'GABBASSI', 'RANIA', 'F', '9/21/2003', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'raniagabbassi@gmail.com', 'WEBFS201'),
(199302030471, 'EL ALAOUI', 'RADIA', 'F', '2/3/2004', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'radiael alaoui@gmail.com', 'WEBFS201'),
(199610100307, 'ES-SALEMY', 'LAILA', 'F', '10/10/2004', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'lailaes-salemy@gmail.com', 'WEBFS201'),
(1996112800104, 'HALLAOUI', 'AYA', 'F', '11/28/2004', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'ayahallaoui@gmail.com', 'WEBFS201'),
(1996122300195, 'NAJIH', 'TOURIA', 'F', '12/23/2004', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'tourianajih@gmail.com', 'WEBFS201'),
(1981090500006, 'DAFIR', 'FARID', 'H', '7/12/2001', ' 2eme', 'Gestion des Entreprises-Option Commerce', 'fariddafir@gmail.com', 'GEC201'),
(199009210072, 'ALAOUI', 'HAJAR', 'F', '7/14/2002', ' 2eme', 'Gestion des Entreprises-Option Commerce', 'hajaralaoui@gmail.com', 'GEC201'),
(199302030471, 'RAJI', 'CHADIA', 'F', '2/3/2004', ' 2eme', 'Gestion des Entreprises-Option Commerce', 'chadiaraji@gmail.com', 'GEC201'),
(199610100307, 'TAKI', 'NADIA', 'F', '5/8/2005', ' 2eme', 'Gestion des Entreprises-Option Commerce', 'nadiataki@gmail.com', 'GEC201'),
(1996112800104, 'FOUHAMI', 'SARA', 'F', '11/28/2004', ' 2eme', 'Gestion des Entreprises-Option Commerce', 'sarafouhami@gmail.com', 'GEC201'),
(1996122300195, 'CHADLI', 'NAJIA', 'F', '12/14/2004', ' 2eme', 'Gestion des Entreprises-Option Commerce', 'najiachadli@gmail.com', 'GEC201'),
(1996122300195, 'NAIM', 'REDA', 'H', '4/25/2005', ' 2eme', 'Gestion des Entreprises-Option Commerce', 'redanaim@gmail.com', 'GEC207'),
(2002080900441, 'SABIRY', 'SOULTANE', 'H', '8/9/2002', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'soultanesabiry@gmail.com', 'DEV103'),
(2003112600530, 'TAIKI', 'NOUHAILA', 'F', '11/26/2003', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'nouhailataiki@gmail.com', 'DEV103'),
(2003121900387, 'KARIM', 'SALMA', 'F', '12/19/2003', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'salmakarim@gmail.com', 'DEV103'),
(2004060300205, 'KHEBBAB', 'AYA', 'F', '6/3/2004', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'ayakhebbab@gmail.com', 'DEV103'),
(2004120400389, 'AFFANE', 'FATIMA-EZZAHRAA', 'F', '12/4/2004', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'fatima-ezzahraaaffane@gmail.com', 'DEV103'),
(2005041700211, 'SEFFANY', 'AYMAN', 'H', '4/17/2005', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'aymanseffany@gmail.com', 'DEV103'),
(2005050900238, 'MEHDI', 'GATIFI', 'H', '5/9/2005', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'gatifimehdi@gmail.com', 'DEV103'),
(2005080600309, 'ASLAOUI', 'NADIA', 'F', '8/6/2005', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'nadiaaslaoui@gmail.com', 'DEV103'),
(2005092500259, 'HADDI', 'EL MEHDI', 'H', '9/25/2005', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'el mehdihaddi@gmail.com', 'DEV103'),
(2006010100828, 'BENCHAMSI', 'AYA', 'F', '1/1/2006', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'ayabenchamsi@gmail.com', 'DEV103'),
(2006012800246, 'AGOUD', 'KOSSAI', 'H', '1/28/2006', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'kossaiagoud@gmail.com', 'DEV103'),
(2006080100205, 'MOUMEN', 'AMINA', 'F', '8/1/2006', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'aminamoumen@gmail.com', 'DEV103'),
(2006080900169, 'BLOULBI', 'AICHA', 'F', '8/9/2006', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'aichabloulbi@gmail.com', 'DEV103'),
(2006081700121, 'JOUDI', 'ADAM', 'H', '8/17/2006', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'adamjoudi@gmail.com', 'DEV103'),
(2006092400110, 'AHDAR', 'HAJAR', 'F', '9/24/2006', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'hajarahdar@gmail.com', 'DEV103'),
(2006122100118, 'HANNOUN', 'HAJAR', 'F', '12/21/2006', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'hajarhannoun@gmail.com', 'DEV103'),
(2007010200092, 'BELLOURAK', 'SALMA', 'F', '1/2/2007', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'salmabellourak@gmail.com', 'DEV103'),
(2007011700092, 'ASSAD', 'YAHYA', 'H', '1/17/2007', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'yahyaassad@gmail.com', 'DEV103'),
(2007020500105, 'FAKID', 'SALSABIL', 'F', '2/5/2007', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'salsabilfakid@gmail.com', 'DEV103'),
(2007020500131, 'KAMAL', 'NOUHAILA', 'F', '2/5/2007', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'nouhailakamal@gmail.com', 'DEV103'),
(2007021500146, 'CHAHBANE', 'SALMA', 'F', '2/15/2007', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'salmachahbane@gmail.com', 'DEV103'),
(2007021900105, 'GHALDOUNI', 'MERIEM', 'F', '2/19/2007', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'meriemghaldouni@gmail.com', 'DEV103'),
(2007031400097, 'SAJI', 'MOHAMMED', 'H', '3/14/2007', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'mohammedsaji@gmail.com', 'DEV103'),
(2007031500014, 'BEROUANE', 'ZINEB', 'F', '3/15/2007', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'zinebberouane@gmail.com', 'DEV103'),
(2002053100394, 'HNIBEL', 'RACHID', 'H', '5/31/2002', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'rachidhnibel@gmail.com', 'DEV102'),
(2004020900412, 'BALHA', 'SOUHAIL', 'H', '2/9/2004', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'souhailbalha@gmail.com', 'DEV102'),
(2004061400375, 'AHADAR', 'MERIEM', 'F', '6/14/2004', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'meriemahadar@gmail.com', 'DEV102'),
(2004061500454, 'NAITOUAHMAN', 'EYA', 'F', '6/15/2004', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'eyanaitouahman@gmail.com', 'DEV102'),
(2004081000497, 'KAAB', 'ASMAA', 'F', '8/10/2004', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'asmaakaab@gmail.com', 'DEV102'),
(2005012600448, 'SAADAOUI', 'NAOUFAL', 'H', '1/26/2005', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'naoufalsaadaoui@gmail.com', 'DEV102'),
(2005040900126, 'BELOUKID', 'RACHID', 'H', '4/9/2005', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'rachidbeloukid@gmail.com', 'DEV102'),
(2005101400355, 'LKAMEL', 'ZINA', 'F', '10/14/2005', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'zinalkamel@gmail.com', 'DEV102'),
(2006012700205, 'FARHAN', 'MOHAMMED-AMINE', 'H', '1/27/2006', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'mohammed-aminefarhan@gmail.com', 'DEV102'),
(2006012900279, 'KARMOUCH', 'MOHAMED AMINE', 'H', '1/29/2006', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'mohamed aminekarmouch@gmail.com', 'DEV102'),
(2006030400179, 'ZEROUALI', 'HIBA', 'F', '3/4/2006', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'hibazerouali@gmail.com', 'DEV102'),
(2006051800104, 'KARIN', 'RACHIDA', 'F', '5/18/2006', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'rachidakarin@gmail.com', 'DEV102'),
(2006060100166, 'MRINY', 'MAROUA', 'F', '6/1/2006', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'marouamriny@gmail.com', 'DEV102'),
(2006091600137, 'KHOULKHAL', 'FATIMAZAHRA', 'F', '9/16/2006', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'fatimazahrakhoulkhal@gmail.com', 'DEV102'),
(2006092400163, 'ZAID', 'FADWA', 'F', '9/24/2006', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'fadwazaid@gmail.com', 'DEV102'),
(2006101800121, 'ZARHBOUCH', 'GHITA', 'F', '10/18/2006', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'ghitazarhbouch@gmail.com', 'DEV102'),
(2006111000131, 'CAWNI', 'MAHMOUD', 'H', '11/10/2006', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'mahmoudcawni@gmail.com', 'DEV102'),
(2006111300151, 'GHOUATI', 'SAAD', 'H', '11/13/2006', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'saadghouati@gmail.com', 'DEV102'),
(2006122100195, 'MOURID', 'SARA', 'F', '12/21/2006', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'saramourid@gmail.com', 'DEV102'),
(2007011300116, 'WAHAB', 'AMINA', 'F', '1/13/2007', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'aminawahab@gmail.com', 'DEV102'),
(2007012000082, 'NAJIH', 'NASSIRA', 'F', '1/20/2007', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'nassiranajih@gmail.com', 'DEV102'),
(2007020100102, 'AZLAG', 'BASSMA', 'F', '2/1/2007', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'bassmaazlag@gmail.com', 'DEV102'),
(2007032200088, 'CHADI', 'YASSINE', 'H', '3/22/2007', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'yassinechadi@gmail.com', 'DEV102'),
(2003122000363, 'RIDAOUI', 'ZHOUR', 'F', '12/20/2003', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'zhourridaoui@gmail.com', 'DEV103'),
(2004020100570, 'SNINA', 'AMIRA', 'F', '2/1/2004', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'amirasnina@gmail.com', 'DEV103'),
(2004083000439, 'AIT SALAH', 'NADYA', 'F', '8/30/2004', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'nadyaait salah@gmail.com', 'DEV103'),
(2004121000395, 'OUARID', 'MOUNDIR', 'H', '12/10/2004', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'moundirouarid@gmail.com', 'DEV103'),
(2005032100230, 'ABOULAHMADA', 'IKRAM', 'F', '3/21/2005', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'ikramaboulahmada@gmail.com', 'DEV103'),
(2005052700268, 'MOUNAN', 'DOUAA', 'F', '5/27/2005', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'douaamounan@gmail.com', 'DEV103'),
(2005110900321, 'LATMANI', 'TAHA', 'H', '11/9/2005', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'tahalatmani@gmail.com', 'DEV103'),
(2005112800327, 'EL HARCHI', 'ABDELMOGHIT', 'H', '11/28/2005', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'abdelmoghitel harchi@gmail.com', 'DEV103'),
(2005120100297, 'SANBATI', 'KAWTAR', 'F', '12/1/2005', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'kawtarsanbati@gmail.com', 'DEV103'),
(2006041800152, 'TRAI', 'SOUKAINA', 'F', '4/18/2006', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'soukainatrai@gmail.com', 'DEV103'),
(2006051800218, 'ER-RAYS', 'ELHOUSSAINE', 'H', '5/18/2006', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'elhoussaineer-rays@gmail.com', 'DEV103'),
(2006052800166, 'AMANSAGUE', 'SALMA', 'F', '5/28/2006', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'salmaamansague@gmail.com', 'DEV103'),
(2006061300152, 'OUZBAD', 'MARYAM', 'F', '6/13/2006', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'maryamouzbad@gmail.com', 'DEV103'),
(2006071200200, 'FAHSSI', 'NADA', 'F', '7/11/2006', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'nadafahssi@gmail.com', 'DEV103'),
(2006100900105, 'ABOUZIN', 'LINA', 'F', '10/9/2006', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'linaabouzin@gmail.com', 'DEV103'),
(2006102000190, 'OULAIZ', 'RANIA', 'F', '10/20/2006', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'raniaoulaiz@gmail.com', 'DEV103'),
(2006110900140, 'MOURCHID', 'ZAYNAB', 'F', '11/9/2006', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'zaynabmourchid@gmail.com', 'DEV103'),
(2006111900109, 'EL MEHRAOUI', 'RANIA', 'F', '11/19/2006', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'raniael mehraoui@gmail.com', 'DEV103'),
(2006112600118, 'HAIM', 'OUSSAMA', 'H', '11/26/2006', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'oussamahaim@gmail.com', 'DEV103'),
(2006122300075, 'TBARKA', 'MAROUA', 'F', '12/23/2006', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'marouatbarka@gmail.com', 'DEV103'),
(2007021900121, 'SORI', 'CHAIMAA', 'F', '2/19/2007', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'chaimaasori@gmail.com', 'DEV103'),
(2007022000106, 'BOUMASHOULE', 'MERIEM', 'F', '2/20/2007', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'meriemboumashoule@gmail.com', 'DEV103'),
(2007031700104, 'YASSIR', 'AYOUB', 'H', '3/17/2007', ' 1ere', 'Developement Digital-Tronc Commun (1A)', 'ayoubyassir@gmail.com', 'DEV103'),
(1999012400442, 'HILALI', 'IBTISSAM', 'F', '1/24/2005', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'ibtissamhilali@gmail.com', 'WEBFS201'),
(2002011300422, 'CHAABANE', 'BOUTAINA', 'F', '1/13/2002', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'boutainachaabane@gmail.com', 'WEBFS201'),
(2003041000439, 'AMADAH', 'HIBA TALLAH', 'F', '4/10/2003', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'hiba tallahamadah@gmail.com', 'WEBFS201'),
(2003051000337, 'MANSOURI', 'FADWA', 'F', '5/10/2003', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'fadwamansouri@gmail.com', 'WEBFS201'),
(2003100500053, 'NAANAA', 'EL ALIA', 'F', '10/5/2003', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'el alianaanaa@gmail.com', 'WEBFS201'),
(2004010200489, 'YAHYAOUI', 'HAFSSA', 'F', '1/2/2004', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'hafssayahyaoui@gmail.com', 'WEBFS201'),
(2004052300256, 'LAANYA', 'SALMA', 'F', '5/23/2004', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'salmalaanya@gmail.com', 'WEBFS201'),
(2004092100216, 'ELHAMDANI', 'SOUKAINA', 'F', '9/21/2004', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'soukainaelhamdani@gmail.com', 'WEBFS201'),
(2005033000191, 'ZIBAR', 'NISSRINE', 'F', '3/30/2005', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'nissrinezibar@gmail.com', 'WEBFS201'),
(2005040200144, 'ZIADI', 'HIBA', 'F', '4/2/2005', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'hibaziadi@gmail.com', 'WEBFS201'),
(2005060600143, 'ELMALIH', 'IBTISSAM', 'F', '6/6/2005', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'ibtissamelmalih@gmail.com', 'WEBFS201'),
(2005062700152, 'HETTAT', 'AYA', 'F', '6/27/2005', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'ayahettat@gmail.com', 'WEBFS201'),
(2005070700194, 'TARIQ', 'MARYAM', 'F', '7/7/2005', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'maryamtariq@gmail.com', 'WEBFS201'),
(2005072800149, 'BENAICHOUR', 'DOUAA', 'F', '7/28/2005', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'douaabenaichour@gmail.com', 'WEBFS201'),
(2005091600209, 'LAGHLALI', 'NOUHAILA', 'F', '9/16/2005', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'nouhailalaghlali@gmail.com', 'WEBFS201'),
(2005092500138, 'EL HASNAOUI', 'RIHAB', 'F', '9/25/2005', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'rihabel hasnaoui@gmail.com', 'WEBFS201'),
(2005101600184, 'ABOURICHA', 'DOAA', 'F', '10/16/2005', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'doaaabouricha@gmail.com', 'WEBFS201'),
(2005112600144, 'FARID', 'SALMA', 'F', '11/26/2005', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'salmafarid@gmail.com', 'WEBFS201'),
(2005121200187, 'BARIJ', 'KHADIJA', 'F', '12/12/2005', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'khadijabarij@gmail.com', 'WEBFS201'),
(2006021600091, 'MOUNIR', 'SALMA', 'F', '2/16/2006', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'salmamounir@gmail.com', 'WEBFS201'),
(2000061200499, 'LOUAFY', 'MOHAMMED', 'H', '6/12/2000', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'mohammedlouafy@gmail.com', 'WEBFS202'),
(2003050900352, 'FATTAHI', 'ZAID', 'H', '5/9/2003', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'zaidfattahi@gmail.com', 'WEBFS202'),
(2004041600110, 'AADDAL', 'ILYASS', 'H', '4/16/2004', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'ilyassaaddal@gmail.com', 'WEBFS202'),
(2004052000290, 'MELLOUK', 'OUMAIMA', 'F', '5/20/2004', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'oumaimamellouk@gmail.com', 'WEBFS202'),
(2004060800108, 'DYANI', 'MOHAMMED AMINE', 'H', '6/8/2004', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'mohammed aminedyani@gmail.com', 'WEBFS202'),
(2004110100263, 'IKLANE', 'SALMA', 'F', '11/1/2004', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'salmaiklane@gmail.com', 'WEBFS202'),
(2004110700102, 'ELBADAOUY', 'LAILA', 'F', '11/7/2004', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'lailaelbadaouy@gmail.com', 'WEBFS202'),
(2005021100160, 'DYBES', 'ILYAS', 'H', '2/11/2005', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'ilyasdybes@gmail.com', 'WEBFS202'),
(2005031200262, 'HERZALLA', 'AMIRA', 'F', '3/12/2005', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'amiraherzalla@gmail.com', 'WEBFS202'),
(2005050100254, 'AIT MANSOUR', 'ADNANE', 'H', '5/1/2005', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'adnaneait mansour@gmail.com', 'WEBFS202'),
(2005050900158, 'SAOUDI', 'IKRAM', 'F', '5/9/2005', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'ikramsaoudi@gmail.com', 'WEBFS202'),
(2005051100211, 'CHOUBANE', 'MALAK', 'F', '5/11/2005', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'malakchoubane@gmail.com', 'WEBFS202'),
(2005062200211, 'HADDAOUI', 'MARWA', 'F', '6/22/2005', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'marwahaddaoui@gmail.com', 'WEBFS202'),
(2005070100194, 'JAADA', 'AYA', 'F', '7/1/2005', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'ayajaada@gmail.com', 'WEBFS202'),
(2005073100097, 'BANHAR', 'HIBA', 'F', '7/31/2005', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'hibabanhar@gmail.com', 'WEBFS202'),
(2005101200151, 'OUIHARDAN', 'WAFAA', 'F', '10/12/2005', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'wafaaouihardan@gmail.com', 'WEBFS202'),
(2005110800169, 'HAMOS', 'KAMAL', 'H', '11/8/2005', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'kamalhamos@gmail.com', 'WEBFS202'),
(2006022100096, 'BALADI', 'LINA', 'F', '2/21/2006', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'linabaladi@gmail.com', 'WEBFS202'),
(2006032600112, 'ACHIK', 'MALAK', 'F', '3/26/2006', ' 2eme', 'Developpement Digital - Option Web Full Stack', 'malakachik@gmail.com', 'WEBFS202');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `Admine`
--
ALTER TABLE `Admine`
  ADD PRIMARY KEY (`id_Admin`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Index pour la table `Filiere`
--
ALTER TABLE `Filiere`
  ADD PRIMARY KEY (`id_Filiere`);

--
-- Index pour la table `Formateur`
--
ALTER TABLE `Formateur`
  ADD PRIMARY KEY (`id_formateur`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Index pour la table `formateur_groupe`
--
ALTER TABLE `formateur_groupe`
  ADD PRIMARY KEY (`id_formateur`,`id_groupe`),
  ADD KEY `id_groupe` (`id_groupe`);

--
-- Index pour la table `Groupe`
--
ALTER TABLE `Groupe`
  ADD PRIMARY KEY (`id_Groupe`);

--
-- Index pour la table `Module`
--
ALTER TABLE `Module`
  ADD PRIMARY KEY (`id_module`);

--
-- Index pour la table `Module_Filiere_Formateur`
--
ALTER TABLE `Module_Filiere_Formateur`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_module` (`id_module`),
  ADD KEY `id_formateur` (`id_formateur`);

--
-- Index pour la table `Note`
--
ALTER TABLE `Note`
  ADD PRIMARY KEY (`id_note`),
  ADD KEY `id_module` (`id_module`),
  ADD KEY `id_formateur` (`id_formateur`),
  ADD KEY `note_ibfk_1` (`id_stagiaire`);

--
-- Index pour la table `Stagiaire`
--
ALTER TABLE `Stagiaire`
  ADD PRIMARY KEY (`id_stagiaire`),
  ADD UNIQUE KEY `id_stagiaire` (`id_stagiaire`),
  ADD UNIQUE KEY `id_stagiaire_2` (`id_stagiaire`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_Filiere` (`id_Filiere`),
  ADD KEY `id_Groupe` (`id_Groupe`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `Admine`
--
ALTER TABLE `Admine`
  MODIFY `id_Admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `Filiere`
--
ALTER TABLE `Filiere`
  MODIFY `id_Filiere` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT pour la table `Formateur`
--
ALTER TABLE `Formateur`
  MODIFY `id_formateur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `Groupe`
--
ALTER TABLE `Groupe`
  MODIFY `id_Groupe` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;

--
-- AUTO_INCREMENT pour la table `Module_Filiere_Formateur`
--
ALTER TABLE `Module_Filiere_Formateur`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `Note`
--
ALTER TABLE `Note`
  MODIFY `id_note` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=286;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `formateur_groupe`
--
ALTER TABLE `formateur_groupe`
  ADD CONSTRAINT `formateur_groupe_ibfk_1` FOREIGN KEY (`id_formateur`) REFERENCES `formateur` (`id_formateur`),
  ADD CONSTRAINT `formateur_groupe_ibfk_2` FOREIGN KEY (`id_groupe`) REFERENCES `groupe` (`id_Groupe`);

--
-- Contraintes pour la table `Module_Filiere_Formateur`
--
ALTER TABLE `Module_Filiere_Formateur`
  ADD CONSTRAINT `module_filiere_formateur_ibfk_1` FOREIGN KEY (`id_module`) REFERENCES `Module` (`id_module`) ON DELETE CASCADE,
  ADD CONSTRAINT `module_filiere_formateur_ibfk_3` FOREIGN KEY (`id_formateur`) REFERENCES `Formateur` (`id_formateur`) ON DELETE CASCADE;

--
-- Contraintes pour la table `Note`
--
ALTER TABLE `Note`
  ADD CONSTRAINT `note_ibfk_1` FOREIGN KEY (`id_stagiaire`) REFERENCES `Stagiaire` (`id_stagiaire`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `note_ibfk_2` FOREIGN KEY (`id_module`) REFERENCES `Module` (`id_module`) ON DELETE CASCADE,
  ADD CONSTRAINT `note_ibfk_3` FOREIGN KEY (`id_formateur`) REFERENCES `Formateur` (`id_formateur`) ON DELETE CASCADE;

--
-- Contraintes pour la table `Stagiaire`
--
ALTER TABLE `Stagiaire`
  ADD CONSTRAINT `stagiaire_ibfk_1` FOREIGN KEY (`id_Filiere`) REFERENCES `Filiere` (`id_Filiere`) ON DELETE CASCADE,
  ADD CONSTRAINT `stagiaire_ibfk_2` FOREIGN KEY (`id_Groupe`) REFERENCES `Groupe` (`id_Groupe`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
