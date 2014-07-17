#Needed for plotting
using PyPlot

#Mandelbrot function
@everywhere include("mandel.jl")

#Height and width points
@everywhere w = 5000
@everywhere h = 5000

#Initialization function for distributed Array
@everywhere function initDArray(localdims)
	println("x range: ", localdims[2], ", y range: ", localdims[1])

	xrange = size(localdims[2],1)
	xstart = (localdims[2][1] - w/2) / (w/3)
	xstop  = (localdims[2][end] - w/2) / (w/3)

	ystart = (localdims[1][1] - h/2) / (h/3)
	ystop  = (localdims[1][end] - h/2) / (h/3)
	yrange = size(localdims[1],1)

	m = Array(Int, (yrange, xrange))

	for x = enumerate(linspace(xstart, xstop, xrange)),
	    y = enumerate(linspace(ystart, ystop, yrange))
		
		z = complex(x[2], y[2])
		m[y[1], x[1]] = mandel(z, 200)
	end
	return m
end

#Initialize the array and convert to local array
tic()
	#Split on rows, default is columns 
Dm = DArray(initDArray, (h,w), workers(), [size(workers(),1), 1])
m = convert(Array, Dm)
toc()

#Make a pretty picture
imshow(m)
axis("off")
readline()
