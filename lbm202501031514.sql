-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: lbm
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `book_id` char(4) NOT NULL,
  `book_name` varchar(20) NOT NULL,
  `author` varchar(10) DEFAULT NULL,
  `publisher` varchar(20) DEFAULT NULL,
  `stock_count` decimal(9,0) DEFAULT '0',
  PRIMARY KEY (`book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES ('B001','计算机网络','谢希仁','电子工业出版社',19),('B002','数据结构','严蔚敏','清华大学出版社',23),('B003','Java核心技术','凯S.霍斯特曼','机械工业出版社',8),('B004','C程序设计','谭浩强','清华大学出版社',25),('B005','算法导论','Thomas H.','机械工业出版社',10),('B006','深入理解计算机系统','Randal E.','机械工业出版社',10),('B007','Python编程','马克·卢茨','人民邮电出版社',18),('B008','操作系统概念','西尔伯查茨','高等教育出版社',15),('B009','数据库系统概论','王珊','高等教育出版社',22),('B010','JavaScript高级程序设计','尼古拉斯','人民邮电出版社',16),('B011','机器学习实战','皮特·哈林顿','人民邮电出版社',14),('B012','深度学习入门','斋藤康毅','人民邮电出版社',18),('B013','统计学习方法','李航','清华大学出版社',20),('B016','MySQL技术内幕','姜承尧','机械工业出版社',16),('B020','Redis设计与实现','黄健宏','机械工业出版社',19),('B021','图解HTTP','上野宣','人民邮电出版社',21),('B022','云计算架构技术与实践','李军','电子工业出版社',14),('B023','大数据技术原理与应用','林子雨','人民邮电出版社',16),('B027','计算机组成原理','唐朔飞','高等教育出版社',22),('B029','深入理解Java虚拟机','周志明','机械工业出版社',19),('B030','React全栈','程墨','电子工业出版社',13),('B032','网络安全基础','王立福','清华大学出版社',18),('B033','Vue.js实战','梁灏','电子工业出版社',20),('B034','人工智能数学基础','戴新宇','高等教育出版社',15),('B040','微服务架构设计','马丁·福勒','机械工业出版社',18),('B043','Swift编程语言','Apple Inc.','人民邮电出版社',17),('B044','深度学习框架PyTorch','陈云','电子工业出版社',13),('B045','区块链技术指南','邹均','机械工业出版社',11),('B047','数据可视化实战','陈为','电子工业出版社',14),('B048','Kubernetes权威指南','龚正','电子工业出版社',18),('B049','自然语言处理实战','何晗','人民邮电出版社',15),('B050','图数据库Neo4j实战','林子雨','电子工业出版社',17),('B051','前端工程化体系设计','周俊鹏','电子工业出版社',16),('B052','深入浅出RxJS','程墨','人民邮电出版社',13),('B055','网络爬虫开发实战','崔庆才','人民邮电出版社',20),('B056','深入理解Nginx','陶辉','机械工业出版社',14),('B057','推荐系统实践','项亮','人民邮电出版社',17),('B058','TensorFlow深度学习','易新月','电子工业出版社',19),('B059','计算机图形学','史蒂夫·马纳','机械工业出版社',16),('B060','Flutter实战','杨加康','电子工业出版社',15);
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrow_records`
--

DROP TABLE IF EXISTS `borrow_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `borrow_records` (
  `borrow_time` datetime NOT NULL,
  `book_id` char(4) NOT NULL,
  `reader_name` varchar(10) NOT NULL,
  `borrow_count` decimal(9,0) DEFAULT '1',
  PRIMARY KEY (`borrow_time`,`book_id`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `borrow_records_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrow_records`
--

LOCK TABLES `borrow_records` WRITE;
/*!40000 ALTER TABLE `borrow_records` DISABLE KEYS */;
INSERT INTO `borrow_records` VALUES ('2024-03-01 09:30:00','B001','张三',1),('2024-03-01 10:15:00','B002','李四',1),('2024-03-01 11:20:00','B003','王五',2),('2024-03-02 09:00:00','B001','赵六',1),('2024-03-02 14:30:00','B004','钱七',1),('2024-03-03 10:45:00','B005','孙八',1),('2024-03-03 15:20:00','B006','周九',2),('2024-03-04 09:15:00','B007','吴十',1),('2024-03-04 11:30:00','B008','郑十一',1),('2024-03-05 10:00:00','B009','王小明',1),('2024-03-05 14:20:00','B010','李小红',1),('2024-03-06 09:45:00','B001','张小华',1),('2024-03-06 16:00:00','B002','刘小军',2),('2024-03-07 10:30:00','B003','陈小梅',1),('2024-03-07 15:15:00','B004','杨小燕',1),('2024-03-08 09:20:00','B005','黄小芳',1),('2024-03-08 14:45:00','B006','周小伟',1),('2024-03-09 11:00:00','B007','吴小龙',2),('2024-03-09 16:30:00','B008','朱小琳',1),('2024-03-10 10:15:00','B009','徐小波',1),('2025-01-02 14:36:56','B002','陈子陵',1),('2025-01-02 21:20:00','B001','陈子陵',1),('2025-01-02 23:16:02','B002','王硕',9),('2025-01-03 14:14:11','B006','马腾',2),('2025-01-03 15:11:23','B045','陈子陵',7);
/*!40000 ALTER TABLE `borrow_records` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `borrow_trigger` AFTER INSERT ON `borrow_records` FOR EACH ROW begin
        update books set stock_count = stock_count - new.borrow_count where book_id = new.book_id;
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `return_records`
--

DROP TABLE IF EXISTS `return_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `return_records` (
  `record_id` char(36) NOT NULL,
  `return_count` decimal(9,0) DEFAULT '1',
  `return_time` datetime NOT NULL,
  `remark` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`return_time`,`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `return_records`
--

LOCK TABLES `return_records` WRITE;
/*!40000 ALTER TABLE `return_records` DISABLE KEYS */;
INSERT INTO `return_records` VALUES ('R20250103151123B045',2,'2025-01-03 15:12:04','很棒！');
/*!40000 ALTER TABLE `return_records` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `return_trigger` AFTER INSERT ON `return_records` FOR EACH ROW begin
            -- 声明变量存储book_id
            DECLARE extracted_book_id VARCHAR(4);
            -- 获取book_id
            SET extracted_book_id = RIGHT(NEW.record_id, 4);
        update books set stock_count = stock_count + new.return_count where book_id = extracted_book_id;
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `change_trigger` AFTER UPDATE ON `return_records` FOR EACH ROW begin
        DECLARE extracted_book_id VARCHAR(4);
        SET extracted_book_id = RIGHT(old.record_id, 4);
        update books set stock_count = stock_count - old.return_count where book_id = extracted_book_id;
        update books set stock_count = stock_count + new.return_count where book_id = extracted_book_id;
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `delete_trigger` AFTER DELETE ON `return_records` FOR EACH ROW begin
        DECLARE extracted_book_id VARCHAR(4);
        SET extracted_book_id = RIGHT(old.record_id, 4);
        update books set stock_count = stock_count - old.return_count where book_id = extracted_book_id;
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `v_borrow_records`
--

DROP TABLE IF EXISTS `v_borrow_records`;
/*!50001 DROP VIEW IF EXISTS `v_borrow_records`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_borrow_records` AS SELECT 
 1 AS `record_id`,
 1 AS `book_id`,
 1 AS `book_name`,
 1 AS `reader_name`,
 1 AS `borrow_time`,
 1 AS `return_time`,
 1 AS `borrow_count`,
 1 AS `status`,
 1 AS `return_count`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v_borrow_records`
--

/*!50001 DROP VIEW IF EXISTS `v_borrow_records`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_borrow_records` AS select concat('R',date_format(`br`.`borrow_time`,'%Y%m%d%H%i%s'),`br`.`book_id`) AS `record_id`,`br`.`book_id` AS `book_id`,`b`.`book_name` AS `book_name`,`br`.`reader_name` AS `reader_name`,`br`.`borrow_time` AS `borrow_time`,coalesce(`r`.`return_time`,NULL) AS `return_time`,`br`.`borrow_count` AS `borrow_count`,(case when (`r`.`return_time` is null) then '借阅中' else concat('归还',coalesce((select sum(`return_records`.`return_count`) from `return_records` where (`return_records`.`record_id` = concat('R',date_format(`br`.`borrow_time`,'%Y%m%d%H%i%s'),`br`.`book_id`))),0),'/',`br`.`borrow_count`) end) AS `status`,`r`.`return_count` AS `return_count` from ((`borrow_records` `br` left join `books` `b` on((`br`.`book_id` = `b`.`book_id`))) left join `return_records` `r` on(((concat('R',date_format(`br`.`borrow_time`,'%Y%m%d%H%i%s'),`br`.`book_id`) = `r`.`record_id`) and (`r`.`return_time` > `br`.`borrow_time`)))) order by `br`.`borrow_time` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-03 15:14:16
