cmake_minimum_required(VERSION 3.6)

project(roaring-func)
set(CMAKE_C_STANDARD 99)

add_library(roaring STATIC popcnt.c)


