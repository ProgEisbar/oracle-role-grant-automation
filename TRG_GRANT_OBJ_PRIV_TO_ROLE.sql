CREATE OR REPLACE TRIGGER SOPORTEDBA.TRG_GRANT_OBJ_PRIV_TO_ROLE
    AFTER CREATE
    ON DATABASE
BEGIN
    EXECUTE IMMEDIATE 'ALTER SESSION SET CURRENT_SCHEMA = SOPORTEDBA';

    EXECUTE IMMEDIATE 'ALTER SESSION SET NLS_DATE_FORMAT = ''DD/MM/YYYY''';

    -- Procesar el objeto creado
    DECLARE
        v_owner_ent         VARCHAR2 (128);
        v_owner_param         VARCHAR2 (128);
        v_object_name   VARCHAR2 (128);
        v_object_type   VARCHAR2 (128);
    BEGIN
        v_owner_ent := ORA_DICT_OBJ_OWNER;
        v_owner_param := ORA_DICT_OBJ_OWNER;
        v_object_name := ORA_DICT_OBJ_NAME;
        v_object_type := ORA_DICT_OBJ_TYPE;

        -- Solo procesar objetos de ENTIDAD 
        IF v_owner_ent LIKE '%ENTIDAD%'
        THEN
            -- Determinar el tipo de objeto y realizar las acciones correspondientes
            CASE v_object_type
                WHEN 'TABLE'
                THEN
                    -- Otorgar privilegios SELECT y DML a tablas
                    INSERT INTO ROLES_TO_GRANT (FECHA, MESSAGE, SP_NAME)
                             VALUES (
                                        SYSDATE - (3 / 24),
                                           'GRANT SELECT ON '
                                        || v_owner_ent
                                        || '.'
                                        || v_object_name
                                        || ' TO '
                                        || v_owner_ent
                                        || '_SELECT',
                                        'TRG_GRANT_OBJ_PRIV_TO_ROLE');

                    INSERT INTO ROLES_TO_GRANT (FECHA, MESSAGE, SP_NAME)
                             VALUES (
                                        SYSDATE - (3 / 24),
                                           'GRANT SELECT, INSERT, UPDATE, DELETE ON '
                                        || v_owner_ent
                                        || '.'
                                        || v_object_name
                                        || ' TO '
                                        || v_owner_ent
                                        || '_DML',
                                        'TRG_GRANT_OBJ_PRIV_TO_ROLE');

                    -- Crear sinónimo para tabla
                    INSERT INTO ROLES_TO_GRANT (FECHA, MESSAGE, SP_NAME)
                             VALUES (
                                        SYSDATE - (3 / 24),
                                           'CREATE OR REPLACE SYNONYM USER_SERVICES'
                                        || SUBSTR (v_owner_ent,8,3)
                                        || '.'
                                        || v_object_name
                                        || ' FOR '
                                        || v_owner_ent
                                        || '.'
                                        || v_object_name,
                                        'TRG_GRANT_OBJ_PRIV_TO_ROLE');
                WHEN 'VIEW'
                THEN
                    -- Otorgar privilegio SELECT a vistas
                    INSERT INTO ROLES_TO_GRANT (FECHA, MESSAGE, SP_NAME)
                             VALUES (
                                        SYSDATE - (3 / 24),
                                           'GRANT SELECT ON '
                                        || v_owner_ent
                                        || '.'
                                        || v_object_name
                                        || ' TO '
                                        || v_owner_ent
                                        || '_SELECT',
                                        'TRG_GRANT_OBJ_PRIV_TO_ROLE');

                    -- Crear sinónimo para vista
                    INSERT INTO ROLES_TO_GRANT (FECHA, MESSAGE, SP_NAME)
                             VALUES (
                                        SYSDATE - (3 / 24),
                                           'CREATE OR REPLACE SYNONYM USER_SERVICES'
                                        ||SUBSTR (v_owner_ent,8,3)
                                        || '.'
                                        || v_object_name
                                        || ' FOR '
                                        || v_owner_ent
                                        || '.'
                                        || v_object_name,
                                        'TRG_GRANT_OBJ_PRIV_TO_ROLE');
                WHEN 'SEQUENCE'
                THEN
                    -- Otorgar privilegio SELECT a secuencias
                    INSERT INTO ROLES_TO_GRANT (FECHA, MESSAGE, SP_NAME)
                             VALUES (
                                        SYSDATE - (3 / 24),
                                           'GRANT SELECT ON '
                                        || v_owner_ent
                                        || '.'
                                        || v_object_name
                                        || ' TO '
                                        || v_owner_ent
                                        || '_SELECT',
                                        'TRG_GRANT_OBJ_PRIV_TO_ROLE');

                    -- Crear sinónimo para secuencia
                    INSERT INTO ROLES_TO_GRANT (FECHA, MESSAGE, SP_NAME)
                             VALUES (
                                        SYSDATE - (3 / 24),
                                           'CREATE OR REPLACE SYNONYM USER_SERVICES'
                                        ||SUBSTR (v_owner_ent,8,3)
                                        || '.'
                                        || v_object_name
                                        || ' FOR '
                                        || v_owner_ent
                                        || '.'
                                        || v_object_name,
                                        'TRG_GRANT_OBJ_PRIV_TO_ROLE');
                WHEN 'FUNCTION'
                THEN
                    -- Otorgar privilegio EXECUTE a funciones
                    INSERT INTO ROLES_TO_GRANT (FECHA, MESSAGE, SP_NAME)
                             VALUES (
                                        SYSDATE - (3 / 24),
                                           'GRANT EXECUTE ON '
                                        || v_owner_ent
                                        || '.'
                                        || v_object_name
                                        || ' TO '
                                        || v_owner_ent
                                        || '_SELECT',
                                        'TRG_GRANT_OBJ_PRIV_TO_ROLE');

                    -- Crear sinónimo para función
                    INSERT INTO ROLES_TO_GRANT (FECHA, MESSAGE, SP_NAME)
                             VALUES (
                                        SYSDATE - (3 / 24),
                                           'CREATE OR REPLACE SYNONYM USER_SERVICES'
                                        ||SUBSTR (v_owner_ent,8,3)
                                        || '.'
                                        || v_object_name
                                        || ' FOR '
                                        || v_owner_ent
                                        || '.'
                                        || v_object_name,
                                        'TRG_GRANT_OBJ_PRIV_TO_ROLE');
                ELSE
                    -- Manejar otros tipos de objetos (opcional)
                    NULL;
            END CASE;
        END IF;
 -- Solo procesar objetos de PARAM 
        IF v_owner_param LIKE '%PARAM%'
        THEN
        v_owner_param := ORA_DICT_OBJ_OWNER;
            -- Determinar el tipo de objeto y realizar las acciones correspondientes
            CASE v_object_type
                WHEN 'TABLE'
                THEN
                    -- Otorgar privilegios SELECT y DML a tablas
                    INSERT INTO ROLES_TO_GRANT (FECHA, MESSAGE, SP_NAME)
                             VALUES (
                                        SYSDATE - (3 / 24),
                                           'GRANT SELECT ON '
                                        || v_owner_param
                                        || '.'
                                        || v_object_name
                                        || ' TO '
                                        || v_owner_param
                                        || '_SELECT',
                                        'TRG_GRANT_OBJ_PRIV_TO_ROLE');

                    INSERT INTO ROLES_TO_GRANT (FECHA, MESSAGE, SP_NAME)
                             VALUES (
                                        SYSDATE - (3 / 24),
                                           'GRANT SELECT, INSERT, UPDATE, DELETE ON '
                                        || v_owner_param
                                        || '.'
                                        || v_object_name
                                        || ' TO '
                                        || v_owner_param
                                        || '_DML',
                                        'TRG_GRANT_OBJ_PRIV_TO_ROLE');

                    -- Sinónimo USER_SERVICES para PARAM deshabilitado:
                    -- USER_SERVICES no tiene los roles PARAM_SELECT/PARAM_DML.
                    /*
                    INSERT INTO ROLES_TO_GRANT (FECHA, MESSAGE, SP_NAME)
                             VALUES (
                                        SYSDATE - (3 / 24),
                                           'CREATE OR REPLACE SYNONYM USER_SERVICES'
                                        || SUBSTR (v_owner_param,6,3)
                                        || '.'
                                        || v_object_name
                                        || ' FOR '
                                        || v_owner_param
                                        || '.'
                                        || v_object_name,
                                        'TRG_GRANT_OBJ_PRIV_TO_ROLE');
                    */
                WHEN 'VIEW'
                THEN
                    -- Otorgar privilegio SELECT a vistas
                    INSERT INTO ROLES_TO_GRANT (FECHA, MESSAGE, SP_NAME)
                             VALUES (
                                        SYSDATE - (3 / 24),
                                           'GRANT SELECT ON '
                                        || v_owner_param
                                        || '.'
                                        || v_object_name
                                        || ' TO '
                                        || v_owner_param
                                        || '_SELECT',
                                        'TRG_GRANT_OBJ_PRIV_TO_ROLE');

                    -- Sinónimo USER_SERVICES para PARAM deshabilitado:
                    -- USER_SERVICES no tiene los roles PARAM_SELECT/PARAM_DML.
                    /*
                    INSERT INTO ROLES_TO_GRANT (FECHA, MESSAGE, SP_NAME)
                             VALUES (
                                        SYSDATE - (3 / 24),
                                           'CREATE OR REPLACE SYNONYM USER_SERVICES'
                                        ||SUBSTR (v_owner_param,6,3)
                                        || '.'
                                        || v_object_name
                                        || ' FOR '
                                        || v_owner_param
                                        || '.'
                                        || v_object_name,
                                        'TRG_GRANT_OBJ_PRIV_TO_ROLE');
                    */
                WHEN 'SEQUENCE'
                THEN
                    -- Otorgar privilegio SELECT a secuencias
                    INSERT INTO ROLES_TO_GRANT (FECHA, MESSAGE, SP_NAME)
                             VALUES (
                                        SYSDATE - (3 / 24),
                                           'GRANT SELECT ON '
                                        || v_owner_param
                                        || '.'
                                        || v_object_name
                                        || ' TO '
                                        || v_owner_param
                                        || '_SELECT',
                                        'TRG_GRANT_OBJ_PRIV_TO_ROLE');

                    -- Sinónimo USER_SERVICES para PARAM deshabilitado:
                    -- USER_SERVICES no tiene los roles PARAM_SELECT/PARAM_DML.
                    /*
                    INSERT INTO ROLES_TO_GRANT (FECHA, MESSAGE, SP_NAME)
                             VALUES (
                                        SYSDATE - (3 / 24),
                                           'CREATE OR REPLACE SYNONYM USER_SERVICES'
                                        ||SUBSTR (v_owner_param,6,3)
                                        || '.'
                                        || v_object_name
                                        || ' FOR '
                                        || v_owner_param
                                        || '.'
                                        || v_object_name,
                                        'TRG_GRANT_OBJ_PRIV_TO_ROLE');
                    */
                WHEN 'FUNCTION'
                THEN
                    -- Otorgar privilegio EXECUTE a funciones
                    INSERT INTO ROLES_TO_GRANT (FECHA, MESSAGE, SP_NAME)
                             VALUES (
                                        SYSDATE - (3 / 24),
                                           'GRANT EXECUTE ON '
                                        || v_owner_param
                                        || '.'
                                        || v_object_name
                                        || ' TO '
                                        || v_owner_param
                                        || '_SELECT',
                                        'TRG_GRANT_OBJ_PRIV_TO_ROLE');

                    -- Sinónimo USER_SERVICES para PARAM deshabilitado:
                    -- USER_SERVICES no tiene los roles PARAM_SELECT/PARAM_DML.
                    /*
                    INSERT INTO ROLES_TO_GRANT (FECHA, MESSAGE, SP_NAME)
                             VALUES (
                                        SYSDATE - (3 / 24),
                                           'CREATE OR REPLACE SYNONYM USER_SERVICES'
                                        ||SUBSTR (v_owner_param,6,3)
                                        || '.'
                                        || v_object_name
                                        || ' FOR '
                                        || v_owner_param
                                        || '.'
                                        || v_object_name,
                                        'TRG_GRANT_OBJ_PRIV_TO_ROLE');
                    */
                ELSE
                    -- Manejar otros tipos de objetos (opcional)
                    NULL;
            END CASE;
        END IF;        

    END;
