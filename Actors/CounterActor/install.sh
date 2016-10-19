#!/bin/bash

azure servicefabric application package copy CounterActorApplication fabric:ImageStore
azure servicefabric application type register CounterActorApplication
azure servicefabric application create fabric:/CounterActorApplication CounterActorApplicationType 1.0.0