#!/usr/bin/perl -w
#
# This is our really ghetto assembler. It does two passes:
#    1. basic assembly. Each assembly statement is a single instruction
#       so a lot of the parsing is made easier. labels() are put into
#       a hash for the second pass. 
#    2. replace lables with actual code positions. necessary so we can
#       do forward codejumps. 

# Register definitions
%registers = ('r0', 0x0, 'r1', 0x1,'r2', 0x2); 
$registers{'rzero'} = 0x20; 

# our program counter
my $pc = 0; 

#actually open the file
($filename) = @ARGV;
print "Opening source from $filename...\n"; 
open SOURCE, $filename || die "Couldn't open file $filename \n";

print "|       |       |       |       |\n";
while(<SOURCE>) {
    print eval($_) ;
    print "\n";
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
sub addc {
    my ($val, $Rb, $Rc) = @_;
    my $iw; 
    $iw .= "0001"; #opcode
    $iw .= sprintf("%.6b", $registers{$Rc});
    $iw .= sprintf("%.6b", $registers{$Rb});
    $iw .= sprintf("%.16b", $val);

    $val <= 65535 or die ("$val is too big!");    

    $pc++; 
    return $iw;


}


sub mov {
    # syntactic sugar
    my ( $Rb, $Ra) = @_;
    add($registers{$Rb}, $registers{'rzero'}, $registers{$Ra});
}

sub nop {
    #syntactic sugar;
    add('r0', 'r0', 'rzero');
}
sub movc {
    #syntactic sugar
    my ($Rc, $val) = @_;
    addc($Rc, 'rzero', $val);
}




