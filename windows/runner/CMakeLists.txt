cmake_minimum_required(VERSION 3.14)
project(runner LANGUAGES CXX)

# Define the application target. To change its name, change BINARY_NAME in the
# top-level CMakeLists.txt.
set(BINARY_NAME "hadron_ide")  # Add this line to explicitly set the binary name

add_executable(${BINARY_NAME} WIN32
  flutter_window.cpp
  main.cpp
  utils.cpp
  win32_window.cpp
  Runner.rc
  ${FLUTTER_MANAGED_DIR}/generated_plugin_registrant.cc
  ${CMAKE_CURRENT_SOURCE_DIR}/resources/app_icon.ico
)

# The apply_standard_settings function is defined in the main CMakeLists.txt
# We'll manually add the settings instead
set_target_properties(${BINARY_NAME} PROPERTIES
  CXX_STANDARD 17
  VS_GLOBAL_ApplicationSupportsUnicode "true"
)

# Add preprocessor definitions for the build version.
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION=\"1.0.0\"")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_MAJOR=1")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_MINOR=0")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_PATCH=0")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_BUILD=1")

# Disable Windows macros that collide with C++ standard library functions.
target_compile_definitions(${BINARY_NAME} PRIVATE "_HAS_STD_BYTE=0")

# Add dependency libraries and include directories
target_link_libraries(${BINARY_NAME} PRIVATE flutter flutter_wrapper_app)
target_include_directories(${BINARY_NAME} PRIVATE "${CMAKE_SOURCE_DIR}")

# Run the Flutter tool portions of the build. This must not be removed.
add_dependencies(${BINARY_NAME} flutter_assemble)