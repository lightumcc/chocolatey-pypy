$ErrorActionPreference = 'Stop'

$packagename  = 'python.pypy'
$toolsdir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://bitbucket.org/pypy/pypy/downloads/pypy2-v5.9.0-win32.zip'
$checksum     = '43b6b0e8afb11b76a13e606499f0d9d4'
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
