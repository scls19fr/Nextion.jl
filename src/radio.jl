"""
    NexRadio(nexSerial, name; pid=pid, cid=cid)

A Nextion Radio UI control.
"""
struct NexRadio <: AbstractNexObject
    _nid::NexID

    function NexRadio(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        error("ToDo")
        new(nid)
    end
end
