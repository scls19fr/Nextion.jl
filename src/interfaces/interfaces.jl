"""
Abstract type for interfaces for Nextion objects
"""
abstract type AbstractINextion end

NexID(interface::AbstractINextion) = interface._nid

include("IViewable.jl")
include("IBooleanValued.jl")
include("ICallback.jl")
include("IColourable.jl")
include("IFontStyleable.jl")
include("INumericalValued.jl")
include("IStringValued.jl")
include("ITouchable.jl")
include("IPicturable.jl")
