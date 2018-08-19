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

function setFont(obj::IFontStyleable, font::Font)
    setNexProperty(NexID(obj), :font, font.id)
end

function getFont(obj::IFontStyleable)::Font
    # Font(getNexProperty(NexID(obj), :font, Int))
end

function setAlignment(obj::IFontStyleable, align::Alignment.Horizontal.AlignmentHorizontalCode)
    setNexProperty(NexID(obj), :xcen, Int(align))
end

function setAlignment(obj::IFontStyleable, align::Alignment.Vertical.AlignmentVerticalCode)
    setNexProperty(NexID(obj), :ycen, Int(align))
end

function refresh()

end