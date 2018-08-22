"""
    IBooleanValued(nexid)

An interface for boolean valued widgets.
"""
struct IBooleanValued <: AbstractINextion
    _nid::NexID

    function IBooleanValued(nid::NexID)
        new(nid)
    end
end


"""
    obj.value = val

Set boolean value from `val` to Nextion object `obj`.
"""
function setproperty!(obj::IBooleanValued, property::Symbol, new_val)

    if property == :value
        setnexproperty!(NexID(obj), :val, Bool(new_val))
    else
        setfield!(obj, property, new_val)
    end

end


"""
    obj.value

Get boolean value from Nextion object `obj`.
"""
function getproperty(obj::IBooleanValued, property::Symbol)

    if property == :value
        Bool(getnexproperty(NexID(obj), :val, Int))
    else
        getfield(obj, property)
    end

end