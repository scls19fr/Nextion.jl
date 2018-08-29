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

function setproperty!(obj::NexWaveformChannel, property::Symbol, new_val)
    if property == :color
        chid = obj._chid
        nid = obj._nid
        prop = Symbol("pco$chid")
        setnexproperty!(nid, prop, new_val)
    else
        setfield!(obj, property, new_val)
    end
end

struct NexWaveformGrid
    _nid::NexID
end

function setproperty!(obj::NexWaveformGrid, property::Symbol, new_val)
    if property in (:width, :height, :color)
        nid = obj._nid
        if property == :width
            setnexproperty!(nid, :gdw, new_val)
        elseif property == :height
            setnexproperty!(nid, :gdh, new_val)
        else
            setnexproperty!(nid, :gdc, new_val)
        end
    else
        setfield!(obj, property, new_val)
    end
end

function getproperty(obj::NexWaveformGrid, property::Symbol)
    if property in (:width, :height)
        getnexproperty(obj._nid, property)
    else
        getfield(obj, property)
    end
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
        nid = NexID(obj)
        NexWaveformChannels(nid)
    elseif property == :grid
        nid = NexID(obj)
        NexWaveformGrid(nid)
    else
        _getcommonproperty(obj, property)   
    end
end