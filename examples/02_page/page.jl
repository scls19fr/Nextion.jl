using Nextion
using Test

@testset "page" begin
    nexSerial = NexSerial("/dev/ttyUSB0", 9600)

    nexPage0 = NexPage(nexSerial, Name("page0"), pid=PageID(0), cid=ComponentID(0))
    nexPage1 = NexPage(nexSerial, Name("page1"), pid=PageID(1), cid=ComponentID(0))

    sleep(0.5)

    show(nexPage0)

    sleep(0.5)

    show(nexPage1)

    sleep(0.5)

    show(nexPage0)
    @test PageID(nexPage0)==PageID(0x00)

    sleep(0.5)

    show(nexPage1)
    @show PageID(nexPage1)==PageID(0x01)

    sleep(0.1)

    #@show isshown(nexPage1)
    #@show !isshown(nexPage0)

    close(nexSerial)
end