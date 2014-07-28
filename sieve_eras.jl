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

#Create the Task object
sieve = Task(() -> sieve_E(20000000))

primesum = 0

# Iterate over values
@time for p in sieve
		primesum += p
	  end


println("Sum = ", primesum)
