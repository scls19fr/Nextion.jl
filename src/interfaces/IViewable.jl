"""
    IViewable(nexid)

An interface for widgets that can be shown or hidden.
"""
struct IViewable <: AbstractINextion
    _nid::NexID

    function IViewable(nid::NexID)
        new(nid)
    end
end


"""
    setVisible(obj, val)

Display Nextion object `obj` when `val` is `true`.
Hide it when `val` is `false`.
"""
function setVisible(obj::IViewable, val::Bool)
    nid = NexID(obj)
    _oid = String(Name(nid))
    #_oid = String(ComponentID(nid))
    if val
        cmd = "vis $_oid,1"
    else
        cmd = "vis $_oid,0"
    end
    nexSerial = NexSerial(nid)
    send(nexSerial, cmd)
end
