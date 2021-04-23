#[[
    Copyright 2021 Patrick Paul
    SPDX-License-Identifier: MIT-0
]]

# FreeRTOS config
add_definitions(-include FreeRTOSConfig.h)

# FreeRTOS
include_directories(${OSAL_FREERTOS_INC_DIR})
include_directories(${OSAL_FREERTOS_SRC_DIR}/include)
include_directories(${OSAL_FREERTOS_SRC_DIR}/portable/GCC/ARM_CM3)
include_directories(
    ${OSAL_FREERTOS_PLUS_FAT_SRC_DIR}
    ${OSAL_FREERTOS_PLUS_FAT_SRC_DIR}/include
)

FILE(GLOB FREERTOS_SOURCES
    ${OSAL_FREERTOS_SRC_DIR}/*.c
)

FILE(GLOB FATFS_SOURCES
    ${OSAL_FREERTOS_PLUS_FAT_SRC_DIR}/*.c
    ${OSAL_FREERTOS_PLUS_FAT_SRC_DIR}/portable/common/*.c
)

add_library(freertos-fatfs STATIC
    ${FREERTOS_SOURCES}
    ${FATFS_SOURCES}
    src/ff-printf.c
    src/os-impl-filesys.c
)
