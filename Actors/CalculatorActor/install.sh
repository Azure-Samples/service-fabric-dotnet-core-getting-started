#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
appPkg="$DIR/CalculatorActorApplication"

sfctl application upload --path $appPkg --show-progress
sfctl application provision --application-type-build-path CalculatorActorApplication
sfctl application create --app-name fabric:/CalculatorActorApplication --app-type CalculatorActorApplicationType --app-version 1.0.0
