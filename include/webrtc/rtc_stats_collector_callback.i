%nspace Antelcat::WebRTC;

%include "ref_count.i"

namespace webrtc {

class RTCStatsCollectorCallback : public rtc::RefCountInterface {
 public:
  ~RTCStatsCollectorCallback() override = default;

  virtual void OnStatsDelivered(
      const rtc::scoped_refptr<const RTCStatsReport>& report) = 0;
};

}  // namespace webrtc