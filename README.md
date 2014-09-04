WinScripts
==========

Various scripts for automating and tweaking Windows
___
## AppPathAdd
Makes programs or files accessible from the Start->Run dialog window.
  
**Usage:**
  
AppPathAdd [Path [Alias]]
  
      ExePath  Path to the program/file that will be run/opened.  
      Alias    Name that will be entered into the Run dialog window.
               If excluded, defaults to the file's name.
  
Examples:
  
      C:\>AppPathAdd
        Prompts for the file path and alias.
  
      C:\>AppPathAdd "C:\Program Files (x86)\NotePad++\notepad++.exe"
        Runs Notepad++ when "notepad++" or "notepad++.exe" is entered.
  
      C:\>AppPathAdd "C:\Program Files (x86)\NotePad++\notepad++.exe" npp
        Runs Notepad++ when "npp" or "npp.exe" is entered.

___
## AppPathRemove
Prevents a program/file from being opened from the "Run" dialog window using its alias.
  
**Usage:**
  
AppPathRemove Alias[.exe]
  
      Alias    The name of the alias to remove, optionally followed by ".exe".
  
Examples:
  
      C:\>AppPathRemove
        Prompts for the alias.

      C:\>AppPathRemove "npp"
        Removes the "npp.exe" alias from the registry.
  
      C:\>AppPathRemove "npp.exe"
        Removes the "npp.exe" alias from the registry.
