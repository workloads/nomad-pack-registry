# Makefile for Nomad Pack Lifecycle Management

# configuration
ARGS                  :=
BINARY_GLOW            = $(call check_for_binary,glow)
BINARY_NOMAD     			?= nomad
BINARY_NOMAD_PACK			?= nomad-pack
DOCS_CONFIG            = .nomad-pack-docs.yml
GLOW_WIDTH             = 160
PACKS_DIR              = ./packs
NEWMAN_REPORTERS      ?= "cli"
NOMAD_ADDR            ?= "http://localhost:4646"
NOMADVARS_SAMPLE_FILE	 = overrides.sample.hcl
PACKS                  = $(shell ls $(PACKS_DIR))
reporter              ?= $(NEWMAN_REPORTERS)
TITLE                  = 🟢 NOMAD PACKS

# override default reporter if `REPORTER` is set
ifneq ($(reporter),)
	NEWMAN_REPORTERS := $(reporter)
endif

include ../tooling/make/configs/shared.mk

include ../tooling/make/functions/shared.mk

# conditionally load Pack-specific configuration if the
# target is `env` and the `pack` argument is not empty
ifeq ($(and $(pack),$(MAKECMDGOALS)),env)
    include $(PACKS_DIR)/$(strip $(pack))/tests/test.mk
endif

# render a Nomad Pack
define render_pack
	$(if $(pack),,$(call missing_argument,render,pack=my_pack))

	$(call print_reference,$(pack))

	$(BINARY_NOMAD_PACK) \
		render \
			$(ARGS) \
			"$(PACKS_DIR)/$(strip $(pack))" \
	;
endef

# run a Nomad Pack
define run_pack
	$(if $(pack),,$(call missing_argument,run,pack=my_pack))

	$(if $(strip $(BINARY_GLOW)), \
		$(BINARY_NOMAD_PACK)  \
			run \
				$(ARGS) \
				"$(PACKS_DIR)/$(strip $(pack))" \
		| \
		glow \
			--width $(GLOW_WIDTH), \
		$(BINARY_NOMAD_PACK) \
			run \
				$(ARGS) \
				"$(PACKS_DIR)/$(strip $(pack))" \
	)
endef

# stop a running Nomad Pack
define stop_pack
	$(if $(pack),,$(call missing_argument,stop,pack=my_pack))

	$(BINARY_NOMAD_PACK) \
		stop \
			"$(PACKS_DIR)/$(strip $(pack))" \
			$(ARGS) \
	;
endef

# test a running Nomad Pack using Newman
define test_pack
	newman \
		run "$(PACKS_DIR)/$(strip $(pack))/tests/newman.json" \
		--reporters "$(NEWMAN_REPORTERS)" \
	&& \
	echo
endef

# create Nomad environment for testing
define create_test_environment
	$(if $(pack),,$(call missing_argument,test,pack=my_pack))

	# create test directories if they do not exist
	$(foreach TEST_DIRECTORY,$(TEST_DIRECTORIES),$(call safely_create_directory,$(TEST_DIRECTORY)))

	echo

	# start Nomad in development mode, using Pack-specific configuration
	$(BINARY_NOMAD) \
		agent \
			-config="$(PACKS_DIR)/$(strip $(pack))/tests/nomad.hcl" \
			-dev \
			$(ARGS) \
	;
endef

# destroy a Nomad Pack
define destroy_pack
	$(if $(pack),,$(call missing_argument,render,pack=my_pack))

	$(BINARY_NOMAD_PACK) \
		destroy \
			"$(PACKS_DIR)/$(strip $(pack))" \
			$(ARGS) \
	;
endef

# restart a Nomad Task
define restart_task
	$(if $(task),,$(call missing_argument,restart,task=my_task))

	$(BINARY_NOMAD) \
		job \
			restart \
			$(task) \
	;
endef

include ../tooling/make/targets/shared.mk

.SILENT .PHONY: env
env: # create Nomad environment for testing [Usage: `make env pack=my_pack`]
	$(call create_test_environment,$(pack))

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
test: # test a running Nomad Pack [Usage: `make test pack=my_pack`]
	$(call test_pack, $(pack))

.SILENT .PHONY: restart
restart: # restart a Task [Usage: `make restart task=my_task`]
	$(call restart_task,$(task))

.SILENT .PHONY: docs
docs: # generate documentation for all Nomad Packs [Usage: `make docs`]
	# see https://www.gnu.org/software/make/manual/html_node/Foreach-Function.html
	$(foreach PACK,$(PACKS),$(call render_documentation,$(PACKS_DIR)/$(strip $(PACK)),variables.hcl,$(DOCS_CONFIG),$(NOMADVARS_SAMPLE_FILE)))

.SILENT .PHONY: registry
registry: # add Nomad Pack Registry to local environment [Usage: `make registry`]
	$(BINARY_NOMAD_PACK) \
		registry \
			add \
				"workloads" \
				"github.com/workloads/nomad-pack-registry"
