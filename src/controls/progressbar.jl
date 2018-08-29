"""
    NexProgressBar(nexSerial, name; pid=pid, cid=cid)

A Nextion Progress Bar UI control.

On Nextion side, it have the following properties:
- bco
- pco
- val
"""
struct NexProgressBar <: AbstractNexObject
    _nid::NexID

    viewable::IViewable
    numericalvalued::INumericalValued
    colourable::IColourable
    touchable::ITouchable

    function NexProgressBar(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        new(nid, IViewable(nid), INumericalValued(nid, RangeNumber{Int64, 0:100}), IColourable(nid), ITouchable(nid))
        #new(nid, IViewable(nid), INumericalValued(nid), IColourable(nid), ITouchable(nid))
    end
end


function setproperty!(obj::NexProgressBar, property::Symbol, new_val)
    _setcommonproperty!(obj, property, new_val)
end


function getproperty(obj::NexProgressBar, property::Symbol)
    _getcommonproperty(obj, property)
end
