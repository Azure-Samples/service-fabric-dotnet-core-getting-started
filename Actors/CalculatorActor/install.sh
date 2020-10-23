#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
appPkg="$DIR/CalculatorActorApplication"
ActorServiceManifestlocation="$appPkg/CalculatorActorPkg"
ActorServiceManifestlocationLinux="$ActorServiceManifestlocation/ServiceManifest-Linux.xml"
ActorServiceManifestlocationWindows="$ActorServiceManifestlocation/ServiceManifest-Windows.xml"
ActorServiceManifestlocation="$ActorServiceManifestlocation/ServiceManifest.xml"
cp $ActorServiceManifestlocationLinux $ActorServiceManifestlocation 
cp dotnet-include.sh ./CalculatorActorApplication/CalculatorActorPkg/Code
cp dotnet-include.sh ./CalculatorActorTestClient
sfctl application upload --path $appPkg --show-progress -t 1200
sfctl application provision --application-type-build-path CalculatorActorApplication
sfctl application create --app-name fabric:/CalculatorActorApplication --app-type CalculatorActorApplicationType --app-version 1.0.0
