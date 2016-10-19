// ------------------------------------------------------------
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//  Licensed under the MIT License (MIT). See License.txt in the repo root for license information.
// ------------------------------------------------------------

namespace CounterActorClient
{
    using System;
    using Microsoft.ServiceFabric.Actors;
    using Microsoft.ServiceFabric.Actors.Client;
    using CounterActor.Interfaces;

    class Program
    {
        static void Main(string[] args)
        {
            var counterActorProxy = ActorProxy.Create<ICounterActor>(new ActorId(0x101), "fabric:/CounterActorApplication" , "CounterActor");
            int result = counterActorProxy.GetCountAsync().Result;
            Console.WriteLine("Value = {0}", result);
        }
    }
}
