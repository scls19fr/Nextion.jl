"""
    NexScrollText(nexSerial, name; pid=pid, cid=cid)

A Nextion Scrolling Text UI control.
"""
struct NexScrollText <: AbstractNexObject
    _nid::NexID

    stringvalued::IStringValued

    function NexScrollText(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        new(nid, IStringValued(nid))
    end
end


function setproperty!(obj::NexScrollText, property::Symbol, new_val)
    # IViewable

    if  property == :visible
        obj.viewable.visible = new_val
    
    # IStringValued
    
    elseif property == :text
        obj.stringvalued.value = new_val

    # Error

    else
        error("setproperty! error '$property'")    

    end

end