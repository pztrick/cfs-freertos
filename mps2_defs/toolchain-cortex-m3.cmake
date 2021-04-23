#[[
    GSC-18128-1, "Core Flight Executive Version 6.7"

    Copyright (c) 2006-2019 United States Government as represented by
    the Administrator of the National Aeronautics and Space Administration.
    All Rights Reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

    SPDX-License-Identifier: Apache-2.0 AND (Apache-2.0 OR MIT-0)

    Modifications in this file authored by Patrick Paul are available under either the Apache-2.0 or MIT-0 license.
]]

set(CMAKE_C_COMPILER_WORKS 1)
set(CMAKE_CXX_COMPILER_WORKS 1)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)
set(CMAKE_CROSSCOMPILING 1)

# toolchain is installed to $PATH in Docker container
set(CMAKE_C_COMPILER            "arm-none-eabi-gcc")
set(CMAKE_CXX_COMPILER          "arm-none-eabi-g++")
set(CMAKE_AS                    "arm-none-eabi-as")
set(CMAKE_ASM_COMPILER          "arm-none-eabi-gcc")
set(CMAKE_OBJCOPY               "arm-none-eabi-objcopy")
set(CMAKE_OBJDUMP               "arm-none-eabi-objdump")
set(CMAKE_SIZE                  "arm-none-eabi-size")

# https://stackoverflow.com/a/43777707/1545769
set(CMAKE_AR                    "arm-none-eabi-ar" CACHE FILEPATH "archiver-bug")

add_definitions(-include osconfig.h)

set(DOCKER_HOST_PROJECT_DIR "$ENV{DOCKER_HOST_PROJECT_DIR}")
set(DOCKER_CONTAINER_PROJECT_DIR "$ENV{DOCKER_CONTAINER_PROJECT_DIR}")
if(NOT DOCKER_HOST_PROJECT_DIR OR NOT DOCKER_CONTAINER_PROJECT_DIR)
    message(FATAL_ERROR "You must export the environment variable \${DOCKER_HOST_PROJECT_DIR} \${DOCKER_CONTAINER_PROJECT_DIR}.")
endif()

set(GDB_FLAGS "-g3 -O0 -fdebug-prefix-map=${DOCKER_CONTAINER_PROJECT_DIR}=${DOCKER_HOST_PROJECT_DIR}")
set(MCPU_FLAGS "-mcpu=cortex-m3 -mthumb")
set(CMAKE_C_FLAGS "${GDB_FLAGS} ${MCPU_FLAGS} ${VFP_FLAGS} -Wall -fno-builtin -std=gnu11 -fmessage-length=0 -ffunction-sections -fdata-sections" CACHE INTERNAL "c compiler flags" FORCE)
set(CMAKE_CXX_FLAGS "${GDB_FLAGS} ${MCPU_FLAGS} ${VFP_FLAGS} -Wall -fno-builtin -fmessage-length=0 -ffunction-sections -fdata-sections" CACHE INTERNAL "cxx compiler flags")
set(CMAKE_ASM_FLAGS "${GDB_FLAGS} ${MCPU_FLAGS} -x assembler-with-cpp" CACHE INTERNAL "asm compiler flags")
set(CMAKE_EXE_LINKER_FLAGS "-specs=nano.specs --specs=rdimon.specs -lc -lrdimon" CACHE INTERNAL "exe link flags" FORCE)

set(LINKER_SCRIPT "$ENV{LINKER_SCRIPT}")
if(NOT DEFINED LINKER_SCRIPT)
    message(FATAL_ERROR "You must export the environment variable \${LINKER_SCRIPT}.")
endif()
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -T ${LINKER_SCRIPT}" CACHE INTERNAL "exe link flags" FORCE)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM   NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY   NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE   NEVER)

set(CFE_SYSTEM_PSPNAME      "freertos")
set(OSAL_SYSTEM_BSPTYPE     "generic-freertos")
set(OSAL_SYSTEM_OSTYPE      "freertos")
