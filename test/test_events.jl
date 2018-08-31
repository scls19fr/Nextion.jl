using Nextion
using Nextion.Event: TouchEvent, CurrentPageIDHeadEvent, PositionHeadEvent, SleepPositionHeadEvent, StringHeadEvent, NumberHeadEvent
using Nextion.Event.Touch
using Test


@testset "Events" begin

    @testset "TouchEvent" begin

        @testset "Constants" begin
            @test Integer(Touch.Press) == 0x01
            @test Integer(Touch.Release) == 0x00
            @test Touch.code(0x01) == Touch.Press
            @test Touch.code(0x00) == Touch.Release
        end

        @testset "Event" begin
            msg = [0x65, 0x00, 0x02, 0x01, 0xff, 0xff, 0xff]
            evt = TouchEvent(msg)
            @test evt.code == Return.Code.EVENT_TOUCH_HEAD
            @test evt.pid == PageID(0x00)
            @test evt.cid == ComponentID(0x02)
            @test evt.tevts == Touch.Press  # touch event state
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
        @test evt.tevts == Touch.Press
    end


    @testset "SleepPositionHeadEvent" begin
        msg = [0x68, 0x00, 0x7a, 0x00, 0x1e, 0x01, 0xff, 0xff, 0xff]
        evt = SleepPositionHeadEvent(msg)
        @test evt.code == Return.Code.EVENT_SLEEP_POSITION_HEAD
        @test evt.x == UInt16(122)
        @test evt.y == UInt16(30)
        @test evt.tevts == Touch.Press
    end


    @testset "StringHeadEvent" begin
        msg = [0x70, 0x61, 0x62, 0x63, 0xff, 0xff, 0xff]
        evt = StringHeadEvent(msg)
        @test evt.code == Return.Code.STRING_HEAD
        @test evt.value == "abc"
    end


    @testset "NumberHeadEvent" begin
        msg = [0x71, 0x66, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff]
        evt = NumberHeadEvent(msg)
        @test evt.code == Return.Code.NUMBER_HEAD
        @test evt.value == 102

        msg = [0x71, 0x66, 0x01, 0x00, 0x00, 0xff, 0xff, 0xff]
        evt = NumberHeadEvent(msg)
        @test evt.value == 0x00000166 # 102 + 256

        msg = [0x71, 0x01, 0xff, 0x00, 0x00, 0xff, 0xff, 0xff]
        evt = NumberHeadEvent(msg)
        @test evt.value == 0x0000ff01 # 65281

        msg = [0x71, 0x01, 0x00, 0xff, 0x00, 0xff, 0xff, 0xff]
        evt = NumberHeadEvent(msg)
        @test evt.value == 0x00ff0001 # 16711681

        msg = [0x71, 0x01, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff]
        evt = NumberHeadEvent(msg)
        @test evt.value == 0xff000001
        
        msg = UInt8[0x71, 0xff, 0xff, 0xff, 0x7f, 0xff, 0xff, 0xff]
        evt = NumberHeadEvent(msg)
        @test evt.value == typemax(Int32)

        msg = [0x71, 0xfe, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff]
        evt = NumberHeadEvent(msg)
        @test evt.value == -2

        msg = UInt8[0x71, 0x00, 0x00, 0x00, 0x80, 0xff, 0xff, 0xff]
        evt = NumberHeadEvent(msg)
        @test evt.value == typemin(Int32)


    end

end