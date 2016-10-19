// ------------------------------------------------------------
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//  Licensed under the MIT License (MIT). See License.txt in the repo root for license information.
// ------------------------------------------------------------

namespace CalculatorActorClient
{
    using System;
    using Microsoft.ServiceFabric.Actors;
    using Microsoft.ServiceFabric.Actors.Client;
    using CalculatorActor.Interfaces;

    class Program
    {
        static void Main(string[] args)
        {
            var calculatorActorTestProxy = ActorProxy.Create<ICalculatorActor>(new ActorId(0x100), "fabric:/CalculatorActorApplication" , "CalculatorActorService");
            Random rand = new Random();
            int number1 = rand.Next(100);
            int number2 = rand.Next(100);
            try
            {
                    double sum  = calculatorActorTestProxy.AddAsync(number1, number2).Result;
                    double difference = calculatorActorTestProxy.SubtractAsync(number1, number2).Result;
                    Console.WriteLine("CalculatorActorService Call for ({0}, {1}). Sum={2} , Difference={3} ",number1,number2,sum,difference);

            }
            catch (Exception e)
            {
                    Console.WriteLine("Exception in Client = {0}", e);
            }
        }
    }
}
