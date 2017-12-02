	/* 	Error guide 
	-1 - Erro no banco

 	0 - Success!
 	
 	11 - Duplicate: Matricula (Aluno)
 	12 - Duplicate: Codigo (Professor)
 	13 - Duplicate: CPF
 	14 - Duplicate: Username (Admin)
 	15 - Duplicate: Email
 	16 - Duplicate: Atividade
 	19 - Duplicate: Facebook

 	21 - Not found: Aluno 	
 	22 - Not found: Professor
 	23 - Not found: Responsavel
 	26 - Not found: Atividade

 	37 - Invalid: Senha antiga 
 	38 - Invalid: Senha nova
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
	numero VARCHAR(6), complemento VARCHAR(80))
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
	pais VARCHAR(50), estado VARCHAR(50), cidade VARCHAR(60), cep VARCHAR(10), bairro VARCHAR(50), rua VARCHAR(100), numero VARCHAR(6), complemento VARCHAR(80))
RETURNS INTEGER AS $$
DECLARE aux VARCHAR(80);
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
			INSERT INTO usuario(login1, login2, senha, tipo) VALUES (rcpf, email, senha, 'R') RETURNING id INTO last_id;
			INSERT INTO responsavel(id) VALUES (last_id);
			INSERT INTO dados_pessoais(id, cpf, nome, email, telefone, sexo, pais, estado, cidade, cep, bairro, rua, numero, complemento) 
				VALUES (last_id, rcpf, nome, email, telefone, sexo, pais, estado, cidade, cep, bairro, rua, numero, complemento);			
			RETURN 0;						
		END IF;
	END IF;		
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION associaResponsavel(matricula_aluno VARCHAR(10), cpf_responsavel VARCHAR(11))
RETURNS INTEGER AS $$
DECLARE responsavel_id BIGINT;
DECLARE aluno_id BIGINT;
BEGIN
	SELECT r.id INTO responsavel_id FROM responsavel r JOIN dados_pessoais d ON r.id = d.id WHERE d.cpf = cpf_responsavel;	
	IF NOT FOUND THEN
		RETURN 23;
	ELSE
		SELECT a.id into aluno_id FROM aluno a WHERE a.matricula = matricula_aluno;
		IF NOT FOUND THEN
			RETURN 21;
		ELSE
			INSERT INTO responsavel_aluno (responsavel, aluno) VALUES (responsavel_id, aluno_id) ON CONFLICT DO NOTHING;
			RETURN 0;
		END IF;
	END IF;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION cadastraProfessor(senha VARCHAR(50), codigo VARCHAR(10), pcpf VARCHAR(11), nome VARCHAR(100), email VARCHAR(80), telefone VARCHAR(14), 
	sexo CHAR(1), pais VARCHAR(50), estado VARCHAR(50), cidade VARCHAR(60), cep VARCHAR(10), bairro VARCHAR(50), rua VARCHAR(100), numero VARCHAR(6), complemento VARCHAR(80))
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

CREATE OR REPLACE FUNCTION realizaLoginFacebook(fbid VARCHAR(20))
RETURNS TABLE(id BIGINT, tipo CHAR(1)) AS $$
BEGIN
	RETURN QUERY SELECT u.id, u.tipo FROM usuario u WHERE facebook = fbid;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION recuperaFacebook(uid BIGINT)
RETURNS TABLE(facebook VARCHAR(20)) AS $$
BEGIN
	RETURN QUERY SELECT u.facebook FROM usuario u WHERE u.id = uid;
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
		INSERT INTO atividade (codigo, nome, ano, semestre, horario, concluida) VALUES (cod, nome, ano, semestre, horario, FALSE);
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

CREATE OR REPLACE FUNCTION listaAtividadesAluno(uid BIGINT)
RETURNS table (codigo VARCHAR(20), nome VARCHAR(100), concluida BOOLEAN) AS $$
BEGIN
	RETURN QUERY SELECT a.codigo, a.nome, a.concluida FROM atividade a
		JOIN aluno_atividade l ON l.atividade = a.codigo
		WHERE l.aluno = uid;		
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION listaAtividadesProfessor(uid BIGINT)
RETURNS table (codigo VARCHAR(20), nome VARCHAR(100), concluida BOOLEAN) AS $$
BEGIN
	RETURN QUERY SELECT a.codigo, a.nome, a.concluida FROM atividade a
		JOIN professor_atividade p ON p.atividade = a.codigo
		WHERE p.professor = uid;		
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION listaAtividadesAdministrador()
RETURNS table (codigo VARCHAR(20), nome VARCHAR(100), concluida BOOLEAN) AS $$
BEGIN
	RETURN QUERY SELECT a.codigo, a.nome, a.concluida FROM atividade a;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION listaAtividadesResponsavel(uid BIGINT)
RETURNS table (codigo VARCHAR(20), nome VARCHAR(100), concluida BOOLEAN) AS $$
BEGIN
	RETURN QUERY SELECT t.codigo, t.nome, t.concluida FROM atividade t
		JOIN aluno_atividade l ON l.atividade = t.codigo 
		JOIN responsavel_aluno r ON r.aluno = l.aluno		
	WHERE r.responsavel = uid;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION listaAlunosAtividadesResponsavel(uid BIGINT)
RETURNS table (aluno VARCHAR(100), atividade TEXT) AS $$
BEGIN
	RETURN QUERY SELECT p.nome, string_agg(t.codigo, '/' ORDER BY t.codigo) FROM atividade t
		JOIN aluno_atividade l ON l.atividade = t.codigo
		JOIN responsavel_aluno r ON r.aluno = l.aluno
		JOIN dados_pessoais p ON p.id = l.aluno		
	WHERE r.responsavel = uid
	GROUP BY p.nome;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION recuperaAtividade(cod_atividade VARCHAR(20))
RETURNS table (nome VARCHAR(100), ano INTEGER, semestre VARCHAR(5), horario VARCHAR(200), concluida BOOLEAN) AS $$
BEGIN
	RETURN QUERY SELECT nome, ano, semestre, horario, concluida FROM atividade WHERE codigo = cod_atividade;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION exibeMensagensNaoLidas(uid BIGINT)
RETURNS table(total BIGINT) AS $$
BEGIN
	RETURN QUERY SELECT count(*) FROM mensagem_usuario WHERE destinatario = uid AND lida = FALSE;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION leMensagens(uid BIGINT)
RETURNS VOID AS $$
BEGIN
	UPDATE mensagem_usuario SET lida = TRUE WHERE destinatario = uid;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION criaMensagem(remetente BIGINT, titulo VARCHAR(140), texto VARCHAR(1000))
RETURNS BIGINT AS $$
DECLARE msg_id BIGINT; 
BEGIN
	INSERT INTO mesagem(remetente, titulo, datahora, texto) VALUES (remetente, titulo, now(), texto) RETURNING codigo INTO msg_id;
	RETURN msg_id;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION enviaMensagem(mensagem BIGINT, destinatario BIGINT)
RETURNS VOID AS $$
BEGIN
	INSERT INTO mesagem_usuario(mensagem, destinatario, lida) VALUES (mensagem, destinatario, FALSE);
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION listaMensagens(uid BIGINT)
RETURNS table (remetente VARCHAR(100), titulo VARCHAR(140), datahora TIMESTAMP, texto VARCHAR(1000)) AS $$
BEGIN
	RETURN QUERY SELECT d.nome, m.titulo, m.datahora, m.texto FROM mensagem m 
		LEFT JOIN dados_pessoais d ON d.id = m.remetente
		JOIN mensagem_usuario u ON u.mensagem = m.codigo		
	WHERE u.destinatario = uid;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION realizaPostagem(atividade VARCHAR(20), professor BIGINT, titulo VARCHAR(140), texto VARCHAR(1000))
RETURNS BIGINT AS $$
DECLARE postagem_id BIGINT; 
BEGIN
	INSERT INTO postagem(atividade, professor, datahora, titulo, texto) VALUES (atividade, professor, now(), titulo, texto) RETURNING codigo INTO postagem_id;
	RETURN postagem_id;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION insereMidia(postagem BIGINT, endereco VARCHAR(1000))
RETURNS VOID AS $$
BEGIN
	INSERT INTO midia(postagem, endereco) VALUES (postagem, endereco);
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION listaPostagens(cod_atividade VARCHAR(20))
RETURNS table (codigo BIGINT, professor VARCHAR(100), titulo VARCHAR(140), datahora TIMESTAMP, texto VARCHAR(1000)) AS $$
BEGIN
	RETURN QUERY SELECT p.codigo, d.nome, p.titulo, p.datahora, p.texto FROM postagem p
		JOIN dados_pessoais d ON d.id = p.professor
		JOIN atividade a ON p.atividade = a.codigo
	WHERE p.atividade = cod_atividade
	ORDER BY p.datahora;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION recuperaMidiasPostagem(id_postagem BIGINT)
RETURNS table (pendereco VARCHAR(1000)) AS $$
BEGIN
	RETURN QUERY SELECT endereco FROM midia WHERE postagem = id_postagem ORDER BY endereco;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION recuperaPostagem(cod_postagem BIGINT)
RETURNS table (codigo BIGINT, professor VARCHAR(100), titulo VARCHAR(140), datahora TIMESTAMP, texto VARCHAR(1000)) AS $$
BEGIN
	RETURN QUERY SELECT p.codigo, d.nome, p.titulo, p.datahora, p.texto FROM postagem p
		JOIN dados_pessoais d ON d.id = p.professor
		JOIN atividade a ON p.atividade = a.codigo
	WHERE p.codigo = cod_postagem;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION atualizaPostagem(pid BIGINT, ptitulo VARCHAR(140), ptexto VARCHAR(1000))
RETURNS VOID AS $$
BEGIN
	UPDATE postagem SET titulo = ptitulo, texto = ptexto WHERE id = pid;	
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION listaAlunosProfessor(prof_id BIGINT)
RETURNS table (id BIGINT, matricula VARCHAR(10), nome VARCHAR(100)) AS $$
BEGIN
	RETURN QUERY SELECT a.id, a.matricula, d.nome FROM aluno a
		JOIN aluno_atividade l ON l.aluno = a.id
		JOIN professor_atividade p ON p.atividade = l.atividade		
		JOIN dados_pessoais d ON d.id = a.id				
	WHERE p.professor = prof_id;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION listaProfessoresAluno(aluno_id BIGINT)
RETURNS table (id BIGINT, nome VARCHAR(100), atividade TEXT) AS $$
BEGIN
	RETURN QUERY SELECT d.id, d.nome, string_agg(t.nome, ' - ' ORDER BY t.nome) FROM dados_pessoais d
		JOIN professor_atividade p ON p.professor = d.id
		JOIN aluno_atividade a ON a.atividade = p.atividade				
		JOIN atividade t ON t.codigo = a.atividade
	WHERE a.aluno = aluno_id
	GROUP BY d.id, d.nome;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION listaProfessoresResponsavel(responsavel_id BIGINT)
RETURNS table (id BIGINT, nome VARCHAR(100), atividade TEXT) AS $$
BEGIN
	RETURN QUERY SELECT d.id, d.nome, string_agg(t.nome, ' - ' ORDER BY t.nome) FROM dados_pessoais d
		JOIN professor_atividade p ON p.professor = d.id		
		JOIN aluno_atividade a ON a.atividade = p.atividade	
		JOIN responsavel_aluno r ON r.aluno = a.aluno			
		JOIN atividade t ON t.codigo = a.atividade
	WHERE r.responsavel = responsavel_id
	GROUP BY d.id, d.nome;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION listaAlunosAdministrador()
RETURNS table (id BIGINT, matricula VARCHAR(10), nome VARCHAR(100)) AS $$
BEGIN
	RETURN QUERY SELECT a.id, a.matricula, d.nome FROM aluno a		
		JOIN dados_pessoais d ON d.id = a.id; 		
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION listaProfessoresAdministrador()
RETURNS table (id BIGINT, nome VARCHAR(100), atividade TEXT) AS $$
BEGIN
	RETURN QUERY SELECT d.id, d.nome, string_agg(a.nome, ' - ' ORDER BY a.nome) FROM dados_pessoais d		
		JOIN professor_atividade p ON p.professor = d.id
		JOIN atividade a ON a.codigo = p.atividade	
	GROUP BY d.id, d.nome;
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION listaResponsaveisProfessor(uid BIGINT)
RETURNS table (id BIGINT, nome VARCHAR(100)) AS $$
BEGIN
	RETURN QUERY SELECT d.id, d.nome FROM dados_pessoais d				
		JOIN responsavel_aluno r on r.responsavel = d.id
		JOIN aluno_atividade a ON a.aluno = r.aluno
		JOIN professor_atividade p ON p.atividade = a.atividade
	WHERE p.professor = uid
	ORDER BY d.nome;	
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION listaResponsaveisAdministrador()
RETURNS table (id BIGINT, nome VARCHAR(100)) AS $$
BEGIN
	RETURN QUERY SELECT d.id, d.nome FROM dados_pessoais d				
		JOIN responsavel r on r.id = d.id
	ORDER BY d.nome;	
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION atualizaDadosPessoais(uid BIGINT, uemail VARCHAR(80), utelefone VARCHAR(14), usexo CHAR(1), upais VARCHAR(50), 
	uestado VARCHAR(50), ucidade VARCHAR(60), ucep VARCHAR(10), ubairro VARCHAR(50), urua VARCHAR(100), unumero VARCHAR(6), ucomplemento VARCHAR(80))
RETURNS INTEGER AS $$
DECLARE aux VARCHAR(80);
DECLARE last_id BIGINT;
BEGIN			
	SELECT login2 INTO aux FROM usuario WHERE uemail = login2 AND id != uid LIMIT 1;
	IF FOUND THEN
		RETURN 15;
	ELSE
		UPDATE usuario SET login2 = uemail WHERE id = uid;			
		UPDATE dados_pessoais SET email = uemail, telefone = utelefone, sexo = usexo, pais = upais, estado = uestado, cidade = ucidade,
			cep = ucep, bairro = ubairro, rua = urua, numero = unumero, complemento = ucomplemento
		WHERE  id = uid;
		RETURN 0;
	END IF;	
END $$ LANGUAGE 'plpgsql';

/* ========================================================== */

