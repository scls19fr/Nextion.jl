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

# IViewable
"""
    obj.visible = val

Display Nextion object `obj` when `val` is `true`.
Hide it when `val` is `false`.
"""
setproperty!(obj::NexText, visible::Symbol, new_val::Bool) = setVisible(obj.viewable, new_val)

# IStringValued
"""
    obj.text = text_value

Set text from string value contained in `text_value` to Nextion object `obj`.
"""
setproperty!(obj::NexText, text::Symbol, new_val::String) = setText(obj.stringvalued, new_val)


#function getText(obj::NexText)
#    getText(obj.stringvalued)
#end
# ToDo: getproperty


# IFontStyleable
"""
    obj.font = new_font

Set font from `Font` struct contained in `new_font` to Nextion object `obj`.
"""
setproperty!(obj::NexText, font::Symbol, new_font::Font) = setFont(obj.fontstyleable, new_font)

function setAlignment(obj::NexText, align)
    setAlignment(obj.fontstyleable, align)
end

#Base.getproperty(obj::NexText, alignment::Symbol) = 0 # AlignmentDirection(NexID(obj))


# IColourable