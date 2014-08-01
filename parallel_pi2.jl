using PyPlot

N=100000

@time begin pts = [2 * rand(2) - 1 for x=1:N]
			cond = bool(pmap(p -> p[1]^2 + p[2]^2 <= 1, pts))
			cpts = pts[cond]
			end


scatter([c[1] for c in cpts],[d[2] for d in cpts], marker= ".")
println("Pi approximated: ", 4 * length(cpts)/N)
readline()

