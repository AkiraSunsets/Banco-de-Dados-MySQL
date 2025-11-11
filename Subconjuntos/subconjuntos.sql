-- 1. Criação do banco
CREATE DATABASE lojaMarcia;
USE lojaMarcia;
 
-- 2. Tabelas
CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome_categoria VARCHAR(50)
);
 
CREATE TABLE fornecedores (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome_fornecedor VARCHAR(100),
    pais VARCHAR(50)
);
 
CREATE TABLE produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(100),
    preco DECIMAL(10, 2),
    id_categoria INT,
    id_fornecedor INT,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedores(id_fornecedor)
);
 
-- 3. Inserção dos dados
INSERT INTO categorias (nome_categoria) VALUES
('Eletrônicos'), ('Roupas'), ('Livros'), ('Esportes');
 
INSERT INTO fornecedores (nome_fornecedor, pais) VALUES
('TechGlobal', 'EUA'), ('ModaBrasil', 'Brasil'), ('BookWorld', 'EUA'), ('SportsInc', 'Brasil'), ('Fornecedor Fantasma', 'Japão');
 
INSERT INTO produtos (nome_produto, preco, id_categoria, id_fornecedor) VALUES
('Notebook', 3500.00, 1, 1),      -- Eletrônicos, TechGlobal
('Smartphone', 1500.00, 1, 1),   -- Eletrônicos, TechGlobal
('Camiseta', 80.00, 2, 2),       -- Roupas, ModaBrasil
('Calça Jeans', 120.00, 2, 2),     -- Roupas, ModaBrasil
('O Gene Egoísta', 50.00, 3, 3),   -- Livros, BookWorld
('Bola de Futebol', 100.00, 4, 4); -- Esportes, SportsInc


-- Subconsultas
-- é uma consulta SELECT dentro de outra consulta
-- pergunta interna e pergunta externa

-- Como funciona:

-- A consulta interna acontece primeiro e "entrega sua resposta para a consulta externa usar.
SELECT nome_produto
FROM produtos
WHERE id_categoria = ("aqui vai a subconsulta");

-- O computador primeiro executa a pergunta interna para descobrir o ID de "bebidas"
SELECT id
FROM categorias
WHERE nome = 'Bebidas';

-- Agora a resposta da subconsulta é entregue para consulta externa, dizendo que só precisa pegar os produtos da categoria = 2

SELECT nome_produto
FROM produtos
WHERE id_categoria = 2;


-- Lembre-se:
-- De dentro para fora, a consulta acontece.
-- Com subconsultas, permitimos o banco anotar o ID para nós 

-- Tipos:

-- Where 
-- Usamos uma consulta no Where para filtrar os resultados da consulta principal

-- exemplo: listar todos os produtos eletrônicos, mas a tabela produtos só tem o id da categoria
-- ex:

SELECT nome_produto, Preco -- procure o nome produto e preço
FROM Produtos -- de produtos
WHERE ID_Categoria = ( -- procura pelo id
	SELECT ID_Categoria -- retorna o valor do id
    FROM Categorias -- vai até a tabela categoria
    WHERE Nome_Categoria = 'Eletrônicos' -- procura pela linha nome_categoria = 'Eletrônicos'
); /* retornou notebook e smartphone e o preço*/


-- Subtipos

-- IN e NOT insert

-- IN: Verifica se um valor existe dentro de uma lista
-- NOT IN: Verifica se um valor Não existe dentro de um conjunto (uma lista)

-- exemplo IN
-- Ver todos os produtos de fornecedores que são dos EUA

SELECT Nome_Produto, Preco -- seleciona o nome e o preço
FROM Produtos
WHERE ID_Fornecedor IN ( -- retorna lista de 1 e 3
SELECT ID_Fornecedor 
FROM Fornecedores -- onde o fornecedor
WHERE Pais = 'EUA' -- for estados unidos
);

-- NOT IN 
-- Quero ver todos os produtos de fornecedores que não são do eua

SELECT Nome_Produto, Preco
FROM Produtos
WHERE ID_Fornecedor NOT IN (
	SELECT ID_Fornecedor
    FROM Fornecedores
    WHERE Pais = 'EUA'
);

-- Retorna somente valores que não estão dentro de 1,3

-- ANY E ALL
-- Usados para fazer filtragem de dados 

-- ANY
-- Retorna true se a comparação for verdadeira para pelo menos um dos valores retornados pela subconsulta

SELECT Nome_Produto, Preco
FROM Produtos
WHERE Preco > ANY ( -- onde ao menos um for maior que 80
	SELECT Preco FROM Produtos
WHERE ID_Categoria = 2
);

-- ALL retorna true somente se a comparação for verdadeira para todos os valores retornados pela subconsulta

SELECT Nome_Produto, Preco
FROM Produtos
WHERE Preco > ALL ( -- Retorna todos os que for maior que todos da categoria 2
	SELECT Preco FROM Produtos
WHERE ID_Categoria = 2
);

-- EXISTS - É verdadeiro se a subconsulta retornar pelo menos uma linha

-- exemplo: ver o nome de todas as categorias que possuem (ou existe) pelo menos um produto cadastrado nelas

SELECT Nome_Categoria
FROM Categorias
WHERE EXISTS(
SELECT * 
FROM Produtos
WHERE Produtos.ID_Categoria = Categorias.ID_Categoria
);


-- NOT EXISTS - É verdadeiro se a subconsulta não retornar nenhuma linha
-- quero ver o nome de todas as categorias que não possuem (ou seja, existe) pelo menos um produto cadastrado nelas
SELECT Nome_Fornecedor
FROM Fornecedores
WHERE NOT EXISTS (
SELECT 1
FROM Produtos
WHERE Produtos.id_Fornecedor = Fornecedores.id_Fornecedor
);

-- FROM 
-- é uma subconsulta na cláusula FROM gera uma tabela temporária que pode ser usada pela consulta principal

SELECT Nome_Categoria, Media_Preco_Categoria
FROM (
		SELECT C.Nome_Categoria,
        AVG (P.preco) AS Media_Preco_Categoria -- calcula a média dos produtos
FROM Produtos AS P
JOIN Categorias AS C ON P.id_categoria = C.id_categoria
GROUP BY C.Nome_Categoria -- agrupa os registros pelo nome da categoria
	)
AS Tabela_Medias
WHERE Media_Preco_Categoria > 100; -- exibe somente a categoria que é maior que 100

-- SELECT 
-- Usamos uma subconsulta no SELECT para criar uma nova coluna calculada no resultado

SELECT Nome_Categoria,
	(
		SELECT COUNT(*) -- conta quantos produtos existem em cada categoria e coloca o valor na consulta chamada Quantidade_Produtos
        FROM Produtos
        WHERE Produtos.id_Categoria = Categorias.id_Categoria
	) AS Quantidade_Produtos
    FROM Categorias; -- percorre todas as categorias e procura um especifico


