@echo off
rem ----------------------------------------------------------------------------------
rem 開発者　KARL　(SFTPを追加しました)
rem ----------------------------------------------------------------------------------

SET BATLOGFILE="%~dp0log\sftp_recieve.log"
SET BATLOGTEMP="%~dp0log\sftp_recieve_tmp.log"
SET SCRIPTLOC="%~dp0\conf\sftp_recieve.conf"
SET WINLOGLOC="%~dp0log\winscp.log"

SET yyyyMMdd=%date:/=%
SET hhmmss=%time: =0%
SET hhmmss=%hhmmss:~0,2%%hhmmss:~3,2%%hhmmss:~6,2%


@rem ====================================
rem Notice start
@rem ====================================

rem ----------------------------------------------------------------------------------
rem IP host 疎通確認
rem ----------------------------------------------------------------------------------

rem ----------------------------------------------------------------------------------
rem IP host 疎通OKの場合
rem ----------------------------------------------------------------------------------

@rem ====================================
@rem 処理開始時間 定義
@rem ====================================
echo ------------------------------------ >> %BATLOGFILE% 2>&1
echo  %yyyyMMdd%_%hhmmss%SFTP処理開始         >> %BATLOGFILE% 2>&1

@rem ====================================
@rem 出力先フォルダ作成
@rem ====================================

::"..\rad\out\SYOHINMT\%yyyyMMdd%"
::mkdir "%~dp0out\SYOHINMT\%yyyyMMdd%"

cd "%~dp0"
mkdir "..\rad\out\SYOHINMT\%yyyyMMdd%"
cd    "..\rad\out\SYOHINMT\%yyyyMMdd%"
type nul > trg_KICS.SD.SYOHINMT

@rem ====================================
@rem SFTP実行
@rem ====================================

set COMPCOUNT=0

"C:\Users\81803\AppData\Local\Programs\WinSCP\WinSCP.com" /ini=nul /console /script=%SCRIPTLOC% /log=%WINLOGLOC% >> %BATLOGFILE% 2>&1

rem DashboardのWINSCPパス
rem "C:\Users\81803\AppData\Local\Programs\WinSCP\WinSCP.exe"



echo -----------------------------------------------WINSCP
for /f "delims=" %%a in (%BATLOGTEMP%) do (

  echo %%a >> %BATLOGFILE% 2>&1
  echo "%%a" | find "%200 COMPLETED.%" >NUL
  if not ERRORLEVEL 1 set /a COMPCOUNT=COMPCOUNT+1

)

@rem ====================================
rem Notice start
@rem ====================================

@rem ファイルコピー
copy .\* ..\..\..\ftp_recieve\  >> %BATLOGFILE% 2>&1

@rem ====================================
@rem 処理終了時間 定義
@rem ====================================
SET yyyyMMdd=%date:/=%
SET hhmmss=%time: =0%
SET hhmmss=%hhmmss:~0,2%%hhmmss:~3,2%%hhmmss:~6,2%

echo %yyyyMMdd%_%hhmmss%処理終了 >> %BATLOGFILE% 2>&1
echo ------------------------------------ >> %BATLOGFILE% 2>&1



@rem ====================================
@rem 終了
@rem ====================================

EXIT
