using Nextion
#using Nextion: v_uint8_eoc
using Nextion.Event
using Nextion: TouchEvent, CurrentPageIDHeadEvent, PositionHeadEvent, SleepPositionHeadEvent, StringHeadEvent, NumberHeadEvent
using Test


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
        @test evt.tevts == Event.Touch.Press
    end


    @testset "SleepPositionHeadEvent" begin
        msg = [0x68, 0x00, 0x7a, 0x00, 0x1e, 0x01, 0xff, 0xff, 0xff]
        evt = SleepPositionHeadEvent(msg)
        @test evt.code == Return.Code.EVENT_SLEEP_POSITION_HEAD
        @test evt.x == UInt16(122)
        @test evt.y == UInt16(30)
        @test evt.tevts == Event.Touch.Press
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

    end

end