FROM mcr.microsoft.com/powershell
RUN pwsh -c 'Install-Module -Name AzDoPs -Scope AllUsers -Force'
CMD [ "pwsh", "-c", "while(1){Start-Sleep -Seconds 30}" ]