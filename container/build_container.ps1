az login --service-principal --username $env:AZ_CLIENT_ID --password "$($env:AZ_CLIENT_SECRET)" --tenant $env:AZURE_TENANT_ID
az account set --subscription $env:AZURE_SUBSCRIPTION_ID
az acr login --name $env:AZURE_ACR_URL

# Set-Location -Path "$($env:GITHUB_WORKSPACE)/container/module"

# docker build -t psmodule:latest .
# docker tag psmodule:latest "$($env:AZURE_ACR_URL)/psmodule/psmodule:latest"
# docker push "$($env:AZURE_ACR_URL)/psmodule/psmodule:latest"




foreach ($folder in (Get-ChildItem -Path "$($env:GITHUB_WORKSPACE)/container" -Directory)){
    $folder_content = Get-ChildItem -Path $folder.FullName
    if('Dockerfile' -in $($folder_content.name)){
        Write-Output "processing folder: `'$($folder.FullName)`'"
        $version = Get-Content -Path "$($folder.FullName)\version.json" | ConvertFrom-Json | Select-Object -ExpandProperty version
        # Write-Output "version: `'$($folder.name)`'"

        Set-Location -Path $folder.FullName

        docker build -t "$($folder.name):$($version)" .
        docker tag "$($folder.name):$($version)" "$($env:AZURE_ACR_URL)/$($folder.name)/$($folder.name):$($version)"
        docker push "$($env:AZURE_ACR_URL)/$($folder.name)/$($folder.name):$($version)"
        
        docker build -t "$($folder.name):latest" .
        docker tag "$($folder.name):latest" "$($env:AZURE_ACR_URL)/$($folder.name)/$($folder.name):latest"
        docker push "$($env:AZURE_ACR_URL)/$($folder.name)/$($folder.name):latest"
    } else {
        Write-Output "skip folder $($folder.FullName)"
    }
}
