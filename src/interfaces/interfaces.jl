"""
Abstract type for interfaces for Nextion objects
"""
abstract type AbstractINextion end

NexID(interface::AbstractINextion) = interface._nid


function getNexProperty(obj::AbstractINextion, property::Symbol, ::Type{Int})
    error("ToDo")
end

function getNexProperty(obj::AbstractINextion, property::Symbol, ::Type{String})
    error("ToDo")
end


include("IViewable.jl")
include("IBooleanValued.jl")
include("ICallback.jl")
include("IColourable.jl")
include("IFontStyleable.jl")
include("INumericalValued.jl")
include("IStringValued.jl")
include("ITouchable.jl")
