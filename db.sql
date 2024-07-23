-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: plantsshopdb
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `id` int NOT NULL AUTO_INCREMENT,
  `city` varchar(255) NOT NULL,
  `region` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `street_number` varchar(50) NOT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `customer_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_address_customer` (`customer_id`),
  CONSTRAINT `fk_address_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'Beirut','Beirut','Hamra','13','0000',1),(2,'Byblos','Byblos','Byblos','234','1000',2),(11,'Beirut','Beirut','Hadath','103','0000',18),(13,'test','test','test','3','4',23);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `id` int NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'admin','admin','hadibaydoun17@gmail.com');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cart_customer_id` (`customer_id`),
  CONSTRAINT `fk_cart_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1,1),(2,2),(14,18);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_items`
--

DROP TABLE IF EXISTS `cart_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `total` decimal(10,2) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `cart_id` int NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cart_items_cart_id` (`cart_id`),
  KEY `fk_cart_items_product_id` (`product_id`),
  CONSTRAINT `fk_cart_items_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`),
  CONSTRAINT `fk_cart_items_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=177 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_items`
--

LOCK TABLES `cart_items` WRITE;
/*!40000 ALTER TABLE `cart_items` DISABLE KEYS */;
INSERT INTO `cart_items` VALUES (1,47.96,4,1,3),(2,29.98,2,1,1),(137,59.98,2,14,8),(157,8.99,1,14,4),(174,19.99,1,14,6),(175,35.97,3,14,3),(176,39.99,1,14,7);
/*!40000 ALTER TABLE `cart_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Gifts and Decor'),(2,'Genus'),(3,'Supplies'),(4,'Benefits'),(5,'Type'),(6,'Plant Size');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Thomas','McLamb','hadibaydoun611@gmail.com','thomas@2001','4043416027'),(2,'Jawad','Karnib','jawadkar311@gmail.com','Jawad@2001','8159490938'),(18,'John','Ghoson','test@gmail.com','John2001','81284256'),(23,'test2','test2','test3@gmail.com','test','3'),(24,'test5','test5','test5@gmail.com','TEst2001','2222222'),(25,'test5','test5','test5@gmail.com','TEst2001','2222222');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `shop_order_id` int NOT NULL,
  `quantity` int DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_order_items_product_id` (`product_id`),
  KEY `fk_order_items_shop_order_id` (`shop_order_id`),
  CONSTRAINT `fk_order_items_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `fk_order_items_shop_order_id` FOREIGN KEY (`shop_order_id`) REFERENCES `shop_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,1,NULL,NULL,1),(2,1,10,139.90,2);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_status`
--

DROP TABLE IF EXISTS `order_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_status`
--

LOCK TABLES `order_status` WRITE;
/*!40000 ALTER TABLE `order_status` DISABLE KEYS */;
INSERT INTO `order_status` VALUES (1,'Processing'),(2,'Delivered'),(3,'Cancelled'),(4,'Awaiting Payment');
/*!40000 ALTER TABLE `order_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_methods`
--

DROP TABLE IF EXISTS `payment_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_methods` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_methods`
--

LOCK TABLES `payment_methods` WRITE;
/*!40000 ALTER TABLE `payment_methods` DISABLE KEYS */;
INSERT INTO `payment_methods` VALUES (1,'Paypal'),(2,'Visa'),(3,'Master Card');
/*!40000 ALTER TABLE `payment_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` text,
  `rating` decimal(3,2) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `sub_categories_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_product_sub_categories_id` (`sub_categories_id`),
  CONSTRAINT `fk_product_sub_categories_id` FOREIGN KEY (`sub_categories_id`) REFERENCES `sub_categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'The perfect display for your favorite air plant. Makes an impactful statement and a great gift.',4.00,'https://houseplantshop.com/cdn/shop/products/hangingbrassairplantholderDETAIL_592x592.jpg?v=1622838876',20,14.99,1,'Air Plant Display Hanger'),(2,'The perfect display for your favorite air plant. Makes an impactful statement and a great gift.',4.00,'https://www.airplantdecor.com.au/cdn/shop/products/image_aea8fd13-d1d7-4291-ad25-236b056d6dc2_800x.jpg?v=1595985457',15,13.99,1,'Ceramic Hand'),(3,'Fluorite crystals are natural gemstones that are often used to dress plants. These crystals are believed to have healing properties and can promote growth and vitality in plants.  They are a popular choice among plant enthusiasts and can be found in many plant stores and online retailers.',3.00,'https://lilith-wolfe-tarot.com/cdn/shop/products/IMG_9365_4188f8a5-363d-4501-81a3-9b4f96e53e3c_990x.jpg?v=1674034224',2,11.99,2,'Green Fluorite Crystals'),(4,'Cactus Magnets for Fridge and Other Household Items. Strong Magnets keep things in place with ease. Simple and minimal, perfect for around the house or for your office. This is the perfect gift to yourself or your fellow plant lovers.',5.00,'https://houseplantshop.com/cdn/shop/products/CacnetMagnet_592x592.jpg?v=1622839314',30,8.99,3,'6 Pack Cactus Magnets'),(5,'Display your house plant by hanging the planter on a wall or from the ceiling. This Macrame is simple and elegant and matches with all types of planters.',2.00,'https://houseplantshop.com/cdn/shop/products/Supplies_macrameflat_592x592.jpg?v=1622839147',9,16.99,4,'Macrame Hanger'),(6,'You can also grow calla lilies in containers, either outdoors or in a sunny window as houseplants.This beautiful plant, available in a multitude of colors, grows from rhizomes and is an ideal plant to add to your garden or as a indoor house plant.',4.00,'https://houseplantshop.com/cdn/shop/products/10e29a35-9075-4cba-a3e4-5ed887c12879_473x473.png?v=1677688283',8,19.99,5,'Calla Lily'),(7,'The Alocasia Polly also known as the African Mask or Elephant Ear is all about the unusual and unique alien looking leaves. The Alocasia Polly is a unique houseplant but beware that it is on the harder side to care for. It requires bright, indirect sunlight as well as soil that is constantly moist from watering. Toxic to pets.',5.00,'https://houseplantshop.com/cdn/shop/products/1-Alocasia-AfricanMask-6_469x469.jpg?v=1622837081',11,39.99,6,'Alocasia Polly \'African Mask\''),(8,'A foxtail is a spikelet or cluster of a grass, that serves to disperse its seeds as a unit. Thus, the foxtail is a type of diaspore or plant dispersal unit. Some grasses that produce a foxtail are themselves called \'foxtail\', also \'spear grass\'. They can become a health hazard for dogs and other domestic animals, and a nuisance for people.',4.00,'https://houseplantshop.com/cdn/shop/products/32c20915-b082-4f72-ae4e-365bd18115b9_592x592.png?v=1674754288',18,29.99,6,'Foxtail Grass'),(26,'Alocasia Jacklyn (Alocasia sulawesi sp.) is a newly discovered plant in the aroid family. Native to Indonesia, it\'s thought to be a mutation of another species, Alocasia portei. This attractive tropical plant is known for vivid green foliage marked with fine dark lines. Deep lobes give each leaf the shape of a stag\'s head.',5.00,'https://houseplantshop.com/cdn/shop/files/4_ALOCASIA_JACKLYN_TEMP_3.28.24_592x789.jpg?v=1712836800',28,28.99,6,'Alocasia \'Jacklyn\''),(27,'Amaryllis (Hippeastrum) are tropical bulbs, native to South America, that are harvested in the summer and then chilled to prepare them to bloom. Given warm temperatures, strong light, and water upon arrival, they will put on a spectacular show 8 to 10 weeks later that will brighten up even the gloomiest winter day.',2.00,'https://houseplantshop.com/cdn/shop/files/cbc2be8a-927c-4ace-9324-f9e4e36841cd_592x592.png?v=1712052476',1,34.99,7,'Amaryllis \'Red/White\''),(28,'Amydrium medium \'Silver\', also known as Spiderman Monstera, is a beautiful and rare plant that is native to South America. It is a member of the Araceae family, which also includes Monstera deliciosa, Philodendron, and Anthurium, but it does not belong to Monstera genus. Amydriums are native to the rainforests of south-east Asia.',4.00,'https://houseplantshop.com/cdn/shop/files/4_AMYDRIUM_SILVER_TEMP_592x592.jpg?v=1712052553',12,39.99,8,'Amydrium \'Silver\''),(29,'A beautiful collector\'s plant with dark green foliage splashed with silver-grey markings and purple-tinged undersides, ribs, and stems.',5.00,'https://houseplantshop.com/cdn/shop/products/54acb496-7f13-44e7-8f60-4cebd1ab01e7_592x789.png?v=1661962491',6,44.99,9,'Apoballis \'Purple Sword\''),(30,'How long do your seedlings need to germinate? What makes a healthy stem cutting? How do you know what type of rootstock to use when grafting plants? With more than 1,800 detailed illustrations and photos to refer to, find out the answer to these questions and more, and discover the experts\' secrets to perfect plant propagation that anyone can follow.',4.00,'https://houseplantshop.com/cdn/shop/products/Supplies_bookPROPAGATING_592x592.jpg?v=1622840090',4,39.99,10,'Propagating Plants'),(31,'With plentiful images and a distinctly modern and sophisticated feel, this book imparts both easy-to-follow advice and creative garden-design inspiration. Whether you are looking to pick a statement plant for your living room, create a terrarium centerpiece, or arrange an artful display of air plants, this book will provide the tools you need. And like the garden spaces it will inspire, the book will be a piece of art to display. You\'ll be tempted to thumb through it again and again--for both resource and relaxation.',5.00,'https://houseplantshop.com/cdn/shop/products/Supplies_bookINSPIRED_592x592.jpg?v=1622840073',10,29.99,10,'The Inspired House Plant'),(32,'Founded in a historic nursery in southeast Pennsylvania, Terrain is a nationally renowned garden, home, and lifestyle brand with an entirely fresh approach to living with nature. It’s an approach that bridges the gap between home and garden, the indoors and the outdoors. An approach that embraces decorating with plants and inviting the garden into every living space.',4.00,'https://houseplantshop.com/cdn/shop/products/Supplies_bookTERRAIN_592x592.jpg?v=1622840099',5,39.99,10,'Terrain'),(33,'This eco-friendly plant fiber pot is made from biodegradable bamboo. Now you can pre-pot your house plant in a sustainable planter.\nTo make the pot, bamboo is first broken down into a powder which is then mixed and heated to construct the shape of the pot. Once the pot is formed, it is then polished and cleaned to give it a smooth finish.\nYou can pot a 4\" plants that needs room to grow or a 6\" plant that will fit exactly the diameter of this pot. \n*Plant not included*',5.00,'https://houseplantshop.com/cdn/shop/products/6inchPLASTICPOTDETAIL_592x592.jpg?v=1628640743',19,14.99,11,'Eco-Friendly \'Plant Fiber\''),(34,'Weight: 2 lbs\nDimensions: 4.50\" x 4.50\" x 4.75\"\nMaterial: Ceramic',1.00,'https://houseplantshop.com/cdn/shop/products/8bbc12ce-31a5-409c-a60a-c5c1525bd97a_592x592.png?v=1628113150',5,21.99,11,'Tomi Hanging Planter'),(35,'This expressive stoneware pot features a simple silhouette, and hand-painted designs both whimsical and iconic.',3.00,'https://houseplantshop.com/cdn/shop/products/ExpressionsFootedPlanterDETAIL_592x592.jpg?v=1617637532',13,25.99,11,'Expressions Planters'),(36,'The Rossi Tray features clean lines and a low lip, perfect for displaying your potted plants, floral designs, or other keepsakes in the home.',4.00,'https://houseplantshop.com/cdn/shop/products/RossiSaucersmall_DETAIL_592x592.jpg?v=1628113160',17,19.99,11,'Rossi Saucer'),(37,'Our winter plant shipping protection is engineered to ship plants during the cold winter months. We recommend adding this winter plant shipping protection when ordering plants during the winter months (November - April) if you experience temps. below 50°F.',5.00,'https://houseplantshop.com/cdn/shop/files/HEATPACKUSA_2_592x592.jpg?v=1698800021',65,4.99,12,'Winter Plant Shipping Protection'),(38,'Kokedama  is a ball of soil, covered with moss, on which an ornamental plant grows. The idea has its origins in Japan, where it is a combination of the nearai bonsai and kusamono planting styles.',4.00,'https://houseplantshop.com/cdn/shop/products/cfc6ed53-432c-4728-b7a5-89686e66b1f6_592x592.png?v=1628113161',21,29.99,13,'Kokedama Moss Ball Hanging Plant'),(39,'A small 6oz pouch of fuchsia preserved reindeer moss ideal for covering soil and dressing potted plants.\nThis moss is preserved and does not require any special care. It is just recommended you keep it out of direct sunlight.\nReindeer moss is a perfect addition to any terrarium or indoor garden.',3.00,'https://houseplantshop.com/cdn/shop/products/Preserved_Reindeer_Moss_-_Fuchsia_-_6_oz_592x592.jpg?v=1622838582',30,11.99,13,'Preserved Reindeer Moss - Fuchsia - 6 oz'),(40,'Controls blackspot, powdery mildew, rust, spider mites, aphids, whiteflies, and other insect pests.',2.00,'https://houseplantshop.com/cdn/shop/products/NEEMOILRTU_592x592.jpg?v=1617637655',20,19.99,14,'Neem Oil RTU - 32 fl oz'),(41,'Bontone II rooting powder promotes quick root development from cuttings. Now for vegetables, fruit trees & berries. Ideal for transplants also.',5.00,'https://houseplantshop.com/cdn/shop/products/RootingPowder_592x592.jpg?v=1617637655',43,13.99,14,'Rooting Powder - 35 g'),(44,'These exotic houseplants have glossy heart-shaped leaves with a beautiful bloom that comes in a large array of colors. They can bloom all year long with enough light and water. The Anthurium originated in the South American rain forest so they thrive in high-humidity environments with a decent amount of shade.',5.00,'https://houseplantshop.com/cdn/shop/products/1-Anthurium-Red-4MAIN_592x592.jpg?v=1664475737',20,24.99,15,'Anthurium \'Red\''),(45,'The Aloe Vera is a stemless succulent with thick and fleshy leaves that are lined with small teeth making it a great ornamental, low maintenance indoor plant which blooms a yellow tubular flower in the summertime. Native to the Arabian Peninsula, this plant is widely used around the world as its leaves are considered to be antimicrobial and has been used to treat burns as a topical medication.',5.00,'https://houseplantshop.com/cdn/shop/products/Pre-PottedblackroundAloe_592x592.jpg?v=1627922614',21,24.99,15,'Aloe Vera'),(46,'Air Plant Magic Mist Fertilizer is pre-mixed tillandsia food in an easy to use spray bottle. ',5.00,'https://houseplantshop.com/cdn/shop/files/Tillandsia_Air_Plants_Fertilizer_30ml_592x592.jpg?v=1711841427',5,2.99,16,'Tillandsia Air Plants Fertilizer - 2oz'),(47,'With its striking spiky appearance, and beautiful bright green it really does liven up any space. The Tillandsia Ionantha Guatamala Air Plant has red tips when blooming and adds a unique color to the leaves. The Tillandsia Ionantha Guatamala easy to cultivate and very versatile.',5.00,'https://houseplantshop.com/cdn/shop/products/HPS-standardplant_IonanthaGuatemala_592x592.jpg?v=1622834154',8,9.99,16,'3 Ionantha Guatemala Air Plants - 2 Inch'),(48,'Native to South Africa, Madagascar, and south east Asia, the polka dot plant is a lively and beautiful little plant with brightly spotted leaves that stand out especially well against other plants. Put them in a mass of ferns or ivies, and their colors will stand out in bright contrast. In colder climates it is an annual plant, expected to live for about one year and die off after its sprout. In tropical climates, it is a perennial that lives a long time.',4.00,'https://houseplantshop.com/cdn/shop/products/1-Hypoestes-Combo-4DETAIL_592x592.jpg?v=1627692206',34,19.99,17,'Hypoestes \'Polka Dot\''),(49,'The Peperomia is a perennial epiphyte native to the tropical regions of Central and South America. It\'s short and sturdy stems wield thick, circular leaves which are a deep burgundy color and retains most of its water. The Peperomia is very easy to care for and requires similar care habits to most succulents making it a great addition to any desk or shelf',4.00,'https://houseplantshop.com/cdn/shop/files/4_PEPEROMIA_RIPPLE.RED_2_592x592.jpg?v=1683070878',14,13.99,17,'Peperomia \'Ripple Red\''),(50,'This exotic assortment set comes with unique seashells, sea urchin shells, and tillandsia ionantha air plants. The Tillandsia Air Plant Ionantha Guatemala has red tips and pairs well with all the different sea shells.',1.00,'https://houseplantshop.com/cdn/shop/products/a9a14438-772b-50cb-a22a-6e6916ccda31_592x592.jpg?v=1629765153',15,16.99,18,'3 Piece Sea Urchin / Seashell Air Plant / Live Tillandsia Ionanthas'),(51,'74 Plants in total \n60 - 4\" Plants (5 of each variety)\n24 - 6\" Plants (3 of each variety)',5.00,'https://houseplantshop.com/cdn/shop/files/8cb6a76d-47b7-4bc7-b878-8c01c19604c4_592x592.png?v=1689951680',3,999.99,19,'Plant Paradise Extra Large Bundle'),(52,'Our \"Spring is here\" variety bundle comes with plants that are herbs and edibles.\n4\" Bundle will include four 4-inch herb/edibles of various assortment. Your bundle may come with any assortment of herbs or edibles depending on the time of year.',3.00,'https://houseplantshop.com/cdn/shop/products/5f55ab81-575f-49ac-915c-37263760150e_592x592.png?v=1625262618',5,39.99,19,'Herb Bundle - 4 Pack'),(53,'Our Pet-Friendly Bundle is for someone looking for Pet-Friendly plants. Ships with plant varieties similar to the photo but may vary depending on the season.\nPerfect for homes with furry friends or curious tots.',5.00,'https://houseplantshop.com/cdn/shop/products/4_petfriendlybundle_592x592.jpg?v=1622838667',28,29.99,19,'Pet Friendly Variety Bundle'),(54,'The small bush blooms in early summer, then re-blooms again late summer or early fall if planted outside. The sturdy stems ensure the flowers are help upright, and make the blooms perfect for cut flower arrangements and indoor decoration. ',4.00,'https://houseplantshop.com/cdn/shop/products/9b64c65a-ee5b-4ecf-bb13-b15b0291b3e3_592x592.png?v=1664391863',6,22.99,20,'Pink Hydrangea'),(56,'Our Blooming Bundle Calla Lily comes with indoor plants that are native to southern Africa from South Africa north to Malawi. Perfect for plant parents that are looking to diversify their collection.',5.00,'https://houseplantshop.com/cdn/shop/products/18739e86-318b-46f6-9758-6aec712b0694_592x592.png?v=1666396869',1,69.99,20,'Blooming Bundle Calla Lily Pink'),(57,'Common Olive is bathed in stunning panicles of fragrant white flowers along the branches from late spring to early summer. The fruits are showy black drupes carried in abundance from mid-summer to early fall. The fruit can be messy if allowed to drop on the lawn or walkways and may require occasional clean-up. It has dark green evergreen foliage which emerges light green in spring. The glossy narrow leaves remain dark green throughout the winter. The smooth gray bark adds an interesting dimension to the landscape. This plant is primarily grown as an ornamental, but it\'s also valued for its edible qualities.',5.00,'https://houseplantshop.com/cdn/shop/files/84847c76-a9a4-4dcb-8f0d-0b50d16f9733_592x592.png?v=1712030851',18,39.99,21,'Common Olive Tree (Olea europaea)'),(58,'Aquatic Plants oxygenate the water to provide shelter for fish and aquarium life while keeping them healthier and your tank looking better.\nJava Moss are one of the world\'s most widely used Plants in planted aquariums. They can grow in low light conditions and a wide range of water parameters.\nPlanting Java Moss is easy; simply throw it into your water. Really - if you just drop it in, it\'ll start growing. You can also choose where it will go by burying the roots in some gravel or tying it onto a piece of material.',2.00,'https://houseplantshop.com/cdn/shop/products/Aquatic_JavaMoss_-Bunch-1-01_592x592.jpg?v=1630806262',38,18.99,22,'Aquatic \'Java Moss\' - Bunch'),(59,'Aquatic Plants oxygenate the water to provide shelter for fish and aquarium life while keeping them healthier and your tank looking better.\nAnubias are one of the world\'s most widely used Plants in planted aquariums. Its slow growth, unique leaf structure, and reproduction method make it an aquarium smash hit.\nPlanting Anubias is easy; simply throw it into your water. Really - if you just drop it in, it\'ll start growing. You can also choose where it will go by burying the roots in some gravel or tying it onto a piece of material.',5.00,'https://houseplantshop.com/cdn/shop/products/Aquatic_AnubiasNana_-2-01_d4d12541-0657-4cd6-80d2-413a69e41a58_592x592.jpg?v=1630369940',75,18.99,22,'Aquatic \'Anubias Nana\' Plant - Pot');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop_order`
--

DROP TABLE IF EXISTS `shop_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shop_order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `address_id` int NOT NULL,
  `payment_methods_id` int DEFAULT NULL,
  `order_status_id` int DEFAULT NULL,
  `order_total` decimal(10,2) DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_shop_order_address_id` (`address_id`),
  KEY `fk_shop_order_customer_id` (`customer_id`),
  KEY `fk_shop_order_order_status_id` (`order_status_id`),
  KEY `fk_shop_order_payment_methods_id` (`payment_methods_id`),
  CONSTRAINT `fk_shop_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`),
  CONSTRAINT `fk_shop_order_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `fk_shop_order_order_status_id` FOREIGN KEY (`order_status_id`) REFERENCES `order_status` (`id`),
  CONSTRAINT `fk_shop_order_payment_methods_id` FOREIGN KEY (`payment_methods_id`) REFERENCES `payment_methods` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop_order`
--

LOCK TABLES `shop_order` WRITE;
/*!40000 ALTER TABLE `shop_order` DISABLE KEYS */;
INSERT INTO `shop_order` VALUES (1,1,1,NULL,NULL,NULL,NULL),(2,2,1,1,2,10.00,'2024-05-04');
/*!40000 ALTER TABLE `shop_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_categories`
--

DROP TABLE IF EXISTS `sub_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sub_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sub_categories_category_id` (`category_id`),
  CONSTRAINT `fk_sub_categories_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_categories`
--

LOCK TABLES `sub_categories` WRITE;
/*!40000 ALTER TABLE `sub_categories` DISABLE KEYS */;
INSERT INTO `sub_categories` VALUES (1,'Air Plant Holder',1),(2,'Crystals',1),(3,'Magnet',1),(4,'Macrame',1),(5,'Zantedeschia',2),(6,'Alocasia',2),(7,'Amaryllis',2),(8,'Amydrium',2),(9,'Apoballis',2),(10,'Book',3),(11,'Planter',3),(12,'Heat Pack',3),(13,'Moss',3),(14,'Fertilizer & Treatments',3),(15,'Air Purifier',4),(16,'Easy Care',4),(17,'Pet Friendly',4),(18,'Air Plant',5),(19,'Bundle',5),(20,'Flowering',5),(21,'Edible',5),(22,'Aquatic Plants',5);
/*!40000 ALTER TABLE `sub_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlist`
--

DROP TABLE IF EXISTS `wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_wishlist_customer_id` (`customer_id`),
  CONSTRAINT `fk_wishlist_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist`
--

LOCK TABLES `wishlist` WRITE;
/*!40000 ALTER TABLE `wishlist` DISABLE KEYS */;
INSERT INTO `wishlist` VALUES (27,2),(4,18);
/*!40000 ALTER TABLE `wishlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlist_items`
--

DROP TABLE IF EXISTS `wishlist_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlist_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `wishlist_id` int NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_product` (`product_id`),
  KEY `fk_wishlist` (`wishlist_id`),
  CONSTRAINT `fk_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `fk_wishlist` FOREIGN KEY (`wishlist_id`) REFERENCES `wishlist` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist_items`
--

LOCK TABLES `wishlist_items` WRITE;
/*!40000 ALTER TABLE `wishlist_items` DISABLE KEYS */;
INSERT INTO `wishlist_items` VALUES (77,4,2),(79,4,1);
/*!40000 ALTER TABLE `wishlist_items` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-23 12:17:08
