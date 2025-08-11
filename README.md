# .dotfiles

Continuously upgraded collection of useful configurations and scripts to setup a new system

## Setup new system

To setup a new system run the `setup.sh` script which is gonna run all the scripts in `setup/`.
Each directory name in `setup/` must be in the form `$PRIORITY_$PROG_NAME` and it contains:

- a required `setup` bash script that:
  - installs package if needed
  - copies configurations over
- an optional `shell.sh` shell file that is gonna be sourced in the selected rc file to add aliases/variables and edit path
- an optional `config` bash script that copies the programs `.config/PROGRAM` directory into `~/.config/PROGRAM`
- optional subdirectories with the same structure, which would make the directory a sort of category (like `00_shell`)
