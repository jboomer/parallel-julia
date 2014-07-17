function mandel(z, maxIter::Int64)
	c = z
	for n = 1:maxIter
		if abs(z) > 2
			return n - 1
		end
		z = z^2 + c
	end
	return maxIter
end
