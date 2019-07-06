-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 07 Tem 2019, 01:35:42
-- Sunucu sürümü: 10.1.38-MariaDB
-- PHP Sürümü: 7.3.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `webservice`
--
CREATE DATABASE IF NOT EXISTS `webservice` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `webservice`;

DELIMITER $$
--
-- İşlevler
--
DROP FUNCTION IF EXISTS `generateToken`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `generateToken` (`_username` VARCHAR(45), `_userkey` VARCHAR(45)) RETURNS VARCHAR(45) CHARSET latin1 BEGIN
	SET SQL_SAFE_UPDATES=0;
    UPDATE user 
	SET 
		token = (select SHA1((SELECT CONCAT(_username, NOW(), 'asdzxcxf'))) _token) ,
		validtime = (select (NOW() + INTERVAL 60 MINUTE) _validtime)
	WHERE
		username = _username
			AND userkey = _userkey;
	SET SQL_SAFE_UPDATES=1;
RETURN (select token from user where username=_username and userkey=_userkey);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `log`
--

DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
  `if` int(11) NOT NULL,
  `username` varchar(45) DEFAULT NULL,
  `function` varchar(45) DEFAULT NULL,
  `requestdata` text,
  `responsedata` text,
  `timestamp` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `log`
--

INSERT INTO `log` (`if`, `username`, `function`, `requestdata`, `responsedata`, `timestamp`) VALUES
(1, 'python', 'insert', '{\"token\": \"92603740e66367aa211aa4d1032b0b17b3103ea8\", \"product_code\": \"ffff\", \"product_desc\": \"bla bla bla\", \"price\": 10, \"stock\": 3}', 'Insert Proccess success', '2019-07-07 00:58:12'),
(2, 'python', 'update', '{\"token\": \"92603740e66367aa211aa4d1032b0b17b3103ea8\", \"product_code\": \"cccc\", \"product_desc\": \"bla bla bla\", \"price\": 40, \"stock\": 10}', 'Insert Proccess success', '2019-07-07 01:01:29'),
(3, 'python', 'update', '{\"token\": \"92603740e66367aa211aa4d1032b0b17b3103ea8\", \"product_code\": \"cccc\", \"product_desc\": \"bla bla bla\", \"price\": 40, \"stock\": 10}', 'Update Proccess success', '2019-07-07 01:02:10'),
(4, 'python', 'update', '{\"token\": \"92603740e66367aa211aa4d1032b0b17b3103ea8\", \"product_code\": \"xxxxx\"}', 'Delete Proccess success', '2019-07-07 01:02:38');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `username` varchar(45) DEFAULT NULL,
  `product_code` varchar(45) DEFAULT NULL,
  `product_desc` varchar(45) DEFAULT NULL,
  `price` decimal(11,0) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `product`
--

INSERT INTO `product` (`id`, `username`, `product_code`, `product_desc`, `price`, `stock`) VALUES
(1, 'python', 'aaaa', 'vdfgfdghfgj', '13', 5),
(2, 'python', 'bbbb', 'dsfdsfv', '5', 6),
(4, 'python', 'dddd', 'bla bla bla', '10', 3),
(5, 'python', 'ffff', 'bla bla bla', '15', 30);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `userkey` varchar(45) DEFAULT NULL,
  `token` varchar(45) DEFAULT NULL,
  `validtime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `userkey`, `token`, `validtime`) VALUES
(1, 'python', 'python@bla.net', 'asdzxcxf', '92603740e66367aa211aa4d1032b0b17b3103ea8', '2019-07-07 01:09:56'),
(9, 'kasimmm', 'kasim@kasim.com', 'asdasczcd', 'asdasdas', NULL),
(10, 'kasimmm', 'kasim@kasim.com', 'asdasczcd', 'asdasdas', NULL),
(11, 'kasimmm', 'kasim@kasim.com', 'asdasczcd', 'asdasdas', NULL),
(12, 'kasimmm', 'kasim@kasim.com', 'asdasczcd', 'asdasdas', NULL),
(13, 'kasimmm', 'kasim@kasim.com', 'asdasczcd', 'asdasdas', '2019-07-06 12:07:37');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`if`);

--
-- Tablo için indeksler `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `log`
--
ALTER TABLE `log`
  MODIFY `if` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Tablo için AUTO_INCREMENT değeri `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Tablo için AUTO_INCREMENT değeri `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
