# Makefile for Nomad Pack Maintenance

# configuration
PACKS_DIR = "./packs"
PACKS     = $(shell ls $(PACKS_DIR))
TITLE     = 🟢 NOMAD PACKS

include ../tooling/make/configs/shared.mk

include ../tooling/make/functions/shared.mk

# render a Nomad Pack
define render_pack
	nomad-pack \
		render \
			"$(PACKS_DIR)/$(strip $(1))" \
	;
endef

# run a Nomad Pack
define run_pack
	nomad-pack \
		run \
			"$(PACKS_DIR)/$(strip $(1))" \
	;
endef

# stop a running Nomad Pack
define stop_pack
	nomad-pack \
		stop \
			"$(PACKS_DIR)/$(strip $(1))" \
	;
endef

# destroy a Nomad Pack
define destroy_pack
	nomad-pack \
		destroy \
			"$(PACKS_DIR)/$(strip $(1))" \
	;
endef

# generate documentation for all Nomad Packs
define render_documentation
	$(call print_reference,$(1))
	echo

	# copy `variables.hcl` to `variables.tf` so that `terraform-docs` can read it:
	cp $(PACKS_DIR)/$(strip $(1))/variables.hcl $(PACKS_DIR)/$(strip $(1))/variables.tf \
  && \
	terraform-docs \
		"$(PACKS_DIR)/$(strip $(1))" \
		--config=".nomad-pack-docs.yml" \
	&& \
	rm "$(PACKS_DIR)/$(strip $(1))/variables.tf" \
	;
endef

include ../tooling/make/targets/shared.mk

.SILENT .PHONY: render
render: # render a Nomad Pack [Usage: `make render pack=my_pack`]
	$(call render_pack,$(pack))

.SILENT .PHONY: run
run: # run a Nomad Pack [Usage: `make run pack=my_pack`]
	$(call run_pack,$(pack))

.SILENT .PHONY: rerun
rerun: # destroy and run a Nomad Pack [Usage: `make rerun pack=my_pack`]
	$(call stop_pack,$(pack))

	$(call destroy_pack,$(pack))

	$(call run_pack,$(pack))

.SILENT .PHONY: stop
stop: # stop a running Nomad Pack [Usage: `make stop pack=my_pack`]
	$(call stop_pack, $(pack))

.SILENT .PHONY: docs
docs: # generate documentation for all Nomad Packs [Usage: `make docs`]
	# see https://www.gnu.org/software/make/manual/html_node/Foreach-Function.html
	$(foreach PACK,$(PACKS),$(call render_documentation,$(strip $(PACK))))
