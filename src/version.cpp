#include <crypto_static_lib/version.h>

namespace crypto_static_lib {
namespace {

constexpr version_info kVersion{
    static_cast<std::uint32_t>(CRYPTO_STATIC_LIB_VERSION_MAJOR),
    static_cast<std::uint32_t>(CRYPTO_STATIC_LIB_VERSION_MINOR),
    static_cast<std::uint32_t>(CRYPTO_STATIC_LIB_VERSION_PATCH),
    static_cast<std::string_view>(CRYPTO_STATIC_LIB_VERSION_TEXT),
};

}  // namespace

const version_info& version() noexcept {
    return kVersion;
}

}  // namespace crypto_static_lib
