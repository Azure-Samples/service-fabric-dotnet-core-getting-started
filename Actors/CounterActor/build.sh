#!/bin/bash
DIR=`dirname $0`
/opt/microsoft/servicefabric/bin/Fabric/Fabric.Code/dotnet/dotnet restore $DIR/../CounterActor/src/CounterActorApplication/CounterActor.Interfaces/project.json -s /opt/microsoft/sdk/servicefabric/csharp/packages -s https://dotnet.myget.org/F/dotnet-core/api/v3/index.json -s https://api.nuget.org/v3/index.json
/opt/microsoft/servicefabric/bin/Fabric/Fabric.Code/dotnet/dotnet build $DIR/../CounterActor/src/CounterActorApplication/CounterActor.Interfaces/project.json

/opt/microsoft/servicefabric/bin/Fabric/Fabric.Code/dotnet/dotnet restore $DIR/../CounterActor/src/CounterActorApplication/CounterActor/project.json -s /opt/microsoft/sdk/servicefabric/csharp/packagesp -s https://dotnet.myget.org/F/dotnet-core/api/v3/index.json -s https://api.nuget.org/v3/index.json
/opt/microsoft/servicefabric/bin/Fabric/Fabric.Code/dotnet/dotnet build $DIR/../CounterActor/src/CounterActorApplication/CounterActor/project.json
/opt/microsoft/servicefabric/bin/Fabric/Fabric.Code/dotnet/dotnet publish $DIR/../CounterActor/src/CounterActorApplication/CounterActor/project.json -o $DIR/../CounterActor/CounterActorApplication/CounterActorPkg/Code


/opt/microsoft/servicefabric/bin/Fabric/Fabric.Code/dotnet/dotnet restore $DIR/../CounterActor/src/CounterActorApplication/CounterActorTestClient/project.json -s /opt/microsoft/sdk/servicefabric/csharp/packages -s https://dotnet.myget.org/F/dotnet-core/api/v3/index.json -s https://api.nuget.org/v3/index.json
/opt/microsoft/servicefabric/bin/Fabric/Fabric.Code/dotnet/dotnet build $DIR/../CounterActor/src/CounterActorApplication/CounterActorTestClient/project.json
/opt/microsoft/servicefabric/bin/Fabric/Fabric.Code/dotnet/dotnet publish $DIR/../CounterActor/src/CounterActorApplication/CounterActorTestClient/project.json -o $DIR/../CounterActor/CounterActorTestClient

/opt/microsoft/servicefabric/bin/Fabric/Fabric.Code/dotnet/dotnet restore $DIR/../CounterActor/src/CounterActorApplication/CounterActor.WebService/CounterActorWebService/project.json -s /opt/microsoft/sdk/servicefabric/csharp/packages -s https://dotnet.myget.org/F/dotnet-core/api/v3/index.json -s https://api.nuget.org/v3/index.json
/opt/microsoft/servicefabric/bin/Fabric/Fabric.Code/dotnet/dotnet build $DIR/../CounterActor/src/CounterActorApplication/CounterActor.WebService/CounterActorWebService/project.json
/opt/microsoft/servicefabric/bin/Fabric/Fabric.Code/dotnet/dotnet publish $DIR/../CounterActor/src/CounterActorApplication/CounterActor.WebService/CounterActorWebService/project.json -o $DIR/../CounterActor/CounterActorApplication/CounterActorWebServicePkg/Code/