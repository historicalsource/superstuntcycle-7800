;@A D	 *4>HR\+p
; Z-1________ -0

	.subttl  "SSCEQU.S:  7800 Equates from Atari"
; Z-1________ -0

; ZERO PAGE REGISTERS

TIA:	ds.B 1  ;$0  BASE ADDRESS FOR TIA CHIP (all write-only)

PTCTRL:	ds.B 7  ;$1-$7.  INPUT PORT CONTROL ("VBLANK" IN TIA )
;
;   LEFT AND RIGHT FIRE BUTTONS CAN BE READ FROM THE FOLLOWING 4 LOCATIONS:
;
;			   THESE ARE ALSO USED FOR PADDLE INPUT
INPT0:	ds.B 1  ;$8	;PLAYER 0, RIGHT FIRE BUTTON (D7 = 1 WHEN PUSHED)
INPT1:	ds.B 1  ;$9	;PLAYER 0, LEFT FIRE BUTTON  (D7 = 1 WHEN PUSHED)
INPT2:	ds.B 1  ;$A	;PLAYER 1, RIGHT FIRE BUTTON (D7 = 1 WHEN PUSHED)
INPT3:	ds.B 1  ;$B	;PLAYER 1, LEFT FIRE BUTTON  (D7 = 1 WHEN PUSHED)
;
;   LEFT OR RIGHT FIRE BUTTONS READ FROM THESE LOCATIONS:
;
INPT4:	ds.B 1  ;$C	;PLAYER 0 FIRE BUTTON INPUT (D7 = 0 WHEN PUSHED)
INPT5:	ds.B 1  ;$D	;PLAYER 1 FIRE BUTTON INPUT (D7 = 0 WHEN PUSHED)

; Z-1________ -0

		ds.B 7		;undefined
; $15 - $1A  (wo)
AUDC0:	ds.B 1  ;$15	;AUDIO CONTROL CHANNEL 0
AUDC1:	ds.B 1  ;$16	;AUDIO CONTROL CHANNEL 1
AUDF0:	ds.B 1  ;$17	;AUDIO FREQUENCY CHANNEL 0
AUDF1:	ds.B 1  ;$18	;AUDIO FREQUENCY CHANNEL 1
AUDV0:	ds.B 1  ;$19	;AUDIO VOLUME CHANNEL 0
AUDV1:	ds.B 1  ;$1A	;AUDIO VOLUME CHANNEL 1
	     ds.B 5
; Z-1________ -0

MARIA:	ds.B 1  ;$20     ;base address for Maria Chip.  Access by ABS,INDEX to read.
BKGRND	=  MARIA ;BACKGROUND COLOR
BACKGRND	=  MARIA ;synonym used by GCC
P0C1:	ds.B 1  ;$21	;PALETTE 0 - COLOR 1
P0C2:	ds.B 1  ;$22	;          - COLOR 2
P0C3:	ds.B 1  ;$23	;          - COLOR 3
WSYNC:	ds.B 1  ;$24   ;WAIT FOR SYNC
P1C1:	ds.B 1  ;$25	;PALETTE 1 - COLOR 1
P1C2:	ds.B 1  ;$26	;          - COLOR 2
P1C3:	ds.B 1  ;$27	;          - COLOR 3
MSTAT:	ds.B 1  ;$28   ;MARIA STATUS: 1 ds.B 1  ;  vblank
P2C1:	ds.B 1  ;$29	;PALETTE 2 - COLOR 1
P2C2:	ds.B 1  ;$2A	;          - COLOR 2
P2C3:	ds.B 1  ;$2B	;          - COLOR 3
DPH	:	ds.B 1  ;$2C   ;synonym used by GCC
DPPH    = DPH		;$2C  DISPLAY LIST LIST POINT HIGH BYTE
P3C1:	ds.B 1  ;$2D	;PALETTE 3 - COLOR 1
P3C2:	ds.B 1  ;$2E	;          - COLOR 2
P3C3:	ds.B 1  ;$2F	;          - COLOR 3
DPL:	ds.B 1  ;$30   ;synonym used by GCC
DPPL    = DPL		;$30  DISPLAY LIST LIST POINT LOW BYTE
P4C1:	ds.B 1  ;$31	;PALETTE 4 - COLOR 1
P4C2:	ds.B 1  ;$32	;          - COLOR 2
P4C3:	ds.B 1  ;$33	;          - COLOR 3
CHBASE:	ds.B 1  ;$34   ;CHARACTER BASE ADDRESS
P5C1:	ds.B 1  ;$35	;PALETTE 5 - COLOR 1
P5C2:	ds.B 1  ;$36	;          - COLOR 2
P5C3:	ds.B 1  ;$37	;          - COLOR 3
OFFSET:	ds.B 1  ;$38   ;FOR FUTURE EXPANSION HERE - STORE ZER0 HERE
P6C1:	ds.B 1  ;$39	;PALETTE 6 - COLOR 1
P6C2:	ds.B 1  ;$3A	;          - COLOR 2
P6C3:	ds.B 1  ;$3B	;          - COLOR 3
CTRL:	ds.B 1  ;$3C   ;MARIA CONTROL REGISTER
P7C1:	ds.B 1  ;$3D	;PALETTE 7 - COLOR 1
P7C2:	ds.B 1  ;$3E	;          - COLOR 2
P7C3:	ds.B 1  ;$3F	;          - COLOR 3

