using Nextion: RangeNumber
#using Nextion: NoRangeNumber
using Test


@testset "RangeNumber" begin
    @testset "construct / isequal" begin
        a = RangeNumber(3, 1:7)
        @test a == 3
    end

    @testset "addition / overflow" begin
        a = RangeNumber(3, 1:7)
        @test a + a == 6 
        @test_throws ErrorException a + a + a == 9
    end

    @testset "other construct" begin
        a = RangeNumber{Int64, 1:7}(3)
        @test a == 3

        @test_throws ErrorException a = RangeNumber{Int64, 1:7}(8)
    end

    #@testset "NoRangeNumber" begin
    #    a = NoRangeNumber(3)
    #    @test a == 3
    #end

end