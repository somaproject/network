#!/usr/bin/perl -w

# just a stupid program to make a bunch of frames for the system. 

my $packetnum = $ARGV[0];
my $packettype = $ARGV[1];

# packet type is:
#   a   any (random mac addresses)
#   b   broadcast (dest addr FF:FF:FF:FF:FF;FF)
#   m   multicast (first word a 01)
#   u   unicast, with mac C0:FF:EE:01:02:03 
my $min_pktlen = 16; 
my $max_pktlen = 1500; 
my $MACADDR = "C0:FF:EE:01:02:03";

if ($packettype eq "b") {
    $MACADDR = "FF:FF:FF:FF:FF:FF";
} elsif ($packettype eq "m") {
    $MACADDR = "01:01:02:03:04:05";
}

for ($x=0; $x <= $packetnum-1; $x++) {
    srand;
    my $pktlen =  int(rand($max_pktlen - $min_pktlen)+$min_pktlen);
    print $pktlen; 
    for($i=0; $i < $pktlen; $i++) {

	my $randnum = int(rand(256)); 

	if($x < 6) { 
	    if($packettype eq "a") {
		$data .= sprintf("%c", $randnum); 
	    } else {
		$data .= hex(substring($MACADDR, $x*3, 2)); 
	    }
	} else {
	    $data .= $randnnum; 
	}
    }

    # now $data contrains the byte string n packets long
    
    # calculate the CRC
    # add it to the data
    $data .= "0000"; 
    $pktlen += 4; 


    # now we add an fcs, perhaps
    if($fcs_errors) {
	$fcs = int(rand(10)); 
	if ($fcs > 1) {
	    
	}

    print "FRAME $pktlen \n";
    $randnum .= sprintf("%2.2x", int(rand(256))); 	
    $pktlen +=4; 
    
}
