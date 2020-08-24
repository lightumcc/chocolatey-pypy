$ErrorActionPreference = 'Stop'

$packagename  = 'pypy3'
$toolsdir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://downloads.python.org/pypy/pypy3.6-v7.3.1-win32.zip'
$checksum     = '752fbe8c4abee6468e5ce22af82818f821daded36faa65f3d69423f9c217007a'
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
