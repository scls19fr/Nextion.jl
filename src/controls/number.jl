"""
    NexNumber(nexSerial, name; pid=pid, cid=cid)

A Nextion Number UI control.
"""
struct NexNumber <: AbstractNexObject
    _nid::NexID

    viewable::IViewable
    numericalvalued::INumericalValued
    fontstyleable::IFontStyleable
    colourable::IColourable
    touchable::ITouchable

    function NexNumber(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        new(nid, IViewable(nid), INumericalValued(nid, nothing), IFontStyleable(nid), IColourable(nid), ITouchable(nid))
    end
end

"""
    obj.visible = val

Display Nextion object `obj` when `val` is `true`.
Hide it when `val` is `false`.

    obj.value = value

Set numerical value from `value` to Nextion object `obj`.

    obj.font = new_font

Set font from `Font` struct contained in `new_font` to Nextion object `obj`.

On Nextion side, it have the following properties:
- bco
- pco
- font
- xcen
- ycen
- val
- length
- format
- isbr
"""
function setproperty!(obj::NexNumber, property::Symbol, new_val)

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

    # IFontStyleable
    elseif property == :font
        setFont(obj.fontstyleable, new_val)

    # IColourable
    elseif property == :backcolor
        obj.colourable.backcolor = new_val

    elseif property == :forecolor
        obj.colourable.forecolor = new_val

    # getfield
    else
        setfield!(obj, property, new_val)

    end
end


function getproperty(obj::NexNumber, property::Symbol)

    # IViewable
    if property == :visible
        obj.viewable.visible

    # INumericalValued
    elseif property == :text
        obj.numericalvalued.value

    # IFontStyleable
    elseif property == :alignment
        obj.fontstyleable.alignment

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