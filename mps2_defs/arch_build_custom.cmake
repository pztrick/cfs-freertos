#[[
    Copyright 2021 Patrick Paul
    SPDX-License-Identifier: Apache-2.0 OR MIT-0
]]

cmake_minimum_required(VERSION 2.8)

enable_language(ASM)

set(OSAL_SOURCE_DIR "${DOCKER_CONTAINER_PROJECT_DIR}/osal")
set(OSAL_FREERTOS_INC_DIR "${DOCKER_CONTAINER_PROJECT_DIR}/lib/include")
set(OSAL_FREERTOS_SRC_DIR "${DOCKER_CONTAINER_PROJECT_DIR}/lib/freertos")
set(OSAL_FREERTOS_CONFIG_H_DIR "${DOCKER_CONTAINER_PROJECT_DIR}/apps/bsp-arm-mps2-an385/inc")
set(OSAL_FREERTOS_PLUS_FAT_SRC_DIR "${DOCKER_CONTAINER_PROJECT_DIR}/lib/freertos-plus-fat")

# FreeRTOS
include_directories(${OSAL_FREERTOS_CONFIG_H_DIR})
include_directories(${OSAL_FREERTOS_INC_DIR})
include_directories(${OSAL_FREERTOS_SRC_DIR}/portable/GCC/ARM_CM3)

# OSAL
include_directories(${OSAL_SOURCE_DIR}/src/os/shared/inc)
include_directories(${OSAL_SOURCE_DIR}/src/os/freertos/inc)

# Apps
set(CUSTOM_FREERTOS_FILESYSTEM "1")