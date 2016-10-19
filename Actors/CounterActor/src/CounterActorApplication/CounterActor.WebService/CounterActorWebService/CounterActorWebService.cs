// ------------------------------------------------------------
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//  Licensed under the MIT License (MIT). See License.txt in the repo root for license information.
// ------------------------------------------------------------

namespace CounterActorApp
{
    using System;
    using System.Threading;
    using System.Threading.Tasks;
    using System.Fabric;
    using System.Fabric.Common;
    using System.Fabric.Description;
    using Microsoft.ServiceFabric.Services.Communication.Runtime;
    using Microsoft.ServiceFabric.Services.Runtime;
    using Microsoft.AspNetCore.Hosting;


    /// Service that handles front-end web requests and acts as a proxy to the back-end data for the UI web page.
    /// It is a stateless service that hosts a Web API application on OWIN.
    internal sealed class CounterActorWebService : StatelessService
    {
        private const String webEndpointName = "WebEndpoint";
        public CounterActorWebService(StatelessServiceContext context)
            : base(context)
        { }

        /// <summary>
        /// This is the main entry point for your service instance.
        /// </summary>
        /// <param name="cancellationToken">Canceled when Service Fabric needs to shut down this service instance.</param>
        protected override async Task RunAsync(CancellationToken cancellationToken)
        {
            ServiceEventSource.Current.Message("Initialize");
            try
            {
                var host = new WebHostBuilder()
               .UseKestrel()
               .UseStartup<Startup>()
               .UseUrls(geturl())
               .Build();
                ServiceEventSource.Current.Message("Starting web server on {0}", geturl());
                host.Start();
            }
            catch (Exception ex)
            {
                ServiceEventSource.Current.ServiceWebHostBuilderFailed(ex);
                throw ex;
            }            
        }

        private string geturl()
        {
            EndpointResourceDescription endpoint = this.Context.CodePackageActivationContext.GetEndpoint(webEndpointName);
            String port = endpoint.Port.ToString();
            String ipaddr = this.Context.NodeContext.IPAddressOrFQDN;
            String url = String.Format("http://{0}:{1}", ipaddr, port);
            return url;
        }
    }
}