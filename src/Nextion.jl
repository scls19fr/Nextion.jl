"""
An unofficial [Julia](https://julialang.org/) library to communicate
with [Itead Nextion display](https://nextion.itead.cc/).
"""
module Nextion

    export NexSerial
    export PageID, ComponentID, Name
    export init, send
    # From Base: close
    
    export setVisible, cls
    export line, draw, pic

    export Draw
    export xstr

    export NexText, setText
    export NexPage, show, isshown

    export Return, Alignment, Background, Colour, Scroll
    export GPIO

    # From Base: close, reset

    # package code goes here
    include("NexHardware.jl")
    include("Draw/draw.jl")

    include("NexObject.jl")

    include("NexGpio.jl")
    include("NexText.jl")
    include("NexPage.jl")

    #=
    include("NexConfig.jl")
    include("NexTouch.jl")
    include("NexButton.jl")
    include("NexCheckbox.jl")
    include("NexHotspot.jl")
    include("NexRadio.jl")
    include("NexUpload.jl")
    include("NexNumber.jl")
    include("NexScrolltext.jl")
    include("NexVariable.jl")
    include("NexCrop.jl")
    include("NexSlider.jl")
    include("NexWaveform.jl")
    include("NexDualStateButton.jl")
    include("NexGauge.jl")
    include("NexPicture.jl")
    include("NexTimer.jl")
    include("NexProgressBar.jl")

    include("NexRtc.jl")

    =#

end # module
