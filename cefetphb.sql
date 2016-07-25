-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.1.41-3ubuntu12.7


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema cefetphb
--

CREATE DATABASE IF NOT EXISTS cefetphb;
USE cefetphb;
CREATE TABLE  `cefetphb`.`aluno_diarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `diario_id` int(11) DEFAULT NULL,
  `aluno_id` int(11) DEFAULT NULL,
  `numero` int(11) DEFAULT NULL,
  `nota_01` decimal(4,2) DEFAULT NULL,
  `nota_02` decimal(4,2) DEFAULT NULL,
  `nota_03` decimal(4,2) DEFAULT NULL,
  `nota_04` decimal(4,2) DEFAULT NULL,
  `nota_05` decimal(4,2) DEFAULT NULL,
  `nota_06` decimal(4,2) DEFAULT NULL,
  `nota_07` decimal(4,2) DEFAULT NULL,
  `nota_08` decimal(4,2) DEFAULT NULL,
  `recuperacao_semestre_1` decimal(4,2) DEFAULT NULL,
  `recuperacao_semestre_2` decimal(4,2) DEFAULT NULL,
  `recuperacao_final` decimal(4,2) DEFAULT NULL,
  `faltas_01` int(11) DEFAULT NULL,
  `faltas_02` int(11) DEFAULT NULL,
  `faltas_03` int(11) DEFAULT NULL,
  `faltas_04` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `lock_version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `diario_id` (`diario_id`),
  KEY `aluno_id` (`aluno_id`),
  CONSTRAINT `aluno_diarios_ibfk_1` FOREIGN KEY (`diario_id`) REFERENCES `diarios` (`id`),
  CONSTRAINT `aluno_diarios_ibfk_2` FOREIGN KEY (`aluno_id`) REFERENCES `alunos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
INSERT INTO `cefetphb`.`aluno_diarios` VALUES  (1,1,2,12,'9.25','9.00','1.00','3.00','1.00','4.00','5.00','8.00','6.00','7.00','7.00',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
 (2,2,2,12,'5.00','5.00','5.00','5.00','5.00','5.00','5.00','5.00','6.00','6.00','8.00',2,2,2,2,NULL,NULL,NULL,NULL,NULL),
 (3,1,1,13,'10.00','10.00','10.00','10.00','10.00','10.00','10.00','10.00','8.00','8.00','8.00',2,2,2,2,NULL,NULL,NULL,NULL,NULL);
CREATE TABLE  `cefetphb`.`alunos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pessoa_id` int(11) DEFAULT NULL,
  `curso_id` int(11) DEFAULT NULL,
  `periodo_id` int(11) DEFAULT NULL,
  `nome_responsavel` varchar(50) DEFAULT NULL,
  `sequencia` int(11) DEFAULT NULL,
  `situacao_matricula_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_alunos_on_periodo_id_and_curso_id_and_sequencia` (`periodo_id`,`curso_id`,`sequencia`),
  KEY `pessoa_id` (`pessoa_id`),
  KEY `curso_id` (`curso_id`),
  KEY `alunos_ibfk_4` (`situacao_matricula_id`),
  CONSTRAINT `alunos_ibfk_1` FOREIGN KEY (`pessoa_id`) REFERENCES `pessoas` (`id`),
  CONSTRAINT `alunos_ibfk_2` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id`),
  CONSTRAINT `alunos_ibfk_3` FOREIGN KEY (`periodo_id`) REFERENCES `lista_valores` (`id`),
  CONSTRAINT `alunos_ibfk_4` FOREIGN KEY (`situacao_matricula_id`) REFERENCES `lista_valores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='InnoDB free: 10240 kB; (`situacao_matricula_id`) REFER `cefe';
INSERT INTO `cefetphb`.`alunos` VALUES  (1,2,1,1,'Francisco das Chagas',2,1),
 (2,1,1,1,'Pascoal Cardoso',1,1);

DELIMITER $$

