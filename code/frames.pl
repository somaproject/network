#!/usr/bin/perl -w
use strict; 
# just a hacked script to make lots of frames! wheee!


#for($i = 0; $i <10; $i++) {
#    $len = int(rand(1000))+100; 
#    system("./frame $len FF:FF:FF:FF:FF:FF C0:FF:EE:00:11:22 /dev/urandom");  
#}


#for testing purposes, we want to make 512 kB of frames. 

# of those, roughly the divison is: 
# 1/4 for broadcast, 1/4 for mcast, 1/4 for ucast, and 1/4 with random macs
# within each of those sets, 
#  two frames will have CRC errors
#  preambles will vary between 0 and 7 bytes
#  two frames (different from the CRCerr ones) will have no SFS
#  five frames (different from the others) will have phy errors


#  we do this by creating 256 frames of each type

# how to do this - four separate arrays? then merge?
# there is NO GOOD WAY OF DOING THIS!
# stupid perl lack of structures

my @crcerrs; 
my @sfserrs;
my @phyerrs;
my @preamblelen; 
my @macs; 
my @lengths; 


my $numframes = 256;

my $crcerr_num = 2;
my $phyerr_num = 5;
my $sfserr_num = 2; 

my @unique_rands;
for( my $i = 0; $i < $numframes; $i++) {
    $unique_rands[$i]=$i;
}

my $k = 0; 
my $i = 0; 
my @rands;
 $rands[$k++] =  splice(@unique_rands, rand @unique_rands, 1) while (@unique_rands);

for( my $i =0; $i < $numframes; $i++) {
    $crcerrs[$i] = 0;
    $sfserrs[$i] = 0;
    $phyerrs[$i] = 0;
    $macs[$i] = "FF:FF:FF:FF:FF:FF";
    $lengths[$i] = int(rand(9000))+64; 
}

for(my $i = 0; $i < $crcerr_num; $i++) {
    $crcerrs[pop(@rands)] = 1;
}

for(my $i = 0; $i < $phyerr_num; $i++) {
    my $j = pop(@rands); 
    $phyerrs[$j] = int(rand($lengths[$j]-1))+1;
}

for(my $i = 0; $i < $sfserr_num; $i++) {
    $sfserrs[pop(@rands)] = 1;
}

for(my $i = 0; $i < $length; $i++) {
    $preamblelen[$i] =  int(rand(7)); 
}




# now we actually generate the packets;
for (my $i = 0; $i < $numframes; $i++) { 
    my $execstring = "./frame $lengths[i] $dest_mac $source_mac ";
    if ($sfserrs[$i]) {

    }

}
