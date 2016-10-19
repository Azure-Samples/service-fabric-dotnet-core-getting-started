// ------------------------------------------------------------
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//  Licensed under the MIT License (MIT). See License.txt in the repo root for license information.
// ------------------------------------------------------------

namespace CalculatorActorApp
{
    using System;
    using System.Diagnostics.Tracing;
    using System.Fabric;
    using System.Threading;
    using Microsoft.ServiceFabric.Actors.Runtime;

    internal static class Program
    {
        /// <summary>
        /// This is the entry point of the service host process.
        /// </summary>
        private static void Main()
        {
            try
            {
                //Creating a new event listener to redirect the traces to a file
                ActorEventListener listener = new ActorEventListener("CalculatorActorApplication");
                listener.EnableEvents(ActorEventSource.Current, EventLevel.LogAlways, EventKeywords.All);

                // This line registers an Actor Service to host your actor class with the Service Fabric runtime.
                ActorRuntime.RegisterActorAsync<CalculatorActorService>(
                   (context, actorType) => new ActorService(context, actorType)).GetAwaiter().GetResult();

                Thread.Sleep(Timeout.Infinite);
            }
            catch (Exception ex)
            {
                ActorEventSource.Current.ActorHostInitializationFailed(ex.ToString());
                throw;
            }
        }
    }
}
