-- -----------------------------------------------------
-- Schema pokemon
-- -----------------------------------------------------
DROP SCHEMA pokemon;
CREATE SCHEMA IF NOT EXISTS pokemon DEFAULT CHARACTER SET utf8 ;
USE pokemon ;

-- -----------------------------------------------------
-- Table equipe
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS equipe (
  idequipe INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  idLider INT NULL,
  PRIMARY KEY (idequipe)
);


-- -----------------------------------------------------
-- Table treinador
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS treinador (
  idtreinador INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  data_nascimento DATE NULL,
  qtd_insignias INT NULL,
  idequipe INT NULL,
  genero VARCHAR(45) NULL,
  PRIMARY KEY (idtreinador),
  CONSTRAINT fk_equipe
    FOREIGN KEY (idequipe)
    REFERENCES equipe (idequipe)
    ON DELETE SET NULL
    ON UPDATE SET NULL
);

alter table equipe add constraint fk_lider foreign key (idLider) references treinador(idtreinador) ON DELETE SET NULL ON UPDATE SET NULL;


-- -----------------------------------------------------
-- Table classe
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS classe (
  idclasse INT NOT NULL AUTO_INCREMENT,
  descricao VARCHAR(50) NOT NULL,
  PRIMARY KEY (idclasse)
);


-- -----------------------------------------------------
-- Table pokemon
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS pokemon (
  idpokemon INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  idclasse INT,
  ataque FLOAT NOT NULL,
  defesa FLOAT NOT NULL,
  vida FLOAT NOT NULL,
  PRIMARY KEY (idpokemon),
  CONSTRAINT fk_classe
    FOREIGN KEY (idclasse)
    REFERENCES classe (idclasse)
    ON DELETE SET NULL
    ON UPDATE SET NULL);


-- -----------------------------------------------------
-- Table enfermaria
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS enfermaria (
  idenfermaria INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  PRIMARY KEY (idenfermaria)
);


-- -----------------------------------------------------
-- Table batalha
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS batalha (
  idbatalha INT NOT NULL AUTO_INCREMENT,
  idTreinadorVencedor INT NOT NULL,
  idTreinadorPerdedor INT NOT NULL,
  PRIMARY KEY (idbatalha),
  CONSTRAINT fk_treinador_vencedor
    FOREIGN KEY (idTreinadorVencedor)
    REFERENCES treinador (idtreinador)
    ON DELETE cascade
    ON UPDATE cascade,
  CONSTRAINT fk_treinador_perdedor
    FOREIGN KEY (idTreinadorPerdedor)
    REFERENCES treinador (idtreinador)
    ON DELETE cascade
    ON UPDATE cascade
);


-- -----------------------------------------------------
-- Table pokemon_capturado
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS pokemon_capturado (
  idtreinador INT NOT NULL,
  idpokemon INT NOT NULL,
  PRIMARY KEY (idtreinador, idpokemon),
  CONSTRAINT fk_treinador
    FOREIGN KEY (idtreinador)
    REFERENCES treinador (idtreinador)
    ON DELETE cascade
    ON UPDATE cascade,
  CONSTRAINT fk_pokemon
    FOREIGN KEY (idpokemon)
    REFERENCES pokemon (idpokemon)
    ON DELETE cascade
    ON UPDATE cascade
);


-- -----------------------------------------------------
-- Table round_batalha
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS round_batalha (
  idBatalha INT NOT NULL,
  idTreinadorVencedor INT NOT NULL,
  idPokemonVencedor INT NOT NULL,
  idTreinadorPerdedor INT NOT NULL,
  idPokemonPerdedor INT NOT NULL,
  PRIMARY KEY (idBatalha, idPokemonVencedor, idPokemonPerdedor),
  CONSTRAINT fk_batalha
    FOREIGN KEY (idBatalha)
    REFERENCES batalha (idBatalha)
    ON DELETE cascade
    ON UPDATE cascade,
  CONSTRAINT fk_treinador_pokemon_vencedor
    FOREIGN KEY (idTreinadorVencedor , idPokemonVencedor)
    REFERENCES pokemon_capturado (idtreinador , idpokemon)
    ON DELETE cascade
    ON UPDATE cascade,
  CONSTRAINT fk_treinador_pokemon_perdedor
    FOREIGN KEY (idTreinadorPerdedor , idPokemonPerdedor)
    REFERENCES pokemon_capturado (idtreinador , idpokemon)
    ON DELETE cascade
    ON UPDATE cascade
);


-- -----------------------------------------------------
-- Table pokemon_enfermaria
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS pokemon_enfermaria (
  idenfermaria INT NOT NULL,
  idtreinador INT NOT NULL,
  idpokemon INT NOT NULL,
  entrada timestamp,
  saida timestamp,
  PRIMARY KEY (idenfermaria, idtreinador, idpokemon),
  CONSTRAINT fk_enfermaria
    FOREIGN KEY (idenfermaria)
    REFERENCES enfermaria (idenfermaria)
    ON DELETE cascade
    ON UPDATE cascade,
  CONSTRAINT fk_treinador_pokemon
    FOREIGN KEY (idtreinador , idpokemon)
    REFERENCES pokemon_capturado (idtreinador , idpokemon)
    ON DELETE cascade
    ON UPDATE cascade
);

