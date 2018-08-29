"""
    IWidthable(nexid)

An interface for widgets whom width can modified.
"""
struct IWidthable <: AbstractINextion
    _nid::NexID

    function IWidthable(nid::NexID)
        new(nid)
    end
end


"""
    obj.width = new_val

Set Nextion object `obj` width to `new_val`.
"""
function setproperty!(obj::IWidthable, property::Symbol, new_val)
    if property == :width
        setnexproperty!(NexID(obj), :wid, new_val)
    else
        setfield!(obj, property, new_val)
    end
end
