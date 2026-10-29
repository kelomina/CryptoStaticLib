#include <crypto_static_lib/crypto_static_lib.h>

#include <iostream>
#include <string_view>

namespace {

bool expect(bool condition, std::string_view message) {
    if (!condition) {
        std::cerr << "FAILED: " << message << '\n';
        return false;
    }
    return true;
}

}  // namespace

int main() {
    bool ok = true;

    ok = expect(CRYPTO_STATIC_LIB_VERSION_MAJOR == 0, "macro major must be 0") && ok;
    ok = expect(CRYPTO_STATIC_LIB_VERSION_MINOR == 1, "macro minor must be 1") && ok;
    ok = expect(CRYPTO_STATIC_LIB_VERSION_PATCH == 0, "macro patch must be 0") && ok;
    ok = expect(std::string_view{CRYPTO_STATIC_LIB_VERSION_TEXT} == "0.1.0", "macro text must be 0.1.0") && ok;

    const crypto_static_lib::version_info& info = crypto_static_lib::version();
    ok = expect(info.major == 0, "version().major must be 0") && ok;
    ok = expect(info.minor == 1, "version().minor must be 1") && ok;
    ok = expect(info.patch == 0, "version().patch must be 0") && ok;
    ok = expect(info.text == "0.1.0", "version().text must be 0.1.0") && ok;

    if (!ok) {
        return 1;
    }

    std::cout << "CryptoStaticLib " << info.text << '\n';
    return 0;
}
