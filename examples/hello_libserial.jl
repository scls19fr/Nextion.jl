using LibSerialPort
using Test


@testset "hello_libserial" begin
    v_uint8_eoc = [0xff, 0xff, 0xff]  # Array{UInt8,1}
    # v_char_eoc = Char.([0xff, 0xff, 0xff])  # Array{Char,1} ['ÿ', 'ÿ', 'ÿ']
    s_eoc = String(copy(v_uint8_eoc))  # "\xff\xff\xff"

    #=
    function _write_end_of_command(ser)
        for i in 0:2
            write(ser, 0xff)
        end
    end
    =#


    function my_readuntil(sp::SerialPort, delim::Vector{T}, timeout_ms::Real) where {T}
        start_time = time_ns()
        out = Vector{T}()
        lastchars = T[0 for i=1:length(delim)]
        while !eof(sp)
            if (time_ns() - start_time)/1e6 > timeout_ms
                break
            end
            if bytesavailable(sp) > 0
                c = read(sp, T)
                push!(out, c)
                lastchars = circshift(lastchars,-1)
                lastchars[end] = c
                if lastchars == delim
                    break
                end
            end
        end
        return out
    end    

    function _format_command(cmd)
        cmd * s_eoc
    end

    function _execute_command(sp, cmd)
        println(cmd)
        cmd = _format_command(cmd)
        println(transcode(UInt8, cmd))
        write(sp, cmd)
        #_write_end_of_command(sp)
    end

    function main()
        list_ports()

        portname = "/dev/ttyUSB0"
        baudrate = 9600
        sp = open(portname, baudrate)
        _execute_command(sp, "page 0")
        sleep(2)
        _execute_command(sp, "page 1")
        sleep(2)
        _execute_command(sp, "t0.txt=\"Hello\"")
        sleep(1)
        println("Read")
        _execute_command(sp, "get t0.txt")
        r = my_readuntil(sp, v_uint8_eoc, 1000)
        println(r)
        s = String(r[2:end-3])
        println(s)
        @test s == "Hello"
        close(sp)
    end


    main()
    @test true

end
