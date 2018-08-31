using Nextion
using Test


@testset "button" begin

    nexSerial = NexSerial("/dev/ttyUSB0")

    nexButtonPlus = NexButton(nexSerial, Name("b0"), cid=ComponentID(1))
    nexNumber0 = NexNumber(nexSerial, Name("n0"), cid=ComponentID(2))
    nexButtonMinus = NexButton(nexSerial, Name("b1"), cid=ComponentID(3))
    nexButtonEnter = NexButton(nexSerial, Name("b2"), cid=ComponentID(4))

    send(nexSerial, "page pg_but")

    nexButtonPlus.backcolor = Colour.GREEN
    nexButtonMinus.backcolor = Colour.RED

    #nexNumber0.value = value
    value = nexNumber0.value
    while true
        sleep(0.2)
        new_value = nexNumber0.value
        if new_value != value
            value = new_value
            println(value)
        end
    end

    close(nexSerial)

    @test true

end
