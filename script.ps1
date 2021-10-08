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
$workspaces = $mma.GetCloudWorkspaces() 


# REMOVE ALL WORKSPACES ASSOCIATED
foreach ($value in $workspaces) {

    # GET MMA CONFIGURATION
    $mma = New-Object -ComObject 'AgentConfigManager.MgmtSvcCfg'
    $mma.RemoveCloudWorkspace($value.workspaceID)
    $mma.ReloadConfiguration()

}


# ADD ALL WORKSPACES PASSED TO MMA
for ($i = 0; $i -lt $workspaceIds.Length; $i++) {

    # GET MMA CONFIGURATION
    $mma = New-Object -ComObject 'AgentConfigManager.MgmtSvcCfg'    
    $mma.AddCloudWorkspace($workspaceIds[$i], $workspaceKeys[$i])
    $mma.ReloadConfiguration()

}


exit 0
