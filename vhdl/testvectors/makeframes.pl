#!/usr/bin/perl -w

# just a stupid program to make a bunch of frames for the system. 

my $packetnum = $ARGV[0]; 
my $min_pktlen = 16; 
my $max_pktlen = 100; 



for ($x=0; $x <= $packetnum-1; $x++) {
    srand;
    my $pktlen =  int(rand($max_pktlen - $min_pktlen)+$min_pktlen);
    print $pktlen; 
    for($i=0; $i < $pktlen; $i++) {
	if(($i % 16 )== 0) {
	    print "\n";
	}
	$randnum = sprintf("%2.2x", int(rand(256))); 
	print "$randnum ";
    }
    print "\n";
    
}

