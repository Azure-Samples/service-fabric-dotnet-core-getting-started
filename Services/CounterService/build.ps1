$invocation = (Get-Variable MyInvocation).Value
$rootpath = Split-Path $invocation.MyCommand.Path

pushd $rootpath\src\CounterServiceApplication\CounterService.Interfaces\
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build
popd

pushd $rootpath\src\CounterServiceApplication\CounterService\
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build 
dotnet publish -c Release --self-contained --runtime win-x64 -o ..\..\CounterServicePkg\Code
popd

pushd $rootpath\src\CounterServiceApplication\CounterService.WebService\CounterServiceWebService\
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build 
dotnet publish -c Release --self-contained --runtime win-x64 -o ..\..\..\..\CounterServiceApplication\CounterServiceWebServicePkg\Code\
popd