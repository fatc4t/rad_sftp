@echo off

SET BATLOGFILE=%~dp0log\winscp_download.log
SET BATLOGTEMP=%~dp0log\winscp_download_tmp.log
SET yyyyMMdd=%date:/=%
SET hhmmss=%time: =0%
SET hhmmss=%hhmmss:~0,2%%hhmmss:~3,2%%hhmmss:~6,2%

@rem ====================================
rem Notice start
@rem ====================================

rem ----------------------------------------------------------------------------------
rem IP host �a�ʊm�F
rem ----------------------------------------------------------------------------------
set COUNT=0
:error
set /a COUNT=COUNT+1
if "%COUNT%" == "1200" goto errorout
echo %COUNT%
ping -n 1 -w 1 133.242.228.107 | find "ms TTL=" > NUL
if ERRORLEVEL 1 goto error


rem ----------------------------------------------------------------------------------
rem IP host �a��OK�̏ꍇ
rem ----------------------------------------------------------------------------------


@rem ====================================
@rem �����J�n���� ��`
@rem ====================================
echo ------------------------------------ >> %BATLOGFILE% 2>&1
echo  %yyyyMMdd%_%hhmmss%�����J�n         >> %BATLOGFILE% 2>&1

@rem ====================================
@rem FTP���s
@rem ====================================
"C:\Users\81803\AppData\Local\Programs\WinSCP\WinSCP.exe"  /console /script="C:\Users\81803\�f�X�N�g�b�v\rad\conf\winscp_download.conf" >> %BATLOGFILE% 2>&1

@rem ====================================
@rem �����I������ ��`
@rem ====================================
SET yyyyMMdd=%date:/=%
SET hhmmss=%time: =0%
SET hhmmss=%hhmmss:~0,2%%hhmmss:~3,2%%hhmmss:~6,2%
echo %yyyyMMdd%_%hhmmss%�����I��          >> %BATLOGFILE% 2>&1
echo ------------------------------------ >> %BATLOGFILE% 2>&1

@rem ====================================
@rem �I��
@rem ====================================
EXIT


rem ----------------------------------------------------------------------------------
rem IP host �a��NG�̏ꍇ
rem ----------------------------------------------------------------------------------
:errorout
EXIT