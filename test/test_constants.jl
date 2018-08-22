using Nextion
using Test


@testset "Constants" begin
    @testset "Return" begin
        @testset "Return Codes" begin
            @test Integer(Return.Code.CMD_FINISHED) == 0x01
            
            _code = Return.code(0x01)
            @test _code == Return.Code.CMD_FINISHED
            @test string(_code) == "CMD_FINISHED"
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
            @test Integer(Scroll.Direction.LEFT_TO_RIGHT) == 0
        end
    end

    @testset "Baudrate" begin
        @test Baudrate.at(9600) == 9600
        @test Baudrate.id(2400) == 1  # is it necessary? ToDo
        @test_throws ErrorException Baudrate.at(9650) == 9600
    end

    @testset "GPIO" begin
        @testset "GPIO Modes" begin
            @test Integer(GPIO.Mode.PULL_UP_INPUT_MODE) == 0
        end
    end
end