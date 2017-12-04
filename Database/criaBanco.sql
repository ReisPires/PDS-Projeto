DROP TABLE IF EXISTS mensagem_usuario;
DROP TABLE IF EXISTS mensagem;
DROP TABLE IF EXISTS responsavel_aluno;
DROP TABLE IF EXISTS aluno_atividade;
DROP TABLE IF EXISTS professor_atividade;
DROP TABLE IF EXISTS dados_pessoais;
DROP TABLE IF EXISTS midia;
DROP TABLE IF EXISTS postagem;
DROP TABLE IF EXISTS atividade;
DROP TABLE IF EXISTS professor;
DROP TABLE IF EXISTS aluno;
DROP TABLE IF EXISTS responsavel;
DROP TABLE IF EXISTS usuario;

CREATE TABLE usuario(
	id BIGSERIAL NOT NULL,
	login1 VARCHAR(11) NOT NULL, /* CPF/Matricula/Codigo de prof/Nome de admin */
	login2 VARCHAR(80), /* Email */
	senha VARCHAR(50) NOT NULL,
	tipo CHAR(1) NOT NULL,
	valido BOOLEAN,
	facebook VARCHAR(20),
	PRIMARY KEY(id)
);

CREATE TABLE responsavel(	
	id BIGINT REFERENCES usuario(id) NOT NULL,	
	PRIMARY KEY(id)
);

CREATE TABLE aluno(	
	matricula VARCHAR(10) NOT NULL,
	turma VARCHAR(5),
	id BIGINT REFERENCES usuario(id) NOT NULL,	
	PRIMARY KEY(id)
);

CREATE TABLE professor(	
	codigo VARCHAR(10) NOT NULL,
	id BIGINT REFERENCES usuario(id) NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE dados_pessoais(
	id BIGINT REFERENCES usuario(id) NOT NULL,
	cpf VARCHAR(11),
	nome VARCHAR(100),	
	email VARCHAR(80),
	telefone VARCHAR(14),	
	sexo CHAR(1),
	pais VARCHAR(50),
	estado VARCHAR(50),
	cidade VARCHAR(60),
	cep VARCHAR(10),
	bairro VARCHAR(50),
	rua VARCHAR(100),
	numero VARCHAR(6),
	complemento VARCHAR(80),
	PRIMARY KEY(id)
);

CREATE TABLE atividade(
	codigo VARCHAR(20),
	nome VARCHAR(100),
	ano INTEGER,
	semestre VARCHAR(5),
	horario VARCHAR(200),
	concluida BOOLEAN NOT NULL,
	PRIMARY KEY(codigo)
);

CREATE TABLE postagem(
	codigo BIGSERIAL,
	atividade VARCHAR(20) REFERENCES atividade (codigo),
	professor BIGINT REFERENCES professor (id),
	titulo VARCHAR(140),
	datahora TIMESTAMP,
	texto VARCHAR(1000),	
	PRIMARY KEY(codigo)
);

CREATE TABLE midia(
	postagem BIGINT REFERENCES postagem(codigo) NOT NULL,
	endereco VARCHAR(1000) NOT NULL,
	PRIMARY KEY(postagem, endereco)
);

CREATE TABLE mensagem(
	codigo BIGSERIAL,
	titulo VARCHAR(140),
	remetente BIGINT REFERENCES usuario (id),	
	datahora TIMESTAMP,
	texto VARCHAR(1000),	
	PRIMARY KEY (codigo)
);

CREATE TABLE mensagem_usuario(
	mensagem BIGINT REFERENCES mensagem (codigo),
	destinatario BIGINT REFERENCES usuario (id),
	lida BOOLEAN,
	PRIMARY KEY (mensagem, destinatario)
);

CREATE TABLE responsavel_aluno(
	responsavel BIGINT REFERENCES responsavel (id),
	aluno BIGINT REFERENCES aluno (id),
	PRIMARY KEY (responsavel, aluno)
);

CREATE TABLE aluno_atividade(
	aluno BIGINT REFERENCES aluno (id),
	atividade VARCHAR(20) REFERENCES atividade (codigo),
	PRIMARY KEY (aluno, atividade)
);

CREATE TABLE professor_atividade(
	professor BIGINT REFERENCES professor (id),
	atividade VARCHAR(20) REFERENCES atividade (codigo),
	PRIMARY KEY (professor, atividade)
);
