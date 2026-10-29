# API 说明

当前公开 API 只有一个版本查询接口。

## 头文件

```cpp
#include <crypto_static_lib/crypto_static_lib.h>
```

伞头文件只包含 `version.h`。

## 声明

```cpp
namespace crypto_static_lib {

struct version_info {
    std::uint32_t major;
    std::uint32_t minor;
    std::uint32_t patch;
    std::string_view text;
};

const version_info& version() noexcept;

}  // namespace crypto_static_lib
```

## 返回引用生命周期

`version()` 返回指向静态存储期常量的引用，进程运行期间始终有效，调用方不得释放或修改。

## 线程安全

`version()` 只读，无副作用，可从任意线程并发调用。

## 宏

| 宏 | 含义 |
| --- | --- |
| `CRYPTO_STATIC_LIB_VERSION_MAJOR` | 主版本号 |
| `CRYPTO_STATIC_LIB_VERSION_MINOR` | 次版本号 |
| `CRYPTO_STATIC_LIB_VERSION_PATCH` | 修订号 |
| `CRYPTO_STATIC_LIB_VERSION_TEXT` | 完整版本字符串，如 `"0.1.0"` |

宏由 `configure_file` 从 `CMakeLists.txt` 的 `project(... VERSION ...)` 派生，禁止手写维护。

## 消费示例

```cpp
#include <crypto_static_lib/crypto_static_lib.h>
#include <iostream>

int main() {
    const auto& info = crypto_static_lib::version();
    std::cout << "CryptoStaticLib " << info.text << '\n';
    return 0;
}
```

## SemVer 兼容规则

- 主版本号变更表示不兼容的 API 变更。
- 次版本号增加表示向后兼容的新增功能。
- 修订号增加表示向后兼容的缺陷修复。
- 包版本兼容策略为 `SameMajorVersion`。
