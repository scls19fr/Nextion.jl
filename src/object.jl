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
    PageID(nid) -> PageID

Return `PageID` from `NexID` `nid`.
"""
function PageID(nid::NexID)::PageID
    nid._pid
end
String(pid::PageID) = string(pid._val)


"""
    ComponentID(nid) -> ComponentID

Return `ComponentID` from `NexID` `nid`.
"""
function ComponentID(nid::NexID)::ComponentID
    nid._cid
end
String(cid::ComponentID) = string(cid._val)


"""
    Name(nid) -> Name

Return `Name` from `NexID` `nid`.
"""
function Name(nid::NexID)::Name
    nid._name
end

"""
    setNexProperty(nid::NexID, property::Symbol, val)

Set property of a Nextion object given by it's NexID

# Example:
`setNexProperty(NexID("t0"), :txt, "Hello!")` send and execute
on the Nextion display `t0.txt="Hello"`
"""
function setNexProperty(nid::NexID, property::Symbol, val::String)
    _name = String(Name(nid))
    _property = String(property)
    cmd = "$_name.$_property=\"$val\""
    nexSerial = NexSerial(nid)
    send(nexSerial, cmd)
end

function setNexProperty(nid::NexID, property::Symbol, val)
    _name = String(Name(nid))
    _property = String(property)
    cmd = "$_name.$_property=$val"
    nexSerial = NexSerial(nid)
    send(nexSerial, cmd)
end



"""
    NexSerial(nid) -> NexSerial

Return NexSerial from NexID `nid`
"""
function NexSerial(nid::NexID)
    nid._nexSerial
end


"""
    NexID(obj) -> NexID

Return `NexID` from Nextion object obj.
"""
function NexID(obj::AbstractNexObject)
    obj._nid
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
