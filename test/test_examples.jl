#=
This examples can only be run
when a Nextion display is connected
to USB TTL converter

Correct test.tft file should be previously
send to display using uSD card
=#

using Nextion
using Test

#portname = "/dev/ttyUSB0"

@testset "Examples" begin
    #include("../examples/hello_serialports.jl")  # this is broken using LibSerialPort.jl instead
    include("../examples/hello_libserial.jl")
    include("../examples/hello_nextion.jl")
    include("../examples/raw_cmd_valid.jl")
    include("../examples/raw_cmd_valid.jl")
    include("../examples/page.jl")
    include("../examples/text.jl")
    include("../examples/draw.jl")
    include("../examples/scroll.jl")
    include("../examples/number.jl")
    include("../examples/pbar.jl")
    include("../examples/picture.jl")
    include("../examples/gauge.jl")
    include("../examples/slider.jl")
#    include("../examples/waveform.jl")
    #waveform(10)  # to avoid looping infinitely
    include("../examples/checkbox.jl")
    include("../examples/radio.jl")
    #include("../examples/button.jl")  # to avoid looping infinitely
end
