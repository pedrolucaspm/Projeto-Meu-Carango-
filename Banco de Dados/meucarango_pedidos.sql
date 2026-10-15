-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: meucarango
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `preco` double NOT NULL,
  `marca` varchar(255) DEFAULT 'Desconhecida',
  `imagem` varchar(500) DEFAULT NULL,
  `data_pedido` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,'BMW X6',1540000,'Desconhecida','http://localhost:8080/Meu_Carango/carro%201.png','2025-06-11 21:31:16'),(2,'BMW X6',1540000,'Desconhecida','http://localhost:8080/Meu_Carango/carro%201.png','2025-06-11 21:33:08'),(3,'Audi A4',299990,'Desconhecida','http://localhost:8080/Meu_Carango/carro%2010.png','2025-06-11 21:33:08'),(4,'Chevrolet Camaro Zl1',518800,'Desconhecida','http://localhost:8080/Meu_Carango/carro%206.png','2025-06-11 21:44:31'),(5,'BMW X6',1540000,'Desconhecida','http://localhost:8080/Meu_Carango/carro%201.png','2025-06-11 22:10:36'),(6,'Audi A4',299990,'Desconhecida','http://localhost:8080/Meu_Carango/carro%2010.png','2025-06-11 22:10:36'),(7,'Nissan GT-R 2009',140000,'Desconhecida','http://localhost:8080/Meu_Carango/carro%203.png','2025-06-11 22:10:36'),(8,'Chevrolet Camaro Zl1',518800,'Desconhecida','http://localhost:8080/Meu_Carango/carro%206.png','2025-06-11 22:11:11'),(9,'Chevrolet Camaro Zl1',518800,'Desconhecida','http://localhost:8080/Meu_Carango/carro%206.png','2025-06-11 22:13:48'),(10,'Audi A4',299990,'Desconhecida','http://localhost:8080/Meu_Carango/carro%2010.png','2025-06-11 22:13:48'),(11,'BMW X6',1540000,'Desconhecida','http://localhost:8080/Meu_Carango/carro%201.png','2025-06-11 23:32:16'),(12,'Audi A4',299990,'Desconhecida','http://localhost:8080/Meu_Carango/carro%2010.png','2025-06-11 23:33:19');
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-11 20:47:44
