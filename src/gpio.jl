module GPIO

    """
    Mode of the GPIO
    """
    module Mode

        @enum ModeCode::UInt8 begin
            PULL_UP_INPUT_MODE = 0
            INPUT_BINDING_MODE = 1
            PUSH_PULL_OUTPUT_MODE = 2
            PWM_OUTPUT_MODE = 3
            OPEN_DRAIN_OUTPUT_MODE = 4
        end

    end

end


"""
    NexGPIO(nexSerial, name; pid=pid, cid=cid)

A Nextion control to General Purpose Input/Output (GPIO).

!!! note

    Only for enhanced model.
"""
struct NexGPIO <: AbstractNexObject
    _nid::NexID

    function NexGPIO(nexSerial::T, name::Name; pid=PageID(), cid=ComponentID()) where {T <: AbstractNexSerial}
        nid = NexID(nexSerial, name, pid, cid)
        error("ToDo")
        new(nid)
    end
end
