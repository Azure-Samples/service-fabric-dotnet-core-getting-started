// ------------------------------------------------------------
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//  Licensed under the MIT License (MIT). See License.txt in the repo root for license information.
// ------------------------------------------------------------

namespace CalculatorActor.Interfaces
{
    using Microsoft.ServiceFabric.Actors;
    using System.Threading.Tasks;

    /// <summary>
    /// This interface defines the methods exposed by an actor.
    /// Clients use this interface to interact with the actor that implements it.
    /// </summary>
    public interface ICalculatorActor : IActor
    {
        Task<double> AddAsync(double valueOne, double valueTwo);
        Task<double> SubtractAsync(double valueOne, double valueTwo);
    }
}
