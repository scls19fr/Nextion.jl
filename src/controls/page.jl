"""
    NexPage(nexSerial, name; pid=pid, cid=cid)

A Nextion Page UI control.

A `NexPage` is the main element of a Nextion UI. It's where controls are put on.
"""
struct NexPage <: AbstractNexObject
    _nid::NexID

    function NexPage(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        new(NexID(nexSerial, name, pid, cid))
    end
end


"""
    show(page, Name)

Show Nextion page named `page` using its name.
"""
function show(page::NexPage, ::Type{Name})
    _nid = NexID(page)
    _name = String(Name(_nid))
    cmd = "page $_name"
    nexSerial = NexSerial(_nid)
    send(nexSerial, cmd)
end


"""
    show(page, PageID)

Show Nextion page named `page` using its page id.
"""
function show(page::NexPage, ::Type{PageID})
    _nid = NexID(page)
    _pid = String(PageID(_nid))
    cmd = "page $_pid"
    nexSerial = NexSerial(_nid)
    send(nexSerial, cmd)
end


"""
    show(page)

Show Nextion page named `page`.

It calls `show(page, Name)` so it's showing
page using its name.
"""
function show(page::NexPage)
    show(page, Name)
end


"""
    isshown(page) -> Bool

Return if a page is currently shown or not.
"""
function isshown(page::NexPage)::Bool
    _nid = NexID(page)
    pid1 = PageID(_nid._nexSerial)  #ToDo: should be implemented
    pid2 = PageID(page)
    pid1 == pid2
end