CREATE OR REPLACE FUNCTION cadastraAtividade(cod VARCHAR(20), nome VARCHAR(100), ano INTEGER, semestre VARCHAR(5), horario VARCHAR(200))
RETURNS void AS $$
DECLARE aux VARCHAR(10);
BEGIN
	SELECT codigo INTO aux FROM atividade WHERE codigo = cod;
	IF NOT FOUND THEN
		INSERT INTO atividade (codigo, nome, ano, semestre, horario) VALUES (cod, nome, ano, semestre, horario);
	END IF;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION associaProfessor(codAtividade VARCHAR(20), codProfessor VARCHAR(10))
RETURNS void AS $$
DECLARE aux VARCHAR(10);
BEGIN
	SELECT codigo INTO aux FROM professor WHERE codigo = codProfessor;
	IF FOUND THEN
		INSERT INTO professor_atividade (atividade_codigo, professor_codigo) VALUES (codAtividade, codProfessor);
	END IF;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION matriculaAluno(codAtividade VARCHAR(20), matAluno VARCHAR(10))
RETURNS void AS $$
DECLARE aux VARCHAR(10);
BEGIN
	SELECT matricula INTO aux FROM aluno WHERE matricula = matAluno;
	IF FOUND THEN
		INSERT INTO aluno_atividade (atividade_codigo, aluno_matricula) VALUES (codAtividade, matAluno);
	END IF;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION cadastraAluno(senha VARCHAR(50), matricula VARCHAR(10), turma VARCHAR(5), cpf VARCHAR(11), email VARCHAR(80), telefone VARCHAR(14), 
	nome VARCHAR(100), sexo CHAR(1), pais VARCHAR(50), cidade VARCHAR(60), cep VARCHAR(10), bairro VARCHAR(50), rua VARCHAR(100), numero INTEGER, complemento VARCHAR(80))
RETURNS void AS $$
DECLARE last_id BIGINT;
BEGIN	
	INSERT INTO usuario(login1, login2, senha, tipo) VALUES (matricula, email, senha, 'A') RETURNING id INTO last_id;
	INSERT INTO aluno(matricula, turma, id, cpf, email, telefone, nome, sexo, pais, cidade, cep, bairro, rua, numero, complemento) 
		VALUES (matricula, turma, last_id, cpf, email, telefone, nome, sexo, pais, cidade, cep, bairro, rua, numero, complemento);
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION cadastraResponsavel(senha VARCHAR(50), responsavelCpf VARCHAR(11), email VARCHAR(80), telefone VARCHAR(14), nome VARCHAR(100), sexo CHAR(1), 
	pais VARCHAR(50), cidade VARCHAR(60), cep VARCHAR(10), bairro VARCHAR(50), rua VARCHAR(100), numero INTEGER, complemento VARCHAR(80), aluno VARCHAR(10))
RETURNS void AS $$
DECLARE last_id BIGINT;
DECLARE aux VARCHAR(14);
BEGIN	
	SELECT cpf INTO aux from responsavel where cpf = responsavelCpf;
	IF NOT FOUND THEN
		INSERT INTO usuario(login1, login2, senha, tipo) VALUES (responsavelCpf, email, senha, 'R') RETURNING id INTO last_id;
		INSERT INTO responsavel(id, cpf, email, telefone, nome, sexo, pais, cidade, cep, bairro, rua, numero, complemento) 
			VALUES (last_id, responsavelCpf, email, telefone, nome, sexo, pais, cidade, cep, bairro, rua, numero, complemento);
	END IF;
	INSERT INTO responsavel_aluno(responsavel_cpf, aluno_matricula) VALUES (responsavelCpf, aluno);
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION cadastraProfessor(senha VARCHAR(50), codigo VARCHAR(10), cpf VARCHAR(11), email VARCHAR(80), telefone VARCHAR(14), nome VARCHAR(100), 
	sexo CHAR(1), pais VARCHAR(50), cidade VARCHAR(60), cep VARCHAR(10), bairro VARCHAR(50), rua VARCHAR(100), numero INTEGER, complemento VARCHAR(80))
