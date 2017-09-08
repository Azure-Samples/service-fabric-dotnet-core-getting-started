#!/bin/bash
DIR=`dirname $0`

cd src/CalculatorActorApplication/CalculatorActor.Interfaces/
dotnet restore -r ubuntu.16.04-x64 -s /opt/microsoft/sdk/servicefabric/csharp/packages -s https://api.nuget.org/v3/index.json
dotnet build 
cd -

cd src/CalculatorActorApplication/CalculatorActor/
dotnet restore -r ubuntu.16.04-x64 -s /opt/microsoft/sdk/servicefabric/csharp/packages -s https://api.nuget.org/v3/index.json
dotnet build 
dotnet publish --self-contained -r ubuntu.16.04-x64 -o ../../../CalculatorActorApplication/CalculatorActorPkg/Code
cd -

cd src/CalculatorActorApplication/CalculatorActorTestClient/
dotnet restore -r ubuntu.16.04-x64 -s /opt/microsoft/sdk/servicefabric/csharp/packages -s https://api.nuget.org/v3/index.json
dotnet build 
dotnet publish --self-contained -r ubuntu.16.04-x64 -o ../../../CalculatorActorTestClient
cd -
