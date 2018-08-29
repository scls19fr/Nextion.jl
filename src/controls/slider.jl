"""
    NexSlider(nexSerial, name; pid=pid, cid=cid)

A Nextion Slider UI control.

On Nextion side, it have the following properties:
- bco
- pco
- wid
- hig
- val
- maxval
- minval
"""
struct NexSlider <: AbstractNexObject
    _nid::NexID

    viewable::IViewable
    numericalvalued::INumericalValued
    colourable::IColourable
    touchable::ITouchable
    
    function NexSlider(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        new(nid, IViewable(nid), INumericalValued(nid, RangeNumber{Int16, 0:typemax(UInt16)}), IColourable(nid), ITouchable(nid))
    end
end


function setproperty!(obj::NexSlider, property::Symbol, new_val)
    _setcommonproperty!(obj, property, new_val)
end


function getproperty(obj::NexSlider, property::Symbol)
    _getcommonproperty(obj, property)
end
