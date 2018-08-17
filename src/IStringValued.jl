"""
Abstract type for interfaces for Nextion objects
"""
abstract type AbstractINextion end

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

Set text to string value contained in `val`.
"""
function setText(obj::IStringValued, val::String)
    nid = NexID(obj)
    _name = String(Name(nid))
    cmd = "$_name.txt=\"$val\""
    nexSerial = NexSerial(nid)
    send(nexSerial, cmd)
end
