function DockerSQLBackup {
param([string] $user,
      [string] $pass,
      [string] $instance = "localhost",
      [string] $db,
      [string] $output = "/var/opt/mssql/data/$($db)_$(Get-Date -format "yyyyMMdd").bak",
      [string] $container,
      [string] $destination = ".")

    $sql = "
    USE $db;
    GO
    BACKUP DATABASE $db TO DISK = '$output';
    GO"

    Write-Output "Creating backup..."
    Invoke-Sqlcmd -Query $sql -ServerInstance $inst –Username $user –Password $pass
    Write-Output "Backup ready."
    Write-Output "Copying backup to $($destination)..."
    docker cp "$($container):$($output)" $destination
    docker exec $container "rm $($output)"
}

Export-ModuleMember -Function DockerSQLBackup