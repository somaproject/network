frame: frame.o crcmodel.o
	g++ frame.o crcmodel.o -o frame
frame.o: frame.cc
	g++ -g -c frame.cc 
crcmodel.o: crcmodel.c crcmodel.h
	gcc  -c crcmodel.c
