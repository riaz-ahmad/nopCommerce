Push-Location -Path ..\Presentation\Nop.Web

Write-Host "Clearing Published Files ..."
Remove-Item -Path .\publish -Recurse -ErrorAction SilentlyContinue

Write-Host "Building ..."
dotnet restore
dotnet publish -c Release -o ./publish


Write-Host "Zipping ..."
& {cmd /c '"C:\Program Files\7-Zip\7z.exe" a -tzip -o.\ abayagirl.zip .\publish\* -aoa'}

az webapp deployment source config-zip --resource-group AbayaGirl --name abayagirl-app --src .\abayagirl.zip

Pop-Location