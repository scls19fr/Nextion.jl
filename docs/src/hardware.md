# Hardware

## Overview

In order to communicate with a Nextion intelligent display using 
Nextion.jl Julia library, it's required to first instanciate a `NexSerial`
struct.

After instantiating it, `init` function should be run.

Low-level commands can be sent using `send` function but for most use cases it's prefered
to use a more high-level API (with struct such as `NexText`, `NexNumber`, ...)

It's preferable to always `close` serial communication with your device before quiting.

## API

### Public

```@docs
NexSerial
init
send
close(::NexSerial)
reset(::NexSerial)
```

### Private

```@docs
Nextion.write(::NexSerial, cmd::String)
Nextion._format_command
Nextion.read(::NexSerial)
Nextion.NexSerialMock
```