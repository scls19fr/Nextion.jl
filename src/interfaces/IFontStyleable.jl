struct Font
    id::UInt8
end
Font(id::Number) = Font(UInt8(id))

struct AlignmentDirection
    _nid::NexID
end
NexID(align::AlignmentDirection) = align._nid

"""
    IFontStyleable(nexid)

An interface for font styleable widgets.
"""
struct IFontStyleable <: AbstractINextion
    _nid::NexID

    function IFontStyleable(nid::NexID)
        new(nid)
    end
end


"""
    obj.font = new_font

Set value from `new_val` to Nextion object `obj`.
"""
function setproperty!(obj::IFontStyleable, property::Symbol, new_val)

    if property == :font
        font = new_val
        setnexproperty!(NexID(obj), :font, font.id)
    else
        setfield!(obj, property, new_val)
    end

end


"""
    obj.font

Get `value` property from Nextion object `obj`.
"""
function getproperty(obj::IFontStyleable, property::Symbol)

    if property == :font
        Font(getnexproperty(NexID(obj), :font, Int))
    else
        getfield(obj, property)
    end

end


function setAlignment(obj::IFontStyleable, align::Alignment.Horizontal.AlignmentHorizontalCode)
    setnexproperty!(NexID(obj), :xcen, Int(align))
end

function setAlignment(obj::IFontStyleable, align::Alignment.Vertical.AlignmentVerticalCode)
    setnexproperty!(NexID(obj), :ycen, Int(align))
end

function refresh()

end