FastCode:	ds.B $80  ;$40	;to $FC approx. 128 bytes

WhirliGig:	ds.B 1  ;$F0	; temporary for debugging
ThingamaJig:	ds.B 1  ;		;

saveA:	ds.B 1	; Temporary register store for use INSIDE DLIs only!
saveX:	ds.B 1	; (faster than PHA/PLA)  [SSCDLI]
saveY:	ds.B 1	;

DLICOUNT: ds.B 1   ; [SSCDLI]
;		ds.B 1		;jump absolute, used as vector 
;DLI:	ds.B 2		;default vector to DLI #0

LumenBK:  ds.B 1	; For "aerial perspective" coloration


POINT:	ds.B 2  ;$FC	;[SSCINI] FOR FILLING, CLEARING, ETC.
COUNT:	ds.B 2  ;$FE	;outside interrupts only.
SRCE:	ds.B 2  ;	 Move, source
DEST:	ds.B 2  ;  Move, destination

ShiftReg:	ds.B 4	;[SSCSUB] Random number generator
RandomNumber: 	ds.B 1	;
Feedback:	ds.B 1	;


; Z-1________ -0

;	PIA AND TIMER (6532) LOCATIONS

	.org $280

SWCHA:	ds.B 1  ;$280	;LEFT & RIGHT JOYSTICKS
;		      	;LEFT RITE
;	7654 3210	;BIT POSITION =0 IF SWITCH IS CLOSED)
;	---- ----
;	RLDU RLDU	;RIGHT/LEFT/DOWN/UP

CTLSWA:	ds.B 1  ;$281	;SWCHA DATA DIRECTION (0=INPUT)

SWCHB:	ds.B 1  ;$282	;CONSOLE SWITCHES
;
;	D7-RITE DIFFICULTY
;	D6-LEFT DIFFICULTY
;	D5/D4 NOT USED
;	D3-PAUSE
;	D2-NOT USED
;	D1-GAME SELECT
;	D0-GAME RESET

CTLSWB:	ds.B 1  	;$283	;SWCHB DATA DIRECTION (0=INPUT)

INTIM:	ds.B $10  ;$284	; to $294  INTERVAL TIMER READ
TIM1T:	ds.B 1    ;$294	;SET 1    CLK INTERVAL (838   NSEC/INTERVAL)
TIM8T:	ds.B 1    ;$295	;SET 8    CLK INTERVAL (6.7   USEC/INTERVAL)
TIM64T:	ds.B 1    ;$296	;SET 64   CLK INTERVAL (53.6  USEC/INTERVAL)
T1024T:	ds.B 1    ;$297	;SET 1024 CLK INTERVAL (858.2 USEC/INTERVAL)
;		          
; Z-1________ -0
;
RESET	=    1		;bits for consle switches
SELECT	=    2		;
PAUSE	=    8		;
; Z-1________ -0

* AVAILABLE RAM, FIRST SEGMENT OF MEMORY MINUS ZP REGS, AND CHIPS TIA & MARIA

RAM0	=   $40   ;PAGE 0
RAM0SIZE =   $BF   ;191 FREE

;RAM1	=   $140	; STACK (variable unused, but included for completeness)
;R1SIZE	=   $C0	; $140 to $1FF, $BF (191) BYTES FREE

RAM2	=   $1800	;FIRST SEGMENT OF MEMORY MINUS THE ZP,STACK, AND CHIPS
R2SIZE 	=   $840	;$1800 to $203F, $840 or 2112 bytes (counts to 0).

RAM3	=   $2100	;FIRST SEGMENT OF MEMORY MINUS THE ZP,STACK, AND CHIPS
R3SIZE 	=   $40	;$2100 to $213F, $40 or 64 bytes.
HPOS_T	=   RAM3	;[SSCZOOM]

RAM4	=   $2200	;FIRST SEGMENT OF MEMORY MINUS THE ZP,STACK, AND CHIPS
R4SIZE	=   $400	;$2200 to $27FF, $400 or 1024 bytes.

; Z-1________ -0

                                                                                                                                                                                      