// ------------------------------------------------------------
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//  Licensed under the MIT License (MIT). See License.txt in the repo root for license information.
// ------------------------------------------------------------

namespace VisualObjects.WebService
{
    using System;
    using System.Threading;
    using Microsoft.ServiceFabric.Services.Runtime;
    using System.Diagnostics.Tracing;

    public class Program
    {
        public static void Main(string[] args)
        {
            try
            {
                // Creating a new event listener to redirect service traces to a file.
                ServiceEventListener listener = new ServiceEventListener("VisualObjects.WebService");
                listener.EnableEvents(ServiceEventSource.Current, EventLevel.LogAlways, EventKeywords.All);

                ServiceRuntime.RegisterServiceAsync(Service.ServiceTypeName, context => new Service(context)).GetAwaiter().GetResult();

                Thread.Sleep(Timeout.Infinite);
            }
            catch (Exception e)
            {
                ServiceEventSource.Current.ServiceHostInitializationFailed(e.ToString());
                throw;
            }
        }
    }
}