"""
    NexText(nexSerial, name; pid=pid, cid=cid)

A Nextion Text UI control.
"""
struct NexText <: AbstractNexObject
    _nid::NexID

    stringvalued::IStringValued

    function NexText(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        new(nid, IStringValued(nid))
    end
end

"""
    setText(nexText, val)

Set text to string value contained in `val`.
"""
function setText(nexText::NexText, val::String)
    setText(nexText.stringvalued, val)
end
