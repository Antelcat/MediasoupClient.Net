%module(directors="1") MediasoupClient

%include "json.i"
%include "webrtc/data_channel_interface.i"

%{
#include "DataProducer.hpp"
%}


%include "swiginterface.i"

%interface_custom("DataProducerListener", "IDataProducerListener", mediasoupclient::DataProducer::Listener);
%feature("director") mediasoupclient::DataProducer::Listener;

%include "DataProducer.hpp"