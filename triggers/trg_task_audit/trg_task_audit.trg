CREATE OR REPLACE TRIGGER GRESTRP.TRG_TASK_AUDIT
AFTER DELETE OR INSERT OR UPDATE
ON "GRESTRP"."E_TASK"
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       TRG_TASK_AUDIT
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        17/05/2023      GRESTRP.      1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     TRG_TASK_AUDIT
      File       :     trg_task_audit.trg
      Sysdate:         17/05/2023
      Date and Time:   17/05/2023, 9:12:09 a. m., and 17/05/2023 9:12:09 a. m.
      Username:        GRESTRP.(set in TOAD Options, Proc Templates)
      Table Name:      E_TASK (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/

    recAudit E_AUDIT%ROWTYPE;

    joData   JSON_OBJECT_T;

    vValorNew E_AUDIT.VALUENEW%TYPE;
    vValorOld E_AUDIT.VALUEOLD%TYPE;

BEGIN
    --
    joData   := NEW JSON_OBJECT_T;

    joData.put('userid'   ,:NEW.USERID);
    joData.put('taskid'   ,:NEW.TASKID);
    joData.put('name'     ,:NEW.NAME);
    joData.put('gloss'    ,:NEW.GLOSS);
    joData.put('projectid',:NEW.PROJECTID);
    joData.put('stateid'  ,:NEW.STATEID);
    joData.put('createdat',:NEW.CREATEDAT);
    joData.put('updatedat',:NEW.UPDATEDAT);

    vValorNew := joData.TO_STRING;
    --
    joData   := NEW JSON_OBJECT_T;

    joData.put('userid'   ,:OLD.USERID);
    joData.put('taskid'   ,:OLD.TASKID);
    joData.put('name'     ,:OLD.NAME);
    joData.put('gloss'    ,:OLD.GLOSS);
    joData.put('projectid',:OLD.PROJECTID);
    joData.put('stateid'  ,:OLD.STATEID);
    joData.put('createdat',:OLD.CREATEDAT);
    joData.put('updatedat',:OLD.UPDATEDAT);

    vValorOld := joData.TO_STRING;
    --

    recAudit := NULL;

    recAudit.AUDITID    := secauditid.NEXTVAL;
    recAudit.TABLENAME  := 'E_TASK';
    recAudit.OBJECTEXECUTE := 'TRG_TASK_AUDIT';
    recAudit.OPERATION  := 'INSERT';
    recAudit.MODULE     := 'TASK';
    recAudit.CREATEAT   := SYSDATE;
    --
    CASE
        WHEN INSERTING THEN
            --
            recAudit.VALUENEW := vValorNew;
            --
            pk_RegisterAudit.prRegisterAudit(recAudit);
            --
        WHEN UPDATING THEN
            --
            recAudit.VALUEOLD := vValorOld;
            recAudit.VALUENEW := vValorNew;
            --
            pk_RegisterAudit.prRegisterAudit(recAudit);
            --
        WHEN DELETING THEN
            --
            recAudit.VALUEOLD := vValorOld;
            --
            pk_RegisterAudit.prRegisterAudit(recAudit);
            --
        ELSE
            NULL;
    END CASE;
    --
   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END TRG_TASK_AUDIT;
/
SHOW ERRORS;
/