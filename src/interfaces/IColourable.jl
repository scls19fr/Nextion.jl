"""
    IColourable(nexid)

An interface for colourable widgets.
"""
struct IColourable <: AbstractINextion
    _nid::NexID

    function IColourable(nid::NexID)
        new(nid)
    end
end
