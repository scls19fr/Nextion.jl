"""
This is an abstract type for each kind
of ITEAD Nextion display objects.
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

An identifier for a Nextion object.

It's composed of 4 fields:

- `_nexSerial`: Nextion Serial struct with COM port
- `_name`: an unique name
- `_pid`: Page ID
- `_cid`: Component ID
"""
struct NexID{T <: AbstractNexSerial}
    _nexSerial::T  

    _name::Name  
    _pid::PageID
    _cid::ComponentID
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
    PageID(nexSerial)

Return PageID of current page.

It send `sendme` command to Nextion and wait response.
"""
function PageID(nexSerial::NexSerial)::PageID
    send(nexSerial, "sendme")
    sp = nexSerial._serial
    timeout_ms = 1000
    r = my_readuntil(sp, v_uint8_eoc, timeout_ms)
    #@info r
    if length(r) != 5
        error("Nextion must return a 5 bytes length message")
    end
    if r[1] != Integer(Return.Code.CURRENT_PAGE_ID_HEAD)
        error("Nextion must return $(Return.Code.CURRENT_PAGE_ID_HEAD)")
    end
    PageID(r[2])
end


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
    obj.visible = val

Display Nextion object `obj` when `val` is `true`.
Hide it when `val` is `false`.


    obj.text = text_value

Set text from string value contained in `text_value` to Nextion object `obj`.


    obj.value = value

Set numerical (or boolean) value from `value` to Nextion object `obj`.

    obj.font = new_font

Set font from `Font` struct contained in `new_font` to Nextion object `obj`.

"""
function _setcommonproperty!(obj::AbstractNexObject, property::Symbol, new_val)

    ab = abilities(obj)

    # IViewable
    if property == :visible && :viewable in ab
        obj.viewable.visible = new_val
    
    # IStringValued
    elseif property == :text && :stringvalued in ab
        obj.stringvalued.value = new_val

    # INumericalValued
    elseif property == :value && :numericalvalued in ab
        if obj.numericalvalued.rn === nothing
            obj.numericalvalued.value = new_val
        else
            new_val = Number(obj.numericalvalued.rn(new_val))
            obj.numericalvalued.value = new_val
        end

    # IBooleanValued
    elseif property == :value && :booleanvalued in ab
        obj.booleanvalued.value = new_val

    # IFontStyleable
    elseif property == :font && :fontstyleable in ab
        obj.fontstyleable.font = new_val

    # IColourable
    elseif property == :backcolor && :colourable in ab
        obj.colourable.backcolor = new_val
    
    elseif property == :forecolor && :colourable in ab
        obj.colourable.forecolor = new_val

    # "IPicturable"
    elseif property == :picture && :picturable in ab
        obj.picturable.picture = new_val

    # "IWidthable"
    elseif property == :width && :widthable in ab
        obj.widthable.width = new_val

    # "IHeigthable"
    elseif property == :height && :heightable in ab
        obj.heightable.height = new_val

    # setfield!
    else
        setfield!(obj, property, new_val)

    end
end



"""
    obj.visible

Return True if `obj` is visible; return False otherwise.

    obj.text

Return `text`` property value.

    obj.value

Return `value`` property (numerical valued or boolean valued).
"""
function _getcommonproperty(obj::AbstractNexObject, property::Symbol)
    ab = abilities(obj)

    # IViewable
    if property == :visible && :viewable in ab
        obj.viewable.visible

    # IStringValued
    elseif property == :text && :stringvalued in ab
        obj.stringvalued.value

    # INumericalValued
    elseif property == :value && :numericalvalued in ab
        obj.numericalvalued.value

    # IBooleanValued
    elseif property == :value && :booleanvalued in ab
        obj.booleanvalued.value

    # IFontStyleable
    elseif property == :alignment && :fontstyleable in ab
        obj.fontstyleable.alignment

    # IColourable
    elseif property == :backcolor && :colourable in ab
        obj.colourable.backcolor
    elseif property == :forecolor && :colourable in ab
        obj.colourable.forecolor

    # "IPicturable"
    elseif property == :picture && :picturable in ab
        obj.picturable.picture

    # "IWidthable"
    elseif property == :width && :widthable in ab
        obj.widthable.width

    # "IHeigthable"
    elseif property == :height && :heightable in ab
        obj.heightable.height
    
    # getfield
    else
        getfield(obj, property)
    
    end
end



"""
    setnexproperty!(nid::NexID, property::Symbol, val)

Set property of a Nextion object given by it's NexID

# Example:
`setnexproperty!(NexID("t0"), :txt, "Hello!")` send and execute
on the Nextion display `t0.txt="Hello"`

`setnexproperty!(NexID("n0"), :val, 3)` send and execute
on the Nextion display `n0.val=3`
"""
function setnexproperty!(nid::NexID, property::Symbol, val::String)
    _name = String(Name(nid))
    _property = String(property)
    cmd = "$_name.$_property=\"$val\""
    nexSerial = NexSerial(nid)
    send(nexSerial, cmd)
end

function setnexproperty!(nid::NexID, property::Symbol, val::Bool)
    if val
        val = 1
    else
        val = 0
    end
    setnexproperty!(nid, property, val)
end


function setnexproperty!(nid::NexID, property::Symbol, val)
    _name = String(Name(nid))
    _property = String(property)
    cmd = "$_name.$_property=$val"
    nexSerial = NexSerial(nid)
    send(nexSerial, cmd)
end

"""
    getnexproperty(nid::NexID, property::Symbol)

Get property of a Nextion object given by it's NexID
"""
function getnexproperty(nid::NexID, property::Symbol, ::Type{Int})
    error("ToDo getnexproperty Int")
end

function getnexproperty(nid::NexID, property::Symbol, ::Type{String})
    #error("ToDo getnexproperty String")

    # send cmd to Nextion
    _name = String(Name(nid))
    _property = String(property)
    cmd = "get $_name.$_property"
    println(cmd)
    nexSerial = NexSerial(nid)
    send(nexSerial, cmd)
    sleep(1)
    # receive Nextion message
    timeout_ms = 1000
    sp = nexSerial._serial
    #r = my_readuntil(sp, v_uint8_eoc, timeout_ms)
    nb, r = sp_blocking_read(sp.ref, bytesavailable(sp), timeout_ms)
    println(r)
    s = String(r[2:end-3])
    s
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
