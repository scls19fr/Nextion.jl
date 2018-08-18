"""
    INumericalValued(nexid)

An interface for numerical valued widgets.
"""
struct INumericalValued <: AbstractINextion
    _nid::NexID

    function INumericalValued(nid::NexID)
        new(nid)
    end
end


"""
    setValue(obj, val)

Set value from `val` to Nextion object `obj`.
"""
function setValue(obj::INumericalValued, val::Unsigned)
    error("ToDo")
end


"""
    getText(obj) -> Unsigned

Get value from Nextion object `obj`.
"""
function getValue(obj::INumericalValued)::Unsigned
    error("ToDo")
end
