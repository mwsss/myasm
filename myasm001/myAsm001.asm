include "init_gr2.asm"
Main:
; --キャラクタパターンとカラーテーブル作成
    call CreateCharacterPattern

;--top





;--
ld hl, $1a27
ld  a, $30
call WRTVRM






;--
gLoop:


;--
ld a, 5
call SNSMAT ;w11101111ef s11111110fe
cp $ef ;w
jp z, wpush1

call DelayLoop
call DelayLoop

jp gLoop

;-- sub

wpush1:
ld hl, $1a27   ;スコアの位置
call REDVRM    ;にある数を読んで
inc a          ;１上げる
cp $3a;比較
jp c, awac
ld a,$30 
awac:
ld hl, $1a27   ;その位置に
call WRTVRM;数を書き込む

call DelayLoop
call DelayLoop
call DelayLoop
call DelayLoop
jp gLoop




;-- INCLUDE
include "pcg_graphic2.asm"
include "data_gr2.asm"
