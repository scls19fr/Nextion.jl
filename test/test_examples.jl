#=
This examples can only be run
when a Nextion display is connected
to USB TTL converter

Correct test.tft file should be previously
send to display using uSD card
=#

using Nextion
using Test

portname = "/dev/ttyUSB0"

@testset "Examples" begin
    #@testset "hello_serialports" begin
        #include("../examples/hello_serialports.jl")  # this is broken using LibSerialPort.jl instead
    #end

    @testset "hello_libserial" begin
        include("../examples/hello_libserial.jl")
        @test true
    end

    @testset "hello_nextion" begin
        include("../examples/hello_nextion.jl")
        @test true
    end

    @testset "Execute incorrect commands" begin
        nexSerial = NexSerial(portname)
        cmd = "pageEEE 0"
        _code = send(nexSerial, cmd)
        println(_code)
        close(nexSerial)
        @test true
    end

    @testset "raw_cmd" begin
        include("../examples/raw_cmd.jl")
        @test true
    end

    @testset "page" begin
        include("../examples/page.jl")
        @test true
    end

    @testset "text" begin
        include("../examples/text.jl")
        @test true
    end

    @testset "draw" begin
        include("../examples/draw.jl")
        @test true
    end

    @testset "scroll" begin
        include("../examples/scroll.jl")
        @test true
    end

    @testset "number" begin
        include("../examples/number.jl")
        @test true
    end

    @testset "pbar" begin
        include("../examples/pbat.jl")
        @test true
    end

end