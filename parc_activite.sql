-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:8889
-- Généré le : dim. 07 déc. 2025 à 23:01
-- Version du serveur : 5.7.44
-- Version de PHP : 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `parc_activite`
--

-- --------------------------------------------------------

--
-- Structure de la table `activities`
--

CREATE TABLE `activities` (
  `id` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `type_id` int(11) NOT NULL,
  `places_disponibles` int(11) NOT NULL,
  `description` text,
  `datetime_debut` datetime NOT NULL,
  `duree` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `activities`
--

INSERT INTO `activities` (`id`, `nom`, `type_id`, `places_disponibles`, `description`, `datetime_debut`, `duree`) VALUES
(1, 'Accrobranche', 1, 20, 'Parcours aventure dans les arbres pour tous niveaux.', '2025-12-10 09:00:00', 120),
(2, 'Laser Game', 2, 12, 'Affrontez vos amis dans un labyrinthe futuriste.', '2025-12-10 14:00:00', 60),
(3, 'Escape Game - Le Trésor du Pirate', 3, 8, 'Résolvez les énigmes pour retrouver le trésor perdu.', '2025-12-11 10:00:00', 60),
(4, 'Karting Électrique', 4, 10, 'Course sur circuit intérieur, sensations fortes garanties.', '2025-12-11 15:00:00', 30),
(5, 'Mini-Golf Tropical', 5, 15, 'Parcours 18 trous dans un décor exotique.', '2025-12-12 10:00:00', 45),
(6, 'Bowling 6 pistes', 6, 24, 'Parties de bowling modernes avec scoring automatique.', '2025-12-12 14:00:00', 90),
(7, 'Tir a l\'arc', 7, 10, 'Initiation et perfectionnement au tir à l’arc.', '2025-12-13 09:30:00', 60),
(8, 'Réalité Virtuelle VR Arena', 8, 8, 'Plongez dans des mondes 3D interactifs.', '2025-12-13 13:00:00', 45),
(9, 'Trampoline Park', 9, 20, 'Zones de sauts, bacs à mousse et parcours Ninja.', '2025-12-14 10:00:00', 90),
(10, 'Atelier Potion Magique', 10, 12, 'Création de potions fumantes pour les enfants.', '2025-12-14 14:00:00', 60);

-- --------------------------------------------------------

--
-- Structure de la table `reservations`
--

CREATE TABLE `reservations` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `activite_id` int(11) NOT NULL,
  `date_reservation` datetime DEFAULT CURRENT_TIMESTAMP,
  `etat` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `type_activite`
--

CREATE TABLE `type_activite` (
  `id` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `type_activite`
--

INSERT INTO `type_activite` (`id`, `nom`) VALUES
(1, 'Aventure'),
(2, 'Jeu'),
(3, 'Escape Game'),
(4, 'Karting'),
(5, 'Mini-Golf'),
(6, 'Bowling'),
(7, 'Tir'),
(8, 'VR'),
(9, 'Trampoline'),
(10, 'Atelier');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `motdepasse` varchar(255) NOT NULL,
  `role` enum('user','admin') DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `activities`
--
ALTER TABLE `activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type_id` (`type_id`);

--
-- Index pour la table `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `activite_id` (`activite_id`);

--
-- Index pour la table `type_activite`
--
ALTER TABLE `type_activite`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `activities`
--
ALTER TABLE `activities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `reservations`
--
ALTER TABLE `reservations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `type_activite`
--
ALTER TABLE `type_activite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `activities`
--
ALTER TABLE `activities`
  ADD CONSTRAINT `activities_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `type_activite` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reservations_ibfk_2` FOREIGN KEY (`activite_id`) REFERENCES `activities` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
