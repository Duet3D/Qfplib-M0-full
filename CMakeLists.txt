# Qfplib-M0-full (fast single-precision floating point for the Cortex-M0+) for the Duet3D firmware,
# built for DUET_MCU, which the consuming project's toolchain file sets along with the core's code
# generation flags.
#
#   DUET_MCU  SAMC21
#
# Target: Duet::Qfplib. A firmware routes the compiler's soft-float calls to it by linking with
# -Wl,-wrap for each __aeabi_ function it replaces.

cmake_minimum_required(VERSION 3.25)
project(Qfplib LANGUAGES ASM)

if(NOT DUET_MCU STREQUAL "SAMC21")
    message(FATAL_ERROR "Qfplib: unsupported DUET_MCU '${DUET_MCU}'")
endif()

add_library(Qfplib STATIC qfplib-m0-full_gcc.S)
add_library(Duet::Qfplib ALIAS Qfplib)
set_target_properties(Qfplib PROPERTIES OUTPUT_NAME Qfplib-M0-full)

target_include_directories(Qfplib PUBLIC .)
