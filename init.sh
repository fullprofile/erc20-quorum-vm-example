#!/bin/bash

set -euf -o pipefail

cd ../quorum
./stop.sh || true  # just in case it's being re-run
./raft-init.sh
./raft-start.sh
cd -
