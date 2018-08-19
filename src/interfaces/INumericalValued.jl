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
function setValue(obj::INumericalValued, val::Integer)
    setNexProperty(NexID(obj), :val, Int32(val))
end


"""
    getText(obj)

Get value from Nextion object `obj`.
"""
function getValue(obj::INumericalValued)
    getNexProperty(NexID(obj), :val, Int)
end
