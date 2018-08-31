using Nextion
using Test


@testset "number" begin

    nexSerial = NexSerial("/dev/ttyUSB0")

    nexNumber = NexNumber(nexSerial, Name("n0"), cid=ComponentID(1))

    send(nexSerial, "page pg_num")

    #=
    sleep(1)

    nexNumber.value = 1

    sleep(1)

    nexNumber.value = 2
    nexNumber.backcolor = Colour.RED
    nexNumber.forecolor = Colour.WHITE

    sleep(1)

    @test nexNumber.value == 2

    sleep(1)

    nexNumber.value = 3
    nexNumber.backcolor = Colour.WHITE
    nexNumber.forecolor = Colour.RED


    sleep(1)
    =#

    #=
    n = typemax(Int32)
    nexNumber.value = n
    sleep(1)
    @test nexNumber.value == n
    =#

    #=
    n = typemin(Int32)
    nexNumber.value = n
    sleep(1)
    @test nexNumber.value == n
    =#

    n = -2
    nexNumber.value = n
    sleep(1)
    @test nexNumber.value == n

    close(nexSerial)

    @test true

end