"""
    NexCrop(nexSerial, name; pid=pid, cid=cid)

A Nextion UI control to deal with cropped picture widget.
"""
struct NexCrop <: AbstractNexObject
    _nid::NexID

    viewable::IViewable
    picturable::IPicturable
    touchable::ITouchable

    function NexCrop(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        new(nid, IViewable(nid), IPicturable(nid), ITouchable(nid))
    end
end
