CREATE TABLE IF NOT EXISTS `owned_vehicles` (
  `vehicle` longtext NOT NULL,
  `owner` varchar(60) DEFAULT NULL,
  `stored` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'State of the vehicle',
  `pound` tinyint(1) NOT NULL DEFAULT 0,
  `vehiclename` varchar(50) NOT NULL DEFAULT 'Veicolo Nuovo',
  `modelname` varchar(50) NOT NULL DEFAULT 'Veicolo Nuovo',
  `proprietario` varchar(50) NOT NULL DEFAULT 'Nome Proprietario',
  `plate` varchar(50) NOT NULL,
  `type` varchar(10) NOT NULL DEFAULT 'car',
  `job` varchar(50) DEFAULT NULL,
  `garage` varchar(200) DEFAULT 'A',
  `storedhouse` int(11) NOT NULL,
  `impound` tinyint(1) NOT NULL DEFAULT 0,
  `trunk` longtext DEFAULT NULL,
  `glovebox` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
