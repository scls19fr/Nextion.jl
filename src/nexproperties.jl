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
    # send cmd to Nextion
    _name = String(Name(nid))
    _property = String(property)
    cmd = "get $_name.$_property"
    @info cmd
    nexSerial = NexSerial(nid)
    send(nexSerial, cmd)

    # wait cmd completed
    timeout_ms = nexSerial.timeout_ms
    sp = nexSerial._serial
    waitcommandcomplete(sp, timeout_ms)

    # receive Nextion message
    #r = my_readuntil(sp, v_uint8_eoc, timeout_ms)
    nb, r = sp_blocking_read(sp.ref, my_bytesavailable(sp), timeout_ms)
    @info r
    evt = Event.NumberHeadEvent(r)
    evt.value
end

function getnexproperty(nid::NexID, property::Symbol, ::Type{String})
    # send cmd to Nextion
    _name = String(Name(nid))
    _property = String(property)
    cmd = "get $_name.$_property"
    @info cmd
    nexSerial = NexSerial(nid)
    send(nexSerial, cmd)

    # wait cmd completed
    timeout_ms = nexSerial.timeout_ms
    sp = nexSerial._serial
    waitcommandcomplete(sp, timeout_ms)

    # receive Nextion message
    #r = my_readuntil(sp, v_uint8_eoc, timeout_ms)
    nb, r = sp_blocking_read(sp.ref, my_bytesavailable(sp), timeout_ms)
    @info r
    evt = Event.StringHeadEvent(r)
    evt.value
end