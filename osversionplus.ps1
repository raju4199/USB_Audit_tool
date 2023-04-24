$osDetails = Get-WmiObject -Class Win32_OperatingSystem
$osProperties = Get-WmiObject -Class Win32_OperatingSystem | Get-Member -MemberType Property | Select-Object -ExpandProperty Name
$csvOutput = "C:\osversion8.csv"

$outputArray = @()

foreach ($property in $osProperties) {
    $value = $osDetails | Select-Object -ExpandProperty $property
    $outputObject = [PSCustomObject] @{
        Property = $property
        Value = $value
    }
    $outputArray += $outputObject
}

$outputArray | Export-Csv -Path $csvOutput -NoTypeInformation
