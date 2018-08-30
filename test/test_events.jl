using Nextion
using Nextion: v_uint8_eoc
using Nextion.Event
using Test


function hasend(msg::Vector{UInt8})
    msg[end] == 0xff && msg[end-1] == 0xff && msg[end-2] == 0xff
end


function ensurehasend(msg::Vector{UInt8})
    if !hasend(msg)
        error("Event message must end with $v_uint8_eoc")
    end
end

function ensurehasexpectedlength(msg::Vector{UInt8}, expectedlength)
    n = length(msg)
    if n != expectedlength
        error("Event message must have $expectedlength bytes not $n")
    end
end

"""
    TouchEvent(msg)

0X65+Page ID+Component ID+TouchEvent+End
"""
struct TouchEvent
    code::Return.Code.ReturnCode
    pid::PageID
    cid::ComponentID
    tevts::Event.Touch.TouchEventCode  # touch event state

    function TouchEvent(msg::Vector{UInt8})
        ensurehasend(msg)
        ensurehasexpectedlength(msg, 7)
        code = Return.code(msg[1])
        pid = PageID(msg[2])
        cid = ComponentID(msg[3])
        tevts = Event.Touch.code(msg[4])
        new(code, pid, cid, tevts)
    end
end

"""
    CurrentPageIDHeadEvent(msg)

0X66+Page ID+End
"""
struct CurrentPageIDHeadEvent
    code::Return.Code.ReturnCode
    pid::PageID

    function CurrentPageIDHeadEvent(msg::Vector{UInt8})
        ensurehasend(msg)
        ensurehasexpectedlength(msg, 5)
        code = Return.code(msg[1])
        pid = PageID(msg[2])
        new(code, pid)
    end
end


"""
    PositionHeadEvent(msg)

0X67++ Coordinate X High-order+Coordinate X Low-order+Coordinate Y High-order+Coordinate Y Low-order+TouchEvent State+End
"""
struct PositionHeadEvent
    code::Return.Code.ReturnCode
    pid::PageID
    x::UInt16
    y::UInt16
    tevts::Event.Touch.TouchEventCode

    function PositionHeadEvent(msg::Vector{UInt8})
        ensurehasend(msg)
        ensurehasexpectedlength(msg, 9)
        code = Return.code(msg[1])
        x = 0  # ToDo msg[2] msg[3]
        y = 0  # ToDo msg[4] msg[5]
        tevts = Event.Touch.code(msg[6])
        new(code, x, y, tevts)
    end
end


"""
    SleepPositionHeadEvent(msg)

0X68++Coordinate X High-order+Coordinate X Low-order+Coordinate Y High-order+Coordinate Y Low-order+TouchEvent State+End
"""
struct SleepPositionHeadEvent
    code::Return.Code.ReturnCode
    pid::PageID

    function SleepPositionHeadEvent(msg::Vector{UInt8})
        ensurehasend(msg)
        code = Return.code(msg[1])
        pid = PageID(msg[2])
        new(code, pid)
    end
end


"""
    StringHeadEvent(msg)

0X70+Variable Content in ASCII code+End
"""
struct StringHeadEvent
    code::Return.Code.ReturnCode
    pid::PageID

    function StringHeadEvent(msg::Vector{UInt8})
        ensurehasend(msg)
        code = Return.code(msg[1])
        pid = PageID(msg[2])
        new(code, pid)
    end
end


"""
    NumberHeadEvent(msg)

0X71+variable binary data(4 bytes little endian mode, low in front)+End
"""
struct NumberHeadEvent
    code::Return.Code.ReturnCode
    pid::PageID

    function NumberHeadEvent(msg::Vector{UInt8})
        ensurehasend(msg)
        code = Return.code(msg[1])
        pid = PageID(msg[2])
        new(code, pid)
    end
end


@testset "Events" begin

    @testset "TouchEvent" begin

        @testset "Constants" begin
            @test Integer(Event.Touch.Press) == 0x01
            @test Integer(Event.Touch.Release) == 0x00
            @test Event.Touch.code(0x01) == Event.Touch.Press
            @test Event.Touch.code(0x00) == Event.Touch.Release
        end

        @testset "Event" begin
            msg = [0x65, 0x00, 0x02, 0x01, 0xff, 0xff, 0xff]
            evt = TouchEvent(msg)
            @test evt.code == Return.Code.EVENT_TOUCH_HEAD
            @test evt.pid == PageID(0x00)
            @test evt.cid == ComponentID(0x02)
            @test evt.tevts == Event.Touch.Press  # touch event state
        end
    end


    @testset "CurrentPageIDHeadEvent" begin
        msg = [0x66, 0x02, 0xff, 0xff, 0xff]
        evt = CurrentPageIDHeadEvent(msg)
        @test evt.code == Return.Code.CURRENT_PAGE_ID_HEAD
        @test evt.pid == PageID(0x02)
    end

    @testset "PositionHeadEvent" begin
        msg = [0x67, 0x00, 0x7a, 0x00, 0x1e, 0x01, 0xff, 0xff, 0xff]
        evt = PositionHeadEvent(msg)
        @test evt.code == Return.Code.EVENT_POSITION_HEAD
        @test evt.x == UInt16(122)
        @test evt.y == UInt16(30)
        @test evt.tevts == Event.Touch.Press  # touch event state
    end


    @testset "SleepPositionHeadEvent" begin
        msg = [0x68, 0x00, 0x7a, 0x00, 0x1e, 0x01, 0xff, 0xff, 0xff]
        evt = SleepPositionHeadEvent(msg)
        @test evt.code == Return.Code.EVENT_SLEEP_POSITION_HEAD
    end


    @testset "StringHeadEvent" begin
        msg = [0x70, 0x61, 0x62, 0x63, 0xff, 0xff, 0xff]
        evt = StringHeadEvent(msg)
        @test evt.code == Return.Code.STRING_HEAD
    end


    @testset "NumberHeadEvent" begin
        msg = [0x71, 0x66, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff]
        evt = NumberHeadEvent(msg)
        @test evt.code == Return.Code.NUMBER_HEAD
    end

end