# .dotfiles

Continuously upgraded collection of useful configurations and scripts
to setup a new system from scratch.

## Setup new system

To setup a new system run

```sh
setup.sh -n # -n to disable dry run (-h for extra options)
```

That is gonna run all the scripts in `setup/`.
Each directory name in `setup/` must be in the form `$PRIORITY_$PROG_NAME` and contain:

- a required `setup` bash script that contains two functions:
  - setup
    - installs packages if needed / clone and compile from git
    - symlinks config
  - config
    - copies the program's `.config/PROGRAM` directory into `~/.config/PROGRAM` (if it's not simlinked)
- an optional `shell.sh` shell file that is gonna be sourced in the selected rc file to add aliases/variables and edit path
- optional subdirectories with the same structure, which would make the directory a sort of category (like `00_shell`)

For more details just look into `./setup/.template/`.
To create a new setup just copy that to a new directory in setup:

```sh
cp ./setup/template ./setup/$PRIORITY_$PROG_NAME
```

Replace `$PRIORITY` with a number between 00 and 99, and `$PROG_NAME` with the name of the program to install and/or config. Make sure the number you choose for the priority, comes after the dependencies you need to install `$PROG_NAME` (i.e. git, make, etc...).
