using Nextion
using Test


@testset "Hardware" begin
    @testset "Return" begin
        @testset "Return Codes" begin
            @test Integer(Return.Code.CMD_FINISHED) == 0x01
            
            #_code = Return.code(0x01)
            #@test _code == Return.Code.CMD_FINISHED
            #@test string(_code) == "CMD_FINISHED"
            @test_broken "ToDo Should be fixed!" == 2
        end
        @testset "Return Modes" begin
            @test Integer(Return.Mode.NO_RETURN) == 0x00
        end
    end

    @testset "Alignement" begin
        @test Integer(Alignment.Vertical.CENTRE) == 1
        @test Integer(Alignment.Horizontal.CENTRE) == 1
    end

    @testset "Background" begin
        @test Integer(Background.SOLIDCOLOUR) == 1
    end

    @testset "Colour" begin
        @test Integer(Colour.WHITE) == Int32(65535)
    end

    @testset "Scroll" begin
        @testset "Scroll Direction" begin
            @test Integer(Scroll.Direction.LEFT) == 1
        end
    end

    @testset "GPIO" begin
        @testset "GPIO Modes" begin
            @test Integer(GPIO.Mode.PULL_UP_INPUT_MODE) == 0
        end
    end
end