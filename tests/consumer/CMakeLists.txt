cmake_minimum_required(VERSION 3.25)

project(CryptoStaticLibConsumer LANGUAGES CXX)

add_executable(CryptoStaticLibConsumer main.cpp)
target_compile_features(CryptoStaticLibConsumer PRIVATE cxx_std_20)

find_package(CryptoStaticLib 0.1 CONFIG REQUIRED)
target_link_libraries(CryptoStaticLibConsumer PRIVATE CryptoStaticLib::CryptoStaticLib)
