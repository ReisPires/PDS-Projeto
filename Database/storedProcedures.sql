/* 	Error guide 
	-1 - Erro no banco
 	0 - Success!
 	
 	11 - Duplicate: Matricula (Aluno)
 	12 - Duplicate: Codigo (Professor)
 	13 - Duplicate: CPF
 	14 - Duplicate: Username (Admin)
 	15 - Duplicate: Email
 	16 - Duplicate: Atividade
 	
 	21 - Not found: Aluno 	
 	22 - Not found: Professor
 	26 - Not found: Atividade
*/

/* Tipo de usuario
	'A' - Aluno
	'P' - Professor
	'R' - Responsavel
	'E' - Admin
*/

/* ========================================================== */

CREATE OR REPLACE FUNCTION cadastraAdministrador(senha VARCHAR(50), username VARCHAR(11), email VARCHAR(80))
RETURNS INTEGER AS $$
DECLARE aux VARCHAR(80);
DECLARE last_id BIGINT;
BEGIN	
	SELECT login1 INTO aux FROM usuario WHERE login1 = username LIMIT 1;
	IF FOUND THEN
		RETURN 14;
	ELSE
		SELECT login2 INTO aux FROM usuario WHERE login2 = email LIMIT 1;
		IF FOUND THEN	
			RETURN 15;		
		ELSE			
			INSERT INTO usuario(login1, login2, senha, tipo) VALUES (username, email, senha, 'E') RETURNING id INTO last_id;			
			RETURN 0;
		END IF;
	END IF;		
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION cadastraAluno(senha VARCHAR(50), matricula VARCHAR(10), turma VARCHAR(5), acpf VARCHAR(11), nome VARCHAR(100), email VARCHAR(80), 
	telefone VARCHAR(14), sexo CHAR(1), pais VARCHAR(50), estado VARCHAR(50), cidade VARCHAR(60), cep VARCHAR(10), bairro VARCHAR(50), rua VARCHAR(100), 
	numero INTEGER, complemento VARCHAR(80))
RETURNS INTEGER AS $$
DECLARE aux VARCHAR(80);
DECLARE last_id BIGINT;
BEGIN	
	SELECT login1 INTO aux FROM usuario WHERE login1 = matricula LIMIT 1;
	IF FOUND THEN
		RETURN 11;
	ELSE
		SELECT login2 INTO aux FROM usuario WHERE login2 = email LIMIT 1;
		IF FOUND THEN	
			RETURN 15;		
		ELSE
			SELECT cpf INTO aux FROM dados_pessoais WHERE acpf = cpf LIMIT 1;
			IF FOUND THEN
				RETURN 13;
			ELSE
				INSERT INTO usuario(login1, login2, senha, tipo) VALUES (matricula, email, senha, 'A') RETURNING id INTO last_id;
				INSERT INTO aluno(id, matricula, turma) VALUES (last_id, matricula, turma);
				INSERT INTO dados_pessoais(id, cpf, nome, email, telefone, sexo, pais, estado, cidade, cep, bairro, rua, numero, complemento) 
					VALUES (last_id, acpf, nome, email, telefone, sexo, pais, estado, cidade, cep, bairro, rua, numero, complemento);
				RETURN 0;
			END IF;
		END IF;
	END IF;		
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION cadastraResponsavel(senha VARCHAR(50), rcpf VARCHAR(11), nome VARCHAR(100), email VARCHAR(80), telefone VARCHAR(14),  sexo CHAR(1), 
	pais VARCHAR(50), estado VARCHAR(50), cidade VARCHAR(60), cep VARCHAR(10), bairro VARCHAR(50), rua VARCHAR(100), numero INTEGER, complemento VARCHAR(80), 
	mat_aluno VARCHAR(10))
RETURNS INTEGER AS $$
DECLARE aux VARCHAR(80);
DECLARE aluno_id BIGINT;
DECLARE last_id BIGINT;
BEGIN	
	SELECT cpf INTO aux FROM dados_pessoais WHERE rcpf = cpf LIMIT 1;
	IF FOUND THEN
		RETURN 13;
	ELSE
		SELECT login2 INTO aux FROM usuario WHERE login2 = email LIMIT 1;
		IF FOUND THEN	
			RETURN 15;		
		ELSE						
			SELECT id INTO aluno_id FROM aluno WHERE matricula = mat_aluno LIMIT 1;
			IF NOT FOUND THEN
				RETURN 21;
			ELSE
				INSERT INTO usuario(login1, login2, senha, tipo) VALUES (rcpf, email, senha, 'R') RETURNING id INTO last_id;
				INSERT INTO responsavel(id) VALUES (last_id);
				INSERT INTO dados_pessoais(id, cpf, nome, email, telefone, sexo, pais, estado, cidade, cep, bairro, rua, numero, complemento) 
					VALUES (last_id, rcpf, nome, email, telefone, sexo, pais, estado, cidade, cep, bairro, rua, numero, complemento);
				INSERT INTO responsavel_aluno(responsavel, aluno) VALUES (last_id, aluno_id);
				RETURN 0;			
			END IF;
		END IF;
	END IF;		
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION cadastraProfessor(senha VARCHAR(50), codigo VARCHAR(10), pcpf VARCHAR(11), nome VARCHAR(100), email VARCHAR(80), telefone VARCHAR(14), 
	sexo CHAR(1), pais VARCHAR(50), estado VARCHAR(50), cidade VARCHAR(60), cep VARCHAR(10), bairro VARCHAR(50), rua VARCHAR(100), numero INTEGER, complemento VARCHAR(80))
