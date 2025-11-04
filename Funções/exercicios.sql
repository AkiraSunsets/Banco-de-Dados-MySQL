
-- Mostre o nome de todos os usuários e o ano em que se cadastram
SELECT nome AS Nome,
YEAR (data_cadastro) AS Ano_Cadastro
FROM Usuario;

-- Exiba o nome dos autores e o mês de nascimento de cada um
SELECT nome AS Nome,
MONTH (data_nascimento) AS Mes_Nascimento
FROM Autor;

-- Liste o nome do usuário, título do livro, data_emprestimo, data_devolucao e a 
-- diferença em dias entre essas duas datas de todos os empréstimos que já foram devolvidos
SELECT
	Usuario.nome AS Nome_Usuario,
    Livro.titulo AS Titulo_Livro,
    Emprestimo.data_emprestimo AS Data_Emprestimo,
    Emprestimo.data_devolucao AS Data_Devolucao,
    DATEDIFF(Emprestimo.data_devolucao, Emprestimo.data_emprestimo) AS Dias_Entre
FROM Emprestimo
JOIN Usuario ON Usuario.id = Emprestimo.usuario_id
JOIN Livro ON Livro.id = Emprestimo.livro_id
WHERE Emprestimo.data_devolucao IS NOT NULL;

-- Mostre os livros emprestados (titulo) e a data formatada do empréstimo no formato dd/mm/aaaa
SELECT 
	Livro.titulo AS Titulo_Livro,
    DATE_FORMAT (Emprestimo.data_emprestimo, '%d/%m/%y') AS Data_Emprestimo_Formatada
FROM Emprestimo
JOIN Livro ON Emprestimo.livro_id = Livro.id;

-- Liste a data do cadastro e o dia da semana em que cada usuário foi cadastrado 
SELECT 
    DATE_FORMAT (Usuario.data_cadastro, '%d/%m/%y') AS Data_Cadastro,
    DAYNAME (Usuario.data_cadastro)
FROM Usuario;

-- Mostre a diferença absoluta em dias entre a data de devolução e a data limite de devolução
-- e a data limite de devolução (empréstimo já devolvidos), acrescente mais uma coluna mostrando
-- somente a diferença em dias entre a data de devolução e a data limite de devolução 
-- (uma coluna com diferencia absoluta e outra sem a função)

SELECT 
    ABS(DATEDIFF(Emprestimo.data_devolucao, Emprestimo.data_devolucao_limite)) AS Diferenca_Absoluta_Dias,
    DATEDIFF(Emprestimo.data_devolucao, Emprestimo.data_devolucao_limite) AS Diferenca_Real_Dias
FROM Emprestimo
JOIN Usuario ON Emprestimo.usuario_id = Usuario.id
JOIN Livro ON Emprestimo.livro_id = Livro.id
WHERE Emprestimo.data_devolucao IS NOT NULL;

-- Calcule o valor da multa, considerando 1 real por dia de atraso (data_devolucao > data devolucao_limite)
-- e mostre o valor arrendondado para 2 casas decimais
SELECT 
    ROUND(DATEDIFF(data_devolucao, data_devolucao_limite), 2) 
FROM Emprestimo
WHERE data_devolucao > data_devolucao_limite;

-- Liste o nome dos usuários em maiúsculas

SELECT 
	UPPER (nome) AS Nome_Usuario_Maiusculo
FROM Usuario;

-- Liste os nomes dos livros com apenas os 5 primeiros caracteres
SELECT 
	LEFT (titulo, 5) AS Primeiros_5_caracteres
FROM Livro;

-- Mostre o nome e o email de cada usuário concatenado com um traço entre eles.
SELECT 
	CONCAT (nome, ' - ', email) AS Nome_Email_Concatenado
FROM Usuario;

-- Mostre os nomes dos autores com todas as letras 'a' substituidas por @
SELECT 
	REPLACE (nome, 'a', '@') AS Nome_Com_Arroba
FROM Autor;

