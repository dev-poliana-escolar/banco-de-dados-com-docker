/* =====================================================
   SCRIPT: dbMusical
   OBJETIVO: Criar banco, tabelas e inserir dados
   SGBD: MySQL 8.x
   OBS: Execute este script usando "Execute SQL Script"
   ===================================================== */

/* 1. Criar banco de dados (se não existir) */
CREATE DATABASE IF NOT EXISTS dbMusical
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

/* 2. Selecionar banco de dados
   (Opcional: pode ser omitido se o banco estiver ativo no DBeaver)
   Nos casos em que o script é executado fora do DBeaver, como por exemplo no terminal MySQL,
   é necessário selecionar o banco explicitamente.
*/
USE dbMusical;

/* 3. Remover tabelas caso existam (ordem correta por FK) */
DROP TABLE IF EXISTS TbIntegrante;
DROP TABLE IF EXISTS TbBanda;

/* 4. Criar tabela TbBanda */
CREATE TABLE TbBanda (
    CoBanda TINYINT AUTO_INCREMENT PRIMARY KEY,
    NoBanda VARCHAR(50) NOT NULL,
    VaCache FLOAT
) ENGINE=InnoDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

/* 5. Criar tabela TbIntegrante */
CREATE TABLE TbIntegrante (
    CoIntegrante INT AUTO_INCREMENT PRIMARY KEY,
    NoIntegrante VARCHAR(50) NOT NULL,
    CoBanda TINYINT NOT NULL,
    CONSTRAINT FK_BandaMusico
        FOREIGN KEY (CoBanda)
        REFERENCES TbBanda (CoBanda)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

/* 6. Inserir dados em TbBanda */
INSERT INTO TbBanda (NoBanda, VaCache) VALUES
('Jota Quest', 130000),
('Skank', 100000),
('Paralamas do Sucesso', 70000),
('Capital Inicial', 150000),
('Roupa Nova', 80000),
('Titãs', NULL);

/* 7. Inserir dados em TbIntegrante */
INSERT INTO TbIntegrante (NoIntegrante, CoBanda) VALUES
('Rogério Flausino', 1),
('Marco Túlio Lara', 1),
('PJ', 1),
('Paulinho Fonseca', 1),
('Márcio Buzelin', 1),
('Samuel Rosa', 2),
('Henrique Portugal', 2),
('Lelo Zaneti', 2),
('Haroldo Ferretti', 2),
('Herbert Vianna', 3),
('Bi Ribeiro', 3),
('João Barone', 3),
('Dinho Ouro Preto', 4),
('Fê Lemos', 4),
('Flávio Lemos', 4),
('Yves Passarel', 4),
('Paulinho', 5),
('Serginho Herval', 5),
('Nando', 5),
('Kiko', 5),
('Ricardo Feghali', 5),
('Cleberson Horsth', 5);