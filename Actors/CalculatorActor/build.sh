#!/bin/bash
DIR=`dirname $0`
. /etc/os-release
linuxDistrib=$ID
if [ $linuxDistrib = "rhel" ]; then
  source scl_source enable rh-dotnet20
  exitCode=$?
  if [ $exitCode != 0 ]; then
        echo "Failed: source scl_source enable rh-dotnet20 : ExitCode: $exitCode"
        exit $exitCode
  fi
fi
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
