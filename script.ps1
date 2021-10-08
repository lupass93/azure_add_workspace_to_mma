param(
    [string] $workspaceIds, 
    [string] $workspaceKeys
)

if ($workspaceIds.count -ne $workspaceKeys.count) {

    Write-Error 'The Input is not Correct. Array Lengths are differents.'
    exit 1
}

for ($i = 0; $i -lt $workspaceIds.count, $i++) {

    $mma = New-Object -ComObject 'AgentConfigManager.MgmtSvcCfg'
    $mma.AddCloudWorkspace($workspaceIds[$i], $workspaceKeys[$i])
    $mma.ReloadConfiguration()

}

exit 0
