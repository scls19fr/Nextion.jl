"""
Module Event
"""
module Event

    using Nextion.Return
    using Nextion: PageID, ComponentID
    using Nextion: hasend, ensurehasend

    module Touch
        @enum TouchEventCode::UInt8 begin
            Press = 0x01
            Release = 0x00
        end
        function code(val::UInt8)
            TouchEventCode(val)
        end    
    end


    abstract type  AbstractNexEvent end

    abstract type ExpectedMessageSize end
    struct SizeUnknown <: ExpectedMessageSize end
    struct HasLength <: ExpectedMessageSize end
    
    
    ExpectedMessageSize(::Type{<: AbstractNexEvent}) = SizeUnknown()


    function ensurehasexpectedlength(msg::Vector{UInt8}, typ::Type)
        if ExpectedMessageSize(typ) == HasLength()
            n = length(msg)
            expectedlength = length(typ)
            if n != expectedlength
                error("Event message must have $expectedlength bytes not $n")
            end
        end
    end

    """
        TouchEvent(msg)
    
    0X65+Page ID+Component ID+TouchEvent+End
    """
    struct TouchEvent <: AbstractNexEvent
        code::Return.Code.ReturnCode
        pid::PageID
        cid::ComponentID
        tevts::Event.Touch.TouchEventCode  # touch event state
    
        function TouchEvent(msg::Vector{UInt8})
            ensurehasend(msg)
            ensurehasexpectedlength(msg, TouchEvent)
            code = Return.code(msg[1])
            pid = PageID(msg[2])
            cid = ComponentID(msg[3])
            tevts = Event.Touch.code(msg[4])
            new(code, pid, cid, tevts)
        end
    end
    Base.length(::Type{TouchEvent}) = 7
    
    
    """
        CurrentPageIDHeadEvent(msg)
    
    0X66+Page ID+End
    """
    struct CurrentPageIDHeadEvent <: AbstractNexEvent
        code::Return.Code.ReturnCode
        pid::PageID
    
        function CurrentPageIDHeadEvent(msg::Vector{UInt8})
            ensurehasend(msg)
            ensurehasexpectedlength(msg, CurrentPageIDHeadEvent)
            code = Return.code(msg[1])
            pid = PageID(msg[2])
            new(code, pid)
        end
    end
    Base.length(::Type{CurrentPageIDHeadEvent}) = 5
    
    
    function Base.UInt16(x1::UInt8, x2::UInt8)::UInt16
        UInt16(x1) << 8 + UInt16(x2)
    end
    
    
    """
        PositionHeadEvent(msg)
    
    0X67++ Coordinate X High-order+Coordinate X Low-order+Coordinate Y High-order+Coordinate Y Low-order+TouchEvent State+End
    """
    struct PositionHeadEvent <: AbstractNexEvent
        code::Return.Code.ReturnCode
        x::UInt16
        y::UInt16
        tevts::Event.Touch.TouchEventCode
    
        function PositionHeadEvent(msg::Vector{UInt8})
            ensurehasend(msg)
            ensurehasexpectedlength(msg, PositionHeadEvent)
            code = Return.code(msg[1])
            x = UInt16(msg[2], msg[3])
            y = UInt16(msg[4], msg[5])
            tevts = Event.Touch.code(msg[6])
            new(code, x, y, tevts)
        end
    end
    Base.length(::Type{PositionHeadEvent}) = 9
    
    
    """
        SleepPositionHeadEvent(msg)
    
    0X68++Coordinate X High-order+Coordinate X Low-order+Coordinate Y High-order+Coordinate Y Low-order+TouchEvent State+End
    """
    struct SleepPositionHeadEvent <: AbstractNexEvent
        code::Return.Code.ReturnCode
        x::UInt16
        y::UInt16
        tevts::Event.Touch.TouchEventCode
    
        function SleepPositionHeadEvent(msg::Vector{UInt8})
            ensurehasend(msg)
            ensurehasexpectedlength(msg, SleepPositionHeadEvent)
            code = Return.code(msg[1])
            x = UInt16(msg[2], msg[3])
            y = UInt16(msg[4], msg[5])
            tevts = Event.Touch.code(msg[6])
            new(code, x, y, tevts)
        end
    end
    Base.length(::Type{SleepPositionHeadEvent}) = 9
    
    
    """
        StringHeadEvent(msg)
    
    0X70+Variable Content in ASCII code+End
    """
    struct StringHeadEvent <: AbstractNexEvent
        code::Return.Code.ReturnCode
        value::String
    
        function StringHeadEvent(msg::Vector{UInt8})
            ensurehasend(msg)
            ensurehasexpectedlength(msg, StringHeadEvent)
            code = Return.code(msg[1])
            @assert code == first(StringHeadEvent)
            value = String(msg[2:end - 3])
            new(code, value)
        end
    end
    first(::Type{StringHeadEvent}) = Return.Code.STRING_HEAD
    #Base.length(::Type{StringHeadEvent}) = ???  # variable length
    
    
    """
        NumberHeadEvent(msg)
    
    0X71+variable binary data(4 bytes little endian mode, low in front)+End
    """
    struct NumberHeadEvent <: AbstractNexEvent
        code::Return.Code.ReturnCode
        value::UInt32
        signedvalue::Int32
    
        function NumberHeadEvent(msg::Vector{UInt8})
            ensurehasend(msg)
            ensurehasexpectedlength(msg, NumberHeadEvent)
            code = Return.code(msg[1])
            @assert code == first(NumberHeadEvent)
            value = UInt32(msg[2]) + UInt32(msg[3]) << 8 + UInt32(msg[4]) << 16 + UInt32(msg[5]) << 24
            signedvalue = reinterpret(Int32, value)
            new(code, value, signedvalue)
        end
    end
    first(::Type{NumberHeadEvent}) = Return.Code.NUMBER_HEAD
    Base.length(::Type{NumberHeadEvent}) = 8
    
end
