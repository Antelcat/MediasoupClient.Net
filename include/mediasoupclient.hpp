#ifndef MEDIASOUP_CLIENT_HPP
#define MEDIASOUP_CLIENT_HPP

#pragma comment(lib, "libwebrtc_full.lib")
#pragma comment(lib, "secur32.lib")
#pragma comment(lib, "winmm.lib")
#pragma comment(lib, "dmoguids.lib")
#pragma comment(lib, "wmcodecdspuuid.lib")
#pragma comment(lib, "msdmo.lib")
#pragma comment(lib, "Strmiids.lib")

#include "Device.hpp"
#include "Logger.hpp"

namespace mediasoupclient
{
	void Initialize();     // NOLINT(readability-identifier-naming)
	void Cleanup();        // NOLINT(readability-identifier-naming)
	std::string Version(); // NOLINT(readability-identifier-naming)
} // namespace mediasoupclient

#endif
