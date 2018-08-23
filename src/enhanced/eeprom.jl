"""
    NexEEPROM(nexSerial, name; pid=pid, cid=cid)

A Nextion control to manage Electrically-erasable programmable read-only memory (EEPROM).

!!! note

    Only for enhanced model.
"""
struct NexEEPROM <: AbstractNexObject
    _nid::NexID

    function NexEEPROM(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        error("ToDo")
        new(nid)
    end
end
