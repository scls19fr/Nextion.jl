# Nextion.jl Overview

```@docs
Nextion
```

## Install

```julia
Pkg.clone("https://github.com/scls19fr/Nextion.jl")
```

## Usage

[See examples](https://github.com/scls19fr/Nextion.jl/tree/master/examples)

## API

### Public

```@docs
NexSerial
init
send
close(nexSerial::NexSerial)
reset(nexSerial::NexSerial)
```

### Private

```@docs
Nextion.write(nexSerial::NexSerial, cmd::String)
Nextion._write_end_of_command
Nextion.read(nexSerial::NexSerial)
```
