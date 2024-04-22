include "init_gr2.asm"
Main:
; --キャラクタパターンとカラーテーブル作成
call CreateCharacterPattern

hensu1: equ $C000
hensu2: equ $C001
;--top

ld a, $42
ld (hensu2) , a		;hensu2=B

ld a, $41
ld (hensu1) , a		;hensu1=A

ld hl, hensu1
ld de, $1903
ld bc, 2
call LDIRVM		;AB hyouji

;--
ld ix, hensu1
ld (ix+0), $43		;c
ld (ix+1), $44		;d
ld (ix+2), $45		;e

ld hl, ix
ld de, $1903+32
ld bc, 3
call LDIRVM		;hyouji


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
