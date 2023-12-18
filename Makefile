# Makefile for Nomad Pack Lifecycle Management

# configuration
ARGS                  :=
BINARY_GLOW            = $(call check_for_binary,glow)
BINARY_NOMAD          ?= nomad
BINARY_NOMAD_PACK     ?= nomad-pack
DOCS_CONFIG            = .nomad-pack-docs.yml
GLOW_WIDTH             = 160
DIR_PACKS              = ./packs
NEWMAN_REPORTERS      ?= "cli"
NOMADVARS_SAMPLE_FILE  = overrides.sample.hcl
PACKS                  = $(shell ls $(DIR_PACKS))
reporter              ?= $(NEWMAN_REPORTERS)
SCREEN_SESSION         = nomad_pack_test_environment
SLEEP_NOMAD_STARTUP    = 5
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
	include $(DIR_PACKS)/$(strip $(pack))/tests/config.mk

# conditionally load Git-ignored Pack-specific configuration
ifneq ($(wildcard $(DIR_PACKS)/$(strip $(pack))/tests/gitignored_config.mk),)
	include $(DIR_PACKS)/$(strip $(pack))/tests/gitignored_config.mk
endif

endif

# format a Nomad Pack's files ending in `.hcl`
define format_nomad_pack
	# see https://www.gnu.org/software/make/manual/html_node/Foreach-Function.html
	$(foreach FILE,$(shell find $(DIR_PACKS)/$(1) -type f -name "*.hcl"),$(call format_hcl_files,$(FILE)))
endef

# render a Nomad Pack
define render_pack
	$(if $(pack),,$(call missing_argument,render,pack=<pack>))

	$(call print_reference,$(pack))

	$(BINARY_NOMAD_PACK) \
		render \
			$(ARGS) \
			"$(DIR_PACKS)/$(strip $(pack))" \
	;
endef

# run a Nomad Pack
define run_pack
	$(if $(pack),,$(call missing_argument,run,pack=<pack>))

	$(if $(strip $(BINARY_GLOW)), \
		$(BINARY_NOMAD_PACK)  \
			run \
				$(ARGS) \
				"$(DIR_PACKS)/$(strip $(pack))" \
		| \
		glow \
			--width $(GLOW_WIDTH), \
		$(BINARY_NOMAD_PACK) \
			run \
				$(ARGS) \
				"$(DIR_PACKS)/$(strip $(pack))" \
	)
endef

# stop a running Nomad Pack
define stop_pack
	$(if $(pack),,$(call missing_argument,stop,pack=<pack>))

	$(BINARY_NOMAD_PACK) \
		stop \
			"$(DIR_PACKS)/$(strip $(pack))" \
			$(ARGS) \
	;
endef

# test a running Nomad Pack using Newman
define test_pack
	newman \
		run "$(DIR_PACKS)/$(strip $(pack))/tests/newman.json" \
		--reporters "$(NEWMAN_REPORTERS)" \
	&& \
	echo
endef

# force-create (or update) a Nomad Variable
define put_nomad_variables
	export VARIABLES_FILE="$(DIR_PACKS)/$(strip $(pack))/tests/gitignored_spec.nv.hcl"; \
	\
	if [ -f "$${VARIABLES_FILE}" ]; then \
		echo "[3/4] Loading Variable Definitions found at \`$(STYLE_GROUP_CODE)$${VARIABLES_FILE}$(STYLE_RESET)\`\n" \
		&& \
		$(BINARY_NOMAD) \
			var \
				put \
					-force \
					-in "hcl" \
					"nomad/jobs/$(pack)" \
					"@$${VARIABLES_FILE}" \
		; \
	else \
		echo "[3/4] No Variable Definitions found at \`$(STYLE_GROUP_CODE)$${VARIABLES_FILE}$(STYLE_RESET)\`" \
		; \
	fi
endef

