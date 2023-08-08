# Get IPv4 and IPv6 addresses of the local machine
$ipv4Address = (Test-Connection -ComputerName $env:COMPUTERNAME -Count 1).IPv4Address.IPAddressToString
$ipv6Address = (Test-Connection -ComputerName $env:COMPUTERNAME -Count 1).IPv6Address.IPAddressToString

# Get network status information
$networkStatus = Test-Connection -ComputerName $env:COMPUTERNAME -Count 1

# Determine the status based on the ResponseTime
$status = if ($networkStatus.ResponseTime -ne $null) {
    "Success"
} else {
    "Failed"
}

# Create an array of custom objects to store network status parameters
$networkInfo = @(
    [PSCustomObject]@{
        "Parameter" = "IPv4 Address"
        "Value" = $ipv4Address
    }
    [PSCustomObject]@{
        "Parameter" = "IPv6 Address"
        "Value" = $ipv6Address
    }
    [PSCustomObject]@{
        "Parameter" = "Response Time (ms)"
        "Value" = $networkStatus.ResponseTime
    }
    [PSCustomObject]@{
        "Parameter" = "TTL"
        "Value" = $networkStatus.TimeToLive
    }
    [PSCustomObject]@{
        "Parameter" = "Bytes"
        "Value" = $networkStatus.BufferSize
    }
    [PSCustomObject]@{
        "Parameter" = "Status"
        "Value" = $status
    }
)

# Convert the array of custom objects to CSV format
$networkInfo | Export-Csv -Path "network_status.csv" -NoTypeInformation
