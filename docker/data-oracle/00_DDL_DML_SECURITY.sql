-- **************************************************************************************************************
-- *  NAME:         00_DDL_DB_SECURITY                                                                         *
-- *  DATE:         2020-12-01                                                                                  *
-- *  AUTOR:        PEDRO QUIJADA                                                         *
-- *  DESCRIPTION:  SQL SENTENCES TO GENERATE THE CGTS_SECURITY DATABASE MODEL                                   *
-- *  VERSION:      v1.0                                                                                     *
-- **************************************************************************************************************
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

DECLARE
    COUNT_USERS     INTEGER := 0;
    COUNT_DATA      INTEGER := 0;
    COUNT_INDEX     INTEGER := 0;
    v_err_code      NUMBER;
    v_err_msg       VARCHAR2(255);
BEGIN
    SELECT COUNT(*) INTO COUNT_USERS FROM dba_users Where USERNAME='CGTS_SECURITY';
    IF COUNT_USERS > 0 THEN
        EXECUTE IMMEDIATE 'DROP USER CGTS_SECURITY CASCADE';
    END IF;

    SELECT COUNT(*) INTO COUNT_DATA FROM dba_tablespaces WHERE tablespace_name = 'SEC_DATA';
    SELECT COUNT(*) INTO COUNT_INDEX FROM dba_tablespaces WHERE tablespace_name = 'SEC_INDEX';

    IF COUNT_DATA>0 THEN
        EXECUTE IMMEDIATE 'DROP TABLESPACE         SEC_DATA        INCLUDING CONTENTS AND DATAFILES';
    END IF;
    IF COUNT_INDEX>0 THEN
        EXECUTE IMMEDIATE 'DROP TABLESPACE         SEC_INDEX       INCLUDING CONTENTS AND DATAFILES';
    END IF;

    EXCEPTION
        WHEN OTHERS THEN
            v_err_code := SQLCODE;
            v_err_msg := SQLERRM;
            DBMS_OUTPUT.PUT_LINE('The program ended because of a runtime exception.');
            DBMS_OUTPUT.PUT_LINE('Error Code: '||v_err_code);
            DBMS_OUTPUT.PUT_LINE('Error Message: '||v_err_msg);
END;
/

------------------------------------------------------------------------------------
-- DDL for TABLESPACE
------------------------------------------------------------------------------------
CREATE TABLESPACE       SEC_DATA    DATAFILE 'sec_data.dbf'         SIZE 32M AUTOEXTEND ON;
CREATE TABLESPACE       SEC_INDEX   DATAFILE 'sec_index.dbf'        SIZE 32M AUTOEXTEND ON;

------------------------------------------------------------------------------------
-- DDL for USER
------------------------------------------------------------------------------------
CREATE USER     CGTS_SECURITY     IDENTIFIED BY   Sec738;

ALTER USER      CGTS_SECURITY     QUOTA UNLIMITED         ON SEC_DATA;
ALTER USER      CGTS_SECURITY     QUOTA UNLIMITED         ON SEC_INDEX;
ALTER USER      CGTS_SECURITY     DEFAULT TABLESPACE      SEC_DATA;

GRANT           CONNECT, RESOURCE   TO CGTS_SECURITY;

ALTER USER CGTS_SECURITY DEFAULT ROLE ALL;

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
-- TABLES
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
-- DDL for TABLA CGTS_SECURITY.SYS_MODULE
------------------------------------------------------------------------------------

C
CREATE SEQUENCE SYS_MOD_SEQ;

