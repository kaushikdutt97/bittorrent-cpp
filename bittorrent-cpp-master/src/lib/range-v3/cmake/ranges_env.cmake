# Copyright Gonzalo Brito Gadeschi 2015
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE.md or copy at http://boost.org/LICENSE_1_0.txt)
#
# Detects the C++ compiler, system, build-type, etc.
include(CheckCXXCompilerFlag)

if("x${CMAKE_CXX_COMPILER_ID}" MATCHES "x.*Clang")
  if("x${CMAKE_CXX_SIMULATE_ID}" STREQUAL "xMSVC")
    set (RANGES_CXX_COMPILER_CLANGCL TRUE)
    if (RANGES_VERBOSE_BUILD)
      message(STATUS "[range-v3]: compiler is clang-cl.")
    endif()
  else()
    set (RANGES_CXX_COMPILER_CLANG TRUE)
    if (RANGES_VERBOSE_BUILD)
      message(STATUS "[range-v3]: compiler is clang.")
    endif()
  endif()
elseif(CMAKE_COMPILER_IS_GNUCXX)
  set (RANGES_CXX_COMPILER_GCC TRUE)
  if (RANGES_VERBOSE_BUILD)
    message(STATUS "[range-v3]: compiler is gcc.")
  endif()
elseif("x${CMAKE_CXX_COMPILER_ID}" STREQUAL "xMSVC")
  set (RANGES_CXX_COMPILER_MSVC TRUE)
  if (RANGES_VERBOSE_BUILD)
    message(STATUS "[range-v3]: compiler is msvc.")
  endif()
else()
  message(WARNING "[range-v3 warning]: unknown compiler ${CMAKE_CXX_COMPILER_ID} !")
endif()

if(CMAKE_SYSTEM_NAME MATCHES "Darwin")
  set (RANGES_ENV_MACOSX TRUE)
  if (RANGES_VERBOSE_BUILD)
    message(STATUS "[range-v3]: system is MacOSX.")
  endif()
elseif(CMAKE_SYSTEM_NAME MATCHES "Linux")
  set (RANGES_ENV_LINUX TRUE)
  if (RANGES_VERBOSE_BUILD)
    message(STATUS "[range-v3]: system is Linux.")
  endif()
elseif(CMAKE_SYSTEM_NAME MATCHES "Windows")
  set (RANGES_ENV_WINDOWS TRUE)
  if (RANGES_VERBOSE_BUILD)
    message(STATUS "[range-v3]: system is Windows.")
  endif()
elseif(CMAKE_SYSTEM_NAME MATCHES "FreeBSD")
  set (RANGES_ENV_FREEBSD TRUE)
  if (RANGES_VERBOSE_BUILD)
    message(STATUS "[range-v3]: system is FreeBSD.")
  endif()
elseif(CMAKE_SYSTEM_NAME MATCHES "OpenBSD")
  set (RANGES_ENV_OPENBSD TRUE)
  if (RANGES_VERBOSE_BUILD)
    message(STATUS "[range-v3]: system is OpenBSD.")
  endif()
elseif(CMAKE_SYSTEM_NAME MATCHES "Emscripten")
  set (RANGES_ENV_EMSCRIPTEN TRUE)
  if (RANGES_VERBOSE_BUILD)
    message(STATUS "[range-v3]: system is Emscripten.")
  endif()
else()
  message(WARNING "[range-v3 warning]: unknown system ${CMAKE_SYSTEM_NAME} !")
endif()

if(RANGES_CXX_STD MATCHES "^[0-9]+$")
  if(RANGES_CXX_COMPILER_MSVC AND RANGES_CXX_STD LESS 17)
    # MSVC is currently supported only in 17+ mode
    set(RANGES_CXX_STD 17)
  elseif(RANGES_CXX_STD LESS 14)
    set(RANGES_CXX_STD 14)
  endif()
endif()

# Build type
set(RANGES_DEBUG_BUILD FALSE)
set(RANGES_RELEASE_BUILD FALSE)

if (CMAKE_BUILD_TYPE MATCHES "^Debug$")
  set(RANGES_DEBUG_BUILD TRUE)
  if (RANGES_VERBOSE_BUILD)
    message(STATUS "[range-v3]: build type is debug.")
  endif()
elseif(CMAKE_BUILD_TYPE MATCHES "^(Release|RelWithDebInfo|MinSizeRel)$")
  set(RANGES_RELEASE_BUILD TRUE)
  if (RANGES_VERBOSE_BUILD)
    message(STATUS "[range-v3]: build type is release.")
  endif()
else()
  message(WARNING "[range-v3 warning]: unknown build type, defaults to release!")
  set(CMAKE_BUILD_TYPE "Release")
  set(RANGES_RELEASE_BUILD TRUE)
endif()

if(RANGE_V3_DOCS)
  find_package(Doxygen)
endif()
find_package(Git)
