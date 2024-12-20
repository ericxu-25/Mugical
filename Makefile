USERNAME:= $(git config --global user.name)
ROOT_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
BIN_DIR:= $(ROOT_DIR).local/bin
CONFIG_DIR:= $(ROOT_DIR).local/.config
EXAMPLES_DIR:=$(ROOT_DIR)examples

.PHONY: all
.PHONY: initialize_environment
.PHONY: example 
all:
	@ echo "Makefile under construction"

setup_environment:
	@echo "root directory: "$(ROOT_DIR)
	# initialize submodules
	git submodule init
	git submodule update
	# delegate to a bash script to setup our environment
	$(BIN_DIR)/env_init.sh $(CONFIG_DIR)

example:
	@ echo "Running Mugic Example"
	@ $(BIN_DIR)/run_example.sh $(EXAMPLES_DIR)
