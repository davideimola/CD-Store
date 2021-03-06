--
--

-- DOMINI
DROP DOMAIN IF EXISTS PAGAMENTO CASCADE;
CREATE DOMAIN PAGAMENTO AS CHAR (5)
	CHECK (VALUE IN ('BONIF','CARTA','PAYPA'));

DROP DOMAIN IF EXISTS CONSEGNA CASCADE;
CREATE DOMAIN CONSEGNA AS CHAR (5)
	CHECK (VALUE IN ('CORRI','POSTA'));

-- TABELLE
DROP TABLE IF EXISTS CLIENTE CASCADE;
CREATE TABLE CLIENTE (
	id SERIAL PRIMARY KEY,
	user_id VARCHAR UNIQUE NOT NULL,
	pwd VARCHAR NOT NULL,
	cod_fiscale CHAR(16) UNIQUE NOT NULL,
	nome VARCHAR NOT NULL,
	cognome VARCHAR NOT NULL,
	citta_residenza VARCHAR NOT NULL,
	telefono VARCHAR NOT NULL,
	cellulare VARCHAR
);

DROP TABLE IF EXISTS ORDINE CASCADE;
CREATE TABLE ORDINE (
	id SERIAL PRIMARY KEY,
	id_cliente SERIAL REFERENCES CLIENTE(id) ON UPDATE CASCADE ON DELETE SET NULL,
	prezzo DECIMAL(5,2) NOT NULL DEFAULT 0.00,
	data_acquisto DATE NOT NULL,
	ora_acquisto  TIME NOT NULL,
	indirizzo_ip VARCHAR(15),
	modalita_pagamento PAGAMENTO NOT NULL,
	modalita_consegna  CONSEGNA  NOT NULL
);

DROP TABLE IF EXISTS CARRELLO CASCADE;
CREATE TABLE CARRELLO (
	id SERIAL PRIMARY KEY,
	id_cliente SERIAL REFERENCES CLIENTE(id) ON UPDATE CASCADE ON DELETE SET NULL
);

DROP TABLE IF EXISTS ARTISTA CASCADE;
CREATE TABLE ARTISTA (
	id SERIAL PRIMARY KEY,
	nome VARCHAR UNIQUE NOT NULL
);

DROP TABLE IF EXISTS GENERE CASCADE;
CREATE TABLE GENERE (
	id SERIAL PRIMARY KEY,
	nome VARCHAR UNIQUE NOT NULL
);

DROP TABLE IF EXISTS MUSICISTA CASCADE;
CREATE TABLE MUSICISTA (
	id SERIAL PRIMARY KEY,
	nome_arte VARCHAR UNIQUE NOT NULL,
	id_genere SERIAL REFERENCES GENERE(id) ON UPDATE CASCADE ON DELETE SET NULL,
	anno_nascita DECIMAL(4)
);

DROP TABLE IF EXISTS ARTISTA_MUSICISTA CASCADE;
CREATE TABLE ARTISTA_MUSICISTA (
	id SERIAL PRIMARY KEY,
	id_artista SERIAL REFERENCES ARTISTA(id) ON UPDATE CASCADE ON DELETE SET NULL,
	id_musicista SERIAL REFERENCES MUSICISTA(id) ON UPDATE CASCADE ON DELETE SET NULL,
	UNIQUE(id_artista,id_musicista)
);

DROP TABLE IF EXISTS DISCO CASCADE;
CREATE TABLE DISCO (
	id SERIAL PRIMARY KEY,
	titolo VARCHAR NOT NULL,
	prezzo DECIMAL(5,2) NOT NULL,
	data_sito DATE NOT NULL,
	id_artista SERIAL REFERENCES ARTISTA(id) ON UPDATE CASCADE ON DELETE SET NULL,
	descrizione VARCHAR,
	quantita INTEGER,
	foto VARCHAR
);

DROP TABLE IF EXISTS TITOLO CASCADE;
CREATE TABLE TITOLO (
	id SERIAL PRIMARY KEY,
	id_disco SERIAL REFERENCES DISCO(id) ON UPDATE CASCADE ON DELETE SET NULL,
	nome_canzone VARCHAR UNIQUE NOT NULL
);

DROP TABLE IF EXISTS DISCO_GENERE CASCADE;
CREATE TABLE DISCO_GENERE (
	id SERIAL PRIMARY KEY,
	id_disco SERIAL REFERENCES DISCO(id) ON UPDATE CASCADE ON DELETE SET NULL,
	id_genere SERIAL REFERENCES GENERE(id) ON UPDATE CASCADE ON DELETE SET NULL,
	UNIQUE(id_disco,id_genere)
);

DROP TABLE IF EXISTS CARRELLO_DISCO CASCADE;
CREATE TABLE CARRELLO_DISCO (
	id SERIAL PRIMARY KEY,
	id_carrello SERIAL REFERENCES CARRELLO(id) ON UPDATE CASCADE ON DELETE SET NULL,
	id_disco SERIAL REFERENCES DISCO(id) ON UPDATE CASCADE ON DELETE SET NULL
);

DROP TABLE IF EXISTS ORDINE_DISCO CASCADE;
CREATE TABLE ORDINE_DISCO (
	id SERIAL PRIMARY KEY,
	id_ordine SERIAL REFERENCES ORDINE(id) ON UPDATE CASCADE ON DELETE SET NULL,
	id_disco SERIAL REFERENCES DISCO(id) ON UPDATE CASCADE ON DELETE SET NULL
);

DROP TABLE IF EXISTS STRUMENTO CASCADE;
CREATE TABLE STRUMENTO (
	id SERIAL PRIMARY KEY,
	nome VARCHAR UNIQUE NOT NULL
);

DROP TABLE IF EXISTS MUSICISTA_STRUMENTO CASCADE;
CREATE TABLE MUSICISTA_STRUMENTO (
	id SERIAL PRIMARY KEY,
	id_musicista SERIAL REFERENCES MUSICISTA(id) ON UPDATE CASCADE ON DELETE SET NULL,
	id_strumento SERIAL REFERENCES STRUMENTO(id) ON UPDATE CASCADE ON DELETE SET NULL,
	UNIQUE(id_musicista,id_strumento)
);

DROP TABLE IF EXISTS SUONA CASCADE;
CREATE TABLE SUONA (
	id SERIAL PRIMARY KEY,
	id_disco SERIAL REFERENCES DISCO(id) ON UPDATE CASCADE ON DELETE SET NULL,
	id_musicista SERIAL REFERENCES MUSICISTA(id) ON UPDATE CASCADE ON DELETE SET NULL,
	id_strumento SERIAL REFERENCES STRUMENTO(id) ON UPDATE CASCADE ON DELETE SET NULL,
	UNIQUE(id_disco,id_musicista,id_strumento)
);
