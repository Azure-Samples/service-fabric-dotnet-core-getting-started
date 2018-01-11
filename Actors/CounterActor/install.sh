#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
appPkg="$DIR/CounterActorApplicationCSharp"

WebServiceManifestlocation="$appPkg/CounterActorWebServicePkg"
WebServiceManifestlocationLinux="$WebServiceManifestlocation/ServiceManifest-Linux.xml"
WebServiceManifestlocationWindows="$WebServiceManifestlocation/ServiceManifest-Windows.xml"
WebServiceManifestlocation="$WebServiceManifestlocation/ServiceManifest.xml"
cp $WebServiceManifestlocationLinux $WebServiceManifestlocation 

ActorServiceManifestlocation="$appPkg/CounterActorPkg"
ActorServiceManifestlocationLinux="$ActorServiceManifestlocation/ServiceManifest-Linux.xml"
ActorServiceManifestlocationWindows="$ActorServiceManifestlocation/ServiceManifest-Windows.xml"
ActorServiceManifestlocation="$ActorServiceManifestlocation/ServiceManifest.xml"
cp $ActorServiceManifestlocationLinux $ActorServiceManifestlocation 

sfctl application upload --path $appPkg --show-progress
sfctl application provision --application-type-build-path CounterActorApplicationCSharp
sfctl application create --app-name fabric:/CounterActorApplicationCSharp --app-type CounterActorApplicationTypeCSharp --app-version 1.0.0