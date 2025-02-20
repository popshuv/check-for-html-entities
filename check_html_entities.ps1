param (
    [string]$FilePath
)

if (-Not (Test-Path $FilePath)) {
    Write-Host "File not found: $FilePath"
    exit 1
}

$entityPattern = "&[a-zA-Z0-9#]+;"

$lines = Get-Content -Path $FilePath
$found = $false

foreach ($index in 0..($lines.Length - 1)) {
    $lineNumber = $index + 1 
    $match = [regex]::Matches($lines[$index], $entityPattern)

    if ($match.Count -gt 0) {
        $found = $true
        foreach ($m in $match) {
            Write-Host "Found '$($match.Value)' on Line $lineNumber"
        }
    }
}

if (-Not $found) {
    Write-Host "No HTML entities found in the file."
}
