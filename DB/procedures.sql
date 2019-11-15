USE `progweb`;
DELIMITER $$

CREATE PROCEDURE genkeys(
	IN TES_id INT,
    IN amount INT)
BEGIN
	
	SET @count = amount;
    SET @gen = '';
	WHILE @count > 0 DO
		SET @gen = LEFT(MD5(RAND()), 8);
        
        if not exists (select * from `progweb`.`codigounico` where `idCodigoUnico` LIKE CONCAT(@gen,'%')) then
			SET @i = 1;
            SET @sum = 0;
			verifier_digit_1: LOOP
				IF @i>8 THEN
					LEAVE verifier_digit_1;
                END IF;
				SET @sum = @sum + ASCII(SUBSTRING(@gen,@i,1));
				SET @i = @i+1;
            END LOOP;
            SET @sum = MOD(@sum,7);
            SET @gen = CONCAT(@gen,@sum);
            SET @i = 1;
            SET @sum = 0;
			verifier_digit_2: LOOP
				IF @i>9 THEN
					LEAVE verifier_digit_2;
                END IF;
				SET @sum = @sum + ASCII(SUBSTRING(@gen,@i,1));
				SET @i = @i+1;
            END LOOP;
            SET @sum = MOD(@sum,7);
            SET @fin = CONCAT(@gen,@sum);
            insert into `progweb`.`codigounico` (`idCodigoUnico`, `Teste_TES_idTeste`) Values(@fin,TES_id);
            SET @count = @count-1;
        end if;
        
	END WHILE;
END;$$
DELIMITER ;
/*CALL genkeys(1,10);*/

use `progweb`
DELIMITER $$
##Esse código gera o csv dos usuários e suas respostas e salva na pasta permitida para o mysql.
CREATE PROCEDURE answers_to_csv(
	IN TES_id INT)
BEGIN
	DECLARE id INT(11);
    DECLARE finished INTEGER DEFAULT 0;
	DECLARE cur CURSOR FOR SELECT `Usu_idUsuario` FROM `Usuario` WHERE `Teste_TES_idTeste` = TES_id;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
    
    SET @questions = "";
	BLOCK_get_perguntas: BEGIN
		DECLARE question VARCHAR(200);
        DECLARE question_code VARCHAR(20);
		DECLARE finished_question INTEGER DEFAULT 0;
		DECLARE cursor_questions CURSOR FOR SELECT `PER_descricao`, `PER_codigo` FROM `Pergunta` WHERE `Teste_TES_idTeste` = TES_id ORDER BY `PER_indice`;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished_question = 1;
		OPEN cursor_questions;
        cursor_questions_loop: LOOP
            FETCH cursor_questions INTO question, question_code;
			IF finished_question THEN
			  LEAVE cursor_questions_loop;
			END IF;
            IF (question = '') THEN
				SET @questions = CONCAT(@questions,question_code,',');
            ELSE
				SET @questions = CONCAT(@questions,"\"",question,"\",");
            END IF;
        END LOOP cursor_questions_loop;
		CLOSE cursor_questions;
        SET @questions = SUBSTRING(@questions,1,CHAR_LENGTH(@questions)-1);
        
    END BLOCK_get_perguntas;
    SET @write_data = CONCAT("\"Contato\",\"Email\",\"Idade\",\"Sexo\",\"CEP\",\"Cor\",\"Deficiência\",",@questions);
    OPEN cur;
    curLoop: LOOP
		FETCH cur INTO id;
		IF finished THEN
		  LEAVE curLoop;
		END IF;
        SELECT CONCAT("\"",USU_contato,'\",\"',USU_email,'\",',USU_idade,',\"',USU_sexo,'\",\"',USU_cep,'\",\"',USU_cor,'\",\"',USU_enfermidade,'\"') FROM `Usuario` WHERE `USU_idUsuario` = id
        INTO @user_data;
        ##Selecionar apenas as respostas de um usuário e verificar qual resposta não é null e salvar no answer, ao final salvar tudo em um csv contendo dado de quem respondeu e as respostas.
        BLOCK_2: BEGIN
            DECLARE continuous DECIMAL(2,2);
			DECLARE ordinal INT(11);
            DECLARE descript VARCHAR(200);
            DECLARE finished_2 INTEGER DEFAULT 0;
			DECLARE cursor_answer_id CURSOR FOR SELECT `RES_respostaContinua`, `RES_respostaOrdinal`, `RES_descricao`
													FROM (SELECT * FROM `Resposta` WHERE `Usuario_USU_idUsuario` = id) as A
                                                    INNER JOIN `Pergunta` as B on A.`Pergunta_PER_idPergunta` = B.`PER_idPergunta` ORDER BY B.`PER_indice`;
			DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished_2 = 1;
			
            OPEN cursor_answer_id;
            SET @all_answer = "";
            cursor_answer_loop: LOOP
				FETCH cursor_answer_id INTO continuous, ordinal, descript;
				IF finished_2 THEN
					LEAVE cursor_answer_loop;
				END IF;
				IF (descript is null) THEN
					IF (continuous is not null) THEN
						SET @answer = continuous;
					ELSE
						SET @answer = ordinal;
                    END IF;
                ELSE
					SET @answer = CONCAT("\"",descript,"\"");
                END IF;
                SET @all_answer = CONCAT(@all_answer,',',@answer);
            END LOOP cursor_answer_loop;
            
            CLOSE cursor_answer_id;
            SET @write_data = CONCAT(@write_data,'\r\n',@user_data,@all_answer);
        END BLOCK_2;
		
        
               
	END LOOP curLoop;
	CLOSE cur;
    SELECT @write_data;
    /*SET @filename = CONCAT('/Teste_',TES_id,'.csv');
    SELECT @@secure_file_priv INTO @secure_location;
    SELECT @write_data;
    SELECT @secure_location;
    set @query_save_to_file = concat('SELECT @write_data INTO OUTFILE ',"'",@filename,"'",' CHARACTER SET utf8;');
	PREPARE stmt1 FROM @query_save_to_file;
	EXECUTE stmt1;
	Deallocate prepare stmt1;*/
    
END;$$
DELIMITER ;
##Setar o --secure-file-priv para uma pasta específica.
##CALL answers_to_csv(2);


