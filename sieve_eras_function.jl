#Load with "julia -L %"

#Produces primes up to N
function sieve_E(N)
	marked = IntSet()
	for p in [2:N]
		if in(p, marked)
			continue
		end
		for m in [p*p:p:N]
			push!(marked,m)
		end
		produce(p)
	end
end

#Create the Task object for primes up to N 
sieve = Task(() -> sieve_E(200000))

