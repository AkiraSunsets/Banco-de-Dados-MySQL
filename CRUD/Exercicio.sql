CREATE DATABASE biblioteca;
USE biblioteca;

CREATE TABLE Livro (
	ID INT PRIMARY KEY AUTO_INCREMENT,
	TituloLivro VARCHAR(255),
	Descricao TEXT,
	ISBN VARCHAR(20) UNIQUE 
);

CREATE TABLE Categoria (
	ID INT PRIMARY KEY AUTO_INCREMENT,
	NomeCategoria VARCHAR(50) NOT NULL
);

CREATE TABLE LivroCategoria (
	id_livro INT,
	id_categoria INT, 
    PRIMARY KEY (id_livro, id_categoria),
	FOREIGN KEY (id_livro) REFERENCES Livro(id),
	FOREIGN KEY (id_categoria) REFERENCES Categoria(id)
);

CREATE TABLE Usuario (
	ID INT PRIMARY KEY AUTO_INCREMENT,
    NomeUsuario VARCHAR(255),
    Email VARCHAR (50) UNIQUE,
    DataCadastro DATE,
    NumeroIdentificacao VARCHAR(50),
    NivelAssociacao VARCHAR (50)
);

CREATE TABLE Autor (
	ID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR (255), 
    DataNascimento DATE,
    Biografia TEXT
);

CREATE TABLE LivroAutor (
	id_livro INT,
    id_autor INT,
    PRIMARY KEY (id_livro, id_autor),
    FOREIGN KEY (id_livro) REFERENCES Livro(id),
    FOREIGN KEY (id_autor) REFERENCES Autor(id)
);

CREATE TABLE Emprestimo (
	ID INT PRIMARY KEY AUTO_INCREMENT,
    DataEmprestimo DATE, 
    DataLimiteDevolucao DATE,
    DataDevolucao DATE, 
    id_usuario INT,
    id_livro INT, 
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id),
    FOREIGN KEY (id_livro) REFERENCES Livro(id)
    );
    
INSERT INTO Livro (TituloLivro, Descricao, ISBN)
VALUES 
('Como eu era antes de você', 
'É a história de Louisa Clark, uma jovem alegre e cheia de vida que perde o emprego e aceita ser cuidadora de Will Traynor, um banqueiro rico e antes ativo que ficou tetraplégico após um acidente',
 '9780670026609'),
('A Culpa é das estrelas', 'é um romance de John Green que conta a história de Hazel Grace Lancaster e Augustus Waters, dois adolescentes que se apaixonam num grupo de apoio para jovens com câncer',
'9780525478812'),
('Marley e Eu', 'é a história real (e um best-seller autobiográfico de John Grogan) sobre a vida de um casal, John e Jennifer, e o seu labrador Marley, o pior cão do mundo', '9781408263761'),
('O pequeno príncipe', 'O pequeno príncipe é um clássico da literatura infantil que narra a amizade entre um menino e um piloto de avião.', '9788854172388'),
('O extraordinário', 'O livro conta a história de August Pullman (Auggie), um garoto de 10 anos com uma deformidade facial rara que o levou a passar por muitas cirurgias e a ser educado em casa.', '9780370332284'),
('Depois de você', 'Depois de Você narra o processo de luto e os recomeços de Louisa Clark após a morte de Will, mostrando sua luta para encontrar um novo propósito em Londres', '9783805250948'),
('Ainda sou eu', 'O livro acompanha Louisa Clark, após a morte de Will, em sua jornada para se reinventar ao se mudar para Nova York e começar uma nova vida, envolvendo-se com os ricos e peculiares Gopnik', '9780718183189'),
('O meu pé de laranja lima', 'O Meu Pé de Laranja Lima conta a história de Zezé, um menino pobre e maltratado que encontra consolo e amizade no seu pé de laranjeira, a quem chama de Minguinho', '9780613962230'),
('O diário de Anne Frank', 'Fugindo da perseguição ao povo judeu, Anne, seus pais e sua irmã, que já tinham se mudado para a Holanda, passam a morar em um esconderigo de uma família amiga. Ali ficam confinados por mais de dois anos, enfrentando muitas dificuldades, situações e coisas impresionantes, tudo isso detalhado em seu diário secreto.', '9783596511495'),
('O menino do pijama listrado', 'conta a história de Bruno, um menino alemão de oito anos que, durante a Segunda Guerra Mundial, se muda para perto de um campo de concentração devido ao trabalho do seu pai, um oficial nazista', '9780857533937');

INSERT INTO Categoria(NomeCategoria)
VALUES 
('Romance'),
('Comédia'),
('Drama'), 
('Ficção-Cientifica'),
('Ficção-Autobiografica'),
('Poesia'),
('Literatura Infantil'),
('Terror'),
('Fantasia'),
('Suspense');

INSERT INTO Usuario (NomeUsuario, Email, DataCadastro, NumeroIdentificacao, NivelAssociacao)
VALUES
('Ana Carolina', 'anacarolina@exemplo.com', '2021-01-20', '12342', 'Administrador'),
('Bruna Amanda', 'brunaamanda@exemplo.com', '2023-02-21', '87421', 'UsuarioPadrao'),
('Carolina Almeida', 'carolinaalmeida@exemplo.com', '2022-03-15', '65213', 'Administrador'),
('Daniela Pereira', 'danipereira@exemplo.com', '2021-06-10', '98134', 'UsuarioPadrao'),
('Emilly Silva', 'emilysilva@exemplo.com', '2022-08-05', '43215', 'Administrador'),
('Felipe Oliveira', 'felipeoliveira@exemplo.com', '2021-11-12', '76529', 'UsuarioPadrao'),
('Giovanna Sanches', 'giovannasanches@exemplo.com', '2023-01-08', '31487', 'UsuarioPadrao'),
('Helena Oliveira', 'helenaoliveira@exemplo.com', '2022-04-18', '59284', 'UsuarioPadrao'),
('Isabella Bertollo', 'isabellabertollo@exemplo.com', '2023-05-22', '84736', 'Administrador'),
('Julia Araújo', 'juliaaraujo@exemplo.com', '2021-09-30', '23019', 'UsuarioPadrao');

INSERT INTO Autor (Nome, DataNascimento, Biografia)
VALUES 
('Jojo Moyes', '1969-08-04', 'Pauline Sara Jo Moyes, mais conhecida como Jojo Moyes, é uma jornalista britânica e, desde 2002, romancista. É uma das poucas autoras que já ganharam duas vezes o Prémio Romance do Ano atribuído pela Associação de Romancistas e foi traduzida para vinte e oito idiomas diferentes.'),
('John Grogan', '1957-03-20', 'John Grogan é um jornalista e escritor americano. Ficou famoso mundialmente após escrever o best-seller Marley & Eu, que foi adaptado para o cinema. John Grogan é casado com Jenny, com quem tem três filhos: Patrick, Conor e Colleen.'),
('John Green', '1977-08-24', 'John Michael Green é um vlogger, empresário, produtor e autor norte-americano de livros para jovens.'),
('Antoine de Saint-Exupéry', '1900-06-29', 'Antoine de Saint-Exupéry, nascido Antoine-Marie-Roger de Saint-Exupéry, foi um escritor, ilustrador e piloto francês, internacionalmente reconhecido pelo seu livro Le Petit Prince, provavelmente a obra infantil mais celebrada da história.'),
('José Mauro de Vasconcelos', '1920-02-26', 'José Mauro de Vasconcelos nasceu no Rio de Janeiro em 1920 e faleceu em São Paulo em 1984. Descendente de portugueses, o autor teve vários empregos durante a adolescência, viajando depois por todo o Brasil e por vários países europeus. O seu primeiro grande êxito foi Rosinha, Minha Canoa (1962).'),
('R. J. Palacio', '1963-07-13', 'R. J. Palacio, cujo nome de nascimento é Raquel Jaramillo, é uma autora e designer gráfica americana, conhecida principalmente pelo romance juvenil Extraordinário (Wonder), de 2012, que virou filme.'),
('Anne Frank', '1929-06-12', 'Anne Frank foi uma menina judia nascida em Frankfurt, Alemanha, em 1929, que se tornou uma das vítimas mais famosas do Holocausto. Fugindo da perseguição nazista, a família de Anne refugiou-se num esconderijo em Amsterdã, onde ela escreveu o seu famoso diário.'),
('John Boyne', '1971-04-30', 'John Boyne é um escritor irlandês, famoso pelo best-seller The Boy in The Stripped Pyjamas: A Fable. Estudou língua inglesa no Trinity College, e Literatura Criativa na Universidade de East Anglia, onde foi galardoado com o prêmio Curtis Brown.'),
('Louisa May Alcott', '1832-11-29', 'Louisa May Alcott foi uma escritora norte-americana, conhecida principalmente por seu romance “Little Women” (Mulherzinhas), publicado em 1868.'),
('Mark Twain', '1835-11-30', 'Mark Twain, pseudônimo de Samuel Langhorne Clemens, foi um escritor, humorista e palestrante norte-americano, famoso por obras como “As Aventuras de Tom Sawyer” e “As Aventuras de Huckleberry Finn”.');

INSERT INTO Emprestimo (DataEmprestimo, DataLimiteDevolucao, DataDevolucao, id_usuario, id_livro)
VALUES
('2024-08-01', 
'2024-08-15', 
'2024-08-14',
 1, 1),
 
 ('2024-07-01',
 '2024-07-15',
 '2024-07-12',
 2, 2),
 
 ('2024-04-02',
 '2024-04-17',
 '2024-04-15',
 3, 3),
 
 ('2024-06-03',
 '2024-06-18',
 '2024-06-06',
 4, 4),
 
 ('2024-05-15',
 '2024-05-30',
 '2024-05-29',
 5, 5),
 
 ('2024-03-02',
 '2024-03-17',
 '2024-03-13',
 6, 6),
 
 ('2024-07-01',
 '2024-07-16',
 '2024-07-13',
 7, 7),
 
 ('2024-12-01',
 '2024-12-16',
 '2024-12-06',
 8, 8),
 
 ('2024-08-20',
 '2024-09-04',
 '2024-09-02',
 9, 9),
 
('2024-09-01',
 '2024-09-16',
 '2024-09-14',
 10, 10);
 
 INSERT INTO LivroAutor (id_livro, id_autor)
 VALUES
 (1, 1),
 (2, 3),
 (3, 2),
 (4, 4),
 (5, 6),
 (6, 1),
 (7, 1),
 (8, 5),
 (9, 7),
 (10, 8);

INSERT INTO LivroCategoria(id_livro, id_categoria)
VALUES 
(1, 1),
(2, 1),
(3, 2),
(4, 7),
(5, 1),
(6, 1),
(7, 1),
(8, 5),
(9, 5),
(10, 4);

SELECT * FROM Livro;
SELECT * FROM Autor;
SELECT * FROM Usuario;
SELECT * FROM Categoria;
SELECT * FROM Emprestimo;
SELECT * FROM LivroCategoria;
SELECT * FROM LivroAutor;


/*--------------------------------------Atividade SELECT -------------------------------------------------*/
SELECT * FROM Livro WHERE id = 3; /*Liste o livro de id número 3* - SELECT - 1/

/* INSERT */

ALTER TABLE Livro ADD COLUMN Edicao VARCHAR (255); /*Adicionar a categoria Edicao na tabela livro*/
ALTER TABLE Livro ADD COLUMN dataPublicacao DATE; /*Adiciona a categoria dataPublicacao na tabela livro - INSERT - 1 */

INSERT INTO Livro (TituloLivro, Descricao, ISBN, Edicao, dataPublicacao)
VALUES 
("Python", NULL, "isbn-13: 1718502702", "3ª Edição", "2023-04-24"); /*Insere o livro python na tabela livro - INSERT - 1*/

SELECT * FROM Livro WHERE id = 11; /*teste para ver se funcionou*/

INSERT INTO Autor (Nome, DataNascimento, Biografia)
VALUES 
("Eric Matthes", NULL, NULL); /*Insere o autor "Eric Matthes" na tabela autor INSERT - 1*/

SELECT * FROM Autor; /*teste para ver se funcionou*/

INSERT INTO LivroAutor (id_livro, id_autor)
VALUES
(11, 11); /*Cria uma ligação entre o novo autor cadastrado e o novo livro cadastrado - INSERT - 1*/
SELECT * FROM LivroAutor; /*teste para ver se funcionou*/

INSERT INTO Categoria(NomeCategoria)
VALUES 
("Técnico"); /*Adiciona a categoria "Técnico" a tabela categoria  INSERT - 1*/
SELECT * FROM Categoria; /*teste para ver se funcionou*/

INSERT INTO LivroCategoria(id_livro, id_categoria)
VALUES 
(11, 11); /*Insere a nova categoria ao novo livro*/

/* UPDATE */

/*--------------- Atividade 1 --------------------------*/
UPDATE Usuario 
SET Email = "teste@email.com" 
WHERE id = 1; 
SELECT * FROM Usuario WHERE id = 1; /*Teste para ver se atualizou*/

/*--------------- Atividade 2 --------------------------*/
UPDATE Livro 
SET TituloLivro = "Curso Intensivo de Python: uma Introdução Prática e Baseada em Projetos à Programação" 
WHERE id = 11;
SELECT * FROM Livro WHERE id = 11; /*Teste para ver se atualizou*/

