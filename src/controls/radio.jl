"""
    NexRadio(nexSerial, name; pid=pid, cid=cid)

A Nextion Radio UI control.
"""
struct NexRadio <: AbstractNexObject
    _nid::NexID

    viewable::IViewable
    booleanvalued::IBooleanValued
    colourable::IColourable
    touchable::ITouchable

    function NexRadio(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        new(nid, IViewable(nid), IBooleanValued(nid), IColourable(nid), ITouchable(nid))
    end
end
