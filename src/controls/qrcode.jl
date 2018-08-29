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


function setproperty!(obj::NexQRcode, property::Symbol, new_val)
    if property == :textmaxlength
        error("text max length property can only be set using Nextion Editor")
    end

    _setcommonproperty!(obj, property, new_val)
end

function getproperty(obj::NexQRcode, property::Symbol, new_val)
    if property == :textmaxlength
        error("text max length property can only be set using Nextion Editor")
    end

    _getcommonproperty(obj, property)
end
