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
