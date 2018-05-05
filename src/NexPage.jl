"""
    NexPage(nexSerial, name; pid=pid, cid=cid)

A Nextion Page UI control.
"""
struct NexPage <: AbstractNexObject
    _nid::NexID

    function NexPage(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        new(NexID(nexSerial, name, pid, cid))
    end
end

"""
    show(page)

Show Nextion page named `page`.
"""
function Base.show(page::NexPage)
    _name = String(Name(page))
    cmd = "page $_name"
    _send(page, cmd)
end

"""
    isshown(page)

Return if a page is currently shown or not.
"""
function isshown(page)
    pid1 = PageID(page._nid._nexSerial)  #ToDo: should be implemented
    pid2 = PageID(page)
    pid1 == pid2
end