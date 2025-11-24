-- LIMPEZA E CRIAÇÃO DO BANCO
DROP DATABASE IF EXISTS bcd_subconsulta;
CREATE DATABASE bcd_subconsulta;
USE bcd_subconsulta;

-- TABELAS
CREATE TABLE clientes (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(80) NOT NULL,
  estado CHAR(2) NOT NULL,
  UNIQUE (nome)
);
ALTER TABLE clientes AUTO_INCREMENT = 101;

CREATE TABLE categorias (
  id_categoria INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  UNIQUE (nome)
);
ALTER TABLE categorias AUTO_INCREMENT = 201;

CREATE TABLE produtos (
  id_produto INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(80) NOT NULL,
  id_categoria INT NOT NULL,
  preco DECIMAL(10,2) NOT NULL,
  UNIQUE (nome),
  FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);
ALTER TABLE produtos AUTO_INCREMENT = 301;

CREATE TABLE pedidos (
  id_pedido INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente INT NOT NULL,
  data_pedido DATE NOT NULL,
  status VARCHAR(20) NOT NULL, -- 'aberto', 'pago', 'cancelado'
  FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);
ALTER TABLE pedidos AUTO_INCREMENT = 401;

CREATE TABLE itens_pedido (
  id_item INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido INT NOT NULL,
  id_produto INT NOT NULL,
  qtde INT NOT NULL,
  preco_unit DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
  FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);
ALTER TABLE itens_pedido AUTO_INCREMENT = 9001;

CREATE TABLE pagamentos (
  id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido INT NOT NULL,
  forma VARCHAR(20) NOT NULL,   -- 'pix', 'cartao', 'boleto'
  valor DECIMAL(10,2) NOT NULL,
  status VARCHAR(20) NOT NULL,  -- 'aprovado', 'pendente', 'recusado'
  FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
);
ALTER TABLE pagamentos AUTO_INCREMENT = 9501;

CREATE TABLE entregas (
  id_entrega INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido INT NOT NULL,
  transportadora VARCHAR(40) NOT NULL,
  prazo_dias INT NOT NULL,
  FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
);
ALTER TABLE entregas AUTO_INCREMENT = 9801;

-- DADOS
-- CLIENTES
INSERT INTO clientes (nome, estado) VALUES
('Ana Souza','SP'),
('Bruno Lima','SP'),
('Carla Nunes','RJ'),
('Diego Alves','MG'),
('Elaine Costa','SP'),
('Felipe Prado','RJ'),
('Giselle Moraes','MG'),
('Heitor Ramos','SP'),
('Iara Pires','RJ'),
('Jonas Freitas','MG');

-- CATEGORIAS
INSERT INTO categorias (nome) VALUES
('Eletrônicos'),
('Livros'),
('Games');

-- PRODUTOS (inclui 1 produto "encostado" sem venda)
INSERT INTO produtos (nome, id_categoria, preco) VALUES
('Fone Sem Fio ZX',    (SELECT id_categoria FROM categorias WHERE nome='Eletrônicos'), 199.90),
('Mouse Óptico Pro',   (SELECT id_categoria FROM categorias WHERE nome='Eletrônicos'),  89.90),
('Teclado Mecânico K7',(SELECT id_categoria FROM categorias WHERE nome='Eletrônicos'), 399.00),
('Power Bank 10k',     (SELECT id_categoria FROM categorias WHERE nome='Eletrônicos'), 149.00),

('Romance A',          (SELECT id_categoria FROM categorias WHERE nome='Livros'),       39.90),
('Romance B',          (SELECT id_categoria FROM categorias WHERE nome='Livros'),       44.90),
('Suspense X',         (SELECT id_categoria FROM categorias WHERE nome='Livros'),       59.90),
('Didático SQL',       (SELECT id_categoria FROM categorias WHERE nome='Livros'),       79.90),

('Jogo Corrida X',     (SELECT id_categoria FROM categorias WHERE nome='Games'),       249.00),
('Jogo Aventura Y',    (SELECT id_categoria FROM categorias WHERE nome='Games'),       299.00),
('Jogo Estratégia Z',  (SELECT id_categoria FROM categorias WHERE nome='Games'),       279.00),
('Controle GamePad',   (SELECT id_categoria FROM categorias WHERE nome='Games'),       199.00),

