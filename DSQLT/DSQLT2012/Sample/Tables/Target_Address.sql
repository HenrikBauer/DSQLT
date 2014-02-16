﻿CREATE TABLE [Sample].[Target_Address] (
    [AddressID]       INT              IDENTITY (1, 1) NOT NULL,
    [AddressLine1]    NVARCHAR (60)    NOT NULL,
    [AddressLine2]    NVARCHAR (60)    NULL,
    [City]            NVARCHAR (30)    NOT NULL,
    [StateProvinceID] INT              NOT NULL,
    [PostalCode]      NVARCHAR (15)    NOT NULL,
    [rowguid]         UNIQUEIDENTIFIER NOT NULL,
    [ModifiedDate]    DATETIME         NOT NULL
);