-- Liste o nome dos livros e o número de caracteres de cada título
SELECT 
	titulo AS Nome_Livro,
    CHAR_LENGTH (titulo) AS Numero_Caracteres
FROM Livro;

-- Mostre quantos usuários há no total
SELECT 
	COUNT(*) AS Total_Usuarios
FROM Usuario;

-- Exiba a média de dias de empréstimo (entre data_emprestimo e data_devolucao) 
-- para os empréstimos já devolvidos

SELECT 
	AVG(DATEDIFF (data_devolucao, data_emprestimo))
FROM Emprestimo
WHERE data_devolucao IS NOT NULL;

-- Mostre o menor e o maior número de dias entre data_emprestimo e data_devolucao 
-- para os empréstimos já devolvidos

SELECT 
	MIN(DATEDIFF(data_devolucao, data_emprestimo)) AS Menor_Quantidade_Dias,
    MAX(DATEDIFF(data_devolucao, data_emprestimo)) AS Maior_Quantidade_Dias
FROM Emprestimo
WHERE data_devolucao IS NOT NULL;

-- Mostre quantos usuários existem por nível de associação
SELECT 
	nivel_associacao AS Nivel_Associacao,
    COUNT(*) AS Quantidade_Usuarios
FROM Usuario
GROUP BY nivel_associacao;

-- Mostre quantos livros foram emprestados por usuário
SELECT 
	Usuario.nome AS Nome_Usuario,
    COUNT(Emprestimo.id) AS Quantidade_Livros_Emprestados
    FROM Emprestimo 
    JOIN Usuario ON Emprestimo.usuario_id = Usuario.id
GROUP BY Usuario.nome;

-- Liste quantos empréstimos foram feitos por mês
SELECT 
    MONTH(data_emprestimo) AS Mes,
    COUNT(id) AS Quantidade_Emprestimos
FROM Emprestimo
GROUP BY 
    MONTH(data_emprestimo), 
    MONTHNAME(data_emprestimo)
ORDER BY MONTH(data_emprestimo);

-- Mostre a quantidade de livros por categoria
SELECT
	Categoria.nome AS Nome_Categoria,
    COUNT(LivroCategoria.livro_id) AS Quantidade_Livros
FROM LivroCategoria
JOIN Categoria ON LivroCategoria.categoria_id = Categoria.id
GROUP BY Categoria.nome
ORDER BY Quantidade_Livros DESC;

-- Mostre os níveis de associação com mais de 3 usuários
SELECT
	nivel_associacao AS Nivel_Associacao,
    COUNT(*) AS Quantidade_Usuarios
FROM Usuario
GROUP BY nivel_associacao
HAVING COUNT(*) > 3;

-- Liste os usuários que fizeram mais de 1 empréstimo

SELECT
	Usuario.nome AS Nome_Usuario,
    COUNT(Emprestimo.id) AS Quantidade_Emprestimos
FROM Emprestimo
JOIN Usuario ON Emprestimo.usuario_id = Usuario.id
GROUP BY Usuario.nome
HAVING COUNT(Emprestimo.id) > 1
ORDER BY Quantidade_Emprestimos DESC;

-- Mostre os meses com mais de 2 empréstimos registrados
SELECT
    MONTH(data_emprestimo) AS Mes,
    COUNT(id) AS Quantidade_Emprestimos
FROM Emprestimo
GROUP BY MONTH(data_emprestimo), MONTHNAME(data_emprestimo)
HAVING COUNT(id) > 2
ORDER BY MONTH(data_emprestimo);
 
-- Liste as categorias com mais de 1 livro vinculado

SELECT 
    Categoria.nome AS nome,
    COUNT(LivroCategoria.livro_id) AS 'COUNT(livro_id)'
FROM Categoria
JOIN LivroCategoria ON LivroCategoria.categoria_id = Categoria.id
GROUP BY Categoria.nome
HAVING COUNT(LivroCategoria.livro_id) > 1
ORDER BY COUNT(LivroCategoria.livro_id) DESC;




