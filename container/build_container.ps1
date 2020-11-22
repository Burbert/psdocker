# login to Azure Container Registry using azure cli
az login --service-principal --username $env:AZ_CLIENT_ID --password "$($env:AZ_CLIENT_SECRET)" --tenant $env:AZURE_TENANT_ID
az account set --subscription $env:AZURE_SUBSCRIPTION_ID
az acr login --name $env:AZURE_ACR_URL

# iterate through all folders in /container to identify if Dockerfile is present
foreach ($folder in (Get-ChildItem -Path "$($env:GITHUB_WORKSPACE)/container" -Directory)){
    $folder_content = Get-ChildItem -Path $folder.FullName
    if('Dockerfile' -in $($folder_content.name)){
        Write-Output "processing folder: `'$($folder.FullName)`'"
        try{
            $version = Get-Content -Path "$($folder.FullName)\version.json" -ErrorAction Stop | ConvertFrom-Json | Select-Object -ExpandProperty version
        } catch {
            Write-Warning "Version file not found - skipping folder: `'$($folder.FullName)`'"
            continue
        }

        # set working directory
        Set-Location -Path $folder.FullName

        # build container with version tag
        docker build -t "$($folder.name):$($version)" .
        docker tag "$($folder.name):$($version)" "$($env:AZURE_ACR_URL)/$($folder.name)/$($folder.name):$($version)"
        docker push "$($env:AZURE_ACR_URL)/$($folder.name)/$($folder.name):$($version)"
        
        # build container with lastest tag
        docker build -t "$($folder.name):latest" .
        docker tag "$($folder.name):latest" "$($env:AZURE_ACR_URL)/$($folder.name)/$($folder.name):latest"
        docker push "$($env:AZURE_ACR_URL)/$($folder.name)/$($folder.name):latest"
    } else {
        Write-Output "skip folder $($folder.FullName)"
    }
}
