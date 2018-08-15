"""
    NexText(nexSerial, name; pid=pid, cid=cid)

A Nextion Text UI control.
"""
struct NexText <: AbstractNexObject
    _nid::NexID

    function NexText(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        new(NexID(nexSerial, name, pid, cid))
    end
end

"""
    setText(nexText, val)

Set text to string value contained in `val`.
"""
function setText(nexText::NexText, val::String)
    _name = String(Name(nexText))
    cmd = "$_name.txt=\"$val\""
    _send(nexText, cmd)
end
