using Documenter
using Nextion


makedocs(
    format = :html,
    sitename = "Nextion.jl",
    pages = [
        "index.md",
        "wiring.md",
        "hardware.md",
        "constants.md",
        "draw.md",
        "objects.md",
        "controls.md",
        "invisibles.md",
    ]
)

deploydocs(
    repo = "github.com/scls19fr/Nextion.jl.git",
    julia  = "1",
    latest = "master",
    target = "build",
    deps = nothing,  # we use the `format = :html`, without `mkdocs`
    make = nothing,  # we use the `format = :html`, without `mkdocs`
)
