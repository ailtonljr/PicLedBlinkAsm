#include <p18F4550.inc>
	
	CONFIG WDT=OFF; disable watchdog timer
	CONFIG MCLRE = ON; MCLEAR Pin on
	CONFIG DEBUG = ON; Enable Debug Mode
	CONFIG LVP = OFF; Low-Voltage programming disabled (necessary for debugging)
	CONFIG FOSC = INTOSCIO_EC;Internal oscillator, port function on RA6 
	
	ORG 0; start code at 0
	GOTO START
	
	;Definir o meu vetor de interrupção
	ORG 0x8
	GOTO INTSR ;Rotina de tratamento da interrupção
	
	CODE ;Seu código começa depois daqui
	
	
START:
	;Configurar os pinos
	;B0 como uma entrada Digital
	MOVLW 0x0F ; Set RB<4:0> as
	MOVWF ADCON1 ; digital I/O pins
	MOVLW 0xFF
	MOVWF TRISB
	;D0 como uma saída digital
	MOVLW 0xFE
	MOVWF TRISD
	
	;INTEDG0 - 1 - Bordas de subida 
	;Registrador INTCON2 - Bit 6
	BSF INTCON2, 6
	
	;Habilitei a interrupção INT0
	;Habilitar o INT0IE - Registrador INTCON - Bit 4
	BSF INTCON, 4
	
	;Habilita a chave geral GIE
	BSF INTCON, 7
	
Loop:
	NOP ;Fazer alguma outra coisa
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	GOTO Loop
	
	
	
INTSR:
	;Ler o port D0 e inverter
	COMF PORTD, F
	;Limpar o flag da interrupção
	;INTCON,1 é o flag INT0IF
	BCF INTCON, 1
	RETFIE
	
	
	END
