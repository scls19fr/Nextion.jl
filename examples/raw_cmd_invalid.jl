using Nextion
using Test

nexSerial = NexSerial("/dev/ttyUSB0")

@testset "valid" begin
    cmd = "page 0"
    _code = send(nexSerial, cmd)
    @test _code == 0
end

@testset "invalid" begin
    cmd = "pageEEE 0"
    _code = send(nexSerial, cmd)
    @test _code == 0
end

close(nexSerial)
