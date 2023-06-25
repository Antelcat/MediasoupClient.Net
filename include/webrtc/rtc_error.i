%nspace Antelcat::WebRTC;

%include "../abseil/optional.i"

%include "std_string.i"
%include "attribute.i"

%attribute(webrtc::RTCError, webrtc::RTCErrorType, Type, type, set_type);
%attribute(webrtc::RTCError, std::string, Message, message, set_message);
%attribute(webrtc::RTCError, webrtc::RTCErrorDetailType, ErrorDetail, error_detail, set_error_detail);
%attribute(webrtc::RTCError, absl::optional<uint16_t>, SctpCauseCode, sctp_cause_code, set_sctp_cause_code);
%attribute(webrtc::RTCError, bool, IsOk, ok);

%ignore webrtc::RTCError::type;
%ignore webrtc::RTCError::set_type;
%ignore webrtc::RTCError::message;
%ignore webrtc::RTCError::set_message;
%ignore webrtc::RTCError::error_detail;
%ignore webrtc::RTCError::set_error_detail;
%ignore webrtc::RTCError::sctp_cause_code;
%ignore webrtc::RTCError::set_sctp_cause_code;

namespace webrtc {

// Enumeration to represent distinct classes of errors that an application
// may wish to act upon differently. These roughly map to DOMExceptions or
// RTCError "errorDetailEnum" values in the web API, as described in the
// comments below.
enum class RTCErrorType {
  // No error.
  NONE,

  // An operation is valid, but currently unsupported.
  // Maps to OperationError DOMException.
  UNSUPPORTED_OPERATION,

  // A supplied parameter is valid, but currently unsupported.
  // Maps to OperationError DOMException.
  UNSUPPORTED_PARAMETER,

  // General error indicating that a supplied parameter is invalid.
  // Maps to InvalidAccessError or TypeError DOMException depending on context.
  INVALID_PARAMETER,

  // Slightly more specific than INVALID_PARAMETER; a parameter's value was
  // outside the allowed range.
  // Maps to RangeError DOMException.
  INVALID_RANGE,

  // Slightly more specific than INVALID_PARAMETER; an error occurred while
  // parsing string input.
  // Maps to SyntaxError DOMException.
  SYNTAX_ERROR,

  // The object does not support this operation in its current state.
  // Maps to InvalidStateError DOMException.
  INVALID_STATE,

  // An attempt was made to modify the object in an invalid way.
  // Maps to InvalidModificationError DOMException.
  INVALID_MODIFICATION,

  // An error occurred within an underlying network protocol.
  // Maps to NetworkError DOMException.
  NETWORK_ERROR,

  // Some resource has been exhausted; file handles, hardware resources, ports,
  // etc.
  // Maps to OperationError DOMException.
  RESOURCE_EXHAUSTED,

  // The operation failed due to an internal error.
  // Maps to OperationError DOMException.
  INTERNAL_ERROR,

  // An error occured that has additional data.
  // The additional data is specified in
  // https://w3c.github.io/webrtc-pc/#rtcerror-interface
  // Maps to RTCError DOMException.
  OPERATION_ERROR_WITH_DATA,
};

// Detail information, showing what further information should be present.
// https://w3c.github.io/webrtc-pc/#rtcerrordetailtype-enum
enum class RTCErrorDetailType {
  NONE,
  DATA_CHANNEL_FAILURE,
  DTLS_FAILURE,
  FINGERPRINT_FAILURE,
  SCTP_FAILURE,
  SDP_SYNTAX_ERROR,
  HARDWARE_ENCODER_NOT_AVAILABLE,
  HARDWARE_ENCODER_ERROR,
};

// Roughly corresponds to RTCError in the web api. Holds an error type, a
// message, and possibly additional information specific to that error.
//
// Doesn't contain anything beyond a type and message now, but will in the
// future as more errors are implemented.
class RTCError {
 public:
  // Constructors.

  // Creates a "no error" error.
  RTCError() {}
  explicit RTCError(RTCErrorType type) : type_(type) {}

  RTCError(RTCErrorType type, std::string message)
      : type_(type), message_(std::move(message)) {}

  // In many use cases, it is better to use move than copy,
  // but copy and assignment are provided for those cases that need it.
  // Note that this has extra overhead because it copies strings.
  RTCError(const RTCError& other) = default;

  // Identical to default constructed error.
  //
  // Preferred over the default constructor for code readability.
  static RTCError OK();

  // Error type.
  RTCErrorType type() const { return type_; }
  void set_type(RTCErrorType type) { type_ = type; }

  // Human-readable message describing the error. Shouldn't be used for
  // anything but logging/diagnostics, since messages are not guaranteed to be
  // stable.
  const char* message() const;

  void set_message(std::string message);

  RTCErrorDetailType error_detail() const { return error_detail_; }
  void set_error_detail(RTCErrorDetailType detail) { error_detail_ = detail; }
  absl::optional<uint16_t> sctp_cause_code() const { return sctp_cause_code_; }
  void set_sctp_cause_code(uint16_t cause_code) {
    sctp_cause_code_ = cause_code;
  }

  // Convenience method for situations where you only care whether or not an
  // error occurred.
  bool ok() const { return type_ == RTCErrorType::NONE; }
};

}
