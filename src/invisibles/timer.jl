"""
    NexTimer(nexSerial, name; pid=pid, cid=cid)

A Nextion Timer control.
"""
struct NexTimer <: AbstractNexObject
    _nid::NexID

    function NexTimer(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        error("ToDo")
        new(nid)
    end
end
