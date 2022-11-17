#!/bin/bash --login

# ---------------------------------------------------------------------------
# This script should be called by the jupyter-notebook-icsf script
# from nyx5,6,7.
#
# Load the anaconda modulefile and start a Jupyter Notebook server
# without popping up a browser. It will listen on the port supplied
# as the first arg to this script (the port num is required!)
#
# Jupyter is the new name for iPython (the language agnostic part).
#
# Given we will be called from another host (nyx3 mainly) via ssh
# then we need to trap SIGINT and send the Jupyter server two
# CTRL+C's (SIGINTs) to shutdown. There is no nice way to shutdown
# an Jupyter server other than with two CTRL+C's.
#
# Arg2 is optional - can supply the version number of Anaconda Python
# to load. This should be the version number used by the modulefiles
# on iCSF. For example: 1.9.2 or 3/2.3.0
# If not supplied the default (latest) modulefile will be loaded).
#
# We now also set an env var JUPYTER_EXAMPLE pointing to the example_job dir
#
# george.leaver@manchester.ac.uk, RI Team, Mar 2018
# ---------------------------------------------------------------------------

# This will be called when the script receives an interrupt
# from the ssh call that launched us.
function finish {
  if [ -n "$IPID" ]; then
    # Give the Jupyter server two CTRL+C's to shutdown.
    # This seems to have stopped working with python3
    #kill -s SIGINT $IPID 2>/dev/null
    #kill -s SIGINT $IPID 2>/dev/null
    kill -s TERM $IPID 2>/dev/null
    if [ "$?" -eq "0" ]; then
      wait $IPID
      echo ""
      echo "Terminated Jupyter Notebook on $HOSTNAME (PID $IPID)."
      echo "If the command-prompt does not appear, press Ctrl+C again."
      echo ""
      exit
    fi
  fi
}
trap finish EXIT SIGINT SIGTERM SIGHUP SIGKILL

if [ $# -lt 1 ]; then
  echo First arg must be a port number
  exit 1;
fi

# Optional second arg
if [ $# -eq 2 ]; then
  CONDAVER=$2
fi

# Optional virtual environment to activate
if [ $# -eq 3 ]; then
  VENV=$3
fi

# Report backend iCSF node
echo "Setting up jupyter notenook on iCSF node `hostname -s` ..."
echo ""

# Load the given version of anaconda python (gives us Jupyter)
if [ -n "$CONDAVER" ]; then
  echo "Starting Jupyter Notebook server (in Anaconda Python $CONDAVER) on $HOSTNAME ..."

  if [ `echo $CONDAVER | grep -c "/"` -eq 1 ]; then
    module load apps/binapps/anaconda$CONDAVER
  else
    module load apps/binapps/anaconda/$CONDAVER
  fi
  MODCOUNT=`module list 2>&1 | grep -c $CONDAVER`
  if [ $MODCOUNT -eq 0 ]; then
    echo "Unable to load Anaconda version $CONDAVER. Using latest installed version..."
    module load apps/binapps/anaconda3/2019.07
  fi
else
  echo "Starting Jupyter Notebook server (in Anaconda Python) on $HOSTNAME ..."

  module load apps/binapps/anaconda3/2019.07
fi

if [ ! -z $VENV ]; then
  if source $VENV/bin/activate; then
    echo "Loaded virtual environment $VENV"
  else
    echo "venv '$VENV' not found. Did not load venv."
  fi
fi

# Load the latest version of R so that %Rmagic commands work
module load apps/gcc/R
module load tools/env/proxy

# Set an env var we can use in online docs to locate an example script
export JUPYTER_EXAMPLE=/opt/gridware/scripts/example_job
export JUPYTER_HOME=/opt/gridware/scripts

# Start the server.

# Mar 2018 - I'm commenting this out and will force users on to incline256 (el7) nodes.

# Aug-2017. Looks like libreadline.so.6.2 is broken in anaconda (again).
# Use the system-wide version (we've needed this trick before with rpy2.)
# env LD_PRELOAD=/lib64/libreadline.so.6.0 jupyter notebook --no-browser --port $1 &

python -m jupyter notebook --no-browser --port $1 &
IPID=$!

# Output a reminder about shutting down after the server starts
sleep 8
echo ""
echo "======= ** IMPORTANT - YOU MUST DO THIS WHEN FINISHED WITH Jupyter ** ======="
echo " Please use CTRL-C in this window to terminate Jupyter Notebook on $HOSTNAME"
echo " (PID $IPID) ..."
echo ""
# Wait for the server to finish
wait $IPID
