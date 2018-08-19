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

# IViewable
"""
    obj.visible = val

Display Nextion object `obj` when `val` is `true`.
Hide it when `val` is `false`.
"""
setproperty!(obj::NexNumber, visible::Symbol, new_val::Bool) = setVisible(obj.viewable, new_val)

# INumericalValued
"""
    obj.value = value

Set numerical value from `value` to Nextion object `obj`.
"""
setproperty!(obj::NexNumber, value::Symbol, new_val::Integer) = setValue(obj.numericalvalued, new_val)


#function getText(obj::NexNumber)
#    getText(obj.stringvalued)
#end
# ToDo: getproperty


# IFontStyleable
"""
    obj.font = new_font

Set font from `Font` struct contained in `new_font` to Nextion object `obj`.
"""
setproperty!(obj::NexNumber, font::Symbol, new_font::Font) = setFont(obj.fontstyleable, new_font)

function setAlignment(obj::NexNumber, align)
    setAlignment(obj.fontstyleable, align)
end



# IColourable