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
