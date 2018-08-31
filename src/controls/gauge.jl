struct NexGaugePointer <: AbstractNexObject
    _nid::NexID

    widthable::IWidthable
end

function setproperty!(obj::NexGaugePointer, property::Symbol, new_val)
    _setcommonproperty!(obj, property, new_val)
end


"""
    NexGauge(nexSerial, name; pid=pid, cid=cid)

A Nextion Gauge UI control.

On Nextion side, it have the following properties:
- bco
- val
- wid
- pco
"""
struct NexGauge <: AbstractNexObject
    _nid::NexID

    viewable::IViewable
    numericalvalued::INumericalValued
    colourable::IColourable
    touchable::ITouchable

    function NexGauge(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        new(nid, IViewable(nid), INumericalValued(nid, UInt16, RangeNumber{UInt16, 0:360}), IColourable(nid), ITouchable(nid))
    end
end


function setproperty!(obj::NexGauge, property::Symbol, new_val)
    _setcommonproperty!(obj, property, new_val)
end


function getproperty(obj::NexGauge, property::Symbol)
    if property == :pointer
        nid = NexID(obj)
        NexGaugePointer(nid, IWidthable(nid))
    else
        _getcommonproperty(obj, property)
    end
end
