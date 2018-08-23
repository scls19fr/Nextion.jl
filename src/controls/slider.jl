"""
    NexSlider(nexSerial, name; pid=pid, cid=cid)

A Nextion Slider UI control.
"""
struct NexSlider <: AbstractNexObject
    _nid::NexID

    viewable::IViewable
    numericalvalued::INumericalValued
    colourable::IColourable
    touchable::ITouchable
    
    function NexSlider(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        new(nid, IViewable(nid), INumericalValued(nid), IColourable(nid), ITouchable(nid))
    end
end
