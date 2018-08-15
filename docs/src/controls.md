# UI controls

## Page

### Overview

A `NexPage` is the main element of a Nextion UI. It's where controls are put on.

### API

#### Public

```@docs
NexPage
Base.show(page::NexPage)
isshown(page::NexPage)
```

## Text

### Overview

A `NexText` is a Nextion UI control to display text on a page

### API

#### Public

```@docs
NexText
setText(nexText::NexText, val::String)
```
