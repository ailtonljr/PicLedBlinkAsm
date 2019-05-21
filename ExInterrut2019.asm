
#include <p18f4550.inc>

	CONFIG WDT=OFF; disable watchdog timer
	CONFIG MCLRE = ON; MCLEAR Pin on
	CONFIG DEBUG = ON; Enable Debug Mode
	CONFIG LVP = OFF; Low-Voltage programming disabled (necessary for debugging)
	CONFIG FOSC = INTOSCIO_EC;Internal oscillator, port function on RA6
	
	
; Ajustar os vetores de Reset e Interrupção
    org 0; start code at 0
    GOTO Start
    
    org 8 ;Vetor de interrupção
    GOTO TratInt




CODE
    
Start:
    ;Colocar a porta D0 e D1 como saída
    BCF TRISD, 0 ; D0 é saída
    BCF TRISD, 1 ; D1 também é saída
    
    ;Configurar a porta B (TRISB) -  Desabilitar o conversor AD 
    MOVLW 0xE ; Set RB<4:0> as
    MOVWF ADCON1 ; digital I/O pins
    ; (required if config bit
    ; PBADEN is set)
    MOVLW 0xFF ; Value used to
	; initialize data
	; direction
    MOVWF TRISB ; Coloquei toda a porta B como entrada
    
    ;Configurar o controlador de interrupção
    ;INTCON<4>(INT0IE) = 1
    BSF INTCON, 4
    ;INTCON<6>(PEIE) = 1
    BSF INTCON, 6
    ;INTCON<7> (GIE) =  1
    BSF INTCON, 7
  

MainLoop:
   
    BTG PORTD, 0 ; Inverte o D0
    NOP
    NOP
    NOP
    
    GOTO MainLoop
    
    
; Rotina de tratamento de Interrupção    
TratInt:
    BTG PORTD, 1 ;Inverte a porta
    BCF INTCON, 1 ; Limpa o INT0IF (Avisa que tratou a interrupção)
    RETFIE
    
    

	END
