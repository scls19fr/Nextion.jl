"""
    NexScrollText(nexSerial, name; pid=pid, cid=cid)

A Nextion Scrolling Text UI control.
"""
struct NexScrollText <: AbstractNexObject
    _nid::NexID

    stringvalued::IStringValued

    function NexScrollText(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        new(nid, IStringValued(nid))
    end
end


# IStringValued

"""
    setText(obj, val)

Set text to string value contained in `val`.
"""
function setText(obj::NexScrollText, val::String)
    setText(obj.stringvalued, val)
end
