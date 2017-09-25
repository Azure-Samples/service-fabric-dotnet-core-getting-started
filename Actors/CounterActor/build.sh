#!/bin/bash
DIR=`dirname $0`

cd $DIR/src/CounterActorApplication/CounterActor.Interfaces/
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build
cd -

cd $DIR/src/CounterActorApplication/CounterActor/
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build 
dotnet publish -o ../../../CounterActorApplication/CounterActorPkg/Code
cd -

cd $DIR/src/CounterActorApplication/CounterActorTestClient/
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build 
dotnet publish -o ../../../CounterActorTestClient
cd -

cd $DIR/src/CounterActorApplication/CounterActor.WebService/CounterActorWebService/
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build 
dotnet publish -o ../../../../CounterActorApplication/CounterActorWebServicePkg/Code/
cd -