CREATE TABLE CGTS_SECURITY.MODULE (
                CODE NUMBER NOT NULL,
                CUSTOM_CODE VARCHAR2(10) NOT NULL,
                NAME VARCHAR2(100) NOT NULL,
                DESCRIPTION VARCHAR2(255),
                PERMITTED VARCHAR2(10) NOT NULL,
                CONSTRAINT SYSTEM_MODULE PRIMARY KEY (CODE)
);
COMMENT ON TABLE CGTS_SECURITY.MODULE IS 'The table stores all the systems module';
COMMENT ON COLUMN CGTS_SECURITY.MODULE.CODE IS 'The primary key of the systems modules';
COMMENT ON COLUMN CGTS_SECURITY.MODULE.CUSTOM_CODE IS 'Primary key within the  system, this must be create by the system. It is the user identification outside the DB.';
COMMENT ON COLUMN CGTS_SECURITY.MODULE.NAME IS 'System module name';
COMMENT ON COLUMN CGTS_SECURITY.MODULE.DESCRIPTION IS 'The description of The system module';


CREATE SEQUENCE USR_PRIVILEGE_SEQ;

CREATE TABLE CGTS_SECURITY.USR_PRIVILEGES (
                CODE NUMBER NOT NULL,
                CUSTOM_CODE VARCHAR2(10) NOT NULL,
                NAME VARCHAR2(20) NOT NULL,
                DESCRIPTION VARCHAR2(500),
                CONSTRAINT PRIVILEGES_PK PRIMARY KEY (CODE)
);
COMMENT ON TABLE CGTS_SECURITY.USR_PRIVILEGES IS 'The table store the profile''s permitting( CRETAE, READ, UPDATE, DELETE). For the moments';
COMMENT ON COLUMN CGTS_SECURITY.USR_PRIVILEGES.CODE IS 'The Primary key of the Table privilege';
COMMENT ON COLUMN CGTS_SECURITY.USR_PRIVILEGES.CUSTOM_CODE IS 'Primary key within the  system, this must be create by the system. It is the user identification outside the DB.';
COMMENT ON COLUMN CGTS_SECURITY.USR_PRIVILEGES.NAME IS 'Permitting''s name. ( CRETAE, READ, UPDATE, DELETE).  For the moments';
COMMENT ON COLUMN CGTS_SECURITY.USR_PRIVILEGES.DESCRIPTION IS 'The description of the profile''s privilege';


CREATE TABLE CGTS_SECURITY.TYPE_AUTHENTICATION (
                CODE NUMBER NOT NULL,
                CUSTOM_CODE VARCHAR2(10) NOT NULL,
                NAME VARCHAR2(30) NOT NULL,
                DESCRIPTION VARCHAR2(255) NOT NULL,
                CONSTRAINT TYPE_AUTHENTICATION_PK PRIMARY KEY (CODE)
);
COMMENT ON TABLE CGTS_SECURITY.TYPE_AUTHENTICATION IS 'The different types of user authentication within the system (BASIC,OAUTH,...)';
COMMENT ON COLUMN CGTS_SECURITY.TYPE_AUTHENTICATION.CODE IS 'Code that identifies a TYPE_AUTHENTICATION. It is generator by itself';
COMMENT ON COLUMN CGTS_SECURITY.TYPE_AUTHENTICATION.CUSTOM_CODE IS 'Primary key within the  system, this must be create by the system. It is the user identification outside the DB.';
COMMENT ON COLUMN CGTS_SECURITY.TYPE_AUTHENTICATION.NAME IS 'Name of the various authentication methods';
COMMENT ON COLUMN CGTS_SECURITY.TYPE_AUTHENTICATION.DESCRIPTION IS 'It details the information that the name represents, so as to be oriented when developing the functionalities of said element.';


CREATE TABLE CGTS_SECURITY.EXPIRE_TIME (
                CODE NUMBER NOT NULL,
                CUSTOM_CODE VARCHAR2(10) NOT NULL,
                NAME NUMBER NOT NULL,
                DESCRIPTION VARCHAR2(255),
                CONSTRAINT EXPIRE_TIME_PK PRIMARY KEY (CODE)
);
COMMENT ON TABLE CGTS_SECURITY.EXPIRE_TIME IS 'The time in which the user password can expire. 30, 60, 180';
COMMENT ON COLUMN CGTS_SECURITY.EXPIRE_TIME.CODE IS 'Code that identifies a EXPIRE_TIME. It is generator by itself';
COMMENT ON COLUMN CGTS_SECURITY.EXPIRE_TIME.CUSTOM_CODE IS 'Primary key within the  system, this must be create by the system. It is the user identification outside the DB.';
COMMENT ON COLUMN CGTS_SECURITY.EXPIRE_TIME.NAME IS 'it represents on time the password can expire';
COMMENT ON COLUMN CGTS_SECURITY.EXPIRE_TIME.DESCRIPTION IS 'It details the information that the name represents, so as to be oriented when developing the functionalities of said element.';


