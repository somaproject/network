#!/usr/bin/perl -w


# simple bunch of code to iterate through a set of PAR reports and write a
# text-file summarizing the results for each possible constraint

#this makes lots of assumptions about file format -- make sure the results make sense

# output file is :
# cost const1 value1 const2 value2
# were const1 is the constraint and value1 is the measured value


foreach (@ARGV) {
    open PARREPORT, $_ or die "Cannot open $_ for read : $!";
    while(<PARREPORT>) {
	
	if(/table entry \(-t\)\: (\d+)/) {
	    print "$1 ";
	}
	
	if(/(ts|TS)_\w+ = .+ \| (\d+\.\d+)ns.+\| (\d+\.\d+)/) {
	    print "$2 $3 ";
	}
    }
    print "\n"; 


}
