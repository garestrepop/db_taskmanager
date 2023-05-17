SPOOL  log_pkregisteraudit.txt

ACCEPT schema_name PROMPT 'Ingrese el nombre del esquema: '

--ALTER SESSION SET CURRENT_SCHEMA=&schema_name;

Prompt Package PK_REGISTERAUDIT;
CREATE OR REPLACE PACKAGE &schema_name..pk_RegisterAudit
IS
/*
    ************************************************************************
    Intellectual property  Gustavo Alberto Restrepo Peláez
    
    File            :   pk_RegisterAudit.pks
    Description     :   This package register change from entity or procedures.
    
    
    Observations    :
    
    Author          :   Gustavo Alberto Restrepo Peláez.
    Date            :   2023-May-17
    
    History of Modifications
    **************************************************************************
    Date          Author     Modifications
    2023-May-17   GARP       v.0.0.0. Creacion paquete.
    
    **************************************************************************
*/
    --
    FUNCTION fnVERSION RETURN VARCHAR2;
    
    --
    PROCEDURE prRegisterAudit (irecAudit IN E_AUDIT%ROWTYPE);

END;
/
SHOW ERRORS;


Prompt Synonym PK_REGISTERAUDIT;
CREATE OR REPLACE PUBLIC SYNONYM PK_REGISTERAUDIT FOR &schema_name..PK_REGISTERAUDIT;

Prompt Package Body PK_REGISTERAUDIT;
CREATE OR REPLACE PACKAGE BODY &schema_name..pk_RegisterAudit
IS
/*
    ************************************************************************
    Intellectual property  Gustavo Alberto Restrepo Peláez
    
    File            :   pk_RegisterAudit.pkb
    Description     :   This package register change from entity or procedures.
    
    
    Observations    :
    
    Author          :   Gustavo Alberto Restrepo Peláez.
    Date            :   2023-May-17
    
    History of Modifications
    **************************************************************************
    Date          Author     Modifications
    2023-May-17   GARP       v.0.0.0. Creacion paquete.
    
    **************************************************************************
*/
    
    cvVersion         CONSTANT  VARCHAR2(10) := 'v.0.0.0';
    
    --    
    FUNCTION fnVERSION
    RETURN VARCHAR2
    IS
    BEGIN
        RETURN cvVersion;
    END fnVERSION;
    
    --
    PROCEDURE prRegisterAudit (irecAudit IN E_AUDIT%ROWTYPE)
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        INSERT INTO E_AUDIT
            VALUES irecAudit;
        COMMIT;
      EXCEPTION 
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE ('Error code : ' || SQLCODE);
            DBMS_OUTPUT.PUT_LINE ('Error message : ' || SQLERRM);
    END prRegisterAudit;

END;
/
SHOW ERRORS;


Prompt Synonym PK_REGISTERAUDIT;
CREATE OR REPLACE PUBLIC SYNONYM PK_REGISTERAUDIT FOR &schema_name..PK_REGISTERAUDIT;

SPOOL OFF