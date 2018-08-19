"""
    NexProgressBar(nexSerial, name; pid=pid, cid=cid)

A Nextion Progress Bar UI control.
"""
struct NexProgressBar <: AbstractNexObject
    _nid::NexID

    viewable::IViewable
    numericalvalued::INumericalValued

    function NexProgressBar(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        new(nid, IViewable(nid), INumericalValued(nid))
    end
end

# IViewable
"""
    obj.visible = val

Display Nextion object `obj` when `val` is `true`.
Hide it when `val` is `false`.
"""
setproperty!(obj::NexProgressBar, visible::Symbol, new_val::Bool) = setVisible(obj.viewable, new_val)

# INumericalValued
"""
    obj.value = value

Set numerical value from `value` to Nextion object `obj`.
"""
function setproperty!(obj::NexProgressBar, value::Symbol, new_val::Integer)
    if new_val >= 0 && new_val <= 100
        setValue(obj.numericalvalued, new_val)
    else
        error("new_val=$new_val but it should be in 0-100")
    end
end