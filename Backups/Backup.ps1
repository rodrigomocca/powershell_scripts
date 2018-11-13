$TARGETDIR = "C:\Backup\$((Get-Date).ToString('yyyy-MM-dd'))"
Write-Output ("Verificando si existe la carpeta $TARGETDIR")
if(!(Test-Path -Path $TARGETDIR )){
    Write-Output("Creando directorio")
    New-Item -ItemType directory -Path $TARGETDIR
}

$sourceRoot = "C:\temp\*"

Write-Output ("Copiando los archivos a $TARGETDIR")
Copy-item -Force -Recurse -Verbose $sourceRoot -Destination $TARGETDIR