DECLARE
    cdata CLOB;
BEGIN
--
    pk_manageruser.prGetUser(cdata);    
    DBMS_OUTPUT.PUT_LINE(SUBSTR(cdata,0,4000));
--           
END;

DECLARE
    recUser E_USER%ROWTYPE;
BEGIN
--
    recUser := NULL;
    
    recUser.USERNAME         := 'LINA.TORO';   
    recUser.USERID           := 384577153;    
    recUser.STATEID          := 'ENABLED';
    recUser.PHONE            := '3184523639';
    recUser.NAME             := 'LINA';
    recUser.MUNICIPALITYID   := 2;
    recUser.LASTNAME         := 'TORO';
    recUser.EMAIL            := 'lina.toro@email.com';
    recUser.CREATEDAT        := SYSDATE;
    recUser.COUNTRYID        := 1;
    recUser.ADDRESS          := 'CRA 45 NRO 35-52';

    pk_manageruser.prCreateUser(recUser);        
--           
END;

