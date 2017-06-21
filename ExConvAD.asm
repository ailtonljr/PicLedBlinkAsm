#include <p18F4550.inc>
	
	CONFIG WDT=OFF; disable watchdog timer
	CONFIG MCLRE = ON; MCLEAR Pin on
	CONFIG DEBUG = ON; Enable Debug Mode
	CONFIG LVP = OFF; Low-Voltage programming disabled (necessary for debugging)
	CONFIG FOSC = INTOSCIO_EC;Internal oscillator, port function on RA6 
	
	ORG 0; start code at 0
	GOTO START
	
	;Definir o meu vetor de interrupção
	;ORG 0x8
	;GOTO INTSR ;Rotina de tratamento da interrupção
	
	CODE ;Seu código começa depois daqui
	
	
START:
	;Colocar o ADCON1 como sendo 0x00
	MOVLW 0x00
	MOVWF ADCON1
	
	;Colocar o ADCON2 como sendo 0x80
	MOVLW 0x80
	MOVWF ADCON2
	
	;Colocar ADCON0 como sendo 0x33
	MOVLW 0x33
	MOVWF ADCON0
	
	;Esperar ficar pronto
	;Resultado em ADRESH e ADRESL
	;Pula a próxima instrução se o bit for 0 - DONE
LoopAD:
	BTFSC ADCON0, 1
	GOTO LoopAD
	
	;Aqui a conversão está pronta.
	NOP
	
	GOTO START
	
	
	

	
	END
