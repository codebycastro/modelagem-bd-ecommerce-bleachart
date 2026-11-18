-- ========================================================
-- PROJETO BLEACHART - SCRIPT COMPLETO (DDL, DML, SELECT, UPDATE, DELETE)
-- ========================================================
USE bleachart;
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE PAGAMENTO;
TRUNCATE TABLE ITEM_PEDIDO;
TRUNCATE TABLE PEDIDO;
TRUNCATE TABLE ENDERECO;
TRUNCATE TABLE PRODUTO;
TRUNCATE TABLE CLIENTE;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. CRIAÇÃO DA ESTRUTURA (DDL)
CREATE DATABASE IF NOT EXISTS bleachart;
USE bleachart;

CREATE TABLE IF NOT EXISTS CLIENTE (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS ENDERECO (
    id_endereco INT AUTO_INCREMENT PRIMARY KEY,
    cep VARCHAR(10) NOT NULL,
    rua VARCHAR(150) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    bairro VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS PRODUTO (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS PEDIDO (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    data_pedido DATE NOT NULL,
    status_pedido VARCHAR(50) NOT NULL,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente)
);

CREATE TABLE IF NOT EXISTS ITEM_PEDIDO (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_produto INT,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES PEDIDO(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES PRODUTO(id_produto)
);

CREATE TABLE IF NOT EXISTS PAGAMENTO (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    forma_pagamento VARCHAR(50) NOT NULL,
    status_pagamento VARCHAR(50) NOT NULL,
    valor_pago DECIMAL(10,2) NOT NULL,
    id_pedido INT,
    FOREIGN KEY (id_pedido) REFERENCES PEDIDO(id_pedido)
);

-- 2. POVOAMENTO DE DADOS (DML - INSERT)
INSERT INTO CLIENTE (nome, email, telefone) VALUES 
('Ana Souza', 'ana.souza@email.com', '41988881111'),
('Carlos Lima', 'carlos.lima@email.com', '41977772222');

INSERT INTO ENDERECO (cep, rua, numero, bairro, cidade, estado, id_cliente) VALUES 
('80060000', 'Rua XV de Novembro', '1000', 'Centro', 'Curitiba', 'PR', 1),
('80045250', 'Rua Ubaldino do Amaral', '250', 'Alto da XV', 'Curitiba', 'PR', 2);

INSERT INTO PRODUTO (nome_produto, descricao, preco, estoque) VALUES 
('Camiseta BleachArt Alice in Chains', 'Camisa preta personalizada com técnica de bleach art', 89.90, 15),
('Moletom Canguru Gótico', 'Moletom preto com estampa ornamental em aerógrafo', 169.90, 10);

INSERT INTO PEDIDO (data_pedido, status_pedido, id_cliente) VALUES 
('2026-11-18', 'Processando', 1);

INSERT INTO ITEM_PEDIDO (id_pedido, id_produto, quantidade, preco_unitario) VALUES 
(1, 1, 2, 89.90);

INSERT INTO PAGAMENTO (forma_pagamento, status_pagamento, valor_pago, id_pedido) VALUES 
('Cartão de Crédito', 'Aprovado', 179.80, 1);

-- 3. CONSULTAS EXPLORATÓRIAS (SELECT)
-- Relatório de pedidos por cliente
SELECT c.nome AS cliente, p.id_pedido, p.data_pedido, p.status_pedido 
FROM CLIENTE c INNER JOIN PEDIDO p ON c.id_cliente = p.id_cliente;

-- 4. MANUTENÇÃO (UPDATE)
UPDATE PEDIDO SET status_pedido = 'Enviado' WHERE id_pedido = 1;

-- 5. EXCLUSÃO SEGURA (DELETE)
-- (Nota: Executar apenas se necessário para testes de limpeza controlada)
-- DELETE FROM PAGAMENTO WHERE id_pagamento = 1;