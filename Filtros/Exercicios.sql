
-- Liste os títulos e categorias dos livros do Gênero mistério
-- ordenados por título em ordem alfabética

SELECT 
	Livro.titulo, 					-- seleciona o titulo do livro
    Categoria.nome AS categoria		-- Seleciona o nome da categoria
FROM Livro							-- Tabela principal da consulta		
JOIN LivroCategoria ON Livro.id = LivroCategoria.livro_id  -- Faz a conexão de cada livro a sua categoria na tabela intermediaria
JOIN Categoria ON LivroCategoria.categoria_id = Categoria.id -- Conecta a categoria correta ao livro
WHERE Categoria.nome = "Mistério" -- Filtra somente os livros da categoria "Mistério"
ORDER BY Livro.titulo ASC; -- Coloca os resultados em ordem alfabética

-- Mostre o titulo e isbn dos livros que comecem com a letra "O"

SELECT 
	Livro.titulo,
    Livro.isbn
FROM Livro
WHERE Livro.titulo LIKE 'O%' -- Filtra os livros cujo titulo começa com "O"
ORDER BY Livro.titulo ASC;

-- Liste os nomes e níveis de associação dos usuários cadastrados
-- após o dia 01/06/2023.

SELECT 
	Usuario.nome,
    Usuario.nivel_associacao
FROM Usuario
WHERE Usuario.data_cadastro > '2023-06-01'
ORDER BY Usuario.nome ASC;

-- Mostre o nome dos autores cuja data esta ausente

SELECT 
	Autor.nome,
    Autor.data_nascimento
FROM Autor
WHERE data_nascimento IS NULL;

-- Exiba o titulos e descrições dos livros que possuem descrição preenchida

SELECT 
	Livro.titulo,
    Livro.descricao
FROM Livro
WHERE Livro.descricao IS NOT NULL;

-- Liste os usuários regulares ou premiums e mostre apenas 
-- nome e data de cadastro

SELECT 
       Usuario.nome,
       Usuario.data_cadastro
FROM Usuario
WHERE Usuario.nivel_associacao IN ('premium', 'regular');

-- Mostre os livros com id entre 3 e 6

SELECT * 
FROM Livro 
WHERE id BETWEEN 3 AND 6;

-- Liste o nome e email dos usuários cujo nome não começa com "M".

SELECT 
	Usuario.nome,
    Usuario.email
FROM Usuario
WHERE Usuario.nome NOT LIKE 'M%'
ORDER BY Usuario.nome ASC; 


-- Exiba os titulos dos livros emprestados que ainda não foram devolvidos

SELECT 
	Livro.titulo
FROM Emprestimo
JOIN Livro ON Livro.id = Emprestimo.livro_id 
WHERE Emprestimo.data_devolucao IS NULL;
  
-- Mostre os 5 primeiros livros cadastrados
SELECT 
	Livro.titulo,
    Livro.isbn,
    Livro.descricao
FROM Livro
LIMIT 5;

-- Mostre os 5 livros seguintes após pular os 3 primeiros
SELECT 
	Livro.titulo,
    Livro.isbn,
    Livro.descricao
FROM Livro
LIMIT 5 OFFSET 3;

-- Mostre os títulos de livros cujo nome tenha exatamente 5 letras 
-- antes de "rry".

SELECT 
	Livro.titulo
FROM Livro
WHERE titulo LIKE '_____%rry%'; -- 5 underscors (_) representam 5 letras antes de "rry".

-- Liste os usuarios premium cadastrados depois de julho de 2023
SELECT
	Usuario.nome,
    Usuario.data_cadastro
FROM Usuario
WHERE Usuario.nivel_associacao IN ('premium') AND Usuario.data_cadastro > '2023-07-01';
    
-- Liste os titulos de livros de categoria Ficção ou Mistério 
-- que tenham descrição preenchida

SELECT
	Livro.titulo
FROM Livro
JOIN LivroCategoria ON Livro.id = LivroCategoria.livro_id
JOIN Categoria ON Categoria.id = LivroCategoria.categoria_id
WHERE categoria.nome IN ('Ficção', 'Mistério') AND Livro.descricao IS NOT NULL
ORDER BY Livro.titulo ASC;

-- Liste os títulos, nomes dos autores e categorias dos livros
-- emprestados entre janeiro e fevereiro de 2024, cujo titulo
-- começa com "O" que possuam descrição preenchida, e sejam de 
-- uma das categorias "Mistério", "Ficção" ou "Fantasia".
-- Mostre apenas os livros escritos por autores cujo nome contém 
-- a letra "A". Ordene o resultado por título

SELECT 
	Livro.titulo, 
    Autor.nome, 
    Categoria.nome
FROM Emprestimo
INNER JOIN Livro ON Livro.id = Emprestimo.livro_id
INNER JOIN LivroAutor ON Livro.id = LivroAutor.livro_id
INNER JOIN Autor ON LivroAutor.autor_id = Autor.id
INNER JOIN LivroCategoria ON Livro.id = LivroCategoria.livro_id
INNER JOIN Categoria ON LivroCategoria.categoria_id = Categoria.id

WHERE Emprestimo.data_emprestimo BETWEEN '2024-01-01' AND '2024-02-29'
AND Livro.titulo LIKE 'O%'
AND Livro.descricao IS NOT NULL
AND Categoria.nome IN ('Mistério', 'Ficção', 'Fantasia')
AND Autor.nome LIKE '%a%'
ORDER BY Livro.titulo ASC;
