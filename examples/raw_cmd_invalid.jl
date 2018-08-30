using Nextion
using Nextion: checkcommandcomplete, _write_end_of_command
using Test
using LibSerialPort: sp_blocking_read


struct NexResponse
    code::Return.Code.ReturnCode
end

@testset "raw_cmd_invalid" begin

    nexSerial = NexSerial("/dev/ttyUSB0")

    function wait_response(ser)
        delim = Char.([0xff, 0xff, 0xff])
        timeout_ms = 1000
        s = readuntil(ser, delim, timeout_ms)
        r = unsafe_wrap(Vector{UInt8}, s)
        NexResponse(Return.code(r[1]))
    end

    @testset "valid" begin
        pid = 0
        cmd = "page $pid"
        send(nexSerial, cmd)
        cmd = "t0.txt=\"Hello\""
        send(nexSerial, cmd)
    end

    @testset "invalid" begin
        pid = 0
        cmd = "page $pid"
        send(nexSerial, cmd)
        cmd = "t0.txt=\"Valid cmd\""
        send(nexSerial, cmd)
        cmd = "t0.txt=\"Invalid cmd"
        send(nexSerial, cmd)
        r = wait_response(nexSerial._serial)
        println(r)
#    cmd = "pageEEE 0"
    #    _code = send(nexSerial, cmd)
    #    checkcommandcomplete(nexSerial)
    #    #@test _code == Return.Code.INVALID_CMD
    end

    close(nexSerial)
    @test true

end
