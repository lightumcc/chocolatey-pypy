$ErrorActionPreference = 'Stop'

$packagename  = 'pypy3'
$toolsdir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://bitbucket.org/pypy/pypy/downloads/pypy3.6-v7.1.0-win32.zip'
$checksum     = '77a0576a3d518210467f0df2d0d9a1892c664566dc02f25d974c2dbc6b4749e7'
$checksumType = 'sha256'

$packageargs = @{
  packagename   = $packagename
  unzipLocation = $toolsdir
  url           = $url
}

Install-ChocolateyZipPackage @packageargs

$files = Get-ChildItem $toolsdir -include *.exe -recurse

foreach ($file in $files) {
    if ($file.Name.Contains("wininst")) {
      New-Item "$file.ignore" -type file -force | Out-Null
    }
}
