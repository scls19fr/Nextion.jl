using Nextion


function _execute_command(nexSerial, cmd)
    println(cmd)
    send(nexSerial, cmd)
end

function main()
    portname = "/dev/ttyUSB0"
    #baudrate = 9600
    #nexSerial = NexSerial(portname, baudrate)
    nexSerial = NexSerial(portname)
    _execute_command(nexSerial, "page 0")
    sleep(2)
    _execute_command(nexSerial, "page 1")
    sleep(2)
    _execute_command(nexSerial, "t0.txt=\"Hello\"")
    close(nexSerial)
end


main()
