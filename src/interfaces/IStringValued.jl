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


function setproperty!(obj::IStringValued, property::Symbol, new_val)

    if property == :value
        setNexProperty(NexID(obj), :txt, new_val)
    else
        error("setproperty! error '$property'")
    end

end




"""
    getText(obj) -> String

Get text from Nextion object `obj`.
"""
function getText(obj::IStringValued)::String
    getNexProperty(NexID(obj), :font, String)
end
