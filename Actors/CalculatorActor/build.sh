#!/bin/bash
DIR=`dirname $0`

/opt/microsoft/servicefabric/bin/Fabric/Fabric.Code/dotnet/dotnet restore $DIR/../CalculatorActor/src/CalculatorActorApplication/CalculatorActor.Interfaces/project.json -s /opt/microsoft/sdk/servicefabric/csharp/packages -s https://dotnet.myget.org/F/dotnet-core/api/v3/index.json -s https://api.nuget.org/v3/index.json
/opt/microsoft/servicefabric/bin/Fabric/Fabric.Code/dotnet/dotnet build $DIR/../CalculatorActor/src/CalculatorActorApplication/CalculatorActor.Interfaces/project.json

/opt/microsoft/servicefabric/bin/Fabric/Fabric.Code/dotnet/dotnet restore $DIR/../CalculatorActor/src/CalculatorActorApplication/CalculatorActor/project.json -s /opt/microsoft/sdk/servicefabric/csharp/packages -s https://dotnet.myget.org/F/dotnet-core/api/v3/index.json -s https://api.nuget.org/v3/index.json
/opt/microsoft/servicefabric/bin/Fabric/Fabric.Code/dotnet/dotnet build $DIR/../CalculatorActor/src/CalculatorActorApplication/CalculatorActor/project.json
/opt/microsoft/servicefabric/bin/Fabric/Fabric.Code/dotnet/dotnet publish $DIR/../CalculatorActor/src/CalculatorActorApplication/CalculatorActor/project.json -o $DIR/../CalculatorActor/CalculatorActorApplication/CalculatorActorPkg/Code


/opt/microsoft/servicefabric/bin/Fabric/Fabric.Code/dotnet/dotnet restore $DIR/../CalculatorActor/src/CalculatorActorApplication/CalculatorActorTestClient/project.json -s /opt/microsoft/sdk/servicefabric/csharp/packages -s https://dotnet.myget.org/F/dotnet-core/api/v3/index.json -s https://api.nuget.org/v3/index.json
/opt/microsoft/servicefabric/bin/Fabric/Fabric.Code/dotnet/dotnet build $DIR/../CalculatorActor/src/CalculatorActorApplication/CalculatorActorTestClient/project.json
/opt/microsoft/servicefabric/bin/Fabric/Fabric.Code/dotnet/dotnet publish $DIR/../CalculatorActor/src/CalculatorActorApplication/CalculatorActorTestClient/project.json -o $DIR/../CalculatorActor/CalculatorActorTestClient