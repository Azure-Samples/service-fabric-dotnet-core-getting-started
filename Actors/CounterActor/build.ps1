
pushd src\CounterActorApplication\CounterActor.Interfaces\
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build
popd

pushd src\CounterActorApplication\CounterActor\
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build 
dotnet publish -o ..\..\..\CounterActorApplicationCSharp\CounterActorPkg\Code
popd

pushd src\CounterActorApplication\CounterActorTestClient\
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build 
dotnet publish -o ..\..\..\CounterActorTestClient
popd

pushd src\CounterActorApplication\CounterActor.WebService\CounterActorWebService\
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build 
dotnet publish -o ..\..\..\..\CounterActorApplicationCSharp\CounterActorWebServicePkg\Code\
popd
