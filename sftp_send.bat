@echo off

rem ----------------------------------------------------------------------------------
rem 開発者　KARL (SFTPを追加しました)
rem ----------------------------------------------------------------------------------

::SET BATLOGFILE=%~dp0log\sftp_send.log
::SET BATLOGTEMP=%~dp0log\sftp_send_tmp.log
SET BATLOGFILE="%~dp0log\sftp_send.log"
SET BATLOGTEMP="%~dp0log\sftp_send_tmp.log"
SET SCRIPTLOC="%~dp0\conf\sftp_send.conf"
SET WINLOGLOC="%~dp0log\winscp.log"
SET DIRLOC=%~dp0


SET yyyyMMdd=%date:/=%
SET hhmmss=%time: =0%
SET hhmmss=%hhmmss:~0,2%%hhmmss:~3,2%%hhmmss:~6,2%

@rem ====================================
rem Notice start
@rem ====================================

rem ----------------------------------------------------------------------------------
rem IP host 疎通確認
rem ----------------------------------------------------------------------------------
set COUNT=0
:error
set /a COUNT=COUNT+1
if "%COUNT%" == "500" goto errorout
echo %COUNT%



rem ----------------------------------------------------------------------------------
rem IP host 疎通OKの場合(ファイル存在確認)
rem ----------------------------------------------------------------------------------
cd %~dp0
cd ..\rad

::if not exist C:\Users\81803\デスクトップ\rad\send\KICS.RV.SOLURECV goto error2
if not exist ".\send\KICS.RV.SOLURECV" (
echo File doesn't exist
goto error2
)


@rem ====================================
@rem 処理開始時間 定義
@rem ====================================
echo ------------------------------------ >> %BATLOGFILE% 2>&1
echo  %yyyyMMdd%_%hhmmss%処理開始         >> %BATLOGFILE% 2>&1


@rem ====================================
@rem ファイル名　変更
@rem ====================================
cd ".\send\"
rename "KICS.RV.SOLURECV" "KICS.RV.SOLURECV_%yyyyMMdd%%hhmmss%"
rename "KICS.RV.SOLMRECV" "KICS.RV.SOLMRECV_%yyyyMMdd%%hhmmss%"
type nul > trg_KICS.RV.SOLURECV_%yyyyMMdd%%hhmmss%
type nul > trg_KICS.RV.SOLMRECV_%yyyyMMdd%%hhmmss%

@rem ====================================
@rem SFTP WinSCP実行
@rem ====================================

::DashboardのWINSCPパス
::"C:\Users\81803\AppData\Local\Programs\WinSCP\WinSCP.exe"

"C:\Users\81803\AppData\Local\Programs\WinSCP\WinSCP.com" /ini=nul /log=%WINLOGLOC% /script=%SCRIPTLOC% >> %BATLOGFILE% 2>&1




set COMPCOUNT=0
for /f "delims=" %%a in (%BATLOGTEMP%) do (
  echo %%a >> %BATLOGFILE% 2>&1
  echo "%%a" | find "%200 COMPLETED.%" >NUL
  if not ERRORLEVEL 1 set /a COMPCOUNT=COMPCOUNT+1
)
echo --------------------forloop after 
@rem ====================================
@rem 送信ファイルを履歴フォルダへ移動
@rem ====================================
@rem ファイルコピー
  mkdir "..\send_filelog\%yyyyMMdd%"
  move  "..\send\*" "..\send_filelog\%yyyyMMdd%"

@rem ====================================
@rem 処理終了時間 定義
@rem ====================================


SET yyyyMMdd=%date:/=%
SET hhmmss=%time: =0%
SET hhmmss=%hhmmss:~0,2%%hhmmss:~3,2%%hhmmss:~6,2%
echo %yyyyMMdd%_%hhmmss%処理終了          >> %BATLOGFILE% 2>&1
echo ------------------------------------ >> %BATLOGFILE% 2>&1




@rem ====================================
@rem 終了
@rem ====================================
::EXIT


rem ----------------------------------------------------------------------------------
rem IP host 疎通NGの場合
rem ----------------------------------------------------------------------------------
:errorout
::EXIT

rem ----------------------------------------------------------------------------------
rem ファイルが存在しない場合
rem ----------------------------------------------------------------------------------
:error2
EXIT

