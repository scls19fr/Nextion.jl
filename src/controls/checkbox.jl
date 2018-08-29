"""
    NexCheckbox(nexSerial, name; pid=pid, cid=cid)

A Nextion Checkbox UI control.

On Nextion side, it have the following properties:
- bco
- pco
- val
"""
struct NexCheckbox <: AbstractNexObject
    _nid::NexID

    viewable::IViewable
    booleanvalued::IBooleanValued
    colourable::IColourable
    touchable::ITouchable

    function NexCheckbox(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        new(nid, IViewable(nid), IBooleanValued(nid), IColourable(nid), ITouchable(nid))
    end
end


function setproperty!(obj::NexCheckbox, property::Symbol, new_val)
    _setcommonproperty!(obj, property, new_val)
end


function getproperty(obj::NexCheckbox, property::Symbol)
    _getcommonproperty(obj, property)
end
