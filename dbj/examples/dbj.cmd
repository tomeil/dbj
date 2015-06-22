@rem load J Qt IDE and start dbj GUI
@rem run from the J install directory
@cd /d %~dp0
REM @start bin\jqt.exe -js "load'~user/projects/dbj/dbj.ijs'" "dbj<'db1'"
@start bin\jqt.exe -js "load'data/dbj'" "dbj<'db1'"
