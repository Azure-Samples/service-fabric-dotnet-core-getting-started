// ------------------------------------------------------------
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//  Licensed under the MIT License (MIT). See License.txt in the repo root for license information.
// ------------------------------------------------------------

namespace VisualObjects.WebService
{
    using System;
    using System.Fabric;
    using System.Fabric.Description;
    using System.Globalization;
    using System.Threading;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Hosting;
    using Microsoft.ServiceFabric.Services.Communication.Runtime;
    using System.IO;
    using System.Reflection;

    public class WebCommunicationListener : ICommunicationListener
    {
        private readonly string appRoot;
        private readonly ServiceContext serviceInitializationParameters;
        private string listeningAddress;
        private string publishAddress;

        // OWIN server handle.
        private IWebHost webHost;

        public WebCommunicationListener(string appRoot, ServiceContext serviceInitializationParameters)
        {
            this.appRoot = appRoot;
            this.serviceInitializationParameters = serviceInitializationParameters;
        }

        public Task<string> OpenAsync(CancellationToken cancellationToken)
        {
            ServiceEventSource.Current.Message("Initialize");

            EndpointResourceDescription serviceEndpoint = this.serviceInitializationParameters.CodePackageActivationContext.GetEndpoint("ServiceEndpoint");
            int port = serviceEndpoint.Port;

            this.listeningAddress = string.Format(
                CultureInfo.InvariantCulture,
                "http://+:{0}/{1}",
                port,
                string.IsNullOrWhiteSpace(this.appRoot)
                    ? string.Empty
                    : this.appRoot.TrimEnd('/') + '/');

            this.publishAddress = this.listeningAddress.Replace("+", FabricRuntime.GetNodeContext().IPAddressOrFQDN);

            ServiceEventSource.Current.Message("Starting web server on {0}", this.listeningAddress);

            try
            {
                string rootDir = Path.GetDirectoryName(Assembly.GetEntryAssembly().Location);

                this.webHost = new WebHostBuilder()
               .UseKestrel()
               .UseContentRoot(rootDir)
               .UseStartup<Startup>()
               .UseUrls(this.listeningAddress)
               .Build();

                this.webHost.Start();
            }
            catch (Exception ex)
            {
                ServiceEventSource.Current.WebHostInitializationFailed(ex.ToString());
            }

            return Task.FromResult(this.publishAddress);
        }

        public Task CloseAsync(CancellationToken cancellationToken)
        {
            this.StopAll();
            return Task.FromResult(true);
        }

        public void Abort()
        {
            this.StopAll();
        }

        /// <summary>
        /// Stops, cancels, and disposes everything.
        /// </summary>
        private void StopAll()
        {
            try
            {
                if (this.webHost != null)
                {
                    ServiceEventSource.Current.Message("Stopping web server.");
                    this.webHost.Dispose();
                }
            }
            catch (ObjectDisposedException)
            {
            }
        }
    }
}