CREATE TABLE CGTS_SECURITY.PROFILES (
                CODE NUMBER NOT NULL,
                CUSTOM_CODE VARCHAR2(10) NOT NULL,
                NAME VARCHAR2(30) NOT NULL,
                DESCRIPTION VARCHAR2(255) NOT NULL,
                STATUS NUMBER(1) DEFAULT 1 NOT NULL,
                ISDEFAULT NUMBER(1) DEFAULT 1 NOT NULL,
                ISDELETE NUMBER(1) DEFAULT 0 NOT NULL,
                CONSTRAINT PROFILES_PK PRIMARY KEY (CODE)
);
COMMENT ON TABLE CGTS_SECURITY.PROFILES IS 'The table stores the different profiles of the users of the  system';
COMMENT ON COLUMN CGTS_SECURITY.PROFILES.CUSTOM_CODE IS 'Primary key within the  system, this must be create by the system. It is the user identification outside the DB.';
COMMENT ON COLUMN CGTS_SECURITY.PROFILES.NAME IS 'Profile''s name';
COMMENT ON COLUMN CGTS_SECURITY.PROFILES.DESCRIPTION IS 'Profile''s description';
COMMENT ON COLUMN CGTS_SECURITY.PROFILES.STATUS IS 'The status of the profile (1=ACTIVE  O 0 =INACTIVE ).';
COMMENT ON COLUMN CGTS_SECURITY.PROFILES.ISDEFAULT IS 'if the profile is by default in the system. 1=YES 0=NO';
COMMENT ON COLUMN CGTS_SECURITY.PROFILES.ISDELETE IS 'Module who where deleted from the system. 1 = YES, 0=NO';


CREATE TABLE CGTS_SECURITY.PERMISOLOGY (
                MODULE_CODE NUMBER NOT NULL,
                PROFILE_CODE NUMBER NOT NULL,
                PRIVILEGE_CODE NUMBER NOT NULL,
                ISDELETE NUMBER(1) DEFAULT 0 NOT NULL,
                CONSTRAINT PERMISOLOGY_PK PRIMARY KEY (MODULE_CODE, PROFILE_CODE, PRIVILEGE_CODE)
);
COMMENT ON TABLE CGTS_SECURITY.PERMISOLOGY IS 'The user modules with the privilege over them and their choice';
COMMENT ON COLUMN CGTS_SECURITY.PERMISOLOGY.MODULE_CODE IS 'The foreign key of the systems modules';
COMMENT ON COLUMN CGTS_SECURITY.PERMISOLOGY.PROFILE_CODE IS 'The Primary key of the table Profile';
COMMENT ON COLUMN CGTS_SECURITY.PERMISOLOGY.PRIVILEGE_CODE IS 'USR_SYS_MODULE ID.The foreign key of the Table privilege';
COMMENT ON COLUMN CGTS_SECURITY.PERMISOLOGY.ISDELETE IS 'Module who where deleted from the system. 1 = YES, 0=NO';


CREATE TABLE CGTS_SECURITY.USER_STATUS (
                CODE NUMBER NOT NULL,
                CUSTOM_CODE VARCHAR2(10) NOT NULL,
                NAME VARCHAR2(30) NOT NULL,
                DESCRIPTION VARCHAR2(255),
                CONSTRAINT USER_STATUS_PK PRIMARY KEY (CODE)
);
COMMENT ON TABLE CGTS_SECURITY.USER_STATUS IS 'Saves the different status of the user within the system';
COMMENT ON COLUMN CGTS_SECURITY.USER_STATUS.CODE IS 'Code that identifies a USER_STATUS. It is generator by itself';
COMMENT ON COLUMN CGTS_SECURITY.USER_STATUS.CUSTOM_CODE IS 'Primary key within the  system, this must be create by the system. It is the user identification outside the DB.';
COMMENT ON COLUMN CGTS_SECURITY.USER_STATUS.NAME IS 'Name of the status of user';
COMMENT ON COLUMN CGTS_SECURITY.USER_STATUS.DESCRIPTION IS 'It details the information that the name represents, so as to be oriented when developing the functionalities of said element.';


