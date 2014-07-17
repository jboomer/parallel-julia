## Add numbers divisible by 13 

N = nprocs();
println("Number of processes: $N");
tic();
sum = @parallel (+) for i=1:2000000000
	if i%13==0
		i
	else
		0
	end
end
toc();
println("Sum = $sum");

