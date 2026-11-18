USE bleachart;

-- 1. Desativa temporariamente as chaves estrangeiras para permitir o TRUNCATE
SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE PAGAMENTO;
TRUNCATE TABLE ITEM_PEDIDO;
TRUNCATE TABLE PEDIDO;
TRUNCATE TABLE ENDERECO;
TRUNCATE TABLE PRODUTO;
TRUNCATE TABLE CLIENTE;

-- Reativa as chaves estrangeiras
SET FOREIGN_KEY_CHECKS = 1;

-- 2. Inserção de Clientes
INSERT INTO CLIENTE (nome, email, telefone) VALUES 
('Ana Souza', 'ana.souza@email.com', '41988881111'),
('Carlos Lima', 'carlos.lima@email.com', '41977772222');

-- 3. Inserção de Endereços
INSERT INTO ENDERECO (cep, rua, numero, bairro, cidade, estado, id_cliente) VALUES 
('80060000', 'Rua XV de Novembro', '1000', 'Centro', 'Curitiba', 'PR', 1),
('80045250', 'Rua Ubaldino do Amaral', '250', 'Alto da XV', 'Curitiba', 'PR', 2);

-- 4. Inserção de Produtos
INSERT INTO PRODUTO (nome_produto, descricao, preco, estoque) VALUES 
('Camiseta BleachArt Alice in Chains', 'Camisa preta personalizada com técnica de bleach art', 89.90, 15),
('Moletom Canguru Gótico', 'Moletom preto com estampa ornamental em aerógrafo', 169.90, 10);

-- 5. Inserção de Pedido
INSERT INTO PEDIDO (data_pedido, status_pedido, id_cliente) VALUES 
('2026-11-18', 'Processando', 1);

-- 6. Inserção de Item do Pedido
INSERT INTO ITEM_PEDIDO (id_pedido, id_produto, quantidade, preco_unitario) VALUES 
(1, 1, 2, 89.90);

-- 7. Inserção de Pagamento
INSERT INTO PAGAMENTO (forma_pagamento, status_pagamento, valor_pago, id_pedido) VALUES 
('Cartão de Crédito', 'Aprovado', 179.80, 1);