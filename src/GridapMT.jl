module GridapMT

using Gridap
import Gridap: solve

using GridapGmsh
import GridapGmsh: gmsh

using Gridap.Fields
using Gridap.Geometry
using Gridap.CellData
using Gridap.Visualization
using Gridap.FESpaces

using JLD2

abstract type ForwardProblem end

mutable struct MT <: ForwardProblem
    model::UnstructuredDiscreteModel
    freqs::Vector{Float64}
    obs::Vector{Float64}
    σ₀::Float64
end

mutable struct FEProblem
    order::Int
    Vₑ
    Vₕ
    V₀
    Ω
    dΩ
    σ::FEFunction
    ρ::FEFunction
end

include("dirichletBC.jl")
include("gmsh.jl")
include("rhoa.jl")
include("utils.jl")
include("fem.jl")
include("solve.jl")
include("grid.jl")

export loadModel, PrismGenerator
export dirichlet_hom_E, dirichlet_hom_H
export FE_setup
export createTensorGrid, createGrid, interpolate_grid_to_fe_space
export get_rhoa_phase
export solve_eh, solve_e, solve_h


end # module GridapMT
