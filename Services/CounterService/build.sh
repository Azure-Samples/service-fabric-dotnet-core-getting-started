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
cd $DIR/src/CounterServiceApplication/CounterService.Interfaces/
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build
cd -

cd $DIR/src/CounterServiceApplication/CounterService/
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build 
dotnet publish -o ../../../CounterServiceApplication/CounterServicePkg/Code
cd -


cd $DIR/src/CounterServiceApplication/CounterService.WebService/CounterServiceWebService/
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build 
dotnet publish -o ../../../../CounterServiceApplication/CounterServiceWebServicePkg/Code/
cd -
