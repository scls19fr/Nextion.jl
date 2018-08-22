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
    setValue(obj, val)

Set boolean value from `val` to Nextion object `obj`.
"""
function setValue(obj::IBooleanValued, val::Bool)
    error("ToDo")
end


"""
    getValue(obj) -> Bool

Get boolean value from Nextion object `obj`.
"""
function getValue(obj::IBooleanValued)::Bool
    error("ToDo")
end
