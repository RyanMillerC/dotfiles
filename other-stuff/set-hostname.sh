#!/bin/bash

FQDN='mac5.taco.moe'
MACHINE_NAME='mac5'

sudo scutil --set HostName "$FQDN"
sudo scutil --set LocalHostName "$MACHINE_NAME"
sudo scutil --set ComputerName "$MACHINE_NAME"
dscacheutil -flushcache
