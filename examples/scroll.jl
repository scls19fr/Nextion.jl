using Nextion
using Test


@testset "scroll" begin

    nexSerial = NexSerial("/dev/ttyUSB0")

    nexPage = NexPage(nexSerial, Name("pg_scroll"), pid=PageID(6))
    show(nexPage)

    nexScrollText = NexScrollText(nexSerial, Name("g0"), pid=PageID(1))
    msg = "Hello Nextion!"
    nexScrollText.text = msg
    assert nexScrollText.text == msg    
    
    sleep(10)

    close(nexSerial)
    @test true

end
