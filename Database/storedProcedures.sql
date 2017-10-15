CREATE OR REPLACE FUNCTION cadastraAtividade(codigo VARCHAR(20), nome VARCHAR(100), ano INTEGER, semestre VARCHAR(5), horario VARCHAR(200), professor VARCHAR(10))
RETURNS void AS $$
BEGIN
	INSERT INTO atividade (codigo, nome, ano, semestre, horario) VALUES (codigo, nome, ano, semestre, horario);
	INSERT INTO professor_atividade (professor_codigo, atividade_codigo) VALUES (professor, codigo);
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION cadastraAluno(senha VARCHAR(50), matricula VARCHAR(10), turma VARCHAR(5), cpf VARCHAR(14), email VARCHAR(80), telefone VARCHAR(14), 
	nome VARCHAR(100), sexo CHAR(1), pais VARCHAR(50), cidade VARCHAR(60), cep VARCHAR(10), bairro VARCHAR(50), rua VARCHAR(100), numero INTEGER, complemento VARCHAR(80))
RETURNS void AS $$
DECLARE last_id BIGINT;
BEGIN	
	INSERT INTO usuario(senha, tipo) VALUES (senha, 'A') RETURNING id INTO last_id;
	INSERT INTO aluno(matricula, turma, id, cpf, email, telefone, nome, sexo, pais, cidade, cep, bairro, rua, numero, complemento) 
		VALUES (matricula, turma, last_id, cpf, email, telefone, nome, sexo, pais, cidade, cep, bairro, rua, numero, complemento);
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION cadastraResponsavel(senha VARCHAR(50), responsavelCpf VARCHAR(14), email VARCHAR(80), telefone VARCHAR(14), nome VARCHAR(100), sexo CHAR(1), 
	pais VARCHAR(50), cidade VARCHAR(60), cep VARCHAR(10), bairro VARCHAR(50), rua VARCHAR(100), numero INTEGER, complemento VARCHAR(80), aluno VARCHAR(10))
RETURNS void AS $$
DECLARE last_id BIGINT;
DECLARE aux VARCHAR(14);
BEGIN	
	SELECT cpf INTO aux from responsavel where cpf = responsavelCpf;
	IF NOT FOUND THEN
		INSERT INTO usuario(senha, tipo) VALUES (senha, 'R') RETURNING id INTO last_id;
		INSERT INTO responsavel(id, cpf, email, telefone, nome, sexo, pais, cidade, cep, bairro, rua, numero, complemento) 
			VALUES (last_id, responsavelCpf, email, telefone, nome, sexo, pais, cidade, cep, bairro, rua, numero, complemento);
	END IF;
	INSERT INTO responsavel_aluno(responsavel_cpf, aluno_matricula) VALUES (responsavelCpf, aluno);
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION cadastraProfessor(senha VARCHAR(50), codigo VARCHAR(10), cpf VARCHAR(14), email VARCHAR(80), telefone VARCHAR(14), nome VARCHAR(100), 
	sexo CHAR(1), pais VARCHAR(50), cidade VARCHAR(60), cep VARCHAR(10), bairro VARCHAR(50), rua VARCHAR(100), numero INTEGER, complemento VARCHAR(80))
RETURNS void AS $$
DECLARE last_id BIGINT;
BEGIN	
	INSERT INTO usuario(senha, tipo) VALUES (senha, 'P') RETURNING id INTO last_id;
	INSERT INTO professor(codigo, id, cpf, email, telefone, nome, sexo, pais, cidade, cep, bairro, rua, numero, complemento) 
		VALUES (codigo, last_id, cpf, email, telefone, nome, sexo, pais, cidade, cep, bairro, rua, numero, complemento);
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION insereInformacao(atividade VARCHAR(20), professor VARCHAR(10), titulo VARCHAR(100), texto VARCHAR(1000), midia VARCHAR(1000))
RETURNS void AS $$
BEGIN
	INSERT INTO informacao(cod_atividade, cod_professor, titulo, datahora, texto, midia) VALUES (atividade, professor, titulo, now(), texto, midia);
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION enviaMensagem(remetente BIGINT, destinatario BIGINT, texto VARCHAR(1000))
RETURNS void AS $$
BEGIN
	INSERT INTO mensagem(remetente, destinatario, texto) VALUES (remetente, destinatario, now(), texto);
END $$ LANGUAGE 'plpgsql';