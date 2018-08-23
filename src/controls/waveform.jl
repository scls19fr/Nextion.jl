"""
    NexWaveform(nexSerial, name; pid=pid, cid=cid)

A Nextion Waveform UI control.
"""
struct NexWaveform <: AbstractNexObject
    _nid::NexID

    viewable::IViewable
    colourable::IColourable
    touchable::ITouchable

    function NexWaveform(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        new(nid, IViewable(nid), IColourable(nid), ITouchable(nid))
    end
end
