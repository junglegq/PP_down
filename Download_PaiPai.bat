@echo off

set PPSRV=172.31.0.201

echo ---  Start w32time service ...
net start w32time
net start w32time

echo ---  Re-Sync system time with host server ...
timeout /t 3 /nobreak
w32tm /resync
timeout /t 3 /nobreak
w32tm /resync
timeout /t 3 /nobreak
w32tm /resync

if exist c:\trash.txt (
        echo "Remove tag file c:\trash.txt and reboot"
        del /f c:\trash.txt
        shutdown -r -t 300
)

set ppdir=d:\PaiPai_EXE
set ppprog=PaiPai_EXE_latest.zip

echo ---  Remove deprecated release ...
del /q d:\%ppprog%
rmdir /s /q %ppdir%

echo ---  Download latest release ...
"C:\Program Files (x86)\GnuWin32\bin\wget.exe" -O d:\%ppprog% "http://%PPSRV%/%ppprog%"


echo ---  Uncompress release ...
"c:\Program Files\7-Zip\7z.exe" x d:\%ppprog% -od:\ -r

del /F /Q d:\%ppprog%