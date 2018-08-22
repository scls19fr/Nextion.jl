"""
    NexHotspot(nexSerial, name; pid=pid, cid=cid)

A Nextion Hotspot UI control.
"""
struct NexHotspot <: AbstractNexObject
    _nid::NexID

    function NexHotspot(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        error("ToDo")
        new(nid)
    end
end
