#!/bin/bash

sfctl application delete --application-id CounterActorApplication
sfctl application unprovision --application-type-name CounterActorApplicationType --application-type-version 1.0.0
sfctl store delete --content-path CounterActorApplication