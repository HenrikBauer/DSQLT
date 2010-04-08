ALTER DATABASE [$(DatabaseName)]
    ADD LOG FILE (NAME = [DSQLT_log], FILENAME = '$(DefaultDataPath)$(DatabaseName).ldf', MAXSIZE = 2097152 MB, FILEGROWTH = 10 %);

