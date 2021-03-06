; @A D	 *4>HR\+p
; Z-1________ -0

	.subttl "SSIZOOM.S:  Zooming Playfield Effect"
;by James St. Louis 10/12/88

; Z-1________ -0



Zoom:		;should update math every 60th if possible. (save on pg0)

;Wind the Queue forward:	
	ldx #63
.5: jsr Random
	and
	sta HPOS_T,x
	dex
	bpl .5

;Update DLIST headers:
	putadr RAM4+3,DEST0		;in display list, object 0 HPOS/line
	putadr RAM4+7,DEST1		;in display list, object 1 HPOS/line
	putadr HPOS_T,SRCE0		;pg0 [SSCEQU] 64 computed from map
	ldy #$3F
	ldx #0
.7:  lda (SRCE0,x)		;
	 sta (DEST0,x)		;
	 clc
	 adc ScaleFactor,y	;in ROM
	 sta (DEST1,x)
	 inc SRCE0
	 bne .71
	 inc SRCE0+1
.71: clc
	 lda DEST0
	 adc #10
	 sta DEST0
	 bcc .72
	 inc DEST0+1
.72: clc
	 adc #7
	 sta DEST1
	 bcc .73
	 inc DEST1+1
.73: dey
	 bpl .7
	rts


;ZoomDLL:
;Copies DLL image from ROM to RAM at $2700 (<1pg):
	    

ZoomDLS:
;Copies ZoomHeaders to RAM4
	putadr ZH_len,COUNT		;pg0 [SSCEQU]
	putadr ZoomHeaders,SRCE		;pg0 [*]
	putadr RAM4,DEST		;pg0
	ldy #0
.0:	lda (SRCE),y
	sta (DEST),y
	inc SRCE
	bne .1
	inc SRCE+1
.1: inc DEST
	bne .2
	inc DEST+1
.2: dec COUNT
	bne .0
	dec COUNT+1
	bpl .0
	
	rts

;Generates 700 bytes of small DLS headers whose HPOS are to be modified.
;	putaddr RAM4,Zdls		;pointer to DLS entry
;	putaddr LABEL01,Zobj		;pointer to object def.
;.0:
;	ldy #0
;	lda Zobj    		
;	sta (Zdls),y		;Lo address of object def 1
;	iny
;	lda #%11000110		;palette 5, width of 6 fixed
;	sta (Zdls),y
;	iny
;	lda Zobj+1		;Hi address of object def 1
;	sta (Zdls),y			
;	 clc
;	 lda Zobj
;	 adc #16		
;	 sta Zobj
;	 bcc .1
; 	 inc Zobj+1
;.1:	iny
;	lda Zobj    		
;	sta (Zdls),y		;Lo address of object def  2
;	iny
;	lda #%11000110		;palette 5, width of 6 fixed
;	sta (Zdls),y
;	iny
;	lda Zobj+1		;Hi address of object def  2
;	sta (Zdls),y			
;	iny
;
;	lda #0		;null header
;	sta (Zdls),y
;	iny
;	sta (Zdls),y
;
;.10:   	
;
ReadQueue:
;Update course turn data into 8 current speed sectors in "fifo" manner.
; Z-1________ -0


