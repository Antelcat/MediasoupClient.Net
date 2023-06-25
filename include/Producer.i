%module(directors="1") MediasoupClient

%include "json.i"
%include "std_string.i"

%include "swiginterface.i"

%interface_custom("ProducerPrivateListenerProxy", "IProducerPrivateListener", mediasoupclient::Producer::PrivateListener);
%feature("director") mediasoupclient::Producer::PrivateListener;

%interface_custom("ProducerListenerProxy", "IProducerListener", mediasoupclient::Producer::Listener);
%feature("director") mediasoupclient::Producer::Listener;

%include "Producer.hpp"