"""
    NexVariable(nexSerial, name; pid=pid, cid=cid)

A Nextion variable.
"""
struct NexVariable <: AbstractNexObject
    _nid::NexID

    function NexVariable(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
      new(NexID(nexSerial, name, pid, cid))
    end
end

"""
    setValue(variable, val)

Set `variable` value to `val`.
"""
function setValue(nexVariable::NexVariable, val)
    _name = String(name(nexText))
    cmd = "$name.val=$val"
    _send(nexVariable, cmd)
end
