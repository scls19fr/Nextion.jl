"""
    NexText(nexSerial, name; pid=pid, cid=cid)

A Nextion Text UI control.

A `NexText` is a Nextion UI control to display text on a page.

On Nextion side, it have the following properties:
- bco
- pco
- font
- xcen
- ycen
- pw
- txt
- isbr
"""
struct NexText <: AbstractNexObject
    _nid::NexID

    viewable::IViewable
    stringvalued::IStringValued
    fontstyleable::IFontStyleable
    colourable::IColourable
    touchable::ITouchable

    function NexText(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        new(nid, IViewable(nid), IStringValued(nid), IFontStyleable(nid), IColourable(nid), ITouchable(nid))
    end
end


function setproperty!(obj::NexText, property::Symbol, new_val)
    _setcommonproperty!(obj, property, new_val)
end


function getproperty(obj::NexText, property::Symbol)
    _getcommonproperty(obj, property)
end