EXCEPTION
    WHEN OTHERS
    THEN
        PRC_Write_Error_log_execution (SYSDATE - (3 / 24),
                                       SQLCODE,
                                       SQLERRM,
                                       'TRG_GRANT_OBJ_PRIV_TO_ROLE',
                                       DBMS_UTILITY.format_error_backtrace,
                                       DBMS_UTILITY.format_error_stack);
END;
/


BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'SOPORTEDBA.JOB_ROLES_TO_GRANTS');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'SOPORTEDBA.JOB_ROLES_TO_GRANTS'
      ,start_date      => TO_TIMESTAMP_TZ('2025/04/14 09:00:00.000000 -03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=DAILY; BYDAY=MON,TUE,WED,THU,FRI; BYHOUR=10,12,15,17; BYMINUTE=0;BYSECOND=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'STORED_PROCEDURE'
      ,job_action      => 'PRC_EXEC_ROLE_GRANTS'
      ,comments        => 'Job para leer la tabla ROLES_TO_GRANT y ejecutar los grants pendientes.'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'SOPORTEDBA.JOB_ROLES_TO_GRANTS'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'SOPORTEDBA.JOB_ROLES_TO_GRANTS'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_RUNS);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'SOPORTEDBA.JOB_ROLES_TO_GRANTS'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'SOPORTEDBA.JOB_ROLES_TO_GRANTS'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'SOPORTEDBA.JOB_ROLES_TO_GRANTS'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'SOPORTEDBA.JOB_ROLES_TO_GRANTS'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'SOPORTEDBA.JOB_ROLES_TO_GRANTS'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'SOPORTEDBA.JOB_ROLES_TO_GRANTS'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'SOPORTEDBA.JOB_ROLES_TO_GRANTS'
     ,attribute => 'RESTART_ON_RECOVERY'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'SOPORTEDBA.JOB_ROLES_TO_GRANTS'
     ,attribute => 'RESTART_ON_FAILURE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'SOPORTEDBA.JOB_ROLES_TO_GRANTS'
     ,attribute => 'STORE_OUTPUT'
     ,value     => TRUE);
