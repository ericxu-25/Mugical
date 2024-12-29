USERNAME:= $(git config --global user.name)
ROOT_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
BIN_DIR:= $(ROOT_DIR).local/bin
CONFIG_DIR:= $(ROOT_DIR).local/.config
EXAMPLES_DIR:=$(ROOT_DIR)examples

.PHONY: help 
.PHONY: initialize_environment
.PHONY: slim_environment
.PHONY: example 
.PHONY: submodules

# print help dialog
help:
	@ echo "===   Make Help   ==="
	@ echo "command list"
	@ echo ">        setup_slim: downloads only required packages with pacman"
	@ echo ">         setup_env: downloads all packages with pacman"
	@ echo ">         setup_git: sets up local git configuration"
	@ echo ">           example: run a script to start an example"
	@ echo "unimplemented commands"
	@ echo ">             godot: compile and run godot"
	@ echo ">              work: startup our working production environment"
	@ echo "=== End Make Help ==="

# setup git ssh (interactive)
setup_git: 
	$(BIN_DIR)/git_setup.sh

# initialize submodules
submodules:
	git submodule init
	git submodule update

# delegate to a bash script to setup our environment
setup_env: submodules
	$(BIN_DIR)/env_init.sh $(CONFIG_DIR)

# same as setup_env but skips over unecessary packages
setup_slim: submodules
	$(BIN_DIR)/env_init.sh $(CONFIG_DIR) -s

example:
	@echo "root directory: "$(ROOT_DIR)
	@ echo "Running Mugic Example"
	@ $(BIN_DIR)/run_example.sh $(EXAMPLES_DIR)

