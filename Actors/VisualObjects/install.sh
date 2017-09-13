#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
appPkg="$DIR/VisualObjectsApplication"

sfctl application upload --path $appPkg --show-progress
sfctl application provision --application-type-build-path VisualObjectsApplication
sfctl application create --app-name fabric:/VisualObjectsApplication --app-type VisualObjectsApplicationType --app-version 1.0.0
