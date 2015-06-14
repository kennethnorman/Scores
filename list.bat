@echo off
echo %DATE% >list.log

XMLDirectory songlist songlist.xml -obs >> list.log
XMLDirectory songinfo songinfo.xml -obs >> list.log

type songupd_top.xml > songupd.xml
echo %DATE% >> songupd.xml
type songupd_bot.xml >> songupd.xml

del /q ..\_Upload\*
copy scores.ftp ..\_Upload
for /D %%i IN (*) do copy "%%i\*.pdf" ..\_Upload /y
del /q ..\_Upload\_private*

if exist list.temp del list.temp
if exist list.txt rename list.txt list.temp
dir /s *.pdf /w /b /on >>list.txt

ftp -s:list.ftp

pushd ..\_Upload
ftp -s:scores.ftp
7z a scores.zip *.pdf
popd

pause



