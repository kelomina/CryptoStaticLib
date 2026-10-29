# 贡献指南

## 分支与提交

- 从 `main` 创建功能分支。
- 提交信息使用清晰的祈使句，例如 `feat: add version query api`。
- 一个提交只做一件事，避免混合无关改动。

## 代码风格

- C++20，遵循 `.editorconfig`（UTF-8、LF、4 空格）。
- 公共标识符使用英文，命名空间统一为 `crypto_static_lib`。
- 避免冗余 try-catch 与不可能边界上的防御性样板。

## 构建与测试门禁

- Debug 与 Release 均需构建、测试通过。
- 消费者夹具必须能通过 `find_package` 配置、构建、运行。

## 文档同步

- 新增或修改公共 API 必须同步更新 `docs/api.md` 等相关文档。
- 文档链接检查必须通过。

## 禁止项

- 禁止提交构建产物、密钥、证书或凭据。
- 禁止提交生成的 `version.h`。
