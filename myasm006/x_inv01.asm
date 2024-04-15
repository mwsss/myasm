dcompr equ $0020
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

org $4000

Header:
    defb 'A', 'B', $10, $40, $00, $00, $00, $00
    defb $00, $00, $00, $00, $00, $00, $00, $00

init: 
ld a,15
ld (forclr),a
ld a,1
ld (bakclr),a
ld (bdrclr),a
call chgmod
call chrset
ld a,0
ld (joystk),a
ld ix,canon
call getxy
ld a,(ix+0)
call wrtvrm

main:
call movcan
call snstrg
call wait
call mvmisl
call breakx
ret c
jr main

movcan:
ld a,(joystk)
call gtstck
cp 3
jr z,right
cp 7
jr z,left
ret

right:
ld ix,canon
call getxy
ld e,l
ld d,h
inc de
ld a,e
and $1f
cp 29
ret nc

movchr:
ld a,' '
call wrtvrm
ex de,hl
call putxy
ld a,(ix+0)
call wrtvrm
ret

left:
ld ix,canon
call getxy
ld e,l
ld d,h
dec de
ld a,e
and $1f
cp 3
ret c
jr movchr

snstrg:
ld a,(joystk)
call gttrig
ld hl,trig
ld c,(hl)
ld (hl),a
and a
ret z
cp c
ret z

fire:
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

fire1:
ld ix,misil1
jr fireon

fire2:
ld ix,misil2
jr fireon

fire3:
ld ix,misil3

fireon:
ld a,-1
ld (ix+0),a
ld hl,(canon+1)
ld bc,-32
add hl,bc
call putxy
ld a,$c1
call wrtvrm
ret 

mvmisl:
ld ix,misil1
call mslchk
ld ix,misil2
call mslchk
ld ix,misil3

mslchk:
ld a,(ix+0)
inc a
ret z ;nz
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

msloff:
xor a
ld (ix+0),a
ret 

getxy:
ld l,(ix+1)
ld h,(ix+2)
ret

putxy:
ld (ix+1),l
ld (ix+2),h
ret

wait:
ld bc,$8000
wait1:
dec bc
ld a,b
or c
jr nz,wait1
ret

joystk:
defb 0

trig:
defb 0

canon:
defb $c0
defw $1800+752

misil1:
defb 0,0,0

misil2:
defb 0,0,0

misil3:
defb 0,0,0


chrset:
ld hl,chrdat
ld de,$c0*8
ld bc,16
call ldivrm
ret


chrdat:
defb $00,$18,$18,$7e,$ff,$ff,$ff,$00
defb $00,$18,$18,$18,$18,$18,$18,$00