RETURNS void AS $$
DECLARE last_id BIGINT;
BEGIN	
	INSERT INTO usuario(login1, login2, senha, tipo) VALUES (codigo, email, senha, 'P') RETURNING id INTO last_id;
	INSERT INTO professor(codigo, id, cpf, email, telefone, nome, sexo, pais, cidade, cep, bairro, rua, numero, complemento) 
		VALUES (codigo, last_id, cpf, email, telefone, nome, sexo, pais, cidade, cep, bairro, rua, numero, complemento);
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION cadastraAdministrador(nome VARCHAR(10), senha VARCHAR(50))
RETURNS void AS $$
DECLARE last_id BIGINT;
BEGIN	
	INSERT INTO usuario(login1, login2, senha, tipo) VALUES (nome, NULL, senha, 'E') RETURNING id INTO last_id;
	INSERT INTO administrador(nome, id) 
		VALUES (nome, last_id);
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
	INSERT INTO mensagem(remetente, destinatario, datahora, texto, lida) VALUES (remetente, destinatario, now(), texto, FALSE);
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION realizaLogin(uLogin VARCHAR(80), uSenha VARCHAR(50))
RETURNS TABLE(id BIGINT, tipo CHAR(1)) AS $$
BEGIN
	RETURN QUERY SELECT u.id, u.tipo FROM usuario u WHERE (u.login1 = uLogin OR u.login2 = uLogin) AND u.senha = uSenha AND u.senha != u.login1;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION realizaPrimeiroAcesso(uLogin1 VARCHAR(11), uLogin2 VARCHAR(80))
RETURNS TABLE(id BIGINT, tipo CHAR(1)) AS $$
BEGIN
	RETURN QUERY SELECT u.id, u.tipo FROM usuario u WHERE u.login1 = uLogin1 AND u.login2 = uLogin2 AND u.senha = u.login1;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION atualizaSenha(uid BIGINT, senhaAntiga VARCHAR(50), senhaNova VARCHAR(50))
RETURNS table(num BIGINT) AS $$
BEGIN
	RETURN QUERY WITH rows AS (UPDATE usuario SET senha = senhaNova WHERE id = uid AND senha = senhaAntiga RETURNING 1) 
		SELECT COUNT(*) FROM rows;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION listaAtividadesAluno(uid BIGINT)
RETURNS table (codigo VARCHAR(20), nome VARCHAR(100)) AS $$
BEGIN
	RETURN QUERY SELECT t.codigo, t.nome FROM atividade t 
	JOIN aluno_atividade l ON l.atividade_codigo = t.codigo 
	JOIN aluno a ON a.matricula = l.aluno_matricula
	WHERE a.id = uid;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION listaAtividadesProfessor(uid BIGINT)
RETURNS table (codigo VARCHAR(20), nome VARCHAR(100)) AS $$
BEGIN
	RETURN QUERY SELECT t.codigo, t.nome FROM atividade t 
	JOIN professor_atividade a ON a.atividade_codigo = t.codigo 
	JOIN professor p ON p.codigo = a.professor_codigo
	WHERE p.id = uid;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION listaAtividadesResponsavel(uid BIGINT)
RETURNS table (codigo VARCHAR(20), nome VARCHAR(100)) AS $$
BEGIN
	RETURN QUERY SELECT t.codigo, t.nome FROM atividade t 
	JOIN aluno_atividade l ON l.atividade_codigo = t.codigo 
	JOIN responsavel_aluno e ON e.aluno_matricula = l.aluno_matricula
	JOIN responsavel r ON e.responsavel_cpf = r.cpf
	WHERE r.id = uid;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION exibeInformacoesAtividade(atvCodigo VARCHAR(20))
RETURNS table (professor VARCHAR (100), titulo VARCHAR(100), datahora TIMESTAMP, texto VARCHAR(1000), midia VARCHAR(1000)) AS $$
BEGIN
	RETURN QUERY SELECT p.nome, i.titulo, i.datahora, i.texto, i.midia 
	FROM informacao i JOIN professor p ON i.cod_professor = p.codigo
	WHERE i.cod_atividade = atvCodigo
	ORDER BY datahora DESC;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION exibeMensagens(uid BIGINT)
RETURNS table (remetente BIGINT, destinatario BIGINT, datahora TIMESTAMP, texto VARCHAR(1000), lida BOOLEAN) AS $$
BEGIN
	SELECT * FROM mensagem WHERE destinatario = uid ORDER BY datahora DESC;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */