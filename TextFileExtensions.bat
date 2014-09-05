@echo off

:: %License%

SetLocal EnableDelayedExpansion

if not [%1] == [] goto Usage

set HasErrors=0

set TextFileExtensions=( ^
ada         ^
adb         ^
addin       ^
ads         ^
ahk         ^
ammo        ^
arena       ^
as          ^
asc         ^
asm         ^
asp         ^
atr         ^
au3         ^
aut         ^
aux         ^
axl         ^
bas         ^
bat         ^
bhc         ^
body        ^
bot         ^
bsh         ^
c           ^
camera      ^
cbd         ^
cbl         ^
cc          ^
cdb         ^
cdc         ^
cfg         ^
cfm         ^
cgi         ^
cls         ^
cmake       ^
cmd         ^
cnf         ^
cob         ^
conf        ^
config      ^
cpp         ^
cs          ^
csdl        ^
csproj      ^
css         ^
ctl         ^
cue         ^
cxx         ^
d           ^
def         ^
defs        ^
dfm         ^
diff        ^
diz         ^
dob         ^
docbook     ^
dotsettings ^
dpk         ^
dpr         ^
dsm         ^
dsp         ^
dsr         ^
dsw         ^
dtd         ^
edmx        ^
efx         ^
ent         ^
f           ^
f2k         ^
f90         ^
f95         ^
filters     ^
for         ^
frames      ^
frm         ^
g2skin      ^
gametype    ^
generate    ^
git         ^
gitignore   ^
gitmodules  ^
gore        ^
gradle      ^
gsc         ^
h           ^
hh          ^
hpp         ^
hs          ^
hta         ^
htd         ^
htm         ^
html        ^
htt         ^
hud         ^
hxa         ^
hxc         ^
hxk         ^
hxt         ^
hxx         ^
idl         ^
idx         ^
il          ^
iml         ^
impacts     ^
inc         ^
inf         ^
ini         ^
instance    ^
inview      ^
isl         ^
iss         ^
itcl        ^
item        ^
java        ^
js          ^
jsfl        ^
jsp         ^
kix         ^
kml         ^
las         ^
lhs         ^
lisp        ^
litcoffee   ^
log         ^
lsp         ^
lst         ^
lua         ^
m           ^
mak         ^
map         ^
mapcycle    ^
master      ^
material    ^
md          ^
menu        ^
miscents    ^
mission     ^
ml          ^
mli         ^
ms          ^
msl         ^
mx          ^
name        ^
nav         ^
nfo         ^
npc         ^
nsh         ^
nsi         ^
nt          ^
objectives  ^
odl         ^
outfitting  ^
pag         ^
pas         ^
patch       ^
php         ^
php3        ^
php4        ^
phtml       ^
pl          ^
player      ^
pln         ^
plx         ^
pm          ^
pod         ^
poses       ^
pp          ^
pro         ^
properties  ^
props       ^
ps          ^
ps1         ^
psm1        ^
py          ^
pyproj      ^
pyw         ^
q3asm       ^
qe4         ^
r           ^
rb          ^
rbw         ^
rc          ^
rc2         ^
rdf         ^
recent      ^
reg         ^
rej         ^
resx        ^
rmd         ^
sample      ^
scm         ^
script      ^
ses         ^
settings    ^
sf          ^
sh          ^
shader      ^
shfbproj    ^
shock       ^
shtm        ^
shtml       ^
sif         ^
skl         ^
sln         ^
sma         ^
smd         ^
sml         ^
sp          ^
spb         ^
spec        ^
sps         ^
sql         ^
ss          ^
ssdl        ^
st          ^
str         ^
sty         ^
stype       ^
sun         ^
sv          ^
svg         ^
svh         ^
t           ^
targets     ^
tcl         ^
teams       ^
terrain     ^
tex         ^
theme       ^
thy         ^
toc         ^
tpl         ^
tt          ^
ttinclude   ^
tui         ^
tuo         ^
txt         ^
url         ^
user        ^
v           ^
vb          ^
vbproj      ^
vbs         ^
vcproj      ^
vcs         ^
vcxproj     ^
vdproj      ^
vh          ^
vhd         ^
vhdl        ^
voice       ^
vscontent   ^
vsdir       ^
vsprops     ^
vssettings  ^
vstdir      ^
vstheme     ^
vsz         ^
vxml        ^
wml         ^
wnt         ^
wpn         ^
wsdl        ^
xhtml       ^
xlf         ^
xliff       ^
xml         ^
xrc         ^
xsd         ^
xsl         ^
xslt        ^
xsml        ^
xul         ^
yml         ^
)

echo Adding a plain text persistent handler for the following extensions:
echo.
for %%a in %TextFileExtensions% do (
    echo | set /p= %%a 
    
    reg add "HKCR\.%%a" /v "PerceivedType" /d "text" /f >nul
    if !ErrorLevel! neq 0 set HasErrors=1

    reg add "HKCR\.%%a\PersistentHandler" /ve /d "{5E941D80-BF96-11CD-B579-08002B30BFEB}" /f > nul
    if !ErrorLevel! neq 0 set HasErrors=1
)

echo.
if %HasErrors% equ 0 exit /b 0
call PauseOnError.bat
exit /b 1

:Usage
echo.
echo Adds over 250 text file extensions, allowing files with these extensions to be indexed, searched, and easily opened in any text editor.
echo.
exit /b 1