CREATE TABLE CGTS_SECURITY.TYPE_ID (
                CODE NUMBER NOT NULL,
                CUSTOM_CODE VARCHAR2(10) NOT NULL,
                NAME VARCHAR2(30) NOT NULL,
                DESCRIPTION VARCHAR2(255),
                CONSTRAINT TYPE_ID_PK PRIMARY KEY (CODE)
);
COMMENT ON TABLE CGTS_SECURITY.TYPE_ID IS 'Stores different types of user identification (ID, RIF, or PASSPORT)';
COMMENT ON COLUMN CGTS_SECURITY.TYPE_ID.CODE IS 'Code that identifies a TYPE_ID. It is generator by itself';
COMMENT ON COLUMN CGTS_SECURITY.TYPE_ID.CUSTOM_CODE IS 'Primary key within the  system, this must be create by the system. It is the user identification outside the DB.';
COMMENT ON COLUMN CGTS_SECURITY.TYPE_ID.NAME IS 'Name of the Type of user identification';
COMMENT ON COLUMN CGTS_SECURITY.TYPE_ID.DESCRIPTION IS 'It details the information that the name represents, so as to be oriented when developing the functionalities of said element.';


CREATE TABLE CGTS_SECURITY.USERS (
                CODE NUMBER NOT NULL,
                IP VARCHAR2(15) NOT NULL,
                TYPE_ID_CODE NUMBER NOT NULL,
                CUSTOM_CODE VARCHAR2(10) NOT NULL,
                EMAIL VARCHAR2(30) NOT NULL,
                USER_STATUS_CODE NUMBER NOT NULL,
                PROFILE_CODE NUMBER NOT NULL,
                EXPIRE_TIME_CODE NUMBER NOT NULL,
                PASSWORD VARCHAR2(255),
                NAME VARCHAR2(20) NOT NULL,
                LAST_NAME VARCHAR2(20) NOT NULL,
                ACTIVE_DATE TIMESTAMP DEFAULT SYSDATE NOT NULL,
                DEACTIVATED_DATE TIMESTAMP DEFAULT SYSDATE NOT NULL,
                LOGIN NUMBER DEFAULT 0 NOT NULL,
                DOUBLE_AUTHENTICATION NUMBER(1) DEFAULT 0 NOT NULL,
                ISDELETE NUMBER(1) DEFAULT 0 NOT NULL,
                TYPE_AUTHENTICATION_CODE NUMBER NOT NULL,
                CONSTRAINT USER_CODE PRIMARY KEY (CODE)
);
COMMENT ON TABLE CGTS_SECURITY.USERS IS 'Saves all system users';
COMMENT ON COLUMN CGTS_SECURITY.USERS.CODE IS 'Primary key of the DB, this is generated by itself';
COMMENT ON COLUMN CGTS_SECURITY.USERS.IP IS 'IP from where the user enters the system';
COMMENT ON COLUMN CGTS_SECURITY.USERS.TYPE_ID_CODE IS 'Code that identifies the USER where this TYPE_ID is';
COMMENT ON COLUMN CGTS_SECURITY.USERS.CUSTOM_CODE IS 'Primary key within the  system, this must be create by the system. It is the user identification outside the DB.';
COMMENT ON COLUMN CGTS_SECURITY.USERS.EMAIL IS 'Email of the user, that allows to recover the  password and in a single element';
COMMENT ON COLUMN CGTS_SECURITY.USERS.USER_STATUS_CODE IS 'Code that identifies a USER_STATUS within the system';
COMMENT ON COLUMN CGTS_SECURITY.USERS.PROFILE_CODE IS 'Profile id of the user. Code that identifies the USER where this  PROFILE_ is';
COMMENT ON COLUMN CGTS_SECURITY.USERS.EXPIRE_TIME_CODE IS 'Code that identifies the USER_ where this EXPIRE_TIME is';
COMMENT ON COLUMN CGTS_SECURITY.USERS.PASSWORD IS 'User password within the system, it must be encrypted by SHA-256';
COMMENT ON COLUMN CGTS_SECURITY.USERS.NAME IS 'Name of the user, i mean real name';
COMMENT ON COLUMN CGTS_SECURITY.USERS.LAST_NAME IS 'user''s last name';
COMMENT ON COLUMN CGTS_SECURITY.USERS.ACTIVE_DATE IS 'Date  the user first loggend into the system';
COMMENT ON COLUMN CGTS_SECURITY.USERS.DEACTIVATED_DATE IS 'Date in the user may be desactivated';
COMMENT ON COLUMN CGTS_SECURITY.USERS.LOGIN IS 'The number of attempts to log into the system, so that it cant be blocked in case of passing the number of attempts already defined';
COMMENT ON COLUMN CGTS_SECURITY.USERS.DOUBLE_AUTHENTICATION IS 'Configuration for double authentication. 1 If you want to activate the double authentication. 0 if you want to continue with simple authentication.';
COMMENT ON COLUMN CGTS_SECURITY.USERS.ISDELETE IS 'Users who where deleted from the system. 1 = YES, 0=NO';
COMMENT ON COLUMN CGTS_SECURITY.USERS.TYPE_AUTHENTICATION_CODE IS 'The different types of user authentication within the system';