('Cabo USB-C Básico',  (SELECT id_categoria FROM categorias WHERE nome='Eletrônicos'),  29.90); -- sem venda

-- PEDIDOS (pedido 10 já 'pago'; pedido extra da Ana em agosto)
INSERT INTO pedidos (id_cliente, data_pedido, status) VALUES
((SELECT id_cliente FROM clientes WHERE nome='Ana Souza'),    '2025-06-10', 'pago'),
((SELECT id_cliente FROM clientes WHERE nome='Ana Souza'),    '2025-07-02', 'pago'),
((SELECT id_cliente FROM clientes WHERE nome='Bruno Lima'),   '2025-07-15', 'pago'),
((SELECT id_cliente FROM clientes WHERE nome='Carla Nunes'),  '2025-07-20', 'aberto'),
((SELECT id_cliente FROM clientes WHERE nome='Diego Alves'),  '2025-07-28', 'pago'),
((SELECT id_cliente FROM clientes WHERE nome='Elaine Costa'), '2025-08-01', 'pago'),
((SELECT id_cliente FROM clientes WHERE nome='Felipe Prado'), '2025-08-03', 'cancelado'),
((SELECT id_cliente FROM clientes WHERE nome='Giselle Moraes'),'2025-08-05','pago'),
((SELECT id_cliente FROM clientes WHERE nome='Heitor Ramos'), '2025-08-05', 'pago'),
((SELECT id_cliente FROM clientes WHERE nome='Iara Pires'),   '2025-08-10', 'pago'),   -- corrigido
((SELECT id_cliente FROM clientes WHERE nome='Jonas Freitas'),'2025-08-12','aberto'),
((SELECT id_cliente FROM clientes WHERE nome='Carla Nunes'),  '2025-08-15', 'pago'),
((SELECT id_cliente FROM clientes WHERE nome='Ana Souza'),    '2025-08-13', 'pago');   -- cobre todos os meses pagos

-- ITENS (sempre com lista de colunas) -----------------------
-- Ana '2025-06-10' -> Fone + Romance A
INSERT INTO itens_pedido (id_pedido, id_produto, qtde, preco_unit)
SELECT p.id_pedido, pr.id_produto, 1, pr.preco
FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Ana Souza'
JOIN produtos pr ON pr.nome='Fone Sem Fio ZX'
WHERE p.data_pedido='2025-06-10';

INSERT INTO itens_pedido (id_pedido, id_produto, qtde, preco_unit)
SELECT p.id_pedido, pr.id_produto, 1, pr.preco
FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Ana Souza'
JOIN produtos pr ON pr.nome='Romance A'
WHERE p.data_pedido='2025-06-10';

-- Ana '2025-07-02' -> Jogo Aventura Y + Didático SQL
INSERT INTO itens_pedido (id_pedido, id_produto, qtde, preco_unit)
SELECT p.id_pedido, pr.id_produto, 1, pr.preco
FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Ana Souza'
JOIN produtos pr ON pr.nome='Jogo Aventura Y'
WHERE p.data_pedido='2025-07-02';

INSERT INTO itens_pedido (id_pedido, id_produto, qtde, preco_unit)
SELECT p.id_pedido, pr.id_produto, 1, pr.preco
FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Ana Souza'
JOIN produtos pr ON pr.nome='Didático SQL'
WHERE p.data_pedido='2025-07-02';

-- Bruno '2025-07-15' -> Teclado K7 + Mouse Pro
INSERT INTO itens_pedido (id_pedido, id_produto, qtde, preco_unit)
SELECT p.id_pedido, pr.id_produto, 1, pr.preco
FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Bruno Lima'
JOIN produtos pr ON pr.nome='Teclado Mecânico K7'
WHERE p.data_pedido='2025-07-15';

INSERT INTO itens_pedido (id_pedido, id_produto, qtde, preco_unit)
SELECT p.id_pedido, pr.id_produto, 1, pr.preco
FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Bruno Lima'
JOIN produtos pr ON pr.nome='Mouse Óptico Pro'
WHERE p.data_pedido='2025-07-15';

-- Carla '2025-07-20' (aberto) -> Suspense X
INSERT INTO itens_pedido (id_pedido, id_produto, qtde, preco_unit)
SELECT p.id_pedido, pr.id_produto, 1, pr.preco
FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Carla Nunes'
JOIN produtos pr ON pr.nome='Suspense X'
WHERE p.data_pedido='2025-07-20';

