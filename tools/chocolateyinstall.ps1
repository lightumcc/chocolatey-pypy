$ErrorActionPreference = 'Stop'

$packagename  = 'python.pypy'
$toolsdir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://bitbucket.org/pypy/pypy/downloads/pypy2-v5.4.1-win32.zip'
$checksum     = 'bd25b15c0d6c0f7c7f6fa75f1da35014'
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
