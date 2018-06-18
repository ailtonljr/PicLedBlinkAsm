#include <p18F4550.inc>
	
	CONFIG WDT=OFF; disable watchdog timer
	CONFIG MCLRE = ON; MCLEAR Pin on
	CONFIG DEBUG = ON; Enable Debug Mode
	CONFIG LVP = OFF; Low-Voltage programming disabled (necessary for debugging)
	CONFIG FOSC = INTOSCIO_EC;Internal oscillator, port function on RA6 
	


CODE

	org 0; start code at 0 
    GOTO Start
    
	org 8;
    GOTO TratIrq
    
    
Start: ;Código normal
    
    ;Coloca os pinos D0 e D1 como saída
    MOVLW b'11111100'
    MOVWF TRISD
    
    ;Configurar a Porta B
    MOVLW 0xE ; Set RB<4:0> as
    MOVWF ADCON1 ; digital I/O pins
    ; (required if config bit
    ; PBADEN is set)
    MOVLW 0xFF ; Value used to
	; initialize data
	; direction
    MOVWF TRISB ; Set RB<3:0> as inputs
    ; RB<5:4> as outputs
    ; RB<7:6> as inputs
    
    ;Configurar a interrupção
    ;IPEN = 0 - Reg RCON, 7 - Não tem níveis de prioridade
    BCF RCON,7
    ;Habilitar o INT0 -Registrador INTCON,4
    BSF INTCON,4
    ;Habilitar a Int. Global - INTCON, 7 = 1
    BSF INTCON,7
    
Repete: ;Fica alternando o estado de D0
    BTG PORTD, 0 ;Interte o estado da porta D0
    GOTO Repete
    
    
    
TratIrq: ;Código da rotina de tratamento de interrupção
    BTG PORTD, 1 ;Interte o estado da porta D0
    ;INT0IF e zerar
    BCF INTCON, 1
    RETFIE ;Return especefício da interrupção
    
    END
