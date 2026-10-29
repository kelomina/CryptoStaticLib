# CryptoStaticLib

CryptoStaticLib 是一个 C++20 静态库工程骨架，用于承载后续经过审查的密码学能力。当前版本只提供基础设施与公共版本查询 API，**尚未实现任何密码算法**（没有 SHA、AES、RSA、随机数等）。

## 当前状态

- 版本：`0.1.0`（见 [CHANGELOG.md](CHANGELOG.md)）
- 公共 API：仅 `crypto_static_lib::version()`
- 构建系统：CMake 3.25+，Visual Studio 生成器，MSVC x64
- 测试：一个版本测试程序，Debug/Release 均执行全部显式检查
- 安装与消费：支持 `cmake --install` 与下游 `find_package(CryptoStaticLib 0.1 CONFIG REQUIRED)`
- 许可证：尚未选择，使用前请先与维护者确认

## 目录结构

```text
CryptoStaticLib/
├── CMakeLists.txt              # 顶层构建、安装与包导出
├── CMakePresets.json           # Debug/Release 配置、构建、测试 preset
├── cmake/                      # 包配置模板
├── include/crypto_static_lib/  # 公共头文件与 version.h 模板
├── src/                        # 实现
├── tests/                      # 单元测试与最小消费者夹具
├── scripts/                    # 文档链接检查脚本
└── docs/                       # 开发与维护文档
```

## 构建与测试

Debug：

```powershell
cmake --preset windows-x64-debug
cmake --build --preset windows-x64-debug
ctest --preset windows-x64-debug --output-on-failure
```

Release：

```powershell
cmake --preset windows-x64-release
cmake --build --preset windows-x64-release
ctest --preset windows-x64-release --output-on-failure
```

## 安装与消费

```powershell
cmake --install build/windows-x64-debug --prefix build/install --config Debug
```

下游工程：

```cmake
find_package(CryptoStaticLib 0.1 CONFIG REQUIRED)
target_link_libraries(your_target PRIVATE CryptoStaticLib::CryptoStaticLib)
```

## 文档入口

- [文档索引](docs/README.md)
- [架构说明](docs/architecture.md)
- [构建指南](docs/building.md)
- [API 说明](docs/api.md)
- [测试策略](docs/testing.md)
- [发布流程](docs/releasing.md)
- [安全策略](docs/security.md)

## 贡献与安全

- 贡献前请阅读 [CONTRIBUTING.md](CONTRIBUTING.md)
- 安全问题请按 [SECURITY.md](SECURITY.md) 私密报告

## 许可证

本项目尚未选择许可证。在许可证确定之前，不授予任何再分发或商用许可。
