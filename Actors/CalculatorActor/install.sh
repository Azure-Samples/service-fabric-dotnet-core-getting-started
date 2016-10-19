#!/bin/bash

azure servicefabric application package copy CalculatorActorApplication fabric:ImageStore
azure servicefabric application type register CalculatorActorApplication
azure servicefabric application create fabric:/CalculatorActorApplication CalculatorActorApplicationType 1.0.0