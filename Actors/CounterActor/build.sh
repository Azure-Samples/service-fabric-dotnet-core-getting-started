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
cd $DIR/src/CounterActorApplication/CounterActor.Interfaces/
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build
cd -

cd $DIR/src/CounterActorApplication/CounterActor/
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build 
dotnet publish -o ../../../CounterActorApplicationCSharp/CounterActorPkg/Code
cd -

cd $DIR/src/CounterActorApplication/CounterActorTestClient/
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build 
dotnet publish -o ../../../CounterActorTestClient
cd -

cd $DIR/src/CounterActorApplication/CounterActor.WebService/CounterActorWebService/
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build 
dotnet publish -o ../../../../CounterActorApplicationCSharp/CounterActorWebServicePkg/Code/
cd -
