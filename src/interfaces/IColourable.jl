"""
    IColourable(nexid)

An interface for colourable widgets.
"""
struct IColourable <: AbstractINextion
    _nid::NexID

    function IColourable(nid::NexID)
        new(nid)
    end
end


function setproperty!(obj::IColourable, property::Symbol, new_val)

    if property == :backcolor
        setnexproperty!(NexID(obj), :bco, new_val)
    elseif property == :forecolor
        setnexproperty!(NexID(obj), :pco, new_val)
    else
        setfield!(obj, property, new_val)
    end

end


function getproperty(obj::IColourable, property::Symbol)

    if property == :backcolor
        getnexproperty(NexID(obj), :bco, Int)  # ToDo convert to Color
    elseif property == :forecolor
        getnexproperty(NexID(obj), :pco, Int)  # ToDo convert to Color
    else
        getfield(obj, property)
    end

end