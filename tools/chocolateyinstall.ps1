$ErrorActionPreference = 'Stop'

$packagename  = 'python.pypy'
$toolsdir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://bitbucket.org/pypy/pypy/downloads/pypy2-v5.10.0-win32.zip'
$checksum     = '3474e06bfcc9c91bc5533aeabd077b3d'
$checksumType = 'md5'

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
