DROP DATABASE IF EXISTS biblioteca_joins;
CREATE DATABASE biblioteca_joins;
USE biblioteca_joins;

-- Tabela de autores (ID a partir de 200)
CREATE TABLE autores (
 id_autor INT PRIMARY KEY,
 nome_autor VARCHAR(50)
);

-- Tabela de editoras (ID a partir de 300)
CREATE TABLE editoras (
 id_editora INT PRIMARY KEY,
 nome_editora VARCHAR(50)
);

-- Tabela de livros (ID a partir de 100)
CREATE TABLE livros (
 id_livro INT PRIMARY KEY,
 titulo VARCHAR(100),
 id_autor INT,
 id_editora INT,
 FOREIGN KEY (id_autor) REFERENCES autores(id_autor),
 FOREIGN KEY (id_editora) REFERENCES editoras(id_editora)
);

-- Tabela de leitores (ID a partir de 500)
CREATE TABLE leitores (
 id_leitor INT PRIMARY KEY,
 nome_leitor VARCHAR(50)
);

-- Tabela de empréstimos (ID a partir de 400)
CREATE TABLE emprestimos (
 id_emprestimo INT PRIMARY KEY,
 id_livro INT,
 data DATE
 
 -- sem FOREIGN KEY para simular dados inválidos
);
-- Associação entre empréstimos e leitores
CREATE TABLE emprestimos_leitores (
 id_emprestimo INT,
 id_leitor INT
 -- sem FOREIGN KEY para simular leitor inexistente
);

-- Autores
INSERT INTO autores VALUES
(200, 'Machado de Assis'),
(201, 'George Orwell'),
(202, 'Jorge Amado'),
(203, 'Autor Fantasma'); -- não tem livro

-- Editoras
INSERT INTO editoras VALUES
(300, 'Editora Brasil'),
(301, 'Companhia das Letras'),
(302, 'Saraiva'),
(303, 'Editora Fantasma'); -- não tem livro

-- Livros
INSERT INTO livros VALUES
(100, 'Dom Casmurro', 200, 300),
(101, '1984', 201, 301),
(102, 'A Revolução dos Bichos', 201, 301),
(103, 'Capitães da Areia', 202, 302);

-- Leitores
INSERT INTO leitores VALUES
(500, 'Alice'),
(501, 'Bruno'),
(502, 'Carla');

-- Empréstimos
INSERT INTO emprestimos VALUES
(400, 100, '2024-05-01'),
(401, 101, '2024-05-02'),
(402, 104, '2024-05-03'), -- livro inexistente
(403, 105, '2024-05-04'); -- livro inexistente

-- Empréstimos-Leitores
INSERT INTO emprestimos_leitores VALUES
(400, 500),
(401, 501),
(403, 503); -- leitor inexistente


-- Exercicios 

-- INNER JOIN - Liste todos os empréstimos com o nome do leitor e titulo do livro

SELECT 
	emprestimos.id_emprestimo AS Id_Emprestimo,
	leitores.nome_leitor AS NomeLeitor,
    livros.titulo AS TituloLivro
FROM emprestimos 
INNER JOIN emprestimos_leitores ON emprestimos.id_emprestimo = emprestimos_leitores.id_emprestimo
INNER JOIN leitores ON emprestimos_leitores.id_leitor = leitores.id_leitor
INNER JOIN livros ON emprestimos.id_livro = livros.id_livro;

-- LEFT JOIN - Mostre todos os livros com o nome do autor mesmo os que não foram publicados
SELECT 
	livros.titulo AS TituloLivro,
    autores.nome_autor AS NomeAutor
FROM livros
LEFT JOIN autores 
ON livros.id_autor = autores.id_autor;

-- RIGHT JOIN - Liste todos os autores que não tenham livros publicados
SELECT 
	autores.nome_autor AS NomeAutor,
    livros.titulo AS TituloLivro
FROM livros
RIGHT JOIN autores 
ON livros.id_autor = autores.id_autor;

-- FULL OUTER JOIN - Liste todos os livros e editoras, mesmo que o livro não tenha
-- editora ou a editora não tenha livro

SELECT 	
	livros.titulo AS TituloLivro,
    editoras.nome_editora AS NomeEditora
FROM livros
LEFT JOIN editoras ON livros.id_editora = editoras.id_editora
UNION 
SELECT 	
	livros.titulo AS TituloLivro,
    editoras.nome_editora AS NomeEditora
FROM livros
RIGHT JOIN editoras ON livros.id_editora = editoras.id_editora;


-- CROSS JOIN - Mostre todas as combinações possíveis entre leitores e livros
SELECT 
	leitores.nome_leitor AS NomeLeitor,
    livros.titulo AS TituloLivro
FROM leitores
CROSS JOIN livros;

-- UNION - Mostre todos os nomes de autores e nomes de editoras numa única coluna

SELECT 
	autores.nome_autor
FROM autores
UNION 
SELECT 
	editoras.nome_editora
FROM editoras;

-- LEFT JOIN - Liste os empréstimos com títulos dos livros (pra testar se aparece null nos inválidos)
SELECT
	emprestimos.id_emprestimo AS IdEmprestimo,
	livros.titulo AS LivroTitulo
FROM emprestimos
LEFT JOIN livros
ON emprestimos.id_livro = livros.id_livro;

-- INNER JOIN - Junte os empréstimos com leitores 

SELECT 
	emprestimos.id_emprestimo AS EmprestimoId,
    leitores.nome_leitor AS Leitores
FROM emprestimos
INNER JOIN emprestimos_leitores 
ON emprestimos.id_emprestimo = emprestimos_leitores.id_emprestimo
INNER JOIN leitores
ON emprestimos_leitores.id_leitor = leitores.id_leitor;

-- Exiba todos os livros com o nome da editora, msm que a editora não tenha publicado
-- nenhum livro

SELECT 
	editoras.nome_editora AS EditoraNome,
	livros.titulo AS TituloLivro
FROM livros
LEFT JOIN editoras
ON livros.id_editora = editoras.id_editora;

-- 	Liste todos os leitores e os livros que eles pegaram emprestado
SELECT 	
	leitores.nome_leitor AS NomeLeitor,
    livros.titulo AS TituloLivro
FROM emprestimos
INNER JOIN emprestimos_leitores
ON emprestimos.id_emprestimo = emprestimos_leitores.id_emprestimo
INNER JOIN leitores 
ON emprestimos_leitores.id_leitor = leitores.id_leitor
INNER JOIN livros 
ON emprestimos.id_livro = livros.id_livro;

-- Mostre os nomes de todos os autores e os titulos de seus livros
-- inclua também os autores que ainda não tem livro cadastrado
SELECT 
	autores.nome_autor AS NomeAutor,
    livros.titulo AS TituloLivro
FROM autores
LEFT JOIN livros
ON autores.id_autor = livros.id_autor;
