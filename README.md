# WaveSim.jl

`WaveSim.jl` is a package that's meant to make life easier for students of [BYU's Scientific Computing Course](https://byuhpc.github.io/sci-comp-course/). It serves to make debugging some phases of the [project](https://byuhpc.github.io/sci-comp-course/project/overview.html) easier, and is used as example and base code for others.



## Install

Open the [Julia package manager](https://docs.julialang.org/en/v1/stdlib/REPL/#Pkg-mode) and run:

```jldoctest
pkg> add https://github.com/BYUHPC/WaveSim.jl.git
```

`WaveSim.jl` can be removed with:

```jldoctest
pkg> remove WaveSim
```



## Usage Example

The `WaveSim` package can be used to interactively check your assignment output files--for example, given an input file `in.wo`, you can see if your C++ code compiled to `wavesim_serial` is correct, and figure out what's wrong if not:

```jldoctest
shell> ./wavesim_serial in.wo out.wo

julia> using WaveSim

julia> wgood = WaveOrthotope(open("in.wo"));

julia> solve!(wgood)

julia> wtest = WaveOrthotope(open("out.wo"));

julia> if !isapprox(wgood, wtest)
           println("out.wo is incorrect")
           println("Damping coefficients: $(dampingcoef(wgood)), $(dampingcoef(wtest))")
           println("Simulation times:     $(simtime(wgood)), $(simtime(wtest))")
           println("Max u difference:     $(max(abs.(wgood.u - wtest.u)))")
           println("Max v difference:     $(max(abs.(wgood.v - wtest.v)))")
       end
```
