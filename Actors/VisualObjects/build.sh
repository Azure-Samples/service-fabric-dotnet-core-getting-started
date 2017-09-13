#!/bin/bash

DIR=`dirname $0`
CURDIR=`pwd`

rm -r $DIR/VisualObjectsApplication

cd `dirname $DIR/src/VisualObjects.Common/VisualObjects.Common.csproj`
dotnet restore  -r ubuntu.16.04-x64 -s /opt/microsoft/sdk/servicefabric/csharp/packages -s https://api.nuget.org/v3/index.json
dotnet build
cd -

cd `dirname $DIR/src/VisualObjects.ActorService/VisualObjects.ActorService.csproj`
dotnet restore -r ubuntu.16.04-x64 -s /opt/microsoft/sdk/servicefabric/csharp/packages -s https://api.nuget.org/v3/index.json
dotnet build 
dotnet publish --self-contained -r ubuntu.16.04-x64 -o ../../VisualObjectsApplication/VisualObjects.ActorServicePkg/Code
cd -

cd `dirname $DIR/src/VisualObjects.WebService/VisualObjects.WebService.csproj`
dotnet restore -r ubuntu.16.04-x64 -s /opt/microsoft/sdk/servicefabric/csharp/packages -s https://api.nuget.org/v3/index.json
dotnet build
dotnet publish --self-contained -r ubuntu.16.04-x64  -o ../..//VisualObjectsApplication/VisualObjects.WebServicePkg/Code
cd -

cp $DIR/ApplicationManifest.xml $DIR/VisualObjectsApplication/.
cp $DIR/src/VisualObjects.ActorService/PackageRoot/ServiceManifest.xml $DIR/VisualObjectsApplication/VisualObjects.ActorServicePkg/.  
cp $DIR/src/VisualObjects.WebService/PackageRoot/ServiceManifest.xml $DIR/VisualObjectsApplication/VisualObjects.WebServicePkg/.
cp -r $DIR/src/VisualObjects.WebService/wwwroot $DIR/VisualObjectsApplication/VisualObjects.WebServicePkg/Code/.
cp $DIR/src/VisualObjects.WebService/entryPoint.sh $DIR/VisualObjectsApplication/VisualObjects.WebServicePkg/Code/.
cp $DIR/src/VisualObjects.ActorService/entryPoint.sh $DIR/VisualObjectsApplication/VisualObjects.ActorServicePkg/Code/.
cp -r $DIR/src/VisualObjects.WebService/PackageRoot/Config $DIR/VisualObjectsApplication/VisualObjects.WebServicePkg/.
cp -r $DIR/src/VisualObjects.ActorService/PackageRoot/Config $DIR/VisualObjectsApplication/VisualObjects.ActorServicePkg/.
