

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

# Dumping database structure for plans
# DROP DATABASE IF EXISTS `plans`;
# CREATE DATABASE IF NOT EXISTS `plans` /*!40100 DEFAULT CHARACTER SET utf8 */;
# USE `plans`;


# Dumping structure for table plans.plans
DROP TABLE IF EXISTS `plans`;
CREATE TABLE IF NOT EXISTS `plans` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `hashtag` text NOT NULL,
  `text` text,
  `title` text,
  `x` int(11) DEFAULT NULL,
  `y` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

# Dumping data for table plans.plans: ~10 rows (approximately)
/*!40000 ALTER TABLE `plans` DISABLE KEYS */;
INSERT INTO `plans` (`id`, `hashtag`, `text`, `title`, `x`, `y`) VALUES
	(26, '0', 'test window for user 1<br><br>Some <b>rich</b> <font color="red">text</font> goes <u>here</u><br>Give it a try!', '11', 334, 0);
/*!40000 ALTER TABLE `plans` ENABLE KEYS */;


# Dumping structure for table plans.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) DEFAULT NULL,
  `signup_date` int(10) DEFAULT NULL,
  `language` tinytext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

# Dumping data for table plans.users: ~11 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `username`, `email`, `password`, `signup_date`, `language`) VALUES
	(0, '1', '1@1.aa', '356a192b7913b04c54574d18c28d46e6395428ab', 1370515540, NULL),
	(3, '2', '1@1.rt', '356a192b7913b04c54574d18c28d46e6395428ab', 1370524742, NULL),
	(4, '3', '1@i.ia', '356a192b7913b04c54574d18c28d46e6395428ab', 1370526895, NULL),
	(6, '4', '1@1.ia', '356a192b7913b04c54574d18c28d46e6395428ab', 1370528465, NULL),
	(7, '5', '5@i.ua', 'ac3478d69a3c81fa62e60f5c3696165a4e5e6ac4', 1370938538, NULL),
	(8, '6', '6@6.ua', 'c1dfd96eea8cc2b62785275bca38ac261256e278', 1370942125, NULL),
	(9, '7', '7@1.ua', '902ba3cda1883801594b6e1b452790cc53948fda', 1371136726, NULL),
	(10, '8', '8@1.ua', 'fe5dbbcea5ce7e2988b8c69bcfdfde8904aabc1f', 1371218679, NULL),
	(11, '9', '9@i.ua', '0ade7c2cf97f75d009975f4d720d1fa6c19f4897', 1371218750, NULL),
	(12, '10', '10@i.ua', 'b1d5781111d84f7b3fe45a0852e59758cd7a87e5', 1371237091, NULL),
	(13, '11', '1@i.ua', '17ba0791499db908433b80f37c5fbc89b870084b', 1371540367, NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
