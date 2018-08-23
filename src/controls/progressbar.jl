"""
    NexProgressBar(nexSerial, name; pid=pid, cid=cid)

A Nextion Progress Bar UI control.

On Nextion side, it have the following properties:
- bco
- pco
- val
"""
struct NexProgressBar <: AbstractNexObject
    _nid::NexID

    viewable::IViewable
    numericalvalued::INumericalValued
    colourable::IColourable
    touchable::ITouchable

    function NexProgressBar(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        new(nid, IViewable(nid), INumericalValued(nid, RangeNumber{Int64, 0:100}), IColourable(nid), ITouchable(nid))
        #new(nid, IViewable(nid), INumericalValued(nid), IColourable(nid), ITouchable(nid))
    end
end


"""
    obj.visible = val

Display Nextion object `obj` when `val` is `true`.
Hide it when `val` is `false`.

    obj.value = value

Set numerical value from `value` to Nextion object `obj`.
"""
function setproperty!(obj::NexProgressBar, property::Symbol, new_val)

    # IViewable
    if property == :visible
        obj.viewable.visible = new_val

    # INumericalValued
    elseif property == :value
        if obj.numericalvalued.rn === nothing
            obj.numericalvalued.value = new_val
        else
            new_val = Number(obj.numericalvalued.rn(new_val))
            obj.numericalvalued.value = new_val
        end

    # setfield!
    else
        setfield!(obj, property)
    
    end
end