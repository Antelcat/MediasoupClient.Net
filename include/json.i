// 使用SWIG封装nlohmann::json到C#

%include "std_string.i"

%{
#include <json.hpp>
%}

namespace nlohmann {

%naturalvar json;

class json;

%typemap(ctype) json "string"
%typemap(imtype) json "string"
%typemap(cstype) json "string"

%typemap(csdirectorin) json "$iminput"
%typemap(csdirectorout) json "$cscall"

%typemap(in, canthrow=1) json
%{ if (!$input) {
    SWIG_CSharpSetPendingExceptionArgument(SWIG_CSharpArgumentNullException, "null string", 0);
    return $null;
   }
   $1.parse($input); %}
%typemap(out) json %{ $result = SWIG_csharp_string_callback($1.dump()); %}

%typemap(directorout, canthrow=1) json
%{ if (!$input) {
    SWIG_CSharpSetPendingExceptionArgument(SWIG_CSharpArgumentNullException, "null string", 0);
    return $null;
   }
   $result.parse($input); %}

%typemap(directorin) json %{ $input = $1.dump(); %}

%typemap(csin) json "$csinput"
%typemap(csout, excode=SWIGEXCODE) json {
    json ret = $imcall;$excode
    return ret;
  }

%typemap(typecheck) json = char *;

%typemap(throws, canthrow=1) json
%{ SWIG_CSharpSetPendingException(SWIG_CSharpApplicationException, $1.dump());
   return $null; %}

// const json &
%typemap(ctype) const json & "string"
%typemap(imtype) const json & "string"
%typemap(cstype) const json & "string"

%typemap(csdirectorin) const json & "$iminput"
%typemap(csdirectorout) const json & "$cscall"

%typemap(in, canthrow=1) const json &
%{ if (!$input) {
    SWIG_CSharpSetPendingExceptionArgument(SWIG_CSharpArgumentNullException, "null string", 0);
    return $null;
   }
   $1.parse($input); %}
%typemap(out) const json & %{ $result = SWIG_csharp_string_callback($1.dump()); %}

%typemap(csin) const json & "$csinput"
%typemap(csout, excode=SWIGEXCODE) const json & {
    json ret = $imcall;$excode
    return ret;
  }

%typemap(directorout, canthrow=1, warning=SWIGWARN_TYPEMAP_THREAD_UNSAFE_MSG) const json &
%{ if (!$input) {
    SWIG_CSharpSetPendingExceptionArgument(SWIG_CSharpArgumentNullException, "null string", 0);
    return $null;
   }
   /* possible thread/reentrant code problem */
   static $*1_ltype $1_str;
   $1_str = $input;
   $result = &$1_str; %}

%typemap(directorin) const json & %{ $input = $1.dump(); %}

%typemap(csvarin, excode=SWIGEXCODE2) const json & %{
    set {
      $imcall;$excode
    } %}
%typemap(csvarout, excode=SWIGEXCODE2) const json & %{
    get {
      json ret = $imcall;$excode
      return ret;
    } %}

%typemap(typecheck) const json & = char *;

%typemap(throws, canthrow=1) const json &
%{ SWIG_CSharpSetPendingException(SWIG_CSharpApplicationException, $1.dump());
   return $null; %}

}
