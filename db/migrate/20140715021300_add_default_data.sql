-- MySQL dump 10.13  Distrib 5.1.46, for slackware-linux-gnu (i486)
--
-- Host: localhost    Database: projecttasktodo
-- ------------------------------------------------------
-- Server version	5.1.46-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` (`id`, `name`, `alpha2`, `alpha3`, `numeric_id`, `iso3166_2`, `continent_id`) VALUES (1,'Afghanistan','AF','AFG',4,'ISO 3166-2:AF',NULL),(2,'Aland Islands','AX','ALA',248,'ISO 3166-2:AX',NULL),(3,'Albania','AL','ALB',8,'ISO 3166-2:AL',NULL),(4,'Algeria','DZ','DZA',12,'ISO 3166-2:DZ',NULL),(5,'American Samoa','AS','ASM',16,'ISO 3166-2:AS',NULL),(6,'Andorra','AD','AND',20,'ISO 3166-2:AD',NULL),(7,'Angola','AO','AGO',24,'ISO 3166-2:AO',NULL),(8,'Anguilla','AI','AIA',660,'ISO 3166-2:AI',NULL),(9,'Antarctica','AQ','ATA',10,'ISO 3166-2:AQ',NULL),(10,'Antigua and Barbuda','AG','ATG',28,'ISO 3166-2:AG',NULL),(11,'Argentina','AR','ARG',32,'ISO 3166-2:AR',NULL),(12,'Armenia','AM','ARM',51,'ISO 3166-2:AM',NULL),(13,'Aruba','AW','ABW',533,'ISO 3166-2:AW',NULL),(14,'Australia','AU','AUS',36,'ISO 3166-2:AU',NULL),(15,'Austria','AT','AUT',40,'ISO 3166-2:AT',NULL),(16,'Azerbaijan','AZ','AZE',31,'ISO 3166-2:AZ',NULL),(17,'Bahamas','BS','BHS',44,'ISO 3166-2:BS',NULL),(18,'Bahrain','BH','BHR',48,'ISO 3166-2:BH',NULL),(19,'Bangladesh','BD','BGD',50,'ISO 3166-2:BD',NULL),(20,'Barbados','BB','BRB',52,'ISO 3166-2:BB',NULL),(21,'Belarus','BY','BLR',112,'ISO 3166-2:BY',NULL),(22,'Belgium','BE','BEL',56,'ISO 3166-2:BE',NULL),(23,'Belize','BZ','BLZ',84,'ISO 3166-2:BZ',NULL),(24,'Benin','BJ','BEN',204,'ISO 3166-2:BJ',NULL),(25,'Bermuda','BM','BMU',60,'ISO 3166-2:BM',NULL),(26,'Bhutan','BT','BTN',64,'ISO 3166-2:BT',NULL),(27,'Bolivia, Plurinational State of','BO','BOL',68,'ISO 3166-2:BO',NULL),(28,'Bonaire, Sint Eustatius and Saba','BQ','BES',535,'ISO 3166-2:BQ',NULL),(29,'Bosnia and Herzegovina','BA','BIH',70,'ISO 3166-2:BA',NULL),(30,'Botswana','BW','BWA',72,'ISO 3166-2:BW',NULL),(31,'Bouvet Island','BV','BVT',74,'ISO 3166-2:BV',NULL),(32,'Brazil','BR','BRA',76,'ISO 3166-2:BR',NULL),(33,'British Indian Ocean Territory','IO','IOT',86,'ISO 3166-2:IO',NULL),(34,'Brunei Darussalam','BN','BRN',96,'ISO 3166-2:BN',NULL),(35,'Bulgaria','BG','BGR',100,'ISO 3166-2:BG',NULL),(36,'Burkina Faso','BF','BFA',854,'ISO 3166-2:BF',NULL),(37,'Burundi','BI','BDI',108,'ISO 3166-2:BI',NULL),(38,'Cambodia','KH','KHM',116,'ISO 3166-2:KH',NULL),(39,'Cameroon','CM','CMR',120,'ISO 3166-2:CM',NULL),(40,'Canada','CA','CAN',124,'ISO 3166-2:CA',NULL),(41,'Cape Verde','CV','CPV',132,'ISO 3166-2:CV',NULL),(42,'Cayman Islands','KY','CYM',136,'ISO 3166-2:KY',NULL),(43,'Central African Republic','CF','CAF',140,'ISO 3166-2:CF',NULL),(44,'Chad','TD','TCD',148,'ISO 3166-2:TD',NULL),(45,'Chile','CL','CHL',152,'ISO 3166-2:CL',NULL),(46,'China','CN','CHN',156,'ISO 3166-2:CN',NULL),(47,'Christmas Island','CX','CXR',162,'ISO 3166-2:CX',NULL),(48,'Cocos (Keeling) Islands','CC','CCK',166,'ISO 3166-2:CC',NULL),(49,'Colombia','CO','COL',170,'ISO 3166-2:CO',NULL),(50,'Comoros','KM','COM',174,'ISO 3166-2:KM',NULL),(51,'Congo','CG','COG',178,'ISO 3166-2:CG',NULL),(52,'Congo, the Democratic Republic of the','CD','COD',180,'ISO 3166-2:CD',NULL),(53,'Cook Islands','CK','COK',184,'ISO 3166-2:CK',NULL),(54,'Costa Rica','CR','CRI',188,'ISO 3166-2:CR',NULL),(55,'C.te d\'Ivoire','CI','CIV',384,'ISO 3166-2:CI',NULL),(56,'Croatia','HR','HRV',191,'ISO 3166-2:HR',NULL),(57,'Cuba','CU','CUB',192,'ISO 3166-2:CU',NULL),(58,'Cura.ao','CW','CUW',531,'ISO 3166-2:CW',NULL),(59,'Cyprus','CY','CYP',196,'ISO 3166-2:CY',NULL),(60,'Czech Republic','CZ','CZE',203,'ISO 3166-2:CZ',NULL),(61,'Denmark','DK','DNK',208,'ISO 3166-2:DK',NULL),(62,'Djibouti','DJ','DJI',262,'ISO 3166-2:DJ',NULL),(63,'Dominica','DM','DMA',212,'ISO 3166-2:DM',NULL),(64,'Dominican Republic','DO','DOM',214,'ISO 3166-2:DO',NULL),(65,'Ecuador','EC','ECU',218,'ISO 3166-2:EC',NULL),(66,'Egypt','EG','EGY',818,'ISO 3166-2:EG',NULL),(67,'El Salvador','SV','SLV',222,'ISO 3166-2:SV',NULL),(68,'Equatorial Guinea','GQ','GNQ',226,'ISO 3166-2:GQ',NULL),(69,'Eritrea','ER','ERI',232,'ISO 3166-2:ER',NULL),(70,'Estonia','EE','EST',233,'ISO 3166-2:EE',NULL),(71,'Ethiopia','ET','ETH',231,'ISO 3166-2:ET',NULL),(72,'Falkland Islands (Malvinas)','FK','FLK',238,'ISO 3166-2:FK',NULL),(73,'Faroe Islands','FO','FRO',234,'ISO 3166-2:FO',NULL),(74,'Fiji','FJ','FJI',242,'ISO 3166-2:FJ',NULL),(75,'Finland','FI','FIN',246,'ISO 3166-2:FI',NULL),(76,'France','FR','FRA',250,'ISO 3166-2:FR',NULL),(77,'French Guiana','GF','GUF',254,'ISO 3166-2:GF',NULL),(78,'French Polynesia','PF','PYF',258,'ISO 3166-2:PF',NULL),(79,'French Southern Territories','TF','ATF',260,'ISO 3166-2:TF',NULL),(80,'Gabon','GA','GAB',266,'ISO 3166-2:GA',NULL),(81,'Gambia','GM','GMB',270,'ISO 3166-2:GM',NULL),(82,'Georgia','GE','GEO',268,'ISO 3166-2:GE',NULL),(83,'Germany','DE','DEU',276,'ISO 3166-2:DE',NULL),(84,'Ghana','GH','GHA',288,'ISO 3166-2:GH',NULL),(85,'Gibraltar','GI','GIB',292,'ISO 3166-2:GI',NULL),(86,'Greece','GR','GRC',300,'ISO 3166-2:GR',NULL),(87,'Greenland','GL','GRL',304,'ISO 3166-2:GL',NULL),(88,'Grenada','GD','GRD',308,'ISO 3166-2:GD',NULL),(89,'Guadeloupe','GP','GLP',312,'ISO 3166-2:GP',NULL),(90,'Guam','GU','GUM',316,'ISO 3166-2:GU',NULL),(91,'Guatemala','GT','GTM',320,'ISO 3166-2:GT',NULL),(92,'Guernsey','GG','GGY',831,'ISO 3166-2:GG',NULL),(93,'Guinea','GN','GIN',324,'ISO 3166-2:GN',NULL),(94,'Guinea-Bissau','GW','GNB',624,'ISO 3166-2:GW',NULL),(95,'Guyana','GY','GUY',328,'ISO 3166-2:GY',NULL),(96,'Haiti','HT','HTI',332,'ISO 3166-2:HT',NULL),(97,'Heard Island and McDonald Islands','HM','HMD',334,'ISO 3166-2:HM',NULL),(98,'Holy See (Vatican City State)','VA','VAT',336,'ISO 3166-2:VA',NULL),(99,'Honduras','HN','HND',340,'ISO 3166-2:HN',NULL),(100,'Hong Kong','HK','HKG',344,'ISO 3166-2:HK',NULL),(101,'Hungary','HU','HUN',348,'ISO 3166-2:HU',NULL),(102,'Iceland','IS','ISL',352,'ISO 3166-2:IS',NULL),(103,'India','IN','IND',356,'ISO 3166-2:IN',NULL),(104,'Indonesia','ID','IDN',360,'ISO 3166-2:ID',NULL),(105,'Iran, Islamic Republic of','IR','IRN',364,'ISO 3166-2:IR',NULL),(106,'Iraq','IQ','IRQ',368,'ISO 3166-2:IQ',NULL),(107,'Ireland','IE','IRL',372,'ISO 3166-2:IE',NULL),(108,'Isle of Man','IM','IMN',833,'ISO 3166-2:IM',NULL),(109,'Israel','IL','ISR',376,'ISO 3166-2:IL',NULL),(110,'Italy','IT','ITA',380,'ISO 3166-2:IT',NULL),(111,'Jamaica','JM','JAM',388,'ISO 3166-2:JM',NULL),(112,'Japan','JP','JPN',392,'ISO 3166-2:JP',NULL),(113,'Jersey','JE','JEY',832,'ISO 3166-2:JE',NULL),(114,'Jordan','JO','JOR',400,'ISO 3166-2:JO',NULL),(115,'Kazakhstan','KZ','KAZ',398,'ISO 3166-2:KZ',NULL),(116,'Kenya','KE','KEN',404,'ISO 3166-2:KE',NULL),(117,'Kiribati','KI','KIR',296,'ISO 3166-2:KI',NULL),(118,'Korea, Democratic People\'s Republic of','KP','PRK',408,'ISO 3166-2:KP',NULL),(119,'Korea, Republic of','KR','KOR',410,'ISO 3166-2:KR',NULL),(120,'Kuwait','KW','KWT',414,'ISO 3166-2:KW',NULL),(121,'Kyrgyzstan','KG','KGZ',417,'ISO 3166-2:KG',NULL),(122,'Lao People\'s Democratic Republic','LA','LAO',418,'ISO 3166-2:LA',NULL),(123,'Latvia','LV','LVA',428,'ISO 3166-2:LV',NULL),(124,'Lebanon','LB','LBN',422,'ISO 3166-2:LB',NULL),(125,'Lesotho','LS','LSO',426,'ISO 3166-2:LS',NULL),(126,'Liberia','LR','LBR',430,'ISO 3166-2:LR',NULL),(127,'Libya','LY','LBY',434,'ISO 3166-2:LY',NULL),(128,'Liechtenstein','LI','LIE',438,'ISO 3166-2:LI',NULL),(129,'Lithuania','LT','LTU',440,'ISO 3166-2:LT',NULL),(130,'Luxembourg','LU','LUX',442,'ISO 3166-2:LU',NULL),(131,'Macao','MO','MAC',446,'ISO 3166-2:MO',NULL),(132,'Macedonia, the former Yugoslav Republic of','MK','MKD',807,'ISO 3166-2:MK',NULL),(133,'Madagascar','MG','MDG',450,'ISO 3166-2:MG',NULL),(134,'Malawi','MW','MWI',454,'ISO 3166-2:MW',NULL),(135,'Malaysia','MY','MYS',458,'ISO 3166-2:MY',NULL),(136,'Maldives','MV','MDV',462,'ISO 3166-2:MV',NULL),(137,'Mali','ML','MLI',466,'ISO 3166-2:ML',NULL),(138,'Malta','MT','MLT',470,'ISO 3166-2:MT',NULL),(139,'Marshall Islands','MH','MHL',584,'ISO 3166-2:MH',NULL),(140,'Martinique','MQ','MTQ',474,'ISO 3166-2:MQ',NULL),(141,'Mauritania','MR','MRT',478,'ISO 3166-2:MR',NULL),(142,'Mauritius','MU','MUS',480,'ISO 3166-2:MU',NULL),(143,'Mayotte','YT','MYT',175,'ISO 3166-2:YT',NULL),(144,'Mexico','MX','MEX',484,'ISO 3166-2:MX',NULL),(145,'Micronesia, Federated States of','FM','FSM',583,'ISO 3166-2:FM',NULL),(146,'Moldova, Republic of','MD','MDA',498,'ISO 3166-2:MD',NULL),(147,'Monaco','MC','MCO',492,'ISO 3166-2:MC',NULL),(148,'Mongolia','MN','MNG',496,'ISO 3166-2:MN',NULL),(149,'Montenegro','ME','MNE',499,'ISO 3166-2:ME',NULL),(150,'Montserrat','MS','MSR',500,'ISO 3166-2:MS',NULL),(151,'Morocco','MA','MAR',504,'ISO 3166-2:MA',NULL),(152,'Mozambique','MZ','MOZ',508,'ISO 3166-2:MZ',NULL),(153,'Myanmar','MM','MMR',104,'ISO 3166-2:MM',NULL),(154,'Namibia','NA','NAM',516,'ISO 3166-2:NA',NULL),(155,'Nauru','NR','NRU',520,'ISO 3166-2:NR',NULL),(156,'Nepal','NP','NPL',524,'ISO 3166-2:NP',NULL),(157,'Netherlands','NL','NLD',528,'ISO 3166-2:NL',NULL),(158,'New Caledonia','NC','NCL',540,'ISO 3166-2:NC',NULL),(159,'New Zealand','NZ','NZL',554,'ISO 3166-2:NZ',NULL),(160,'Nicaragua','NI','NIC',558,'ISO 3166-2:NI',NULL),(161,'Niger','NE','NER',562,'ISO 3166-2:NE',NULL),(162,'Nigeria','NG','NGA',566,'ISO 3166-2:NG',NULL),(163,'Niue','NU','NIU',570,'ISO 3166-2:NU',NULL),(164,'Norfolk Island','NF','NFK',574,'ISO 3166-2:NF',NULL),(165,'Northern Mariana Islands','MP','MNP',580,'ISO 3166-2:MP',NULL),(166,'Norway','NO','NOR',578,'ISO 3166-2:NO',NULL),(167,'Oman','OM','OMN',512,'ISO 3166-2:OM',NULL),(168,'Pakistan','PK','PAK',586,'ISO 3166-2:PK',NULL),(169,'Palau','PW','PLW',585,'ISO 3166-2:PW',NULL),(170,'Palestinian Territory, Occupied','PS','PSE',275,'ISO 3166-2:PS',NULL),(171,'Panama','PA','PAN',591,'ISO 3166-2:PA',NULL),(172,'Papua New Guinea','PG','PNG',598,'ISO 3166-2:PG',NULL),(173,'Paraguay','PY','PRY',600,'ISO 3166-2:PY',NULL),(174,'Peru','PE','PER',604,'ISO 3166-2:PE',NULL),(175,'Philippines','PH','PHL',608,'ISO 3166-2:PH',NULL),(176,'Pitcairn','PN','PCN',612,'ISO 3166-2:PN',NULL),(177,'Poland','PL','POL',616,'ISO 3166-2:PL',NULL),(178,'Portugal','PT','PRT',620,'ISO 3166-2:PT',NULL),(179,'Puerto Rico','PR','PRI',630,'ISO 3166-2:PR',NULL),(180,'Qatar','QA','QAT',634,'ISO 3166-2:QA',NULL),(181,'R.union','RE','REU',638,'ISO 3166-2:RE',NULL),(182,'Romania','RO','ROU',642,'ISO 3166-2:RO',NULL),(183,'Russian Federation','RU','RUS',643,'ISO 3166-2:RU',NULL),(184,'Rwanda','RW','RWA',646,'ISO 3166-2:RW',NULL),(185,'Saint Barth.lemy','BL','BLM',652,'ISO 3166-2:BL',NULL),(186,'Saint Helena, Ascension and Tristan da Cunha','SH','SHN',654,'ISO 3166-2:SH',NULL),(187,'Saint Kitts and Nevis','KN','KNA',659,'ISO 3166-2:KN',NULL),(188,'Saint Lucia','LC','LCA',662,'ISO 3166-2:LC',NULL),(189,'Saint Martin (French part)','MF','MAF',663,'ISO 3166-2:MF',NULL),(190,'Saint Pierre and Miquelon','PM','SPM',666,'ISO 3166-2:PM',NULL),(191,'Saint Vincent and the Grenadines','VC','VCT',670,'ISO 3166-2:VC',NULL),(192,'Samoa','WS','WSM',882,'ISO 3166-2:WS',NULL),(193,'San Marino','SM','SMR',674,'ISO 3166-2:SM',NULL),(194,'Sao Tome and Principe','ST','STP',678,'ISO 3166-2:ST',NULL),(195,'Saudi Arabia','SA','SAU',682,'ISO 3166-2:SA',NULL),(196,'Senegal','SN','SEN',686,'ISO 3166-2:SN',NULL),(197,'Serbia','RS','SRB',688,'ISO 3166-2:RS',NULL),(198,'Seychelles','SC','SYC',690,'ISO 3166-2:SC',NULL),(199,'Sierra Leone','SL','SLE',694,'ISO 3166-2:SL',NULL),(200,'Singapore','SG','SGP',702,'ISO 3166-2:SG',NULL),(201,'Sint Maarten (Dutch part)','SX','SXM',534,'ISO 3166-2:SX',NULL),(202,'Slovakia','SK','SVK',703,'ISO 3166-2:SK',NULL),(203,'Slovenia','SI','SVN',705,'ISO 3166-2:SI',NULL),(204,'Solomon Islands','SB','SLB',90,'ISO 3166-2:SB',NULL),(205,'Somalia','SO','SOM',706,'ISO 3166-2:SO',NULL),(206,'South Africa','ZA','ZAF',710,'ISO 3166-2:ZA',NULL),(207,'South Georgia and the South Sandwich Islands','GS','SGS',239,'ISO 3166-2:GS',NULL),(208,'South Sudan','SS','SSD',728,'ISO 3166-2:SS',NULL),(209,'Spain','ES','ESP',724,'ISO 3166-2:ES',NULL),(210,'Sri Lanka','LK','LKA',144,'ISO 3166-2:LK',NULL),(211,'Sudan','SD','SDN',729,'ISO 3166-2:SD',NULL),(212,'Suriname','SR','SUR',740,'ISO 3166-2:SR',NULL),(213,'Svalbard and Jan Mayen','SJ','SJM',744,'ISO 3166-2:SJ',NULL),(214,'Swaziland','SZ','SWZ',748,'ISO 3166-2:SZ',NULL),(215,'Sweden','SE','SWE',752,'ISO 3166-2:SE',NULL),(216,'Switzerland','CH','CHE',756,'ISO 3166-2:CH',NULL),(217,'Syrian Arab Republic','SY','SYR',760,'ISO 3166-2:SY',NULL),(218,'Taiwan, Province of China','TW','TWN',158,'ISO 3166-2:TW',NULL),(219,'Tajikistan','TJ','TJK',762,'ISO 3166-2:TJ',NULL),(220,'Tanzania, United Republic of','TZ','TZA',834,'ISO 3166-2:TZ',NULL),(221,'Thailand','TH','THA',764,'ISO 3166-2:TH',NULL),(222,'Timor-Leste','TL','TLS',626,'ISO 3166-2:TL',NULL),(223,'Togo','TG','TGO',768,'ISO 3166-2:TG',NULL),(224,'Tokelau','TK','TKL',772,'ISO 3166-2:TK',NULL),(225,'Tonga','TO','TON',776,'ISO 3166-2:TO',NULL),(226,'Trinidad and Tobago','TT','TTO',780,'ISO 3166-2:TT',NULL),(227,'Tunisia','TN','TUN',788,'ISO 3166-2:TN',NULL),(228,'Turkey','TR','TUR',792,'ISO 3166-2:TR',NULL),(229,'Turkmenistan','TM','TKM',795,'ISO 3166-2:TM',NULL),(230,'Turks and Caicos Islands','TC','TCA',796,'ISO 3166-2:TC',NULL),(231,'Tuvalu','TV','TUV',798,'ISO 3166-2:TV',NULL),(232,'Uganda','UG','UGA',800,'ISO 3166-2:UG',NULL),(233,'Ukraine','UA','UKR',804,'ISO 3166-2:UA',NULL),(234,'United Arab Emirates','AE','ARE',784,'ISO 3166-2:AE',NULL),(235,'United Kingdom','GB','GBR',826,'ISO 3166-2:GB',NULL),(236,'United States','US','USA',840,'ISO 3166-2:US',NULL),(237,'United States Minor Outlying Islands','UM','UMI',581,'ISO 3166-2:UM',NULL),(238,'Uruguay','UY','URY',858,'ISO 3166-2:UY',NULL),(239,'Uzbekistan','UZ','UZB',860,'ISO 3166-2:UZ',NULL),(240,'Vanuatu','VU','VUT',548,'ISO 3166-2:VU',NULL),(241,'Venezuela, Bolivarian Republic of','VE','VEN',862,'ISO 3166-2:VE',NULL),(242,'Viet Nam','VN','VNM',704,'ISO 3166-2:VN',NULL),(243,'Virgin Islands, British','VG','VGB',92,'ISO 3166-2:VG',NULL),(244,'Virgin Islands, U.S.','VI','VIR',850,'ISO 3166-2:VI',NULL),(245,'Wallis and Futuna','WF','WLF',876,'ISO 3166-2:WF',NULL),(246,'Western Sahara','EH','ESH',732,'ISO 3166-2:EH',NULL),(247,'Yemen','YE','YEM',887,'ISO 3166-2:YE',NULL),(248,'Zambia','ZM','ZMB',894,'ISO 3166-2:ZM',NULL),(249,'Zimbabwe','ZW','ZWE',716,'ISO 3166-2:ZW',NULL);
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `list_type`
--

LOCK TABLES `list_type` WRITE;
/*!40000 ALTER TABLE `list_type` DISABLE KEYS */;
INSERT INTO `list_type` (`id`, `name`, `description`) VALUES (1,'project',NULL),(2,'todolist',NULL);
/*!40000 ALTER TABLE `list_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `project_status_type`
--

