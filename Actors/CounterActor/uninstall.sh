#!/bin/bash

sfctl application delete --application-id CounterActorApplicationCSharp
sfctl application unprovision --application-type-name CounterActorApplicationTypeCSharp --application-type-version 1.0.0
sfctl store delete --content-path CounterActorApplicationCSharp
rm ./CounterActorApplicationCSharp/CounterActorPkg/Code/dotnet-include.sh
rm ./CounterActorApplicationCSharp/CounterActorWebServicePkg/Code/dotnet-include.sh
rm ./CounterActorTestClient/dotnet-include.sh