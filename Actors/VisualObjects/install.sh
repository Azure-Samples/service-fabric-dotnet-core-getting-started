#!/bin/bash

azure servicefabric application package copy VisualObjectsApplication fabric:ImageStore
azure servicefabric application type register VisualObjectsApplication
azure servicefabric application create fabric:/VisualObjectsApplication  VisualObjectsApplicationType 1.0.0
