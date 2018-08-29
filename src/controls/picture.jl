"""
    NexPicture(nexSerial, name; pid=pid, cid=cid)

A Nextion Picture UI control.

On Nextion side, it have the following properties:
- pic
"""
struct NexPicture <: AbstractNexObject
    _nid::NexID

    viewable::IViewable
    picturable::IPicturable

    function NexPicture(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        new(nid, IViewable(nid), IPicturable(nid))
    end
end

function setproperty!(obj::NexPicture, property::Symbol, new_val)
    _setcommonproperty!(obj, property, new_val)
end


function getproperty(obj::NexPicture, property::Symbol)
    _getcommonproperty(obj, property)
end
