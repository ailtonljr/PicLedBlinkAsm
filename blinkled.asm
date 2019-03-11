;    Tutorial2.asm - LED Blink
;    Copyright (C) 2007 www.pic18f.com
;
;    This program is free software: you can redistribute it and/or modify
;    it under the terms of the GNU General Public License as published by
;    the Free Software Foundation, either version 3 of the License, or
;    (at your option) any later version.
;
;    This program is distributed in the hope that it will be useful,
;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;    GNU General Public License for more details.
;
;    You should have received a copy of the GNU General Public License
;    along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#include <p18f4550.inc>
	
	CONFIG WDT=OFF; disable watchdog timer
	CONFIG MCLRE = ON; MCLEAR Pin on
	CONFIG DEBUG = ON; Enable Debug Mode
	CONFIG LVP = OFF; Low-Voltage programming disabled (necessary for debugging)
	CONFIG FOSC = INTOSCIO_EC;Internal oscillator, port function on RA6 
	
	org 0; start code at 0

UDATA
	
Delay1 res 1;reserve 1 byte for the variable Delay1
Delay2 res 1;reserve 1 byte for the variable Delay2

CODE
 
Start:
	CLRF PORTD
	CLRF TRISD
	
	CLRF Delay1
	CLRF Delay2
MainLoop:
	BTG PORTD,RD1 ;Toggle PORT D PIN 1 (20)

Delay:
	DECFSZ    Delay1,1 ;Decrement Delay1 by 1, skip next instruction if Delay1 is 0 
	GOTO Delay
	DECFSZ	  Delay2,1
	GOTO Delay

	GOTO MainLoop
	
	end
