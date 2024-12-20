USERNAME:= $(git config --global user.name)
ROOT_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
BIN_DIR:= $(ROOT_DIR).local/bin
CONFIG_DIR:= $(ROOT_DIR).local/.config

.PHONY: all
.PHONY: initialize_environment
all:
	@ echo "Makefile under construction"

setup_environment:
	@echo "root directory: "$(ROOT_DIR)
	# delegate to a bash script to setup our environment
	$(BIN_DIR)/env_init.sh $(CONFIG_DIR)
