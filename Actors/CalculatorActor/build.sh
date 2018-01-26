#!/bin/bash
DIR=`dirname $0`

source ./dotnet-include.sh 
cd src/CalculatorActorApplication/CalculatorActor.Interfaces/
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build 
cd -

cd src/CalculatorActorApplication/CalculatorActor/
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build 
dotnet publish -o ../../../CalculatorActorApplication/CalculatorActorPkg/Code
cd -

cd src/CalculatorActorApplication/CalculatorActorTestClient/
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build 
dotnet publish -o ../../../CalculatorActorTestClient
cd -
