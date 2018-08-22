"""
    NexProgressBar(nexSerial, name; pid=pid, cid=cid)

A Nextion Progress Bar UI control.
"""
struct NexProgressBar <: AbstractNexObject
    _nid::NexID

    viewable::IViewable
    numericalvalued::INumericalValued
    #colourable::IColourable

    function NexProgressBar(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        new(nid, IViewable(nid), INumericalValued(nid))
    end
end


"""
    obj.visible = val

Display Nextion object `obj` when `val` is `true`.
Hide it when `val` is `false`.

    obj.value = value

Set numerical value from `value` to Nextion object `obj`.
"""
function setproperty!(obj::NexProgressBar, property::Symbol, new_val::Integer)
    # IViewable
    if property == :visible
        obj.viewable.visible = new_val

    # INumericalValued
    elseif property == :value
        if new_val >= 0 && new_val <= 100
            obj.numericalvalued.value = new_val
        else
            error("new_val=$new_val but it should be in 0-100")
        end

    else
        setfield!(obj, property)
    end
end