"""
    IHeightable(nexid)

An interface for widgets whom height can modified.
"""
struct IHeightable <: AbstractINextion
    _nid::NexID

    function IHeightable(nid::NexID)
        new(nid)
    end
end


"""
    obj.height = new_val

Set Nextion object `obj` width to `new_val`.
"""
function setproperty!(obj::IHeightable, property::Symbol, new_val)
    if property == :height
        setnexproperty!(NexID(obj), :hig, new_val)
    else
        setfield!(obj, property, new_val)
    end
end