-- Diego '2025-07-28' -> Power Bank + Jogo Corrida X
INSERT INTO itens_pedido (id_pedido, id_produto, qtde, preco_unit)
SELECT p.id_pedido, pr.id_produto, 1, pr.preco
FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Diego Alves'
JOIN produtos pr ON pr.nome='Power Bank 10k'
WHERE p.data_pedido='2025-07-28';

INSERT INTO itens_pedido (id_pedido, id_produto, qtde, preco_unit)
SELECT p.id_pedido, pr.id_produto, 1, pr.preco
FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Diego Alves'
JOIN produtos pr ON pr.nome='Jogo Corrida X'
WHERE p.data_pedido='2025-07-28';

-- Elaine '2025-08-01' -> Didático SQL + Romance A
INSERT INTO itens_pedido (id_pedido, id_produto, qtde, preco_unit)
SELECT p.id_pedido, pr.id_produto, 1, pr.preco
FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Elaine Costa'
JOIN produtos pr ON pr.nome='Didático SQL'
WHERE p.data_pedido='2025-08-01';

INSERT INTO itens_pedido (id_pedido, id_produto, qtde, preco_unit)
SELECT p.id_pedido, pr.id_produto, 1, pr.preco
FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Elaine Costa'
JOIN produtos pr ON pr.nome='Romance A'
WHERE p.data_pedido='2025-08-01';

-- Felipe '2025-08-03' (cancelado) -> Jogo Aventura Y
INSERT INTO itens_pedido (id_pedido, id_produto, qtde, preco_unit)
SELECT p.id_pedido, pr.id_produto, 1, pr.preco
FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Felipe Prado'
JOIN produtos pr ON pr.nome='Jogo Aventura Y'
WHERE p.data_pedido='2025-08-03';

-- Giselle '2025-08-05' -> Jogo Estratégia Z + Romance B
INSERT INTO itens_pedido (id_pedido, id_produto, qtde, preco_unit)
SELECT p.id_pedido, pr.id_produto, 1, pr.preco
FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Giselle Moraes'
JOIN produtos pr ON pr.nome='Jogo Estratégia Z'
WHERE p.data_pedido='2025-08-05';

INSERT INTO itens_pedido (id_pedido, id_produto, qtde, preco_unit)
SELECT p.id_pedido, pr.id_produto, 1, pr.preco
FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Giselle Moraes'
JOIN produtos pr ON pr.nome='Romance B'
WHERE p.data_pedido='2025-08-05';

-- Heitor '2025-08-05' -> Controle GamePad + Mouse Pro
INSERT INTO itens_pedido (id_pedido, id_produto, qtde, preco_unit)
SELECT p.id_pedido, pr.id_produto, 1, pr.preco
FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Heitor Ramos'
JOIN produtos pr ON pr.nome='Controle GamePad'
WHERE p.data_pedido='2025-08-05';

INSERT INTO itens_pedido (id_pedido, id_produto, qtde, preco_unit)
SELECT p.id_pedido, pr.id_produto, 1, pr.preco
FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Heitor Ramos'
JOIN produtos pr ON pr.nome='Mouse Óptico Pro'
WHERE p.data_pedido='2025-08-05';

-- Iara '2025-08-10' (pago) -> Jogo Corrida X + Suspense X
INSERT INTO itens_pedido (id_pedido, id_produto, qtde, preco_unit)
SELECT p.id_pedido, pr.id_produto, 1, pr.preco
FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Iara Pires'
JOIN produtos pr ON pr.nome='Jogo Corrida X'
WHERE p.data_pedido='2025-08-10';

INSERT INTO itens_pedido (id_pedido, id_produto, qtde, preco_unit)
SELECT p.id_pedido, pr.id_produto, 1, pr.preco
FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Iara Pires'
JOIN produtos pr ON pr.nome='Suspense X'
WHERE p.data_pedido='2025-08-10';

-- Jonas '2025-08-12' (aberto) -> Teclado K7
INSERT INTO itens_pedido (id_pedido, id_produto, qtde, preco_unit)
SELECT p.id_pedido, pr.id_produto, 1, pr.preco
FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Jonas Freitas'
JOIN produtos pr ON pr.nome='Teclado Mecânico K7'
WHERE p.data_pedido='2025-08-12';

