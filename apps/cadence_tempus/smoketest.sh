#!/bin/bash

INSTALL_DIR="/datadrive"

cd ${INSTALL_DIR}/work/Tempus171_RAK/block_scope/work

tempus -distributed -init ../scripts/run_full_chip.tcl
echo "check monitor_host.log* file for results."

