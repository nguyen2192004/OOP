# CMakeList.txt : CMake project for OOP, include source and define
# project specific logic here.
#

# Add source to this project's executable.
add_executable (OOP  "OOP.h"  "OOP.cpp")
target_link_libraries(OOP ${CMAKE_SOURCE_DIR}/library/sfml-graphics.lib)
target_link_libraries(OOP ${CMAKE_SOURCE_DIR}/library/sfml-audio.lib)
target_link_libraries(OOP ${CMAKE_SOURCE_DIR}/library/sfml-network.lib)
target_link_libraries(OOP ${CMAKE_SOURCE_DIR}/library/sfml-system.lib)
target_link_libraries(OOP ${CMAKE_SOURCE_DIR}/library/sfml-window.lib)


include_directories(${CMAKE_SOURCE_DIR}/include)
set_property(TARGET OOP PROPERTY CXX_STANDARD 17)
set_property(TARGET OOP PROPERTY CXX_STANDARD REQUIRED ON)



if (CMAKE_VERSION VERSION_GREATER 3.12)
  set_property(TARGET OOP PROPERTY CXX_STANDARD 20)
endif()

# TODO: Add tests and install targets if needed.
