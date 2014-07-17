for i=1:10
	#Create RemoteRef
	rr = @spawn rand(Int8) 
	
	#Print process id and output
	@printf("process: %d\toutput: %d\n", rr.where, fetch(rr))
end
