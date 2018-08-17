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


# IStringValued

"""
    setText(obj, val)

Set text in NexText object `obj` to string value contained in `val`.
"""
function setText(obj::NexText, val::String)
    setText(obj.stringvalued, val)
end


"""
    getText(obj) -> String

Get text from NexText object `obj` 
"""
function getText(obj::NexText)
    getText(obj.stringvalued)
end