-- Carla '2025-08-15' (pago) -> Fone + Didático SQL + Jogo Aventura Y
INSERT INTO itens_pedido (id_pedido, id_produto, qtde, preco_unit)
SELECT p.id_pedido, pr.id_produto, 1, pr.preco
FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Carla Nunes'
JOIN produtos pr ON pr.nome='Fone Sem Fio ZX'
WHERE p.data_pedido='2025-08-15';

INSERT INTO itens_pedido (id_pedido, id_produto, qtde, preco_unit)
SELECT p.id_pedido, pr.id_produto, 1, pr.preco
FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Carla Nunes'
JOIN produtos pr ON pr.nome='Didático SQL'
WHERE p.data_pedido='2025-08-15';

INSERT INTO itens_pedido (id_pedido, id_produto, qtde, preco_unit)
SELECT p.id_pedido, pr.id_produto, 1, pr.preco
FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Carla Nunes'
JOIN produtos pr ON pr.nome='Jogo Aventura Y'
WHERE p.data_pedido='2025-08-15';

-- Ana '2025-08-13' (pago) -> Fone Sem Fio ZX
INSERT INTO itens_pedido (id_pedido, id_produto, qtde, preco_unit)
SELECT p.id_pedido, pr.id_produto, 1, pr.preco
FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Ana Souza'
JOIN produtos pr ON pr.nome='Fone Sem Fio ZX'
WHERE p.data_pedido='2025-08-13';
-- -----------------------------------------------------------

