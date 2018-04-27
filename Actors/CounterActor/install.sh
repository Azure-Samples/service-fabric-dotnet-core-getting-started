#!/bin/bash
create_app()
{
  if [ $# -eq 0 ]; then
    sfctl application create --app-name fabric:/CounterActorApplicationCSharp --app-type CounterActorApplicationTypeCSharp --app-version 1.0.0 --parameters "{\"CounterActorWebService_InstanceCount\":\"1\"}"
  else
    sfctl application create --app-name fabric:/CounterActorApplicationCSharp --app-type CounterActorApplicationTypeCSharp --app-version 1.0.0
  fi
}
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

cp dotnet-include.sh ./CounterActorApplicationCSharp/CounterActorPkg/Code
cp dotnet-include.sh ./CounterActorApplicationCSharp/CounterActorWebServicePkg/Code
cp dotnet-include.sh ./CounterActorTestClient
sfctl application upload --path $appPkg --show-progress
sfctl application provision --application-type-build-path CounterActorApplicationCSharp
if [ $# -eq 0 ]
  then
    echo "No arguments supplied, proceed with default instanceCount of 1"
    create_app
  elif [ $1 = "onebox" ]
  then
    echo "Onebox environment, proceed with default instanceCount of 1."
    create_app
  elif [ $1 = "multinode" ]
  then
    echo "Multinode env, proceed with default instanceCount of -1"
    create_app 1
fi