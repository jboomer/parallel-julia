## signals.jl
# The obsessive compulsive way to integrate a function

# Needed for plotting
using PyPlot

function produce_wave(time, f)
	for t in time
		produce(apply(f, t)) #Produce instead of return!
	end
end

function integrate(source::Task, stepsize)
	x = 0 #Integrator state
	for u in source
		x += u * stepsize
		produce(x)
	end
end

function collect(source::Task)
	out = {}
	for u in source
		push!(out, u)
	end
	return out
end

# Setup simulation
stepsize = 0.01
time_axis = [0:stepsize: 2*pi]
wavefunc = cos

# Create task objects
source = Task(() -> produce_wave(time_axis, wavefunc))
integrator = Task(() -> integrate(source, stepsize))

# Collect results and plot them
plot(time_axis, map(wavefunc, time_axis), time_axis, collect(integrator))
legend(["input", "output"])
readline()
