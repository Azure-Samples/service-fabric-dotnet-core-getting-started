#!/bin/bash

azure servicefabric application delete fabric:/CalculatorActorApplication
azure servicefabric application type unregister CalculatorActorApplicationType 1.0.0