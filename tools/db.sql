/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE TABLE IF NOT EXISTS `authentication_ticket` (
  `user_id` int(11) NOT NULL,
  `sso_ticket` varchar(250) NOT NULL DEFAULT '',
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `authentication_ticket` DISABLE KEYS */;
INSERT INTO `authentication_ticket` (`user_id`, `sso_ticket`, `expires_at`) VALUES
	(1, '123', NULL),
	(2, 'kek', NULL);
/*!40000 ALTER TABLE `authentication_ticket` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `messenger_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `label` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `messenger_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `messenger_category` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `messenger_chat_history` (
  `user_id` int(11) NOT NULL,
  `friend_id` int(11) NOT NULL,
  `message` text NOT NULL DEFAULT '',
  `has_read` tinyint(1) NOT NULL,
  `messaged_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `messenger_chat_history` DISABLE KEYS */;
INSERT INTO `messenger_chat_history` (`user_id`, `friend_id`, `message`, `has_read`, `messaged_at`) VALUES
	(1, 2, 'test', 1, '2020-04-13 14:45:21'),
	(2, 1, 'hey bitch lol', 1, '2020-04-13 14:45:25'),
	(2, 1, 'sup bish', 1, '2020-04-13 23:19:57');
/*!40000 ALTER TABLE `messenger_chat_history` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `messenger_friend` (
  `user_id` int(11) NOT NULL,
  `friend_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `messenger_friend` DISABLE KEYS */;
INSERT INTO `messenger_friend` (`user_id`, `friend_id`) VALUES
	(1, 3),
	(3, 1),
	(1, 4),
	(4, 1),
	(1, 2),
	(2, 1);
/*!40000 ALTER TABLE `messenger_friend` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `messenger_request` (
  `user_id` int(11) NOT NULL,
  `friend_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `messenger_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `messenger_request` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `navigator_official_rooms` (
  `banner_id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL,
  `banner_type` enum('NONE','TAG','FLAT','PUBLIC_FLAT','CATEGORY') NOT NULL,
  `room_id` int(11) NOT NULL,
  `image_type` enum('INTERNAL','EXTERNAL') NOT NULL DEFAULT 'INTERNAL',
  `label` text NOT NULL DEFAULT '',
  `description` text NOT NULL DEFAULT '',
  `description_entry` tinyint(1) NOT NULL DEFAULT 0,
  `image_url` text NOT NULL,
  PRIMARY KEY (`banner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `navigator_official_rooms` DISABLE KEYS */;
INSERT INTO `navigator_official_rooms` (`banner_id`, `parent_id`, `banner_type`, `room_id`, `image_type`, `label`, `description`, `description_entry`, `image_url`) VALUES
	(1, 0, 'CATEGORY', 0, 'EXTERNAL', 'Classic Rooms', '', 0, 'officialrooms_hq/alhambra_official_rooms.gif'),
	(2, 1, 'PUBLIC_FLAT', 1, 'EXTERNAL', 'Welcome Lounge', 'welcome_lounge', 0, 'officialrooms_defaults/hh_room_nlobby.png');
/*!40000 ALTER TABLE `navigator_official_rooms` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `room` (
  `id` int(100) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) NOT NULL,
  `name` mediumtext NOT NULL,
  `description` mediumtext NOT NULL,
  `category_id` int(11) NOT NULL DEFAULT 14,
  `visitors_now` int(11) NOT NULL DEFAULT 0,
  `visitors_max` int(11) NOT NULL DEFAULT 25,
  `status` enum('OPEN','CLOSED','PASSWORD') NOT NULL DEFAULT 'OPEN',
  `password` text NOT NULL DEFAULT '',
  `model` varchar(30) NOT NULL DEFAULT '',
  `ccts` text NOT NULL DEFAULT '',
  `wallpaper` int(11) NOT NULL DEFAULT 0,
  `floor` int(11) NOT NULL DEFAULT 0,
  `landscape` int(11) NOT NULL DEFAULT 0,
  `rating` int(11) NOT NULL DEFAULT 0,
  `allow_pets` tinyint(1) NOT NULL DEFAULT 1,
  `allow_pets_eat` tinyint(1) NOT NULL DEFAULT 1,
  `allow_walkthrough` tinyint(1) NOT NULL DEFAULT 0,
  `hidewall` tinyint(1) NOT NULL DEFAULT 0,
  `wall_thickness` tinyint(3) NOT NULL DEFAULT 0,
  `floor_thickness` tinyint(3) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` (`id`, `owner_id`, `name`, `description`, `category_id`, `visitors_now`, `visitors_max`, `status`, `password`, `model`, `ccts`, `wallpaper`, `floor`, `landscape`, `rating`, `allow_pets`, `allow_pets_eat`, `allow_walkthrough`, `hidewall`, `wall_thickness`, `floor_thickness`) VALUES
	(1, 0, 'Welcome Lobby', 'welcome_lounge', 15, 1, 25, 'OPEN', '', 'newbie_lobby', 'hh_room_nlobby', 0, 0, 0, 0, 1, 1, 1, 0, 0, 0),
	(2, 1, 'test creation lolz', '', 6, 0, 25, 'OPEN', '', 'model_t', '', 0, 0, 0, 0, 1, 1, 0, 0, 0, 0);
/*!40000 ALTER TABLE `room` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `room_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `caption` varchar(100) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `min_rank` int(11) NOT NULL DEFAULT 1,
  `trading_allowed` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `room_category` DISABLE KEYS */;
INSERT INTO `room_category` (`id`, `caption`, `enabled`, `min_rank`, `trading_allowed`) VALUES
	(1, 'Staff Rooms', 1, 4, 1),
	(2, 'Competition Category', 1, 1, 1),
	(3, 'unused competition category', 1, 1, 1),
	(4, 'Themed & RPG Rooms', 1, 1, 0),
	(5, 'Restaurant, Bar & Night Club Rooms', 1, 1, 0),
	(6, 'Club & Group Rooms', 1, 1, 1),
	(7, 'Chat, Chill & Discussion Rooms', 1, 1, 1),
	(8, 'Maze & Theme Park Rooms', 1, 1, 1),
	(9, 'Trading & Shopping Rooms', 1, 1, 1),
	(10, 'Gaming & Race Rooms', 1, 1, 1),
	(11, 'Hair Salons & Modelling Rooms', 1, 1, 0),
	(12, 'Help Centre, Guide & Service Rooms', 1, 1, 0),
	(13, 'School, Daycare & Adoption Rooms', 1, 1, 0),
	(14, 'All Other Rooms', 1, 1, 1),
	(15, 'No Category', 1, 1, 1);
/*!40000 ALTER TABLE `room_category` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `room_models` (
  `model` varchar(100) NOT NULL,
  `door_x` int(11) NOT NULL,
  `door_y` int(11) NOT NULL,
  `door_z` double NOT NULL,
  `door_dir` int(4) NOT NULL DEFAULT 2,
  `heightmap` text NOT NULL,
  `club_only` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `room_models` DISABLE KEYS */;
INSERT INTO `room_models` (`model`, `door_x`, `door_y`, `door_z`, `door_dir`, `heightmap`, `club_only`) VALUES
	('model_a', 3, 5, 0, 2, 'xxxxxxxxxxxx|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxxxxxxxxxx|xxxxxxxxxxxx', 0),
	('model_b', 0, 5, 0, 2, 'xxxxxxxxxxxx|xxxxx0000000|xxxxx0000000|xxxxx0000000|xxxxx0000000|x00000000000|x00000000000|x00000000000|x00000000000|x00000000000|x00000000000|xxxxxxxxxxxx|xxxxxxxxxxxx|xxxxxxxxxxxx|xxxxxxxxxxxx|xxxxxxxxxxxx', 0),
	('model_c', 4, 7, 0, 2, 'xxxxxxxxxxxx|xxxxxxxxxxxx|xxxxxxxxxxxx|xxxxxxxxxxxx|xxxxxxxxxxxx|xxxxx000000x|xxxxx000000x|xxxxx000000x|xxxxx000000x|xxxxx000000x|xxxxx000000x|xxxxxxxxxxxx|xxxxxxxxxxxx|xxxxxxxxxxxx|xxxxxxxxxxxx|xxxxxxxxxxxx', 0),
	('model_d', 4, 7, 0, 2, 'xxxxxxxxxxxx|xxxxx000000x|xxxxx000000x|xxxxx000000x|xxxxx000000x|xxxxx000000x|xxxxx000000x|xxxxx000000x|xxxxx000000x|xxxxx000000x|xxxxx000000x|xxxxx000000x|xxxxx000000x|xxxxx000000x|xxxxx000000x|xxxxxxxxxxxx', 0),
	('model_e', 1, 5, 0, 2, 'xxxxxxxxxxxx|xxxxxxxxxxxx|xxxxxxxxxxxx|xx0000000000|xx0000000000|xx0000000000|xx0000000000|xx0000000000|xx0000000000|xx0000000000|xx0000000000|xxxxxxxxxxxx|xxxxxxxxxxxx|xxxxxxxxxxxx|xxxxxxxxxxxx|xxxxxxxxxxxx', 0),
	('model_f', 2, 5, 0, 2, 'xxxxxxxxxxxx|xxxxxxx0000x|xxxxxxx0000x|xxx00000000x|xxx00000000x|xxx00000000x|xxx00000000x|x0000000000x|x0000000000x|x0000000000x|x0000000000x|xxxxxxxxxxxx|xxxxxxxxxxxx|xxxxxxxxxxxx|xxxxxxxxxxxx|xxxxxxxxxxxx', 0),
	('model_g', 1, 7, 1, 2, 'xxxxxxxxxxxx|xxxxxxxxxxxx|xxxxxxx00000|xxxxxxx00000|xxxxxxx00000|xx1111000000|xx1111000000|xx1111000000|xx1111000000|xx1111000000|xxxxxxx00000|xxxxxxx00000|xxxxxxx00000|xxxxxxxxxxxx|xxxxxxxxxxxx|xxxxxxxxxxxx|xxxxxxxxxxxx', 1),
	('model_h', 4, 4, 1, 2, 'xxxxxxxxxxxx|xxxxxxxxxxxx|xxxxx111111x|xxxxx111111x|xxxxx111111x|xxxxx111111x|xxxxx111111x|xxxxx000000x|xxxxx000000x|xxx00000000x|xxx00000000x|xxx00000000x|xxx00000000x|xxxxxxxxxxxx|xxxxxxxxxxxx|xxxxxxxxxxxx', 1),
	('model_i', 0, 10, 0, 2, 'xxxxxxxxxxxxxxxxx|x0000000000000000|x0000000000000000|x0000000000000000|x0000000000000000|x0000000000000000|x0000000000000000|x0000000000000000|x0000000000000000|x0000000000000000|x0000000000000000|x0000000000000000|x0000000000000000|x0000000000000000|x0000000000000000|x0000000000000000|x0000000000000000|x0000000000000000|x0000000000000000|x0000000000000000|x0000000000000000|x0000000000000000|x0000000000000000|x0000000000000000|x0000000000000000|x0000000000000000|x0000000000000000|xxxxxxxxxxxxxxxxx', 0),
	('model_j', 0, 10, 0, 2, 'xxxxxxxxxxxxxxxxxxxxx|xxxxxxxxxxx0000000000|xxxxxxxxxxx0000000000|xxxxxxxxxxx0000000000|xxxxxxxxxxx0000000000|xxxxxxxxxxx0000000000|xxxxxxxxxxx0000000000|x00000000000000000000|x00000000000000000000|x00000000000000000000|x00000000000000000000|x00000000000000000000|x00000000000000000000|x00000000000000000000|x00000000000000000000|x00000000000000000000|x00000000000000000000|x0000000000xxxxxxxxxx|x0000000000xxxxxxxxxx|x0000000000xxxxxxxxxx|x0000000000xxxxxxxxxx|x0000000000xxxxxxxxxx|x0000000000xxxxxxxxxx|xxxxxxxxxxxxxxxxxxxxx', 0),
	('model_k', 0, 13, 0, 2, 'xxxxxxxxxxxxxxxxxxxxxxxxx|xxxxxxxxxxxxxxxxx00000000|xxxxxxxxxxxxxxxxx00000000|xxxxxxxxxxxxxxxxx00000000|xxxxxxxxxxxxxxxxx00000000|xxxxxxxxx0000000000000000|xxxxxxxxx0000000000000000|xxxxxxxxx0000000000000000|xxxxxxxxx0000000000000000|x000000000000000000000000|x000000000000000000000000|x000000000000000000000000|x000000000000000000000000|x000000000000000000000000|x000000000000000000000000|x000000000000000000000000|x000000000000000000000000|xxxxxxxxx0000000000000000|xxxxxxxxx0000000000000000|xxxxxxxxx0000000000000000|xxxxxxxxx0000000000000000|xxxxxxxxx0000000000000000|xxxxxxxxx0000000000000000|xxxxxxxxx0000000000000000|xxxxxxxxx0000000000000000|xxxxxxxxx0000000000000000|xxxxxxxxx0000000000000000|xxxxxxxxxxxxxxxxxxxxxxxxx', 0),
	('model_l', 0, 16, 0, 2, 'xxxxxxxxxxxxxxxxxxxxx|x00000000000000000000|x00000000000000000000|x00000000000000000000|x00000000000000000000|x00000000000000000000|x00000000000000000000|x00000000000000000000|x00000000000000000000|x00000000xxxx00000000|x00000000xxxx00000000|x00000000xxxx00000000|x00000000xxxx00000000|x00000000xxxx00000000|x00000000xxxx00000000|x00000000xxxx00000000|x00000000xxxx00000000|x00000000xxxx00000000|x00000000xxxx00000000|x00000000xxxx00000000|x00000000xxxx00000000|xxxxxxxxxxxxxxxxxxxxx', 0),
	('model_m', 0, 15, 0, 2, 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxx|xxxxxxxxxxx00000000xxxxxxxxxx|xxxxxxxxxxx00000000xxxxxxxxxx|xxxxxxxxxxx00000000xxxxxxxxxx|xxxxxxxxxxx00000000xxxxxxxxxx|xxxxxxxxxxx00000000xxxxxxxxxx|xxxxxxxxxxx00000000xxxxxxxxxx|xxxxxxxxxxx00000000xxxxxxxxxx|xxxxxxxxxxx00000000xxxxxxxxxx|xxxxxxxxxxx00000000xxxxxxxxxx|xxxxxxxxxxx00000000xxxxxxxxxx|x0000000000000000000000000000|x0000000000000000000000000000|x0000000000000000000000000000|x0000000000000000000000000000|x0000000000000000000000000000|x0000000000000000000000000000|x0000000000000000000000000000|x0000000000000000000000000000|xxxxxxxxxxx00000000xxxxxxxxxx|xxxxxxxxxxx00000000xxxxxxxxxx|xxxxxxxxxxx00000000xxxxxxxxxx|xxxxxxxxxxx00000000xxxxxxxxxx|xxxxxxxxxxx00000000xxxxxxxxxx|xxxxxxxxxxx00000000xxxxxxxxxx|xxxxxxxxxxx00000000xxxxxxxxxx|xxxxxxxxxxx00000000xxxxxxxxxx|xxxxxxxxxxx00000000xxxxxxxxxx|xxxxxxxxxxx00000000xxxxxxxxxx|xxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 0),
	('model_n', 0, 16, 0, 2, 'xxxxxxxxxxxxxxxxxxxxx|x00000000000000000000|x00000000000000000000|x00000000000000000000|x00000000000000000000|x00000000000000000000|x00000000000000000000|x000000xxxxxxxx000000|x000000x000000x000000|x000000x000000x000000|x000000x000000x000000|x000000x000000x000000|x000000x000000x000000|x000000x000000x000000|x000000xxxxxxxx000000|x00000000000000000000|x00000000000000000000|x00000000000000000000|x00000000000000000000|x00000000000000000000|x00000000000000000000|xxxxxxxxxxxxxxxxxxxxx', 0),
	('model_o', 0, 18, 1, 2, 'xxxxxxxxxxxxxxxxxxxxxxxxx|xxxxxxxxxxxxx11111111xxxx|xxxxxxxxxxxxx11111111xxxx|xxxxxxxxxxxxx11111111xxxx|xxxxxxxxxxxxx11111111xxxx|xxxxxxxxxxxxx11111111xxxx|xxxxxxxxxxxxx11111111xxxx|xxxxxxxxxxxxx11111111xxxx|xxxxxxxxxxxxx00000000xxxx|xxxxxxxxx0000000000000000|xxxxxxxxx0000000000000000|xxxxxxxxx0000000000000000|xxxxxxxxx0000000000000000|xxxxxxxxx0000000000000000|xxxxxxxxx0000000000000000|x111111100000000000000000|x111111100000000000000000|x111111100000000000000000|x111111100000000000000000|x111111100000000000000000|x111111100000000000000000|x111111100000000000000000|x111111100000000000000000|xxxxxxxxx0000000000000000|xxxxxxxxx0000000000000000|xxxxxxxxx0000000000000000|xxxxxxxxx0000000000000000|xxxxxxxxxxxxxxxxxxxxxxxxx', 1),
	('model_p', 0, 23, 2, 2, 'xxxxxxxxxxxxxxxxxxx|xxxxxxx222222222222|xxxxxxx222222222222|xxxxxxx222222222222|xxxxxxx222222222222|xxxxxxx222222222222|xxxxxxx222222222222|xxxxxxx22222222xxxx|xxxxxxx11111111xxxx|x222221111111111111|x222221111111111111|x222221111111111111|x222221111111111111|x222221111111111111|x222221111111111111|x222221111111111111|x222221111111111111|x2222xx11111111xxxx|x2222xx00000000xxxx|x2222xx000000000000|x2222xx000000000000|x2222xx000000000000|x2222xx000000000000|22222xx000000000000|x2222xx000000000000|xxxxxxxxxxxxxxxxxxx', 1),
	('model_q', 10, 4, 2, 2, 'xxxxxxxxxxxxxxxxxxx|xxxxxxxxxxx22222222|xxxxxxxxxxx22222222|xxxxxxxxxxx22222222|xxxxxxxxxxx22222222|xxxxxxxxxxx22222222|xxxxxxxxxxx22222222|x222222222222222222|x222222222222222222|x222222222222222222|x222222222222222222|x222222222222222222|x222222222222222222|x2222xxxxxxxxxxxxxx|x2222xxxxxxxxxxxxxx|x2222211111xx000000|x222221111110000000|x222221111110000000|x2222211111xx000000|xx22xxx1111xxxxxxxx|xx11xxx1111xxxxxxxx|x1111xx1111xx000000|x1111xx111110000000|x1111xx111110000000|x1111xx1111xx000000|xxxxxxxxxxxxxxxxxxx', 1),
	('model_r', 10, 4, 3, 2, 'xxxxxxxxxxxxxxxxxxxxxxxxx|xxxxxxxxxxx33333333333333|xxxxxxxxxxx33333333333333|xxxxxxxxxxx33333333333333|xxxxxxxxxx333333333333333|xxxxxxxxxxx33333333333333|xxxxxxxxxxx33333333333333|xxxxxxx333333333333333333|xxxxxxx333333333333333333|xxxxxxx333333333333333333|xxxxxxx333333333333333333|xxxxxxx333333333333333333|xxxxxxx333333333333333333|x4444433333xxxxxxxxxxxxxx|x4444433333xxxxxxxxxxxxxx|x44444333333222xx000000xx|x44444333333222xx000000xx|xxx44xxxxxxxx22xx000000xx|xxx33xxxxxxxx11xx000000xx|xxx33322222211110000000xx|xxx33322222211110000000xx|xxxxxxxxxxxxxxxxx000000xx|xxxxxxxxxxxxxxxxx000000xx|xxxxxxxxxxxxxxxxx000000xx|xxxxxxxxxxxxxxxxx000000xx|xxxxxxxxxxxxxxxxxxxxxxxxx', 1),
	('model_t', 0, 3, 2, 2, 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxx|x222222222222222222222222222x|x222222222222222222222222222x|2222222222222222222222222222x|x222222222222222222222222222x|x2222xxxxxx222222xxxxxxx2222x|x2222xxxxxx111111xxxxxxx2222x|x2222xx111111111111111xx2222x|x2222xx111111111111111xx2222x|x2222xx11xxx1111xxxx11xx2222x|x2222xx11xxx0000xxxx11xx2222x|x22222111x00000000xx11xx2222x|x22222111x00000000xx11xx2222x|x22222111x00000000xx11xx2222x|x22222111x00000000xx11xx2222x|x22222111x00000000xx11xx2222x|x22222111x00000000xx11xx2222x|x2222xx11xxxxxxxxxxx11xx2222x|x2222xx11xxxxxxxxxxx11xx2222x|x2222xx111111111111111xx2222x|x2222xx111111111111111xx2222x|x2222xxxxxxxxxxxxxxxxxxx2222x|x2222xxxxxxxxxxxxxxxxxxx2222x|x222222222222222222222222222x|x222222222222222222222222222x|x222222222222222222222222222x|x222222222222222222222222222x|xxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 1),
	('model_u', 0, 17, 1, 2, 'xxxxxxxxxxxxxxxxxxxxxxxx|x1111100000000000000000x|x1111100000000000000000x|x1111100000000000000000x|x1111100000000000000000x|x1111100000000000000000x|x1111100000000000000000x|x1111100000000000000000x|x1111100000000000000000x|x1111100000000000000000x|x1111100000000000000000x|x1111100000000000000000x|x1111100000000000000000x|x1111100000000000000000x|x1111100000000000000000x|x1111100000000000000000x|x1111100000000000000000x|11111100000000000000000x|x1111100000000000000000x|x1111100000000000000000x|x1111100000000000000000x|x1111100000000000000000x|x1111100000000000000000x|x1111100000000000000000x|x1111100000000000000000x|x1111100000000000000000x|x1111100000000000000000x|x1111100000000000000000x|x1111100000000000000000x|x1111100000000000000000x|x1111100000000000000000x|x1111100000000000000000x|x1111100000000000000000x|x1111100000000000000000x|x1111100000000000000000x|xxxxxxxxxxxxxxxxxxxxxxxx', 1),
	('model_v', 0, 3, 2, 2, 'xxxxxxxxxxxxxxxxxxxx|x222221111111111111x|x222221111111111111x|2222221111111111111x|x222221111111111111x|x222221111111111111x|x222221111111111111x|xxxxxxxx1111xxxxxxxx|xxxxxxxx0000xxxxxxxx|x000000x0000x000000x|x000000x0000x000000x|x00000000000x000000x|x00000000000x000000x|x000000000000000000x|x000000000000000000x|xxxxxxxx00000000000x|x000000x00000000000x|x000000x0000xxxxxxxx|x00000000000x000000x|x00000000000x000000x|x00000000000x000000x|x00000000000x000000x|xxxxxxxx0000x000000x|x000000x0000x000000x|x000000x0000x000000x|x000000000000000000x|x000000000000000000x|x000000000000000000x|x000000000000000000x|xxxxxxxxxxxxxxxxxxxx', 1),
	('model_w', 0, 3, 2, 2, 'xxxxxxxxxxxxxxxxxxxxxxxxxxx|x2222xx1111111111xx11111111|x2222xx1111111111xx11111111|222222111111111111111111111|x22222111111111111111111111|x22222111111111111111111111|x22222111111111111111111111|x2222xx1111111111xx11111111|x2222xx1111111111xx11111111|x2222xx1111111111xxxx1111xx|x2222xx1111111111xxxx0000xx|xxxxxxx1111111111xx00000000|xxxxxxx1111111111xx00000000|x22222111111111111000000000|x22222111111111111000000000|x22222111111111111000000000|x22222111111111111000000000|x2222xx1111111111xx00000000|x2222xx1111111111xx00000000|x2222xxxx1111xxxxxxxxxxxxxx|x2222xxxx0000xxxxxxxxxxxxxx|x2222x0000000000xxxxxxxxxxx|x2222x0000000000xxxxxxxxxxx|x2222x0000000000xxxxxxxxxxx|x2222x0000000000xxxxxxxxxxx|x2222x0000000000xxxxxxxxxxx|x2222x0000000000xxxxxxxxxxx', 1),
	('model_x', 0, 12, 0, 2, 'xxxxxxxxxxxxxxxxxxxx|x000000000000000000x|x000000000000000000x|x000000000000000000x|x000000000000000000x|x000000000000000000x|x000000000000000000x|xxx00xxx0000xxx00xxx|x000000x0000x000000x|x000000x0000x000000x|x000000x0000x000000x|x000000x0000x000000x|0000000x0000x000000x|x000000x0000x000000x|x000000x0000x000000x|x000000x0000x000000x|x000000x0000x000000x|x000000x0000x000000x|x000000xxxxxx000000x|x000000000000000000x|x000000000000000000x|x000000000000000000x|x000000000000000000x|x000000000000000000x|x000000000000000000x|xxxxxxxxxxxxxxxxxxxx', 1),
	('model_y', 0, 3, 0, 2, 'xxxxxxxxxxxxxxxxxxxxxxxxxxxx|x00000000xx0000000000xx0000x|x00000000xx0000000000xx0000x|000000000xx0000000000xx0000x|x00000000xx0000000000xx0000x|x00000000xx0000xx0000xx0000x|x00000000xx0000xx0000xx0000x|x00000000xx0000xx0000000000x|x00000000xx0000xx0000000000x|xxxxx0000xx0000xx0000000000x|xxxxx0000xx0000xx0000000000x|xxxxx0000xx0000xxxxxxxxxxxxx|xxxxx0000xx0000xxxxxxxxxxxxx|x00000000xx0000000000000000x|x00000000xx0000000000000000x|x00000000xx0000000000000000x|x00000000xx0000000000000000x|x0000xxxxxxxxxxxxxxxxxx0000x|x0000xxxxxxxxxxxxxxxxxx0000x|x00000000000000000000000000x|x00000000000000000000000000x|x00000000000000000000000000x|x00000000000000000000000000x|xxxxxxxxxxxxxxxxxxxxxxxxxxxx', 1),
	('model_z', 0, 9, 0, 2, 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx|xxxxxxxxxxx00000000000000000000|xxxxxxxxxxx00000000000000000000|xxxxxxxxxxx00000000000000000000|x00000000xx00000000000000000000|x00000000xx00000000000000000000|x00000000xx00000000000000000000|x00000000xx00000000000000000000|x00000000xx00000000000000000000|000000000xx00000000000000000000|x00000000xx00000000000000000000|x00000000xx00000000000000000000|x00000000xx00000000000000000000|x00000000xx00000000000000000000|x00000000xx00000000000000000000|x00000000xx00000000000000000000|xxxxxxxxxxx00000000000000000000|xxxxxxxxxxx00000000000000000000|xxxxxxxxxxx00000000000000000000|xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 1),
	('newbie_lobby', 2, 11, 0, 2, 'xxxxxxxxxxxxxxxx000000|xxxxx0xxxxxxxxxx000000|xxxxx00000000xxx000000|xxxxx000000000xx000000|0000000000000000000000|0000000000000000000000|0000000000000000000000|0000000000000000000000|0000000000000000000000|xxxxx000000000000000xx|xxxxx000000000000000xx|x0000000000000000000xx|x0000000000000000xxxxx|xxxxxx00000000000xxxxx|xxxxxxx0000000000xxxxx|xxxxxxxx000000000xxxxx|xxxxxxxx000000000xxxxx|xxxxxxxx000000000xxxxx|xxxxxxxx000000000xxxxx|xxxxxxxx000000000xxxxx|xxxxxxxx000000000xxxxx|xxxxxx00000000000xxxxx|xxxxxx00000000000xxxxx|xxxxxx00000000000xxxxx|xxxxxx00000000000xxxxx|xxxxxx00000000000xxxxx|xxxxx000000000000xxxxx|xxxxx000000000000xxxxx', 0);
/*!40000 ALTER TABLE `room_models` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `figure` varchar(250) NOT NULL DEFAULT 'hd-180-1.hr-100-61.ch-210-66.lg-270-82.sh-290-80',
  `sex` varchar(1) NOT NULL DEFAULT 'M',
  `rank` int(11) NOT NULL DEFAULT 1,
  `credits` int(11) NOT NULL DEFAULT 0,
  `pixels` int(11) NOT NULL DEFAULT 0,
  `motto` text NOT NULL DEFAULT '',
  `join_date` datetime NOT NULL DEFAULT current_timestamp(),
  `last_online` datetime NOT NULL DEFAULT current_timestamp(),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `username`, `figure`, `sex`, `rank`, `credits`, `pixels`, `motto`, `join_date`, `last_online`) VALUES
	(1, 'Alex', 'hd-180-1.hr-100-61.ch-210-66.lg-270-82.sh-290-80', 'M', 1, 2000, 0, '123', '2020-03-29 18:20:03', '2020-04-17 01:39:00'),
	(2, 'Test', 'hd-180-1.hr-100-.ch-260-62.lg-275-64.ha-1008-.ea-1402-.ca-1806-73', 'M', 1, 0, 0, '456', '2020-03-29 20:47:31', '2020-04-15 20:48:07'),
	(3, 'Test123', 'hd-180-1.hr-100-61.ch-210-66.lg-270-82.sh-290-80', 'M', 1, 0, 0, '789', '2020-03-29 20:47:31', '2020-04-10 20:37:28'),
	(4, 'Test456', 'hd-180-1.hr-100-61.ch-210-66.lg-270-82.sh-290-80', 'M', 1, 0, 0, '789', '2020-03-29 20:47:31', '2020-04-10 20:37:28');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `user_settings` (
  `user_id` int(11) NOT NULL,
  `daily_respect_points` int(11) NOT NULL DEFAULT 0,
  `daily_respect_pet_points` int(11) NOT NULL DEFAULT 0,
  `respect_points` int(11) NOT NULL DEFAULT 0,
  `friend_requests_enabled` tinyint(1) NOT NULL DEFAULT 1,
  `following_enabled` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `user_settings` DISABLE KEYS */;
INSERT INTO `user_settings` (`user_id`, `daily_respect_points`, `daily_respect_pet_points`, `respect_points`, `friend_requests_enabled`, `following_enabled`) VALUES
	(1, 0, 0, 0, 1, 1),
	(2, 0, 0, 0, 1, 1),
	(3, 0, 0, 0, 1, 1);
/*!40000 ALTER TABLE `user_settings` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `user_subscriptions` (
  `user_id` int(11) NOT NULL,
  `subscribed_at` datetime NOT NULL,
  `expire_at` datetime NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `user_subscriptions` DISABLE KEYS */;
INSERT INTO `user_subscriptions` (`user_id`, `subscribed_at`, `expire_at`) VALUES
	(1, '2020-04-10 14:00:31', '2024-04-28 14:00:31');
/*!40000 ALTER TABLE `user_subscriptions` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
