"""
    NexPicture(nexSerial, name; pid=pid, cid=cid)

A Nextion Picture UI control.
"""
struct NexPicture <: AbstractNexObject
    _nid::NexID

    function NexPicture(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        new(nid)
    end
end


"""
    obj.picture = picture_id

Display picture with `picture_id`.
"""
function setproperty!(obj::NexPicture, property::Symbol, new_val)

    # "IPicturable"
    if property == :picture
        setnexproperty!(NexID(obj), :pic, Int32(new_val))

    # setfield!
    else
        setfield!(obj, property)
    end
end