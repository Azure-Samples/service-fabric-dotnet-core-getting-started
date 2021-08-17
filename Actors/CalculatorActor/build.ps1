$invocation = (Get-Variable MyInvocation).Value
$rootpath = Split-Path $invocation.MyCommand.Path

pushd $rootpath\src\CalculatorActorApplication\CalculatorActor.Interfaces\
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build
popd

pushd $rootpath\src\CalculatorActorApplication\CalculatorActor\
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build 
dotnet publish -c Release --self-contained --runtime win-x64 -o ..\CalculatorActorPkg\Code
popd

pushd $rootpath\src\CalculatorActorApplication\CalculatorActorTestClient\
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build 
dotnet publish -c Release --self-contained --runtime win-x64 -o ..\CalculatorActorTestClient
popd