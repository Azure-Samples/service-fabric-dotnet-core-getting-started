#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

appPkg="$DIR/CounterServiceApplication"

WebServiceManifestlocation="$appPkg/CounterServiceWebServicePkg"
WebServiceManifestlocationLinux="$WebServiceManifestlocation/ServiceManifest-Linux.xml"
WebServiceManifestlocationWindows="$WebServiceManifestlocation/ServiceManifest-Windows.xml"
WebServiceManifestlocation="$WebServiceManifestlocation/ServiceManifest.xml"
cp $WebServiceManifestlocationLinux $WebServiceManifestlocation 


StatefulServiceManifestlocation="$appPkg/CounterServicePkg"
StatefulServiceManifestlocationLinux="$StatefulServiceManifestlocation/ServiceManifest-Linux.xml"
StatefulServiceManifestlocationWindows="$StatefulServiceManifestlocation/ServiceManifest-Windows.xml"
StatefulServiceManifestlocation="$StatefulServiceManifestlocation/ServiceManifest.xml"
cp $StatefulServiceManifestlocationLinux $StatefulServiceManifestlocation
cp dotnet-include.sh ./CounterServiceApplication/CounterServicePkg/Code
cp dotnet-include.sh ./CounterServiceApplication/CounterServiceWebServicePkg/Code
sfctl application upload --path CounterServiceApplication --show-progress
sfctl application provision --application-type-build-path CounterServiceApplication
if [ $# -eq 0 ]
  then
    echo "No arguments supplied, proceed with default instanceCount of 1"
    sfctl application create --app-name fabric:/CounterServiceApplication --app-type CounterServiceApplicationType --app-version 1.0.0 --parameters "{\"CounterServiceWebService_InstanceCount\":\"1\"}"
  elif [ $1 = 0 ]
  then
    echo "Onebox environment, proceed with default instanceCount of 1."
    sfctl application create --app-name fabric:/CounterServiceApplication --app-type CounterServiceApplicationType --app-version 1.0.0 --parameters "{\"CounterServiceWebService_InstanceCount\":\"1\"}"
  elif [ $1 = 1 ]
  then
    echo "Multinode env, proceed with default instanceCount of -1"
    sfctl application create --app-name fabric:/CounterServiceApplication --app-type CounterServiceApplicationType --app-version 1.0.0
fi