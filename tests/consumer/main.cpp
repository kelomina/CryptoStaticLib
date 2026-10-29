#include <crypto_static_lib/crypto_static_lib.h>

#include <iostream>
#include <string_view>

int main() {
    const crypto_static_lib::version_info& info = crypto_static_lib::version();

    if (info.major != 0 || info.minor != 1 || info.patch != 0 || info.text != "0.1.0") {
        std::cerr << "unexpected version\n";
        return 1;
    }

    std::cout << "CryptoStaticLib " << info.text << '\n';
    return 0;
}