LOCK TABLES `project_status_type` WRITE;
/*!40000 ALTER TABLE `project_status_type` DISABLE KEYS */;
INSERT INTO `project_status_type` (`id`, `name`, `living`, `description`) VALUES (1,'Active','1',NULL),(2,'Complete','0',NULL),(3,'Deleted','0',NULL),(4,'Cancelled','0',NULL);
/*!40000 ALTER TABLE `project_status_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `project_type`
--

LOCK TABLES `project_type` WRITE;
/*!40000 ALTER TABLE `project_type` DISABLE KEYS */;
INSERT INTO `project_type` (`id`, `name`, `description`) VALUES (1,'Traditional','A traditional, non-agile project'),(2,'Scrum - Agile','A Scrum-based Agile project');
/*!40000 ALTER TABLE `project_type` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` (`id`, `custom_role`, `role`, `capability`, `project_related`, `display_name`, `description`) VALUES (2,1,'member',NULL,0,NULL,NULL),(3,1,'client',NULL,0,'Client',NULL),(4,1,'user_maintainer',NULL,0,'User Maintainer',NULL),(1,1,'administrator',NULL,0,'System Administrator',NULL);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `task_comment_type`
--

LOCK TABLES `task_comment_type` WRITE;
/*!40000 ALTER TABLE `task_comment_type` DISABLE KEYS */;
INSERT INTO `task_comment_type` (`task_comment_type_id`, `task_comment_type_name`, `task_comment_type_description`) VALUES (1,'Status Report',NULL),(2,'FYI',NULL),(3,'Feedback',NULL),(4,'Code',NULL);
/*!40000 ALTER TABLE `task_comment_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `task_status_type`
--

LOCK TABLES `task_status_type` WRITE;
/*!40000 ALTER TABLE `task_status_type` DISABLE KEYS */;
INSERT INTO `task_status_type` (`id`, `name`, `living`, `description`) VALUES (1,'Active','1','Active and in progress'),(2,'Complete','0','The task is finished'),(3,'Deleted','0','Deleted'),(4,'Cancelled','0','Task is not complete but is no longer needed'),(5,'Deferred','1','Put off until a future date');
/*!40000 ALTER TABLE `task_status_type` ENABLE KEYS */;
UNLOCK TABLES;



LOCK TABLES `schema_migration` WRITE;
INSERT INTO `schema_migration` (`version`) VALUES ('20140715021300');
UNLOCK TABLES;



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-06-28 18:03:06
