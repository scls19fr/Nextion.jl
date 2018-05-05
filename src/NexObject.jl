"""
This is an abstract type for each kind
of ITEAD Nextion display objects
"""
abstract type AbstractNexObject end

"""
    PageID(pid)

Page identifier.
"""
struct PageID
    _val::UInt8
end
PageID() = PageID(0)

"""
    ComponentID(pid)

Component identifier.
"""
struct ComponentID
    _val::UInt8
end
ComponentID() = ComponentID(0)

"""
    Name(s)

Name of component.
"""
struct Name
    _s::String
end
String(name::Name) = name._s

"""
    NexID(nexSerial, pid, cid, name)

An identifier for a Nextion object
"""
struct NexID{T <: AbstractNexSerial}
    _nexSerial::T  # Nextion Serial struct with COM port

    _name::Name  # An unique name
    _pid::PageID  # Page ID
    _cid::ComponentID  # Component ID
end

"""
    PageID(obj) -> PageID

Return `PageID` of Nextion object `obj`.
"""
function PageID(obj::AbstractNexObject)::PageID
    obj._nid._pid
end
String(pid::PageID) = string(pid._val)

"""
    ComponentID(obj) -> ComponentID

Return `ComponentID` of Nextion object `obj`.
"""
function ComponentID(obj::AbstractNexObject)::ComponentID
    obj._nid._cid
end
String(cid::ComponentID) = string(cid._val)

"""
    Name(obj) -> Name

Return `Name` of Nextion object `obj`.
"""
function Name(obj::AbstractNexObject)::Name
    obj._nid._name
end

"""
    _send(obj, cmd)

Send command `cmd` to Nextion object `obj`.
"""
function _send(obj::AbstractNexObject, cmd)
    send(obj._nid._nexSerial, cmd)
end

"""
    setVisible(obj, val)

Display Nextion object `obj` when `val` is `true`.
Hide it when `val` is `false`.
"""
function setVisible(obj::AbstractNexObject, val::Bool)
    _o = String(Name(obj))
    #_o = String(ComponentID(obj))
    if val
        cmd = "vis $_o,1"
    else
        cmd = "vis $_o,0"
    end
    _send(obj, cmd)
end

#function name(obj::AbstractNexObject)
#    @deprecate name(obj) get(obj, Name)
#    obj._nid._name
#end
  
#=
# obj need to be mutable

function set!(obj::AbstractNexObject, pid::PageID)
  obj._nid._pid = pid
end

function set!(obj::AbstractNexObject, cid::ComponentID)
  obj._nid._cid = cid
end

function rename!(obj::AbstractNexObject, name::String)
  obj._nid._name = name
end
=#