END;
/


DECLARE
    v_table_exists  NUMBER;
    v_column_exists NUMBER;
BEGIN
    SELECT COUNT(*)
      INTO v_table_exists
      FROM ALL_TABLES
     WHERE OWNER = 'SOPORTEDBA'
       AND TABLE_NAME = 'ROLES_TO_GRANT';

    SELECT COUNT(*)
      INTO v_column_exists
      FROM ALL_TAB_COLUMNS
     WHERE OWNER = 'SOPORTEDBA'
       AND TABLE_NAME = 'ROLES_TO_GRANT'
       AND COLUMN_NAME = 'ESTADO';

    IF v_table_exists > 0 AND v_column_exists = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE SOPORTEDBA.ROLES_TO_GRANT ADD (ESTADO VARCHAR2(30 BYTE) DEFAULT ''Pendiente de ejecucion'' NOT NULL)';
        EXECUTE IMMEDIATE 'ALTER TABLE SOPORTEDBA.ROLES_TO_GRANT ADD CONSTRAINT CHK_ROLES_TO_GRANT_ESTADO CHECK (ESTADO IN (''Pendiente de ejecucion'', ''Procesado''))';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN SOPORTEDBA.ROLES_TO_GRANT.ESTADO IS ''Estado de ejecucion del privilegio''';
    END IF;
END;
/


CREATE OR REPLACE PACKAGE SOPORTEDBA.PKG_DDL_GUARD AS
    PROCEDURE ENABLE_ROLE_GRANTS;
    PROCEDURE DISABLE_ROLE_GRANTS;
    FUNCTION IS_ROLE_GRANTS_ALLOWED RETURN BOOLEAN;
END;
/

CREATE OR REPLACE PACKAGE BODY SOPORTEDBA.PKG_DDL_GUARD AS
    g_allow_role_grants BOOLEAN := FALSE;

    PROCEDURE ENABLE_ROLE_GRANTS AS
    BEGIN
        g_allow_role_grants := TRUE;
    END;

    PROCEDURE DISABLE_ROLE_GRANTS AS
    BEGIN
        g_allow_role_grants := FALSE;
    END;

    FUNCTION IS_ROLE_GRANTS_ALLOWED RETURN BOOLEAN AS
    BEGIN
        RETURN g_allow_role_grants;
    END;
END;
/


--------------------------------------------------------------------------------
-- Agregar al inicio de SOPORTEDBA.TRG_BLOCK_MANUAL_DDL, antes de levantar
-- ORA-20001, para permitir solo los DDL ejecutados por PRC_EXEC_ROLE_GRANTS:
--
-- IF SOPORTEDBA.PKG_DDL_GUARD.IS_ROLE_GRANTS_ALLOWED THEN
--     RETURN;
-- END IF;
--------------------------------------------------------------------------------


CREATE OR REPLACE PROCEDURE SOPORTEDBA.PRC_EXEC_ROLE_GRANTS
AS
BEGIN
DECLARE        

    v_sql_stmt VARCHAR2(4000);

BEGIN

    EXECUTE IMMEDIATE 'alter session set current_schema = SOPORTEDBA';
    EXECUTE IMMEDIATE 'alter session set nls_Date_format=''dd/mm/yyyy''';

    FOR to_grant IN (
        SELECT ROWID AS GRANT_ROWID,
               MESSAGE
        FROM SOPORTEDBA.ROLES_TO_GRANT
        WHERE FECHA >= TRUNC(SYSDATE - (3 / 24))
        AND FECHA < TRUNC(SYSDATE - (3 / 24)) + 1
        AND NVL(ESTADO, 'Pendiente de ejecucion') = 'Pendiente de ejecucion'
        ORDER BY FECHA
    )
    LOOP
        BEGIN
            
            v_sql_stmt := to_grant.MESSAGE;
			BEGIN
            DBMS_OUTPUT.PUT_LINE('Ejecutando: ' || v_sql_stmt);
            SOPORTEDBA.PKG_DDL_GUARD.ENABLE_ROLE_GRANTS;
            EXECUTE IMMEDIATE v_sql_stmt;
            SOPORTEDBA.PKG_DDL_GUARD.DISABLE_ROLE_GRANTS;

            UPDATE SOPORTEDBA.ROLES_TO_GRANT
               SET ESTADO = 'Procesado'
             WHERE ROWID = to_grant.GRANT_ROWID;
			EXCEPTION
                WHEN OTHERS
                THEN
                    SOPORTEDBA.PKG_DDL_GUARD.DISABLE_ROLE_GRANTS;
                    PRC_Write_Error_log_execution (SYSDATE,SQLCODE,SQLERRM,'PRC_EXEC_ROLE_GRANTS',DBMS_UTILITY.format_error_backtrace,SUBSTR(DBMS_UTILITY.format_error_stack || ' - Grant Fallo en: ' || v_sql_stmt, 1, 300));
            END;

        EXCEPTION
            WHEN OTHERS THEN
                SOPORTEDBA.PKG_DDL_GUARD.DISABLE_ROLE_GRANTS;
                PRC_Write_Error_log_execution(sysdate, SQLCODE, SQLERRM, 'PRC_EXEC_ROLE_GRANTS', dbms_utility.format_error_backtrace, SUBSTR(dbms_utility.format_error_stack || ' - Grant Fallo en: ' || v_sql_stmt, 1, 300));
        END;
    END LOOP;
    COMMIT;
END;
END;
/


CREATE TABLE SOPORTEDBA.ROLES_TO_GRANT
(
  FECHA    DATE,
  MESSAGE  VARCHAR2(300 CHAR),
  SP_NAME  VARCHAR2(100 BYTE),
  ESTADO   VARCHAR2(30 BYTE) DEFAULT 'Pendiente de ejecucion' NOT NULL,
  CONSTRAINT CHK_ROLES_TO_GRANT_ESTADO
    CHECK (ESTADO IN ('Pendiente de ejecucion', 'Procesado'))
)
TABLESPACE USERS
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOLOGGING 
NOCOMPRESS 
NOCACHE;

COMMENT ON COLUMN SOPORTEDBA.ROLES_TO_GRANT.FECHA IS 'Fecha de ejecucion';

COMMENT ON COLUMN SOPORTEDBA.ROLES_TO_GRANT.MESSAGE IS 'Privilegio a otorgar';

COMMENT ON COLUMN SOPORTEDBA.ROLES_TO_GRANT.SP_NAME IS 'Nombre del stored procedure';

COMMENT ON COLUMN SOPORTEDBA.ROLES_TO_GRANT.ESTADO IS 'Estado de ejecucion del privilegio';
