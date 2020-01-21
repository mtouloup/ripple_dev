#/bin/bash

#Create Directories for ripple
mkdir ripple_backup
mkdir /ripple_backup/db_path
mkdir /ripple_backup/debug_log
mkdir /ripple_backup/node_db_path

#Create a copy of the example config file
mkdir -p ~/.config/ripple
cp tmp/rippled-example.cfg ~/.config/ripple/rippled.cfg

#Create a copy of the validators file
cp rippled/cfg/validators-example.txt ~/.config/ripple/validators.txt