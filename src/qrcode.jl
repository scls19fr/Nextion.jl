"""
    NexQRcode(nexSerial, name; pid=pid, cid=cid)

A Nextion QR code UI control.
"""
struct NexQRcode <: AbstractNexObject
    _nid::NexID

    viewable::IViewable
    stringvalued::IStringValued
    #colourable

    function NexQRcode(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        new(nid, IViewable(nid), IStringValued(nid))
    end
end

# IViewable
"""
    obj.visible = val

Display Nextion object `obj` when `val` is `true`.
Hide it when `val` is `false`.
"""
setproperty!(obj::NexQRcode, visible::Symbol, new_val::Bool) = setVisible(obj.viewable, new_val)

# IStringValued
"""
    obj.text = text_value

Set text from string value contained in `text_value` to Nextion object `obj`.
"""
function setproperty!(obj::NexQRcode, property::Symbol, new_val)
    if property == :text
        setText(obj.stringvalued, new_val)
    elseif property == :textmaxlength
        error("text max length property can only be set using Nextion Editor")
        #nid = NexID(obj)
        #if new_val >= 0 && new_val <= 192
        #    setNexProperty(nid, :txt_maxl, Int32(new_val))
        #else
        #    error("Trying to max length to $new_val but it must be in 0-192")
        #end
    end
end