#!/bin/bash
DIR=`dirname $0`

dotnet restore $DIR/../CalculatorActor/src/CalculatorActorApplication/CalculatorActor.Interfaces/project.json -s /opt/microsoft/sdk/servicefabric/csharp/packages -s https://dotnet.myget.org/F/dotnet-core/api/v3/index.json -s https://api.nuget.org/v3/index.json
dotnet build $DIR/../CalculatorActor/src/CalculatorActorApplication/CalculatorActor.Interfaces/project.json

dotnet restore $DIR/../CalculatorActor/src/CalculatorActorApplication/CalculatorActor/project.json -s /opt/microsoft/sdk/servicefabric/csharp/packages -s https://dotnet.myget.org/F/dotnet-core/api/v3/index.json -s https://api.nuget.org/v3/index.json
dotnet build $DIR/../CalculatorActor/src/CalculatorActorApplication/CalculatorActor/project.json
dotnet publish $DIR/../CalculatorActor/src/CalculatorActorApplication/CalculatorActor/project.json -o $DIR/../CalculatorActor/CalculatorActorApplication/CalculatorActorPkg/Code


dotnet restore $DIR/../CalculatorActor/src/CalculatorActorApplication/CalculatorActorTestClient/project.json -s /opt/microsoft/sdk/servicefabric/csharp/packages -s https://dotnet.myget.org/F/dotnet-core/api/v3/index.json -s https://api.nuget.org/v3/index.json
dotnet build $DIR/../CalculatorActor/src/CalculatorActorApplication/CalculatorActorTestClient/project.json
dotnet publish $DIR/../CalculatorActor/src/CalculatorActorApplication/CalculatorActorTestClient/project.json -o $DIR/../CalculatorActor/CalculatorActorTestClient