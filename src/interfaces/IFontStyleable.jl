struct Font
    id::UInt8
end
Font(id::Number) = Font(UInt8(id))

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
    _nid = NexID(obj)
    _name = String(Name(_nid))
    cmd = "$_name.font=$(font.id)"
    nexSerial = NexSerial(_nid)
    send(nexSerial, cmd)
end

function getFont(obj::IFontStyleable)::Font

end

function setAlignment(obj::IFontStyleable, align::Alignment.Horizontal.AlignmentHorizontalCode)
    _nid = NexID(obj)
    _name = String(Name(_nid))
    align_id = Int(align)
    cmd = "$_name.xcen=$align_id"
    nexSerial = NexSerial(_nid)
    send(nexSerial, cmd)
end

function setAlignment(obj::IFontStyleable, align::Alignment.Vertical.AlignmentVerticalCode)
    _nid = NexID(obj)
    _name = String(Name(_nid))
    align_id = Int(align)
    cmd = "$_name.ycen=$align_id"
    nexSerial = NexSerial(_nid)
    send(nexSerial, cmd)
end

function refresh()

end