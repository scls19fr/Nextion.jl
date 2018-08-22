"""
    NexText(nexSerial, name; pid=pid, cid=cid)

A Nextion Text UI control.
"""
struct NexText <: AbstractNexObject
    _nid::NexID

    viewable::IViewable
    stringvalued::IStringValued
    fontstyleable::IFontStyleable

    function NexText(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        new(nid, IViewable(nid), IStringValued(nid), IFontStyleable(nid))
    end
end


"""
    obj.visible = val

Display Nextion object `obj` when `val` is `true`.
Hide it when `val` is `false`.


    obj.text = text_value

Set text from string value contained in `text_value` to Nextion object `obj`.


    obj.font = new_font

Set font from `Font` struct contained in `new_font` to Nextion object `obj`.

"""
function setproperty!(obj::NexText, property::Symbol, new_val)
    # IViewable

    if property == :visible
        obj.viewable.visible = new_val
    
    # IStringValued
    
    elseif property == :text
        obj.stringvalued.value = new_val

    # IFontStyleable
    
    elseif property == :font
        obj.fontstyleable.font = new_val

    # setfield!

    else
        setfield!(obj, property, new_val)

    end
end


function getproperty(obj::NexText, property::Symbol)
    # IStringValued
    
    if property == :text
        obj.stringvalued.text

    # IFontStyleable
    elseif property == :alignment
        obj.fontstyleable.alignment
    
    # getfield

    else
        getfield(obj, property)
    end
end


# IColourable