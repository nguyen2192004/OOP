cmake_minimum_required(VERSION 3.24...3.28)
project(cxx_modules_export_include_directories CXX)

include("${CMAKE_SOURCE_DIR}/../cxx-modules-rules.cmake")

add_library(export_include_directories STATIC
  include/include.h)
target_sources(export_include_directories
  PRIVATE
    forward.cxx
  PRIVATE
    FILE_SET modules_private TYPE CXX_MODULES
      BASE_DIRS
        "${CMAKE_CURRENT_SOURCE_DIR}"
      FILES
        private.cxx
  PUBLIC
    FILE_SET modules TYPE CXX_MODULES
      BASE_DIRS
        "${CMAKE_CURRENT_SOURCE_DIR}"
      FILES
        importable.cxx
        subdir/importable.cxx
  )
target_compile_features(export_include_directories PUBLIC cxx_std_20)
target_include_directories(export_include_directories
  PRIVATE
    "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>"
    "$<INSTALL_INTERFACE:include>")

add_library(no_modules STATIC no_modules.cxx)

install(TARGETS export_include_directories no_modules
  EXPORT CXXModules
  FILE_SET modules DESTINATION "lib/cxx/miu")
install(DIRECTORY include
  DESTINATION "include")
install(EXPORT CXXModules
  NAMESPACE CXXModules::
  DESTINATION "lib/cmake/export_include_directories"
  FILE "export_include_directories-targets.cmake"
  CXX_MODULES_DIRECTORY "export_include_directories-cxx-modules")
file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/export_include_directories-config.cmake"
  "include(\"\${CMAKE_CURRENT_LIST_DIR}/export_include_directories-targets.cmake\")
set(\${CMAKE_FIND_PACKAGE_NAME}_FOUND 1)
")
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/export_include_directories-config.cmake"
  DESTINATION "lib/cmake/export_include_directories")

set(generator
  -G "${CMAKE_GENERATOR}")
if (CMAKE_GENERATOR_TOOLSET)
  list(APPEND generator
    -T "${CMAKE_GENERATOR_TOOLSET}")
endif ()
if (CMAKE_GENERATOR_PLATFORM)
  list(APPEND generator
    -A "${CMAKE_GENERATOR_PLATFORM}")
endif ()

add_test(NAME export_include_directories_build
  COMMAND
    "${CMAKE_COMMAND}"
    "-Dexpected_source_dir=${CMAKE_INSTALL_PREFIX}/lib/cxx/miu"
    "-Dexpected_binary_dir=${CMAKE_INSTALL_PREFIX}/lib/cxx/bmi"
    "-Dexport_include_directories_DIR=${CMAKE_INSTALL_PREFIX}/lib/cmake/export_include_directories"
    ${generator}
    -S "${CMAKE_CURRENT_SOURCE_DIR}/test"
    -B "${CMAKE_CURRENT_BINARY_DIR}/test")
