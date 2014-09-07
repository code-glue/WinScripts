WinScripts
==========

Various scripts for automating and tweaking Windows I've created over the years.

___
## AppPathAdd.bat
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
## AppPathRemove.bat
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
## ClearIconCache.bat
Clears the icon cache by running this command:  
    ie4uinit.exe -ClearIconCache  

**Usage:**  

    ClearIconCache <No Parameters>  

___
## DirExists.bat
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
## FileExists.bat
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
## GetTextEditor.bat
Gets the default editor for text files.  

**Usage:**  

    Usage:  
    GetTextEditor <No Parameters>  

___
## PauseOnError.bat
Pauses the console if %PauseOnError% is set to 1; otherwise, does nothing.  

**Usage:**  

    PauseOnError <No Parameters>  

___
## RegKeyExists.bat
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
## RestartAdb.bat
Kills all instances of adb.exe and restarts it.  

**Usage:**  

    RestartAdb <No Parameters>  

___
## RestartExplorer.bat
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
## SetTextEditor.bat
Sets the default editor for text files.  

**Usage:**  

    SetTextEditor [ExePath]  

      ExePath    The path of the program to set as the default text editor.  

**Examples:**

      C:\>SetTextEditor  
        Prompts for the path.  

      C:\>SetTextEditor "C:\Program Files (x86)\Notepad++\notepad++.exe"  
        Sets Notepad++ as the default text editor.  

___
## TextFileExtensions.bat
Adds over 250 text file extensions, allowing files with these extensions to be indexed, searched, and easily opened in any text editor.  

**Usage:**  

