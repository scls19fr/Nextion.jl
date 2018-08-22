"""
    NexUpload(nexSerial, name; pid=pid, cid=cid)

A Nextion control to download the tft file.
"""
struct NexUpload <: AbstractNexObject
    _nid::NexID

    function NexUpload(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        error("ToDo")
        new(nid)
    end
end
