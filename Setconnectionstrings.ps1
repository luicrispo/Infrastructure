$mResourceGroup = $env:ResourceGroup

$mySite = $env:backendname

$myDb = $env:sqlservername

$myDbAdmin = $env:sqladminusername

$myAdminPassword = $env:sqladminpassword

$connetctionstring = "Server=tcp:" + $myDb + ".database.windows.net,1433;Initial Catalog=RealWorld;Persist Security Info=False;User ID=" + $myDbAdmin + ";Password=" + $myAdminPassword + ";MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"


$webApp = Get-AzureRMWebAppSlot -ResourceGroupName $myResourceGroup -Name $mySite -Slot production

$appSettingList = $webApp.SiteConfig.ConnectionStrings

$hash = @{}

ForEach ($kvp in $appSettingList) {

$hash[$kvp.Name] = $kvp.Value

}

$hash['BEDatabase'] = "$Env:Release_ReleaseId"


Set-AzureRMWebAppSlot -ResourceGroupName $myResourceGroup -Name $mySite -ConnectionStrings $hash -Slot production

Write-Host "Done!"