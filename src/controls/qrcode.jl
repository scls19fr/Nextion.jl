"""
    NexQRcode(nexSerial, name; pid=pid, cid=cid)

A Nextion QR code UI control.

On Nextion side, it have the following properties:
- bco
- pco
- txt
"""
struct NexQRcode <: AbstractNexObject
    _nid::NexID

    viewable::IViewable
    stringvalued::IStringValued

    function NexQRcode(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        new(nid, IViewable(nid), IStringValued(nid))
    end
end


"""
    obj.visible = val

Display Nextion object `obj` when `val` is `true`.
Hide it when `val` is `false`.


    obj.text = text_value

Set text from string value contained in `text_value` to Nextion object `obj`.
"""
function setproperty!(obj::NexQRcode, property::Symbol, new_val)
    # IViewable
    if  property == :visible
        obj.viewable.visible = new_val
    
    # IStringValued
    elseif property == :text
        obj.stringvalued.value = new_val
    elseif property == :textmaxlength
        error("text max length property can only be set using Nextion Editor")
        #nid = NexID(obj)
        #if new_val >= 0 && new_val <= 192
        #    setNexProperty(nid, :txt_maxl, Int32(new_val))
        #else
        #    error("Trying to max length to $new_val but it must be in 0-192")
        #end

    # setfield!
    else
        setfield!(obj, property)
    
    end

end
