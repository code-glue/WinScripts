WinScripts
==========

Various scripts for automating and tweaking Windows I've created over the years.

___
### AddBatchFileExtension.bat
Makes the specified file extension behave like a batch file (i.e. .bat, .cmd. etc).  

**Usage:**  

    AddBatchFileExtension [.]Extension  

      Extension    The name of the extension, optionally prefixed by ".".  

**Examples:**

      C:\>AddBatchFileExtension  
        Prompts for the file extension.  

      C:\>AddBatchFileExtension "sh"  
        Makes files with the .sh file extension behave like a batch file.  

      C:\>AddBatchFileExtension ".sh"  
        Makes files with the .sh file extension behave like a batch file.  

___
### AddCommonTextFileExts.bat
Adds a plain text handler for the following file extensions, allowing files with the extension to be indexed, searched, and easily opened in any text editor:  
ada adb addin ads ahk ammo arena as asc asm asp atr au3 aut aux axl bas bat bhc body bot bsh c camera cbd cbl cc cdb cdc cfg cfm cgi cls cmake cmd cnf cob conf config cpp cs csdl csproj css ctl cue cxx d def defs dfm diff diz dob docbook dotsettings dpk dpr dsm dsp dsr dsw dtd edmx efx ent f f2k f90 f95 filters for frames frm g2skin gametype generate git gitignore gitmodules gore gradle gsc h hh hpp hs hta htd htm html htt hud hxa hxc hxk hxt hxx idl idx il iml impacts inc inf ini instance inview isl iss itcl item java js jsfl jsp kix kml las lhs lisp litcoffee log lsp lst lua m mak map mapcycle master material md menu miscents mission ml mli ms msl mx name nav nfo npc nsh nsi nt objectives odl outfitting pag pas patch php php3 php4 phtml pl player pln plx pm pod poses pp pro properties props ps ps1 psm1 py pyproj pyw q3asm qe4 r rb rbw rc rc2 rdf recent reg rej resx rmd sample scm script ses settings sf sh shader shfbproj shock shtm shtml sif skl sln sma smd sml sp spb spec sps sql ss ssdl st str sty stype sun sv svg svh t targets tcl teams terrain tex theme thy toc tpl tt ttinclude tui tuo txt url user v vb vbproj vbs vcproj vcs vcxproj vdproj vh vhd vhdl voice vscontent vsdir vsprops vssettings vstdir vstheme vsz vxml wml wnt wpn wsdl xhtml xlf xliff xml xrc xsd xsl xslt xsml xul yml   

**Usage:**  

    AddCommonTextFileExts <No Parameters>  

___
### AddTextFileExtension.bat
Adds a plain text handler to the given file extension, allowing files with the extension to be indexed, searched, and easily opened in any text editor.  

**Usage:**  

    AddTextFileExtension [.]Extension  

      Extension    The name of the extension to add, optionally prefixed by ".".  

**Examples:**

      C:\>AddTextFileExtension  
        Prompts for the file extension.  

      C:\>AddTextFileExtension "txt"  
        Adds a plain text handler for the .txt file extension.  

      C:\>AddTextFileExtension ".txt"  
        Adds a plain text handler for the .txt file extension.  

___
### AppPathAdd.bat
Allows a program/file to be opened from the "Run" dialog window using an alias.  

**Usage:**  

    AppPathAdd [Path [Alias]]  

      Path   Path to the program/file that will be run/opened.  
      Alias  Name that will be entered into the Run dialog window.  
             If excluded, defaults to the file's name.  

**Examples:**

      C:\>AppPathAdd  
        Prompts for the file path and alias.  

      C:\>AppPathAdd "C:\Program Files (x86)\NotePad++\notepad++.exe"  
        Runs Notepad++ when "notepad++" or "notepad++.exe" is entered.  

      C:\>AppPathAdd "C:\Program Files (x86)\NotePad++\notepad++.exe" npp  
        Runs Notepad++ when "npp" or "npp.exe" is entered.  

___
### AppPathRemove.bat
Prevents a program/file from being opened from the "Run" dialog window using its alias.  

