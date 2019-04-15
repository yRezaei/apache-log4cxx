cmake_minimum_required(VERSION 2.8.12)
project(test-log4cxx)

add_definitions("-std=c++11")

execute_process(COMMAND conan install ..)
include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

add_executable(test-log4cxx main.cpp)
target_link_libraries(test-log4cxx ${CONAN_LIBS})