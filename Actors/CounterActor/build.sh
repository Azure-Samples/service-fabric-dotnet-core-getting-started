#!/bin/bash
DIR=`dirname $0`

cd $DIR/src/CounterActorApplication/CounterActor.Interfaces/
dotnet restore -s /home/rapatchi/Desktop/Repos/service-fabric-dotnet-core-getting-started/packages
dotnet build
cd -

cd $DIR/src/CounterActorApplication/CounterActor/
dotnet restore -s /home/rapatchi/Desktop/Repos/service-fabric-dotnet-core-getting-started/packages
dotnet build 
dotnet publish -o ../../../CounterActorApplicationCSharp/CounterActorPkg/Code
cd -

cd $DIR/src/CounterActorApplication/CounterActorTestClient/
dotnet restore -s /home/rapatchi/Desktop/Repos/service-fabric-dotnet-core-getting-started/packages
dotnet build 
dotnet publish -o ../../../CounterActorTestClient
cd -

cd $DIR/src/CounterActorApplication/CounterActor.WebService/CounterActorWebService/
dotnet restore -s /home/rapatchi/Desktop/Repos/service-fabric-dotnet-core-getting-started/packages
dotnet build 
dotnet publish -o ../../../../CounterActorApplicationCSharp/CounterActorWebServicePkg/Code/
cd -
