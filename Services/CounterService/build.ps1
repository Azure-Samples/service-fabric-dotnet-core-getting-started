pushd src\CounterServiceApplication\CounterService.Interfaces\
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build
popd

pushd src\CounterServiceApplication\CounterService\
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build 
dotnet publish -c Release --self-contained --runtime win-x64 -o ..\..\..\CounterServiceApplication\CounterServicePkg\Code
popd


pushd src\CounterServiceApplication\CounterService.WebService\CounterServiceWebService\
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build 
dotnet publish -c Release --self-contained --runtime win-x64 -o ..\..\..\..\CounterServiceApplication\CounterServiceWebServicePkg\Code\
popd