RETURNS INTEGER AS $$
DECLARE aux VARCHAR(80);
DECLARE last_id BIGINT;
BEGIN	
	SELECT login1 INTO aux FROM usuario WHERE login1 = codigo LIMIT 1;
	IF FOUND THEN
		RETURN 12;
	ELSE
		SELECT login2 INTO aux FROM usuario WHERE login2 = email LIMIT 1;
		IF FOUND THEN	
			RETURN 15;		
		ELSE
			SELECT cpf INTO aux FROM dados_pessoais WHERE pcpf = cpf LIMIT 1;
			IF FOUND THEN
				RETURN 13;
			ELSE
				INSERT INTO usuario(login1, login2, senha, tipo) VALUES (codigo, email, senha, 'P') RETURNING id INTO last_id;
				INSERT INTO professor(id, codigo) VALUES (last_id, codigo);
				INSERT INTO dados_pessoais(id, cpf, nome, email, telefone, sexo, pais, estado, cidade, cep, bairro, rua, numero, complemento) 
					VALUES (last_id, pcpf, nome, email, telefone, sexo, pais, estado, cidade, cep, bairro, rua, numero, complemento);
				RETURN 0;
			END IF;
		END IF;
	END IF;		
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION realizaLogin(uLogin VARCHAR(80), uSenha VARCHAR(50))
RETURNS TABLE(id BIGINT, tipo CHAR(1)) AS $$
BEGIN
	RETURN QUERY SELECT u.id, u.tipo FROM usuario u WHERE (u.login1 = uLogin OR u.login2 = uLogin) AND u.senha = uSenha AND u.senha != u.login1;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION realizaPrimeiroAcesso(uLogin1 VARCHAR(11), uLogin2 VARCHAR(80), uSenha VARCHAR(50))
RETURNS TABLE(id BIGINT, tipo CHAR(1)) AS $$
DECLARE aux BIGINT;
BEGIN
	SELECT u.id INTO aux FROM usuario u WHERE u.login1 = uLogin1 AND u.login2 = uLogin2 AND u.senha = u.login1;
	IF FOUND THEN
		UPDATE usuario SET senha = uSenha WHERE login1 = uLogin1 AND login2 = uLogin2;
		RETURN QUERY SELECT u.id, u.tipo FROM usuario u WHERE u.login1 = uLogin1 AND u.login2 = uLogin2;
	ELSE
		RETURN QUERY SELECT u.id FROM usuario u WHERE u.login1 = uLogin1 AND u.login2 = uLogin2 AND u.senha = u.login1;
	END IF;		
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION cadastraAtividade(cod VARCHAR(20), nome VARCHAR(100), ano INTEGER, semestre VARCHAR(5), horario VARCHAR(200))
RETURNS INTEGER AS $$
DECLARE aux VARCHAR(10);
BEGIN
	SELECT codigo INTO aux FROM atividade WHERE codigo = cod;
	IF FOUND THEN
		RETURN 16;
	ELSE
		INSERT INTO atividade (codigo, nome, ano, semestre, horario, concluida) VALUES (cod, nome, ano, semestre, horario, TRUE);
		RETURN 0;
	END IF;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION associaProfessor(cod_atividade VARCHAR(20), cod_professor VARCHAR(10))
RETURNS INTEGER AS $$
DECLARE aux VARCHAR(20);
DECLARE prof_id BIGINT;
BEGIN
	SELECT id INTO prof_id FROM professor WHERE codigo = cod_professor;	
	IF NOT FOUND THEN
		RETURN 22;
	ELSE
		SELECT codigo into aux FROM atividade WHERE codigo = cod_atividade;
		IF NOT FOUND THEN
			RETURN 26;
		ELSE
			INSERT INTO professor_atividade (professor, atividade) VALUES (prof_id, cod_atividade) ON CONFLICT DO NOTHING;
			RETURN 0;
		END IF;
	END IF;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION matriculaAluno(cod_atividade VARCHAR(20), mat_aluno VARCHAR(10))
RETURNS INTEGER AS $$
DECLARE aux VARCHAR(10);
DECLARE aluno_id BIGINT;
BEGIN
	SELECT id INTO aluno_id FROM aluno WHERE matricula = mat_aluno;	
	IF NOT FOUND THEN
		RETURN 21;
	ELSE
		SELECT codigo into aux FROM atividade WHERE codigo = cod_atividade;
		IF NOT FOUND THEN
			RETURN 26;
		ELSE
			INSERT INTO aluno_atividade (aluno, atividade) VALUES (aluno_id, cod_atividade) ON CONFLICT DO NOTHING;
			RETURN 0;
		END IF;
	END IF;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */