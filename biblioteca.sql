CREATE DATABASE biblioteca;
USE biblioteca;

CREATE TABLE Livro (
	ID INT PRIMARY KEY AUTO_INCREMENT,
	TituloLivro VARCHAR(50) NOT NULL,
	Descricao TEXT,
	IBSN VARCHAR(20) UNIQUE 
);

CREATE TABLE Categoria (
	ID INT PRIMARY KEY AUTO_INCREMENT,
	Nome VARCHAR(50) NOT NULL
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
    NomeUsuario VARCHAR(50) NOT NULL,
    Email VARCHAR (50) UNIQUE,
    DataCadastro DATE,
    NivelAssociacao VARCHAR (50)
);

CREATE TABLE Autor (
	ID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR (50) NOT NULL, 
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

INSERT INTO Categoria(Nome)
VALUES 
('Romance'),
('Comédia'),
('Drama'), 
('Ficção-Cientifica'),
('Ação'),
('Poesia'),
('Literatura Brasileira'),
('Terror'),
('Fantasia'),
('Suspense');


INSERT INTO Usuario (NomeUsuario, Email, DataCadastro, NivelAssociacao)
VALUES
('Ana Carolina', 'anacarola@exemplo.com', '20-01-2021', 'Estudante'),
('Bruna Amanda', 'brunaamanda@exemplo.com', '21-02-2023', 'Professor'),
('Carolina Almeida', 'carolinaalmeida@exemplo.com', 'Professor'),
('Daniela Pereira', 'danipereira@exemplo.com', 'Estudante'),
('Emilly Silva', 'emilysilva@exemplo.com', 'Professor'),
('Felipe Oliveira', 'felipeoliveira.com', 'Professor'),
('Giovanna Sanches', 'giovannasanches@exemplo.com', 'Estudante'),
('Helena Oliveira', 'helenaoliveira@exemplo.com', 'Professor'),
('Isabella Bertollo', 'isabellabertollo@exemplo.com', 'Professor'),
('Julia Araújo', 'juliaaraujo@exemplo.com', 'Professor');

INSERT INTO Autor (Nome, DataNascimento, Biografia)
VALUES 
('Jojo Moyes', '04-08-1969', 'Pauline Sara Jo Moyes, mais conhecida como Jojo Moyes é uma jornalista britânica e, desde 2002, romancista. É uma das poucas autoras que já ganharam duas vezes o Prémio Romance do Ano atribuído pela Associação de Romancistas e foi traduzida para vinte e oito idiomas diferentes'),
('John Grogan', '20-03-1957', 'John Grogan é um jornalista e escritor americano. Ficou famoso mundialmente após escrever o best-seller Marley & Eu, que foi adaptado para o cinema. John Grogan é casado com Jenny, com quem tem três filhos: Patrick, Conor e Colleen.'),
('John Green', '24-08-1977', 'John Michael Green é um vlogger, empresário, produtor e autor norte-americano de livros para jovens.'),
('Antoine de Saint-Exupéry', '29-06-1900', 'Antoine de Saint-Exupéry, nascido Antoine-Marie-Roger de Saint-Exupéry, foi um escritor, ilustrador e piloto francês, internacionalmente reconhecido pelo seu livro Le Petit Prince, provavelmente a obra infantil mais celebrada da história.'),
('José Mauro de Vasconcelos', '26-02-1920', 'José Mauro de Vasconcelos nasceu no Rio de Janeiro em 1920 e faleceu em São Paulo em 1984. Descendente de portugueses, o autor teve vários empregos durante a adolescência, viajando depois por todo o Brasil e por vários países europeus. O seu primeiro grande êxito foi Rosinha, Minha Canoa (1962).'),
('R. J. Palacio', '13-07-1963', 'R. J. Palacio, cujo nome de nascimento é Raquel Jaramillo, é uma autora e designer gráfica americana, conhecida principalmente pelo romance juvenil Extraordinário (Wonder), de 2012, que virou filme'),
('Anne Frank', '12-06-1929', 'Anne Frank foi uma menina judia nascida em Frankfurt, Alemanha, em 1929, que se tornou uma das vítimas mais famosas do Holocausto. Fugindo da perseguição nazista, a família de Anne refugiou-se num esconderijo em Amsterdã, onde ela escreveu o seu famoso diário. '),
('John Boyne', '30-04-1971', 'John Boyne é um escritor irlandês, famoso pelo best-seller The Boy in The Stripped Pyjamas: A Fable. Estudou língua inglesa no Trinity College, e Literatura Criativa na Universidade de East Anglia, onde foi galardoado com o prêmio Curtis Brown.'),
