set LD_LIBRARY_PATH="D:\WindowsFabric\out\debug-amd64\bin\FabricDrop\bin\Fabric\Fabric.Code"
dotnet %~dp0\VisualObjects.ActorService.dll
echo %errorlevel%
cd
dir
SLEEP 30