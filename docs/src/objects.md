# Nextion objects

```@docs
Nextion.AbstractNexObject
```

## Interfaces
Theses objects can have the following interfaces:

| interface          | property    | type     | description
| ------------------ | ----------- | -------- | -----------
| `IViewable`        | `visible`   | Boolean  | Can be shown or hidden
| `IBooleanValued`   | `value`     | Boolean  | Can get/set a Boolean 
| `IStringValued`    | `value`     | String   | Can get/set a String
| `INumericalValued` | `value`     | Number   | Can get/set a numerical value
| `IFontStyleable`   | `font`      | Font     | Can get/set a font (using font_id)
| `IColourable`      | `backcolor` | Color?   | Can get/set backcolor
|                    | `forecolor` | ...      | Can get/set forecolor
| `IPicturable`      | `picture`   | Picture  | Can get/set a picture (using pic_id)
| `ITouchable`       | ...         | ...      | Can be touched


## Description
Here is a list of objects and their description:

- User Interface (UI) controls (ie objects that can be shown on a page)

| object               | description
| -------------------- | -----------
| `NexButton`          |
| `NexCheckbox`        |
| `NexCrop`            |
| `NexDualStateButton` |
| `NexGauge`           |
| `NexHotspot`         |
| `NexNumber`          |
| `NexPage`            |
| `NexPicture`         |
| `NexProgressBar`     |
| `NexQRcode`          |
| `NexRadio`           |
| `NexScrollText`      |
| `NexSlider`          |
| `NexText`            |
| `NexWaveform`        |


- Invisibles controls

| object        | description
| ------------- | -----------
| `NexTimer`    |
| `NexUpload`   |
| `NexVariable` |

- for enhanced model only:

| object        | description
| ------------- | -----------
| `NexGPIO`     |
| `NexRTC`      |
| `NexEEPROM`   |


## Implementation status

- User Interface (UI) controls

| object               | `IViewable` | `IBooleanValued` | `IStringValued` | `INumericalValued` |
| :---                 |    :---:    |       :---:      |      :---:      |       :---:        |
| `NexButton`          |      ✓      |                  |        ✓        |
| `NexCheckbox`        |      ✓      |         ✓        |                 |
| `NexCrop`            |      ?      |                  |                 |
| `NexDualStateButton` |      ✓      |         ✓        |                 |
| `NexGauge`           |      ✓      |                  |                 |         ✓
| `NexHotspot`         |      ?      |                  |                 |
| `NexNumber`          |      ✓      |                  |                 |         ✓
| `NexPage`            |             |                  |                 |
| `NexPicture`         |      ✓      |                  |                 |
| `NexProgressBar`     |      ✓      |                  |                 |         ✓
| `NexQRcode`          |      ✓      |                  |                 |
| `NexRadio`           |      ✓      |         ✓        |                 |
| `NexScrollText`      |      ✓      |                  |        ✓        |
| `NexSlider`          |      ✓      |                  |                 |         ✓
| `NexText`            |      ✓      |                  |        ✓        |
| `NexWaveform`        |      ✓      |                  |                 |


| object               | `IFontStyleable` | `IColourable` | `IPicturable` | `ITouchable` |
| :---                 |       :---:      |     :---:     |     :---:     |     :---:    |
| `NexButton`          |         ✓        |       ✓       |               |       ✓      |
| `NexCheckbox`        |                  |       ✓       |               |       ✓      |
| `NexCrop`            |                  |               |       ✓       |       ✓      |
| `NexDualStateButton` |                  |       ✓       |               |       ✓      |
| `NexGauge`           |                  |       ✓       |               |       ✓      |
| `NexHotspot`         |                  |               |               |       ✓      |
| `NexNumber`          |         ✓        |       ✓       |               |       ✓      |
| `NexPage`            |                  |               |               |              |
| `NexPicture`         |                  |               |       ✓       |       ✓      |
| `NexProgressBar`     |                  |       ✓       |               |       ✓      |
| `NexQRcode`          |                  |               |               |              |
| `NexRadio`           |                  |       ✓       |               |       ✓      |
| `NexScrollText`      |         ✓        |       ✓       |               |       ✓      |
| `NexSlider`          |                  |       ✓       |               |       ✓      |
| `NexText`            |         ✓        |       ✓       |               |       ✓      |
| `NexWaveform`        |                  |       ✓       |               |       ✓      |

- Invisibles controls

| object        | `IViewable` | `IBooleanValued` | `IStringValued` | `INumericalValued` |
| :---          |    :---:    |      :---:       |      :---:      |       :---:        |
| `NexTimer`    |             |                  |                 |
| `NexUpload`   |             |                  |                 |
| `NexVariable` |             |                  |                 |


| object        | `IFontStyleable` | `IColourable` | `IPicturable` | `ITouchable` |
| :---          |       :---:      |     :---:     |     :---:     |    :---:     |
| `NexTimer`    |                  |               |               |              |
| `NexUpload`   |                  |               |               |              |
| `NexVariable` |                  |               |               |              |


- for enhanced model only

| object        | `IViewable` | `IBooleanValued` | `IStringValued` | `INumericalValued` |
| :---          |    :---:    |      :---:       |      :---:      |       :---:        |
| `NexEEPROM`   |             |                  |                 |
| `NexGPIO`     |             |                  |                 |
| `NexRTC`      |             |                  |                 |

| object        | `IFontStyleable` | `IColourable` | `IPicturable` | `ITouchable` |
| :---          |       :---:      |     :---:     |     :---:     |    :---:     |
| `NexEEPROM`   |                  |               |               |              |
| `NexGPIO`     |                  |               |               |              |
| `NexRTC`      |                  |               |               |              |

To send commands or receive instructions from an object, you need to contruct
one of the previous object on Julia side by passing a `name` (`Name`), a `pid` (`PageID`) 
and a `cid` (`ComponentID`). These 3 parameters composed, with `nexSerial` a Nextion identifier
(called internally `NexID`).

```@docs
Nextion.Name
Nextion.PageID
Nextion.ComponentID
Nextion.NexID
```
