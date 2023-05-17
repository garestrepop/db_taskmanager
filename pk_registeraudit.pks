CREATE OR REPLACE PACKAGE GRESTRP.pk_RegisterAudit
IS
/*
    ************************************************************************
    Intellectual property  Gustavo Alberto Restrepo Peláez
    
    File            :   pk_registeraudit.pks
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