cmake_minimum_required(VERSION 3.16)
project(ATP VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick Network SerialPort)

# Resource file
qt_add_resources(APP_RESOURCES ${CMAKE_SOURCE_DIR}/resources.qrc)

# Source files
set(SOURCES
    src/cpp/main.cpp
    src/cpp/interface.cpp
    ${APP_RESOURCES}
)

# Header files (for IDEs, not strictly necessary)
set(HEADERS src/cpp/interface.h
)

# Build executable
add_executable(ATP ${SOURCES} ${HEADERS})

target_link_libraries(ATP
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::Network
    Qt6::SerialPort
)

# Include directories (optional if structure is flat)
target_include_directories(ATP PRIVATE src/cpp)

# Optional: Definitions (e.g., for X11 headers)
target_compile_definitions(ATP PRIVATE X11_FOUND)
