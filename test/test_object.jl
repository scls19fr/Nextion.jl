using Nextion
using Nextion: NexSerialMock, NexID

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
    end

    @testset "NexText" begin
        nexSerial = NexSerialMock()
        nexText = NexText(nexSerial, Name("t0"), pid=PageID(2), cid=ComponentID(3))
        nid = NexID(nexText)
        @test Name(nid) == Name("t0")
        @test PageID(nid) == PageID(2)
        @test ComponentID(nid) == ComponentID(3)
    end
end
