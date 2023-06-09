Prompt Table E_MUNICIPALITY;
CREATE TABLE &SCHEMA..E_MUNICIPALITY
(
  MUNICIPALITYID  NUMBER(9)                     NOT NULL,
  NAME            VARCHAR2(256 BYTE)            NOT NULL,
  COUNTRYID       NUMBER(9)                     NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE;


Prompt Index E_MUNICIPALITY_PK;
CREATE UNIQUE INDEX &SCHEMA..E_MUNICIPALITY_PK ON &SCHEMA..E_MUNICIPALITY
(MUNICIPALITYID)
LOGGING;

ALTER TABLE &SCHEMA..E_MUNICIPALITY ADD (
  CONSTRAINT E_MUNICIPALITY_PK
  PRIMARY KEY
  (MUNICIPALITYID)
  USING INDEX &SCHEMA..E_MUNICIPALITY_PK
  ENABLE VALIDATE);


Prompt Synonym E_MUNICIPALITY;
CREATE OR REPLACE PUBLIC SYNONYM E_MUNICIPALITY FOR &SCHEMA..E_MUNICIPALITY;


ALTER TABLE &SCHEMA..E_MUNICIPALITY ADD (
  CONSTRAINT MUNICIPALITY_COUNTRY_FK 
  FOREIGN KEY (COUNTRYID) 
  REFERENCES &SCHEMA..E_COUNTRY (COUNTRYID)
  ENABLE VALIDATE);