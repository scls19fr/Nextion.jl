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
    @testset "Execute correct commands" begin
        function _execute_command(nexSerial, cmd)
            println(cmd)
            _code = send(nexSerial, cmd)
            println(_code)
        end

        function main()
            nexSerial = NexSerial(portname)
            _execute_command(nexSerial, "page 0")
            sleep(2)
            _execute_command(nexSerial, "page 1")
            sleep(2)
            _execute_command(nexSerial, "t0.txt=\"Hello\"")
            close(nexSerial)
        end

        main()
    end

    @testset "Execute incorrect commands" begin
        nexSerial = NexSerial(portname)
        cmd = "pageEEE 0"
        _code = send(nexSerial, cmd)
        println(_code)
        close(nexSerial)
    end

    @testset "01_hello" begin
        @testset "raw_cmd" begin
            include("../examples/01_hello/raw_cmd.jl")
        end
        @testset "text" begin
            include("../examples/01_hello/text.jl")
        end

        @testset "draw" begin
            include("../examples/01_hello/draw.jl")
        end
    end

    @testset "02_page" begin
        @testset "hello_libserial" begin
            include("../examples/02_page/hello_libserial.jl")
        end

        #@testset "hello_serialports" begin
            #include("../examples/02_page/hello_serialports.jl")
        #end

        @testset "page" begin
            include("../examples/02_page/page.jl")
        end
    end
    
end