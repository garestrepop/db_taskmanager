CREATE OR REPLACE PACKAGE GRESTRP.pk_ManagerUser AUTHID DEFINER
IS
/*
    ************************************************************************
    Intellectual property  Gustavo Alberto Restrepo Peláez
    
    File            :   pk_manageruser
    Description     :   This package manager User Info.
    
    
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
    PROCEDURE prCreateUser (irecUser IN E_USER%ROWTYPE);
    
    --
    PROCEDURE prDeleteUser (ivUserId IN E_USER.USERID%TYPE);
    
    --
    PROCEDURE prUpdateUser (irecUser IN E_USER%ROWTYPE);
    
    --  This procedure get all user to json structure.
    PROCEDURE prGetUser (ocUsers OUT CLOB);
    
END;
/