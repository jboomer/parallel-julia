## cons_prod.jl
# Creates a task object that generates expressions of the form +(a,b),
# where a and b are random numbers in the range 1:10.
# The jobs are processes by the function process_jobs, that creates a number of
# consumers to evaluate the expressions asynchronously.


#Produces 10 expressions
function produce_jobs()
	for i=1:10
		a,b = rand(1:10, 2)
		produce(:($a+$b)) 
		sleep(1) # To simulate doing some other things
	end
	while true
		produce("end")
	end
end

#Creates 5 "consumers" that evaluate expressions
function process_jobs(producer)
	results = {}

	# Sync block waits for all async blocks to complete
	@sync begin
		for c=1:4
			@async begin 
				while true
					cjob = consume(producer)
					if cjob == "end"
						break
					end
					res = eval(cjob)
					println(string("Consumer ",c,": ",cjob.args[2],"+",cjob.args[3],"=",res))
					push!(results, res)
				end
			end
		end
	end
	return results
end

# Create the task object
p = Task(produce_jobs)

# Get the results
results = process_jobs(p)
println("Results: ", results)
