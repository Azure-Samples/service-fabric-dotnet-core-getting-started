set LD_LIBRARY_PATH="D:\WindowsFabric\out\debug-amd64\bin\FabricDrop\bin\Fabric\Fabric.Code"
dotnet %~dp0\CounterActorTestClient.dll
echo %errorlevel%
exit /b %errorlevel%