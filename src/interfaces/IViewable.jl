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
    obj.visible = new_val

Set value from `new_val` to Nextion object `obj`.
"""
function setproperty!(obj::IViewable, property::Symbol, new_val)

    if property == :visible
        nid = NexID(obj)
        _oid = String(Name(nid))
        #_oid = String(ComponentID(nid))
        if new_val
            cmd = "vis $_oid,1"
        else
            cmd = "vis $_oid,0"
        end
        nexSerial = NexSerial(nid)
        send(nexSerial, cmd)
    else
        setfield!(obj, property, new_val)
    end

end
