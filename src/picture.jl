"""
    NexPicture(nexSerial, name; pid=pid, cid=cid)

A Nextion Picture UI control.
"""
struct NexPicture <: AbstractNexObject
    _nid::NexID

    function NexPicture(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        error("ToDo")
        new(nid)
    end
end
