"""
    NexNumber(nexSerial, name; pid=pid, cid=cid)

A Nextion Number UI control.
"""
struct NexNumber <: AbstractNexObject
    _nid::NexID

    viewable::IViewable
    numericalvalued::INumericalValued
    fontstyleable::IFontStyleable

    function NexNumber(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        new(nid, IViewable(nid), INumericalValued(nid), IFontStyleable(nid))
    end
end

"""
    obj.visible = val

Display Nextion object `obj` when `val` is `true`.
Hide it when `val` is `false`.

    obj.value = value

Set numerical value from `value` to Nextion object `obj`.

    obj.font = new_font

Set font from `Font` struct contained in `new_font` to Nextion object `obj`.

"""
function setproperty!(obj::NexNumber, property::Symbol, new_val)
    # IViewable

    if property == :visible
        setVisible(obj.viewable, new_val)

    # INumericalValued

    elseif property == :value
        setValue(obj.numericalvalued, new_val)

    # IFontStyleable

    elseif property == :font
        setFont(obj.fontstyleable, new_val)

    # Error

    else
        error("setproperty! error '$property'")    

    end
end


function setAlignment(obj::NexNumber, align)
    setAlignment(obj.fontstyleable, align)
end



# IColourable