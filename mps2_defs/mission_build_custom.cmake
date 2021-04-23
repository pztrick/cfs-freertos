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

    SPDX-License-Identifier: Apache-2.0
]]

#
# Example mission_build_custom.cmake
# ----------------------------------
#
# This file will be automatically included in the top level ("mission") build scope
#
# Definitions and options specified here will be used when building local tools and
# other code that runs on the development host, but do _NOT_ apply to flight software
# (embedded) code or anything built for the target machine. 
#
# These options assume a GCC toolchain but a similar set should be applicable to clang.
#
add_compile_options(
    -std=c99                # Target the C99 standard (without gcc extensions) 
    -pedantic               # Issue all the warnings demanded by strict ISO C
    -Wall                   # Warn about most questionable operations
    -Wstrict-prototypes     # Warn about missing prototypes
    -Wwrite-strings         # Warn if not treating string literals as "const"
    -Wpointer-arith         # Warn about suspicious pointer operations
    -Wcast-align            # Warn about casts that increase alignment requirements
    -Werror                 # Treat warnings as errors (code should be clean) 
)

# The _XOPEN_SOURCE directive is required for glibc to enable conformance with the
# the X/Open standard version 6, which includes POSIX.1c as well as SUSv2/UNIX98 extensions.
add_definitions(
    -D_XOPEN_SOURCE=600
)
