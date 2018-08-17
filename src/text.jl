"""
    NexText(nexSerial, name; pid=pid, cid=cid)

A Nextion Text UI control.
"""
struct NexText <: AbstractNexObject
    _nid::NexID

    stringvalued::IStringValued
    fontstyleable::IFontStyleable

    function NexText(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        new(nid, IStringValued(nid), IFontStyleable(nid))
    end
end


# IStringValued
Base.setproperty!(obj::NexText, text::Symbol, new_text::String) = setText(obj.stringvalued, new_text)


#function getText(obj::NexText)
#    getText(obj.stringvalued)
#end
# ToDo: getproperty


# IFontStyleable
Base.setproperty!(obj::NexText, font::Symbol, new_font::Font) = setFont(obj.fontstyleable, new_font)

function setAlignment(obj::NexText, align)
    setAlignment(obj.fontstyleable, align)
end


# IColourable