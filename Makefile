# Makefile for Nomad Pack Maintenance

# configuration
BINARY_GLOW = $(call check_for_binary,glow)
GLOW_WIDTH  = 160
PACKS_DIR   = ./packs
PACKS       = $(shell ls $(PACKS_DIR))
TITLE       = 🟢 NOMAD PACKS

include ../tooling/make/configs/shared.mk

include ../tooling/make/functions/shared.mk

# conditionally load Pack-specific configuration if the
# target is `test` and the `pack` argument is not empty
ifeq ($(and $(pack),$(MAKECMDGOALS)),test)
    include $(PACKS_DIR)/$(strip $(pack))/tests/test.mk
endif

# render a Nomad Pack
define render_pack
	$(if $(pack),,$(call missing_argument,render,pack=my_pack))

	$(call print_reference,$(pack))

	nomad-pack \
		render \
			"$(PACKS_DIR)/$(strip $(pack))" \
	;
endef

# run a Nomad Pack
define run_pack
	$(if $(pack),,$(call missing_argument,run,pack=my_pack))

	$(if $(strip $(BINARY_GLOW)), \
		nomad-pack \
			run \
				"$(PACKS_DIR)/$(strip $(pack))" \
		| \
		glow \
			--width $(GLOW_WIDTH), \
		nomad-pack \
			run \
				"$(PACKS_DIR)/$(strip $(pack))" \
	)
endef

# stop a running Nomad Pack
define stop_pack
	$(if $(pack),,$(call missing_argument,stop,pack=my_pack))

	nomad-pack \
		stop \
			"$(PACKS_DIR)/$(strip $(pack))" \
	;
endef

# create environment to test a Nomad Pack
define create_test_environment
	$(if $(pack),,$(call missing_argument,test,pack=my_pack))

	# create test directories if they do not exist
	$(foreach TEST_DIRECTORY,$(TEST_DIRECTORIES),$(call safely_create_directory,$(TEST_DIRECTORY)))

	# start Nomad in development mode, using Pack-specific configuration
	nomad \
		agent \
			-config="$(PACKS_DIR)/$(strip $(pack))/tests/config.hcl" \
			-dev \
	;
endef

# destroy a Nomad Pack
define destroy_pack
	$(if $(pack),,$(call missing_argument,render,pack=my_pack))

	nomad-pack \
		destroy \
			"$(PACKS_DIR)/$(strip $(pack))" \
	;
endef

# generate documentation for all Nomad Packs
define render_documentation
	$(call print_reference,$(1))

	# copy `variables.hcl` to `variables.tf` so that `terraform-docs` can read it:
	cp $(PACKS_DIR)/$(strip $(1))/variables.hcl $(PACKS_DIR)/$(strip $(1))/variables.tf \
  && \
	terraform-docs \
		"$(PACKS_DIR)/$(strip $(1))" \
		--config=".nomad-pack-docs.yml" \
	&& \
	rm "$(PACKS_DIR)/$(strip $(1))/variables.tf" \
	;

	echo
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

.SILENT .PHONY: test
test: # create environment to test a Nomad Pack [Usage: `make test pack=my_pack`]
	$(call create_test_environment, $(pack))

.SILENT .PHONY: docs
docs: # generate documentation for all Nomad Packs [Usage: `make docs`]
	# see https://www.gnu.org/software/make/manual/html_node/Foreach-Function.html
	$(foreach PACK,$(PACKS),$(call render_documentation,$(strip $(PACK))))
