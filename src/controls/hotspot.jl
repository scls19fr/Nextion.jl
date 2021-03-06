"""
    NexHotspot(nexSerial, name; pid=pid, cid=cid)

A Nextion Hotspot UI control.
"""
struct NexHotspot <: AbstractNexObject
    _nid::NexID

    touchable::ITouchable

    function NexHotspot(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        new(nid, ITouchable(nid))
    end
end


function setproperty!(obj::NexHotspot, property::Symbol, new_val)
    _setcommonproperty!(obj, property, new_val)
end


function getproperty(obj::NexHotspot, property::Symbol)
    _getcommonproperty(obj, property)
end
