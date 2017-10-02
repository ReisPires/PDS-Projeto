DROP TABLE IF EXISTS mensagem;
DROP TABLE IF EXISTS responsavel_aluno;
DROP TABLE IF EXISTS aluno_atividade;
DROP TABLE IF EXISTS professor_atividade;
DROP TABLE IF EXISTS informacao;
DROP TABLE IF EXISTS atividade;
DROP TABLE IF EXISTS professor;
DROP TABLE IF EXISTS aluno;
DROP TABLE IF EXISTS responsavel;
DROP TABLE IF EXISTS usuario;

CREATE TABLE usuario(	
	id BIGSERIAL NOT NULL,	
	senha VARCHAR(50) NOT NULL,
	tipo CHAR NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE responsavel(
	cpf VARCHAR(14),
	id BIGSERIAL REFERENCES usuario(id) NOT NULL,	
	email VARCHAR(80),
	telefone VARCHAR(14),
	nome VARCHAR(100),	
	sexo CHARACTER,
	pais VARCHAR(50),
	cidade VARCHAR(60),
	cep VARCHAR(10),
	bairro VARCHAR(50),
	rua VARCHAR(100),
	numero INTEGER,
	complemento VARCHAR(80),
	PRIMARY KEY(cpf)
);

CREATE TABLE aluno(	
	matricula VARCHAR(10),
	turma VARCHAR(5),
	id BIGSERIAL REFERENCES usuario(id) NOT NULL,
	cpf VARCHAR(14),
	email VARCHAR(80),
	telefone VARCHAR(14),
	nome VARCHAR(100),	
	sexo CHARACTER,
	pais VARCHAR(50),
	cidade VARCHAR(60),
	cep VARCHAR(10),
	bairro VARCHAR(50),
	rua VARCHAR(100),
	numero INTEGER,
	complemento VARCHAR(80),	
	PRIMARY KEY(matricula)
);

CREATE TABLE professor(	
	codigo VARCHAR(10),
	id BIGSERIAL REFERENCES usuario(id) NOT NULL,
	cpf VARCHAR(14),
	email VARCHAR(80),
	telefone VARCHAR(14),
	nome VARCHAR(100),	
	sexo CHARACTER,
	pais VARCHAR(50),
	cidade VARCHAR(60),
	cep VARCHAR(10),
	bairro VARCHAR(50),
	rua VARCHAR(100),
	numero INTEGER,
	complemento VARCHAR(80),	
	PRIMARY KEY(codigo)
);

CREATE TABLE atividade(
	codigo VARCHAR(20),
	nome VARCHAR(100),
	ano INTEGER,
	semestre VARCHAR(5),
	horario VARCHAR(200),
	PRIMARY KEY(codigo)
);

CREATE TABLE informacao(
	cod_informacao BIGSERIAL,
	cod_atividade VARCHAR(20) REFERENCES atividade (codigo),
	titulo VARCHAR(100),
	datahora TIMESTAMP,
	texto VARCHAR(1000),
	midia VARCHAR(1000),
	PRIMARY KEY(cod_informacao, cod_atividade)
);

CREATE TABLE mensagem(
	remetente BIGSERIAL REFERENCES usuario (id),
	destinatario BIGSERIAL REFERENCES usuario (id),
	datahora TIMESTAMP,
	texto VARCHAR(1000),
	PRIMARY KEY (remetente, destinatario, datahora)
);

CREATE TABLE responsavel_aluno(
	responsavel_cpf VARCHAR(14) REFERENCES responsavel (cpf),
	aluno_matricula VARCHAR(10) REFERENCES aluno (matricula),
	PRIMARY KEY (responsavel_cpf, aluno_matricula)
);

CREATE TABLE aluno_atividade(
	aluno_matricula VARCHAR(10) REFERENCES aluno (matricula),
	atividade_codigo VARCHAR(20) REFERENCES atividade (codigo),
	PRIMARY KEY (aluno_matricula, atividade_codigo)
);

CREATE TABLE professor_atividade(
	professor_codigo VARCHAR(10) REFERENCES professor (codigo),
	atividade_codigo VARCHAR(20) REFERENCES atividade (codigo),
	PRIMARY KEY (professor_codigo, atividade_codigo)
);