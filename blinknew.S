PROCESSOR 18F4550

#include <xc.inc>


CONFIG WDT=OFF; disable watchdog timer
CONFIG MCLRE = ON; MCLEAR Pin on
CONFIG DEBUG = ON; Enable Debug Mode
CONFIG LVP = OFF; Low-Voltage programming disabled (necessary for debugging)
CONFIG FOSC = INTOSCIO_EC;Internal oscillator, port function on RA6 
    
;this must be linked to the reset vector
PSECT resetVec,class=CODE,reloc=2
resetVec:
    goto start
    
    
PSECT code
start:
	clrf PORTD, a
	clrf TRISD, a
mainLoop:
	btg PORTD, 1, a ;Toggle PORT D PIN 1 (20)

	goto mainLoop
    
    END resetVec