CREATE DEFINER = `root`@`localhost` TRIGGER  `cefetphb`.`cria_sequencia` BEFORE INSERT ON `alunos` FOR EACH ROW begin
        set new.sequencia = (select max(sequencia)+1 as seq 
            from alunos where periodo_id = new.periodo_id 
            and curso_id = new.curso_id);
        if new.sequencia is null then
          set new.sequencia = 1;
        end if;  
      end $$

DELIMITER ;
CREATE TABLE  `cefetphb`.`areas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(20) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE  `cefetphb`.`autores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE  `cefetphb`.`autores_obras` (
  `autor_id` int(11) DEFAULT NULL,
  `obra_id` int(11) DEFAULT NULL,
  KEY `autor_id` (`autor_id`),
  KEY `obra_id` (`obra_id`),
  CONSTRAINT `autores_obras_ibfk_1` FOREIGN KEY (`autor_id`) REFERENCES `autores` (`id`),
  CONSTRAINT `autores_obras_ibfk_2` FOREIGN KEY (`obra_id`) REFERENCES `obras` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE  `cefetphb`.`cursos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modalidade_id` int(11) DEFAULT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `sigla` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `modalidade_id` (`modalidade_id`),
  CONSTRAINT `cursos_ibfk_1` FOREIGN KEY (`modalidade_id`) REFERENCES `lista_valores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
INSERT INTO `cefetphb`.`cursos` VALUES  (1,1,'informática','info'),
 (2,3,NULL,NULL);
CREATE TABLE  `cefetphb`.`diario_horarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `diario_id` int(11) DEFAULT NULL,
  `dia_semana_id` int(11) DEFAULT NULL,
  `horario_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `diario_id` (`diario_id`),
  KEY `dia_semana_id` (`dia_semana_id`),
  KEY `horario_id` (`horario_id`),
  CONSTRAINT `diario_horarios_ibfk_1` FOREIGN KEY (`diario_id`) REFERENCES `diarios` (`id`),
  CONSTRAINT `diario_horarios_ibfk_2` FOREIGN KEY (`dia_semana_id`) REFERENCES `lista_valores` (`id`),
  CONSTRAINT `diario_horarios_ibfk_3` FOREIGN KEY (`horario_id`) REFERENCES `horarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
INSERT INTO `cefetphb`.`diario_horarios` VALUES  (1,1,1,1);
CREATE TABLE  `cefetphb`.`diarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `professor_id` int(11) DEFAULT NULL,
  `periodo_id` int(11) DEFAULT NULL,
  `disciplina_id` int(11) DEFAULT NULL,
  `curso_id` int(11) DEFAULT NULL,
  `turno_id` int(11) DEFAULT NULL,
  `sala_id` int(11) DEFAULT NULL,
  `modulo` int(11) DEFAULT NULL,
  `carga_horaria` int(11) DEFAULT NULL,
  `aulas_previstas` int(11) DEFAULT NULL,
  `aulas_dadas` int(11) DEFAULT NULL,
  `aulas_semanais` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `professor_id` (`professor_id`),
  KEY `periodo_id` (`periodo_id`),
  KEY `disciplina_id` (`disciplina_id`),
  KEY `curso_id` (`curso_id`),
  KEY `turno_id` (`turno_id`),
  KEY `sala_id` (`sala_id`),
  CONSTRAINT `diarios_ibfk_1` FOREIGN KEY (`professor_id`) REFERENCES `servidores` (`id`),
  CONSTRAINT `diarios_ibfk_2` FOREIGN KEY (`periodo_id`) REFERENCES `lista_valores` (`id`),
  CONSTRAINT `diarios_ibfk_3` FOREIGN KEY (`disciplina_id`) REFERENCES `disciplinas` (`id`),
  CONSTRAINT `diarios_ibfk_4` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id`),
  CONSTRAINT `diarios_ibfk_5` FOREIGN KEY (`turno_id`) REFERENCES `lista_valores` (`id`),
  CONSTRAINT `diarios_ibfk_6` FOREIGN KEY (`sala_id`) REFERENCES `salas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
INSERT INTO `cefetphb`.`diarios` VALUES  (1,2,1,1,1,1,1,2,20,12,15,2),
 (2,2,1,2,1,1,1,2,12,12,12,12);
CREATE TABLE  `cefetphb`.`disciplinas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) DEFAULT NULL,
  `sigla` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
