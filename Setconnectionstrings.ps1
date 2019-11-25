$myResourceGroup = $env:ResourceGroup

$mySite = $env:backendname

$myDb = $env:sqlservername

$myDbAdmin = $env:sqladminusername

$myAdminPassword = $env:sqladminpassword

$connetctionstring = "Server=tcp:" + $myDb + ".database.windows.net,1433;Initial Catalog=RealWorld;Persist Security Info=False;User ID=" + $myDbAdmin + ";Password=" + $myAdminPassword + ";MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"

Write-Host $connetctionstring

$webApp = Get-AzureRMWebApp -ResourceGroupName $myResourceGroup -Name $mySite


$test= @{"Type"="Custom"; "Value" = $connetctionstring} 
$Conn=@{"DbConnectionString"=$test }

Set-AzureRMWebApp -ResourceGroupName $myResourceGroup -Name $mySite -ConnectionStrings $Conn

Write-Host "Done!"