-- PAGAMENTOS (valores planejados)
INSERT INTO pagamentos (id_pedido, forma, valor, status) VALUES
((SELECT id_pedido FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Ana Souza'    WHERE p.data_pedido='2025-06-10'), 'pix',    239.80, 'aprovado'),
((SELECT id_pedido FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Ana Souza'    WHERE p.data_pedido='2025-07-02'), 'cartao', 378.90, 'aprovado'),
((SELECT id_pedido FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Bruno Lima'   WHERE p.data_pedido='2025-07-15'), 'pix',    488.90, 'aprovado'),
((SELECT id_pedido FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Carla Nunes'  WHERE p.data_pedido='2025-07-20'), 'pix',     59.90, 'pendente'),
((SELECT id_pedido FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Diego Alves'  WHERE p.data_pedido='2025-07-28'), 'boleto', 398.00, 'aprovado'),
((SELECT id_pedido FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Elaine Costa' WHERE p.data_pedido='2025-08-01'), 'pix',    119.80, 'aprovado'),
((SELECT id_pedido FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Felipe Prado' WHERE p.data_pedido='2025-08-03'), 'cartao', 299.00, 'recusado'),
((SELECT id_pedido FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Giselle Moraes'WHERE p.data_pedido='2025-08-05'), 'pix',   323.90, 'aprovado'),
((SELECT id_pedido FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Heitor Ramos' WHERE p.data_pedido='2025-08-05'), 'pix',   288.90, 'aprovado'),
((SELECT id_pedido FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Iara Pires'   WHERE p.data_pedido='2025-08-10'), 'cartao', 308.90, 'aprovado'),
((SELECT id_pedido FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Jonas Freitas'WHERE p.data_pedido='2025-08-12'), 'pix',   399.00, 'pendente'),
((SELECT id_pedido FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Carla Nunes'  WHERE p.data_pedido='2025-08-15'), 'cartao', 578.80, 'aprovado'),
((SELECT id_pedido FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Ana Souza'    WHERE p.data_pedido='2025-08-13'), 'pix',   199.90, 'aprovado');

-- ENTREGAS (somente pedidos não cancelados)
INSERT INTO entregas (id_pedido, transportadora, prazo_dias) VALUES
((SELECT id_pedido FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Ana Souza'    WHERE p.data_pedido='2025-06-10'), 'RápidaLog', 5),
((SELECT id_pedido FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Ana Souza'    WHERE p.data_pedido='2025-07-02'), 'RápidaLog', 7),
((SELECT id_pedido FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Bruno Lima'   WHERE p.data_pedido='2025-07-15'), 'EntregaJá', 3),
((SELECT id_pedido FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Diego Alves'  WHERE p.data_pedido='2025-07-28'), 'EntregaJá', 5),
((SELECT id_pedido FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Elaine Costa' WHERE p.data_pedido='2025-08-01'), 'RápidaLog', 6),
((SELECT id_pedido FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Giselle Moraes'WHERE p.data_pedido='2025-08-05'), 'EntregaJá', 4),
((SELECT id_pedido FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Heitor Ramos' WHERE p.data_pedido='2025-08-05'), 'RápidaLog', 5),
((SELECT id_pedido FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Iara Pires'   WHERE p.data_pedido='2025-08-10'), 'EntregaJá', 3),
((SELECT id_pedido FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Carla Nunes'  WHERE p.data_pedido='2025-08-15'), 'RápidaLog', 7),
((SELECT id_pedido FROM pedidos p JOIN clientes c ON c.id_cliente=p.id_cliente AND c.nome='Ana Souza'    WHERE p.data_pedido='2025-08-13'), 'EntregaJá', 4);



-- Liste o id_pedido, data_pedido, status e o total do pedido calculado
-- com uma subconsulta que some qtde preco_unit dos itens

SELECT 
	pedidos.id_pedido,
    pedidos.data_pedido,
    pedidos.status,
    (
		SELECT SUM(itens_pedido.qtde * itens_pedido.preco_unit)
        FROM itens_pedido 
        WHERE itens_pedido.id_pedido = pedidos.id_pedido
	) AS total_pedido
FROM pedidos;

-- Mostre o id_pedido, data_pedido e o tal calculado por subconsulta apenas
-- para os pedidos cujo total é maior que a média geral de todos os pedidos

SELECT 
	pedidos.id_pedido,
    pedidos.data_pedido,
    (
		SELECT SUM(itens_pedido.qtde * itens_pedido.preco_unit)
        FROM itens_pedido
        WHERE itens_pedido.id_pedido = pedidos.id_pedido
	) AS total_pedido
FROM pedidos
WHERE 
	(
		SELECT SUM(itens_pedido.qtde * itens_pedido.preco_unit)
        FROM itens_pedido
        WHERE itens_pedido.id_pedido = pedidos.id_pedido
	) >
    (
		SELECT AVG(total_por_pedido.total_pedido)
        FROM (
			SELECT 
				itens_pedido.id_pedido,
                SUM(itens_pedido.qtde * itens_pedido.preco_unit) AS total_pedido
			FROM itens_pedido
            GROUP BY itens_pedido.id_pedido
            ) AS total_por_pedido
	);
    
    -- Mostre o id_produto e o nome dos produtos que não aparecem em nenhum registri
    -- da tabela itens_pedido
    
    SELECT 
		produtos.id_produto,
        produtos.nome
	FROM produtos
    WHERE produtos.id_produto NOT IN (
		SELECT itens_pedido.id_produto 
        FROM itens_pedido
	);
    
    -- Liste o id_cliente e nome dos cliente que nunca compraram produtos
    -- da categoria 'games'
    
SELECT 
    clientes.id_cliente,
    clientes.nome
FROM clientes
WHERE clientes.id_cliente NOT IN (
    SELECT pedidos.id_cliente
    FROM pedidos
    JOIN itens_pedido ON itens_pedido.id_pedido = pedidos.id_pedido
    JOIN produtos ON produtos.id_produto = itens_pedido.id_produto
    JOIN categorias ON categorias.id_categoria = produtos.id_categoria
    WHERE categorias.nome = 'Games'
);

-- mostre o id_produto, nome e preco dos produtos cujoo preço é o maior dentro da
-- sua categoria

SELECT 
    produtos.id_produto,
    produtos.nome,
    produtos.preco
FROM produtos
WHERE produtos.preco = (
    SELECT MAX(produto2.preco)
    FROM produtos produto2
    WHERE produto2.id_categoria = produtos.id_categoria
);

-- Exiba o id_pedido e prazo_dias das entregas de pedidos pagos cujos prazo é
-- menor que a média de todos os prazos

SELECT 
    entregas.id_pedido,
    entregas.prazo_dias
FROM entregas
WHERE entregas.id_pedido IN
	(
	SELECT id_pedido
    FROM pedidos
    WHERE status = 'Pago'
    )
AND entregas.prazo_dias < (
	SELECT AVG (prazo_dias)
    FROM entregas
);

-- Liste o id_produto, nome e preco dos produtos cujo preco é maior que a média
-- de preços da própria categoria
    
SELECT 
		produtos.id_produto,
        produtos.nome,
        produtos.preco
FROM produtos
WHERE produtos.preco >
	(
		SELECT AVG (produtos2.preco)
        FROM produtos AS produtos2
        WHERE produtos2.id_categoria = produtos.id_categoria
	);


-- Mostre o id_produto, nome e quantos produtos da mesma categoria têm preço 
-- maior. Depois, traga apenas os que não tem nenhum mais caro (top de categoria)
-- obs: são duas 2 consultas indenpendentes aqui

SELECT 
	produtos.id_produto,
    produtos.nome,
    (
		SELECT COUNT(*)
        FROM produtos AS outros_produtos
        WHERE outros_produtos.id_categoria = produtos.id_categoria
        AND outros_produtos.preco > produtos.preco
	)
    AS quantidade_mais_caros
FROM produtos;

SELECT 
    produtos.id_produto,
    produtos.nome,
    produtos.preco
FROM produtos
WHERE 
    (
        SELECT COUNT(*)
        FROM produtos AS outros_produtos
        WHERE outros_produtos.id_categoria = produtos.id_categoria
          AND outros_produtos.preco > produtos.preco
    ) = 0;

-- Liste o id_produto e nome dos produtos que já foram vendidos em pedidos com 
-- pagamentos aprovado

SELECT DISTINCT 
    produtos.id_produto,
    produtos.nome
FROM produtos
JOIN itens_pedido
    ON itens_pedido.id_produto = produtos.id_produto
JOIN pagamentos
    ON pagamentos.id_pedido = itens_pedido.id_pedido
WHERE pagamentos.status = 'aprovado';

-- desafio 1: liste o nome do cliente, id_pedido e o total apenas dos pedidos
-- de maior valor no mês de agosto/2025

SELECT 
    clientes.nome, 
    pedidos.id_pedido, 
    SUM(itens_pedido.qtde * itens_pedido.preco_unit) AS total_pedido
FROM pedidos
JOIN clientes 
    ON pedidos.id_cliente = clientes.id_cliente
JOIN itens_pedido 
    ON pedidos.id_pedido = itens_pedido.id_pedido
WHERE pedidos.data_pedido BETWEEN '2025-08-01' AND '2025-08-31'
GROUP BY pedidos.id_pedido, clientes.nome
HAVING total_pedido = (

    -- Subconsulta para achar o valor MÁXIMO entre as somas de agosto
    SELECT MAX(soma_mensal)
    FROM (
        SELECT SUM(itens_pedido.qtde * itens_pedido.preco_unit) AS soma_mensal
        FROM pedidos
        JOIN itens_pedido 
            ON pedidos.id_pedido = itens_pedido.id_pedido
        WHERE pedidos.data_pedido BETWEEN '2025-08-01' AND '2025-08-31'
        GROUP BY pedidos.id_pedido
    ) AS tabela_temporaria
);

-- desafio 2: mostre apenas o mes, id_pedido e o total do pedido de maior valor
-- em cada mes (somando qtde * preco_unit) usando subconsulta no from

SELECT 
    tabela_todos_pedidos.mes,
    tabela_todos_pedidos.id_pedido,
    tabela_todos_pedidos.total_pedido
FROM 
    (
        SELECT 
            MONTH(pedidos.data_pedido) AS mes,
            pedidos.id_pedido,
            SUM(itens_pedido.qtde * itens_pedido.preco_unit) AS total_pedido
        FROM pedidos
        JOIN itens_pedido 
            ON pedidos.id_pedido = itens_pedido.id_pedido
        GROUP BY MONTH(pedidos.data_pedido), pedidos.id_pedido
    ) AS tabela_todos_pedidos

JOIN 
    (
        SELECT 
            mes, 
            MAX(total_pedido) AS maior_valor
        FROM 
            (
                SELECT 
                    MONTH(pedidos.data_pedido) AS mes,
                    SUM(itens_pedido.qtde * itens_pedido.preco_unit) AS total_pedido
                FROM pedidos
                JOIN itens_pedido 
                    ON pedidos.id_pedido = itens_pedido.id_pedido
                GROUP BY MONTH(pedidos.data_pedido), pedidos.id_pedido
            ) AS tabela_auxiliar
        GROUP BY mes
    ) AS tabela_maiores_valores

ON tabela_todos_pedidos.mes = tabela_maiores_valores.mes 
AND tabela_todos_pedidos.total_pedido = tabela_maiores_valores.maior_valor

ORDER BY tabela_todos_pedidos.mes;
