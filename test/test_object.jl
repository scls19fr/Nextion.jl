using Nextion
using Nextion: NexSerialMock
using Nextion: NexID, PageID, ComponentID, Name

using Test

@testset "Object" begin
    @testset "PageID" begin
        _pid = 2
        @test PageID(_pid)._val == _pid
        @test PageID(_pid) == PageID(_pid)
    end

    @testset "ComponentID" begin
        _cid = 1
        @test ComponentID(_cid)._val == _cid
        @test ComponentID(_cid) == ComponentID(_cid)
    end

    @testset "NexID" begin
        nexSerial = NexSerialMock()
        name, pid, cid = Name("txt_name"), PageID(1), ComponentID(2)
        nid = NexID(nexSerial, name, pid, cid)
        #println(nid)
        #@test Name(nid) == "txt_name"
        #@test PageID(nid) == 1
        #@test ComponentID(nid) == 2
    end

    @testset "NexText" begin
        nexSerial = NexSerialMock()
        nexText = NexText(nexSerial, Name("t0"), pid=PageID(2), cid=ComponentID(3))
        nid = NexID(nexText)
        @test Name(nid) == Name("t0")
        @test PageID(nid) == PageID(2)
        @test ComponentID(nid) == ComponentID(3)
    end

    @testset "Controls constructors" begin
        controls = [
          NexButton,
          NexCheckbox,
          NexCrop,
          NexDualStateButton,
          NexGauge,
          NexHotspot,
          NexNumber,
          NexPage,
          NexPicture,
          NexProgressBar,
          NexQRcode,
          NexRadio,
          NexScrollText,
          NexSlider,
          NexText,
          NexWaveform
        ]
        nexSerial = NexSerialMock()
        for ctl in controls
            ctl(nexSerial, Name("t0"), pid=PageID(0), cid=ComponentID(0))
        end
        @test 1==1
    end

    @testset "Invisible constructors" begin
        controls = [
          NexTimer,
          NexUpload,
          NexVariable
        ]
        nexSerial = NexSerialMock()
        for ctl in controls
            ctl(nexSerial, Name("t0"), pid=PageID(0), cid=ComponentID(0))
        end
        @test 1==1
    end

    @testset "Enhanced constructors" begin
        controls = [
          NexEEPROM,
          NexGPIO,
          NexRTC
        ]
        nexSerial = NexSerialMock()
        for ctl in controls
            ctl(nexSerial, Name("t0"), pid=PageID(0), cid=ComponentID(0))
        end
        @test 1==1
    end    

    @testset "Backlight" begin
        @test_throws ErrorException Backlight(105)
        @test_throws ErrorException Backlight(-10)
        @test_throws ErrorException Backlight(50.3)
        bl = Backlight(30)
        @test bl.value == 30
    end

end


