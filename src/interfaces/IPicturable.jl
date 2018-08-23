"""
    IPicturable(nexid)

An interface for picturable widgets.
"""
struct IPicturable <: AbstractINextion
    _nid::NexID

    function IPicturable(nid::NexID)
        new(nid)
    end
end


"""
    obj.picture = picture_id

Display picture with `picture_id`.
"""
function setproperty!(obj::IPicturable, property::Symbol, new_val)
    if property == :picture
        pic = new_val
        @assert typeof(pic) <: Picture "'$pic' must be a 'Picture'"
        setnexproperty!(NexID(obj), :pic, pic.id)
    else
        setfield!(obj, property)
    end
end
