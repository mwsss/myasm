dcompr equ $0020        ;wakaru bios
wrtvrm equ $004d
ldivrm equ $005c
chgmod equ $005f
chput equ $00a2
breakx equ $00b7
posit equ $00c6
gtstck equ $00d5
gttrig equ $00d8
t32nam equ $f3db
t32col equ $f3dc
t32cgp equ $f3dd
forclr equ $f3e9
bakclr equ $f3ea
bdrclr equ $f3eb

org $4000        ;wakaru kaisi ichi

Header:        ;wakaru
    defb 'A', 'B', $10, $40, $00, $00, $00, $00
    defb $00, $00, $00, $00, $00, $00, $00, $00
    
call setInitialData        ;wakaru hensu

init: 
ld a,15        ;wakaru gamen iro
ld (forclr),a
ld a,1
ld (bakclr),a
ld (bdrclr),a
call chgmod        ;wakaru
call chrset
ld a,0
ld (joystk),a        ;wakaru
ld ix,canon
call getxy          ;l,h ichi hairu
ld a,(ix+0)         ;a n chr$ hairu
call wrtvrm        ;wakaru

main:        ;wakaru
call movcan
call snstrg
call wait
call mvmisl
;call breakx
;ret c
jr main

movcan:        ;wakaru houdai ido
ld a,(joystk)
call gtstck
cp 3        ;wakaru migi osaretara
jr z,right
cp 7        ;wakaru hidari osaretara
jr z,left
ret

right:        ;wakaru ido
ld ix,canon
call getxy
ld e,l
ld d,h
inc de
ld a,e
and $1f         ;? atode / 31 ika ni suru
cp 29           ;wakaru x>29 nara ret
ret nc

movchr:        ;wakaru houdai hyouji
ld a,' '
call wrtvrm
ex de,hl
call putxy
ld a,(ix+0)
call wrtvrm
ret

left:        ;wakaru ido
ld ix,canon
call getxy
ld e,l
ld d,h
dec de
ld a,e
and $1f     ;? atode / 31 ika ni suru
cp 3        ;wakaru x<3 nara ret
ret c
jr movchr

snstrg:        ;ayahuya spc key
ld a,(joystk)
call gttrig
ld hl,trig
ld c,(hl)
ld (hl),a
and a
ret z
cp c
ret z

fire:        ;wakaru
ld ix,misil1
ld a,(ix+0)
and a
jr z,fire1
ld a,(ix+3)
and a
jr z,fire2
ld a,(ix+6)
and a
jr z,fire3
ret

fire1:        ;wakaru
ld ix,misil1
jr fireon

fire2:        ;wakaru
ld ix,misil2
jr fireon

fire3:        ;wakaru
ld ix,misil3

fireon:        ;wakaru
ld a,-1
ld (ix+0),a
ld hl,(canon+1)
ld bc,-32       ;wakaru ue e utu
add hl,bc
call putxy
ld a,$c1
call wrtvrm     ;wakaru tama hyouji
ret 

mvmisl:        ;wakaru
ld ix,misil1
call mslchk
ld ix,misil2
call mslchk
ld ix,misil3

mslchk:        ;wakaru
ld a,(ix+0)
inc a
ret nz ;nz
call getxy
ld d,h
ld e,l
ld bc,-32
add hl,bc
ex de,hl
ld a,' '
call wrtvrm
ld a,d
cp $18
jr c,msloff
ex de,hl
call putxy
ld a,$c1
call wrtvrm
ret 

msloff:        ;wakaru
xor a
ld (ix+0),a
ret 

getxy:
ld l,(ix+1)
ld h,(ix+2)
ret

putxy:        ;wakaru
ld (ix+1),l
ld (ix+2),h
ret

wait:        ;wakaru
ld bc,$500     ;$8000
wait1:
dec bc
ld a,b
or c
jr nz,wait1
ret






chrset:        ;wakaru
ld hl,chrdat
ld de,$c0*8
ld bc,16
call ldivrm
ret


chrdat:        ;wakaru
defb $00,$18,$18,$7e,$ff,$ff,$ff,$00
defb $00,$18,$18,$18,$18,$18,$18,$00







timec1:equ $C000  ; 1 byte        ;wakaru
timec2:equ $C001  ; 1 byte
timec3:equ $C002  ; 1 byte
timec4:equ $C003  ; 1 byte
joystk:equ $C004  ; 1 byte
trig:equ   $C005  ; 1 byte
canon:equ  $C006  ; 3 byte
misil1:equ $C009  ; 3 byte
misil2:equ $C00C  ; 3 byte
misil3:equ $C00F  ; 3 byte
time1:equ  $C012  ; 1 byte
time2:equ  $C013  ; 1 byte
time3:equ  $C014  ; 1 byte
time4:equ  $C015  ; 1 byte
invtic:equ $C016  ; 1 byte
invtim:equ $C017  ; 1 byte
invnin:equ $C018  ; 1 byte
lrd:equ    $C019  ; 1 byte
lr:equ     $C01A  ; 1 byte
invpnt:equ $C01B  ; 2 byte
inv1:equ   $C01D  ; 3*54 byte (C01DH - C0BFH)
inv55:equ  $C0BF  ; 3 byte

; 変数領域に初期値をセットする
setInitialData:

  ld a, 7
  ld (timec1), a
  ld (timec2), a
  ld a, 5
  ld (timec3), a
  ld a, 7
  ld (timec4), a
  xor a
  ld (joystk), a
  ld (trig), a
  ld a, $c0
  ld (canon), a
  ld hl, $1800 + 752
  ld (canon + 1), hl

  xor a
  ld (misil1), a
  ld (misil2), a
  ld (misil3), a
  ld (misil1 + 1), a
  ld (misil2 + 1), a
  ld (misil3 + 1), a
  ld (misil1 + 2), a
  ld (misil2 + 2), a
  ld (misil3 + 2), a

  ld a, 1
  ld (time1), a
  ld (time2), a
  ld (time3), a
  ld (time4), a
  ld a, 55
  ld (invtic), a
  ld (invtim), a
  xor a
  ld (invnin), a
  ld a, 7
  ld (lrd), a
  ld (lr), a
  ld hl, inv1
  ld (invpnt), hl

  ld hl, inv1
  ld b, 3*54
  xor a

inv1_memset:
  ld (hl), a
  inc hl
  djnz inv1_memset

  xor a
  ld (inv55), a
  ld (inv55 + 1), a
  ld (inv55 + 2), a

  ret