# create Nomad environment for testing
define create_test_environment
	$(if $(pack),,$(call missing_argument,test,pack=<pack>))

	# create test directories if they do not exist
	# see https://www.gnu.org/software/make/manual/html_node/Foreach-Function.html
	$(foreach TEST_DIRECTORY,$(TEST_DIRECTORIES),$(call safely_create_directory,$(TEST_DIRECTORY)))

	echo
	echo "[1/4] Starting Nomad in background (Screen Session \`$(STYLE_GROUP_CODE)$(SCREEN_SESSION)$(STYLE_RESET)\`)"

	# using `screen`, start Nomad in development mode, using Pack-specific configuration
	screen \
		-d \
		-m \
		-S "$(SCREEN_SESSION)" \
		-t "Testing Environment for the \`$(pack)\` Nomad Pack." \
		$(BINARY_NOMAD) \
			agent \
			-config=./packs/$(pack)/tests/nomad_config.hcl \
			-dev \
			$(ARGS) \
	;

	echo "[2/4] Waiting $(SLEEP_NOMAD_STARTUP) seconds for Nomad to finish start-up operations"
	sleep $(SLEEP_NOMAD_STARTUP) \
	;

	$(call put_nomad_variables)

	# insert sleep to allow inspection of Variable lifecycle and bring Nomad session back to foreground
	echo
	echo "[4/4] Reattaching Screen Session \`$(STYLE_GROUP_CODE)$(SCREEN_SESSION)$(STYLE_RESET)\`"
	sleep 2 \
	;

	screen \
		-r "$(SCREEN_SESSION)" \
	;
endef

# destroy a Nomad Pack
define destroy_pack
	$(if $(pack),,$(call missing_argument,render,pack=<pack>))

	$(BINARY_NOMAD_PACK) \
		destroy \
			"$(DIR_PACKS)/$(strip $(pack))" \
			$(ARGS) \
	;
endef

# restart a Nomad Task
define restart_task
	$(if $(task),,$(call missing_argument,restart,task=task))

	$(BINARY_NOMAD) \
		job \
			restart \
			$(task) \
	;
endef

include ../tooling/make/targets/shared.mk

.SILENT .PHONY: env
env: # create Nomad environment for testing [Usage: `make env pack=<pack>`]
	$(if $(pack),,$(call missing_argument,test,pack=<pack>))

	$(call create_test_environment,$(pack))

.SILENT .PHONY: render
render: # render a Nomad Pack [Usage: `make render pack=<pack>`]
	$(if $(pack),,$(call missing_argument,test,pack=<pack>))

	$(call render_pack,$(pack))

.SILENT .PHONY: run
run: # run a Nomad Pack [Usage: `make run pack=<pack>`]
	$(if $(pack),,$(call missing_argument,test,pack=<pack>))

	$(call run_pack,$(pack))

.SILENT .PHONY: rerun
rerun: # destroy and run a Nomad Pack [Usage: `make rerun pack=<pack>`]

.SILENT .PHONY: rerun
rerun: # destroy and run a Nomad Pack [Usage: `make rerun pack=<pack>`]
	$(if $(pack),,$(call missing_argument,test,pack=<pack>))

	$(call stop_pack,$(pack))

	$(call destroy_pack,$(pack))

	$(call run_pack,$(pack))

.SILENT .PHONY: stop
stop: # stop a running Nomad Pack [Usage: `make stop pack=<pack>`]
	$(if $(pack),,$(call missing_argument,test,pack=<pack>))

	$(call stop_pack, $(pack))

.SILENT .PHONY: test
test: # test a running Nomad Pack [Usage: `make test pack=<pack>`]
	$(if $(pack),,$(call missing_argument,test,pack=<pack>))

	$(call test_pack, $(pack))

.SILENT .PHONY: restart
restart: # restart a Task [Usage: `make restart task=<task>`]
	$(if $(pack),,$(call missing_argument,test,pack=<pack>))

	$(call restart_task,$(task))

.SILENT .PHONY: format
format: # format HCL files for all Nomad Packs [Usage: `make format`]
	# see https://www.gnu.org/software/make/manual/html_node/Foreach-Function.html
	$(foreach PACK,$(PACKS),$(call format_nomad_pack,$(PACK)))

.SILENT .PHONY: docs
docs: # generate documentation for all Nomad Packs [Usage: `make docs`]
	# see https://www.gnu.org/software/make/manual/html_node/Foreach-Function.html
	$(foreach PACK,$(PACKS),$(call render_documentation,$(DIR_PACKS)/$(strip $(PACK)),variables.hcl,$(DOCS_CONFIG),$(NOMADVARS_SAMPLE_FILE)))

.SILENT .PHONY: registry
registry: # add Nomad Pack Registry to local environment [Usage: `make registry`]
	$(BINARY_NOMAD_PACK) \
		registry \
			add \
				"workloads" \
				"github.com/workloads/nomad-pack-registry"
