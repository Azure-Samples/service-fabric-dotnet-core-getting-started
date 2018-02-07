#!/bin/bash

sfctl application delete --application-id VisualObjectsApplicationCSharp
sfctl application unprovision --application-type-name VisualObjectsApplicationTypeCSharp --application-type-version 1.0.0
sfctl store delete --content-path VisualObjectsApplicationCSharp
rm ./VisualObjectsApplicationCSharp/VisualObjects.ActorServicePkg/Code/dotnet-include.sh
rm ./VisualObjectsApplicationCSharp/VisualObjects.WebServicePkg/Code/dotnet-include.sh