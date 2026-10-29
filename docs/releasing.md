# 发布流程

## 版本语义

版本遵循 SemVer。唯一版本源是 `CMakeLists.txt` 中的：

```cmake
project(CryptoStaticLib VERSION 0.1.0 LANGUAGES CXX)
```

`version.h` 由 `configure_file` 自动派生，`version.cpp` 只消费宏，禁止在源码中重复手写版本号。

## 发布产物

- `CryptoStaticLib.lib`
- `include/crypto_static_lib/crypto_static_lib.h`
- `include/crypto_static_lib/version.h`
- `lib/cmake/CryptoStaticLib/` 下的 Config、ConfigVersion、Targets 文件

## 发布前检查清单

1. 更新 `CMakeLists.txt` 版本号后，同步更新 `CHANGELOG.md` 与测试中的期望版本（`tests/version_test.cpp`、`tests/consumer/main.cpp`）。
2. Debug 与 Release 构建、测试全部通过。
3. 安装清单齐全，且不含 `version.h.in`。
4. 消费者 `find_package` 配置、构建、运行通过。
5. 文档链接检查正向、负向均符合预期。
6. 确认 `git status --short --branch` 干净。

## 回滚要求

若发布后发现严重问题，通过追加提交修复并发布新的修订版本；禁止 `git reset --hard` 或删除用户文件。
