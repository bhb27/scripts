
    ;ENABLE PORTC AND D AS OUTPUT
    LDI R16, 0XFF
    OUT DDRD,R16
    OUT DDRC,R16

    ;Function set: 2 Line, 8-bit, 5x7 dots
    LDI R16, 0X04
    OUT PORTC,R16

    LDI R16, 0X38
    OUT PORTD,R16

    LDI R16, 0X00
    OUT PORTC,R16

    ;Display on, Cursor blinking command
    LDI R16, 0X04
    OUT PORTC,R16

    LDI R16, 0X0F
    OUT PORTD,R16

    LDI R16, 0X00
    OUT PORTC,R16

    ;Clear LCD
    LDI R16, 0X04
    OUT PORTC,R16

    LDI R16, 0X01
    OUT PORTD,R16

    LDI R16, 0X00
    OUT PORTC,R16

    ;Entry mode, auto increment with no shift
    LDI R16, 0X04
    OUT PORTC,R16

    LDI R16, 0X06
    OUT PORTD,R16

    LDI R16, 0X00
    OUT PORTC,R16

    ;R18 CHECK IF LINE IS FULL
    LDI R18, 0X00
    ;R16 PORTC VALUE FIRST NONE EMPTY VALUE 21
    LDI R16, 0X21

START:
    CPI R16,0X80
    BREQ SET_NEXT_VALUE;IF R16 == 0X80 JUMP TO SET_NEXT_VALUE, 0X80 IS A BLANK LCD CHARACTER

    ;ENABLE AND RS ON
    LDI R17, 0X05
    OUT PORTC,R17

    ;SET CARACTER
    OUT PORTD,R16

    ;ENABLE DOWN RS ON, LOAD VALUE
    LDI R17, 0X01
    OUT PORTC,R17

    CPI R16,0XFF
    BREQ STOP;IF R16 == 0XFF JUMP TO STOP, LAST AVAILABLE CHARACTER HAS BE SET
    INC R16
    INC R18

    CPI R18,0X10
    BRNE START;IF R18 != 0X10 JUMP TO START, ELSE SKIP LINE

    ;Sets DDRAM address so that the cursor is positioned at the head of the second line.
    LDI R17, 0X04
    OUT PORTC,R17

    LDI R17, 0XC0
    OUT PORTD,R17

    LDI R17, 0X00
    OUT PORTC,R17

    LDI R18, 0X00; RESET R18
START2:
    CPI R16,0X80
    BREQ SET_NEXT_VALUE2;IF R16 == 0X80 JUMP TO SET_NEXT_VALUE, 0X80 IS A BLANK LCD CHARACTER

    ;ENABLE AND RS ON
    LDI R17, 0X05
    OUT PORTC,R17

    ;SET CARACTER
    OUT PORTD,R16

    ;ENABLE DOWN RS ON, LOAD VALUE
    LDI R17, 0X01
    OUT PORTC,R17

    CPI R16,0XFF
    BREQ STOP;IF R16 == 0XFF JUMP TO STOP, LAST AVAILABLE CHARACTER HAS BE SET
    INC R16
    INC R18

    CPI R18,0X10
    BRNE START2;IF R18 != 0X10 JUMP TO START2, ELSE SKIP LINE

    ;Sets DDRAM address so that the cursor is positioned at the head of the FIRST line.
    LDI R17, 0X04
    OUT PORTC,R17

    LDI R17, 0X02
    OUT PORTD,R17

    LDI R17, 0X00
    OUT PORTC,R17

    LDI R18, 0X00; RESET R18

    RJMP START; BACK TO TOP

SET_NEXT_VALUE:
    LDI R16, 0XA1;NEXT "NOT BLANK" CHARACTER
    RJMP START

SET_NEXT_VALUE2:
    LDI R16, 0XA1
    RJMP START2

STOP:; SET LAST TWO CHARACTER OF THE LINE TO BLANK AND LOOP FOREVER
    LDI R17, 0X05
    OUT PORTC,R17

    LDI R16, 0X00
    OUT PORTD,R16

    LDI R17, 0X01
    OUT PORTC,R17

    LDI R17, 0X05
    OUT PORTC,R17

    LDI R17, 0X01
    OUT PORTC,R17

LOOP:
    RJMP LOOP
