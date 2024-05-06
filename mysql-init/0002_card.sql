CREATE TABLE `card` (
                        `id` int(11) NOT NULL,
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
                        `expansionId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

ALTER TABLE `card`
    ADD PRIMARY KEY (`id`),
    ADD KEY `primaryMaterialId` (`primaryMaterialId`),
    ADD KEY `secondaryMaterialId` (`secondaryMaterialId`),
    ADD KEY `tertiaryMaterialId` (`tertiaryMaterialId`),
    ADD KEY `countsAsId` (`countsAsId`),
    ADD KEY `expansionId` (`expansionId`);

ALTER TABLE `card`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

ALTER TABLE `card`
    ADD CONSTRAINT `card_ibfk_1` FOREIGN KEY (`primaryMaterialId`) REFERENCES `card` (`id`),
    ADD CONSTRAINT `card_ibfk_2` FOREIGN KEY (`secondaryMaterialId`) REFERENCES `card` (`id`),
    ADD CONSTRAINT `card_ibfk_3` FOREIGN KEY (`tertiaryMaterialId`) REFERENCES `card` (`id`),
    ADD CONSTRAINT `card_ibfk_4` FOREIGN KEY (`countsAsId`) REFERENCES `card` (`id`),
    ADD CONSTRAINT `card_ibfk_5` FOREIGN KEY (`expansionId`) REFERENCES `expansion` (`id`);
COMMIT;