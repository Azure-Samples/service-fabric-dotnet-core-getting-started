
pushd src\CounterActorApplication\CounterActor.Interfaces\
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build
popd

pushd src\CounterActorApplication\CounterActor\
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build 
dotnet publish -c Release --runtime win-x64 -o ..\..\..\CounterActorApplicationCSharp\CounterActorPkg\Code
popd

pushd src\CounterActorApplication\CounterActorTestClient\
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build 
dotnet publish -c Release --runtime win-x64 -o ..\..\..\CounterActorTestClient
popd

pushd src\CounterActorApplication\CounterActor.WebService\CounterActorWebService\
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build 
dotnet publish -c Release --runtime win-x64 -o ..\..\..\..\CounterActorApplicationCSharp\CounterActorWebServicePkg\Code\
popd
