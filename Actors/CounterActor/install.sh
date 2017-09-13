#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
appPkg="$DIR/CounterActorApplication"

sfctl application upload --path $appPkg --show-progress
sfctl application provision --application-type-build-path CounterActorApplication
sfctl application create --app-name fabric:/CounterActorApplication --app-type CounterActorApplicationType --app-version 1.0.0