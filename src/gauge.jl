"""
    NexGauge(nexSerial, name; pid=pid, cid=cid)

A Nextion Gauge UI control.
"""
struct NexGauge <: AbstractNexObject
    _nid::NexID

    function NexGauge(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        error("ToDo")
        new(nid)
    end
end
