"""
    NexNumber(nexSerial, name; pid=pid, cid=cid)

A Nextion Number UI control.

On Nextion side, it have the following properties:
- bco
- pco
- font
- xcen
- ycen
- val
- length
- format
- isbr
"""
struct NexNumber <: AbstractNexObject
    _nid::NexID

    viewable::IViewable
    numericalvalued::INumericalValued
    fontstyleable::IFontStyleable
    colourable::IColourable
    touchable::ITouchable

    function NexNumber(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        new(nid, IViewable(nid), INumericalValued(nid, nothing), IFontStyleable(nid), IColourable(nid), ITouchable(nid))
    end
end

function setproperty!(obj::NexNumber, property::Symbol, new_val)
    _setcommonproperty!(obj, property, new_val)
end


function getproperty(obj::NexNumber, property::Symbol)
    _getcommonproperty(obj, property)
end
