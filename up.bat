docker-compose up -d
@echo off
SETLOCAL EnableDelayedExpansion

FOR /F "tokens=1" %%i IN ('docker-compose ps ^| findstr "ubuntu-aso"') DO (
    set "containerName=%%i"
    goto :breakLoop
)
:breakLoop
docker exec -it %containerName% /bin/bash
docker-compose down