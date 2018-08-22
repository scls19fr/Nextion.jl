"""
An unofficial [Julia](https://julialang.org/) library to communicate
with [Itead Nextion display](https://nextion.itead.cc/).

The Nextion.jl package is licensed under the MIT "Expat" License:

Copyright (c) 2018: [Sébastien Celles](https://github.com/scls19fr/).

```
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

Source: [https://github.com/scls19fr/Nextion.jl](https://github.com/scls19fr/Nextion.jl)

Contributors: [https://github.com/scls19fr/Nextion.jl/graphs/contributors](https://github.com/scls19fr/Nextion.jl/graphs/contributors)

Reference documents for implementation:
- [https://nextion.itead.cc/resources/documents/instruction-set/](https://nextion.itead.cc/resources/documents/instruction-set/)
- [https://www.itead.cc/wiki/Nextion_Instruction_Set](https://www.itead.cc/wiki/Nextion_Instruction_Set)
"""
module Nextion
    import Base: show, read, write, close, reset,
                    setproperty!, getproperty
    import Sockets: send

    # hardware
    export NexSerial
    #export PageID, ComponentID, Name
    export init
    #  Base: close, reset
    export send  # to avoid WARNING: Base.send is deprecated

    export Name, PageID, ComponentID

    # drawing
    export Draw

    # contants
    export Return
    export Alignment, Background,
        Colour, Scroll, Baudrate, GPIO

    # resources
    export Font, Picture

    # controls
    export NexText
    export NexPage, isshown
    #  Base: show
    export NexNumber
    export NexScrollText
    export NexProgressBar
    export NexQRcode
    export NexPicture
    export NexGauge
    export NexButton
    export NexDualStateButton
    export NexCheckbox
    export NexRadio
    export NexCrop
    export NexHotspot
    export NexSlider
    export NexWaveform

    # invisibles
    export NexVariable
    export NexTimer
    export NexUpload

    # enhanced
    export NexRTC
    export NexEEPROM
    export NexGPIO

    # package code goes here
    include("constants.jl")
    include("resources.jl")
    include("hardware.jl")

    include("Draw/Draw.jl")

    include("object.jl")
    include("interfaces/interfaces.jl")

    include("controls/text.jl")
    include("controls/page.jl")
    include("controls/scrolltext.jl")
    include("controls/number.jl")
    include("controls/progressbar.jl")
    include("controls/qrcode.jl")
    include("controls/picture.jl")

    include("controls/gauge.jl")

    include("enhanced/gpio.jl")

#=
    include("controls/slider.jl")
    include("controls/button.jl")
    include("controls/checkbox.jl")
    include("controls/radio.jl")
    include("controls/waveform.jl")
    include("controls/dualstatebutton.jl")
    include("controls/crop.jl")
    include("controls/hotspot.jl")

    include("invisibles/variable.jl")
    include("invisibles/timer.jl")
    include("invisibles/upload.jl")

    include("enhanced/rtc.jl")
    include("enhanced/eeprom.jl")
=#
end # module
