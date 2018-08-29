using Nextion
using Nextion: checkcommandcomplete, _write_end_of_command
using Test


@testset "raw_cmd_invalid" begin

    nexSerial = NexSerial("/dev/ttyUSB0")

    @testset "valid" begin
        pid = rand(1:10)
        cmd = "page $pid"
        ser = nexSerial._serial
        write(ser, cmd)
        _write_end_of_command(ser)
    
        #_code = send(nexSerial, cmd)
        #ret = checkcommandcomplete(nexSerial)
        #println(ret)
        #@test _code == Return.Code.CMD_FINISHED

        #0x01 0xff 0xff 0xff
    end

    #@testset "invalid" begin
    #    cmd = "pageEEE 0"
    #    _code = send(nexSerial, cmd)
    #    checkcommandcomplete(nexSerial)
    #    #@test _code == Return.Code.INVALID_CMD
    #end

    close(nexSerial)
    @test true

end
