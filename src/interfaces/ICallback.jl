"""
    ICallback(nexid)

An interface for widgets with callback.
"""
struct ICallback <: AbstractINextion
    _nid::NexID

    function ICallback(nid::NexID)
        new(nid)
    end
end
