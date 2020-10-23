#!/bin/bash
create_app()
{
  sfctl application create --app-name fabric:/CounterActorApplicationCSharp --app-type CounterActorApplicationTypeCSharp --app-version 1.0.0 --parameters $1
}
print_help()
{
  echo "Additional Options"
  echo "-onebox (Default): If you are deploying application on one box cluster"
  echo "-multinode: If you are deploying application on a multi node cluster"
}

if [ "$1" = "--help" ]
  then
    print_help
    exit 0
fi

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
sfctl application upload --path $appPkg --show-progress -t 1200
sfctl application provision --application-type-build-path CounterActorApplicationCSharp 
if [ $# -eq 0 ]
  then
    echo "No arguments supplied, proceed with default instanceCount of 1"
    create_app "{\"CounterActorWebService_InstanceCount\":\"1\"}" 
  elif [ $1 = "-onebox" ]
  then
    echo "Onebox environment, proceed with default instanceCount of 1."
    create_app "{\"CounterActorWebService_InstanceCount\":\"1\"}" 
  elif [ $1 = "-multinode" ]
  then
    echo "Multinode env, proceed with default instanceCount of -1"
    create_app {}
fi