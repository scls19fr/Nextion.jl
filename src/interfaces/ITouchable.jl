"""
    ITouchable(nexid)

An interface for touchable widgets.
"""
struct ITouchable <: AbstractINextion
    _nid::NexID

    function ITouchable(nid::NexID)
        new(nid)
    end
end
