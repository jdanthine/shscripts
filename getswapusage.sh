#!/bin/bash
for PROCID in `find /proc/ -maxdepth 1 -type d | egrep "^/proc/[0-9]" | cut -d / -f 3` ; do
if [ -f /proc/$PROCID/status ] 
then
  # add 0, so if VmSwap not found in status file, SWAPSIZE is initalized to 0
  let SWAPSIZE=`grep VmSwap /proc/$PROCID/status |  awk '{ print $2 }'`+0
  if [ $SWAPSIZE -gt 0 ] 
  then 
     PROCNAME=`ps -p $PROCID -o command --no-header`
     echo "$PROCID  - ${SWAPSIZE} Kb ( ${PROCNAME:0:100} )"
  fi
fi
done

