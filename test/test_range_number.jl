using Nextion: RangeNumber
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
    end

end