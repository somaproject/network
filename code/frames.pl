#!/usr/bin/perl -w

# just a hacked script to make lots of frames! wheee!

for($i = 0; $i <10; $i++) {
    $len = int(rand(1000))+100; 
    system("./frame $len FF:FF:FF:FF:FF:FF C0:FF:EE:00:11:22 /dev/urandom");  
}
