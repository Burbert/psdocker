FROM mcr.microsoft.com/powershell:latest
RUN pwsh -c 'Install-Module Pode -Force'
COPY . /usr/src/app/
CMD [ "pwsh", "-c", "cd /usr/src/app; ./web.ps1" ]
