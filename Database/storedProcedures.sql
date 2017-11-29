/* 	Error guide 
	-1 - Erro no banco
 	0 - Success!
 	1 - Duplicate login1 (Matricula do aluno, Codigo do professor, CPF do responsavel, Username do admin)
 	2 - Duplicate login2 (Email)
 	3 - Duplicate CPF
 	4 - Aluno nao encontrado
*/

/* Tipo de usuario
	'A' - Aluno
	'P' - Professor
	'R' - Responsavel
	'E' - Admin
*/

/* ========================================================== */

CREATE OR REPLACE FUNCTION cadastraAdministrador(senha VARCHAR(50), username VARCHAR(11), email VARCHAR(80), nome VARCHAR(100))
RETURNS INTEGER AS $$
DECLARE aux VARCHAR(80);
DECLARE last_id BIGINT;
BEGIN	
	SELECT login1 INTO aux FROM usuario WHERE login1 = username LIMIT 1;
	IF FOUND THEN
		RETURN 1;
	ELSE
		SELECT login2 INTO aux FROM usuario WHERE login2 = email LIMIT 1;
		IF FOUND THEN	
			RETURN 2;		
		ELSE			
			INSERT INTO usuario(login1, login2, senha, tipo) VALUES (username, email, senha, 'E') RETURNING id INTO last_id;
			INSERT INTO administrador(id, nome) VALUES (last_id, nome);
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
		RETURN 1;
	ELSE
		SELECT login2 INTO aux FROM usuario WHERE login2 = email LIMIT 1;
		IF FOUND THEN	
			RETURN 2;		
		ELSE
			SELECT cpf INTO aux FROM dados_pessoais WHERE acpf = cpf LIMIT 1;
			IF FOUND THEN
				RETURN 3;
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
	SELECT login1 INTO aux FROM usuario WHERE login1 = rcpf LIMIT 1;
	IF FOUND THEN
		RETURN 1;
	ELSE
		SELECT login2 INTO aux FROM usuario WHERE login2 = email LIMIT 1;
		IF FOUND THEN	
			RETURN 2;		
		ELSE
			SELECT cpf INTO aux FROM dados_pessoais WHERE rcpf = cpf LIMIT 1;
			IF FOUND THEN
				RETURN 3;
			ELSE
				SELECT id INTO aluno_id FROM aluno WHERE matricula = mat_aluno LIMIT 1;
				IF NOT FOUND THEN
					RETURN 4;
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
	END IF;		
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION cadastraAluno(senha VARCHAR(50), codigo VARCHAR(10), pcpf VARCHAR(11), nome VARCHAR(100), email VARCHAR(80), telefone VARCHAR(14), 
	sexo CHAR(1), pais VARCHAR(50), estado VARCHAR(50), cidade VARCHAR(60), cep VARCHAR(10), bairro VARCHAR(50), rua VARCHAR(100), numero INTEGER, complemento VARCHAR(80))
RETURNS INTEGER AS $$
DECLARE aux VARCHAR(80);
DECLARE last_id BIGINT;
BEGIN	
	SELECT login1 INTO aux FROM usuario WHERE login1 = codigo LIMIT 1;
	IF FOUND THEN
		RETURN 1;
	ELSE
		SELECT login2 INTO aux FROM usuario WHERE login2 = email LIMIT 1;
		IF FOUND THEN	
			RETURN 2;		
		ELSE
			SELECT cpf INTO aux FROM dados_pessoais WHERE pcpf = cpf LIMIT 1;
			IF FOUND THEN
				RETURN 3;
			ELSE
				INSERT INTO usuario(login1, login2, senha, tipo) VALUES (codigo, email, senha, 'P') RETURNING id INTO last_id;
				INSERT INTO professor(id, codigo) VALUES (last_id, codigo);
				INSERT INTO dados_pessoais(id, cpf, nome, email, telefone, sexo, pais, estado, cidade, cep, bairro, rua, numero, complemento) 
					VALUES (last_id, acpf, nome, email, telefone, sexo, pais, estado, cidade, cep, bairro, rua, numero, complemento);
				RETURN 0;
			END IF;
		END IF;
	END IF;		
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */