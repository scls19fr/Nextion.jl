using Nextion
using Test


@testset "checkbox" begin

    nexSerial = NexSerial("/dev/ttyUSB0")

    nexCheckbox0 = NexCheckbox(nexSerial, Name("c0"), cid=ComponentID(4))
    nexCheckbox1 = NexCheckbox(nexSerial, Name("c1"), cid=ComponentID(5))
    nexCheckbox2 = NexCheckbox(nexSerial, Name("c2"), cid=ComponentID(7))

    send(nexSerial, "page pg_dsb_chk_rad")

    nexCheckbox0.value = false
    nexCheckbox1.value = false
    nexCheckbox2.value = false

    sleep(1)

    nexCheckbox0.value = true

    sleep(1)

    nexCheckbox0.value = false

    sleep(1)

    close(nexSerial)

    @test true

end
