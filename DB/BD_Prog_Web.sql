-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema progweb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema progweb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `progweb` DEFAULT CHARACTER SET utf8 ;
USE `progweb` ;

-- -----------------------------------------------------
-- Table `progweb`.`pesquisador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `progweb`.`Pesquisador` (
  `PES_email` VARCHAR(60) NOT NULL,
  `PES_id` INT(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`PES_id`),
  UNIQUE INDEX `PES_id_UNIQUE` (`PES_id` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `progweb`.`teste`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `progweb`.`Teste` (
  `TES_idTeste` INT(11) NOT NULL AUTO_INCREMENT,
  `TES_descricao` VARCHAR(1000) NOT NULL,
  `TES_titulo` VARCHAR(50) NOT NULL,
  `Pesquisador_PES_id` INT(11) NULL,
  `TES_visibilidade` TINYINT(4) NOT NULL,
  `TES_createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `TES_updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`TES_idTeste`),
  UNIQUE INDEX `TES_idTeste_UNIQUE` (`TES_idTeste` ASC) ,
  UNIQUE INDEX `TES_titulo_UNIQUE` (`TES_titulo` ASC) ,
  INDEX `fk_teste_pesquisador1_idx` (`Pesquisador_PES_id` ASC) ,
  CONSTRAINT `fk_teste_pesquisador1`
    FOREIGN KEY (`Pesquisador_PES_id`)
    REFERENCES `progweb`.`Pesquisador` (`PES_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `progweb`.`codigounico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `progweb`.`CodigoUnico` (
  `idCodigoUnico` VARCHAR(10) NOT NULL,
  `Teste_TES_idTeste` INT(11) NOT NULL,
  PRIMARY KEY (`Teste_TES_idTeste`, `idCodigoUnico`),
  UNIQUE INDEX `idCodigoUnico_UNIQUE` (`idCodigoUnico` ASC) ,
  INDEX `fk_CodigoUnico_Teste1_idx` (`Teste_TES_idTeste` ASC) ,
  CONSTRAINT `fk_CodigoUnico_Teste1`
    FOREIGN KEY (`Teste_TES_idTeste`)
    REFERENCES `progweb`.`Teste` (`TES_idTeste`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `progweb`.`imagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `progweb`.`Imagem` (
  `IMG_idImagem` INT(11) NOT NULL AUTO_INCREMENT,
  `IMG_endereco` VARCHAR(150) NOT NULL,
  `IMG_tag` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IMG_idImagem`),
  UNIQUE INDEX `IMG_idImagem_UNIQUE` (`IMG_idImagem` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `progweb`.`pergunta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `progweb`.`Pergunta` (
  `PER_descricao` VARCHAR(200) NULL DEFAULT NULL,
  `PER_codigo` VARCHAR(20) NULL DEFAULT NULL,
  `PER_tipo` INT(11) NULL DEFAULT NULL,
  `PER_idPergunta` INT(11) NOT NULL AUTO_INCREMENT,
  `Teste_TES_idTeste` INT(11) NOT NULL,
  `PER_indice` INT(11) NOT NULL,
  `PER_updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`PER_idPergunta`),
  UNIQUE INDEX `PER_idPergunta_UNIQUE` (`PER_idPergunta` ASC) ,
  INDEX `fk_Pergunta_Teste1_idx` (`Teste_TES_idTeste` ASC) ,
  CONSTRAINT `fk_Pergunta_Teste1`
    FOREIGN KEY (`Teste_TES_idTeste`)
    REFERENCES `progweb`.`Teste` (`TES_idTeste`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `progweb`.`pergunta_has_imagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `progweb`.`Pergunta_has_Imagem` (
  `Pergunta_PER_idPergunta` INT(11) NOT NULL,
  `Imagem_IMG_idImagem` INT(11) NOT NULL,
  `PHI_indice` INT(11) NOT NULL,
  PRIMARY KEY (`Pergunta_PER_idPergunta`, `Imagem_IMG_idImagem`),
  INDEX `fk_Pergunta_has_Imagem_Imagem1_idx` (`Imagem_IMG_idImagem` ASC) ,
  INDEX `fk_Pergunta_has_Imagem_Pergunta_idx` (`Pergunta_PER_idPergunta` ASC) ,
  CONSTRAINT `fk_Pergunta_has_Imagem_Imagem1`
    FOREIGN KEY (`Imagem_IMG_idImagem`)
    REFERENCES `progweb`.`Imagem` (`IMG_idImagem`)
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pergunta_has_Imagem_Pergunta`
    FOREIGN KEY (`Pergunta_PER_idPergunta`)
    REFERENCES `progweb`.`Pergunta` (`PER_idPergunta`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `progweb`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `progweb`.`Usuario` (
  `USU_idUsuario` INT(11) NOT NULL AUTO_INCREMENT,
  `USU_contato` CHAR(13) NOT NULL,
  `USU_email` VARCHAR(60) NOT NULL,
  `USU_idade` INT(11) NOT NULL,
  `USU_sexo` CHAR(1) NOT NULL,
  `USU_cep` CHAR(8) NOT NULL,
  `USU_cor` VARCHAR(15) NOT NULL,
  `USU_enfermidade` VARCHAR(200) NULL DEFAULT NULL,
  `Teste_TES_idTeste` INT(11) NOT NULL,
  `USU_codigo_unico_teste` VARCHAR(10) NULL,
  PRIMARY KEY (`USU_idUsuario`),
  UNIQUE INDEX `idUsuario_UNIQUE` (`USU_idUsuario` ASC) ,
  INDEX `fk_Usuario_Teste1_idx` (`Teste_TES_idTeste` ASC) ,
  CONSTRAINT `fk_Usuario_Teste1`
    FOREIGN KEY (`Teste_TES_idTeste`)
    REFERENCES `progweb`.`Teste` (`TES_idTeste`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `progweb`.`resposta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `progweb`.`Resposta` (
  `RES_idResposta` INT(11) NOT NULL AUTO_INCREMENT,
  `RES_respostaContinua` DECIMAL(2,2) NULL DEFAULT NULL,
  `RES_respostaOrdinal` INT(1) NULL DEFAULT NULL,
  `RES_descricao` VARCHAR(200) NULL DEFAULT NULL,
  `Usuario_USU_idUsuario` INT(11) NOT NULL,
  `Pergunta_PER_idPergunta` INT(11) NOT NULL,
  `RES_createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`RES_idResposta`, `Usuario_USU_idUsuario`, `Pergunta_PER_idPergunta`),
  UNIQUE INDEX `RES_idResposta_UNIQUE` (`RES_idResposta` ASC) ,
  INDEX `fk_Resposta_Usuario1_idx` (`Usuario_USU_idUsuario` ASC) ,
  INDEX `fk_Resposta_Pergunta1_idx` (`Pergunta_PER_idPergunta` ASC) ,
  CONSTRAINT `fk_Resposta_Pergunta1`
    FOREIGN KEY (`Pergunta_PER_idPergunta`)
    REFERENCES `progweb`.`Pergunta` (`PER_idPergunta`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Resposta_Usuario1`
    FOREIGN KEY (`Usuario_USU_idUsuario`)
    REFERENCES `progweb`.`Usuario` (`USU_idUsuario`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


USE progweb;
INSERT INTO `Pesquisador` (`PES_id`,`PES_email`) VALUES (null,'pes1@teste.com');
INSERT INTO `Pesquisador` (`PES_id`,`PES_email`) VALUES (null,'pes2@teste.com');
INSERT INTO `Pesquisador` (`PES_id`,`PES_email`) VALUES (null,'pes3@teste.com');
INSERT INTO `Pesquisador` (`PES_id`,`PES_email`) VALUES (null,'pedro.fachini.99@gmail.com');
INSERT INTO `Pesquisador` (`PES_id`,`PES_email`) VALUES (null,'dudupedrosao@gmail.com');
INSERT INTO `Pesquisador` (`PES_id`,`PES_email`) VALUES (null,'igortorati@gmail.com');

INSERT INTO `Imagem` (`IMG_idImagem`, `IMG_endereco`, `IMG_tag`) VALUES (NULL, '/images/1.png', 'Feliz');
INSERT INTO `Imagem` (`IMG_idImagem`, `IMG_endereco`, `IMG_tag`) VALUES (NULL, '/images/2.png', 'Neutro');
INSERT INTO `Imagem` (`IMG_idImagem`, `IMG_endereco`, `IMG_tag`) VALUES (NULL, '/images/3.png', 'Triste');
INSERT INTO `Imagem` (`IMG_idImagem`, `IMG_endereco`, `IMG_tag`) VALUES (NULL, '/images/4.png', 'Triste-Neutro');
INSERT INTO `Imagem` (`IMG_idImagem`, `IMG_endereco`, `IMG_tag`) VALUES (NULL, '/images/5.png', 'Neutro-Feliz');

INSERT INTO `Teste`(`TES_idTeste`, `TES_descricao`, `TES_titulo`, `Pesquisador_PES_id`, `TES_visibilidade`) VALUES (NULL,'Teste para avaliar perfil psicológico dos alunos de Ciência da Computação da UFLA.','Perfil psicológico GCC-UFLA.',1,1);
INSERT INTO `Teste`(`TES_idTeste`, `TES_descricao`, `TES_titulo`, `Pesquisador_PES_id`, `TES_visibilidade`) VALUES (NULL,'Teste para avaliar satisfação dos alunos do curso de Engenharia de Alimentos da UFLA.','Satisfação GCA-UFLA.',3,0);

INSERT INTO `CodigoUnico` (`idCodigoUnico`, `Teste_TES_idTeste`) VALUES ('gfr543x2', 1);
INSERT INTO `CodigoUnico` (`idCodigoUnico`, `Teste_TES_idTeste`) VALUES ('htf658n3', 2);
INSERT INTO `CodigoUnico` (`idCodigoUnico`, `Teste_TES_idTeste`) VALUES ('sad51396', 1);
INSERT INTO `CodigoUnico` (`idCodigoUnico`, `Teste_TES_idTeste`) VALUES ('hvn328fh', 1);
INSERT INTO `CodigoUnico` (`idCodigoUnico`, `Teste_TES_idTeste`) VALUES ('awe2368k', 2);

INSERT INTO `Pergunta` (`PER_descricao`, `PER_codigo`, `PER_tipo`, `PER_idPergunta`, `Teste_TES_idTeste`, `PER_indice`) VALUES ('Com relação aos professores do curso, qual sua satisfação com o método de ensino que utilizam?', NULL, 0, NULL, 2, 1);
INSERT INTO `Pergunta_has_Imagem` (`Pergunta_PER_idPergunta`, `Imagem_IMG_idImagem`, `PHI_indice`) VALUES (1, 1, 3);
INSERT INTO `Pergunta_has_Imagem` (`Pergunta_PER_idPergunta`, `Imagem_IMG_idImagem`, `PHI_indice`) VALUES (1, 2, 2);
INSERT INTO `Pergunta_has_Imagem` (`Pergunta_PER_idPergunta`, `Imagem_IMG_idImagem`, `PHI_indice`) VALUES (1, 3, 1);
INSERT INTO `Pergunta` (`PER_descricao`, `PER_codigo`, `PER_tipo`, `PER_idPergunta`, `Teste_TES_idTeste`, `PER_indice`) VALUES ('Com relação aos professores do curso, qual sua satisfação com o método de de avaliação que utilizam?', NULL, 0, NULL, 2, 3);
INSERT INTO `Pergunta_has_Imagem` (`Pergunta_PER_idPergunta`, `Imagem_IMG_idImagem`, `PHI_indice`) VALUES (2, 1, 3);
INSERT INTO `Pergunta_has_Imagem` (`Pergunta_PER_idPergunta`, `Imagem_IMG_idImagem`, `PHI_indice`) VALUES (2, 2, 2);
INSERT INTO `Pergunta_has_Imagem` (`Pergunta_PER_idPergunta`, `Imagem_IMG_idImagem`, `PHI_indice`) VALUES (2, 3, 1);
INSERT INTO `Pergunta` (`PER_descricao`, `PER_codigo`, `PER_tipo`, `PER_idPergunta`, `Teste_TES_idTeste`, `PER_indice`) VALUES ('Com relação aos professores do curso, qual sua satisfação com o horário de atendimento disponibilizado por eles?', NULL, 0, NULL, 2, 2);
INSERT INTO `Pergunta_has_Imagem` (`Pergunta_PER_idPergunta`, `Imagem_IMG_idImagem`, `PHI_indice`) VALUES (3, 1, 3);
INSERT INTO `Pergunta_has_Imagem` (`Pergunta_PER_idPergunta`, `Imagem_IMG_idImagem`, `PHI_indice`) VALUES (3, 2, 2);
INSERT INTO `Pergunta_has_Imagem` (`Pergunta_PER_idPergunta`, `Imagem_IMG_idImagem`, `PHI_indice`) VALUES (3, 3, 1);
INSERT INTO `Pergunta` (`PER_descricao`, `PER_codigo`, `PER_tipo`, `PER_idPergunta`, `Teste_TES_idTeste`, `PER_indice`) VALUES ('Com relação aos professores do curso, qual sua satisfação com o monitor da disciplina?', NULL, 0, NULL, 2,4);
INSERT INTO `Pergunta_has_Imagem` (`Pergunta_PER_idPergunta`, `Imagem_IMG_idImagem`, `PHI_indice`) VALUES (4, 1, 3);
INSERT INTO `Pergunta_has_Imagem` (`Pergunta_PER_idPergunta`, `Imagem_IMG_idImagem`, `PHI_indice`) VALUES (4, 2, 2);
INSERT INTO `Pergunta_has_Imagem` (`Pergunta_PER_idPergunta`, `Imagem_IMG_idImagem`, `PHI_indice`) VALUES (4, 3, 1);

INSERT INTO `Pergunta` (`PER_descricao`, `PER_codigo`, `PER_tipo`, `PER_idPergunta`, `Teste_TES_idTeste`, `PER_indice`) VALUES ('O quão satisfeito você está com a quantidade de tempo de lazer (tempo livre) que você tem diariamente?', NULL, 1, NULL, 1, 4);
INSERT INTO `Pergunta_has_Imagem` (`Pergunta_PER_idPergunta`, `Imagem_IMG_idImagem`, `PHI_indice`) VALUES (5, 1, 5);
INSERT INTO `Pergunta_has_Imagem` (`Pergunta_PER_idPergunta`, `Imagem_IMG_idImagem`, `PHI_indice`) VALUES (5, 2, 3);
INSERT INTO `Pergunta_has_Imagem` (`Pergunta_PER_idPergunta`, `Imagem_IMG_idImagem`, `PHI_indice`) VALUES (5, 3, 1);
INSERT INTO `Pergunta_has_Imagem` (`Pergunta_PER_idPergunta`, `Imagem_IMG_idImagem`, `PHI_indice`) VALUES (5, 4, 2);
INSERT INTO `Pergunta_has_Imagem` (`Pergunta_PER_idPergunta`, `Imagem_IMG_idImagem`, `PHI_indice`) VALUES (5, 5, 4);
INSERT INTO `Pergunta` (`PER_descricao`, `PER_codigo`, `PER_tipo`, `PER_idPergunta`, `Teste_TES_idTeste`, `PER_indice`) VALUES ('Qual seu animo para fazer atividades ao acordar?', NULL, 0, NULL, 1,2);
INSERT INTO `Pergunta_has_Imagem` (`Pergunta_PER_idPergunta`, `Imagem_IMG_idImagem`, `PHI_indice`) VALUES (6, 1, 3);
INSERT INTO `Pergunta_has_Imagem` (`Pergunta_PER_idPergunta`, `Imagem_IMG_idImagem`, `PHI_indice`) VALUES (6, 2, 2);
INSERT INTO `Pergunta_has_Imagem` (`Pergunta_PER_idPergunta`, `Imagem_IMG_idImagem`, `PHI_indice`) VALUES (6, 3, 1);
INSERT INTO `Pergunta` (`PER_descricao`, `PER_codigo`, `PER_tipo`, `PER_idPergunta`, `Teste_TES_idTeste`, `PER_indice`) VALUES ('', 236, 0, NULL, 1, 1);
INSERT INTO `Pergunta_has_Imagem` (`Pergunta_PER_idPergunta`, `Imagem_IMG_idImagem`, `PHI_indice`) VALUES (7, 1, 3);
INSERT INTO `Pergunta_has_Imagem` (`Pergunta_PER_idPergunta`, `Imagem_IMG_idImagem`, `PHI_indice`) VALUES (7, 2, 2);
INSERT INTO `Pergunta_has_Imagem` (`Pergunta_PER_idPergunta`, `Imagem_IMG_idImagem`, `PHI_indice`) VALUES (7, 3, 1);
INSERT INTO `Pergunta` (`PER_descricao`, `PER_codigo`, `PER_tipo`, `PER_idPergunta`, `Teste_TES_idTeste`, `PER_indice`) VALUES ('Quão satisfeito você está com o curso?', NULL, 0, NULL, 1, 3);
INSERT INTO `Pergunta_has_Imagem` (`Pergunta_PER_idPergunta`, `Imagem_IMG_idImagem`, `PHI_indice`) VALUES (8, 1, 3);
INSERT INTO `Pergunta_has_Imagem` (`Pergunta_PER_idPergunta`, `Imagem_IMG_idImagem`, `PHI_indice`) VALUES (8, 2, 2);
INSERT INTO `Pergunta_has_Imagem` (`Pergunta_PER_idPergunta`, `Imagem_IMG_idImagem`, `PHI_indice`) VALUES (8, 3, 1);

INSERT INTO `progweb`.`Usuario`(`USU_idUsuario`,`USU_contato`,`USU_email`,`USU_idade`,`USU_sexo`,`USU_cep`,`USU_cor`,`USU_enfermidade`,`Teste_TES_idTeste`,`USU_codigo_unico_teste`)VALUES(null,'35991501894','usu1@mail.com',26,'M','13873207','Branco','Problema de Visão severo.',2,'aaaaaa00');
INSERT INTO `progweb`.`Usuario`(`USU_idUsuario`,`USU_contato`,`USU_email`,`USU_idade`,`USU_sexo`,`USU_cep`,`USU_cor`,`USU_enfermidade`,`Teste_TES_idTeste`,`USU_codigo_unico_teste`)VALUES(null,'35999999999','usu2@mail.com',17,'F','13720000','Preto','',1,'bbbbbb11');
INSERT INTO `progweb`.`Usuario`(`USU_idUsuario`,`USU_contato`,`USU_email`,`USU_idade`,`USU_sexo`,`USU_cep`,`USU_cor`,`USU_enfermidade`,`Teste_TES_idTeste`,`USU_codigo_unico_teste`)VALUES(null,'35991501894','usu1@mail.com',26,'M','13873207','Branco','Problema de Visão severo.',1,'cccccc22');

INSERT INTO `progweb`.`Resposta`(`RES_idResposta`,`RES_respostaContinua`,`RES_respostaOrdinal`,`RES_descricao`,`Usuario_USU_idUsuario`,`Pergunta_PER_idPergunta`,`RES_createdAt`)VALUES(null,null,1,null,1,1,CURRENT_TIMESTAMP);
INSERT INTO `progweb`.`Resposta`(`RES_idResposta`,`RES_respostaContinua`,`RES_respostaOrdinal`,`RES_descricao`,`Usuario_USU_idUsuario`,`Pergunta_PER_idPergunta`,`RES_createdAt`)VALUES(null,null,2,null,1,2,CURRENT_TIMESTAMP);
INSERT INTO `progweb`.`Resposta`(`RES_idResposta`,`RES_respostaContinua`,`RES_respostaOrdinal`,`RES_descricao`,`Usuario_USU_idUsuario`,`Pergunta_PER_idPergunta`,`RES_createdAt`)VALUES(null,null,0,null,1,3,CURRENT_TIMESTAMP);
INSERT INTO `progweb`.`Resposta`(`RES_idResposta`,`RES_respostaContinua`,`RES_respostaOrdinal`,`RES_descricao`,`Usuario_USU_idUsuario`,`Pergunta_PER_idPergunta`,`RES_createdAt`)VALUES(null,null,2,null,1,4,CURRENT_TIMESTAMP);

INSERT INTO `progweb`.`Resposta`(`RES_idResposta`,`RES_respostaContinua`,`RES_respostaOrdinal`,`RES_descricao`,`Usuario_USU_idUsuario`,`Pergunta_PER_idPergunta`,`RES_createdAt`)VALUES(null,0.56,null,null,3,5,CURRENT_TIMESTAMP);
INSERT INTO `progweb`.`Resposta`(`RES_idResposta`,`RES_respostaContinua`,`RES_respostaOrdinal`,`RES_descricao`,`Usuario_USU_idUsuario`,`Pergunta_PER_idPergunta`,`RES_createdAt`)VALUES(null,null,0,null,3,6,CURRENT_TIMESTAMP);
INSERT INTO `progweb`.`Resposta`(`RES_idResposta`,`RES_respostaContinua`,`RES_respostaOrdinal`,`RES_descricao`,`Usuario_USU_idUsuario`,`Pergunta_PER_idPergunta`,`RES_createdAt`)VALUES(null,null,null,'Parece ser uma garrafa de vidro.',3,7,CURRENT_TIMESTAMP);
INSERT INTO `progweb`.`Resposta`(`RES_idResposta`,`RES_respostaContinua`,`RES_respostaOrdinal`,`RES_descricao`,`Usuario_USU_idUsuario`,`Pergunta_PER_idPergunta`,`RES_createdAt`)VALUES(null,null,1,null,3,8,CURRENT_TIMESTAMP);

INSERT INTO `progweb`.`Resposta`(`RES_idResposta`,`RES_respostaContinua`,`RES_respostaOrdinal`,`RES_descricao`,`Usuario_USU_idUsuario`,`Pergunta_PER_idPergunta`,`RES_createdAt`)VALUES(null,0.73,null,null,2,5,CURRENT_TIMESTAMP);
INSERT INTO `progweb`.`Resposta`(`RES_idResposta`,`RES_respostaContinua`,`RES_respostaOrdinal`,`RES_descricao`,`Usuario_USU_idUsuario`,`Pergunta_PER_idPergunta`,`RES_createdAt`)VALUES(null,null,2,null,2,6,CURRENT_TIMESTAMP);
INSERT INTO `progweb`.`Resposta`(`RES_idResposta`,`RES_respostaContinua`,`RES_respostaOrdinal`,`RES_descricao`,`Usuario_USU_idUsuario`,`Pergunta_PER_idPergunta`,`RES_createdAt`)VALUES(null,null,null,'Possui uma textura lisa, parece ser vidro, talvez seja um vaso ou uma garrafa de vidro.',2,7,CURRENT_TIMESTAMP);
INSERT INTO `progweb`.`Resposta`(`RES_idResposta`,`RES_respostaContinua`,`RES_respostaOrdinal`,`RES_descricao`,`Usuario_USU_idUsuario`,`Pergunta_PER_idPergunta`,`RES_createdAt`)VALUES(null,null,0,null,2,8,CURRENT_TIMESTAMP);

ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'eduardoigorjoao';