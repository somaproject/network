A basic ping reflector for the network interface. 
I'm putting it in this part of the repository tree as it should be easy to retarget for any FPGA you want to use, not just the protointerface one. 

We have a double-buffer approach where we read in in a frame, while checking
if it's an ICMP echo request frame targeted for our particular MAC address. 

We have an address counter that writes each sequentially input word into the blockselect ram buffer. the same counter latches various register/comparison systems which generate signals to check for the validity of the packet. 


For timing purposes, the actual block ram writing inputs have an extra set of registers in front. 
INLEN resets to 0xFFFF when tcs = none 


For TX: we wait until the SWAPB state is hit, and then we clock out the bytes, but... the first 32 have a funny sequence: we reverse source and destination MAC addrs and IPs, and change the response type from echo request to echo reply

The ICMP checksum makes things slightly more complicated, unfortunately. Since we're simply swapping the IP header addresses, it's not going to change the IP header checksum. However, the ICMP checksum will change by changing the type field from 08 to 00. Thus, we must have the approrpiate word be complemented, subtract 0800, and then recomplement the result. 


