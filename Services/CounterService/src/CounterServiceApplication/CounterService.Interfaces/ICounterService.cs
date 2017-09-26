// ------------------------------------------------------------
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//  Licensed under the MIT License (MIT). See License.txt in the repo root for license information.
// ------------------------------------------------------------

namespace CounterService.Interfaces
{
    using System.Threading.Tasks;
    using Microsoft.ServiceFabric.Services.Remoting;
    /// <summary>
    /// This interface defines the methods exposed by an service.
    /// Clients use this interface to interact with the service that implements it.
    /// </summary>
    public interface ICounterService : IService
    {
        Task<long> GetValueAsync();
    }
}
