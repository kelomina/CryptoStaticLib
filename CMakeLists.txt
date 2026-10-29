cmake_minimum_required(VERSION 3.25)

project(CryptoStaticLib VERSION 0.1.0 LANGUAGES CXX)

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

option(CRYPTO_STATIC_LIB_BUILD_TESTS "Build CryptoStaticLib tests" ON)

add_library(CryptoStaticLib STATIC src/version.cpp)
add_library(CryptoStaticLib::CryptoStaticLib ALIAS CryptoStaticLib)

target_compile_features(CryptoStaticLib PUBLIC cxx_std_20)
set_target_properties(CryptoStaticLib PROPERTIES CXX_EXTENSIONS OFF)

if(MSVC)
    target_compile_options(CryptoStaticLib PRIVATE /W4 /permissive-)
else()
    target_compile_options(CryptoStaticLib PRIVATE -Wall -Wextra -Wpedantic)
endif()

target_include_directories(CryptoStaticLib
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/generated>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

configure_file(
    include/crypto_static_lib/version.h.in
    ${CMAKE_CURRENT_BINARY_DIR}/generated/crypto_static_lib/version.h
    @ONLY
)

install(TARGETS CryptoStaticLib
    EXPORT CryptoStaticLibTargets
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

install(FILES include/crypto_static_lib/crypto_static_lib.h
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/crypto_static_lib
)

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/generated/crypto_static_lib/version.h
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/crypto_static_lib
)

set(CRYPTO_STATIC_LIB_CMAKE_INSTALL_DIR "${CMAKE_INSTALL_LIBDIR}/cmake/CryptoStaticLib")

configure_package_config_file(
    cmake/CryptoStaticLibConfig.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/CryptoStaticLibConfig.cmake
    INSTALL_DESTINATION ${CRYPTO_STATIC_LIB_CMAKE_INSTALL_DIR}
)

write_basic_package_version_file(
    ${CMAKE_CURRENT_BINARY_DIR}/CryptoStaticLibConfigVersion.cmake
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY SameMajorVersion
)

install(EXPORT CryptoStaticLibTargets
    FILE CryptoStaticLibTargets.cmake
    NAMESPACE CryptoStaticLib::
    DESTINATION ${CRYPTO_STATIC_LIB_CMAKE_INSTALL_DIR}
)

install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/CryptoStaticLibConfig.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/CryptoStaticLibConfigVersion.cmake
    DESTINATION ${CRYPTO_STATIC_LIB_CMAKE_INSTALL_DIR}
)

if(CRYPTO_STATIC_LIB_BUILD_TESTS)
    enable_testing()
    add_subdirectory(tests)
endif()
