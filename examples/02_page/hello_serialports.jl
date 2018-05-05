# Broken code
# https://github.com/JuliaIO/SerialPorts.jl/issues/23

using SerialPorts

function _write_end_of_command(ser)
    for i in 0:2
        write(ser, 0xff)
    end
end

function _execute_command(ser, cmd)
    println(cmd)
    write(ser, cmd)
    _write_end_of_command(ser)
end

function main()
    portname = "/dev/ttyUSB0"
    baudrate = 9600
    ser = SerialPort(portname, baudrate)
    _execute_command(ser, "page 0")
    sleep(2)
    _execute_command(ser, "page 1")
    sleep(2)
    _execute_command(ser, "t0.txt=\"Hello\"")
    close(ser)
end


main()
