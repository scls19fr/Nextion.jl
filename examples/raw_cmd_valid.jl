using Nextion
using Test


@testset "raw_cmd_valid" begin

    nexSerial = NexSerial("/dev/ttyUSB0")

    send(nexSerial, "page 0")

    send(nexSerial, "cls WHITE")
    # send(nexSerial, "rest")

    sleep(0.5)

    send(nexSerial, "t0.txt=\"Hello\"")

    sleep(0.5)

    send(nexSerial, "t0.txt=\"1\"")

    sleep(0.5)

    send(nexSerial, "t0.txt=\"2\"")

    sleep(0.5)

    send(nexSerial, "t0.txt=\"3\"")

    sleep(0.5)

    send(nexSerial, "t0.txt=\"Bye\"")

    close(nexSerial)
    
    @test true

end