param(
    [string[]] $workspaceIds,
    [string[]] $workspaceKeys
)

# CHECK IF ARRAY HAVE SAME LENGTH
if ($workspaceIds.Length -ne $workspaceKeys.Length) {


    Write-Error ('The Input is not Correct. Array Lengths are differents: ' +  $workspaceIds.Length +  ' and ' +  $workspaceKeys.Length)
    exit 1
}


# ADD ALL WORKSPACES PASSED TO MMA
for ($i = 0; $i -lt $workspaceIds.Length; $i++) {

    # GET MMA CONFIGURATION
    $mma = New-Object -ComObject 'AgentConfigManager.MgmtSvcCfg'
    Write-Information("Adding " + $workspaceIds[$i])    
    $mma.AddCloudWorkspace($workspaceIds[$i], $workspaceKeys[$i])
    $mma.ReloadConfiguration()
  

}



exit 0
