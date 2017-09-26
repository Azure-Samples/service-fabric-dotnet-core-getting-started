// ------------------------------------------------------------
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//  Licensed under the MIT License (MIT). See License.txt in the repo root for license information.
// ------------------------------------------------------------

namespace CounterServiceApp
{
    using Microsoft.AspNetCore.Builder;
    using Microsoft.AspNetCore.Hosting;
    using Microsoft.Extensions.Configuration;
    using Microsoft.Extensions.DependencyInjection;
    using System.Collections.Generic;
    using System.Globalization;
    using System.IO;
    using System.Text;
    using System.Threading.Tasks;
    using Microsoft.ServiceFabric.Services;
    using Microsoft.ServiceFabric.Services.Client;
    using Microsoft.ServiceFabric.Services.Remoting.Client;
    using CounterService.Interfaces;
	using System;
    public class Startup 
    {
        /// <summary>
        /// OWIN configuration
        /// </summary>
        public Startup(IHostingEnvironment env)
        {
            var builder = new ConfigurationBuilder()
                .SetBasePath(env.ContentRootPath)
                .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
                .AddJsonFile($"appsettings.{env.EnvironmentName}.json", optional: true)
                .AddEnvironmentVariables();
            Configuration = builder.Build();
        }

        public IConfigurationRoot Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            // Add framework services.
        }

        /// <summary>
        /// Configures the app builder using Web API.
        /// </summary>
        public void Configure(IApplicationBuilder app)
        {
            app.UseOwin(addToPiepline =>
            {
                addToPiepline(next =>
                {
                    return Invoke;
                });
            });
        }
        
        public Task Invoke(IDictionary<string, object> environment)
        {
        try
        {
            var counterServiceProxy = ServiceProxy.Create<ICounterService>(new Uri("fabric:/CounterServiceApplication/CounterService"),new ServicePartitionKey(1));
            long result = counterServiceProxy.GetValueAsync().Result;
            string responseText = "The value of counter is : " + result;
            byte[] responseBytes = Encoding.UTF8.GetBytes(responseText);

            // See http://owin.org/spec/owin-1.0.0.html for standard environment keys.
            var responseStream = (Stream)environment["owin.ResponseBody"];
            var responseHeaders = (IDictionary<string, string[]>)environment["owin.ResponseHeaders"];

            responseHeaders["Content-Length"] = new string[] { responseBytes.Length.ToString(CultureInfo.InvariantCulture) };
            responseHeaders["Content-Type"] = new string[] { "text/plain" };

            return responseStream.WriteAsync(responseBytes, 0, responseBytes.Length);
            }
            catch (Exception Ex)
            {
            ServiceEventSource.Current.Message("Invoke failed with Exception: {0}", Ex);
            throw;
            }
        }    
    }
}

