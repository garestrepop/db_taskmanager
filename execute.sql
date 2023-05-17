SET APPINFO ON
SET ECHO OFF
SET SERVEROUTPUT ON
SET TIMING ON
SET VERIFY OFF
SET HEADING OFF 
SET FEEDBACK OFF
SET TERMOUT ON

PROMPT ######################################################
PROMPT ****            Inicia aplica general             ****
PROMPT ######################################################
PROMPT

PROMPT ejecutando createmodel.sql
@createmodel.sql

PROMPT ejecutando createpkregisteraudit.sql
@createpkregisteraudit.sql

PROMPT ejecutando createtriggertaskaudit.sql
@createtriggertaskaudit.sql

PROMPT ejecutando createpkmanageruser.sql
@createpkmanageruser.sql

PROMPT ejecutando createviewprojectuser.sql
@createviewprojectuser.sql

PROMPT
PROMPT ######################################################
PROMPT ****            Termina aplica general            ****
PROMPT ######################################################

EXIT