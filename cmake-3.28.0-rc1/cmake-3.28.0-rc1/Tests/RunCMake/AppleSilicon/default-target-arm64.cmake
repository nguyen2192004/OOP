enable_language(C)
if(NOT CMAKE_OSX_ARCHITECTURES STREQUAL "")
  message(FATAL_ERROR "CMAKE_OSX_ARCHITECTURES is '${CMAKE_OSX_ARCHITECTURES}', not empty ''")
endif()
add_library(arm64 arm64.c)
