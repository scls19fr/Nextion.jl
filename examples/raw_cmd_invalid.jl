using Nextion
using Nextion: checkcommandcomplete, _write_end_of_command
using Test
using LibSerialPort: sp_blocking_read


@testset "raw_cmd_invalid" begin

    nexSerial = NexSerial("/dev/ttyUSB0")

    function wait_response(ser)
        #bytes = UInt8[]
        #i = 0
        #nbend = 0
        #timeout = 10
        #port = nexSerial._serial.ref
        #returned_bytes = sp_blocking_read(port, 4000, timeout)
        #delim = [Char(0xff), Char(0xff), Char(0xff)]
        #delim = [Char(0xff), Char(0xff), Char(0xff)]
        #0x050x05delim = Char.([0xff, 0xff, 0xff])
        delim = Char.([0xff, 0xff, 0xff])
        timeout_ms = 1000
        s = readuntil(ser, delim, timeout_ms)
        #r = Vector{UInt8}(s)
        r = unsafe_wrap(Vector{UInt8}, s)
        #println(typeof(r))
        #=
        #while true
        while !eof(ser)
            byte = read(ser, UInt8)
            #if byte != 0
                s = string(byte, base=16, pad=2)
                println(s)
            #end
            if i == 0
                if byte != 0x00  # in ...
                    push!(bytes, byte)
                    i = i + 1
                end
            else
                push!(bytes, byte)
                if length(bytes) > 3
                    #println(bytes)
                    #println("$bytes[end], $bytes[end-1], $bytes[end-2]")
                    if bytes[end] == 0xff && bytes[end-1] == 0xff && bytes[end-2] == 0xff
                        break
                    #elseif bytes[end] == 0x00 && bytes[end-1] == 0x00 && bytes[end-2] == 0x00 && bytes[end-3] == 0x00
                    #    break
                    end
                end
                i = i + 1
            end
        end
        =#
        r
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
