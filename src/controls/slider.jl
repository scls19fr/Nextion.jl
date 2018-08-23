"""
    NexSlider(nexSerial, name; pid=pid, cid=cid)

A Nextion Slider UI control.
"""
struct NexSlider <: AbstractNexObject
    _nid::NexID

    viewable::IViewable
    numericalvalued::INumericalValued
    colourable::IColourable
    touchable::ITouchable
    
    function NexSlider(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        new(nid, IViewable(nid), INumericalValued(nid, RangeNumber{Int16, 0:typemax(UInt16)}), IColourable(nid), ITouchable(nid))
    end
end


function setproperty!(obj::NexSlider, property::Symbol, new_val)

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