﻿// ------------------------------------------------------------
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//  Licensed under the MIT License (MIT). See License.txt in the repo root for license information.
// ------------------------------------------------------------

namespace VisualObjects.WebService
{
    using System;
    using System.Diagnostics.Tracing;
    using System.Threading.Tasks;
    using Microsoft.ServiceFabric.Services.Runtime;

    [EventSource(Name = "MyCompany-VisualObjectsApplication-VisualObjects")]
    internal sealed class ServiceEventSource : EventSource
    {
        private const int MessageEventId = 1;
        private const int ServiceMessageEventId = 2;
        private const int ServiceTypeRegisteredEventId = 3;
        private const int ServiceHostInitializationFailedEventId = 4;

        // A pair of events sharing the same name prefix with a "Start"/"Stop" suffix implicitly marks boundaries of an event tracing activity.
        // These activities can be automatically picked up by debugging and profiling tools, which can compute their execution time, child activities,
        // and other statistics.
        private const int ServiceRequestStartEventId = 5;
        private const int ServiceRequestStopEventId = 6;

        private const int ServiceRequestFailedEventId = 7;
        private const int WebHostInitializationFailedEventId = 8;

        public static readonly ServiceEventSource Current = new ServiceEventSource();

        // Instance constructor is private to enforce singleton semantics
        private ServiceEventSource() : base()
        {
        }

        // Define an instance method for each event you want to record and apply an [Event] attribute to it.
        // The method name is the name of the event.
        // Pass any parameters you want to record with the event (only primitive integer types, DateTime, Guid & string are allowed).
        // Each event method implementation should check whether the event source is enabled, and if it is, call WriteEvent() method to raise the event.
        // The number and types of arguments passed to every event method must exactly match what is passed to WriteEvent().
        // Put [NonEvent] attribute on all methods that do not define an event.
        // For more information see https://msdn.microsoft.com/en-us/library/system.diagnostics.tracing.eventsource.aspx

        [NonEvent]
        public void Message(string message, params object[] args)
        {
            if (this.IsEnabled())
            {
                string finalMessage = string.Format(message, args);
                this.Message(finalMessage);
            }
        }

        [Event(MessageEventId, Level = EventLevel.Informational, Message = "{0}")]
        public void Message(string message)
        {
            if (this.IsEnabled())
            {
                this.WriteEvent(MessageEventId, message);
            }
        }

        [NonEvent]
        public void ServiceMessage(StatefulService service, string message, params object[] args)
        {
            if (this.IsEnabled())
            {
                string finalMessage = string.Format(message, args);
                this.ServiceMessage(
                    service.Context.ServiceName.ToString(),
                    service.Context.ServiceTypeName,
                    service.Context.ReplicaId,
                    service.Context.PartitionId,
                    service.Context.CodePackageActivationContext.ApplicationName,
                    service.Context.CodePackageActivationContext.ApplicationTypeName,
                    service.Context.NodeContext.NodeName,
                    finalMessage);
            }
        }

        [Event(ServiceTypeRegisteredEventId, Level = EventLevel.Informational, Message = "Service host process {0} registered service type {1}",
            Keywords = Keywords.ServiceInitialization)]
        public void ServiceTypeRegistered(int hostProcessId, string serviceType)
        {
            this.WriteEvent(ServiceTypeRegisteredEventId, hostProcessId, serviceType);
        }

        [Event(ServiceHostInitializationFailedEventId, Level = EventLevel.Error, Message = "Service host initialization failed",
            Keywords = Keywords.ServiceInitialization)]
        public void ServiceHostInitializationFailed(string exception)
        {
            this.WriteEvent(ServiceHostInitializationFailedEventId, exception);
        }

        [Event(ServiceRequestStartEventId, Level = EventLevel.Informational, Message = "Service request '{0}' started", Keywords = Keywords.Requests)]
        public void ServiceRequestStart(string requestTypeName)
        {
            this.WriteEvent(ServiceRequestStartEventId, requestTypeName);
        }

        [Event(ServiceRequestStopEventId, Level = EventLevel.Informational, Message = "Service request '{0}' finished", Keywords = Keywords.Requests)]
        public void ServiceRequestStop(string requestTypeName)
        {
            this.WriteEvent(ServiceRequestStopEventId, requestTypeName);
        }

        [Event(ServiceRequestFailedEventId, Level = EventLevel.Error, Message = "Service request '{0}' failed", Keywords = Keywords.Requests)]
        public void ServiceRequestFailed(string requestTypeName, string exception)
        {
            this.WriteEvent(ServiceRequestFailedEventId, exception);
        }

        [Event(ServiceMessageEventId, Level = EventLevel.Informational, Message = "{7}")]
        private
        void ServiceMessage(
            string serviceName,
            string serviceTypeName,
            long replicaOrInstanceId,
            Guid partitionId,
            string applicationName,
            string applicationTypeName,
            string nodeName,
            string message)
        {
            this.WriteEvent(
                ServiceMessageEventId,
                serviceName,
                serviceTypeName,
                replicaOrInstanceId,
                partitionId,
                applicationName,
                applicationTypeName,
                nodeName,
                message);
        }

        [Event(WebHostInitializationFailedEventId, Level = EventLevel.Error, Message = "Web host initialization failed")]
        public void WebHostInitializationFailed(string exception)
        {
            this.WriteEvent(WebHostInitializationFailedEventId, exception);
        }

        // Event keywords can be used to categorize events. 
        // Each keyword is a bit flag. A single event can be associated with multiple keywords (via EventAttribute.Keywords property).
        // Keywords must be defined as a public class named 'Keywords' inside EventSource that uses them.
        public static class Keywords
        {
            public const EventKeywords Requests = (EventKeywords)0x1L;
            public const EventKeywords ServiceInitialization = (EventKeywords)0x2L;
        }
    }
}
