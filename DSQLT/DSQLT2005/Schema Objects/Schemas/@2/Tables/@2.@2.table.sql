CREATE TABLE [@2].[@2] (
    [@1]                 NVARCHAR (MAX)   NOT NULL,
    [@2]                 NVARCHAR (MAX)   NOT NULL,
    [@3]                 NVARCHAR (MAX)   NOT NULL,
    [@4]                 NVARCHAR (MAX)   NOT NULL,
    [@5]                 NVARCHAR (MAX)   NOT NULL,
    [@6]                 NVARCHAR (MAX)   NULL,
    [@7]                 NVARCHAR (MAX)   NULL,
    [@8]                 NVARCHAR (MAX)   NULL,
    [@9]                 NVARCHAR (MAX)   NULL,
    [Sync_Version]       CHAR (4)         NULL,
    [Sync_Id]            INT              NULL,
    [Sync_RowGUID]       UNIQUEIDENTIFIER NULL,
    [Sync_RowCreated]    DATETIME         NULL,
    [Sync_RowModified]   DATETIME         NULL,
    [Sync_RowDeleted]    TINYINT          NULL,
    [Sync_CompareID]     INT              NULL,
    [Sync_CompareStatus] TINYINT          NULL,
    [Sync_CompareDate]   DATETIME         NULL
);

