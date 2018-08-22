"""
    NexButton(nexSerial, name; pid=pid, cid=cid)

A Nextion Button UI control.
"""
struct NexCheckbox <: AbstractNexObject
    _nid::NexID

    function NexButton(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        error("ToDo")
        new(nid)
    end
end
