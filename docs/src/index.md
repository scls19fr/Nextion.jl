# Nextion.jl Overview

```@docs
Nextion
```

## Install

Run Julia REPL and type:

```julia
julia> using Pkg
```

Nextion.jl have [LibSerialPort.jl](https://github.com/andrewadare/LibSerialPort.jl) as dependency. 
But this package is not in the Julia package registry.

So you will have to first install it "manually" using:

```julia
julia> Pkg.clone("https://github.com/andrewadare/LibSerialPort.jl")
```

You can then, install Nextion.jl (which is also not a registered package) using:

```julia
julia> Pkg.clone("https://github.com/scls19fr/Nextion.jl")
```

## Usage

[See examples](https://github.com/scls19fr/Nextion.jl/tree/master/examples)