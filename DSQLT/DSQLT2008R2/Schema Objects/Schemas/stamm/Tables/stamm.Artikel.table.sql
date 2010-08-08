﻿CREATE TABLE [stamm].[Artikel] (
    [Transfer_ID]             INT              NULL,
    [Transfer_Version]        CHAR (5)         NULL,
    [Transfer_Row_PrimaryKey] UNIQUEIDENTIFIER NULL,
    [Transfer_Row_Deleted]    BIT              NULL,
    [Transfer_Row_Created]    SMALLDATETIME    NULL,
    [Transfer_Row_Changed]    SMALLDATETIME    NULL,
    [Transfer_Row_Deployed]   SMALLDATETIME    NULL,
    [Transfer_Row_Status]     TINYINT          NULL,
    [MANDT]                   VARCHAR (4)      NOT NULL,
    [Benutzer#]               VARCHAR (12)     NOT NULL,
    [Personal#]               CHAR (4)         NOT NULL,
    [Name]                    VARCHAR (35)     NOT NULL,
    [Email]                   VARCHAR (50)     NOT NULL,
    [Telefon]                 VARCHAR (25)     NOT NULL,
    [Abteilung]               VARCHAR (15)     NOT NULL,
    [Status]                  VARCHAR (50)     NOT NULL,
    [Mandant#]                CHAR (3)         NOT NULL,
    [Personal#_Vorgesetzter]  CHAR (4)         NOT NULL,
    [Benutzer#_Vorgesetzter]  CHAR (12)        NOT NULL,
    [Vorname]                 VARCHAR (35)     NULL,
    [Nachname]                VARCHAR (35)     NULL,
    [i5Profil]                CHAR (10)        NULL,
    [DCWBenutzer]             CHAR (15)        NULL,
    [DCWGruppe]               CHAR (15)        NULL,
    [Bestellnummernkreis]     CHAR (2)         NULL
);

