-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 18 sep. 2024 à 02:41
-- Version du serveur : 8.0.30
-- Version de PHP : 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `gmao_onda_db`
--

-- --------------------------------------------------------

--
-- Structure de la table `agentsuppliers`
--

CREATE TABLE `agentsuppliers` (
  `Id` int NOT NULL,
  `Name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Adress` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Phone` bigint NOT NULL,
  `Email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agentsuppliers`
--

INSERT INTO `agentsuppliers` (`Id`, `Name`, `Adress`, `Phone`, `Email`, `Notes`, `createdAt`, `updatedAt`) VALUES
(1, 'Kamal idrissi', 'route ain chekaf', 767984356, 'kamalidrissi@gmail.com', '', '2024-07-30 02:24:49', '2024-07-30 02:24:49'),
(2, 'Saad Sebar', 'route ain chekaf', 767984321, 'Saad@gmail.com', '', '2024-07-30 02:25:16', '2024-07-30 02:25:16'),
(3, 'Kamal Habib', 'route ain chekaf 2', 760085443, 'Habib@gmail.com', '', '2024-07-30 03:24:42', '2024-07-30 03:24:42'),
(4, 'Oussama Salhi', 'route ain chekaf', 767985445, 'oussama@gmail.com', '', '2024-07-30 04:09:12', '2024-07-30 04:09:12'),
(5, 'Hamza Rbati', 'route ain chekaf', 667980917, 'hamza@gmail.com', '', '2024-07-30 04:26:04', '2024-07-30 04:26:04'),
(6, 'Youssef Rami', 'route Triq mouzar', 654239512, 'yousseframi@gmail.com', '', '2024-09-10 22:32:34', '2024-09-10 22:32:34'),
(7, 'Haythame Benjeloune', 'route immouzar', 654239512, 'Haythameben@gmail.com', '', '2024-09-10 22:33:50', '2024-09-10 22:33:50');

-- --------------------------------------------------------

--
-- Structure de la table `breakdowns`
--

CREATE TABLE `breakdowns` (
  `Code` int NOT NULL,
  `Reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `DATE` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `EquipmentCode` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `breakdowns`
--

INSERT INTO `breakdowns` (`Code`, `Reason`, `DATE`, `createdAt`, `updatedAt`, `EquipmentCode`) VALUES
(61, 'L\'équipement peut ne pas fonctionner en raison d\'une défaillance du tube à rayons X ou d\'un problème d\'alimentation électrique.', '2024-09-11T09:00', '2024-09-10 23:20:38', '2024-09-10 23:20:38', 30),
(62, 'Un dysfonctionnement du détecteur d\'images ou d\'un problème avec le système de calibration.', '2024-07-12T15:35', '2024-09-10 23:22:53', '2024-09-10 23:22:53', 22),
(63, 'Une défaillance des capteurs de détection.', '2024-05-02T19:05', '2024-09-10 23:24:34', '2024-09-10 23:24:34', 18),
(64, 'Une erreur de calibration du système.', '2024-07-15T10:30', '2024-09-10 23:25:58', '2024-09-10 23:25:58', 35),
(65, 'Problème de connexion avec le système informatique.', '2024-09-06T20:00', '2024-09-10 23:27:42', '2024-09-10 23:27:42', 42),
(66, 'Pas encore trouve', '2024-03-08T00:27', '2024-09-10 23:28:45', '2024-09-10 23:28:45', 54),
(67, 'System failed ', '2024-02-13T16:00', '2024-09-10 23:30:29', '2024-09-10 23:30:29', 62);

-- --------------------------------------------------------

--
-- Structure de la table `clinicalenginners`
--

CREATE TABLE `clinicalenginners` (
  `DSSN` bigint NOT NULL,
  `FName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `LName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Phone` bigint NOT NULL,
  `Image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Age` int NOT NULL,
  `Email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Adress` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `WorkHours` int DEFAULT NULL,
  `Password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `DepartmentCode` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `clinicalenginners`
--

INSERT INTO `clinicalenginners` (`DSSN`, `FName`, `LName`, `Phone`, `Image`, `Age`, `Email`, `Adress`, `WorkHours`, `Password`, `createdAt`, `updatedAt`, `DepartmentCode`) VALUES
(234, 'Ali', 'Bouziane', 767985456, 'image_Layer 2.png', 21, 'ali@gmail.com', 'route ain chekaf', 8, '$2a$10$PngTMzg/ID/CKZWYAQENm.y40wRSeK3MgRylK1EMjMJxnGy4xJ1W2', '2024-07-30 03:32:59', '2024-07-30 03:32:59', 2),
(434, 'Youness', 'El faquir', 767984356, 'image_younnes.JPG', 20, 'youness@gmail.com', 'route ain chekaf', 8, '$2a$10$NNKl2BsRHlTuVJuxkJxFDOlY3NvJkNJ7ntT6WQo.f6GijO3qWpLyq', '2024-07-31 05:22:19', '2024-07-31 05:22:19', 3),
(456, 'Mohamed', 'Rami', 616347646, 'image_téléchargement (2).jpeg', 28, 'Mohammedrami12@gmail.com', 'Centre ville , Fès', 8, '$2a$10$ereS6tK2rQ0klAgLpBnaZuCwH9O2HElriMcpcSVKSaXbjFkZdCfhK', '2024-09-10 23:10:08', '2024-09-10 23:10:08', 6),
(546, 'Zineb ', 'Rahime', 734215678, 'image_Capture d’écran 2024-09-05 175436.png', 24, 'Zinebrahime@gmail.com', 'route ain chekaf 4', 8, '$2a$10$WoCLUJYLBY1CdVr5H1exhesaVvMVLnT/tziPOFLpRY3KcYCyR2mrC', '2024-09-10 23:03:29', '2024-09-10 23:06:05', 4),
(578, 'Elina ', 'Svitolina', 778644719, 'image_téléchargement (1).jpeg', 43, 'Elinasvil@gmail.com', 'route saiss', 6, '$2a$10$apuhFxQxqJXYWBKE8y74s.Taz.iCb6qEcBBqob3siDoYDssG6FsM.', '2024-09-10 23:08:06', '2024-09-10 23:08:06', 9),
(8795, 'Ayoub', 'Abbadi', 771844780, 'image_WhatsApp Image 2023-09-21 at 10.36.44 AM (1).jpeg', 22, 'Ayoubabbadi@gmail.com', 'route immouzar', 8, '$2a$10$SyZULDK2IrTrTx1deasHduzegf1yWDwt3Fbu89dkIi8uybO/3gNXa', '2024-09-10 22:57:42', '2024-09-10 22:57:42', 5);

-- --------------------------------------------------------

--
-- Structure de la table `dashboards`
--

CREATE TABLE `dashboards` (
  `Code` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `dashbords`
--

CREATE TABLE `dashbords` (
  `Code` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `MaintenanceId` int DEFAULT NULL,
  `DepartmentCode` int DEFAULT NULL,
  `WorkOrderCode` int DEFAULT NULL,
  `BreakdownCode` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `departmenthours`
--

CREATE TABLE `departmenthours` (
  `id` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `departments`
--

CREATE TABLE `departments` (
  `Code` int NOT NULL,
  `Name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `TotalHoursP` decimal(10,2) DEFAULT NULL,
  `Ponderation` decimal(10,2) DEFAULT NULL,
  `Trp` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `departments`
--

INSERT INTO `departments` (`Code`, `Name`, `Location`, `createdAt`, `updatedAt`, `TotalHoursP`, `Ponderation`, `Trp`) VALUES
(1, 'portiques magnétiques', 'FEZ_8_D_003/00', '2024-07-30 02:19:44', '2024-07-30 02:19:44', 0.00, 1.50, 100),
(2, 'scanners corporels ( Body scann)', 'FEZ_8_D_003/00', '2024-07-30 03:10:55', '2024-07-30 03:10:55', 0.00, 1.50, 100),
(3, 'Rayons x  bagages de soute', 'FEZ_8_D_003/00', '2024-07-30 03:22:10', '2024-07-30 03:22:10', 4.00, 1.50, 100),
(4, 'EDS 2', 'FEZ_8_D_003/00', '2024-07-30 04:08:30', '2024-07-30 04:08:30', 0.00, 1.00, 100),
(5, 'Rayon x FRET', 'FEZ_8_D_003/00', '2024-07-30 04:15:25', '2024-07-30 04:15:25', 0.00, 1.00, 100),
(6, 'EDS 3', 'FEZ_8_D_003/00', '2024-07-30 04:33:04', '2024-07-30 04:33:04', 0.00, 1.00, 100),
(7, 'Rayon x  bagage à main', 'FEZ_8_D_003/00', '2024-07-30 04:35:35', '2024-07-30 04:35:35', 1.00, 1.50, 100),
(8, 'Détecteur de trace', 'FEZ_8_D_003/00', '2024-07-30 04:44:25', '2024-07-30 04:44:25', 0.00, 1.50, 100),
(9, 'Détecteurs des explosifs liquide', 'FEZ_8_D_003/00', '2024-07-30 04:49:08', '2024-07-30 04:49:08', 0.00, 1.50, 100);

-- --------------------------------------------------------

--
-- Structure de la table `dialyinspections`
--

CREATE TABLE `dialyinspections` (
  `Code` int NOT NULL,
  `DATE` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Q1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Q2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Q3` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Q4` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Q5` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Q6` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Q7` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Q8` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `EquipmentCode` int DEFAULT NULL,
  `ClinicalEnginnerDSSN` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `dialyinspections`
--

INSERT INTO `dialyinspections` (`Code`, `DATE`, `Q1`, `Q2`, `Q3`, `Q4`, `Q5`, `Q6`, `Q7`, `Q8`, `createdAt`, `updatedAt`, `EquipmentCode`, `ClinicalEnginnerDSSN`) VALUES
(17, '2024-09-12T21:21', 'on', 'on', 'on', 'on', 'off', 'on', 'on', 'on', '2024-09-11 00:22:22', '2024-09-11 00:22:22', 26, 434),
(18, '2024-08-29T20:30', 'on', 'off', 'off', 'on', 'on', 'on', 'on', 'on', '2024-09-11 00:28:20', '2024-09-11 00:28:20', 36, 8795),
(19, '2024-09-02T09:30', 'on', 'on', 'off', 'on', 'off', 'on', 'on', 'on', '2024-09-11 00:30:05', '2024-09-11 00:30:05', 42, 8795),
(20, '2024-08-05T12:20', 'on', 'off', 'on', 'off', 'on', 'on', 'on', 'off', '2024-09-11 00:31:08', '2024-09-11 00:31:08', 25, 8795),
(21, '2024-09-03T10:30', 'off', 'on', 'off', 'on', 'on', 'off', 'off', 'off', '2024-09-11 00:35:43', '2024-09-11 00:35:43', 23, 234),
(22, '2024-09-10T12:45', 'on', 'on', 'on', 'on', 'off', 'on', 'off', 'off', '2024-09-11 00:45:37', '2024-09-11 00:45:37', 64, 578);

-- --------------------------------------------------------

--
-- Structure de la table `equipment`
--

CREATE TABLE `equipment` (
  `Code` int NOT NULL,
  `Name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Cost` bigint DEFAULT NULL,
  `Model` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `SerialNumber` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `InstallationDate` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `ArrivalDate` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `WarrantyDate` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `Manufacturer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `Location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `PM` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `AgentSupplierId` int DEFAULT NULL,
  `DepartmentCode` int DEFAULT NULL,
  `Eqcontrat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Observation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `equipment`
--

INSERT INTO `equipment` (`Code`, `Name`, `Image`, `Cost`, `Model`, `SerialNumber`, `InstallationDate`, `ArrivalDate`, `WarrantyDate`, `Manufacturer`, `Location`, `PM`, `Notes`, `createdAt`, `updatedAt`, `AgentSupplierId`, `DepartmentCode`, `Eqcontrat`, `Observation`) VALUES
(1, 'HI-PE/ PZPLUS', 'HI-PE-PLUS.jpg', 4300, '', '21606019055', '2016-10-13', '2024-07-30', '', 'CEIA', 'accès de SVC SS départ', 'Monthly', '', '2024-07-30 04:05:43', '2024-07-30 22:08:35', 1, 1, 'non couvert', ''),
(2, 'HI-PE/ PZPLUS', 'HI-PE-PLUS.jpg', 4300, NULL, '21606019054', '2016-10-13', '2024-07-30', NULL, 'CEIA', 'accès de service T2', 'Monthly', NULL, '2024-07-30 04:05:43', '2024-07-30 04:05:43', 1, 1, 'non couvert', NULL),
(3, 'Metor 300emd', 'Metor300emd.jfif', 4050, NULL, 'IK731766', '2015-05-28', '2024-07-30', NULL, 'rapiscan', 'PIF N1', 'Monthly', NULL, '2024-07-30 04:05:43', '2024-07-30 04:05:43', 1, 1, 'non couvert', NULL),
(4, 'Metor 300emd', 'Metor300emd.jfif', 4050, NULL, 'IK731758', '2015-05-28', '2024-07-30', NULL, 'rapiscan', 'PIF N2', 'Monthly', NULL, '2024-07-30 04:05:43', '2024-07-30 04:05:43', 1, 1, 'non couvert', NULL),
(5, 'Metor 300emd', 'Metor300emd.jfif', 4050, NULL, 'IK731765', '2015-05-28', '2024-07-30', NULL, 'rapiscan', 'PIF N3', 'Monthly', NULL, '2024-07-30 04:05:43', '2024-07-30 04:05:43', 1, 1, 'non couvert', NULL),
(6, 'Metor 300emd', 'Metor300emd.jfif', 4050, NULL, 'IK731764', '2015-05-28', '2024-07-30', NULL, 'rapiscan', 'PIF N4', 'Monthly', NULL, '2024-07-30 04:05:43', '2024-07-30 04:05:43', 1, 1, 'non couvert', NULL),
(7, 'Metor 300emd', 'Metor300emd.jfif', 4050, NULL, 'IK731762', '2015-05-28', '2024-07-30', NULL, 'rapiscan', 'PIF N5', 'Monthly', NULL, '2024-07-30 04:05:43', '2024-07-30 04:05:43', 1, 1, 'non couvert', NULL),
(8, 'Metor 300emd', 'Metor300emd.jfif', 4050, NULL, 'IK731763', '2015-05-28', '2024-07-30', NULL, 'rapiscan', 'data center', 'Monthly', NULL, '2024-07-30 04:05:43', '2024-07-30 04:05:43', 1, 1, 'non couvert', NULL),
(9, 'PD6500i', 'PD6500i.jfif', NULL, NULL, '51453064', '2011-01-01', '2024-07-30', NULL, 'GARETT', 'porte 4 PARIF', 'Monthly', NULL, '2024-07-30 04:05:43', '2024-07-30 04:05:43', 1, 1, 'non couvert', NULL),
(10, 'PD6500i', 'PD6500i.jfif', NULL, NULL, '51453029', '2011-01-01', '2024-07-30', NULL, 'GARETT', 'Trnasit T1', 'Monthly', NULL, '2024-07-30 04:05:43', '2024-07-30 04:05:43', 1, 1, 'non couvert', NULL),
(11, 'PD6500i', 'PD6500i.jfif', NULL, NULL, '51453030', '2011-01-01', '2024-07-30', NULL, 'GARETT', 'accès de SVC SS arrivée', 'Monthly', NULL, '2024-07-30 04:05:43', '2024-07-30 04:05:43', 1, 1, 'non couvert', NULL),
(12, 'PD6500i', 'PD6500i.jfif', NULL, NULL, '51453024', '2011-01-01', '2024-07-30', NULL, 'GARETT', 'transit T2', 'Monthly', NULL, '2024-07-30 04:05:43', '2024-07-30 04:05:43', 1, 1, 'non couvert', NULL),
(13, 'PD6500i', 'PD6500i.jfif', NULL, NULL, '51423625', '2011-01-01', '2024-07-30', NULL, 'GARETT', 'salon d\'honneur', 'Monthly', NULL, '2024-07-30 04:05:43', '2024-07-30 04:05:43', 1, 1, 'non couvert', NULL),
(14, 'PD6500i', 'PD6500i.jfif', NULL, NULL, '51453032', '2011-01-01', '2024-07-30', NULL, 'GARETT', 'entrée Aérogare', 'Monthly', NULL, '2024-07-30 04:05:43', '2024-07-30 04:05:43', 1, 1, 'non couvert', NULL),
(15, 'HI-PE/ PZPLUS', 'HI-PE-PLUS.jpg', NULL, NULL, '21206030072', '2013-05-14', '2024-07-30', NULL, 'CEIA', 'T1', 'Monthly', NULL, '2024-07-30 04:05:43', '2024-07-30 04:05:43', 1, 1, 'non couvert', NULL),
(16, 'PMD2', 'PMD2.jfif', NULL, NULL, NULL, '2004-12-01', '2024-07-30', NULL, 'CEIA', 'fret', 'Monthly', NULL, '2024-07-30 04:05:43', '2024-07-30 04:05:43', 1, 1, 'non couvert', NULL),
(17, 'PMD2', 'PMD2.jfif', NULL, NULL, NULL, '2004-12-01', '2024-07-30', NULL, 'CEIA', 'T0', 'Monthly', NULL, '2024-07-30 04:05:43', '2024-07-30 04:05:43', 1, 1, 'non couvert', NULL),
(18, 'PMD2', 'PMD2.jfif', NULL, NULL, NULL, '2004-12-01', '2024-07-30', NULL, 'CEIA', 'T0', 'Monthly', NULL, '2024-07-30 04:05:43', '2024-07-30 04:05:43', 1, 1, 'non couvert', 'degradé'),
(19, 'PMD2', 'PMD2.jfif', NULL, NULL, NULL, '2004-12-01', '2024-07-30', NULL, 'CEIA', 'T0', 'Monthly', NULL, '2024-07-30 04:05:43', '2024-07-30 04:05:43', 1, 1, 'non couvert', 'degradé'),
(20, 'PMD2', 'PMD2.jfif', NULL, NULL, NULL, '2004-12-01', '2024-07-30', NULL, 'CEIA', 'T0', 'Monthly', NULL, '2024-07-30 04:05:43', '2024-07-30 04:05:43', 1, 1, 'non couvert', 'degradé'),
(21, 'PMD2', 'PMD2.jfif', NULL, NULL, NULL, '2004-12-01', '2024-07-30', NULL, 'CEIA', 'T0', 'Monthly', NULL, '2024-07-30 04:05:43', '2024-07-30 04:05:43', 1, 1, 'non couvert', 'degradé'),
(22, 'Provision 2 C02-00004', 'Provision 2 C02-00004.jfif', 211459, NULL, 'PV-20228', '2015-07-12', '2024-01-01', NULL, 'L3-COM', 'PIF2', 'Monthly', NULL, '2024-01-01 00:00:00', '2024-01-01 00:00:00', 2, 2, 'non couvert', NULL),
(23, 'Provision 2 C02-00004', 'Provision 2 C02-00004.jfif', 211459, NULL, 'PV-20229', '2015-07-12', '2024-01-01', NULL, 'L3-COM', 'PIF4', 'Monthly', NULL, '2024-01-01 00:00:00', '2024-01-01 00:00:00', 2, 2, 'non couvert', 'HS'),
(24, '628 XR', '628 XR.jfif', 33711, NULL, '6143114', '2015-05-28', '2015-05-28', NULL, 'rapiscan', 'entrée Aérogare droite', 'Monthly', NULL, '2024-07-30 04:30:15', '2024-07-30 04:30:15', 3, 3, '065/20', NULL),
(25, '628 XR', '628 XR.jfif', 33711, NULL, '6143115', '2015-05-28', '2015-05-28', NULL, 'rapiscan', 'circuit rejet tri bag SS T2', 'Monthly', NULL, '2024-07-30 04:30:15', '2024-07-30 04:30:15', 3, 3, '065/20', NULL),
(26, '628 XR', '628 XR.jfif', 33711, NULL, '6143116', '2015-05-28', '2015-05-28', NULL, 'rapiscan', 'arrivé sous-sol 3', 'Monthly', NULL, '2024-07-30 04:30:15', '2024-07-30 04:30:15', 3, 3, '065/20 (en arrêt)', NULL),
(27, '628 XR', '628 XR.jfif', 33711, NULL, '6143112', '2015-05-28', '2015-05-28', NULL, 'rapiscan', 'arrivé sous-sol 2', 'Monthly', NULL, '2024-07-30 04:30:15', '2024-07-30 04:30:15', 3, 3, '065/20', NULL),
(28, '628 XR', '628 XR.jfif', 33711, NULL, '6143113', '2015-05-28', '2015-05-28', NULL, 'rapiscan', 'arrivé sous-sol 1', 'Monthly', NULL, '2024-07-30 04:30:15', '2024-07-30 04:30:15', 3, 3, '065/20', NULL),
(29, 'CX100100D', 'CX100100D.jfif', 42840, NULL, 'TFNAP-XIII-180332', '2018-11-09', '2018-11-09', NULL, 'Nuctech', 'entrée Aérogare gauche', 'Monthly', NULL, '2024-07-30 04:30:15', '2024-07-30 04:30:15', 3, 3, '097/22', 'MA 205/17'),
(30, 'CX100100D', 'CX100100D.jfif', 42840, NULL, 'TFNAP-XIII-180333', '2018-11-09', '2018-11-09', NULL, 'Nuctech', 'arrivée douane droite', 'Monthly', NULL, '2024-07-30 04:30:15', '2024-07-30 04:30:15', 3, 3, '097/22', 'MA 205/17'),
(31, '100100T', '100100T.jfif', NULL, NULL, '24895', '2002-10-30', '2002-10-30', NULL, 'Heimann', 'tri bagages T1', 'Monthly', NULL, '2024-07-30 04:30:15', '2024-07-30 04:30:15', 3, 3, NULL, 'reformé'),
(32, 'XIS100XD', 'XIS100XD.jfif', NULL, NULL, 'ASTHC160LLD51', '2009-06-07', '2009-06-07', NULL, 'Astrophysics', 'accès de service T1', 'Monthly', NULL, '2024-07-30 04:30:15', '2024-07-30 04:30:15', 3, 3, NULL, 'reformé'),
(33, 'MVXR 5000', 'MVXR 5000.jfif', 298993, NULL, '6150344', '2015-06-10', '2015-06-10', NULL, 'rapiscan', 'tri bagages sous-sol départ 1', 'Monthly', NULL, '2024-07-30 05:10:48', '2024-07-30 05:10:48', 4, 4, '065/20', NULL),
(34, 'MVXR 5000', 'MVXR 5000.jfif', 298993, NULL, '6150343', '2015-06-10', '2015-06-10', NULL, 'rapiscan', 'tri bagages sous-sol départ 2', 'Monthly', NULL, '2024-07-30 05:10:48', '2024-07-30 05:10:48', 4, 4, '065/20', NULL),
(35, 'MVXR 5000', 'MVXR 5000.jfif', NULL, NULL, '6103201', '2012-08-01', '2012-08-01', NULL, 'rapiscan', 'tri bagages T1', 'Monthly', NULL, '2024-07-30 05:10:48', '2024-07-30 05:10:48', 4, 4, '065/20 (en arrêt)', NULL),
(36, 'XIS-1818 DV', 'XIS-1818 DV.png', NULL, NULL, 'ASTQA200DVXX114', '2019-01-01', '2019-01-01', NULL, 'ASTROPHYSICS', 'Fret', 'Monthly', NULL, '2024-07-30 05:26:07', '2024-07-30 05:26:07', 5, 5, 'non couvert', 'MA 26/16'),
(37, '620 XR', '620 XR.jfif', 21000, NULL, '6142541', '2015-05-28', '2015-05-28', NULL, 'rapiscan', 'PIF N1', 'Monthly', NULL, '2024-07-30 05:41:49', '2024-07-30 05:41:49', 4, 7, '065/20', NULL),
(38, '620 XR', '620 XR.jfif', 21000, NULL, '6142816', '2015-05-28', '2015-05-28', NULL, 'rapiscan', 'PIF N2', 'Monthly', NULL, '2024-07-30 05:41:49', '2024-07-30 05:41:49', 4, 7, '065/20', NULL),
(39, '620 XR', '620 XR.jfif', 21000, NULL, '6142418', '2015-05-28', '2015-05-28', NULL, 'rapiscan', 'PIF N3', 'Monthly', NULL, '2024-07-30 05:41:49', '2024-07-30 05:41:49', 4, 7, '065/20', NULL),
(40, '620 XR', '620 XR.jfif', 21000, NULL, '6142540', '2015-05-28', '2015-05-28', NULL, 'rapiscan', 'PIF N4', 'Monthly', NULL, '2024-07-30 05:41:49', '2024-07-30 05:41:49', 4, 7, '065/20', NULL),
(41, '620 XR', '620 XR.jfif', 21000, NULL, '6142815', '2015-05-28', '2015-05-28', NULL, 'rapiscan', 'PIF N5', 'Monthly', NULL, '2024-07-30 05:41:49', '2024-07-30 05:41:49', 4, 7, '065/20', NULL),
(42, '620 XR', '620 XR.jfif', 21000, NULL, '6142417', '2015-05-28', '2015-05-28', NULL, 'rapiscan', 'accès de service T2', 'Monthly', NULL, '2024-07-30 05:41:49', '2024-07-30 05:41:49', 4, 7, '065/20', NULL),
(43, '620 XR', '620 XR.jfif', NULL, NULL, '61018P47', '2018-02-14', '2018-02-14', NULL, 'rapiscan', 'accès de SVC SS départ', 'Monthly', NULL, '2024-07-30 05:41:49', '2024-07-30 05:41:49', 4, 7, '065/20', 'récupéré de l\'Aéroport de Marrakech'),
(44, '620 XR', '620 XR.jfif', NULL, NULL, '61019P45', '2018-02-14', '2018-02-14', NULL, 'rapiscan', 'salon d\'honneur', 'Monthly', NULL, '2024-07-30 05:41:49', '2024-07-30 05:41:49', 4, 7, '065/20', 'récupéré de l\'Aéroport de Marrakech'),
(45, '6040I', '6040I.jpg', NULL, NULL, '115480', '2013-06-14', '2013-06-14', NULL, 'Heimann', 'arrivée douane 2', 'Monthly', NULL, '2024-07-30 05:41:49', '2024-07-30 05:41:49', 4, 7, NULL, NULL),
(46, '6040I', '6040I.jpg', NULL, NULL, '24482', '2002-10-30', '2002-10-30', NULL, 'Heimann', 'transit', 'Monthly', NULL, '2024-07-30 05:41:49', '2024-07-30 05:41:49', 4, 7, NULL, NULL),
(47, 'PX215M', NULL, NULL, NULL, 'PX2801', '2004-12-10', '2004-12-10', NULL, 'L3 communications', 'porte 4 PARIF', 'Monthly', NULL, '2024-07-30 05:41:49', '2024-07-30 05:41:49', 4, 7, NULL, 'dégradé'),
(48, 'PX215M', NULL, NULL, NULL, 'PX2876', '2004-12-10', '2004-12-10', NULL, 'L3 communications', 'accès de SVC SS arrivée', 'Monthly', NULL, '2024-07-30 05:41:49', '2024-07-30 05:41:49', 4, 7, NULL, 'reformé'),
(49, '620 XR', '620 XR.jfif', NULL, NULL, '61018P22', '2019-11-05', '2019-11-05', NULL, 'rapiscan', 'Transit T1', 'Monthly', NULL, '2024-07-30 05:41:49', '2024-07-30 05:41:49', 4, 7, '065/20 (en arrêt)', 'récupéré de l\'Aéroport Med V le /10/2019'),
(50, 'EN 5000', NULL, NULL, NULL, '201111142', '2013-02-01', '2013-02-01', NULL, 'SCINTREX trace', 'vetuste (HS)', 'Monthly', NULL, '2024-07-30 05:45:58', '2024-07-30 05:45:58', 1, 8, NULL, 'reformé'),
(51, 'QS-B220', 'QS-B220.jfif', 26150, NULL, '0616-B220-2812', '2016-11-09', '2016-11-09', NULL, 'Implant Sciences', 'SS tri Bagages', 'Monthly', NULL, '2024-07-30 05:45:58', '2024-07-30 05:45:58', 1, 8, 'MA-285/15', NULL),
(52, 'QS-B220', 'QS-B220.jfif', 26150, NULL, '0616-B220-2821', '2016-11-09', '2016-11-09', NULL, 'Implant Sciences', 'acces de service T2', 'Monthly', NULL, '2024-07-30 05:45:58', '2024-07-30 05:45:58', 1, 8, 'récupéré du Marrakech le 28/05/2017 MA-285/15', NULL),
(53, 'IONSCAN 600', 'IONSCAN 600.jfif', 21642, NULL, '69447', '2019-11-05', '2019-11-05', NULL, 'Smith Heimann', 'porte 4', 'Monthly', NULL, '2024-07-30 05:45:58', '2024-07-30 05:45:58', 1, 8, 'MA-287/18', NULL),
(54, 'IONSCAN 600', 'IONSCAN 600.jfif', 21642, NULL, '69453', '2019-11-05', '2019-11-05', NULL, 'Smith Heimann', 'fret', 'Monthly', NULL, '2024-07-30 05:45:58', '2024-07-30 05:45:58', 1, 8, 'MA-287/18', NULL),
(55, 'bionsens300', NULL, NULL, NULL, 'D120447', NULL, NULL, NULL, 'BIONSENSOR', 'ONDA-A,fes  201806658', 'Monthly', NULL, '2024-07-30 05:45:58', '2024-07-30 05:45:58', 1, 8, NULL, 'récupéré HS du CMN le 26/06/2018'),
(56, 'bionsens300', NULL, NULL, NULL, 'D120438', NULL, NULL, NULL, 'BIONSENSOR', 'ONDA-A,fes  201806657', 'Monthly', NULL, '2024-07-30 05:45:58', '2024-07-30 05:45:58', 1, 8, NULL, 'récupéré HS du CMN le 26/06/2018'),
(57, 'TR2000DC', 'TR2000DC.jfif', 18450, NULL, 'TFNBZ14 210380', '2022-04-01', '2022-04-01', NULL, 'NUCTECH', 'PIF 2', 'Monthly', NULL, '2024-07-30 05:45:58', '2024-07-30 05:45:58', 1, 8, NULL, NULL),
(58, 'TR2000DC', 'TR2000DC.jfif', 18450, NULL, 'TFNBZ14 210390', '2022-04-02', '2022-04-02', NULL, 'NUCTECH', 'PIF 4', 'Monthly', NULL, '2024-07-30 05:45:58', '2024-07-30 05:45:58', 1, 8, NULL, NULL),
(59, 'LS1516BA', 'LS1516BA.jfif', 33160, NULL, 'TFNBF-III-160009', '2016-08-30', '2016-08-30', NULL, 'Nuctech', 'accès de service T2', 'Monthly', NULL, '2024-07-30 05:50:15', '2024-07-30 05:50:15', 4, 9, '097/22', 'MA 363-15'),
(60, 'LS1516BA', 'LS1516BA.jfif', 33160, NULL, 'TFNBF-III-160011', '2016-08-30', '2016-08-30', NULL, 'Nuctech', 'PIF4', 'Monthly', NULL, '2024-07-30 05:50:15', '2024-07-30 05:50:15', 4, 9, '097/22', 'MA 363-15'),
(61, 'LS1516BA', 'LS1516BA.jfif', 33160, NULL, 'TFNBF-III-160013', '2016-08-30', '2016-08-30', NULL, 'Nuctech', 'accès de svc ss départ', 'Monthly', NULL, '2024-07-30 05:50:15', '2024-07-30 05:50:15', 4, 9, '097/22', 'MA 363-15'),
(62, 'LS1516BA', 'LS1516BA.jfif', 33160, NULL, 'TFNBF-III-160026', '2016-08-30', '2016-08-30', NULL, 'Nuctech', 'transit', 'Monthly', NULL, '2024-07-30 05:50:15', '2024-07-30 05:50:15', 4, 9, '097/22', 'MA 363-15'),
(63, 'EMA3', NULL, 20270, NULL, '21720003031', '2017-05-27', '2017-05-27', NULL, 'CEIA', 'PIF2', 'Monthly', NULL, '2024-07-30 05:50:15', '2024-07-30 05:50:15', 4, 9, 'non couvert', 'MA 190-16'),
(64, 'EMA3', NULL, 20270, NULL, '21720004001', '2017-05-27', '2017-05-27', NULL, 'CEIA', 'porte 4', 'Monthly', NULL, '2024-07-30 05:50:15', '2024-07-30 05:50:15', 4, 9, 'non couvert', 'MA 190-16');

-- --------------------------------------------------------

--
-- Structure de la table `maintenances`
--

CREATE TABLE `maintenances` (
  `Id` int NOT NULL,
  `StartDate` varchar(19) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `EndDate` varchar(19) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `BreakDownCode` int DEFAULT NULL,
  `ClinicalEnginnerDSSN` bigint DEFAULT NULL,
  `Duration` int DEFAULT NULL,
  `StartDateNoTime` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `EndDateNoTime` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `maintenances`
--

INSERT INTO `maintenances` (`Id`, `StartDate`, `EndDate`, `Description`, `createdAt`, `updatedAt`, `BreakDownCode`, `ClinicalEnginnerDSSN`, `Duration`, `StartDateNoTime`, `EndDateNoTime`) VALUES
(39, '2024-09-11T09:00', '2024-09-11T10:45', 'good , is done', '2024-09-11 00:06:54', '2024-09-11 00:06:54', 61, 434, NULL, '2024-09-11', '2024-09-11'),
(40, '2024-07-13T10:00', '2024-07-13T12:00', 'done', '2024-09-11 00:10:06', '2024-09-11 00:10:06', 62, 234, NULL, '2024-07-13', '2024-07-13'),
(41, '2024-05-03T09:00', '2024-05-03T14:30', 'ca marche ', '2024-09-11 00:11:55', '2024-09-11 00:11:55', 63, 8795, NULL, '2024-05-03', '2024-05-03'),
(42, '2024-07-15T16:00', '2024-07-15T18:00', 'good', '2024-09-11 00:13:08', '2024-09-11 00:13:08', 64, 546, NULL, '2024-07-15', '2024-07-15'),
(43, '2024-09-07T09:30', '2024-09-07T11:00', 'bien', '2024-09-11 00:15:09', '2024-09-11 00:15:09', 65, 434, NULL, '2024-09-07', '2024-09-07'),
(44, '2024-03-09T13:00', '2024-03-09T14:00', 'good', '2024-09-11 00:16:30', '2024-09-11 00:16:30', 66, 578, NULL, '2024-03-09', '2024-03-09'),
(45, '2024-02-14T12:00', '2024-02-14T13:30', 'good , is done', '2024-09-11 00:17:56', '2024-09-11 00:17:56', 67, 578, NULL, '2024-02-14', '2024-02-14');

-- --------------------------------------------------------

--
-- Structure de la table `ppmquestions`
--

CREATE TABLE `ppmquestions` (
  `Code` int NOT NULL,
  `Q1` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `Q2` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `Q3` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `Q4` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `Q5` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `EquipmentCode` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `ppmquestions`
--

INSERT INTO `ppmquestions` (`Code`, `Q1`, `Q2`, `Q3`, `Q4`, `Q5`, `createdAt`, `updatedAt`, `EquipmentCode`) VALUES
(16, 'Vérifiez si les connexions des composants sont correctement sécurisées.', 'Examinez les surfaces des unités pour tout dommage ou éraflure.', 'Vérifiez si toutes les pièces sont intactes lors du transport.', 'Contrôlez l’état des câbles et des connecteurs.', 'Assurez-vous que tous les dispositifs de sécurité mécanique sont en position prescrite.', '2024-07-31 06:03:09', '2024-07-31 06:03:09', 1),
(17, 'Assurez-vous que les connecteurs, les câbles patient et les palettes ne sont pas endommagés ni expirés.', 'Vérifiez que la carte mémoire est insérée et a une capacité suffisante.', 'Connectez l’appareil à une source d’alimentation externe et vérifiez l’indicateur correspondant.', 'Vérifiez que l’enregistreur a du papier et imprime correctement.', 'Assurez-vous que la batterie est chargée et sans signe de dommage.', '2024-07-31 06:03:09', '2024-07-31 06:03:09', 2),
(18, 'Assurez-vous que les connecteurs, les câbles patient et les palettes ne sont pas endommagés ni expirés.', 'Vérifiez que la carte mémoire est insérée et a une capacité suffisante.', 'Connectez l’appareil à une source d’alimentation externe et vérifiez l’indicateur correspondant.', 'Vérifiez que l’enregistreur a du papier et imprime correctement.', 'Assurez-vous que la batterie est chargée et sans signe de dommage.', '2024-07-31 06:03:09', '2024-07-31 06:03:09', 3),
(19, 'Vérifiez le cordon d’alimentation chaque fois que le générateur est utilisé.', 'Vérifiez le courant de fuite haute fréquence monopolaire et bipolaire.', 'Vérifiez la sortie des modes de coupe.', 'Vérifiez la sortie des modes de coagulation.', 'Vérifiez les fusibles pour savoir s’ils doivent être remplacés si le générateur cesse de fonctionner.', '2024-07-31 06:03:09', '2024-07-31 06:03:09', 4),
(20, 'Vérifiez le cordon d’alimentation chaque fois que le générateur est utilisé.', 'Vérifiez le courant de fuite haute fréquence monopolaire et bipolaire.', 'Vérifiez la sortie des modes de coupe.', 'Vérifiez la sortie des modes de coagulation.', 'Vérifiez les fusibles pour savoir s’ils doivent être remplacés si le générateur cesse de fonctionner.', '2024-07-31 06:03:09', '2024-07-31 06:03:09', 5),
(21, 'Vérifiez le fonctionnement du ventilateur au plafond du gantry.', 'Assurez-vous que l’unité rotative est correctement fixée.', 'Vérifiez la tension d’alimentation CC du console.', 'Recherchez toute interférence dans les câbles à l’intérieur du canapé.', 'Lubrifiez le mécanisme de mouvement vertical du canapé.', '2024-07-31 06:03:09', '2024-07-31 06:03:09', 6),
(22, 'Vérifiez le fonctionnement du ventilateur au plafond du gantry.', 'Assurez-vous que l’unité rotative est correctement fixée.', 'Vérifiez la tension d’alimentation CC du console.', 'Recherchez toute interférence dans les câbles à l’intérieur du canapé.', 'Lubrifiez le mécanisme de mouvement vertical du canapé.', '2024-07-31 06:03:09', '2024-07-31 06:03:09', 7),
(23, 'Vérifiez la couche de valeur à moitié (HVL) du tube.', 'Vérifiez l’épaisseur du sein mesurée du gantry.', 'Vérifiez la collimation correcte.', 'Vérifiez les boutons d’arrêt d’urgence du gantry.', 'Vérifiez l’imprimante DICOM.', '2024-07-31 06:03:09', '2024-07-31 06:03:09', 8),
(24, 'Inspectez et ajustez la puissance de sortie radiofréquence (RF).', 'Inspectez l’étalonnage des gradients.', 'Effectuez un test de surface de bobine rotative.', 'Vérifiez le fonctionnement des ventilateurs du poste de travail, des prises et de l’écran.', 'Effectuez un test du rapport signal/bruit (SNR) du casque.', '2024-07-31 06:03:09', '2024-07-31 06:03:09', 9),
(25, 'Vérifiez la fonction du mélangeur d’oxygène.', 'Vérifiez l’absence de fuites.', 'Vérifiez l’alarme de basse pression/apnée.', 'Vérifiez l’alarme de l’approvisionnement en gaz.', 'Vérifiez l’alarme de défaillance d’alimentation.', '2024-07-31 06:03:09', '2024-07-31 06:03:09', 10),
(26, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-07-31 06:03:09', '2024-07-31 06:03:09', 11),
(27, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-07-31 06:03:09', '2024-07-31 06:03:09', 12),
(28, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-07-31 06:03:09', '2024-07-31 06:03:09', 13),
(29, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-07-31 06:03:09', '2024-07-31 06:03:09', 14),
(30, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-07-31 06:03:09', '2024-07-31 06:03:09', 15),
(31, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 16),
(32, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 17),
(33, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 18),
(34, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 19),
(35, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 20),
(36, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 21),
(37, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 22),
(38, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 23),
(39, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 24),
(40, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 25),
(41, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 26),
(42, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 27),
(43, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 28),
(44, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 29),
(45, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 30),
(46, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 31),
(47, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 32),
(48, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 33),
(49, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 34),
(50, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 35),
(51, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 36),
(52, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 37),
(53, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 38),
(54, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 39),
(55, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 40),
(56, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 41),
(57, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 42),
(58, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 43),
(59, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 44),
(60, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 45),
(61, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 46),
(62, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 47),
(63, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 48),
(64, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:54:16', '2024-09-04 18:54:16', 49),
(65, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:56:49', '2024-09-04 18:56:49', 50),
(66, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:56:49', '2024-09-04 18:56:49', 51),
(67, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:56:49', '2024-09-04 18:56:49', 52),
(68, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:56:49', '2024-09-04 18:56:49', 53),
(69, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:56:49', '2024-09-04 18:56:49', 54),
(70, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:56:49', '2024-09-04 18:56:49', 55),
(71, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:56:49', '2024-09-04 18:56:49', 56),
(72, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:56:49', '2024-09-04 18:56:49', 57),
(73, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:56:49', '2024-09-04 18:56:49', 58),
(74, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:56:49', '2024-09-04 18:56:49', 59),
(75, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:56:49', '2024-09-04 18:56:49', 60),
(76, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:56:49', '2024-09-04 18:56:49', 61),
(77, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:56:49', '2024-09-04 18:56:49', 62),
(78, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:56:49', '2024-09-04 18:56:49', 63),
(79, 'Vérifiez le taux d’infusion.', 'Vérifiez l’alarme de porte ouverte.', 'Vérifiez l’alarme d’occlusion.', 'Vérifiez l’alarme d’air dans la ligne.', 'Vérifiez le capteur de débit.', '2024-09-04 18:56:49', '2024-09-04 18:56:49', 64);

-- --------------------------------------------------------

--
-- Structure de la table `ppms`
--

CREATE TABLE `ppms` (
  `Code` int NOT NULL,
  `DATE` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Q1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Q2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Q3` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Q4` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Q5` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `N1` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `N2` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `N3` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `N4` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `N5` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `EquipmentCode` int DEFAULT NULL,
  `ClinicalEnginnerDSSN` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `ppms`
--

INSERT INTO `ppms` (`Code`, `DATE`, `Q1`, `Q2`, `Q3`, `Q4`, `Q5`, `N1`, `N2`, `N3`, `N4`, `N5`, `createdAt`, `updatedAt`, `EquipmentCode`, `ClinicalEnginnerDSSN`) VALUES
(9, '2024-09-07', 'on', 'on', 'on', 'on', 'on', '', '', '', '', '', '2024-09-11 00:19:57', '2024-09-11 00:19:57', 42, 434),
(10, '0024-09-11', 'on', 'off', 'on', 'on', 'on', '', '', '', '', '', '2024-09-11 00:25:36', '2024-09-11 00:25:36', 30, 434),
(11, '2024-05-03', 'on', 'on', 'on', 'on', 'on', '', '', '', '', '', '2024-09-11 00:27:47', '2024-09-11 00:27:47', 18, 8795),
(12, '2024-07-13', 'on', 'on', 'on', 'on', 'on', '', '', '', '', '', '2024-09-11 00:36:47', '2024-09-11 00:36:47', 22, 234),
(13, '2024-03-09', 'on', 'off', 'on', 'on', 'on', '', '', '', '', '', '2024-09-11 00:44:29', '2024-09-11 00:44:29', 54, 578),
(14, '2024-02-14', 'on', 'on', 'on', 'on', 'on', '', '', '', '', '', '2024-09-11 00:45:04', '2024-09-11 00:45:04', 62, 578);

-- --------------------------------------------------------

--
-- Structure de la table `workorders`
--

CREATE TABLE `workorders` (
  `Code` int NOT NULL,
  `StartDate` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `EndDate` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Cost` int NOT NULL,
  `Priority` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `ClinicalEnginnerDSSN` bigint DEFAULT NULL,
  `EquipmentCode` int DEFAULT NULL,
  `AdditionalStartDate` datetime DEFAULT NULL,
  `AdditionalEndDate` datetime DEFAULT NULL,
  `Duration` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `workorders`
--

INSERT INTO `workorders` (`Code`, `StartDate`, `EndDate`, `Description`, `Cost`, `Priority`, `createdAt`, `updatedAt`, `ClinicalEnginnerDSSN`, `EquipmentCode`, `AdditionalStartDate`, `AdditionalEndDate`, `Duration`) VALUES
(50, '2024-09-11', '2024-09-11', 'urgent', 4000, 'High', '2024-09-10 23:40:31', '2024-09-10 23:40:31', 434, 30, '2024-09-11 08:00:00', '2024-09-11 09:00:00', NULL),
(51, '2024-07-13', '2024-07-13', 'urgent', 3000, 'High', '2024-09-10 23:43:20', '2024-09-11 00:02:31', 234, 22, '2024-07-13 09:00:00', '2024-07-13 11:00:00', NULL),
(52, '2024-05-03', '2024-05-03', 'urgent', 12000, 'High', '2024-09-10 23:45:52', '2024-09-10 23:45:52', 8795, 18, '2024-05-03 08:00:00', '2024-05-03 12:00:00', NULL),
(53, '2024-07-15', '2024-07-15', 'urgent', 4000, 'Medium', '2024-09-10 23:48:42', '2024-09-10 23:48:42', 546, 35, '2024-07-15 15:00:00', '2024-07-15 17:00:00', NULL),
(54, '2024-09-07', '2024-09-07', 'urgent', 2000, 'Low', '2024-09-10 23:52:05', '2024-09-10 23:52:05', 434, 42, '2024-09-07 08:30:00', '2024-09-07 10:00:00', NULL),
(55, '2024-03-09', '2024-03-09', 'urgent', 4000, 'High', '2024-09-10 23:55:21', '2024-09-10 23:55:21', 578, 54, '2024-03-09 12:00:00', '2024-03-09 13:00:00', NULL),
(56, '2024-02-14', '2024-02-14', 'urgent', 6000, 'High', '2024-09-10 23:58:18', '2024-09-10 23:58:18', 578, 62, '2024-02-14 11:00:00', '2024-02-14 12:00:00', NULL);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `agentsuppliers`
--
ALTER TABLE `agentsuppliers`
  ADD PRIMARY KEY (`Id`);

--
-- Index pour la table `breakdowns`
--
ALTER TABLE `breakdowns`
  ADD PRIMARY KEY (`Code`),
  ADD KEY `EquipmentCode` (`EquipmentCode`);

--
-- Index pour la table `clinicalenginners`
--
ALTER TABLE `clinicalenginners`
  ADD PRIMARY KEY (`DSSN`),
  ADD KEY `DepartmentCode` (`DepartmentCode`);

--
-- Index pour la table `dashboards`
--
ALTER TABLE `dashboards`
  ADD PRIMARY KEY (`Code`);

--
-- Index pour la table `dashbords`
--
ALTER TABLE `dashbords`
  ADD PRIMARY KEY (`Code`),
  ADD KEY `tbmti_fk_maintenance` (`MaintenanceId`),
  ADD KEY `dashbords_ibfk_1` (`DepartmentCode`),
  ADD KEY `dashbords_ibfk_3` (`WorkOrderCode`),
  ADD KEY `dashbords_ibfk_4` (`BreakdownCode`);

--
-- Index pour la table `departmenthours`
--
ALTER TABLE `departmenthours`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`Code`),
  ADD UNIQUE KEY `Code` (`Code`),
  ADD UNIQUE KEY `Name` (`Name`);

--
-- Index pour la table `dialyinspections`
--
ALTER TABLE `dialyinspections`
  ADD PRIMARY KEY (`Code`),
  ADD KEY `EquipmentCode` (`EquipmentCode`),
  ADD KEY `ClinicalEnginnerDSSN` (`ClinicalEnginnerDSSN`);

--
-- Index pour la table `equipment`
--
ALTER TABLE `equipment`
  ADD PRIMARY KEY (`Code`),
  ADD KEY `AgentSupplierId` (`AgentSupplierId`),
  ADD KEY `DepartmentCode` (`DepartmentCode`);

--
-- Index pour la table `maintenances`
--
ALTER TABLE `maintenances`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `BreakDownCode` (`BreakDownCode`),
  ADD KEY `ClinicalEnginnerDSSN` (`ClinicalEnginnerDSSN`);

--
-- Index pour la table `ppmquestions`
--
ALTER TABLE `ppmquestions`
  ADD PRIMARY KEY (`Code`),
  ADD KEY `EquipmentCode` (`EquipmentCode`);

--
-- Index pour la table `ppms`
--
ALTER TABLE `ppms`
  ADD PRIMARY KEY (`Code`),
  ADD KEY `EquipmentCode` (`EquipmentCode`),
  ADD KEY `ClinicalEnginnerDSSN` (`ClinicalEnginnerDSSN`);

--
-- Index pour la table `workorders`
--
ALTER TABLE `workorders`
  ADD PRIMARY KEY (`Code`),
  ADD KEY `ClinicalEnginnerDSSN` (`ClinicalEnginnerDSSN`),
  ADD KEY `EquipmentCode` (`EquipmentCode`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `agentsuppliers`
--
ALTER TABLE `agentsuppliers`
  MODIFY `Id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11131;

--
-- AUTO_INCREMENT pour la table `breakdowns`
--
ALTER TABLE `breakdowns`
  MODIFY `Code` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT pour la table `dashboards`
--
ALTER TABLE `dashboards`
  MODIFY `Code` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `dashbords`
--
ALTER TABLE `dashbords`
  MODIFY `Code` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pour la table `departmenthours`
--
ALTER TABLE `departmenthours`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `dialyinspections`
--
ALTER TABLE `dialyinspections`
  MODIFY `Code` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT pour la table `maintenances`
--
ALTER TABLE `maintenances`
  MODIFY `Id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT pour la table `ppmquestions`
--
ALTER TABLE `ppmquestions`
  MODIFY `Code` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT pour la table `ppms`
--
ALTER TABLE `ppms`
  MODIFY `Code` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pour la table `workorders`
--
ALTER TABLE `workorders`
  MODIFY `Code` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `breakdowns`
--
ALTER TABLE `breakdowns`
  ADD CONSTRAINT `breakdowns_ibfk_1` FOREIGN KEY (`EquipmentCode`) REFERENCES `equipment` (`Code`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `clinicalenginners`
--
ALTER TABLE `clinicalenginners`
  ADD CONSTRAINT `clinicalenginners_ibfk_1` FOREIGN KEY (`DepartmentCode`) REFERENCES `departments` (`Code`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `dashbords`
--
ALTER TABLE `dashbords`
  ADD CONSTRAINT `dashbords_ibfk_1` FOREIGN KEY (`DepartmentCode`) REFERENCES `departments` (`Code`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `dashbords_ibfk_3` FOREIGN KEY (`WorkOrderCode`) REFERENCES `workorders` (`Code`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `dashbords_ibfk_4` FOREIGN KEY (`BreakdownCode`) REFERENCES `breakdowns` (`Code`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tbmti_fk_maintenance` FOREIGN KEY (`MaintenanceId`) REFERENCES `maintenances` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `dialyinspections`
--
ALTER TABLE `dialyinspections`
  ADD CONSTRAINT `dialyinspections_ibfk_1` FOREIGN KEY (`EquipmentCode`) REFERENCES `equipment` (`Code`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `dialyinspections_ibfk_2` FOREIGN KEY (`ClinicalEnginnerDSSN`) REFERENCES `clinicalenginners` (`DSSN`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `equipment`
--
ALTER TABLE `equipment`
  ADD CONSTRAINT `equipment_ibfk_1` FOREIGN KEY (`AgentSupplierId`) REFERENCES `agentsuppliers` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `equipment_ibfk_2` FOREIGN KEY (`DepartmentCode`) REFERENCES `departments` (`Code`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `maintenances`
--
ALTER TABLE `maintenances`
  ADD CONSTRAINT `maintenances_ibfk_1` FOREIGN KEY (`BreakDownCode`) REFERENCES `breakdowns` (`Code`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `maintenances_ibfk_2` FOREIGN KEY (`ClinicalEnginnerDSSN`) REFERENCES `clinicalenginners` (`DSSN`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `ppmquestions`
--
ALTER TABLE `ppmquestions`
  ADD CONSTRAINT `ppmquestions_ibfk_1` FOREIGN KEY (`EquipmentCode`) REFERENCES `equipment` (`Code`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `ppms`
--
ALTER TABLE `ppms`
  ADD CONSTRAINT `ppms_ibfk_1` FOREIGN KEY (`EquipmentCode`) REFERENCES `equipment` (`Code`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ppms_ibfk_2` FOREIGN KEY (`ClinicalEnginnerDSSN`) REFERENCES `clinicalenginners` (`DSSN`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `workorders`
--
ALTER TABLE `workorders`
  ADD CONSTRAINT `workorders_ibfk_1` FOREIGN KEY (`ClinicalEnginnerDSSN`) REFERENCES `clinicalenginners` (`DSSN`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `workorders_ibfk_2` FOREIGN KEY (`EquipmentCode`) REFERENCES `equipment` (`Code`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
