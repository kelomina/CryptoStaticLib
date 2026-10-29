# 构建指南

## 环境前提

- 操作系统：Windows 10 / 11
- 编译器：Visual Studio 2022 或 Visual Studio 2026（MSVC）
- 构建工具：CMake 3.25+
- Shell：PowerShell

实际仓库使用的生成器记录在 `CMakePresets.json`，当前为 `Visual Studio 18 2026` 与 `-A x64`。若本机不可用，请用 `cmake --help` 确认可用生成器，并同步修改 `CMakePresets.json`。

## Debug 构建

```powershell
cmake --preset windows-x64-debug
cmake --build --preset windows-x64-debug
ctest --preset windows-x64-debug --output-on-failure
```

## Release 构建

```powershell
cmake --preset windows-x64-release
cmake --build --preset windows-x64-release
ctest --preset windows-x64-release --output-on-failure
```

## 安装

多配置生成器必须用 `--config` 指定配置：

```powershell
cmake --install build/windows-x64-debug --prefix build/install --config Debug
```

安装产物：

```text
build/install/
├── include/crypto_static_lib/
│   ├── crypto_static_lib.h
│   └── version.h
└── lib/
    ├── CryptoStaticLib.lib
    └── cmake/CryptoStaticLib/
        ├── CryptoStaticLibConfig.cmake
        ├── CryptoStaticLibConfigVersion.cmake
        ├── CryptoStaticLibTargets.cmake
        └── CryptoStaticLibTargets-debug.cmake
```

## 下游消费

```cmake
find_package(CryptoStaticLib 0.1 CONFIG REQUIRED)
target_link_libraries(your_target PRIVATE CryptoStaticLib::CryptoStaticLib)
```

```powershell
cmake -S your_project -B build/your_project -DCMAKE_PREFIX_PATH=E:/Project/CryptoStaticLib/build/install
cmake --build build/your_project --config Debug
```

## 常见故障

- **生成器不可用**：`cmake --help` 确认已安装的 Visual Studio 生成器名称，并同步修改 `CMakePresets.json`。
- **多配置生成器报缺少配置**：构建、测试、安装都需显式给出 `--config Debug` 或 `--config Release`。
- **安装前缀错误**：确认 `--prefix` 指向预期目录，且下游 `CMAKE_PREFIX_PATH` 指向同一个安装根。
