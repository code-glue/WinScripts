@echo off

:: %License%

SetLocal DisableDelayedExpansion

set Result=1

set BinaryFileExtensions=( ^
.386            ^
.aif            ^
.aifc           ^
.aiff           ^
.aps            ^
.art            ^
.asf            ^
.au             ^
.avi            ^
.ba             ^
.baml           ^
.bi             ^
.bin            ^
.bkf            ^
.bmp            ^
.bsc            ^
.bti            ^
.cache          ^
.cda            ^
.cgm            ^
.cod            ^
.com            ^
.cpl            ^
.cpt            ^
.cub            ^
.cur            ^
.dax            ^
.dbg            ^
.dca            ^
.dct            ^
.desklink       ^
.dex            ^
.dgn            ^
.dib            ^
.dll            ^
.dl_            ^
.drv            ^
.drx            ^
.dvx            ^
.dwg            ^
.emf            ^
.eng            ^
.eps            ^
.etp            ^
.exe            ^
.exp            ^
.ex_            ^
.eyb            ^
.fnd            ^
.fnt            ^
.fon            ^
.ghi            ^
.gif            ^
.hdp            ^
.icm            ^
.ico            ^
.igr            ^
.ilk            ^
.imc            ^
.ino            ^
.ins            ^
.inv            ^
.in_            ^
.jbf            ^
.jds            ^
.jfif           ^
.jpe            ^
.jpeg           ^
.jpg            ^
.key            ^
.latex          ^
.ldb            ^
.lib            ^
.m14            ^
.m1v            ^
.ma             ^
.mapimail       ^
.mdb            ^
.mdb2           ^
.mid            ^
.midi           ^
.mmf            ^
.mov            ^
.movie          ^
.mp2            ^
.mp2v           ^
.mp3            ^
.mpa            ^
.mpe            ^
.mpeg           ^
.mpg            ^
.mpp            ^
.mpv2           ^
.mshc           ^
.msm            ^
.mso            ^
.mv             ^
.mydocs         ^
.ncb            ^
.o              ^
.obj            ^
.obs            ^
.ocx            ^
.oc_            ^
.opt            ^
.par            ^
.pc6            ^
.pcd            ^
.pch            ^
.pdb            ^
.pds            ^
.pic            ^
.pid            ^
.pma            ^
.pmc            ^
.PML            ^
.pmr            ^
.png            ^
.ppn            ^
.psd            ^
.pth            ^
.pvk            ^
.res            ^
.resources      ^
.rle            ^
.rmi            ^
.rose           ^
.rpc            ^
.rsc            ^
.rsp            ^
.sbr            ^
.sc2            ^
.scd            ^
.sch            ^
.sit            ^
.snd            ^
.sr_            ^
.sym            ^
.sys            ^
.sy_            ^
.tap            ^
.tbl            ^
.tlb            ^
.tsp            ^
.ttc            ^
.ttf            ^
.vbx            ^
.vue            ^
.vxd            ^
.wav            ^
.wax            ^
.wdp            ^
.wlt            ^
.wm             ^
.wma            ^
.wmf            ^
.wmp            ^
.wmv            ^
.wmx            ^
.wmz            ^
.wsi            ^
.wsz            ^
.wvx            ^
.xesc           ^
.xix            ^
.xor            ^
.z96            ^
.zfsendtotarget ^
.zvf            ^
)

set Arg1=%1
SetLocal EnableDelayedExpansion
if not .!Arg1! == . EndLocal & call :Usage & goto Exit
EndLocal


:DoWork
set Result=0
echo Adding a NULL persistent handler for the following extensions:
echo.
for %%a in %BinaryFileExtensions% do (
    echo | set /p= %%a 
    call "%~dp0AddBinaryFileExtension.bat" "%%a" >nul
    if %ErrorLevel% neq 0 set Result=1
)

goto Exit


:Usage
SetLocal EnableDelayedExpansion
echo.
echo Adds a NULL handler for the following file extensions, telling the search indexer to ignore the file's contents.
echo.
for %%a in %BinaryFileExtensions% do (
    set AllExts=!AllExts!%%a
)
echo !AllExts!
echo.
echo.%~n0 ^<No Parameters^>
exit /b


:Exit
call "%~dp0PauseGui.bat" "%~f0"
@%ComSpec% /c exit %Result% >nul