ZoomHeaders:

	header LABEL01,1,1,70		;sc0:
	header LABEL01+7,1,6,40
		nullhdr
	header LABEL01,1,1,72		;sc1:
	header LABEL01+7,1,6,41
		nullhdr
	header LABEL01,1,1,74		;sc2:
	header LABEL01+7,1,6,42
		nullhdr
	header LABEL01,1,1,75		;sc3:
	header LABEL01+7,1,6,43
		nullhdr	
	header LABEL01+$100,1,2,76		;sc4:
	header LABEL01+7+$100,1,6,44
		nullhdr
	header LABEL01+$100,1,2,77		;sc5:
	header LABEL01+7+$100,1,6,45
		nullhdr
	header LABEL01+$100,1,2,76		;sc6:
	header LABEL01+7+$100,1,6,46
		nullhdr
	header LABEL01+$100,1,2,75		;sc7:
	header LABEL01+7+$100,1,6,47
		nullhdr
	header LABEL01+$200,1,3,74		;sc8:
	header LABEL01+7+$200,1,6,48
		nullhdr
	header LABEL01+$200,1,3,73		;sc9:
	header LABEL01+7+$200,1,6,49
		nullhdr
	header LABEL01+$200,1,3,72		;scA:
	header LABEL01+7+$200,1,6,50
		nullhdr
	header LABEL01+$200,1,3,71		;scB:
	header LABEL01+7+$200,1,6,51
		nullhdr
	header LABEL01+$300,1,4,70		;scC:
	header LABEL01+7+$300,1,6,52
		nullhdr
	header LABEL01+$300,1,4,69		;scD:
	header LABEL01+7+$300,1,6,53
		nullhdr
	header LABEL01+$300,1,4,68		;scE:
	header LABEL01+7+$300,1,6,54
		nullhdr
	header LABEL01+$300,1,4,69		;scF:
	header LABEL01+7+$300,1,6,55
		nullhdr
	header LABEL01+$400,1,4,70		;sc10
	header LABEL01+7+$400,1,6,56
		nullhdr
	header LABEL01+$400,1,4,72		;sc11
	header LABEL01+7+$400,1,6,57
		nullhdr
	header LABEL01+$400,1,4,74		;sc12
	header LABEL01+7+$400,1,6,58
		nullhdr
	header LABEL01+$400,1,4,75		;sc13:
	header LABEL01+7+$400,1,6,59
		nullhdr
	header LABEL01+$500,1,4,76		;sc14:
	header LABEL01+7+$500,1,6,60
		nullhdr
	header LABEL01+$500,1,4,77		;sc15:
	header LABEL01+7+$500,1,6,61
		nullhdr
	header LABEL01+$500,1,4,76		;sc16:
	header LABEL01+7+$500,1,6,62
		nullhdr
	header LABEL01+$500,1,4,75		;sc17:
	header LABEL01+7+$500,1,6,63
		nullhdr
	header LABEL01+$600,1,4,74		;sc18:
	header LABEL01+7+$600,1,6,64
		nullhdr
	header LABEL01+$600,1,4,73		;sc19:
	header LABEL01+7+$600,1,6,65
		nullhdr
	header LABEL01+$600,1,4,72		;sc1A:
	header LABEL01+7+$600,1,6,66
		nullhdr
	header LABEL01+$600,1,4,71		;sc1B:
	header LABEL01+7+$600,1,6,67
		nullhdr
	header LABEL01+$700,1,4,70		;sc1C:
	header LABEL01+7+$700,1,6,68
		nullhdr
	header LABEL01+$700,1,4,69		;sc1D:
	header LABEL01+7+$700,1,6,69
		nullhdr
	header LABEL01+$700,1,4,68		;sc1E:
	header LABEL01+7+$700,1,6,70
		nullhdr
	header LABEL01+$700,1,4,66		;sc1F:
	header LABEL01+7+$700,1,6,71
		nullhdr
	header LABEL01+$800,1,4,70		;sc20:
	header LABEL01+7+$800,1,6,72
		nullhdr
	header LABEL01+$800,1,4,72		;sc21:
	header LABEL01+7+$800,1,6,73
		nullhdr
	header LABEL01+$800,1,4,74		;sc22:
	header LABEL01+7+$800,1,6,74
		nullhdr
	header LABEL01+$800,1,4,75		;sc23:
	header LABEL01+7+$800,1,6,75
		nullhdr
	header LABEL01+$900,1,4,76		;sc24:
	header LABEL01+7+$900,1,6,76
		nullhdr
	header LABEL01+$900,1,4,77		;sc25:
	header LABEL01+7+$900,1,6,77
		nullhdr
	header LABEL01+$900,1,4,76		;sc26:
	header LABEL01+7+$900,1,6,78
		nullhdr
	header LABEL01+$900,1,4,75		;sc27:
	header LABEL01+7+$900,1,6,79
		nullhdr
	header LABEL01+$A00,1,5,74		;sc28:
	header LABEL01+7+$A00,1,6,80
		nullhdr
	header LABEL01+$A00,1,5,73		;sc29:
	header LABEL01+7+$A00,1,6,81
		nullhdr
	header LABEL01+$A00,1,5,72		;sc2A:
	header LABEL01+7+$A00,1,6,82
		nullhdr
	header LABEL01+$A00,1,5,71		;sc2B:
	header LABEL01+7+$A00,1,6,83
		nullhdr
	header LABEL01+$B00,1,5,70		;sc2C:
	header LABEL01+7+$B00,1,6,84
		nullhdr
	header LABEL01+$B00,1,5,69		;sc2D:
	header LABEL01+7+$B00,1,6,85
		nullhdr
	header LABEL01+$B00,1,5,68		;sc2E:
	header LABEL01+7+$B00,1,6,86
		nullhdr
	header LABEL01+$B00,1,5,66		;sc2F:
	header LABEL01+7+$B00,1,6,87
		nullhdr
	header LABEL01+$C00,1,6,70		;sc30:
	header LABEL01+7+$C00,1,6,88
		nullhdr
	header LABEL01+$C00,1,6,72		;sc31:
	header LABEL01+7+$C00,1,6,89
		nullhdr
	header LABEL01+$C00,1,6,74		;sc32:
	header LABEL01+7+$C00,1,6,90
		nullhdr
	header LABEL01+$C00,1,6,75		;sc33:
	header LABEL01+7+$C00,1,6,91
		nullhdr
	header LABEL01+$D00,1,6,76		;sc34:
	header LABEL01+7+$D00,1,6,92
		nullhdr
	header LABEL01+$D00,1,6,77		;sc35:
	header LABEL01+7+$D00,1,6,93
		nullhdr
	header LABEL01+$D00,1,6,76		;sc36:
	header LABEL01+7+$D00,1,6,94
		nullhdr
	header LABEL01+$D00,1,6,75		;sc37:
	header LABEL01+7+$D00,1,6,95
		nullhdr
	header LABEL01+$E00,1,7,74		;sc38:
	header LABEL01+7+$E00,1,6,96
		nullhdr
	header LABEL01+$E00,1,7,73		;sc39:
	header LABEL01+7+$E00,1,6,97
		nullhdr
	header LABEL01+$E00,1,7,72		;sc3A:
	header LABEL01+7+$E00,1,6,98
		nullhdr
	header LABEL01+$E00,1,7,71		;sc3B:
	header LABEL01+7+$E00,1,6,99
		nullhdr
	header LABEL01+$F00,1,7,70		;sc3C:
	header LABEL01+7+$F00,1,6,100
		nullhdr
	header LABEL01+$F00,1,7,69		;sc3D:
	header LABEL01+7+$F00,1,6,101
		nullhdr
	header LABEL01+$F00,1,7,68		;sc3E:
	header LABEL01+7+$F00,1,6,102
		nullhdr
	header LABEL01+$F00,1,7,66		;sc3F:
	header LABEL01+7+$F00,1,6,103
		nullhdr

ZH_len	= *-ZoomHeaders

; Z-1________ -0

testmap:
	 dc.B $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A
	 dc.B $0B,$0C,$0D,$0E,$0F,$10,$11,$12,$13,$14,$15

ScaleFactors:		;Y= course vectors, X= depth plane  (128 bytes)
; scale/256
	ds.B	2,4,6,8,10,12,14,17
	ds.B	4,8,12,17,21,25,29,34
	ds.B	6,12,19,25,32,38,44,51
	ds.B	8,17,25,34,42,51,59,68
	ds.B	10,21,32,42,53,64,74,85
	ds.B	12,25,38,51,64,76,89,102
	ds.B	14,29,44,59,74,89,104,119
	ds.B	17,34,51,68,85,102,119,136
	ds.B	19,38,57,76,96,115,134,153
	ds.B	21,42,64,85,106,128,149,170
	ds.B	23,46,70,93,117,140,164,187
	ds.B	25,51,76,102,128,153,179,204
	ds.B	27,55,83,110,138,166,194,221
	ds.B	29,59,89,119,149,179,209,238
	ds.B	32,64,96,128,160,192,224,256

; Z-1________ -0

                                                                                                                                                                                