CREATE TABLE CGTS_SECURITY.DEVICE (
                CODE NUMBER NOT NULL,
                USERS_CODE NUMBER NOT NULL,
                IMEI VARCHAR2(15) NOT NULL,
                S_N VARCHAR2(20) NOT NULL,
                STATUS NUMBER DEFAULT 0 NOT NULL,
                REGISTRATION_DATE TIMESTAMP NOT NULL,
                ACTIVATION_DATE TIMESTAMP,
                DESACTIV_DATE TIMESTAMP,
                CONSTRAINT DEVICE_PK PRIMARY KEY (CODE)
);
COMMENT ON TABLE CGTS_SECURITY.DEVICE IS 'Registration of Devices. The devices will be registered and then associated with a user';
COMMENT ON COLUMN CGTS_SECURITY.DEVICE.CODE IS 'The Primary key of the Table privilege';
COMMENT ON COLUMN CGTS_SECURITY.DEVICE.IMEI IS 'International Mobile Equipment Identity,';
COMMENT ON COLUMN CGTS_SECURITY.DEVICE.S_N IS 'Serial number';
COMMENT ON COLUMN CGTS_SECURITY.DEVICE.STATUS IS 'Value TRUE(1)/FALSE(0), indicate if it is activated';
COMMENT ON COLUMN CGTS_SECURITY.DEVICE.REGISTRATION_DATE IS 'registration date of device';
COMMENT ON COLUMN CGTS_SECURITY.DEVICE.ACTIVATION_DATE IS 'user activation date';
COMMENT ON COLUMN CGTS_SECURITY.DEVICE.DESACTIV_DATE IS 'deactivation date with the user';


ALTER TABLE CGTS_SECURITY.PERMISOLOGY ADD CONSTRAINT SYS_MOD_USR_FK
FOREIGN KEY (MODULE_CODE)
REFERENCES CGTS_SECURITY.MODULE (CODE)
NOT DEFERRABLE;

ALTER TABLE CGTS_SECURITY.PERMISOLOGY ADD CONSTRAINT PRIV_SYS_MOD_FK
FOREIGN KEY (PRIVILEGE_CODE)
REFERENCES CGTS_SECURITY.USR_PRIVILEGES (CODE)
NOT DEFERRABLE;

