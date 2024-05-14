include "init_gr2.asm"
Main:
; --キャラクタパターンとカラーテーブル作成
call CreateCharacterPattern

hensu1: equ $C000
hensu2: equ $C001
;--top

ld a, $81
ld (hensu2) , a		;hensu2=B

ld a, $80
ld (hensu1) , a		;hensu1=A

ld hl, hensu1
ld de, $1903
ld bc, 2
call LDIRVM		;AB hyouji

;--
ld ix, hensu1
ld (ix+0), $82		;
ld (ix+1), $83		;
ld (ix+2), $84		;
ld (ix+3), $85		;
ld (ix+4), $86		;

ld hl, ix
ld de, $1903+32
ld bc, 5
call LDIRVM	



;-- kokokara
tekid01:
defb 31,30,29,28,27,26,25,24,23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0

ld a,32
ld (hensu1), a ;hensu1 32kai
ld hl,tekid01
ld (hensu2), hl ;hensu2 idoanim

idoloop:
ld hl,(hensu2)
ld b,0
ld c, (hl)
ld hl, $1900
add hl, bc

ld  a, $83
call WRTVRM	

ld hl,(hensu2)
inc hl
ld (hensu2),hl

ld a,(hensu1)
dec a
ld (hensu1),a

call delay02

ld a, (hensu1)
cp 0
jp nz, idoloop





;call delay01

gLoop:
jp gLoop

;--

delay01:		;--体感1秒ぐらい
ld a,$ff
delay01ls2:
ld b,$ff
delay01ls:
djnz delay01ls
dec a
jp nz, delay01ls2
ret

delay02:		;--体感3秒ぐらい(実際1.5秒ぐらいかも)
call delay01
call delay01
call delay01
ret




;-- INCLUDE
include "pcg_graphic2.asm"
include "data_gr2.asm"
