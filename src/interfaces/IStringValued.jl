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
        setnexproperty!(NexID(obj), :txt, new_val)
    else
        setfield!(obj, property, new_val)
    end

end


function getproperty(obj::IStringValued, property::Symbol)

    if property == :value
        getnexproperty(NexID(obj), :font, String)
    else
        getfield(obj, property)
    end

end
