#!/usr/bin/perl -w
#
# This is our really ghetto assembler. It does two passes:
#    1. basic assembly. Each assembly statement is a single instruction
#       so a lot of the parsing is made easier. labels() are put into
#       a hash for the second pass. 
#    2. replace lables with actual code positions. necessary so we can
#       do forward codejumps. 

# Register definitions
%registers = ('r0', 0, 'r1', 1,'r2', 2, 'r3', 3, 
	      'r4', 4, 'r5', 5, 'r6', 6, 'r7', 7,
	      'r8', 8, 'r9', 9, 'r10', 10, 'r11', 11); 
$registers{'rzero'} = 0x20; 

# our program counter
my $pc = 0; 

#actually open the file
($filename) = @ARGV;
open SOURCE, $filename || die "Couldn't open file $filename \n";

while(<SOURCE>) {

    if(/(\w+)\W*(\w*)\W*(\w*)\W*(\w*)/i) {
	
	$iw = ""; 
	#actual decoding

	if($1 eq "add") { $iw = add($2, $3, $4) ;};    
	if($1 eq "sub") { $iw = subb($2, $3, $4) ;};    
	if($1 eq "and") { $iw = and_op($2, $3, $4) ;};    
	if($1 eq "or")  { $iw = or_op($2, $3, $4) ;};    


	if($1 eq "addc") { $iw = addc($2, $3, $4) ;};    
	if($1 eq "subc") { $iw = subc($2, $3, $4) ;};    
	if($1 eq "andc") { $iw = andc($2, $3, $4) ;};    
	if($1 eq "orc")  { $iw = orc($2, $3, $4) ;};    

	#sugar
	if($1 eq "nop") { $iw = nop();}; 
	if($1 eq "mov") { $iw = mov($2, $3); };
	if($1 eq "movc") { $iw = movc($2, $3); };


	chomp; 

	# convert to hex
	#print "$iw\n";
	my $decimal = pack('B32', $iw);


	my $iwhex =  unpack('H8', $decimal);
	print "$iwhex | $_";
	print "\n";
    }
}



sub add {
    my ( $Ra, $Rb, $Rc) = @_;
    my $iw; #create instruction word. 
    $iw .= "0000"; #opcode
    $iw .= sprintf("%.6b", $registers{$Rc});
    $iw .= sprintf("%.6b", $registers{$Rb});
    $iw .= sprintf("%.6b", $registers{$Ra});
    $iw .=  "0000000000";
    
    $pc++; 
    return $iw; 


}

sub subb { # not "sub" because that's a reserved word. 
    my ( $Ra, $Rb, $Rc) = @_;
    my $iw; #create instruction word. 
    $iw .= "0010"; #opcode
    $iw .= sprintf("%.6b", $registers{$Rc});
    $iw .= sprintf("%.6b", $registers{$Rb});
    $iw .= sprintf("%.6b", $registers{$Ra});
    $iw .=  "0000000000";
    
    $pc++; 
    return $iw; 

}

sub and_op {
    my ( $Ra, $Rb, $Rc) = @_;
    my $iw; #create instruction word. 
    $iw .= "0100"; #opcode
    $iw .= sprintf("%.6b", $registers{$Rc});
    $iw .= sprintf("%.6b", $registers{$Rb});
    $iw .= sprintf("%.6b", $registers{$Ra});
    $iw .=  "0000000000";
    
    $pc++; 
    return $iw; 

}

sub or_op {
    my ( $Ra, $Rb, $Rc) = @_;
    my $iw; #create instruction word. 
    $iw .= "0110"; #opcode
    $iw .= sprintf("%.6b", $registers{$Rc});
    $iw .= sprintf("%.6b", $registers{$Rb});
    $iw .= sprintf("%.6b", $registers{$Ra});
    $iw .=  "0000000000";
    
    $pc++; 
    return $iw; 

}

sub addc {
    my ($val, $Rb, $Rc) = @_;
    my $iw; 
    #print "val: $val  Rb: $Rb, Rc: $Rc\n";
    $val = eval($val); 
    $iw .= "0001"; #opcode
    $iw .= sprintf("%.6b", $registers{$Rc});
    $iw .= sprintf("%.6b", $registers{$Rb});
    $iw .= sprintf("%.16b", $val);

    $val <= 65535 or die ("$val is too big!");    

    $pc++; 
    return $iw;
}


sub subc {
    my ($val, $Rb, $Rc) = @_;
    my $iw; 
    $val = eval($val); 
    $iw .= "0011"; #opcode
    $iw .= sprintf("%.6b", $registers{$Rc});
    $iw .= sprintf("%.6b", $registers{$Rb});
    $iw .= sprintf("%.16b", $val);

    $val <= 65535 or die ("$val is too big!");    

    $pc++; 
    return $iw;


}

sub andc {
    my ($val, $Rb, $Rc) = @_;
    my $iw; 
    $val = eval($val); 
    $iw .= "0101"; #opcode
    $iw .= sprintf("%.6b", $registers{$Rc});
    $iw .= sprintf("%.6b", $registers{$Rb});
    $iw .= sprintf("%.16b", $val);

    $val <= 65535 or die ("$val is too big!");    

    $pc++; 
    return $iw;
}

sub orc {
    my ($val, $Rb, $Rc) = @_;
    my $iw; 
    $val = eval($val); 
    $iw .= "0111"; #opcode
    $iw .= sprintf("%.6b", $registers{$Rc});
    $iw .= sprintf("%.6b", $registers{$Rb});
    $iw .= sprintf("%.16b", $val);

    $val <= 65535 or die ("$val is too big!");    

    $pc++; 
    return $iw;
}




sub mov {
    # syntactic sugar
    my ( $Ra, $Rb) = @_;
    add($registers{$Rb}, $registers{'rzero'}, $registers{$Ra});
}

sub nop {
    #syntactic sugar;
    add('r0', 'r0', 'rzero');
}
sub movc {
    #syntactic sugar
    my  ($val, $Rc) = @_;
    addc($val, 'rzero', $Rc);
}