ALTER TABLE CGTS_SECURITY.USERS ADD CONSTRAINT TYPE_AUTHENTICATION_USER__FK
FOREIGN KEY (TYPE_AUTHENTICATION_CODE)
REFERENCES CGTS_SECURITY.TYPE_AUTHENTICATION (CODE)
NOT DEFERRABLE;

ALTER TABLE CGTS_SECURITY.USERS ADD CONSTRAINT EXPIRE_TIME_USER__FK
FOREIGN KEY (EXPIRE_TIME_CODE)
REFERENCES CGTS_SECURITY.EXPIRE_TIME (CODE)
NOT DEFERRABLE;

ALTER TABLE CGTS_SECURITY.USERS ADD CONSTRAINT PROFILE__USER__FK
FOREIGN KEY (PROFILE_CODE)
REFERENCES CGTS_SECURITY.PROFILES (CODE)
NOT DEFERRABLE;

ALTER TABLE CGTS_SECURITY.PERMISOLOGY ADD CONSTRAINT PROFILE__PERMISOLOGY_FK
FOREIGN KEY (PROFILE_CODE)
REFERENCES CGTS_SECURITY.PROFILES (CODE)
NOT DEFERRABLE;

ALTER TABLE CGTS_SECURITY.USERS ADD CONSTRAINT USER_STATUS_USER__FK
FOREIGN KEY (USER_STATUS_CODE)
REFERENCES CGTS_SECURITY.USER_STATUS (CODE)
NOT DEFERRABLE;

ALTER TABLE CGTS_SECURITY.USERS ADD CONSTRAINT TYPE_ID_USER__FK
FOREIGN KEY (TYPE_ID_CODE)
REFERENCES CGTS_SECURITY.TYPE_ID (CODE)
NOT DEFERRABLE;

ALTER TABLE CGTS_SECURITY.DEVICE ADD CONSTRAINT USERS_DEVICE_FK
FOREIGN KEY (USERS_CODE)
REFERENCES CGTS_SECURITY.USERS (CODE)
NOT DEFERRABLE;

-- **************************************************************************************************************
-- *  NAME:         DML_DB CGST_SECURITY                                                                         *
-- *  DATE:         2020-12-01                                                                                  *
-- *  AUTOR:        PEDRO QUIJADA                                                                             *
-- *  DESCRIPTION:  SQL SENTENCES TO GENERATE DATA FOR THE CGTS_SECURITY DATABASE MODEL                          *
-- *  VERSION:      v1.0                                                                                      *
-- **************************************************************************************************************

--------------------------------------------------------
-- -- DML Insert for Table CGTS_SECURITY.PRIVILEGED
--------------------------------------------------------
INSERT INTO CGTS_SECURITY.USR_PRIVILEGES (CODE,CUSTOM_CODE,NAME,DESCRIPTION) VALUES(1,'CREATE','CREATE','Create records in the system modules.');
INSERT INTO CGTS_SECURITY.USR_PRIVILEGES (CODE,CUSTOM_CODE,NAME,DESCRIPTION) VALUES(2,'READ','READ','It allows to visualize the registers that are in the modules of the system.');
INSERT INTO CGTS_SECURITY.USR_PRIVILEGES (CODE,CUSTOM_CODE,NAME,DESCRIPTION) VALUES(3,'UPDATE','UPDATE','Update the records found in the system modules.');
INSERT INTO CGTS_SECURITY.USR_PRIVILEGES (CODE,CUSTOM_CODE,NAME,DESCRIPTION) VALUES(4,'DELETE','DELETE','It allows deleting the system records.');

-------------------------------------------------------
-- -- DML Insert for Table CGTS_SECURITY.USER_STATUS
--------------------------------------------------------
INSERT INTO CGTS_SECURITY.USER_STATUS(CODE,CUSTOM_CODE,NAME,DESCRIPTION) VALUES(1,'ACTIVE','ACTIVE','USUARIOS ACTIVOS');
INSERT INTO CGTS_SECURITY.USER_STATUS(CODE,CUSTOM_CODE,NAME,DESCRIPTION) VALUES(2,'INACTIVE','INACTIVE','USUARIO INACTIVOS');

