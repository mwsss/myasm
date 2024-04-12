include "init_gr2.asm"
Main:
; --キャラクタパターンとカラーテーブル作成
call CreateCharacterPattern

;--top

;--
ld hl, $1a29	;ダミーの0
ld  a, $30
call WRTVRM
;--
ld hl, $1a28	;ダミーの0
ld  a, $30
call WRTVRM
;--
ld hl, $1a27
ld  a, $30
call WRTVRM
;--
ld hl, $1a26
ld  a, $30
call WRTVRM
;--
ld hl, $1a25
ld  a, $30
call WRTVRM


;--
gLoop:

;--
ld a, 5
call SNSMAT	;w11101111ef s11111110fe
cp $ef ;w
jp z, wpush1

call DelayLoop
call DelayLoop

jp gLoop

;-- sub

wpush1:
ld hl, $1a27	;スコアの位置
call REDVRM	;にある数を読んで
inc a			;１上げる
cp $3a		;比較
jp c, awac	;a<3a(10)ならawacへ

;-- 1ケタあがり
ld hl, $1a26	;1ケタ上の位置
call REDVRM	;にある数を読んで
inc a			;１上げる

cp $3a		;比較
jp c, awad	;a<3a(10)ならawadへ

;-- 2ケタ上
ld hl, $1a25	;2ケタ上の位置
call REDVRM	;にある数を読んで
inc a			;１上げる
call WRTVRM	;数を書き込む
ld a,$30		;aを0、そのままawadへ

awad:
ld hl, $1a26
call WRTVRM	;数を書き込む
ld a,$30		;aを0、そのままawacへ
;--

awac:
ld hl, $1a27	;その位置に
call WRTVRM	;数を書き込む

call DelayLoop
call DelayLoop
call DelayLoop
call DelayLoop
jp gLoop

;-- INCLUDE
include "pcg_graphic2.asm"
include "data_gr2.asm"
