-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : db
-- Généré le : lun. 24 oct. 2022 à 14:44
-- Version du serveur : 8.0.31
-- Version de PHP : 8.0.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `Binômotron`
--

-- --------------------------------------------------------

--
-- Structure de la table `date_groupe`
--

CREATE TABLE `date_groupe` (
  `id_groupe` int NOT NULL,
  `libelle_groupe` varchar(50) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `groupe`
--

CREATE TABLE `groupe` (
  `id_personne` int NOT NULL,
  `id_groupe` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `personnes`
--

CREATE TABLE `personnes` (
  `id_personne` int NOT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `adresse_mail` varchar(50) NOT NULL,
  `id_xp` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `personnes`
--

INSERT INTO `personnes` (`id_personne`, `nom`, `prenom`, `adresse_mail`, `id_xp`) VALUES
(1, 'LE GRAND', 'Kevin', 'kevin.le-grand@isen-ouest.yncrea.fr', 1),
(2, 'PETIARD', 'Harold', 'harold.petiard@isen-ouest.yncrea.fr', 1),
(3, 'SCANU', 'David', 'david.scanu@isen-ouest.yncrea.fr', 1),
(4, 'ANCELIN', 'Antoine', 'antoine.ancelin@isen-ouest.yncrea.fr', 1),
(5, 'JOURNAUX', 'Johann', 'johann.journaux@isen-ouest.yncrea.fr', 1),
(6, 'LEBARBIER', 'Charley', 'charley.lebarbier@isen-ouest.yncrea.fr', 1),
(7, 'DIABY', 'Amadou', 'amadou.diaby@isen-ouest.yncrea.fr', 1),
(8, 'DAUMER', 'Geoffroy', 'geoffroy.daumer@isen-ouest.yncrea.fr', 1),
(9, 'JULES', 'Dimitri', 'dimitri.jules@isen-ouest.yncrea.fr', 1),
(10, 'GUERIN', 'Basile', 'basile.guerin@isen-ouest.yncrea.fr', 1),
(11, 'OSWALD', 'Viacheslav', 'viacheslav.oswald@isen-ouest.yncrea.fr', 1),
(12, 'DUSSART', 'Ramata Soraya', 'ramata-soraya.dussart@isen-ouest.yncrea.fr', 1),
(13, 'ZOUITEN', 'Guinel', 'guinel.zouiten@isen-ouest.yncrea.fr', 1);

-- --------------------------------------------------------

--
-- Structure de la table `xp`
--

CREATE TABLE `xp` (
  `id_xp` int NOT NULL,
  `level_xp` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `xp`
--

INSERT INTO `xp` (`id_xp`, `level_xp`) VALUES
(1, 'debutant'),
(2, 'intermediaire'),
(3, 'expert');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `date_groupe`
--
ALTER TABLE `date_groupe`
  ADD PRIMARY KEY (`id_groupe`);

--
-- Index pour la table `groupe`
--
ALTER TABLE `groupe`
  ADD KEY `id_groupe` (`id_groupe`),
  ADD KEY `id_personne` (`id_personne`);

--
-- Index pour la table `personnes`
--
ALTER TABLE `personnes`
  ADD PRIMARY KEY (`id_personne`),
  ADD KEY `id_xp` (`id_xp`);

--
-- Index pour la table `xp`
--
ALTER TABLE `xp`
  ADD PRIMARY KEY (`id_xp`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `date_groupe`
--
ALTER TABLE `date_groupe`
  MODIFY `id_groupe` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `personnes`
--
ALTER TABLE `personnes`
  MODIFY `id_personne` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `xp`
--
ALTER TABLE `xp`
  MODIFY `id_xp` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `groupe`
--
ALTER TABLE `groupe`
  ADD CONSTRAINT `groupe_ibfk_1` FOREIGN KEY (`id_groupe`) REFERENCES `date_groupe` (`id_groupe`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `groupe_ibfk_2` FOREIGN KEY (`id_personne`) REFERENCES `personnes` (`id_personne`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `personnes`
--
ALTER TABLE `personnes`
  ADD CONSTRAINT `personnes_ibfk_1` FOREIGN KEY (`id_xp`) REFERENCES `xp` (`id_xp`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
