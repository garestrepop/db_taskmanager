CREATE OR REPLACE PACKAGE BODY GRESTRP.pk_ManagerUser
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
    
    cvVersion         CONSTANT  VARCHAR2(10) := 'v.0.0.0';
    
    --    
    FUNCTION fnVERSION
    RETURN VARCHAR2
    IS
    BEGIN
        RETURN cvVersion;
    END fnVERSION;
    
    --
    PROCEDURE prCreateUser (irecUser IN E_USER%ROWTYPE)
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        INSERT INTO E_USER
            VALUES irecUser;
        COMMIT;
      EXCEPTION 
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE ('Error code : ' || SQLCODE);
            DBMS_OUTPUT.PUT_LINE ('Error message : ' || SQLERRM);
    END prCreateUser;
    
    --
    PROCEDURE prDeleteUser (ivUserId IN E_USER.USERID%TYPE)
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;
        
        CURSOR cuUser
        IS
        SELECT COUNT(USERID)
        FROM   E_USER
        WHERE  USERID = ivUserId;
        
        vUserCount NUMBER := 0;
               
    BEGIN
        --
        OPEN cuUser;
        --
            FETCH cuUser INTO vUserCount;
            --            
            IF cuUser%ROWCOUNT > 0 THEN
                --  Logic Delete,  The register not deleted of DataBase.
                UPDATE E_USER            
                SET    STATEID   = 'DELETED', 
                       UPDATEDAT = SYSDATE
                WHERE  USERID    = ivUserId;
                --                
                COMMIT;
            END IF;
        --                
        CLOSE cuUser;
        --        
      EXCEPTION 
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE ('Error code : ' || SQLCODE);
            DBMS_OUTPUT.PUT_LINE ('Error message : ' || SQLERRM);
    END prDeleteUser;
    
     --
    PROCEDURE prUpdateUser (irecUser IN E_USER%ROWTYPE)
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;
        
        CURSOR cuUser
        IS
        SELECT COUNT(USERID)
        FROM   E_USER
        WHERE  USERID = irecUser.USERID
        AND    STATEID NOT IN ('DELETED');
        
        vUserCount NUMBER := 0;
               
    BEGIN
        --
        OPEN cuUser;
            --
            FETCH cuUser INTO vUserCount;
                        
            IF cuUser%ROWCOUNT > 0 THEN
            --                
                UPDATE E_USER            
                 SET  UPDATEDAT      = SYSDATE
                     ,STATEID        = irecUser.STATEID
                     ,PHONE          = irecUser.PHONE          
                     ,NAME           = irecUser.NAME           
                     ,MUNICIPALITYID = irecUser.MUNICIPALITYID 
                     ,LASTNAME       = irecUser.LASTNAME       
                     ,EMAIL          = irecUser.EMAIL          
                     ,CREATEDAT      = irecUser.CREATEDAT      
                     ,COUNTRYID      = irecUser.COUNTRYID      
                     ,ADDRESS        = irecUser.ADDRESS        
                WHERE USERID = irecUser.USERID;
                               
                COMMIT;
            END IF;
        --                
        CLOSE cuUser;
        --        
      EXCEPTION 
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE ('Error code : ' || SQLCODE);
            DBMS_OUTPUT.PUT_LINE ('Error message : ' || SQLERRM);
    END prUpdateUser;
    
    --  This procedure get all user to json structure.
    PROCEDURE prGetUser (ocUsers OUT CLOB)
    IS
        --
        CURSOR cuUser
        IS
        SELECT
             USERNAME
            ,USERID
            ,UPDATEDAT
            ,STATEID
            ,PHONE
            ,U.NAME AS NAME
            ,M.NAME AS MUNICIPALITY
            ,LASTNAME
            ,EMAIL
            ,CREATEDAT
            ,M.NAME AS COUNTRY
            ,ADDRESS
        FROM   E_USER U INNER JOIN 
                E_COUNTRY C ON U.COUNTRYID = C.COUNTRYID INNER JOIN 
                    E_MUNICIPALITY M ON U.MUNICIPALITYID = M.MUNICIPALITYID;  
        --            
        joUser      JSON_OBJECT_T;
        jeUser      JSON_ELEMENT_T;
        jaUsers     JSON_ARRAY_T  := NEW JSON_ARRAY_T;
                                                                                     
    BEGIN                         
        --    
        FOR r IN cuUser
        LOOP
            --        
            joUser    := NEW JSON_OBJECT_T;
            --
            joUser.PUT('userid'       ,r.USERID      );     
            joUser.PUT('username'     ,r.USERNAME    );
            joUser.PUT('name'         ,r.NAME        );
            joUser.PUT('lastname'     ,r.LASTNAME    );
            joUser.PUT('municipality' ,r.MUNICIPALITY);
            joUser.PUT('country'      ,r.COUNTRY     );      
            joUser.PUT('address'      ,r.ADDRESS     );
            joUser.PUT('phone'        ,r.PHONE       );
            joUser.PUT('email'        ,r.EMAIL       );
            joUser.PUT('stateid'      ,r.STATEID     );
            joUser.PUT('createdat'    ,r.CREATEDAT   );     
            --            
            jeUser := joUser;
            --
            jaUsers.APPEND(jeUser);
            --                 
        END LOOP;
        --                      
        ocUsers := '{'||jaUsers.TO_CLOB||'}';  
        --        
      EXCEPTION 
        WHEN OTHERS THEN       
            DBMS_OUTPUT.PUT_LINE ('Error code : ' || SQLCODE);
            DBMS_OUTPUT.PUT_LINE ('Error message : ' || SQLERRM);
    END prGetUser;

END;
/