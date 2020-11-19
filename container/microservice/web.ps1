Start-PodeServer {

    Add-PodeEndpoint -Address * -Port 80 -Protocol Http

    Add-PodeRoute -Method Get -Path '/health' -ScriptBlock {             
        # Write-PodeTextResponse -Value 'Hello from PowerShell in Docker'

        Write-PodeJsonResponse -Value @{ 'response' = 'everything looks fine' } -StatusCode 200
    }

    Add-PodeRoute -Method Get -Path '/ping' -ScriptBlock {             
        # Write-PodeTextResponse -Value 'Hello from PowerShell in Docker'

        Write-PodeJsonResponse -Value @{ 'response' = 'pong' } -StatusCode 200
    }

    Add-PodeRoute -Method Get -Path '/hello' -ScriptBlock {             
        # Write-PodeTextResponse -Value 'Hello from PowerShell in Docker'

        Write-PodeJsonResponse -Value @{ 'response' = 'hey ho!' } -StatusCode 200
    }
}