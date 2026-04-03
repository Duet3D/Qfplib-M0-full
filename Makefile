# Qfplib-M0-full Master Makefile
# Builds Qfplib-M0-full for various MCU configurations

# Cross-compiler toolchain (relative to project root)
CROSS_COMPILE ?= arm-none-eabi-
export CROSS_COMPILE

# Toolchain commands
CC = $(CROSS_COMPILE)gcc
AR = $(CROSS_COMPILE)ar

# Quiet build support (Linux kernel style)
# Use V=1 for verbose output
ifeq ($(V),1)
	Q :=
else
	Q := @
endif
export Q

# Available build configurations
CONFIGS := SAMC21

# Default target
.DEFAULT_GOAL := SAMC21

# Print available targets
.PHONY: help
help:
	@echo "Qfplib-M0-full Build System"
	@echo "Available targets:"
	@for config in $(CONFIGS); do echo "  make $$config"; done
	@echo ""
	@echo "Other targets:"
	@echo "  make all          - Build all configurations"
	@echo "  make clean        - Clean all build outputs"
	@echo "  make clean-<config> - Clean specific configuration"
	@echo ""
	@echo "Options:"
	@echo "  V=1               - Verbose build output"

# Build all configurations
.PHONY: all
all:
	$(Q)$(MAKE) SAMC21

# Include configuration-specific makefiles only when building that specific config
ifneq ($(filter SAMC21,$(MAKECMDGOALS)),)
-include Makefiles/SAMC21.mk
endif
ifeq ($(MAKECMDGOALS),)
-include Makefiles/SAMC21.mk
endif

# Generic clean target
.PHONY: clean
clean:
	@echo "Cleaning all Qfplib-M0-full build outputs..."
	@for config in $(CONFIGS); do \
		if [ -d "$$config" ]; then \
			echo "  Cleaning $$config..."; \
			rm -rf "$$config"; \
		fi; \
	done
