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

    obj.backcolor = color

Set backcolor

    obj.forecolor = color

Set forecolor
"""
function setproperty!(obj::NexGauge, property::Symbol, new_val)

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

    # IColourable
    elseif property == :backcolor
        obj.colourable.backcolor = new_val

    elseif property == :forecolor
        obj.colourable.forecolor = new_val

    # setfield!
    else
        setfield!(obj, property)
    
    end
end


function getproperty(obj::NexGauge, property::Symbol)

    # IViewable
    if property == :visible
        obj.viewable.visible

    # INumericalValued
    elseif property == :value
        obj.stringvalued.value

    # IColourable
    elseif property == :backcolor
        obj.colourable.backcolor
    elseif property == :forecolor
        obj.colourable.forecolor

    # getfield
    else
        getfield(obj, property)
    
    end
end