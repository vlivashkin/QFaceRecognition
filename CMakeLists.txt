cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

set(PROJECT "QFaceRecognition")
project(${PROJECT})
message("-- build ${PROJECT}")

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /bigobj")

# Qt
find_package(Qt5 COMPONENTS Widgets Qml Quick Multimedia REQUIRED)  # Find the Qt libraries for Qt Quick/QML
include_directories(${Qt5Widgets_INCLUDE_DIRS} ${QtQml_INCLUDE_DIRS})
add_definitions(${Qt5Widgets_DEFINITIONS} ${QtQml_DEFINITIONS} ${${Qt5Quick_DEFINITIONS}})

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${Qt5Widgets_EXECUTABLE_COMPILE_FLAGS}")
set(CMAKE_INCLUDE_CURRENT_DIR ON)  # Find includes in corresponding build directories
set(CMAKE_AUTOMOC ON)  # Instruct CMake to run moc automatically when needed.
set(CMAKE_AUTOUIC ON)  # if you have any .ui files
set(CMAKE_AUTORCC ON)  # if you have any .qrc files


# dlib
set(DLIB_USE_CUDA 0)
add_library(dlib STATIC IMPORTED)
set_target_properties(dlib PROPERTIES
        IMPORTED_LOCATION_DEBUG "C:\\SDKs\\dlib-19.21\\cmake-build-debug\\dlib\\dlib19.21.0_debug_64bit_msvc1926.lib"
        IMPORTED_LOCATION_RELEASE "C:\\SDKs\\dlib-19.21\\cmake-build-release\\dlib\\dlib19.21.0_release_64bit_msvc1926.lib"
        INTERFACE_INCLUDE_DIRECTORIES "C:\\SDKs\\dlib-19.21"
        )

set(HEADERS ${HEADERS}
        src/facerecognitiontypes.hpp
        src/imageconvertor.hpp
        src/qfacerecognition.hpp
        src/qfacerecognitionfilter.h
        )
set(SOURCES ${SOURCES}
        src/qfacerecognition.cpp
        src/qfacerecognitionfilter.cpp
        "C:/SDKs/dlib-19.21/dlib/all/source.cpp"
        )
add_library(${PROJECT} STATIC
        ${HEADERS}
        ${SOURCES}
        ${QT_RESOURCES}
        )
target_link_libraries(${PROJECT} PRIVATE
        dlib
        )
set_property(TARGET ${PROJECT} PROPERTY CXX_STANDARD 14)