INSERT INTO `cefetphb`.`disciplinas` VALUES  (1,'Programação para Web','PW'),
 (2,'Programação orientada a objetos','POO');
CREATE TABLE  `cefetphb`.`editoras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) DEFAULT NULL,
  `cidade` varchar(255) DEFAULT NULL,
  `estado` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE  `cefetphb`.`emprestimos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_devolucao` date DEFAULT NULL,
  `data_emprestimo` date DEFAULT NULL,
  `multa` float DEFAULT NULL,
  `exemplar_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `servidor_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `aluno_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `exemplar_id` (`exemplar_id`),
  KEY `servidor_id` (`servidor_id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `aluno_id` (`aluno_id`),
  CONSTRAINT `emprestimos_ibfk_1` FOREIGN KEY (`exemplar_id`) REFERENCES `exemplares` (`id`),
  CONSTRAINT `emprestimos_ibfk_2` FOREIGN KEY (`servidor_id`) REFERENCES `servidores` (`id`),
  CONSTRAINT `emprestimos_ibfk_3` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `emprestimos_ibfk_4` FOREIGN KEY (`aluno_id`) REFERENCES `alunos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE  `cefetphb`.`exemplares` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cativo` tinyint(1) DEFAULT NULL,
  `obra_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `numero_registro` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `obra_id` (`obra_id`),
  CONSTRAINT `exemplares_ibfk_1` FOREIGN KEY (`obra_id`) REFERENCES `obras` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE  `cefetphb`.`frequencia_professores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `diario_id` int(11) DEFAULT NULL,
  `data` date DEFAULT NULL,
  `qtd_aulas` int(11) DEFAULT NULL,
  `resumo` varchar(255) DEFAULT NULL,
  `tipo_aula_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `diario_id` (`diario_id`),
  KEY `tipo_aula_id` (`tipo_aula_id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `frequencia_professores_ibfk_1` FOREIGN KEY (`diario_id`) REFERENCES `diarios` (`id`),
  CONSTRAINT `frequencia_professores_ibfk_2` FOREIGN KEY (`tipo_aula_id`) REFERENCES `lista_valores` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE  `cefetphb`.`horarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fim` varchar(5) DEFAULT NULL,
  `inicio` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
INSERT INTO `cefetphb`.`horarios` VALUES  (1,'0930','1020');
CREATE TABLE  `cefetphb`.`lista_valores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `valor` varchar(100) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `sigla` varchar(10) DEFAULT NULL,
  `sequencia` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
INSERT INTO `cefetphb`.`lista_valores` VALUES  (1,NULL,NULL,NULL,NULL),
 (2,NULL,NULL,NULL,NULL),
 (3,NULL,NULL,NULL,NULL),
 (4,NULL,NULL,NULL,NULL),
 (5,NULL,NULL,NULL,NULL);
CREATE TABLE  `cefetphb`.`obras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) DEFAULT NULL,
  `data_registro` date DEFAULT NULL,
  `numero_paginas` varchar(6) DEFAULT NULL,
  `numero_chamada` varchar(6) DEFAULT NULL,
  `exemplar` varchar(6) DEFAULT NULL,
  `edicao` varchar(20) DEFAULT NULL,
  `ano` varchar(4) DEFAULT NULL,
  `origem` varchar(10) DEFAULT NULL,
  `subtitulo` varchar(255) DEFAULT NULL,
  `volume` varchar(10) DEFAULT NULL,
  `serie_colecao` varchar(50) DEFAULT NULL,
  `idioma` varchar(10) DEFAULT NULL,
  `assunto` varchar(255) DEFAULT NULL,
  `observacao` text,
  `area_id` int(11) DEFAULT NULL,
  `editora_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `area_id` (`area_id`),
  KEY `editora_id` (`editora_id`),
  CONSTRAINT `obras_ibfk_1` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`),
  CONSTRAINT `obras_ibfk_2` FOREIGN KEY (`editora_id`) REFERENCES `editoras` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE  `cefetphb`.`ocorrencias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aluno_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `categoria_ocorrencia_id` int(11) DEFAULT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `observacao` text,
  `situacao_ocorrencia_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `aluno_id` (`aluno_id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `categoria_ocorrencia_id` (`categoria_ocorrencia_id`),
  KEY `situacao_ocorrencia_id` (`situacao_ocorrencia_id`),
  CONSTRAINT `ocorrencias_ibfk_1` FOREIGN KEY (`aluno_id`) REFERENCES `alunos` (`id`),
  CONSTRAINT `ocorrencias_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `ocorrencias_ibfk_3` FOREIGN KEY (`categoria_ocorrencia_id`) REFERENCES `lista_valores` (`id`),
  CONSTRAINT `ocorrencias_ibfk_4` FOREIGN KEY (`situacao_ocorrencia_id`) REFERENCES `lista_valores` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE  `cefetphb`.`pessoas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(25) DEFAULT NULL,
  `nome_completo` varchar(50) DEFAULT NULL,
  `cpf` varchar(11) DEFAULT NULL,
  `rg` varchar(20) DEFAULT NULL,
  `titulo_eleitor` varchar(12) DEFAULT NULL,
  `sexo_id` int(11) DEFAULT NULL,
  `estado_civil_id` int(11) DEFAULT NULL,
  `raca_id` int(11) DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL,
  `endereco` varchar(50) DEFAULT NULL,
  `bairro` varchar(30) DEFAULT NULL,
  `cep` varchar(8) DEFAULT NULL,
  `cidade` varchar(30) DEFAULT NULL,
  `uf_id` int(11) DEFAULT NULL,
  `profissao` varchar(30) DEFAULT NULL,
  `nacionalidade` varchar(25) DEFAULT NULL,
  `naturalidade` varchar(25) DEFAULT NULL,
  `nome_pai` varchar(50) DEFAULT NULL,
  `nome_mae` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `fone_res` varchar(10) DEFAULT NULL,
  `fone_cel` varchar(10) DEFAULT NULL,
  `observacao` text,
  `foto_file_name` varchar(255) DEFAULT NULL,
  `foto_content_type` varchar(255) DEFAULT NULL,
  `foto_file_size` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_pessoas_on_cpf` (`cpf`),
  KEY `sexo_id` (`sexo_id`),
  KEY `estado_civil_id` (`estado_civil_id`),
  KEY `raca_id` (`raca_id`),
  KEY `uf_id` (`uf_id`),
  CONSTRAINT `pessoas_ibfk_1` FOREIGN KEY (`sexo_id`) REFERENCES `lista_valores` (`id`),
  CONSTRAINT `pessoas_ibfk_2` FOREIGN KEY (`estado_civil_id`) REFERENCES `lista_valores` (`id`),
  CONSTRAINT `pessoas_ibfk_3` FOREIGN KEY (`raca_id`) REFERENCES `lista_valores` (`id`),
  CONSTRAINT `pessoas_ibfk_4` FOREIGN KEY (`uf_id`) REFERENCES `lista_valores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
INSERT INTO `cefetphb`.`pessoas` VALUES  (1,'Dener','Dener Silva Miranda','04358518676',NULL,NULL,1,2,3,'0000-00-00','Pinheiro Machado','Piaui','64208-33','Parnaiba',4,'estudante','Brasileiro nato','São Paulo-SP','Fcº das Chagas','Luzinete Luzitânia','denner.miranda@gmail.com','8633234196','8694178564',NULL,NULL,NULL,NULL),
 (2,'vitoria','Vitoria Regina','04357667597',NULL,NULL,2,1,3,'2000-12-01','São Sebastião','Pindorama','64208-20','parnaiba',1,'estudante','Brasileiro nato','Parnaiba-PI','Fco Chagas','Luzinete luzitania','exemplo@exemp.com','8612345678','8612345678',NULL,NULL,NULL,NULL),
 (3,'fulano','Fulano da silva','04358128676',NULL,NULL,1,1,1,'1993-12-12','3 de maio','Piaui','64208-34','Parnaiba',1,'estudante','Brasileiro nato','Campinas-SP','Fulano','Maria','exemplo@host.co','8611219612','1223178564',NULL,NULL,NULL,NULL);
CREATE TABLE  `cefetphb`.`renovacao_matriculas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aluno_id` int(11) DEFAULT NULL,
  `data` date DEFAULT NULL,
  `periodo_id` int(11) DEFAULT NULL,
  `modulo` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `lock_version` int(11) DEFAULT NULL,
  `turno_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_renovacao_matriculas_on_aluno_id_and_periodo_id` (`aluno_id`,`periodo_id`),
  KEY `periodo_id` (`periodo_id`),
  KEY `turno_id` (`turno_id`),
  CONSTRAINT `renovacao_matriculas_ibfk_1` FOREIGN KEY (`aluno_id`) REFERENCES `alunos` (`id`),
  CONSTRAINT `renovacao_matriculas_ibfk_2` FOREIGN KEY (`periodo_id`) REFERENCES `lista_valores` (`id`),
  CONSTRAINT `renovacao_matriculas_ibfk_3` FOREIGN KEY (`turno_id`) REFERENCES `lista_valores` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE  `cefetphb`.`reservas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data` date DEFAULT NULL,
  `estado` varchar(255) DEFAULT NULL,
  `obra_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `servidor_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `aluno_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `obra_id` (`obra_id`),
  KEY `servidor_id` (`servidor_id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `aluno_id` (`aluno_id`),
  CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`obra_id`) REFERENCES `obras` (`id`),
  CONSTRAINT `reservas_ibfk_2` FOREIGN KEY (`servidor_id`) REFERENCES `servidores` (`id`),
  CONSTRAINT `reservas_ibfk_3` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `reservas_ibfk_4` FOREIGN KEY (`aluno_id`) REFERENCES `alunos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE  `cefetphb`.`roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE  `cefetphb`.`roles_usuarios` (
  `role_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  KEY `index_roles_usuarios_on_role_id` (`role_id`),
  KEY `index_roles_usuarios_on_usuario_id` (`usuario_id`),
  CONSTRAINT `roles_usuarios_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `roles_usuarios_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE  `cefetphb`.`salas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) DEFAULT NULL,
  `sigla` varchar(20) DEFAULT NULL,
  `lock_version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
INSERT INTO `cefetphb`.`salas` VALUES  (1,'Informática','info',NULL);
CREATE TABLE  `cefetphb`.`schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE  `cefetphb`.`servidores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pessoa_id` int(11) DEFAULT NULL,
  `siape` varchar(10) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pessoa_id` (`pessoa_id`),
  CONSTRAINT `servidores_ibfk_1` FOREIGN KEY (`pessoa_id`) REFERENCES `pessoas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
INSERT INTO `cefetphb`.`servidores` VALUES  (2,3,'0123456789',NULL);
CREATE TABLE  `cefetphb`.`usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(40) DEFAULT NULL,
  `name` varchar(100) DEFAULT '',
  `email` varchar(100) DEFAULT NULL,
  `crypted_password` varchar(40) DEFAULT NULL,
  `salt` varchar(40) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `remember_token` varchar(40) DEFAULT NULL,
  `remember_token_expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_usuarios_on_login` (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
