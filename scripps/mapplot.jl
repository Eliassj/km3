using GLMakie
GLMakie.activate!()
const global resolution::Int64 = 1000

function main()
    if length(ARGS) == 0
        maxsys = 230.0
        maxdia = 230.0
    elseif length(ARGS) != 2
        error("Number of arguments must be 0 or 2 (maxsys, maxdia)")
    else
        maxsys = parse(Float64, ARGS[1])
        maxdia = parse(Float64, ARGS[2])
    end
    heat = Matrix{Float64}(undef, resolution, resolution)
    sysv = LinRange(0.0, maxsys, resolution)
    diav = LinRange(0.0, maxdia, resolution)

    for j in 1:resolution
        for i in 1:resolution
            heat[i, j] = map(sysv[i], diav[j])
        end
    end
    plotmap(heat, maxsys, maxdia)
end

function map(sys::Float64, dia::Float64)
    return dia + (sys - dia) / 3
end

function plotmap(heat::Matrix{Float64}, maxsys::Float64, maxdia::Float64)

    fig = Figure()
    ax = Axis(
        fig[1, 1],
        xticks=(collect(0.0:20:maxdia) .* (resolution / maxdia)collect(0.0:20:maxdia)),
        yticks=(collect(0.0:20:maxsys) .* (resolution / maxsys)collect(0.0:20:maxsys))
    )
    heatmap!(
        ax,
        heat
    )
    display(fig)

end
