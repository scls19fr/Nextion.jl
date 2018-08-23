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
        @assert typeof(font) <: Font "'$font' must be a 'Font'"
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
    elseif property == :alignment
        AlignmentDirection(NexID(obj))
    else
        getfield(obj, property)
    end

end


"""
    obj.alignment.[vertical|horizontal] = ...

Set alignment.
"""
function setproperty!(obj::AlignmentDirection, property::Symbol, align::Alignment.Horizontal.AlignmentHorizontalCode)

    if property == :horizontal
        setnexproperty!(NexID(obj), :xcen, Int(align))
    else
        setfield!(obj, property, align)
    end

end


function setproperty!(obj::AlignmentDirection, property::Symbol, align::Alignment.Vertical.AlignmentVerticalCode)

    if property == :vertical
        setnexproperty!(NexID(obj), :ycen, Int(align))
    else
        setfield!(obj, property, align)
    end

end


function refresh()

end