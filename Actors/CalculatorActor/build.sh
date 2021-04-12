#!/bin/bash
DIR=`dirname $0`

source $DIR/dotnet-include.sh 
cd src/CalculatorActorApplication/CalculatorActor.Interfaces/
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build 
cd -

cd src/CalculatorActorApplication/CalculatorActor/
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build 
dotnet publish -c Release --self-contained --runtime linux-x64 -o ../../../CalculatorActorApplication/CalculatorActorPkg/Code
cd -

cd src/CalculatorActorApplication/CalculatorActorTestClient/
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build 
dotnet publish -c Release --self-contained --runtime linux-x64 -o ../../../CalculatorActorTestClient
cd -
