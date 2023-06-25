%module(directors="1") MediasoupClient

%include "json.i"
%include "DataProducer.i"

%include "std_map.i"
%include "std_future.i"
%include "std_string.i"
%include "std_unique_ptr.i"

%include "swiginterface.i"

%interface_custom("TransportListenerProxy", "ITransportListener", mediasoupclient::Transport::Listener);
%feature("director") mediasoupclient::Transport::Listener;

%include "Transport.hpp"