// ------------------------------------------------------------
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//  Licensed under the MIT License (MIT). See License.txt in the repo root for license information.
// ------------------------------------------------------------

namespace CounterActorApp
{
    using System;
    using System.Threading.Tasks;
    using Microsoft.ServiceFabric.Actors;
    using Microsoft.ServiceFabric.Actors.Runtime;
    using Microsoft.ServiceFabric.Actors.Client;
    using CounterActor.Interfaces;

    /// <remarks>
    /// This class represents an actor.
    /// Every ActorID maps to an instance of this class.
    /// The StatePersistence attribute determines persistence and replication of actor state:
    ///  - Persisted: State is written to disk and replicated.
    ///  - Volatile: State is kept in memory only and replicated.
    ///  - None: State is kept in memory only and not replicated.
    /// </remarks>
    [ActorServiceAttribute(Name="CounterActor")]
    [StatePersistence(StatePersistence.Persisted)]
    internal class CounterActorService : Actor, ICounterActor
    {
        /// <summary>
        /// This method is called whenever an actor is activated.
        /// An actor is activated the first time any of its methods are invoked.
        /// </summary>
        public CounterActorService(ActorService actorService, ActorId actorId) : base(actorService, actorId)
        {
        }
        
        protected override Task OnActivateAsync()
        {
            RegisterTimer(AsyncCallback, null, TimeSpan.FromMilliseconds(100), TimeSpan.FromMilliseconds(100));

            // The StateManager is this actor's private state store.
            // Data stored in the StateManager will be replicated for high-availability for actors that use volatile or persisted state storage.
            // Any serializable object can be saved in the StateManager.
            // For more information, see http://aka.ms/servicefabricactorsstateserialization
            return this.StateManager.TryAddStateAsync("count", 0);
        }

        private Task AsyncCallback(object o)
        {
            int count = this.StateManager.GetStateAsync<int>("count").Result + 1;
            return this.StateManager.AddOrUpdateStateAsync("count", count, (key, value) => count > value ? count : value);
        }

        Task<int> ICounterActor.GetCountAsync()
        {
            ActorEventSource.Current.Message("Count is {0}", this.StateManager.GetStateAsync<int>("count").Result);
            return this.StateManager.GetStateAsync<int>("count");
        }

        Task ICounterActor.SetCountAsync(int count)
        {
            // Requests are not guaranteed to be processed in order nor at most once.
            // The update function here verifies that the incoming count is greater than the current count to preserve order.
            return this.StateManager.AddOrUpdateStateAsync("count", count, (key, value) => count > value ? count : value);
        }
    }
}
