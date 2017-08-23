-- --------------------------------------------------------
-- 主机:                           192.168.1.250
-- 服务器版本:                        5.5.27-log - Source distribution
-- 服务器操作系统:                      Linux
-- HeidiSQL 版本:                  9.1.0.4867
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出 jhtd 的数据库结构
CREATE DATABASE IF NOT EXISTS `jhtd` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `jhtd`;


-- 导出  表 jhtd.fold 结构
CREATE TABLE IF NOT EXISTS `fold` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `father_id` varchar(50) DEFAULT NULL,
  `project_id` int(11) DEFAULT '1',
  `name` varchar(100) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `new_time` datetime DEFAULT NULL,
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `father_id_project_id_name_type` (`father_id`,`project_id`,`name`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- 正在导出表  jhtd.fold 的数据：~11,600 rows (大约)
/*!40000 ALTER TABLE `fold` DISABLE KEYS */;
INSERT INTO `fold` (`id`, `father_id`, `project_id`, `name`, `type`, `update_time`, `new_time`) VALUES
	(0, NULL, 1, 'Subject', NULL, NULL, NULL);


/*!40000 ALTER TABLE `fold` ENABLE KEYS */;


-- 导出  表 jhtd.project 结构
CREATE TABLE IF NOT EXISTS `project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state` int(11) NOT NULL DEFAULT '1',
  `project` varchar(50) NOT NULL DEFAULT '',
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- 正在导出表  jhtd.project 的数据：~2 rows (大约)
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` (`id`, `state`, `project`) VALUES
	(1, 1, '项目一'),
	(2, 1, '武动九天');
/*!40000 ALTER TABLE `project` ENABLE KEYS */;


-- 导出  表 jhtd.testcase 结构
CREATE TABLE IF NOT EXISTS `testcase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `father_id` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `tc_id` varchar(50) DEFAULT NULL,
  `description` text,
  `update_time` datetime DEFAULT NULL,
  `new_time` datetime DEFAULT NULL,
  `user` varchar(50) DEFAULT NULL,
  `x_state` int(11) DEFAULT '1',
  UNIQUE KEY `father_id_name` (`father_id`,`name`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;





-- 导出  表 jhtd.testrun 结构
CREATE TABLE IF NOT EXISTS `testrun` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `x_state` int(11) NOT NULL DEFAULT '1',
  `father_id` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT '未执行',
  `tc_id` varchar(50) DEFAULT NULL,
  `user` varchar(50) DEFAULT NULL,
  `path` text,
  `description` text,
  `new_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;



-- 导出  表 jhtd.user 结构
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `isauto` int(11) NOT NULL DEFAULT '0',
  `leader` int(11) DEFAULT '0',
  `user` varchar(50) DEFAULT '0',
  `reg_user` varchar(50) DEFAULT '',
  `password` varchar(50) DEFAULT '0',
  `bianhao` varchar(50) DEFAULT '0',
  `name` varchar(50) DEFAULT '0',
  `state` int(11) NOT NULL DEFAULT '1',
  `kouwei` varchar(200) DEFAULT '0',
  UNIQUE KEY `user` (`user`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- 正在导出表  jhtd.user 的数据：~5 rows (大约)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `isauto`, `leader`, `user`, `reg_user`, `password`, `bianhao`, `name`, `state`, `kouwei`) VALUES
	(2, 0, 0, 'ijunhai', '', 'ijunhai', '0', '君海游戏', 1, '0');


