@echo off

SET BATLOGFILE=%~dp0log\winscp_upload.log
SET BATLOGTEMP=%~dp0log\winscp_upload_tmp.log
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
if "%COUNT%" == "1200" goto errorout
echo %COUNT%
ping -n 1 -w 1 133.242.228.107 | find "ms TTL=" > NUL
if ERRORLEVEL 1 goto error


rem ----------------------------------------------------------------------------------
rem IP host 疎通OKの場合
rem ----------------------------------------------------------------------------------


@rem ====================================
@rem 処理開始時間 定義
@rem ====================================
echo ------------------------------------ >> %BATLOGFILE% 2>&1
echo  %yyyyMMdd%_%hhmmss%処理開始         >> %BATLOGFILE% 2>&1

@rem ====================================
@rem FTP実行
@rem ====================================
"C:\Users\81803\AppData\Local\Programs\WinSCP\WinSCP.exe"  /console /script="C:\Users\81803\Desktop\rad\conf\winscp_upload.conf" >> %BATLOGFILE% 2>&1

@rem ====================================
@rem 送信ファイルを履歴フォルダへ移動
@rem ====================================
del C:\Users\81803\Desktop\rad\ftp_recieve\KICS.SD.SYOHINMT
del C:\Users\81803\Desktop\rad\ftp_recieve\KICS.SD.SOLSNDF1
del C:\Users\81803\Desktop\rad\ftp_recieve\KICS.SD.SOLSNDF2
del C:\Users\81803\Desktop\rad\ftp_recieve\KICS.SD.SOLSNDF3

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
EXIT


rem ----------------------------------------------------------------------------------
rem IP host 疎通NGの場合
rem ----------------------------------------------------------------------------------
:errorout
EXIT