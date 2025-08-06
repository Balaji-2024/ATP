cmake_minimum_required(VERSION 3.16)
project(ATP VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick)

# Resource file is at the project root
qt_add_resources(APP_RESOURCES ${CMAKE_SOURCE_DIR}/resources.qrc)

add_executable(ATP
    src/cpp/main.cpp
    ${APP_RESOURCES}
)

target_link_libraries(ATP
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
)
target_sources(ATP PRIVATE ${APP_RESOURCES})
