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
ld hl, $1a24
ld  a, $30
call WRTVRM

;--
gLoop:		;メインゲームループ

;--
;ld a, 5		;キー入力
;call SNSMAT	;w11101111ef s11111110fe
;cp $ef		;wキーか？
;jp z, wpush1	;押された時の処理



call delay02
jp wpush1
jp gLoop		;メインゲームループ頭へジャンプ

;-- sub

wpush1:
;--　スコア+1表示
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
cp $3a		;比較
jp c, awae	;a<3a(10)ならawaeへ


;-- 3ケタ上
ld hl, $1a24	;3ケタ上の位置
call REDVRM	;にある数を読んで
inc a			;１上げる
call WRTVRM	;数を書き込む
ld a,$30		;aを0、そのままawaeへ


awae:
ld hl, $1a25
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
;--　スコア+1表示ここまで
call delay01


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
