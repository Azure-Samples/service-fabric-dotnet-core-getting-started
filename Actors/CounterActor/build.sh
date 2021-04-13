#!/bin/bash
DIR=`dirname $0`
source $DIR/dotnet-include.sh 
cd $DIR/src/CounterActorApplication/CounterActor.Interfaces/
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build
cd -

cd $DIR/src/CounterActorApplication/CounterActor/
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build 
dotnet publish -c Release --self-contained --runtime linux-x64 -o ../../../CounterActorApplicationCSharp/CounterActorPkg/Code
cd -

cd $DIR/src/CounterActorApplication/CounterActorTestClient/
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build 
dotnet publish -c Release --self-contained --runtime linux-x64 -o ../../../CounterActorTestClient
cd -

cd $DIR/src/CounterActorApplication/CounterActor.WebService/CounterActorWebService/
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build 
dotnet publish -c Release --self-contained --runtime linux-x64 -o ../../../../CounterActorApplicationCSharp/CounterActorWebServicePkg/Code/
cd -
