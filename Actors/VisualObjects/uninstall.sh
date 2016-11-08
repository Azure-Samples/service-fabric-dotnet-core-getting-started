#!/bin/bash

azure servicefabric application delete fabric:/VisualObjectsApplication
azure servicefabric application type unregister VisualObjectsApplicationType 1.0.0
