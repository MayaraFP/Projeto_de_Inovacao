CREATE DATABASE prototipo_banco;

USE prototipo_banco;

CREATE TABLE usuario(
id_usuario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR (50) NOT NULL,
email VARCHAR (50) UNIQUE,
senha CHAR(16) NOT NULL
);

CREATE TABLE empresa(
id_empresa INT PRIMARY KEY AUTO_INCREMENT,
cnpj CHAR (18) UNIQUE,
nome_fantasia VARCHAR (45),
data_cadastro DATETIME,
data_rompimento_servicos DATE
);

CREATE TABLE sala(
id_sala INT PRIMARY KEY AUTO_INCREMENT,
nome_sala VARCHAR(50) NOT NULL,
quantidade_gaiolas INT
);

CREATE TABLE gaiola(
id_gaiolas INT PRIMARY KEY AUTO_INCREMENT,
modelo_gaiola VARCHAR(30),
quantidade_ratos INT
);

CREATE TABLE temperatura(
id_temperatura_gaiola INT PRIMARY KEY AUTO_INCREMENT,
origem_leitura CHAR(6),
CONSTRAINT chOrigem CHECK (origem_leitura IN('Sala','Gaiola')),
data_registro DATETIME NOT NULL,
temperatura_registrada DECIMAL (4,2) NOT NULL
);

-- ---------------------------------- INSERTS

INSERT INTO usuario(nome, email, senha) VALUES
('Gestor','gestor@gmail.com','090167281'),
('pesquisador 1','pesquisador@gmail.com','6618236181'),
('Pesquisador 2','pesquisador3@gmail.com','582941736'),
('Pesquisador 3','pesquisador4@gmail.com','374829105'),
('Pesquisador 4','pesquisador5@gmail.com','647382910');

INSERT INTO empresa(cnpj,nome_fantasia,data_cadastro) VALUES
('96.206.664/0001-80','Bioterio corp',CURDATE()),
('29.191.412/0001-38','Bioterio labs',CURDATE()),
('75.130.601/0001-86','BioTechnology', '2026-01-24'),
('87.911.418/0001-32','spTeBio', '2026-07-31');

INSERT INTO sala(nome_sala,quantidade_gaiolas) VALUES
('15B','10'),
('32C','15'),
('21A','8'),
('47D','12'),
('09C','6'),
('18A','10'),
('25B','14');

INSERT INTO gaiola(modelo_gaiola, quantidade_ratos) VALUES
('EM500',3),
('47442',2),
('RM300',1),
('EM500',3),
('CR800',2),
('MX250',2),
('EM500',3);

INSERT INTO temperatura(origem_leitura,data_registro,temperatura_registrada) VALUES
('Sala',NOW(),23.2),
('Gaiola',NOW(),24.2),
('Sala', NOW(), 14.7),
('Gaiola', NOW(), 19.0),
('Sala', NOW(), 30.5),
('Sala', NOW(), 26.0),
('Sala', NOW(), 25.8),
('Gaiola', NOW(), 31.2),
('Gaiola', NOW(), 30.8),
('Gaiola', NOW(), 22.6),
('Gaiola', NOW(), 23.3),
('Gaiola', NOW(), 21.6),
('Gaiola', NOW(), 24.8),
('Gaiola', NOW(), 25.4),
('Gaiola', NOW(), 26.4),
('Sala', NOW(), 23.9),
('Gaiola', NOW(), 21.0),
('Gaiola', NOW(), 31.1);

-- ---------------------------------- SELECTS 

SELECT * FROM empresa;
SELECT * FROM sala;
SELECT * FROM gaiola;
SELECT * FROM temperatura;

SELECT CONCAT( nome_fantasia, ' - ', cnpj, ' ', data_cadastro)
AS info_empresa FROM empresa;

SELECT TIMESTAMPDIFF(MONTH, data_cadastro, NOW()) meses_cadastrado 
FROM empresa;

SELECT CONCAT( nome, ' - ', email)
AS info_user FROM usuario;

SELECT CONCAT( origem_leitura, ' - ', temperatura_registrada, ' - ', data_registro)
AS info_temperatura FROM temperatura;

SELECT nome_fantasia
AS empresas_contratantes
FROM empresa;

SELECT nome_fantasia AS 'Nome', data_cadastro AS 'Data de inicio',
CONCAT(nome_fantasia, ' - ',data_cadastro)
AS 'Informações empresariais',
CASE
WHEN data_cadastro BETWEEN '2026-08-01 00:00:00'
AND '2026-12-31 23:59:59'THEN 'Novo cliente'
ELSE 'Cliente antigo'
END AS tempo_clientela	
FROM empresa;

SELECT nome_sala
AS 'Salas de pesquisa'
FROM sala
ORDER BY nome_sala;

SELECT CONCAT('id Gaiola: ', id_gaiolas,' - ', 'Quantidade de roedores:', quantidade_ratos)
AS 'Quantidade de roedores na gaiola'
FROM gaiola
ORDER BY quantidade_ratos
DESC;

SELECT id_temperatura_gaiola AS ID,
origem_leitura AS Origem,
data_registro AS 'Data',
temperatura_registrada AS Temperatura,
CASE
	WHEN temperatura_registrada <= 26 AND temperatura_registrada >= 20 THEN 'Regular'
	WHEN temperatura_registrada > 26 AND temperatura_registrada < 31 THEN 'Cuidado!'
	WHEN temperatura_registrada >= 31 THEN 'CRITICO!'
	WHEN temperatura_registrada < 20 AND temperatura_registrada > 15 THEN 'Cuidado!'
	WHEN temperatura_registrada <= 15 THEN 'CRITICO!'
END AS Alerta
FROM temperatura ORDER BY Alerta ASC;