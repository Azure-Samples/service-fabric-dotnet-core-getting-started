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

. /etc/os-release
linuxDistrib=$ID
if [ $linuxDistrib = "rhel" ]; then
  source scl_source enable rh-dotnet20
  exitCode=$?
  if [ $exitCode != 0 ]; then
        echo "Failed: source scl_source enable rh-dotnet20 : ExitCode: $exitCode"
        exit $exitCode
  fi
fi

dotnet $DIR/CounterService.dll $@
check_errs $?
