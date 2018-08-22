"""
    NexSlider(nexSerial, name; pid=pid, cid=cid)

A Nextion Slider UI control.
"""
struct NexSlider <: AbstractNexObject
    _nid::NexID

    function NexSlider(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        error("ToDo")
        new(nid)
    end
end
