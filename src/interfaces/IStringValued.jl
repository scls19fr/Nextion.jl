"""
    IStringValued(nexid)

An interface for string valued widgets.
"""
struct IStringValued <: AbstractINextion
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
    setNexProperty(NexID(obj), :txt, val)
end


"""
    getText(obj) -> String

Get text from Nextion object `obj`.
"""
function getText(obj::IStringValued)::String
    getNexProperty(NexID(obj), :font, String)
end
