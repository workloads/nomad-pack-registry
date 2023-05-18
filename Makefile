# Makefile for Nomad Pack Maintenance

# see https://www.gnu.org/software/make/manual/html_node/Options_002fRecursion.html
MAKEFLAGS = --no-builtin-rules --silent --warn-undefined-variables

# see https://www.gnu.org/software/make/manual/html_node/Choosing-the-Shell.html
SHELL       := sh
.SHELLFLAGS := -eu -c

# see https://www.gnu.org/software/make/manual/html_node/Goals.html
.DEFAULT_GOAL := help

# see https://www.gnu.org/software/make/manual/html_node/One-Shell.html
.ONESHELL :

# configuration
PACKS_DIR = "./packs"
PACKS     = $(shell ls $(PACKS_DIR))

# Renders a Nomad Pack
define render_pack
	nomad-pack \
		render \
			"$(PACKS_DIR)/$(strip $(1))" \
	;
endef

# Runs a Nomad Pack
define run_pack
	nomad-pack \
		run \
			"$(PACKS_DIR)/$(strip $(1))" \
	;
endef

# Stops a (running) Nomad Pack
define stop_pack
	nomad-pack \
		stop \
			"$(PACKS_DIR)/$(strip $(1))" \
	;
endef

# Destroys a Nomad Pack
define destroy_pack
	nomad-pack \
		destroy \
			"$(PACKS_DIR)/$(strip $(1))" \
	;
endef

# Generates Documentation for all Packs
define render_documentation
	cp $(PACKS_DIR)/$(strip $(1))/variables.hcl $(PACKS_DIR)/$(strip $(1))/variables.tf \
  && \
	terraform-docs \
		"$(PACKS_DIR)/$(strip $(1))" \
		--config=".nomad-pack-docs.yml" \
	&& \
	rm "$(PACKS_DIR)/$(strip $(1))/variables.tf" \
	;
endef

.SILENT .PHONY: help
help: # Displays a list of Make Targets          Usage: `make` or `make help`
	$(info )
	$(info $(shell tput bold)NOMAD PACKS MAINTENANCE$(shell tput sgr0))
	$(info )

	grep \
		--context=0 \
		--devices=skip \
		--extended-regexp \
		--no-filename \
			"(^[a-z-]+):{1} ?(?:[a-z-])* #" $(MAKEFILE_LIST) | \
	\
	awk 'BEGIN {FS = ":.*?# "}; {printf "\033[1m%s\033[0m;%s\n", $$1, $$2}' | \
	\
	column \
		-c2 \
		-s ";" \
		-t

.SILENT .PHONY: render
render: # Renders a Nomad Pack                     Usage: `make render pack=my-pack`
	$(call render_pack, $(pack))

.SILENT .PHONY: run
run: # Runs a Nomad Pack                        Usage: `make run pack=my-pack`
	$(call run_pack, $(pack))

.SILENT .PHONY: rerun
rerun: # Destroys and Runs a Nomad Pack           Usage: `make rerun pack=my-pack`
	$(call stop_pack, $(pack))

	$(call destroy_pack, $(pack))

	$(call run_pack, $(pack))

.SILENT .PHONY: stop
stop: # Stops a (running) Nomad Pack             Usage: `make stop pack=my-pack`
	$(call stop_pack, $(pack))

.SILENT .PHONY: docs
docs: # Generates Documentation for all Packs    Usage: `make docs`
	# see https://www.gnu.org/software/make/manual/html_node/Foreach-Function.html
	$(foreach PACK,$(PACKS),$(call render_documentation,$(strip $(PACK))))

.SILENT .PHONY: selfcheck
selfcheck: # Lints Makefile                           Usage: `make selfcheck`
	echo checkmake \
		--config="./checkmake.ini" \
		"$(firstword $(MAKEFILE_LIST))"
