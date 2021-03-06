using Nextion
using Test


@testset "gauge" begin

    nexSerial = NexSerial("/dev/ttyUSB0")

    nexGauge = NexGauge(nexSerial, Name("z0"), cid=ComponentID(3))

    send(nexSerial, "page pg_gauge")

    nexGauge.backcolor = Colour.WHITE
    nexGauge.forecolor = Colour.RED

    #nexGauge.width = 3  # 0-5
    nexGauge.pointer.width = 3  # 0-5

    #for angle in 30:30:360
    #    sleep(1)
    #    nexGauge.value = angle
    #end
    for angle in 0:6:360
        sleep(0.1)
        nexGauge.value = (angle + 90) % 360
    end

    sleep(1)

    @test nexGauge.value == 90

    close(nexSerial)
    @test true

end