"""
    NexButton(nexSerial, name; pid=pid, cid=cid)

A Nextion Button UI control.
"""
struct NexButton <: AbstractNexObject
    _nid::NexID

    viewable::IViewable
    stringvalued::IStringValued
    fontstyleable::IFontStyleable
    colourable::IColourable
    touchable::ITouchable

    function NexButton(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        new(nid, IViewable(nid), IStringValued(nid), IFontStyleable(nid), IColourable(nid), ITouchable(nid))
    end
end
