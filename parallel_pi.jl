nPoints = 5e7

@time cPoints = @parallel (+) for i=1:nPoints
	x,y = rand(2)
	if (x^2 + y^2) <= 1
		1
	else
		0
	end
end


nPi = 4 * (cPoints/nPoints)
err = abs(nPi - pi)

println("Pi approximated: $nPi")
println("Error          : $err")
