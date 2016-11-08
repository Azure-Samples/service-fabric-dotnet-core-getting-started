// ------------------------------------------------------------
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//  Licensed under the MIT License (MIT). See License.txt in the repo root for license information.
// ------------------------------------------------------------

namespace VisualObjects.WebService
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Builder;
    using Microsoft.AspNetCore.Http;
    using System.Net.WebSockets;
    using Microsoft.Extensions.Logging;
    using System.Threading;
    using System.Text;
    using Microsoft.Extensions.DependencyInjection;
    using Microsoft.AspNetCore.Hosting;
    using Microsoft.Extensions.FileProviders;
    using System.IO;
    using System.Reflection;

    public class Startup
    {
        public static CancellationTokenSource CancellationTokenSource = new CancellationTokenSource();

        // This method gets called by the runtime. Use this method to add services to the container. 
        // For more information on how to configure your application, visit http://go.microsoft.com/fwlink/?LinkID=398940 
        public void ConfigureServices(IServiceCollection services)
        {
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline. 
        public void Configure(IApplicationBuilder app, Microsoft.AspNetCore.Hosting.IHostingEnvironment env, ILoggerFactory loggerFactory)
        {
            string rootDir = Path.GetDirectoryName(Assembly.GetEntryAssembly().Location);

            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseWebSockets();

            app.UseDefaultFiles();
            
            app.UseStaticFiles();

            app.Use(async (context, next) =>
            {
                if (context.WebSockets.IsWebSocketRequest)
                {
                    WebSocket webSocket = await context.WebSockets.AcceptWebSocketAsync();
                    await Startup.SendData(context, webSocket);
                }
                else
                {
                    await next();
                }
            });
        }

        private static async Task SendData(HttpContext context, WebSocket webSocket)
        {
            ServiceEventSource.Current.Message("Connection from: {0}", context.Connection.RemoteIpAddress);

            while (true)
            {
                byte[] buffer = Encoding.UTF8.GetBytes(VisualObjectsBox.Current.GetJson());

                try
                {
                    await webSocket.SendAsync(new ArraySegment<byte>(buffer, 0, buffer.Length),
                                                    WebSocketMessageType.Text,
                                                    true, 
                                                    Startup.CancellationTokenSource.Token);

                    if (webSocket.State != WebSocketState.Open)
                    {
                        break;
                    }
                }
                catch (WebSocketException ex)
                {
                    // If the browser quit or the socket was closed, exit this loop so we can get a new browser socket.
                    ServiceEventSource.Current.Message(ex.InnerException != null ? ex.InnerException.Message : ex.Message);

                    break;
                }

                // wait a bit and continue. This determines the client refresh rate.
                await Task.Delay(TimeSpan.FromMilliseconds(10), Startup.CancellationTokenSource.Token);
            }

            ServiceEventSource.Current.Message("Client disconnected.");
        }
    }
}
