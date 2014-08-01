#Total number of points
nPoints = 50000000 

#MapReduce algorithm
@time cPoints = @parallel (+) for _ = 1:nPoints
	x,y = rand(2)
	if (x^2 + y^2) <= 1
		1
	else
		0
	end
end

#Printing approximation and error
nPi = 4 * (cPoints/nPoints)
err = abs(nPi - pi)
println("Pi approximated: $nPi")
println("Error          : $err")
