# Qfplib-M0-full SAMC21 Configuration Makefile

BUILD_DIR := SAMC21
TARGET := $(BUILD_DIR)/libQfplib-M0-full.a

# Assembly source file
ASM_SRCS := qfplib-m0-full_gcc.S

# Assembler flags
ASFLAGS := -c \
	-mcpu=cortex-m0plus \
	-mthumb

OBJS := $(ASM_SRCS:%.S=$(BUILD_DIR)/%.o)

.PHONY: SAMC21
SAMC21: $(TARGET)

$(TARGET): $(OBJS)
	$(Q)echo "  AR      $@"
	$(Q)mkdir -p $(@D)
	$(Q)$(AR) rcs $@ $^

$(BUILD_DIR)/%.o: %.S
	$(Q)echo "  AS      $<"
	$(Q)mkdir -p $(@D)
	$(Q)$(CC) $(ASFLAGS) -o $@ $<

.PHONY: clean-SAMC21
clean-SAMC21:
	$(Q)echo "  RM      $(BUILD_DIR)"
	$(Q)rm -rf $(BUILD_DIR)
