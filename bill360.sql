/*
SQLyog Ultimate v11.33 (64 bit)
MySQL - 5.7.6-m16 : Database - bill360
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`bill360` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `bill360`;

/*Table structure for table `b_acceptance` */

DROP TABLE IF EXISTS `b_acceptance`;

CREATE TABLE `b_acceptance` (
  `_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `_invoice` varchar(255) DEFAULT NULL COMMENT '承兑企业名称（开票企业）',
  `_core` varchar(255) DEFAULT NULL COMMENT '上市主体',
  `_category` varchar(255) DEFAULT NULL COMMENT '企业类别',
  `_nature` varchar(255) DEFAULT NULL COMMENT '企业性质',
  `_type` int(11) NOT NULL COMMENT '类型0-母公司、1-子公司、2-孙公司',
  `_addr` varchar(255) DEFAULT NULL COMMENT '地址',
  `_area` varchar(255) DEFAULT NULL COMMENT '地区',
  `_is_finish` int(11) NOT NULL COMMENT '企业信息0-未完善、1-已完善',
  PRIMARY KEY (`_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

/*Data for the table `b_acceptance` */

insert  into `b_acceptance`(`_id`,`_invoice`,`_core`,`_category`,`_nature`,`_type`,`_addr`,`_area`,`_is_finish`) values (1,'青海比亚迪实业有限公司','比亚迪','独资','房地产',1,'青海',NULL,1),(2,'中国建筑一局（集团）有限公司','中建','独资','房地产',1,'北京',NULL,1),(3,'比亚迪股份有限公司','比亚迪','股份制','制造业',0,'深圳',NULL,1),(4,'比亚迪汽车工业有限公司','比亚迪','合资','制造业',1,'深圳',NULL,1),(5,'比亚迪汽车有限公司','比亚迪','合资','制造业',1,'西安',NULL,1),(6,'西安比亚迪电子有限公司','比亚迪','独资','制造业',2,'西安',NULL,1),(7,'无锡幸福基业房地产开发有限公司',NULL,NULL,NULL,0,NULL,NULL,0),(8,'新乡御景置业有限公司','恒大','全资','房地产业',2,'',NULL,1),(9,'恒生银行','恒生','国有','金融业',0,'','',1),(10,'','恒大地产',NULL,NULL,0,NULL,NULL,0),(11,'恒大地产集团珠三角房地产开发有限公司','恒大地产',NULL,NULL,0,NULL,NULL,0),(12,'','龙湖地产',NULL,NULL,0,NULL,NULL,0);

/*Table structure for table `b_admin` */

DROP TABLE IF EXISTS `b_admin`;

CREATE TABLE `b_admin` (
  `_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `_name` varchar(128) NOT NULL COMMENT '登录名',
  `_pwd` varchar(128) NOT NULL COMMENT '登录密码',
  PRIMARY KEY (`_id`),
  UNIQUE KEY `name_index` (`_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `b_admin` */

insert  into `b_admin`(`_id`,`_name`,`_pwd`) values (1,'billman','c4644008c86ea3aaa6520b3895722fc4'),(2,'admin','0e40fb451b5f42df86ac880a57ea901f'),(3,'ad','123');

/*Table structure for table `b_bill` */

DROP TABLE IF EXISTS `b_bill`;

CREATE TABLE `b_bill` (
  `_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `_acceptance_id` int(11) NOT NULL COMMENT '承兑企业id',
  `_staff_id` int(11) NOT NULL COMMENT '对接人id',
  `_ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `_remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `_shortest` int(11) DEFAULT NULL COMMENT '最短期限(收票起步天数)',
  `_longest` int(11) DEFAULT NULL COMMENT '最长期限(收票最高天数)',
  `_is_bargain` int(11) DEFAULT NULL COMMENT '合同0-不是、1-是',
  `_is_invoice` int(11) DEFAULT NULL COMMENT '发票0-不是（默认）、1-是',
  `_agreement` int(11) DEFAULT NULL COMMENT '质押协议0-否(默认)、1-是',
  `_is_moneyorback` int(11) DEFAULT NULL COMMENT '先款先背0-先款（默认）、1-先背',
  `_is_financing` int(11) DEFAULT NULL COMMENT '融资票0-不是（默认）、1-是',
  `_is_clean` int(11) DEFAULT NULL COMMENT '光票0-不是（默认）、1-是',
  `_endorse_time` int(11) DEFAULT NULL COMMENT '背书次数限制',
  `_adjuest` int(11) DEFAULT NULL COMMENT '调整天数',
  `_rate` decimal(6,2) DEFAULT '0.00' COMMENT '利率',
  `_status` int(11) DEFAULT '0' COMMENT '状态0-正常（默认）、1-已关闭',
  `_level` int(11) DEFAULT '0' COMMENT '优先级0-默认',
  `_total` decimal(18,6) DEFAULT '0.000000' COMMENT '总额度',
  `_usable` decimal(18,6) DEFAULT '0.000000' COMMENT '可用额度',
  `_max` varchar(255) DEFAULT NULL COMMENT '票面最大金额（收票单张上限金额(万)）',
  `_min` decimal(18,6) DEFAULT '0.000000' COMMENT '最小金额(收票单张起步金额(万))',
  `_offer` int(11) DEFAULT '0' COMMENT '报价方式',
  `_deductions` decimal(14,2) DEFAULT '0.00' COMMENT '每十万扣费',
  `_direct` decimal(14,2) DEFAULT '0.00' COMMENT '直接扣？%',
  PRIMARY KEY (`_id`),
  KEY `FKn1qgpcitx5qm16y0ufkojlbx8` (`_acceptance_id`),
  KEY `FKqkdrjw8g779fsk2l9ot2t0lun` (`_staff_id`),
  CONSTRAINT `FKn1qgpcitx5qm16y0ufkojlbx8` FOREIGN KEY (`_acceptance_id`) REFERENCES `b_acceptance` (`_id`),
  CONSTRAINT `FKqkdrjw8g779fsk2l9ot2t0lun` FOREIGN KEY (`_staff_id`) REFERENCES `b_staff` (`_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;

/*Data for the table `b_bill` */

insert  into `b_bill`(`_id`,`_acceptance_id`,`_staff_id`,`_ctime`,`_remark`,`_shortest`,`_longest`,`_is_bargain`,`_is_invoice`,`_agreement`,`_is_moneyorback`,`_is_financing`,`_is_clean`,`_endorse_time`,`_adjuest`,`_rate`,`_status`,`_level`,`_total`,`_usable`,`_max`,`_min`,`_offer`,`_deductions`,`_direct`) values (1,4,1,'2018-05-22 16:48:39','',90,360,0,0,0,1,0,0,1,3,'8.00',0,0,'0.000000',NULL,'1000.00','10.000000',0,'0.00','0.00'),(2,4,2,'2018-05-29 12:09:37',NULL,30,360,1,1,1,1,1,1,2,4,'9.00',0,1,'500000.000000','0.000000','不限','10000.000000',0,'0.00','0.00'),(3,10,70,'2018-06-02 16:05:55',NULL,90,360,1,1,1,1,0,0,1,3,'16.00',0,0,'20000.000000','20000.000000','不限制','1.000000',0,'0.00','0.00'),(4,11,2,'2018-06-02 16:05:55',NULL,30,360,0,0,0,0,1,1,3,0,'0.00',0,0,'1000.000000','800.000000','200','5.000000',1,'23500.00','0.00'),(5,12,1,'2018-06-02 16:20:45','',30,360,1,1,1,1,0,0,1,5,'16.50',0,0,'20000.000000','20000.000000','10000','1.000000',0,'0.00','0.00'),(6,10,72,'2018-06-02 16:38:22',NULL,90,360,1,1,1,1,0,0,1,3,'16.00',0,0,'20000.000000','20000.000000','不限制','1.000000',0,'0.00','0.00'),(12,10,78,'2018-06-02 16:43:18',NULL,90,360,1,1,1,1,0,0,1,3,'16.00',0,0,'20000.000000','20000.000000','不限制','1.000000',0,'0.00','0.00');

/*Table structure for table `b_card` */

DROP TABLE IF EXISTS `b_card`;

CREATE TABLE `b_card` (
  `_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `_addr` varchar(255) DEFAULT NULL COMMENT '地址',
  `_company` varchar(255) DEFAULT NULL COMMENT '公司名称',
  `_name` varchar(255) NOT NULL COMMENT '姓名',
  `_phone` varchar(13) DEFAULT NULL COMMENT '手机',
  `_tel` varchar(20) DEFAULT NULL COMMENT '固话',
  `_user_id` int(11) NOT NULL COMMENT '用户id',
  PRIMARY KEY (`_id`),
  UNIQUE KEY `user_index` (`_user_id`),
  CONSTRAINT `FK6hwvo6ucebbkcmpq2r59m38no` FOREIGN KEY (`_user_id`) REFERENCES `b_user` (`_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

/*Data for the table `b_card` */

insert  into `b_card`(`_id`,`_addr`,`_company`,`_name`,`_phone`,`_tel`,`_user_id`) values (1,'测试地址A','测试公司A','特斯拉','15012341234','12345678',1),(2,'广州大学城厄23123123','广州闻喜信息科技有限公司','卢磊','18620810370','28107743',3),(3,'狗市','刚刚','奔奔','15999931712','966',5),(4,'测试地址0319','测试公司0319','测试用户01','15088888888','12345678',6),(5,'com','wxkj','鞠婧祎','13111122222','4483855',9),(6,NULL,'大象慧云信息技术有限公司','王娜','13011805177',NULL,11),(7,'gz','www','芝芝','13111122222','4483855',12),(8,'gz','albb','东方','13111122222','4483855',18),(9,'广州大学城','广州闻喜信息科技有限公司','陆磊','18620810370','02028107743',23);

/*Table structure for table `b_constant` */

DROP TABLE IF EXISTS `b_constant`;

CREATE TABLE `b_constant` (
  `_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `_name` varchar(255) NOT NULL COMMENT '常量名',
  `_remark` varchar(255) DEFAULT NULL COMMENT '常量名',
  `_value` varchar(255) NOT NULL COMMENT '常量值',
  PRIMARY KEY (`_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `b_constant` */

/*Table structure for table `b_datadic` */

DROP TABLE IF EXISTS `b_datadic`;

CREATE TABLE `b_datadic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_Dic_Name` varchar(255) DEFAULT NULL COMMENT '数据字典名',
  `data_Dic_Value` varchar(255) DEFAULT NULL COMMENT '数据字典值',
  PRIMARY KEY (`id`),
  KEY `FK_b_datadic` (`data_Dic_Value`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `b_datadic` */

insert  into `b_datadic`(`id`,`data_Dic_Name`,`data_Dic_Value`) values (1,'企业类别','国有'),(2,'企业类别','股份制'),(3,'企业类别','合资'),(4,'企业类别','独资'),(5,'企业性质','制造业'),(6,'企业类别','全资'),(7,'企业性质','房地产业'),(8,'企业性质','金融业'),(9,'企业性质','建筑业'),(10,'企业性质','金属业'),(11,'企业性质','电力业');

/*Table structure for table `b_inventory` */

DROP TABLE IF EXISTS `b_inventory`;

CREATE TABLE `b_inventory` (
  `_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `_user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `_userbyadmin_id` int(11) DEFAULT NULL COMMENT '管理员建用户id',
  `_company` varchar(255) NOT NULL COMMENT '开票企业名称',
  `_img_front` varchar(255) NOT NULL COMMENT '商票正面',
  `_img_back` varchar(255) DEFAULT NULL COMMENT '背书面',
  `_money` decimal(18,6) NOT NULL DEFAULT '0.000000' COMMENT '金额（万）',
  `_ctime` varchar(255) NOT NULL COMMENT '出票日期',
  `_dtime` varchar(255) NOT NULL COMMENT '到期日期',
  `_ttime` varchar(255) DEFAULT NULL COMMENT '贴现日',
  `_offer` varchar(255) DEFAULT NULL COMMENT '接受价额',
  PRIMARY KEY (`_id`),
  KEY `FKib2f8yto8m3t5xe0jbf8ggj2c` (`_user_id`),
  KEY `FKhlr0sayke0cl3nfkukkunwg7o` (`_userbyadmin_id`),
  CONSTRAINT `FKhlr0sayke0cl3nfkukkunwg7o` FOREIGN KEY (`_userbyadmin_id`) REFERENCES `b_userbyadmin` (`id`),
  CONSTRAINT `FKib2f8yto8m3t5xe0jbf8ggj2c` FOREIGN KEY (`_user_id`) REFERENCES `b_user` (`_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

/*Data for the table `b_inventory` */

insert  into `b_inventory`(`_id`,`_user_id`,`_userbyadmin_id`,`_company`,`_img_front`,`_img_back`,`_money`,`_ctime`,`_dtime`,`_ttime`,`_offer`) values (1,NULL,1,'无锡幸福基业房地产开发有限公司','b73e68d3-6a44-4759-9184-a35f529a334d1526981173697无锡幸福基业房地产开发有限公司-0102.png',NULL,'120.561118','2018年2月22日','2019年2月22日','','年化17'),(2,NULL,1,'比亚迪汽车工业有限公司','fed6a639-fa81-4765-981d-a1d89019176615275635985042.jpg',NULL,'500000.000000','2018-04-02','2019-02-02','','年化16');

/*Table structure for table `b_order` */

DROP TABLE IF EXISTS `b_order`;

CREATE TABLE `b_order` (
  `_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `_ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `_day` int(11) NOT NULL DEFAULT '0' COMMENT '计息天数',
  `_img` varchar(255) NOT NULL COMMENT '商票照片',
  `_interest` decimal(14,2) NOT NULL DEFAULT '0.00' COMMENT '保理利息',
  `_money` decimal(14,2) NOT NULL DEFAULT '0.00' COMMENT '保理金额',
  `_status` int(11) NOT NULL DEFAULT '0' COMMENT '状态0-处理中、1-已处理、2-被驳回',
  `_stime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '处理时间（如果未处理则和创建时间一致）',
  `_subsidy` decimal(14,2) NOT NULL DEFAULT '0.00' COMMENT '保理金额',
  `_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '到期时间',
  `_bill_id` int(11) NOT NULL COMMENT '票据id',
  `_user_id` int(11) NOT NULL COMMENT '用户id',
  PRIMARY KEY (`_id`),
  KEY `FKh8oupea67ovk6jvn2wpev721n` (`_bill_id`),
  KEY `FKnpe7fqxvbcwtc2dtu72paeup2` (`_user_id`),
  CONSTRAINT `FKh8oupea67ovk6jvn2wpev721n` FOREIGN KEY (`_bill_id`) REFERENCES `b_bill` (`_id`),
  CONSTRAINT `FKnpe7fqxvbcwtc2dtu72paeup2` FOREIGN KEY (`_user_id`) REFERENCES `b_user` (`_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

/*Data for the table `b_order` */

insert  into `b_order`(`_id`,`_ctime`,`_day`,`_img`,`_interest`,`_money`,`_status`,`_stime`,`_subsidy`,`_time`,`_bill_id`,`_user_id`) values (1,'2018-05-30 14:04:22',368,'https://xcx.wenxikeji.com/bill360/upload/b73e68d3-6a44-4759-9184-a35f529a334d1526981173697无锡幸福基业房地产开发有限公司-0102.png','14311.12','200000.00',0,'2018-05-22 16:04:22','10000.00','2019-05-22 16:04:22',1,1),(2,'2018-06-02 15:20:20',259,'https://xcx.wenxikeji.com/bill360/upload/c8018457-f920-495e-9602-bad9d0746b291527923395330wxc14f10b94e87d428.o6zAJsxCXuIf3kzY8lkfY4R6rv7I.jtUz9eCtzgk65ef6ae7d5e05384c841136145b52b69b.jpg','3237.50','50000.00',0,'2018-06-02 15:20:20','50000.00','2019-02-12 00:00:00',2,5),(3,'2018-06-02 15:25:05',258,'https://xcx.wenxikeji.com/bill360/upload/9eec7504-d2d5-4f51-aa81-4f4393dc507f1527924221127wxc14f10b94e87d428.o6zAJsxCXuIf3kzY8lkfY4R6rv7I.ejUifb8W6U5B5ef6ae7d5e05384c841136145b52b69b.jpg','2866.66','50000.00',0,'2018-06-02 15:25:05','50000.00','2019-02-12 00:00:00',1,5),(4,'2018-06-02 15:30:17',369,'https://xcx.wenxikeji.com/bill360/upload/b64fb5cb-5b06-40cc-a02b-6b6eac637f621527924508299tmp_0bcce1dc1760bf567bba26588d13a12e906e4793fc4c58f9.jpg','13120.02','160000.00',0,'2018-06-02 15:30:17','160000.00','2019-06-02 00:00:00',1,5),(5,'2018-06-03 10:55:53',301,'https://xcx.wenxikeji.com/bill360/upload/73b60167-fa92-4238-913c-4f6a24f358e41527994509424tmp_1c9b832846bcad53031a6c2754de55965d825ee90dc5f5ac.jpg','3344.44','50000.00',0,'2018-06-03 10:55:53','50000.00','2019-03-28 00:00:00',1,5),(6,'2018-06-04 09:20:34',257,'https://xcx.wenxikeji.com/bill360/upload/e91c1316-9e7a-4d31-a872-d0ff674891761528075119502wxc14f10b94e87d428.o6zAJsxCXuIf3kzY8lkfY4R6rv7I.2HBhd8fshsOm5ef6ae7d5e05384c841136145b52b69b.jpg','3212.50','50000.00',0,'2018-06-04 09:20:34','50000.00','2019-02-12 00:00:00',2,5);

/*Table structure for table `b_pwd` */

DROP TABLE IF EXISTS `b_pwd`;

CREATE TABLE `b_pwd` (
  `_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `_openid` varchar(128) NOT NULL COMMENT '微信openid',
  `_phone` varchar(13) DEFAULT NULL COMMENT '手机号',
  `_user_id` int(11) NOT NULL COMMENT '用户id',
  PRIMARY KEY (`_id`),
  UNIQUE KEY `user_index` (`_user_id`),
  UNIQUE KEY `openid_index` (`_openid`),
  CONSTRAINT `FK8lg9rfou6e23fayfyqjid6hyp` FOREIGN KEY (`_user_id`) REFERENCES `b_user` (`_id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4;

/*Data for the table `b_pwd` */

insert  into `b_pwd`(`_id`,`_openid`,`_phone`,`_user_id`) values (1,'test','13888888888',1),(2,'wx0d576ce5f10b4260',NULL,2),(3,'','17612085835',3),(4,'ov0Dq0ODwMS2NE4tUVsEmu6eIuSQ',NULL,4),(5,'null','15012920449',5),(6,'slience','13888888889',6),(9,'olxjW5QP5skqa5IeoPBX2VxdT9zo','17665126221',9),(10,'olxjW5c_bk_6mAzFpgyDYD4z1zaw',NULL,10),(11,'olxjW5bjUoAeesx-HfpQd72BOEuw',NULL,11),(12,'olxjW5R4T2J_NSKDwFvCdSD2fnHw',NULL,12),(13,'olxjW5SQHP7xPodkAh74TJtpacMA',NULL,13),(14,'olxjW5TMYxcCYDW2aXKQyEbN0LM4',NULL,14),(15,'olxjW5ZqLx8s6u9wU1tutUImDxqw',NULL,15),(16,'olxjW5WPeQL4GbO-vl7vI5m0Q3bw',NULL,16),(17,'olxjW5VwUQ7Qqj0Y8hqp-CBANaD8',NULL,17),(18,'olxjW5ctxtP9-v7_F6g1wkpnEmvQ',NULL,18),(19,'olxjW5RKHzwgKLMUvqtPpb9JHd4g',NULL,19),(20,'olxjW5Xcd7PFM8FXBUdifUKKZNhU',NULL,20),(21,'olxjW5aMd1uOyvYb-ZqB9J33Iqus',NULL,21),(22,'olxjW5XOhNTgg-8cZ479sI9DkPnA',NULL,22),(23,'olxjW5ZNRGiPvG--QPku_e4QS7W4','18620810370',23),(24,'olxjW5YRzYQW9c2H9rz42HlVRclg',NULL,24),(25,'olxjW5cmAQdYbX8ckbFdMH6qxlfQ',NULL,25),(26,'olxjW5SbMGRNQlHMhMGIRHqTehVU',NULL,26),(27,'olxjW5c7_Ia1H49G1LBdgqkACYOw',NULL,27),(28,'olxjW5ST8Pt6QUf-6wL36v_1w4RA',NULL,28),(29,'olxjW5fURREHlu0ZgRLRQuJPkEus',NULL,29),(30,'olxjW5ZoWwsv1oSNJWvTl7pK1O5g',NULL,30),(31,'olxjW5S-KDSxpC-VgRuVej1UDjWw',NULL,31),(32,'olxjW5QYBA49jUKHHnXoDhXWfaDY',NULL,32),(33,'olxjW5U0fou5a6WAkr9YL9rX4P7E',NULL,33),(34,'olxjW5XeZ068lqZ1TIJZThXh8CGQ',NULL,34),(35,'olxjW5Qvp6xpSAsEuq5vdjOnBZXw',NULL,35),(36,'olxjW5SX5OcjzrfVN5gHRmgmkZhM',NULL,36),(38,'olxjW5eciGaHJXhbZH7bCYYKwOjY',NULL,38),(39,'olxjW5V3aopLCa_ZDHHWDM6IOpvg',NULL,39),(40,'olxjW5dCL6vGaGXCR0Y8GcO-u_V4',NULL,40),(41,'olxjW5VwidGadhysV0uiwCLD5uMw',NULL,41),(42,'olxjW5dr_furEB-5yUgahQJjl1aA',NULL,42),(43,'olxjW5bKFIWqpNoys3-nYHXoCfI4',NULL,43),(44,'olxjW5QQ7gAdA5iv4iUE8rAVxv8Y',NULL,44);

/*Table structure for table `b_record` */

DROP TABLE IF EXISTS `b_record`;

CREATE TABLE `b_record` (
  `_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `_word` varchar(255) NOT NULL COMMENT '查询关键字',
  `_user_id` int(11) NOT NULL COMMENT '用户id',
  PRIMARY KEY (`_id`),
  KEY `FKspd5skq6u21ilsrxfs8dtiw36` (`_user_id`),
  CONSTRAINT `FKspd5skq6u21ilsrxfs8dtiw36` FOREIGN KEY (`_user_id`) REFERENCES `b_user` (`_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4;

/*Data for the table `b_record` */

insert  into `b_record`(`_id`,`_time`,`_word`,`_user_id`) values (5,'2018-06-04 18:40:25','恒大',5),(6,'2018-05-22 17:43:34','恒大',19),(7,'2018-05-23 17:49:31','恒大',23),(8,'2018-06-04 17:45:49','比亚迪',5),(9,'2018-06-04 17:02:53','ww',5),(10,'2018-05-28 15:09:07','da',5),(11,'2018-05-28 15:08:57','ow',5),(12,'2018-06-02 11:01:28','中建',5),(13,'2018-06-04 17:04:36','恒',5),(14,'2018-06-04 17:02:22','恒大地产',5),(15,'2018-06-04 16:57:21','钉钉',5),(16,'2018-06-04 17:17:23','恒大',44),(17,'2018-06-04 17:17:50','中建',44),(18,'2018-06-04 17:18:51','f\'f',5);

/*Table structure for table `b_staff` */

DROP TABLE IF EXISTS `b_staff`;

CREATE TABLE `b_staff` (
  `_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `_name` varchar(255) NOT NULL COMMENT '对接人姓名',
  `_company` varchar(255) NOT NULL COMMENT '公司',
  `_endorse_company` varchar(255) DEFAULT NULL COMMENT '背书公司名',
  `_endorse_account` varchar(255) DEFAULT NULL COMMENT '背书账号',
  `_phone` varchar(255) DEFAULT NULL COMMENT '联系电话',
  `_wechat` varchar(255) DEFAULT NULL COMMENT '微信id',
  `_addr` varchar(255) DEFAULT NULL COMMENT '地址',
  `_area` varchar(255) DEFAULT NULL COMMENT '地区',
  `_business_license` varchar(255) DEFAULT NULL COMMENT '营业执照号',
  `_business_license_photo` varchar(255) DEFAULT NULL COMMENT '营业执照（照片）',
  `_legal_person_name` varchar(255) DEFAULT NULL COMMENT '法人姓名',
  `_idCard_front` varchar(255) DEFAULT NULL COMMENT '法人身份证（正面）',
  `_idCard_back` varchar(255) DEFAULT NULL COMMENT '法人身份证(反面)',
  `_id_card_back` varchar(255) DEFAULT NULL COMMENT '法人身份证(反面)',
  `_id_card_front` varchar(255) DEFAULT NULL COMMENT '法人身份证(正面)',
  PRIMARY KEY (`_id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4;

/*Data for the table `b_staff` */

insert  into `b_staff`(`_id`,`_name`,`_company`,`_endorse_company`,`_endorse_account`,`_phone`,`_wechat`,`_addr`,`_area`,`_business_license`,`_business_license_photo`,`_legal_person_name`,`_idCard_front`,`_idCard_back`,`_id_card_back`,`_id_card_front`) values (1,'李定韬','深圳前海票牛牛商业保理有限公司',NULL,'0','17322009880',NULL,'深圳市福田区卓越世纪中心4号楼38A',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,'张德智','深圳前海票牛牛商业保理有限公司',NULL,'0','18218818432',NULL,'深圳市福田区卓越世纪中心4号楼38A',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,'苏杰','天云生辉',NULL,'0','15981898595',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(70,'张德智','国昇保理',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(71,'张德智','票牛牛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(72,'苏杰','天云生辉',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(73,'张德智','票牛牛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(74,'苏杰','天云生辉',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(75,'张德智','票牛牛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(76,'苏杰','天云生辉',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(77,'张德智','票牛牛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(78,'苏杰','天云生辉',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(79,'张德智','票牛牛',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `b_user` */

DROP TABLE IF EXISTS `b_user`;

CREATE TABLE `b_user` (
  `_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `_card` int(11) NOT NULL DEFAULT '0' COMMENT '是否上传了名片0-未上传、1-已上传',
  `_head` varchar(255) NOT NULL DEFAULT 'user-head.png' COMMENT '用户头像',
  `_name` varchar(255) NOT NULL DEFAULT '查票360' COMMENT '用户名-微信昵称',
  `_precise` int(11) NOT NULL DEFAULT '0' COMMENT '精确搜索次数',
  `_reg` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `_status` int(11) NOT NULL DEFAULT '0' COMMENT '用户状态0-正常（默认）、1-管理员锁定',
  `_type` int(11) NOT NULL DEFAULT '0' COMMENT '用户类型0-未绑定手机、1-已绑定手机',
  PRIMARY KEY (`_id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4;

/*Data for the table `b_user` */

insert  into `b_user`(`_id`,`_card`,`_head`,`_name`,`_precise`,`_reg`,`_status`,`_type`) values (1,1,'user-head.png','查票360',0,'2018-02-01 15:15:32',0,0),(2,0,'user-head.png','查票360',0,'2018-02-26 16:18:55',0,0),(3,1,'user-head.png','查票360',5,'2018-02-27 16:25:35',0,0),(4,0,'user-head.png','查票360',1,'2018-02-28 09:57:52',0,0),(5,1,'user-head.png','查票360',5,'2018-03-05 16:16:59',0,1),(6,1,'user-head.png','查票360',0,'2018-03-16 09:48:47',0,0),(9,1,'13e5433e-f25b-4e7f-bcd2-75b7634fd4c51521535281982.jpg','ARLEN?',4,'2018-03-20 16:41:22',0,0),(10,0,'f702caff-4a12-4609-a4e8-eb202178b3d21521613804669.jpg','™瘾℡',0,'2018-03-21 14:30:04',0,0),(11,1,'36cad4ba-9efc-458c-b22a-8cba9bf7d8e21521699787231.jpg','娜娜',0,'2018-03-22 14:23:07',0,0),(12,1,'69162e40-4af1-452e-84f4-18f3242199ca1521722614386.jpg','守望者',3,'2018-03-22 20:43:34',0,0),(13,0,'27966990-a4a3-43f8-b419-3ed3a1353e811521777652904.jpg','Dennis张德智',5,'2018-03-23 12:00:53',0,0),(14,0,'user-head.png','rdgztest_HYKEMQ',0,'2018-03-24 01:12:10',0,0),(15,0,'user-head.png','rdgztest_HJVTQF',0,'2018-03-24 10:07:53',0,0),(16,0,'user-head.png','rdgztest_VPOJJJ',0,'2018-03-24 10:07:54',0,0),(17,0,'user-head.png','rdgztest_JVFHTH',0,'2018-03-24 10:07:56',0,0),(18,1,'94b42798-e5e9-408d-931d-2b09fdfcee871521859775435.jpg','你说什么名字咧',5,'2018-03-24 10:49:35',0,0),(19,0,'11ede584-7fd9-4219-91d4-34ed06acc1da1522023294310.jpg','Boom(李定韬)',4,'2018-03-26 08:14:54',0,0),(20,0,'57be8acd-c30a-47e5-a41d-81f9614d37a91522057382779.jpg','悲伤中的沉默',0,'2018-03-26 17:43:02',0,0),(21,0,'23335031-3c01-4554-9ed3-3efad7df5d541522072412591.jpg','A.张老板',0,'2018-03-26 21:53:32',0,0),(22,0,'user-head.png','rdgztest_ZEZUBE',0,'2018-03-27 03:43:25',0,0),(23,1,'59c17590-853f-4435-9979-0b1a5d2ba7611522117225841.jpg','All-App开发',0,'2018-03-27 10:20:26',0,1),(24,0,'a302ac8d-5d02-48a3-a666-977115508ebb1522128313825.jpg','Sandy',0,'2018-03-27 13:25:14',0,0),(25,0,'b2e23c82-a6ad-4db9-89ba-80aa669dfcdb1522133250950.jpg','夸克',0,'2018-03-27 14:47:31',0,0),(26,0,'user-head.png','rdgztest_DWOMTK',0,'2018-03-27 19:14:58',0,0),(27,0,'de42803f-46b6-4d6c-9c4a-4937be8c4fd31522200305353.jpg','乔伊悦',0,'2018-03-28 09:25:05',0,0),(28,0,'a37aba53-4c06-4e6c-bf1d-0b60536a70fd1522304202071.jpg','热爱生活，拥抱人生',0,'2018-03-29 14:16:42',0,0),(29,0,'7d3b0884-e20e-40b1-98e9-5021786e934d1522313163556.jpg','哥こ的小脾气う',0,'2018-03-29 16:46:03',0,0),(30,0,'7e3821e6-bebf-440a-9527-89ac0965f83e1522336867509.jpg','乄古→玩?',0,'2018-03-29 23:21:07',0,0),(31,0,'53f516df-e9be-4ca4-bc8b-f0d8ac6695891522367152056.jpg','　',0,'2018-03-30 07:45:52',0,0),(32,0,'000d2bde-f104-4b0d-a714-4abc8511a7921522432816573.jpg','miss  u',0,'2018-03-31 02:00:16',0,0),(33,0,'8b37fbfe-e75a-4fa9-b8f8-54f950873af31522468380963.jpg','Anne',0,'2018-03-31 11:53:01',0,0),(34,0,'47104615-55fe-40d0-b027-bbf8ad80fd1d1522633456056.jpg','Donte(定韬)',0,'2018-04-02 09:44:16',0,0),(35,0,'a9ec3d0c-92e0-4807-bdb5-2ce606eb9a111522640368837.jpg','L',0,'2018-04-02 11:39:29',0,0),(36,0,'bb08d4fa-889a-4fef-b6c2-629564d67d191526887643713.jpg','海子',0,'2018-05-21 15:27:23',0,0),(38,0,'45cdba11-bdf4-4012-b319-f3891c2757981527039360041.jpg','kiss',0,'2018-05-23 09:36:00',0,0),(39,0,'dfe599da-bcc6-414c-813c-4c89121753a51527164138298.jpg','A.? 张大大',0,'2018-05-24 20:15:38',0,0),(40,0,'aa6c6f8b-5c9b-4b6c-bf4c-0d59646ab4491527196716064.jpg','我家大宝秋',0,'2018-05-25 05:18:36',0,0),(41,0,'cebb8058-1ebf-45df-a546-09eff80a87f71527396348955.jpg','回忆过去',0,'2018-05-27 12:45:49',0,0),(42,0,'a6dc37fb-56c5-4aa6-b764-3aa7a78292161527674873517.jpg','Lover文⁰⁹¹¹',0,'2018-05-30 18:07:53',0,0),(43,0,'59c4f894-d58c-43ac-991c-c81c9f82a7281527922098283.jpg','坠落的流星',0,'2018-06-02 14:48:18',0,0),(44,0,'9cdebe78-82fa-409d-b323-00574d4531e21528103626928.jpg','Billing',0,'2018-06-04 17:13:47',0,0);

/*Table structure for table `b_userbyadmin` */

DROP TABLE IF EXISTS `b_userbyadmin`;

CREATE TABLE `b_userbyadmin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `addr` varchar(255) DEFAULT NULL COMMENT '地址',
  `company` varchar(255) DEFAULT NULL COMMENT '公司名称',
  `name` varchar(255) NOT NULL COMMENT '姓名',
  `phone` varchar(13) DEFAULT NULL COMMENT '手机',
  `wechat` varchar(255) DEFAULT NULL COMMENT '微信号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `b_userbyadmin` */

insert  into `b_userbyadmin`(`id`,`addr`,`company`,`name`,`phone`,`wechat`) values (1,'深圳市福田区卓越世纪中心4号楼38A','深圳前海票牛牛商业保理有限公司','李定韬','17322009880','L852007549');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
