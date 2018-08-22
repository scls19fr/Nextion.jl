"""
    NexDualStateButton(nexSerial, name; pid=pid, cid=cid)

A Nextion Button UI control.
"""
struct NexDualStateButton <: AbstractNexObject
    _nid::NexID

    function NexDualStateButton(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        error("ToDo")
        new(nid)
    end
end
