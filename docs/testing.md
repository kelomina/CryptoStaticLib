# 测试策略

## 当前测试

- `tests/version_test.cpp`：验证版本宏与 `version()` 的 major/minor/patch/text，且不使用 `assert`，Release 下仍执行全部显式检查。
- `tests/consumer/`：最小独立工程，通过 `find_package` 使用安装后的包，证明导出 target 与安装接口真实可用。

## 命令

```powershell
cmake --preset windows-x64-debug
cmake --build --preset windows-x64-debug
ctest --preset windows-x64-debug --output-on-failure

cmake --preset windows-x64-release
cmake --build --preset windows-x64-release
ctest --preset windows-x64-release --output-on-failure
```

## 未来密码模块测试要求

- 必须包含官方或公认测试向量。
- 必须包含边界与负向测试（非法长度、空输入、错误密钥等）。
- 必须评估常量时间特性，避免明显的数据依赖分支与内存访问。
- 必须进行内存安全审查，优先使用静态分析工具并记录结果。
- 测试不得仅用 `assert`，确保 Release 配置仍执行检查。
