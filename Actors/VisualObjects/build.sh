#!/bin/bash

DIR=`dirname $0`

rm -r $DIR/VisualObjectsApplication

dotnet restore $DIR/src/VisualObjects.Common/project.json -s /opt/microsoft/sdk/servicefabric/csharp/packages -s https://api.nuget.org/v3/index.json
dotnet build $DIR/src/VisualObjects.Common/project.json

dotnet restore $DIR/src/VisualObjects.ActorService/project.json -s /opt/microsoft/sdk/servicefabric/csharp/packages -s https://api.nuget.org/v3/index.json
dotnet build $DIR/src/VisualObjects.ActorService/project.json
dotnet publish $DIR/src/VisualObjects.ActorService/project.json -o $DIR/VisualObjectsApplication/VisualObjects.ActorServicePkg/Code

dotnet restore $DIR/src/VisualObjects.WebService/project.json -s /opt/microsoft/sdk/servicefabric/csharp/packages -s https://api.nuget.org/v3/index.json
dotnet build $DIR/src/VisualObjects.WebService/project.json
dotnet publish $DIR/src/VisualObjects.WebService/project.json -o $DIR/VisualObjectsApplication/VisualObjects.WebServicePkg/Code

cp $DIR/ApplicationManifest.xml $DIR/VisualObjectsApplication/.
cp $DIR/src/VisualObjects.ActorService/PackageRoot/ServiceManifest.xml $DIR/VisualObjectsApplication/VisualObjects.ActorServicePkg/.  
cp $DIR/src/VisualObjects.WebService/PackageRoot/ServiceManifest.xml $DIR/VisualObjectsApplication/VisualObjects.WebServicePkg/.
cp -r $DIR/src/VisualObjects.WebService/wwwroot $DIR/VisualObjectsApplication/VisualObjects.WebServicePkg/Code/.
cp $DIR/src/VisualObjects.WebService/entryPoint.sh $DIR/VisualObjectsApplication/VisualObjects.WebServicePkg/Code/.
cp $DIR/src/VisualObjects.ActorService/entryPoint.sh $DIR/VisualObjectsApplication/VisualObjects.ActorServicePkg/Code/.
cp -r $DIR/src/VisualObjects.WebService/PackageRoot/Config $DIR/VisualObjectsApplication/VisualObjects.WebServicePkg/.
cp -r $DIR/src/VisualObjects.ActorService/PackageRoot/Config $DIR/VisualObjectsApplication/VisualObjects.ActorServicePkg/.
