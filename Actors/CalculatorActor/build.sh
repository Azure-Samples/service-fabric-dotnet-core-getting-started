#!/bin/bash
DIR=`dirname $0`

cd src/CalculatorActorApplication/CalculatorActor.Interfaces/
dotnet restore -s /home/rapatchi/Desktop/Repos/service-fabric-dotnet-core-getting-started/packages
dotnet build 
cd -

cd src/CalculatorActorApplication/CalculatorActor/
dotnet restore -s /home/rapatchi/Desktop/Repos/service-fabric-dotnet-core-getting-started/packages
dotnet build 
dotnet publish -o ../../../CalculatorActorApplication/CalculatorActorPkg/Code
cd -

cd src/CalculatorActorApplication/CalculatorActorTestClient/
dotnet restore -s /home/rapatchi/Desktop/Repos/service-fabric-dotnet-core-getting-started/packages
dotnet build 
dotnet publish -o ../../../CalculatorActorTestClient
cd -
