# UI controls

## Page

### Overview

A `NexPage` is the main element of a Nextion UI. It's where controls are put on.

### API

#### Public

```@docs
NexPage
Base.show(::NexPage)
isshown(::NexPage)
```

## Text

### Overview

A `NexText` is a Nextion UI control to display text on a page

### API

#### Public

```@docs
NexText
setproperty!(::NexText, ::Symbol, ::Font)
setproperty!(::NexText, ::Symbol, ::Bool)
setproperty!(::NexText, ::Symbol, ::String)
```

## Scrolltext
### Overview


### API

#### Public
```@docs
Scroll.Direction
```
