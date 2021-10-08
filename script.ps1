param(
    [string[]] $workspaceIds,
    [string[]] $workspaceKeys
)

# CHECK IF ARRAY HAVE SAME LENGTH
if ($workspaceIds.Length -ne $workspaceKeys.Length) {


    Write-Error ('The Input is not Correct. Array Lengths are differents: ' +  $workspaceIds.Length +  ' and ' +  $workspaceKeys.Length)
    exit 1
}



# GET ALL WORKSPACES ASSOCIATED
$mma = New-Object -ComObject 'AgentConfigManager.MgmtSvcCfg'
$workspaces = $mma.GetCloudWorkspaces() 

Write-Information ($workspaces)


# REMOVE ALL WORKSPACES ASSOCIATED
foreach ($value in $workspaces) {

    # GET MMA CONFIGURATION
    $mmare = New-Object -ComObject 'AgentConfigManager.MgmtSvcCfg'
    Write-Information("Deleting " + $value.workspaceID)
    $mmare.RemoveCloudWorkspace($value.workspaceID)


}

$mmare.ReloadConfiguration()


# ADD ALL WORKSPACES PASSED TO MMA
for ($i = 0; $i -lt $workspaceIds.Length; $i++) {

    # GET MMA CONFIGURATION
    $mmaadd = New-Object -ComObject 'AgentConfigManager.MgmtSvcCfg'
    Write-Information("Adding " + $workspaceIds[$i])    
    $mmaadd.AddCloudWorkspace($workspaceIds[$i], $workspaceKeys[$i])
  

}

$mmaadd.ReloadConfiguration()

exit 0