CREATE OR REPLACE FUNCTION recuperaDadosPessoais(uid BIGINT)
RETURNS table(email VARCHAR(80), telefone VARCHAR(14), sexo CHAR(1), pais VARCHAR(50), estado VARCHAR(50), cidade VARCHAR(60), cep VARCHAR(10), 
	bairro VARCHAR(50), rua VARCHAR(100), numero VARCHAR(6), complemento VARCHAR(80)) AS $$
BEGIN			
	RETURN QUERY SELECT d.email, d.telefone, d.sexo, d.pais, d.estado, d.cidade, d.cep, d.bairro, d.rua, d.numero, d.complemento FROM dados_pessoais d WHERE d.id = uid;
END $$ LANGUAGE 'plpgsql';


/* ========================================================== */

CREATE OR REPLACE FUNCTION atualizaSenha(uid BIGINT, senhaAntiga VARCHAR(50), senhaNova VARCHAR(50))
RETURNS INTEGER AS $$
DECLARE aux BIGINT;
BEGIN
	SELECT id INTO aux FROM usuario u WHERE uid = u.id AND u.senha = senhaAntiga LIMIT 1;
	IF NOT FOUND THEN
		RETURN 37;
	ELSE
		SELECT id INTO aux FROM usuario u WHERE uid = u.id AND u.login1 = senhaNova LIMIT 1;
		IF FOUND THEN
			RETURN 38;
		ELSE
			UPDATE usuario SET senha = senhaNova WHERE id = uid;
			RETURN 0;
		END IF;
	END IF;
END $$ LANGUAGE 'plpgsql';