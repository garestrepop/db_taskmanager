CREATE OR REPLACE PACKAGE BODY GRESTRP.pk_RegisterAudit
IS
/*
    ************************************************************************
    Intellectual property  Gustavo Alberto Restrepo Peláez
    
    File            :   pk_registeraudit.pkb
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