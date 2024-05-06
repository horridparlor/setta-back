CREATE TABLE `expansion` (
                             `id` int(11) NOT NULL,
                             `name` varchar(32) NOT NULL,
                             `releaseYear` int(11) NOT NULL DEFAULT 2024,
                             `isReleased` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO `expansion` (`id`, `name`, `releaseYear`, `isReleased`) VALUES
    (1, 'Set 1', 2023, 1),
    (2, 'Mini 1', 2024, 1),
    (3, 'Mini 2', 2024, 1),
    (4, 'Mini 3', 2024, 1),
    (5, 'Mini 4', 2024, 1),
    (6, 'Mini 5', 2024, 1),
    (7, 'Set 2', 2024, 1);

ALTER TABLE `expansion`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

ALTER TABLE `expansion`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;