"""
    IStringValued(nexid)

An interface for string valued widgets.
"""
struct IStringValued <: AbstractNexObject
    _nid::NexID

    function IStringValued(nid::NexID)
        new(nid)
    end
end

"""
    setText(obj, val)

Set text from string value contained in `val` to Nextion object `obj`.
"""
function setText(obj::IStringValued, val::String)
    _nid = NexID(obj)
    _name = String(Name(_nid))
    cmd = "$_name.txt=\"$val\""
    nexSerial = NexSerial(_nid)
    send(nexSerial, cmd)
end


"""
    getText(obj) -> String

Get text from Nextion object `obj`.
"""
function setText(obj::IStringValued, val::String)
    error("ToDo")
end
