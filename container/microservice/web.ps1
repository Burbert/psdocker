Start-PodeServer {

    Add-PodeEndpoint -Address * -Port 80 -Protocol Http

    Add-PodeRoute -Method Get -Path '/health' -ScriptBlock {             
        Write-PodeJsonResponse -Value @{ 'response' = 'everything looks fine' } -StatusCode 200
    }

    Add-PodeRoute -Method Get -Path '/ping' -ScriptBlock {             
        Write-PodeJsonResponse -Value @{ 'response' = 'pong' } -StatusCode 200
    }

    Add-PodeRoute -Method Get -Path '/hello' -ScriptBlock {             
        Write-PodeJsonResponse -Value @{ 'response' = 'hey ho!' } -StatusCode 200
    }

    Add-PodeRoute -Method Get -Path '/error' -ScriptBlock {
        Write-PodeJsonResponse -Value @{ 'response' = 'Error - everything is broken!' } -StatusCode 400
    }
}