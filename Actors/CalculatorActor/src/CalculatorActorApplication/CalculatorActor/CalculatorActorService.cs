// ------------------------------------------------------------
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//  Licensed under the MIT License (MIT). See License.txt in the repo root for license information.
// ------------------------------------------------------------

namespace CalculatorActorApp
{
    using System.Threading.Tasks;
    using Microsoft.ServiceFabric.Actors;
    using Microsoft.ServiceFabric.Actors.Runtime;
    using Microsoft.ServiceFabric.Actors.Client;
    using CalculatorActor.Interfaces;

    [ActorServiceAttribute(Name="CalculatorActorService")]
    [StatePersistence(StatePersistence.Persisted)]
    internal class CalculatorActorService : Actor, ICalculatorActor
    {
        public CalculatorActorService(ActorService actorService, ActorId actorId) : base(actorService, actorId)
        {
        }

        public Task<double> AddAsync(double valueOne, double valueTwo)
        {
            Task<double> sum = Task.FromResult(valueOne + valueTwo);
            ActorEventSource.Current.Message("Result of Add operation on {0}, {1} : {2}", new object[] {valueOne, valueTwo, sum.Result});
            return sum;
        }

        public Task<double> SubtractAsync(double valueOne, double valueTwo)
        {
            Task<double> difference = Task.FromResult(valueOne - valueTwo);
            ActorEventSource.Current.Message("Result of Subtract operation on {0}, {1} : {2}", new object[] {valueOne, valueTwo, difference.Result});
            return difference;
        }
    }
}
