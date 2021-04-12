#!/bin/bash
DIR=`dirname $0`
source $DIR/dotnet-include.sh 
cd $DIR/src/CounterServiceApplication/CounterService.Interfaces/
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build
cd -

cd $DIR/src/CounterServiceApplication/CounterService/
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build 
dotnet publish -c Release --self-contained --runtime linux-x64 -o ../../../CounterServiceApplication/CounterServicePkg/Code
cd -


cd $DIR/src/CounterServiceApplication/CounterService.WebService/CounterServiceWebService/
dotnet restore -s https://api.nuget.org/v3/index.json
dotnet build 
dotnet publish -c Release --self-contained --runtime linux-x64 -o ../../../../CounterServiceApplication/CounterServiceWebServicePkg/Code/
cd -
