#!/bin/bash

azure servicefabric application delete fabric:/CounterActorApplication
azure servicefabric application type unregister CounterActorApplicationType 1.0.0