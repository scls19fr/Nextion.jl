using Nextion
using Test


@testset "raw_cmd_invalid" begin

    nexSerial = NexSerial("/dev/ttyUSB0")

    @testset "valid" begin
        cmd = "page 0"
        _code = send(nexSerial, cmd)
        @test _code == Return.Code.CMD_FINISHED
    end

    @testset "invalid" begin
        cmd = "pageEEE 0"
        _code = send(nexSerial, cmd)
        @test _code == Return.Code.INVALID_CMD
    end

    close(nexSerial)
    @test true

end
