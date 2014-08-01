## parallel_mandel.jl
# Plots the mandelbrot set by using a distributed array

#Needed for plotting
import PyPlot

#Height and width points
@everywhere w = 5000
@everywhere h = 5000

#Mandelbrot function
@everywhere function mandel(z, maxIter::Int64)
	c = z # For Mandelbrot set
	# c = complex(-0.8,0.156) # For Julia set
	for n = 1:maxIter
		if abs2(z) > 4
			return n - 1
		end
		z = z*z + c
	end
	return maxIter
end

#Initialization function for distributed Array
@everywhere function initDArray(localdims)
	println("x range: ", localdims[2], ", y range: ", localdims[1])

	xrange = length(localdims[2])
	xstart = (3 * localdims[2][1]) / w  - 2
	xstop = (3 * localdims[2][end]) / w  - 2 

	yrange = length(localdims[1])
	ystart = (3 * localdims[1][1])/ h - 1.5
	ystop  = (3 * localdims[1][end]) / h - 1.5

	m = Array(Int, (yrange, xrange))

	for x = enumerate(linspace(xstart, xstop, xrange)),
	    y = enumerate(linspace(ystart, ystop, yrange))
		
		z = complex(x[2], y[2])
		m[y[1], x[1]] = mandel(z, 200)
	end
  println("Done!")
	return m
end

#Initialize the array and convert to local array, timing the operation
println("Starting initialization of DArray")
@time m = begin
		Dm = DArray(initDArray, (h,w), workers(), [1, length(workers())])
		convert(Array, Dm)
	end


#Make a pretty picture
PyPlot.imshow(m)
PyPlot.axis("off")
readline()
