%module(directors="1") MediasoupClient

%nspace Antelcat::WebRTC;

%include "swiginterface.i"

%interface_custom("RefCountProxy", "IRefCount", rtc::RefCountInterface);
%feature("csdirectordelegatemodifiers") "internal"
%feature("director") rtc::RefCountInterface;

%typemap(cscode) rtc::RefCountInterface %{
  public RefCountProxy(IRefCount instance) : this(MediasoupClientPINVOKE.new_RefCountProxy(), true) {
    swigDelegate0 = new SwigDelegateRefCountProxy_0(() => instance.AddRef());
    swigDelegate1 = new SwigDelegateRefCountProxy_1(() => (int)instance.Release());
    MediasoupClientPINVOKE.RefCountProxy_director_connect(swigCPtr, swigDelegate0, swigDelegate1);
  }
%}

%include "rtc_base/ref_count.h"