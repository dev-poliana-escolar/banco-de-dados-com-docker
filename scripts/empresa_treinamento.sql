-- MySQL dump 10.13  Distrib 8.0.44, for Linux (x86_64)
--
-- Host: localhost    Database: empresa_treinamento
-- ------------------------------------------------------
-- Server version	8.0.44

CREATE DATABASE empresa_treinamento;
USE `empresa_treinamento`;

DROP TABLE IF EXISTS `tb_departamento`;

CREATE TABLE `tb_departamento` (
  `id_departamento` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `numero_andar` int NOT NULL,
  PRIMARY KEY (`id_departamento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tb_funcionario` (
  `id_funcionario` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cpf` char(11) DEFAULT NULL,
  `salario` decimal(10,2) DEFAULT NULL,
  `id_departamento_fk` int NOT NULL,
  `email` varchar(120) NOT NULL,
  PRIMARY KEY (`id_funcionario`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `cpf` (`cpf`),
  KEY `id_departamento_fk` (`id_departamento_fk`),
  CONSTRAINT `tb_funcionario_ibfk_1` FOREIGN KEY (`id_departamento_fk`) REFERENCES `tb_departamento` (`id_departamento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `tb_funcionario_projeto` (
  `id_funcionario_fk` int NOT NULL,
  `id_projeto_fk` int NOT NULL,
  `id_departamento` int NOT NULL,
  PRIMARY KEY (`id_funcionario_fk`,`id_projeto_fk`,`id_departamento`),
  KEY `id_projeto_fk` (`id_projeto_fk`,`id_departamento`),
  CONSTRAINT `tb_funcionario_projeto_ibfk_1` FOREIGN KEY (`id_funcionario_fk`) REFERENCES `tb_funcionario` (`id_funcionario`),
  CONSTRAINT `tb_funcionario_projeto_ibfk_2` FOREIGN KEY (`id_projeto_fk`, `id_departamento`) REFERENCES `tb_projeto` (`id_projeto`, `id_departamento_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `tb_projeto` (
  `id_projeto` int NOT NULL AUTO_INCREMENT,
  `nome_projeto` varchar(100) NOT NULL,
  `id_departamento_fk` int NOT NULL,
  `data_inicio` date DEFAULT NULL,
  PRIMARY KEY (`id_projeto`,`id_departamento_fk`),
  KEY `id_departamento_fk` (`id_departamento_fk`),
  CONSTRAINT `tb_projeto_ibfk_1` FOREIGN KEY (`id_departamento_fk`) REFERENCES `tb_departamento` (`id_departamento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

