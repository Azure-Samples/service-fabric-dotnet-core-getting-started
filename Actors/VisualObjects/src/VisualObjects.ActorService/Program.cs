// ------------------------------------------------------------
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//  Licensed under the MIT License (MIT). See License.txt in the repo root for license information.
// ------------------------------------------------------------

namespace VisualObjects.ActorService
{
    using System;
    using System.Threading;
    using Microsoft.ServiceFabric.Actors.Runtime;
    using System.Diagnostics.Tracing;

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
                ActorEventListener listener = new ActorEventListener("VisualObjects.ActorService");
                listener.EnableEvents(ActorEventSource.Current, EventLevel.LogAlways, EventKeywords.All);

                // This line registers an Actor Service to host your actor class with the Service Fabric runtime.
                // For more information, see http://aka.ms/servicefabricactorsplatform

                ActorRuntime.RegisterActorAsync<VisualObjectActor>().GetAwaiter().GetResult();

                Thread.Sleep(Timeout.Infinite);
            }
            catch (Exception e)
            {
                ActorEventSource.Current.ActorHostInitializationFailed(e.ToString());
                throw;
            }
        }
    }
}
