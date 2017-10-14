#include "drivers/screen.h"

void main() 
{
	clear_screen();
	kprint_at('X', 1, 6);

	while(1);
}
