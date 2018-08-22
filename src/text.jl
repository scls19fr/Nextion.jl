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
        setVisible(obj.viewable, new_val)
    
    # IStringValued
    
    elseif property == :text
        obj.stringvalued.value = new_val

    # IFontStyleable
    
    elseif property == :font
        setFont(obj.fontstyleable, new_val)

    # Error

    else
        error("setproperty! error '$property'")    

    end
end


#function getproperty(obj::NexText, property::Symbol)
#    # IStringValued
#    
#    if property == :text
#        getText(obj.stringvalued)
#    end
#end


function setAlignment(obj::NexText, align)
    setAlignment(obj.fontstyleable, align)
end

#function getproperty(obj::NexText, alignment::Symbol)
#end


# IColourable