<#
.SYNOPSIS
   Adds template parameters to specified script files and outputs them to the specified path.

.DESCRIPTION
   Adds template parameters to specified script files and outputs them to the specified path.
   Currently, it only adds the license to each file, but it could be used to generate OS-specific scripts.

.PARAMETER ScriptDir
   Path to a directory containing script files.

.PARAMETER OutputDir
   The directory where the modified script files will be saved.

.PARAMETER Zip
    Specifies whether or not to zip the contents of the output directory.

#>
[CmdletBinding()]
param
(
    [Parameter(Mandatory=$true, Position=0)]
    [String]
    $ScriptDir,

    [Parameter(Mandatory=$true, Position=1)]
    [String]
    $OutputDir,

    [switch]
    $Zip = $true
)

begin
{
    Set-StrictMode -Version Latest


    #region Contants

    $projectName       = 'WinScripts'
    $version           = '1.0.1'
    $authorName        = 'Benjamin Lemmond'
    $authorEmail       = 'benlemmond@codeglue.org'
    $companyName       = 'Code Glue, LLC'
    $companyUrl        = 'www.code-glue.com'
    $copyrightYear     = '2014'
    $indent            = ' ' * 4

    #endregion


    #region Internal variables

    $here        = $PSCmdlet.MyInvocation.MyCommand.Definition | Split-Path
    $copyright   = "Copyright (c) $copyrightYear $companyName ($companyUrl)"
    $newLine     = [Environment]::NewLine
    $license     = [System.IO.File]::ReadAllText("$here\license.txt") -f $copyright
    $licensePs   = "<#{0}$license{0}#>{0}" -f $newLine
    $licenseBat  = $(($license -split $newLine | foreach { ($_, ":: $_")[[bool]$_] }) -join $newLine)
    $readMe      = [System.IO.File]::ReadAllText("$here\ReadMeHeader.txt")
    #endregion


    function writeScriptFile($fileName, $content, [ValidateSet('utf8', 'ascii')]$encoding)
    {
        $path = "$targetPath\$fileName"
        Write-Host "Building $fileName"
        New-Item $path -Type File -Force > $null
        $content | Out-File $path -Encoding $encoding -Force
    }

    function GetUsage($scriptPath)
    {
        $fileName = [System.IO.Path]::GetFileName($scriptPath)
        $foundDescription = $false
        $usageWritten = $false

        $usageLines = & $scriptPath /? | Out-String -Stream | foreach {

            if (-not $foundDescription)
            {
                if (-not $_) { return }
                $foundDescription = $true
                return "$_  "
            }

            if (-not $usageWritten)
            {
                if ($_) { return "$_  " }
                $usageWritten = $true
                return '', '**Usage:**  ', ''
            }

            if ($_ -eq "Examples:") { return "**$_**" }

            if (-not $_) { return $_ }
            "    $_  "
        }

        $usageLines = @($newLine, '___', "## $fileName") + $usageLines
        $usageLines -join $newLine
    }
}

process
{
    try
    {
        $outDir =
            if (Test-Path $OutputDir)
            {
                Resolve-Path $OutputDir
            }
            else
            {
                New-Item -Type Directory $OutputDir -ErrorAction Stop
            }

        $ScriptDir, $outDir | foreach {
            $item = Get-Item -LiteralPath $_ -ErrorAction SilentlyContinue

            if ($item -eq $null -or @($item).Count -ne 1 -or -not $item.PSIsContainer)
            {
                throw [System.IO.FileNotFoundException]"'$_' is not a directory"
            }
        }

        $targetPath  = Join-Path $outDir "$projectName.v$version"
        $zipPath     = "$targetPath.zip"

        Remove-Item "$targetPath" -Recurse -Force -ErrorAction SilentlyContinue

        if ($Zip)
        {
            Remove-Item $zipPath -Force -ErrorAction SilentlyContinue
        }

        Get-ChildItem $ScriptDir *.bat | foreach {
            $readMe += GetUsage $_.FullName
            $contents = [System.IO.File]::ReadAllText($_.FullName) -replace '::\s*%License%', $licenseBat
            writeScriptFile $_.Name $contents ascii
        }

        
        writeScriptFile "ReadMe.md" $readMe utf8

        if ($Zip)
        {
            if (-not ([System.Management.Automation.PSTypeName]'System.IO.Compression.ZipFile').Type)
            {
                Add-Type -AssemblyName System.IO.Compression.FileSystem
            }

            Write-Host "Creating zip file $zipPath"
            [System.IO.Compression.ZipFile]::CreateFromDirectory($targetPath, $zipPath, 'Optimal', $true)
        }
    }
    catch
    {
        Write-Error -ErrorRecord $_
    }
}
