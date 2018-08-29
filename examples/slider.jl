using Nextion
using Test


@testset "slider" begin

    nexSerial = NexSerial("/dev/ttyUSB0")

    nexSlider = NexSlider(nexSerial, Name("h0"), cid=ComponentID(4))

    send(nexSerial, "page pg_slider")
    sleep(0.1)

    nexSlider.value = 43691  # 0-65535

    sleep(1)

    #nexSlider.cursor.color = Colour.GRAY
    nexSlider.forecolor = Colour.GRAY

    sleep(1)

    nexSlider.cursor.width = 10

    sleep(1)

    nexSlider.cursor.height = 13

    sleep(1)

    close(nexSerial)
    @test true

end
