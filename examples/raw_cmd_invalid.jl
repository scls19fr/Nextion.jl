using Nextion
using Nextion: checkcommandcomplete, _write_end_of_command
using Test
using LibSerialPort: sp_blocking_read


@testset "raw_cmd_invalid" begin

    nexSerial = NexSerial("/dev/ttyUSB0")

    function wait_response(ser)
        bytes = UInt8[]
        i = 0
        nbend = 0
        timeout = 10
        #port = nexSerial._serial.ref
        #returned_bytes = sp_blocking_read(port, 4000, timeout)
        end0 = 0x00

        while true
            byte = read(ser, UInt8)
            if byte != 0
                s = string(byte, base=16, pad=2)
                println(s)
            end
            if i == 0
                if byte != 0x00  # in ...
                    push!(bytes, byte)
                end
            else
                push!(bytes, byte)
                if length(byte) > 3
                    if bytes[end] == 0xff && bytes[end-1] == 0xff && bytes[end-2] == 0xff
                        error("ToDo: should quit")
                    end
                end
            end
            i = i + 1
        end
        bytes
    end

    @testset "valid" begin
        pid = rand(1:10)
        cmd = "page $pid"
        println(cmd)
        ser = nexSerial._serial
        write(ser, cmd)
        _write_end_of_command(ser)

        write(ser, "sendme")
        _write_end_of_command(ser)        
        r = wait_response(ser)
        println(r)
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
