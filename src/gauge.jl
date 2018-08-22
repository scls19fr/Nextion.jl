"""
    NexGauge(nexSerial, name; pid=pid, cid=cid)

A Nextion Gauge UI control.
"""
struct NexGauge <: AbstractNexObject
    _nid::NexID

    viewable::IViewable
    numericalvalued::INumericalValued
    colourable::IColourable    

    function NexGauge(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        new(nid, IViewable(nid), INumericalValued(nid), IColourable(nid))
    end
end


"""
    obj.visible = val

Display Nextion object `obj` when `val` is `true`.
Hide it when `val` is `false`.

    obj.value = value

Set numerical value from `value` to Nextion object `obj`.
"""
function setproperty!(obj::NexGauge, property::Symbol, new_val::Integer)
    # IViewable
    if property == :visible
        obj.viewable.visible = new_val

    # INumericalValued
    elseif property == :value
        if new_val >= 0 && new_val <= 360
            obj.numericalvalued.value = new_val
        else
            error("new_val=$new_val but it should be in 0-360")
        end

    else
        setfield!(obj, property)
    end
end