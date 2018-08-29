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

    @testset "raw_cmd_valid" begin
        include("../examples/raw_cmd_valid.jl")
        @test true
    end

    @testset "raw_cmd_invalid" begin
        include("../examples/raw_cmd_valid.jl")
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
        include("../examples/pbar.jl")
        @test true
    end

    @testset "picture" begin
        include("../examples/picture.jl")
        @test true
    end

    @testset "gauge" begin
        include("../examples/gauge.jl")
        @test true
    end

    @testset "slider" begin
        include("../examples/slider.jl")
        @test true
    end

    #@testset "waveform" begin
    #    include("../examples/waveform.jl")
        #waveform(10)  # to avoid looping infinitely
    #    @test true
    #end

    @testset "checkbox" begin
        include("../examples/checkbox.jl")
        @test true
    end

    @testset "radio" begin
        include("../examples/radio.jl")
        @test true
    end

end