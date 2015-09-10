@echo off
echo %DATE% >list.log

set tempfolder=c:\temp\_Upload

XMLDirectory songlist songlist.xml -obs >> list.log
XMLDirectory songinfo songinfo.xml -obs >> list.log

type songupd_top.xml > songupd.xml
echo %DATE% >> songupd.xml
type songupd_bot.xml >> songupd.xml

if not exist %tempfolder% md %tempfolder%
del /q %tempfolder%\*
copy scores.ftp %tempfolder%
copy songupd.xml %tempfolder%
for /D %%i IN (*) do copy "%%i\*.pdf" %tempfolder% /y
del /q %tempfolder%\_private*

if exist list.temp del list.temp
if exist list.txt rename list.txt list.temp
dir /s *.pdf /w /b /on >>list.txt

ftp -s:list.ftp

pushd %tempfolder%
ftp -s:scores.ftp
7z a scores.zip *.pdf
popd

pause



