cmake_minimum_required(VERSION 3.26)
project(Foo NONE)

add_custom_target(drive ALL COMMAND ${CMAKE_COMMAND} -E true)
