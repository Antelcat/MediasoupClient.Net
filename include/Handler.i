%module(directors="1") MediasoupClient

%include "json.i"
%include "PeerConnection.i"

%include "swiginterface.i"

%interface_custom("HandlerPrivateListenerProxy", "IHandlerPrivateListener", mediasoupclient::Handler::PrivateListener);
%feature("director") mediasoupclient::Handler::PrivateListener;

%include "Handler.hpp"