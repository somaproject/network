#include <iostream>
#include <string>
#include <vector>
#include <stdlib.h>
#include <fcntl.h>
#include <fstream>
#include <stdio.h>

extern "C" {
#include "crcmodel.h"
}


/*
this code generates a frame
in the format that testbench wants to read in 
takes in data from stdin 
 
frame length sourcemac destinationmac options filename; 
source and destination are both expressed as ff:00:bb:aa:33:22
length is an integer, and is the size of the data bytes!!
-crcerr : frame will have a crcerr
-nosfs  : don't have a start frame sequence
-preamblelen val : have a preamble of length val. By default, val = 6
-phyerr loc : number of bytes into the frame to have a phy error, default is 
              0 (i.e. no error)
 
output frame looks like:
frame totallen crcerr nosfserr pramblelen phyerrloc data 

such as 
frame 1000 0 0 6 0 0A 0B 0C 0D 0E 0F


 let's do this like bhuddists
*/
using namespace std; 

int main (int argc, char **argv) {
  
  int len = 0; 
  bool crcerr = false;
  bool nosfs = false;
  int preamblelen = 7;
  int phyerr = 0; 

  string source_mac, dest_mac;
  
  
  if (argc < 4) {
    cout << "not enough input arguments";
    exit(1); 
  }

  dest_mac = argv[2];
  source_mac = argv[3];
  len = atoi(argv[1]); 

  for(int i = 4; i < argc; i++) {
    
    string option = argv[i];
    
    if (option == "-crcerr") {
      crcerr = true;
    }
    
    if (option == "-phyerr") {
      phyerr = atoi(argv[i+1]);
      i++;
    }
    
    if (option == "-nosfs") {
      nosfs = true; 
    }
    
    if (option == "-preamblelen") {
      preamblelen = atoi(argv[i+1]); 
      i++;
    }
  }

 
  string filename = argv[argc-1]; 




  
  char * data;
  int crcable_len = len + 6 + 6; 
  data = new char[crcable_len + 4];
 
  ifstream file (filename.c_str(), ios::in|ios::binary);
  
  file.read((data + 12), len);
  file.close(); 


  
  // put in mac addressess
  for(int i = 0; i < 6; i++) {
    string byte;
    
    byte = dest_mac.substr(i*3, 2);
    data[i] = (char)strtoul(byte.c_str(), 0,  16);

    byte = source_mac.substr(i*3, 2);
    data[i+6] = (char)strtoul(byte.c_str(), 0,  16);
    
  }


  // here's the CRC code
  cm_t cmt;
  p_cm_t p_cm = &cmt; 
  unsigned int crc; 

  p_cm->cm_width = 32;
  p_cm->cm_poly = 0x04C11DB7;
  p_cm->cm_init = 0xFFFFFFFF;
  p_cm->cm_refin = TRUE;
  p_cm->cm_refot = TRUE;
  p_cm->cm_xorot = 0xFFFFFFFF;
  cm_ini(p_cm);

  for(int i =0; i < crcable_len; i++) {
    cm_nxt(p_cm, data[i]);
  }
  
  crc = cm_crc(p_cm);  
  data[crcable_len ] = (char) ((crc >> 24) & 0xFF);
  data[crcable_len + 1] = (char) ((crc >> 16) & 0xFF);
  data[crcable_len + 2] = (char) ((crc >> 8) & 0xFF);
  data[crcable_len + 3] = (char) ((crc) & 0xFF);
  
  cout << "crc is " << hex <<crc << endl;
  // dump data out :+



  // now, the output!
  // output frame looks like:
  // frame totallen crcerr nosfserr pramblelen phyerrloc data 

  // such as 
  // frame 1000 0 0 6 0 0A 0B 0C 0D 0E 0F

  int totallen = len + preamblelen +6 +6 + 4;
  if (!nosfs) {
    totallen++;
  }
  
  cout << "frame " << totallen;

  if (crcerr) {
    cout << " 1";
  } else {
    cout << " 0";
  }

  if (nosfs) {
    cout << " 1";
  } else {
    cout << " 0";
  }

  cout << ' ' << preamblelen;
  cout << ' ' << phyerr ;

  for(int i = 0; i < preamblelen; i++) {
    cout << " 55";
  }
  if(!nosfs)
    cout << " D5";
  cout << ' ';
  
  for(int i = 0; i < crcable_len + 4; i++) {
    printf("%2.2X ", (unsigned char)data[i]); 
    // yea, it's printf -- you make cout work!
  }//
  
  cout << endl; 
  
}





 
   
