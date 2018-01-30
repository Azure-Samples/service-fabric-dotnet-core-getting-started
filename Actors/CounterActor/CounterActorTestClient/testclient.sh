#!/usr/bin/env bash
check_errs()
{
  # Function. Parameter 1 is the return code
  if [ "${1}" -ne "0" ]; then
    # make our script exit with the right error code.
    exit ${1}
  fi
}

DIR=`dirname $0`
export LD_LIBRARY_PATH=/opt/microsoft/servicefabric/bin/Fabric/Fabric.Code/

source $DIR/dotnet-include.sh 

dotnet $DIR/CounterActorTestClient.dll $@
check_errs $?
