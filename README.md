# db_taskmanager
It's a database for task manager.   It used ORACLE SQL, PL/SQL.

This project is to demonstrate my knowledge in PL/SQL

## Prerequisites
1. You must a Oracle Database higher than 19c

## Install
1. Clone this respository
2. Put on ..\scripts
3. Connect to Oracle Database using sqlplus
        sqlplus user/password@yourOracleDataBase
4. Execute scripts\createmodel.sql    
5. Execute scripts\createpkregisteraudit.sql    
6. Execute scripts\createpkmanageruser.sql    
7. Execute scripts\createtriggertaskaudit.sql    
8. Execute scripts\createviewprojectuser.sql

### Example to execute in sqlplus
    SQL> @createmodel.sql   

## This Application have:
* A Package whit CRUD of Users.
* A Package to record audit
* A view to select projects by users.

## Examples

### Example 1.
This anonymous procedure creates a user using pk_manageruser.prCreateUser procedure

```PLSQL
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
```

### Example 2.
This anonymous procedure retrieves the information of all users in json format

```PLSQL
DECLARE
    cdata CLOB;
BEGIN
--
    pk_manageruser.prGetUser(cdata);    
    DBMS_OUTPUT.PUT_LINE(SUBSTR(cdata,0,4000));
--           
END;
```

## Enjoy this application using PLSQL.
