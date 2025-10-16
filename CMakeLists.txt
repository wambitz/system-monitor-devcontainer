cmake_minimum_required(VERSION 3.20)

project(system_monitor
        VERSION 0.1.0
        LANGUAGES CXX)

# ── Global compiler defaults ──────────────────────────────────────────────
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# ── Dependencies ──────────────────────────────────────────────────────────
find_package(Curses REQUIRED)

# ── Main executable ───────────────────────────────────────────────────────
include_directories(${CURSES_INCLUDE_DIRS})
include_directories(include)

file(GLOB SOURCES "src/*.cpp")

add_executable(monitor ${SOURCES})

target_link_libraries(monitor PRIVATE ${CURSES_LIBRARIES})
target_compile_options(monitor PRIVATE -Wall -Wextra)
