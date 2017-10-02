CREATE OR REPLACE FUNCTION cadastraAtividade(codigo VARCHAR(20), nome VARCHAR(100), ano INTEGER, semestre VARCHAR(5), horario VARCHAR(200), professor VARCHAR(10))
RETURNS void AS $$
BEGIN
	INSERT INTO atividade (codigo, nome, ano, semestre, horario) VALUES (codigo, nome, ano, semestre, horario);
	INSERT INTO professor_atividade (professor_codigo, atividade_codigo) VALUES (codigo, professor);
END $$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION cadastraUsuario()