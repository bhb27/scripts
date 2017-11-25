    #include <p16f877a.inc>
    __config b'11110100011000'
    org 0x0000
    
    CLRF STATUS
    MOVLW b'101111';BIT 4 PORTA MUST BE REVERSED
    MOVWF PORTA

    ;BANKSEL ADCON1;ONLY NEEDE IF USING DECFSZ PORTA,1 IN LESS_ONE
    ;MOVLW 0x6
    ;MOVWF ADCON1

    BANKSEL TRISA
    MOVLW 0X00
    MOVWF TRISA

    BANKSEL PORTA
START
    MOVLW b'111111'

LESS_ONE
    XORLW b'010000';BIT 4 PORTA MUST BE REVERSED
    MOVWF PORTA
    XORLW b'010000'
    ADDLW -1
    GOTO LESS_ONE

    GOTO START
    end
