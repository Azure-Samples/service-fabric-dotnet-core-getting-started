#!/bin/bash

DIR=`dirname $0`
CURDIR=`pwd`
source $DIR/dotnet-include.sh 
rm -r $DIR/VisualObjectsApplicationCSharp

cd `dirname $DIR/src/VisualObjects.Common/VisualObjects.Common.csproj`
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build
cd -

cd `dirname $DIR/src/VisualObjects.ActorService/VisualObjects.ActorService.csproj`
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build 
dotnet publish -c Release --self-contained --runtime linux-x64 -o ../../VisualObjectsApplicationCSharp/VisualObjects.ActorServicePkg/Code
cd -

cd `dirname $DIR/src/VisualObjects.WebService/VisualObjects.WebService.csproj`
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build
dotnet publish -c Release --self-contained --runtime linux-x64 -o ../..//VisualObjectsApplicationCSharp/VisualObjects.WebServicePkg/Code
cd -

cp $DIR/ApplicationManifest.xml $DIR/VisualObjectsApplicationCSharp/.
cp $DIR/src/VisualObjects.ActorService/PackageRoot/ServiceManifest-Linux.xml $DIR/VisualObjectsApplicationCSharp/VisualObjects.ActorServicePkg/. 
cp $DIR/src/VisualObjects.ActorService/PackageRoot/ServiceManifest-Windows.xml $DIR/VisualObjectsApplicationCSharp/VisualObjects.ActorServicePkg/. 
cp $DIR/src/VisualObjects.WebService/PackageRoot/ServiceManifest-Linux.xml $DIR/VisualObjectsApplicationCSharp/VisualObjects.WebServicePkg/.
cp $DIR/src/VisualObjects.WebService/PackageRoot/ServiceManifest-Windows.xml $DIR/VisualObjectsApplicationCSharp/VisualObjects.WebServicePkg/.
cp -r $DIR/src/VisualObjects.WebService/wwwroot $DIR/VisualObjectsApplicationCSharp/VisualObjects.WebServicePkg/Code/.
cp $DIR/src/VisualObjects.WebService/entryPoint.sh $DIR/VisualObjectsApplicationCSharp/VisualObjects.WebServicePkg/Code/.
cp $DIR/src/VisualObjects.ActorService/entryPoint.sh $DIR/VisualObjectsApplicationCSharp/VisualObjects.ActorServicePkg/Code/.
cp $DIR/src/VisualObjects.WebService/entryPoint.cmd $DIR/VisualObjectsApplicationCSharp/VisualObjects.WebServicePkg/Code/.
cp $DIR/src/VisualObjects.ActorService/entryPoint.cmd $DIR/VisualObjectsApplicationCSharp/VisualObjects.ActorServicePkg/Code/.
cp -r $DIR/src/VisualObjects.WebService/PackageRoot/Config $DIR/VisualObjectsApplicationCSharp/VisualObjects.WebServicePkg/.
cp -r $DIR/src/VisualObjects.ActorService/PackageRoot/Config $DIR/VisualObjectsApplicationCSharp/VisualObjects.ActorServicePkg/.
