SPOOL  log_viewprojectuser.txt

ACCEPT schema_name PROMPT 'Ingrese el nombre del esquema: '

PROMPT View V_PROJECTUSER;

CREATE OR REPLACE FORCE VIEW &schema_name..V_PROJECTUSER
(
    USERID,
    NAME,
    LASTNAME,
    USERNAME,
    COUNTRY,
    MUNICIPALITY,
    ADDRESS,
    PHONE,
    EMAIL,
    STATE_USER,
    USER_CREATEDAT,
    PROJECTID,
    NAME_PROJECT,
    STARTDATE,
    ENDDATE,
    STATE_PROJECT,
    PROJECT_CREATEDAT
)
BEQUEATH DEFINER
AS
    SELECT U.USERID,
           U.NAME,
           U.LASTNAME,
           U.USERNAME,
           C.NAME          AS COUNTRY,
           M.NAME          AS MUNICIPALITY,
           U.ADDRESS,
           U.PHONE,
           U.EMAIL,
           U.STATEID       AS STATE_USER,
           U.CREATEDAT     AS USER_CREATEDAT,
           P.PROJECTID,
           P.NAME          AS NAME_PROJECT,
           P.STARTDATE,
           P.ENDDATE,
           P.STATEID       STATE_PROJECT,
           P.CREATEDAT     AS PROJECT_CREATEDAT
      FROM E_USER          U,
           E_COUNTRY       C,
           E_MUNICIPALITY  M,
           E_PROJECT       P
     WHERE     U.USERID = P.USERID
           AND U.COUNTRYID = C.COUNTRYID
           AND U.MUNICIPALITYID = M.MUNICIPALITYID;


Prompt Synonym V_PROJECTUSER;
CREATE OR REPLACE PUBLIC SYNONYM V_PROJECTUSER FOR &schema_name..V_PROJECTUSER;

SPOOL OFF