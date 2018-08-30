using LibSerialPort
using Test


@testset "hello_libserial" begin
    v_uint8_eoc = [0xff, 0xff, 0xff]  # Array{UInt8,1}
    # v_char_eoc = Char.([0xff, 0xff, 0xff])  # Array{Char,1} ['ÿ', 'ÿ', 'ÿ']
    s_eoc = String(copy(v_uint8_eoc))  # "\xff\xff\xff"

    #function _write_end_of_command(ser)
    #    for i in 0:2
    #        write(ser, 0xff)
    #    end
    #end

    function _format_command(cmd)
        cmd * s_eoc
    end

    function _execute_command(ser, cmd)
        println(cmd)
        cmd = _format_command(cmd)
        println(transcode(UInt8, cmd))
        write(ser, cmd)
        #_write_end_of_command(ser)
    end

    function main()
        list_ports()

        portname = "/dev/ttyUSB0"
        baudrate = 9600
        ser = open(portname, baudrate)
        _execute_command(ser, "page 0")
        sleep(2)
        _execute_command(ser, "page 1")
        sleep(2)
        _execute_command(ser, "t0.txt=\"Hello\"")
        close(ser)
    end


    main()
    @test true

end
