"""
Abstract type for interfaces for Nextion objects
"""
abstract type AbstractINextion end

NexID(interface::AbstractINextion) = interface._nid

include("IViewable.jl")
include("IBooleanValued.jl")
include("INumericalValued.jl")
include("IStringValued.jl")
include("IColourable.jl")
include("IFontStyleable.jl")
include("IPicturable.jl")
# include("ICallback.jl")
include("ITouchable.jl")
include("IWidthable.jl")
include("IHeightable.jl")


function abilities(obj::AbstractNexObject)
    ab = Symbol[]
    for field in fieldnames(typeof(obj))
        if typeof(getfield(obj, field)) <: AbstractINextion
            push!(ab, field)
        end
    end
    ab
end