/*--------------- Atividade 3 --------------------------*/
SELECT * FROM Livro; /*Consulta livros*/
UPDATE Livro SET dataPublicacao = '1943-04-01' WHERE id = 4; /*Atualiza o livro "O pequeno principe" com a data de publicacao*/
UPDATE Livro SET dataPublicacao = '1968-01-01' WHERE id = 8; /*Atualiza o livro "O meu pé de laranja lima" com a data de publicacao */
UPDATE Livro SET dataPublicacao = '1947-06-25' WHERE id = 9; /*Atualiza o livro "O diário de anne frank" com a data de publicacao*/

ALTER TABLE Livro ADD COLUMN Status VARCHAR (255); /*adiciona o campo "status" aos livros*/

UPDATE Livro SET Status = "Inativo" WHERE id IN (4, 8, 9); /*deixa os campos antes de 2000 com status inativo*/
/*============================================================================*/

/*DELETE - Atividade 1*/

/*Essa etapa foi necessária para limpar todo o registro do livro no banco de dados antes de o apagar*/
DELETE FROM LivroCategoria WHERE id_livro = 2;  /*Deletei o id = 2, pois o livro possuia uma categoria*/
DELETE FROM LivroAutor WHERE id_livro = 2;  /*Deletei o id = 2, pois o livro possuia um autor*/
DELETE FROM Emprestimo WHERE id = 2; /*Deletei o id = 2, pois o livro estava emprestado*/
DELETE FROM Livro WHERE id = 2;

/*---------------------- Atividade 2 --------------------------*/
INSERT INTO Usuario (NomeUsuario, Email, DataCadastro, NumeroIdentificacao, NivelAssociacao)
VALUES
("Teste Testador", "email@exemplo.com", '2025-09-30', NULL, NULL);
SELECT * FROM Usuario; /*teste pra ver se funcionou"*/

DELETE FROM Usuario WHERE id = 11;
SELECT * FROM Usuario; /*teste pra ver se funcionou"*/

/*-------------------------------Atividade 3 ------------------------------------------*/
UPDATE Livro SET Status = "Danificado" WHERE id IN (1, 3, 6, 10);
SELECT * FROM Livro; /*teste pra ver se funcionou"*/

DELETE FROM LivroCategoria WHERE id_livro = 1;  /*Deletei o id = 1, pois o livro possuia uma categoria*/
DELETE FROM LivroAutor WHERE id_livro = 1;  /*Deletei o id = 1, pois o livro possuia um autor*/
DELETE FROM Emprestimo WHERE id = 1; /*Deletei o id = 1, pois o livro estava emprestado*/
DELETE FROM Livro WHERE id = 1;

DELETE FROM LivroCategoria WHERE id_livro = 3;  /*Deletei o id = 3, pois o livro possuia uma categoria*/
DELETE FROM LivroAutor WHERE id_livro = 3;  /*Deletei o id = 3, pois o livro possuia um autor*/
DELETE FROM Emprestimo WHERE id = 3; /*Deletei o id = 3, pois o livro estava emprestado*/
DELETE FROM Livro WHERE id = 3;

DELETE FROM LivroCategoria WHERE id_livro = 6;  /*Deletei o id = 6, pois o livro possuia uma categoria*/
DELETE FROM LivroAutor WHERE id_livro = 6;  /*Deletei o id = 6, pois o livro possuia um autor*/
DELETE FROM Emprestimo WHERE id = 6; /*Deletei o id = 6, pois o livro estava emprestado*/
DELETE FROM Livro WHERE id = 6;

DELETE FROM LivroCategoria WHERE id_livro = 10;  /*Deletei o id = 10, pois o livro possuia uma categoria*/
DELETE FROM LivroAutor WHERE id_livro = 10;  /*Deletei o id = 10, pois o livro possuia um autor*/
DELETE FROM Emprestimo WHERE id = 10; /*Deletei o id = 10, pois o livro estava emprestado*/
DELETE FROM Livro WHERE id = 10;

/*------------------------------------- Atividade 4 ----------------------------------------------------*/
INSERT INTO Emprestimo (DataEmprestimo, DataLimiteDevolucao, DataDevolucao, id_usuario, id_livro)
VALUES
('2020-01-01', '2020-01-15', '2020-01-10', 10, 9);
SELECT * FROM Emprestimo; /*Ver se funcionou*/

DELETE FROM Emprestimo WHERE id = 14; /*Apagar registro de antes de 2020*/
