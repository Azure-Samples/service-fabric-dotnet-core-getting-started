pushd src\CalculatorActorApplication\CalculatorActor.Interfaces\
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build
popd

pushd src\CalculatorActorApplication\CalculatorActor\
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build 
dotnet publish -o ..\..\..\CalculatorActorApplication\CalculatorActorPkg\Code
popd

pushd src\CalculatorActorApplication\CalculatorActorTestClient\
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build 
dotnet publish -o ..\..\..\CalculatorActorTestClient
popd