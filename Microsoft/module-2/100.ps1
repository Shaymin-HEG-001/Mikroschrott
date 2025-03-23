Function Set-SoundVolume 
{
    Param(
        [Parameter(Mandatory=$true)]
        [ValidateRange(0,100)]
        [Int]
        $volume
    )

    $keyPresses = [Math]::Ceiling( $volume / 2 )
    
    $obj = New-Object -ComObject WScript.Shell
    
    1..50 | ForEach-Object {  $obj.SendKeys( [char] 174 )  }
    
    for( $i = 0; $i -lt $keyPresses; $i++ )
    {
        $obj.SendKeys( [char] 175 )
    }
}
New-Alias -Name "ssv" Set-SoundVolume

Set-SoundVolume 100