--------------------------------------------------------
-- -- DML Insert for Table CGTS_SECURITY.PROFILE
--------------------------------------------------------
INSERT INTO CGTS_SECURITY.PROFILES(CODE,CUSTOM_CODE,NAME,DESCRIPTION,STATUS,ISDEFAULT,ISDELETE) VALUES(1,'ADMIN','ADMINISTRATOR','SYSTEM ADMINISTRATOR',1,1,0);
INSERT INTO CGTS_SECURITY.PROFILES(CODE,CUSTOM_CODE,NAME,DESCRIPTION,STATUS,ISDEFAULT,ISDELETE) VALUES(2,'CONSULTA','CONSULTA','USUARIO CONSULTA',1,1,0);

--------------------------------------------------------
-- -- DML Insert for Table CGTS_SECURITY.TYPE_AUTHENTICATION
--------------------------------------------------------
INSERT INTO CGTS_SECURITY.TYPE_AUTHENTICATION(CODE,CUSTOM_CODE,NAME,DESCRIPTION) VALUES(1,'SQL','SQL','RELATIONAL DB AUTHENTICATION');
INSERT INTO CGTS_SECURITY.TYPE_AUTHENTICATION(CODE,CUSTOM_CODE,NAME,DESCRIPTION) VALUES(2,'LDAP','LDAP','LDAP AUTHENTICATION');
INSERT INTO CGTS_SECURITY.TYPE_AUTHENTICATION(CODE,CUSTOM_CODE,NAME,DESCRIPTION) VALUES(3,'JWT','JWT','JWT AUTHETICATION');

--------------------------------------------------------
-- -- DML Insert for Table CGTS_SECURITY.TYPE_ID
--------------------------------------------------------
INSERT INTO CGTS_SECURITY.TYPE_ID(CODE,CUSTOM_CODE,NAME,DESCRIPTION) VALUES(1,'DNI','DNI','DNI DOCUMENT ID');
INSERT INTO CGTS_SECURITY.TYPE_ID(CODE,CUSTOM_CODE,NAME,DESCRIPTION) VALUES(2,'PASSPORT','PASSPORT','PASSWORD DOCUMENT ID');

--------------------------------------------------------
-- -- DML Insert for Table CGTS_SECURITY.EXPIRE_TIME
--------------------------------------------------------
INSERT INTO CGTS_SECURITY.EXPIRE_TIME(CODE,CUSTOM_CODE,NAME,DESCRIPTION) VALUES(1,'1 YEAR',365,'1 YEAR');

--------------------------------------------------------
-- -- DML Insert for Table CGTS_SECURITY.USERS
--------------------------------------------------------
INSERT INTO CGTS_SECURITY.USERS (CODE, IP, TYPE_ID_CODE, CUSTOM_CODE, EMAIL, USER_STATUS_CODE, PROFILE_CODE, EXPIRE_TIME_CODE, NAME, LAST_NAME, LOGIN, DOUBLE_AUTHENTICATION, ISDELETE, TYPE_AUTHENTICATION_CODE) VALUES (1, '10.10.10.10', 1, 'admin', 'admin@tvs.com', 1, 1, 1, 'Administrador TVS', 'ADMINISTRADOR', 11111111, 0, 0, 1);
INSERT INTO CGTS_SECURITY.USERS (CODE, IP, TYPE_ID_CODE, CUSTOM_CODE, EMAIL, USER_STATUS_CODE, PROFILE_CODE, EXPIRE_TIME_CODE, NAME, LAST_NAME, LOGIN, DOUBLE_AUTHENTICATION, ISDELETE, TYPE_AUTHENTICATION_CODE) VALUES (2, '10.10.10.11', 1, 'Consulta', 'adminConsulta@tvs.com', 1, 2, 1, 'Admin DE CONSULTAS', 'CONSULTA', 22222222, 0, 0, 1);