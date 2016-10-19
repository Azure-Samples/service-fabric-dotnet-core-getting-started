---
services: service-fabric
platforms: .Net Core
author: prachic, raunakp
---

# Getting started with Service Fabric with .NET Core

This repository contains a set of simple sample projects to help you getting started with Service Fabric on Linux with .NET Core as the framework. As a pre requisite ensure you have the Service Fabric C# SDK installed on ubuntu box. Follow these instruction to [prepare your development environment on Linux][service-fabric-Linux-getting-started]

## How the samples are organized

The samples are divided by the category and [Service Fabric programming model][service-fabric-programming-models] that they focus on: Reliable Actors, Reliable Services. Most real applications will include a mixture of the concepts and programming models. Note that the support for reliable stateful service is not there today and will come in near future.

## Actor samples
### CounterActor

Counter Actor provides an example of a very simple actor which implements a counter. Once the service is deployed you can run the testclient to see the output of the counter on console. 
The application includes a OWIN self hosting based web service, modeled as Service Fabric reliable stateless service, accessible at http://<clusteraddress>:20003 where you can see the effect of counter incrementing on the web UI.

### CalculatorActor

Calculator Actor sample uses the actor programming model to implement two basic calculator operations, add and subtract. Once the service is deployed you can run the testclient to see the output of the calculator on console.

## Compiling the samples
For compiling the samples use the build.sh sample provided along with the sample which will use .NET core framework configured as part of the Service Fabric installation to compile the sample.

## Deploying the samples
All the samples once compiled can be deployed immediately using the install.sh scripts provided along with the sample. These scripts underneath uses azurecli. Before running the scripts you need to first connect to the cluster using azurecli.

## More information

The [Service Fabric documentation][service-fabric-docs] includes a rich set of tutorials and conceptual articles, which serve as a good complement to the samples.

<!-- Links -->

[service-fabric-programming-models]: https://azure.microsoft.com/en-us/documentation/articles/service-fabric-choose-framework/
[service-fabric-docs]: http://aka.ms/servicefabricdocs
[service-fabric-Linux-getting-started]: https://azure.microsoft.com/en-us/documentation/articles/service-fabric-get-started-linux/