 [CmdletBinding()]
param
(
    [switch]
    $Zip = $true
)

begin
{
    Set-StrictMode -Version Latest

 
    #region Editable variables
    
    $projectName       = 'WinScripts'
    $version           = '1.0.1'
    $outputDirName     = "dist"
    $authorName        = 'Benjamin Lemmond'
    $authorEmail       = 'benlemmond@codeglue.org'
    $companyName       = 'Code Glue, LLC'
    $companyUrl        = 'www.code-glue.com'
    $copyrightYear     = '2014'
    $indent            = ' ' * 4

    #endregion
    

    #region Internal variables

    $here        = $PSCmdlet.MyInvocation.MyCommand.Definition | Split-Path
    $scriptDir   = Resolve-Path "$here\.."
    $outputPath  = Join-Path $scriptDir $outputDirName
    $targetPath  = Join-Path $outputPath "$projectName.v$version"
    $zipPath     = "$targetPath.zip"
    $copyright   = "Copyright (c) $copyrightYear $companyName ($companyUrl)"
    $newLine     = [Environment]::NewLine
    $license     = [System.IO.File]::ReadAllText("$here\license.txt") -f $copyright
    $licensePs   = "<#{0}$license{0}#>{0}" -f $newLine
    $licenseBat  = $(($license -split $newLine | foreach { ($_, ":: $_")[[bool]$_] }) -join $newLine)

    #endregion


    
    function writeScriptFile($fileName, $content, [ValidateSet('utf8', 'ascii')]$encoding)
    {
        $path = "$targetPath\$fileName"
        Write-Host "Building $fileName"
        New-Item $path -Type File -Force > $null
        $content | Out-File $path -Encoding $encoding -Force
    }
}

process
{
    Remove-Item "$targetPath" -Recurse -Force -ErrorAction SilentlyContinue

    if ($Zip)
    {
        Remove-Item $zipPath -Force -ErrorAction SilentlyContinue
    }

    Get-ChildItem $scriptDir *.bat | foreach {
        $contents = [System.IO.File]::ReadAllText($_.FullName) -f $licenseBat
        writeScriptFile $_.Name $contents ascii
    }

    
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