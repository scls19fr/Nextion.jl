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

    export NexScrollText
    export setAlignment

    # From Base: close, reset

    # package code goes here
    include("hardware.jl")

    include("Draw/Draw.jl")

    include("object.jl")
    include("interfaces/interfaces.jl")

    include("gpio.jl")
    include("text.jl")
    include("page.jl")
    include("scrolltext.jl")

    #=
    include("config.jl")
    include("touch.jl")
    include("button.jl")
    include("checkbox.jl")
    include("hotspot.jl")
    include("radio.jl")
    include("upload.jl")
    include("number.jl")
    include("variable.jl")
    include("crop.jl")
    include("slider.jl")
    include("waveform.jl")
    include("dualstatebutton.jl")
    include("gauge.jl")
    include("picture.jl")
    include("timer.jl")
    include("progressbar.jl")

    include("rtc.jl")
    include("eeprom.jl")  # Flash?

    =#

end # module
