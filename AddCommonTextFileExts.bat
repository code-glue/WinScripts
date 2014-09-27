@echo off

:: %License%

SetLocal EnableDelayedExpansion

set Result=1
set FileName=%~n0
set PauseOnError=%~dp0PauseOnError.bat
set AddTextFileExtension=%~dp0AddTextFileExtension.bat

set TextFileExtensions=( ^
ada           ^
adb           ^
addin         ^
ads           ^
ahk           ^
ammo          ^
arena         ^
as            ^
asc           ^
asm           ^
asp           ^
atr           ^
au3           ^
aut           ^
aux           ^
axl           ^
bas           ^
bat           ^
bhc           ^
body          ^
bot           ^
bsh           ^
c             ^
camera        ^
cbd           ^
cbl           ^
cc            ^
cdb           ^
cdc           ^
cfg           ^
cfm           ^
cgi           ^
cls           ^
cmake         ^
cmd           ^
cnf           ^
cob           ^
conf          ^
config        ^
cpp           ^
cs            ^
csdl          ^
csproj        ^
css           ^
ctl           ^
cue           ^
cxx           ^
d             ^
def           ^
defs          ^
dfm           ^
diff          ^
diz           ^
dob           ^
docbook       ^
dotsettings   ^
dpk           ^
dpr           ^
dsm           ^
dsp           ^
dsr           ^
dsw           ^
dtd           ^
edmx          ^
efx           ^
ent           ^
f             ^
f2k           ^
f90           ^
f95           ^
filters       ^
for           ^
frames        ^
frm           ^
g2skin        ^
gametype      ^
generate      ^
git           ^
gitattributes ^
gitconfig     ^
gitignore     ^
gitmodules    ^
gore          ^
gradle        ^
gsc           ^
h             ^
hh            ^
hpp           ^
hs            ^
hta           ^
htaccess      ^
htd           ^
htm           ^
html          ^
htpasswd      ^
htt           ^
hud           ^
hxa           ^
hxc           ^
hxk           ^
hxt           ^
hxx           ^
idl           ^
idx           ^
il            ^
iml           ^
impacts       ^
inc           ^
inf           ^
ini           ^
instance      ^
inview        ^
ipr           ^
isl           ^
iss           ^
itcl          ^
item          ^
iws           ^
java          ^
js            ^
jsfl          ^
jsp           ^
kix           ^
kml           ^
las           ^
lhs           ^
lisp          ^
litcoffee     ^
log           ^
lsp           ^
lst           ^
lua           ^
m             ^
mak           ^
map           ^
mapcycle      ^
master        ^
material      ^
md            ^
menu          ^
miscents      ^
mission       ^
ml            ^
mli           ^
ms            ^
msl           ^
mx            ^
name          ^
nav           ^
nfo           ^
npc           ^
nsh           ^
nsi           ^
nt            ^
objectives    ^
odl           ^
outfitting    ^
pag           ^
pas           ^
patch         ^
php           ^
php3          ^
php4          ^
phtml         ^
pl            ^
player        ^
pln           ^
plx           ^
pm            ^
po            ^
pod           ^
portable      ^
pot           ^
poses         ^
pp            ^
ppk           ^
pro           ^
properties    ^
props         ^
ps            ^
ps1           ^
psm1          ^
pub           ^
py            ^
pyproj        ^
pyw           ^
q3asm         ^
qe4           ^
r             ^
rb            ^
rbw           ^
rc            ^
rc2           ^
rdf           ^
recent        ^
reg           ^
rej           ^
resx          ^
rmd           ^
sample        ^
scm           ^
script        ^
ses           ^
settings      ^
sf            ^
sh            ^
shader        ^
shfbproj      ^
shock         ^
shtm          ^
shtml         ^
sif           ^
skl           ^
sln           ^
sma           ^
smd           ^
sml           ^
sp            ^
spb           ^
spec          ^
sps           ^
sql           ^
ss            ^
ssdl          ^
st            ^
str           ^
sty           ^
stype         ^
sun           ^
sv            ^
svg           ^
svh           ^
t             ^
targets       ^
tcl           ^
teams         ^
terrain       ^
tex           ^
theme         ^
thy           ^
toc           ^
tpl           ^
tt            ^
ttinclude     ^
tui           ^
tuo           ^
txt           ^
url           ^
user          ^
v             ^
vb            ^
vbproj        ^
vbs           ^
vcproj        ^
vcs           ^
vcxproj       ^
vdproj        ^
vh            ^
vhd           ^
vhdl          ^
voice         ^
vscontent     ^
vsdir         ^
vsprops       ^
vssettings    ^
vstdir        ^
vstheme       ^
vsz           ^
vxml          ^
wml           ^
wnt           ^
wpn           ^
wsdl          ^
xhtml         ^
xlf           ^
xliff         ^
xml           ^
xrc           ^
xsd           ^
xsl           ^
xslt          ^
xsml          ^
xul           ^
yml           ^
)

if not [%1] == [] goto Usage

set Result=0
echo Adding a plain text persistent handler for the following extensions:
echo.
for %%a in %TextFileExtensions% do (
    echo | set /p= %%a 
    call "%AddTextFileExtension%" "%%a" >nul
    if !ErrorLevel! neq 0 set Result=1
)

goto ExitResult

:Usage
echo.
echo Adds a plain text handler for the following file extensions, allowing files with the extension to be indexed, searched, and easily opened in any text editor:
for %%a in %TextFileExtensions% do (
    set AllExts=!AllExts!%%a 
)
echo !AllExts!
echo.
echo.%FileName% ^<No Parameters^>
goto Exit


:ExitResult
if %Result% neq 0 call "%PauseOnError%"


:Exit
@%ComSpec% /c exit %Result% >nul
