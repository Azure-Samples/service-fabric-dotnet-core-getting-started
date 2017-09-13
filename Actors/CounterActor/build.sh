#!/bin/bash
DIR=`dirname $0`

cd $DIR/src/CounterActorApplication/CounterActor.Interfaces/
dotnet restore -r ubuntu.16.04-x64 -s /opt/microsoft/sdk/servicefabric/csharp/packages -s https://api.nuget.org/v3/index.json
dotnet build
cd -

cd $DIR/src/CounterActorApplication/CounterActor/
dotnet restore -r ubuntu.16.04-x64 -s /opt/microsoft/sdk/servicefabric/csharp/packages -s https://api.nuget.org/v3/index.json
dotnet build 
dotnet publish --self-contained -r ubuntu.16.04-x64 -o ../../../CounterActorApplication/CounterActorPkg/Code
cd -

cd $DIR/src/CounterActorApplication/CounterActorTestClient/
dotnet restore -r ubuntu.16.04-x64 -s /opt/microsoft/sdk/servicefabric/csharp/packages -s https://api.nuget.org/v3/index.json
dotnet build 
dotnet publish --self-contained -r ubuntu.16.04-x64 -o ../../../CounterActorTestClient
cd -

cd $DIR/src/CounterActorApplication/CounterActor.WebService/CounterActorWebService/
dotnet restore -r ubuntu.16.04-x64 -s /opt/microsoft/sdk/servicefabric/csharp/packages -s https://api.nuget.org/v3/index.json
dotnet build 
dotnet publish --self-contained -r ubuntu.16.04-x64 -o ../../../../CounterActorApplication/CounterActorWebServicePkg/Code/
cd -
