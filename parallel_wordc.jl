function wordcount(filename)
	file = open(filename, "r")
	lines = readlines(file)
	@time count = @parallel (+) for line in lines
		length(split(line))
	end
	return count
end

println("number of words: ", wordcount("../sherlock_holmes.txt"))
