"""
    NexCrop(nexSerial, name; pid=pid, cid=cid)

A Nextion UI control to deal with cropped picture widget.
"""
struct NexCrop <: AbstractNexObject
    _nid::NexID

    function NexCrop(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        error("ToDo")
        new(nid)
    end
end
