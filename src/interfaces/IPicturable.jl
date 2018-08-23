"""
    IPicturable(nexid)

An interface for picturable widgets.
"""
struct IPicturable <: AbstractINextion
    _nid::NexID

    function IPicturable(nid::NexID)
        new(nid)
    end
end
