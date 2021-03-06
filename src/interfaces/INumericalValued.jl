"""
    INumericalValued(nexid)

An interface for numerical valued widgets.
"""
struct INumericalValued <: AbstractINextion
    _nid::NexID

    T
    rn  # RangeNumber type

    function INumericalValued(nid::NexID, T, rn)
        new(nid, T, rn)
    end
end


"""
    obj.value = new_val

Set value from `new_val` to Nextion object `obj`.
"""
function setproperty!(obj::INumericalValued, property::Symbol, new_val)

    if property == :value
        setnexproperty!(NexID(obj), :val, obj.T(new_val))
    else
        setfield!(obj, property, new_val)
    end

end


"""
    obj.value

Get `value` property from Nextion object `obj`.
"""
function getproperty(obj::INumericalValued, property::Symbol)

    if property == :value
        getnexproperty(NexID(obj), :val, obj.T)
    else
        getfield(obj, property)
    end

end
