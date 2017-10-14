#include "drivers/screen.h"

void main() 
{
	int position;
	position = 0x0;

	port_byte_out(0x3d4, 14);
	position |= port_byte_in(0x3d5) << 8;

	int test = 3;

    /*port_byte_out(0x3d4, 15);
    position += port_byte_in(0x3d5);*/
}
