%module(directors="1") abseil

%{
#include "absl/types/optional.h"
using namespace absl;
%}

// For all absl::optional<T>, if the C# Nullable<T> has a value, pass that value, 
// otherwise pass absl::optional::nullopt
%typemap(csout, excode=SWIGEXCODE2) absl::optional<int>, absl::optional<uint16_t> {
    var result = $imcall;$excode
    return result.HasValue() ? result.Value : null;
}

// If the absl::optional<T> has a value, return that value to C#, 
// otherwise return null
%typemap(in) absl::optional<int>, absl::optional<uint16_t> 
{
  if (!$csinput.HasValue)
    $1 = absl::optional::nullopt;
  else
    $1 = absl::optional($csinput.Value);
}
