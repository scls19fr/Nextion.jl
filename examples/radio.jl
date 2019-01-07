using Nextion
using Test


@testset "radio" begin

    nexSerial = NexSerial("/dev/ttyUSB0")

    nexRadio0 = NexRadio(nexSerial, Name("r0"), cid=ComponentID(8))
    nexRadio1 = NexRadio(nexSerial, Name("r1"), cid=ComponentID(9))
    nexRadio2 = NexRadio(nexSerial, Name("r2"), cid=ComponentID(10))

    send(nexSerial, "page pg_dsb_chk_rad")

    nexRadio0.value = false
    nexRadio1.value = false
    nexRadio2.value = false
    
    @test !nexRadio0.value

    sleep(1)

    nexRadio0.value = true
    
    @test nexRadio0.value

    sleep(1)

    nexRadio0.value = false

    @test !nexRadio0.value

    sleep(1)

    close(nexSerial)

    @test true

end
