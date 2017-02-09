#!/bin/bash
DIR=`dirname $0`
dotnet restore $DIR/../CounterActor/src/CounterActorApplication/CounterActor.Interfaces/project.json -s /opt/microsoft/sdk/servicefabric/csharp/packages -s https://api.nuget.org/v3/index.json
dotnet build $DIR/../CounterActor/src/CounterActorApplication/CounterActor.Interfaces/project.json

dotnet restore $DIR/../CounterActor/src/CounterActorApplication/CounterActor/project.json -s /opt/microsoft/sdk/servicefabric/csharp/packages -s https://api.nuget.org/v3/index.json
dotnet build $DIR/../CounterActor/src/CounterActorApplication/CounterActor/project.json
dotnet publish $DIR/../CounterActor/src/CounterActorApplication/CounterActor/project.json -o $DIR/../CounterActor/CounterActorApplication/CounterActorPkg/Code


dotnet restore $DIR/../CounterActor/src/CounterActorApplication/CounterActorTestClient/project.json -s /opt/microsoft/sdk/servicefabric/csharp/packages -s https://api.nuget.org/v3/index.json
dotnet build $DIR/../CounterActor/src/CounterActorApplication/CounterActorTestClient/project.json
dotnet publish $DIR/../CounterActor/src/CounterActorApplication/CounterActorTestClient/project.json -o $DIR/../CounterActor/CounterActorTestClient

dotnet restore $DIR/../CounterActor/src/CounterActorApplication/CounterActor.WebService/CounterActorWebService/project.json -s /opt/microsoft/sdk/servicefabric/csharp/packages -s https://api.nuget.org/v3/index.json
dotnet build $DIR/../CounterActor/src/CounterActorApplication/CounterActor.WebService/CounterActorWebService/project.json
dotnet publish $DIR/../CounterActor/src/CounterActorApplication/CounterActor.WebService/CounterActorWebService/project.json -o $DIR/../CounterActor/CounterActorApplication/CounterActorWebServicePkg/Code/
