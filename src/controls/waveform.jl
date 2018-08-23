struct NexWaveformChannels
    _nid::NexID
end
getindex(channels::Nextion.NexWaveformChannels, ch::Integer) = NexWaveformChannel(channels._nid, ch)

struct NexWaveformChannel
    _nid::NexID
    _chid::UInt8  # channel id
end

function push!(channel::NexWaveformChannel, value::UInt8)
    nid = channel._nid
    nexSerial = nid._nexSerial
    cid = String(ComponentID(nid))
    chid = channel._chid
    send(nexSerial, "add $cid,$chid,$value")
end

"""
    NexWaveform(nexSerial, name; pid=pid, cid=cid)

A Nextion Waveform UI control.

On Nextion side, it have the following properties:
- bco/picc/pic
- gdc
- gdw
- gdh 
- pco0
- pco1
- pco2
- pco3

"""
struct NexWaveform <: AbstractNexObject
    _nid::NexID

    viewable::IViewable
    colourable::IColourable
    touchable::ITouchable

    function NexWaveform(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        new(nid, IViewable(nid), IColourable(nid), ITouchable(nid))
    end
end


function getproperty(obj::NexWaveform, property::Symbol)
    if property == :channels
        NexWaveformChannels(NexID(obj))

    # getfield
    else
        getfield(obj, property)
    
    end
end