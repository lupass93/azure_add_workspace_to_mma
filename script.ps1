param(
    [string] $workspaceIds, 
    [string] $workspaceKeys
)

if ($workspaceIds.Length -ne $workspaceKeys.Length) {

    Write-Output 'workspaceIds'  $workspaceIds.Length
    Write-Output 'workspaceKeys'  $workspaceKeys.Length

    Write-Error 'The Input is not Correct. Array Lengths are differents.'
    exit 1
}

for ($i = 0; $i -lt $workspaceIds.Length, $i++) {

    $mma = New-Object -ComObject 'AgentConfigManager.MgmtSvcCfg'
    $mma.AddCloudWorkspace($workspaceIds[$i], $workspaceKeys[$i])
    $mma.ReloadConfiguration()

}

exit 0
