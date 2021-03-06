"""
    NexScrollText(nexSerial, name; pid=pid, cid=cid)

A Nextion Scrolling Text UI control.

On Nextion side, it have the following properties:
- bco
- pco
- font
- xcen
- ycen
- dir
- tim
- dis
- txt
- en
- isbr
"""
struct NexScrollText <: AbstractNexObject
    _nid::NexID

    viewable::IViewable
    stringvalued::IStringValued
    fontstyleable::IFontStyleable
    colourable::IColourable
    touchable::ITouchable

    function NexScrollText(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        new(nid, IViewable(nid), IStringValued(nid), IFontStyleable(nid), IColourable(nid), ITouchable(nid))
    end
end


function setproperty!(obj::NexScrollText, property::Symbol, new_val)
    _setcommonproperty!(obj, property, new_val)
end


function getproperty(obj::NexScrollText, property::Symbol)
    _getcommonproperty(obj, property)
end
