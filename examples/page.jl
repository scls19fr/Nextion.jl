using Nextion
using Nextion: NexID
using Test


@testset "page" begin

    nexSerial = NexSerial("/dev/ttyUSB0")

    # Nextion pages are 0-indexed
    # nexPages is a Julia Vector and is 1-indexed

    nexPages = NexPage[]
    pages_nb = 22
    for i in 0:pages_nb-1
        nexPage = NexPage(nexSerial, Name("page$i"), pid=PageID(i), cid=ComponentID(0))
        push!(nexPages, nexPage)
    end

    for i in 1:pages_nb
        show(nexPages[i], PageID)
        sleep(0.5)
    end

    sleep(2)

    nexPage = nexPages[1]  # page0
    show(nexPage)
    @test PageID(NexID(nexPage)) == PageID(0x00)

    sleep(2)

    @test PageID(nexSerial) == PageID(0x00)  # return current page (send command sendme and wait response)

    sleep(0.1)

    @test isshown(nexPages[1])  # Page 1 (ie page0) is visible
    @test !isshown(nexPages[2])  # Page 2 (ie page1) is not visible

    close(nexSerial)
    @test true

end