**Usage:**  

    AppPathRemove [Alias[.exe]]  

      Alias    The name of the alias to remove, optionally followed by ".exe".  

**Examples:**

      C:\>AppPathRemove  
        Prompts for the alias.  

      C:\>AppPathRemove "npp"  
        Removes the "npp.exe" alias from the registry.  

      C:\>AppPathRemove "npp.exe"  
        Removes the "npp.exe" alias from the registry.  

___
### ClearIconCache.bat
Clears the icon cache by running this command:  
    ie4uinit.exe -ClearIconCache  

**Usage:**  

    ClearIconCache <No Parameters>  

___
### DirExists.bat
Determines whether the given path refers to an existing directory.  
Sets the ErrorLevel variable to 0 if the directory exists; otherwise, 1.  

**Usage:**  

    DirExists Path  

      Path    The path to test.  

**Examples:**

      C:\>DirExists  
        Sets %ErrorLevel% to 1  

      C:\>DirExists "C:\Windows"  
        Sets %ErrorLevel% to 0. Directory exists.  

      C:\>DirExists "C:\"  
        Sets %ErrorLevel% to 0. Drives are considered directories.  

      C:\>DirExists "C:\Windows\notepad.exe"  
        Sets %ErrorLevel% to 1. Path exists but is a file.  

___
### FileExists.bat
Determines whether the given path refers to an existing file.  
Sets the ErrorLevel variable to 0 if the file exists; otherwise, 1.  

**Usage:**  

    FileExists Path  

      Path    The path to test.  

**Examples:**

      C:\>FileExists  
        Sets %ErrorLevel% to 1  

      C:\>FileExists "C:\Windows\notepad.exe"  
        Sets %ErrorLevel% to 0. File exists.  

      C:\>FileExists "C:\Windows"  
        Sets %ErrorLevel% to 1. Path exists but is a directory.  

___
### GetTextEditor.bat
Gets the default editor for text files.  

**Usage:**  

    GetTextEditor <No Parameters>  

___
### PauseOnError.bat
Pauses the console if %PauseOnError% is set to 1; otherwise, does nothing.  

**Usage:**  

    PauseOnError <No Parameters>  

___
### RegKeyExists.bat
Determines whether the given path refers to an existing registry key.  
Sets the ErrorLevel variable to 0 if the registry key exists; otherwise, 1.  

**Usage:**  

    RegKeyExists KeyName  

      KeyName  [\\Machine\]FullKey  
               Machine - Name of remote machine, omitting defaults to the  
                         current machine. Only HKLM and HKU are available on  
                         remote machines  
               FullKey - in the form of ROOTKEY\SubKey name  
                    ROOTKEY - [ HKLM | HKCU | HKCR | HKU | HKCC ]  
                    SubKey  - The full name of a registry key under the  
                              selected ROOTKEY  

**Examples:**

      C:\>RegKeyExists  
        Sets %ErrorLevel% to 1  

      C:\>RegKeyExists "HKCR"  
        Sets %ErrorLevel% to 0. Registry key exists.  

      C:\>RegKeyExists "HKCU\BadKeyName"  
        Sets %ErrorLevel% to 1. Registry key does not exist.  

___
### RestartAdb.bat
Kills all instances of adb.exe and restarts it.  

**Usage:**  

    RestartAdb <No Parameters>  

___
### RestartExplorer.bat
Restarts explorer.exe.  

**Usage:**  

    RestartExplorer [/Q]  

      /Q    Quiet mode, do not ask if ok to restart explorer.exe.  

**Examples:**

      C:\>RestartExplorer  
        Prompts to restart explorer.exe.  

      C:\>RestartExplorer /q  
        Restarts explorer.exe without prompting.  

___
### SetTextEditor.bat
Sets the default editor for text files.  

**Usage:**  

    SetTextEditor [ExePath]  

      ExePath    The path of the program to set as the default text editor.  

**Examples:**

      C:\>SetTextEditor  
        Prompts for the path.  

      C:\>SetTextEditor "C:\Program Files (x86)\Notepad++\notepad++.exe"  
        Sets Notepad++ as the default text editor.  
