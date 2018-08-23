"""
    NexScrollText(nexSerial, name; pid=pid, cid=cid)

A Nextion Scrolling Text UI control.
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

    # IViewable
    if property == :visible
        obj.viewable.visible = new_val
    
    # IStringValued
    elseif property == :text
        obj.stringvalued.value = new_val

    # getfield
    else
        getfield(obj, property)

    end

end