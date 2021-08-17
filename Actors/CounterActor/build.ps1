$invocation = (Get-Variable MyInvocation).Value
$rootpath = Split-Path $invocation.MyCommand.Path

pushd $rootpath\src\CounterActorApplication\CounterActor.Interfaces\
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build
popd

pushd $rootpath\src\CounterActorApplication\CounterActor\
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build 
dotnet publish -c Release --self-contained --runtime win-x64 -o .\CounterActorApplicationCSharp\CounterActorPkg\Code
popd

pushd $rootpath\src\CounterActorApplication\CounterActorTestClient\
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build 
dotnet publish -c Release --self-contained --runtime win-x64 -o .\CounterActorTestClient
popd

pushd $rootpath\src\CounterActorApplication\CounterActor.WebService\CounterActorWebService\
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build 
dotnet publish -c Release --self-contained --runtime win-x64 -o ..\..\..\..\CounterActorApplicationCSharp\CounterActorWebServicePkg\Code\
popd
