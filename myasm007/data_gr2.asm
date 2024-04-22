;--------------------------------------------
; data_gr2.asm
; 固定データ(GRAPHIC2モード用)
;--------------------------------------------
; キャラクタパターンとカラーテーブル
CHRPTN:
    defb $80  ; CHAR CODE kabe
    defb $aa, $55, $aa, $55, $aa, $55, $aa, $55 ; CHAR PATTERN
    defb $51, $51, $51, $51, $51, $51, $51, $51 ; COLOR PATTERN

    defb $81  ; CHAR CODE hato
    defb $66, $ff, $ff, $ff, $7e, $7E, $3c, $18 ; CHAR PATTERN
    defb $d1, $d1, $81, $81, $81, $81, $d1, $d1 ; COLOR PATTERN

    defb $82  ; CHAR CODE me
    defb $3C, $7E, $5A, $FF, $E7, $7E, $7E, $66 ; CHAR PATTERN
    defb $e1, $f1, $f1, $f1, $f6, $f1, $e1, $f1 ; COLOR PATTERN

    defb $84  ; CHAR CODE hi
    defb $08, $3c, $5a, $aa, $ba, $a5, $66, $7e ; CHAR PATTERN
    defb $71, $51, $57, $57, $57, $47, $41, $41 ; COLOR PATTERN


    defb $85  ; CHAR CODE siro B
    defb $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; CHAR PATTERN
    defb $f1, $f1, $f1, $f1, $f1, $f1, $f1, $f1 ; COLOR PATTERN

    defb $58  ; CHAR CODE ao x
    defb $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; CHAR PATTERN
    defb $41, $41, $41, $41, $41, $41, $41, $41 ; COLOR PATTERN

    defb $85  ; CHAR CODE hosi
    defb $18, $3c, $ff, $7e, $3c, $7E, $66, $c3 ; CHAR PATTERN
    defb $b1, $a1, $a1, $b1, $a1, $a1, $a1, $a1 ; COLOR PATTERN



CHRPTN_END:
    defb $00 ; CHAR CODEの部分が00Hであれば処理終了とみなす
