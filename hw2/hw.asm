format PE console
entry start

include 'win32a.inc'

;--------------------------------------------------------------------------
section '.data' data readable writable

        strVecSize     db 'size of vector? ', 0
        strIncorSize   db 'Incorrect size of vector = %d', 10, 0
        strVecElemI    db '[%d]? ', 0
        strScanInt     db '%d', 0
        strVecElemOut  db '[%d] = %d', 10, 0
        strOutA        db 'vector A:', 10, 0
        strOutB        db 'vector B:', 10, 0


        vec_size     dd 0
        tmpStack     dd ?
        vec_size_B   dd 0
        sum          dd 0
        i            dd ?
        tmp          dd ?
        vec          rd 100
        vecB         rd 100

;--------------------------------------------------------------------------
section '.code' code readable executable
start:

        call VectorInput

        call FormVecB

        push strOutA
        call [printf]

        call VectorOut

        push strOutB
        call [printf]

        call PrintB
finish:
        call [getch]

        push 0
        call [ExitProcess]

;--------------------------------------------------------------------------
VectorInput:
        push strVecSize
        call [printf]
        add esp, 4

        push vec_size
        push strScanInt
        call [scanf]
        add esp, 8

        mov eax, [vec_size]
        cmp eax, 0
        jg  getVector

        push [vec_size]
        push strIncorSize
        call [printf]
        push 0
        call [ExitProcess]

getVector:
        xor ecx, ecx
        mov ebx, vec
getVecLoop:
        mov [tmp], ebx
        cmp ecx, [vec_size]
        jge endInputVector

        mov [i], ecx
        push ecx
        push strVecElemI
        call [printf]
        add esp, 8

        push ebx
        push strScanInt
        call [scanf]
        add esp, 8

        mov ecx, [i]
        inc ecx
        mov ebx, [tmp]
        add ebx, 4
        jmp getVecLoop
endInputVector:
        ret
;--------------------------------------------------------------------------
VectorOut:
        mov [tmpStack], esp
        xor ecx, ecx
        mov ebx, vec
putVecLoop:
        mov [tmp], ebx
        cmp ecx, [vec_size]
        je endOutputVector
        mov [i], ecx


        push dword [ebx]
        push ecx
        push strVecElemOut
        call [printf]

        mov ecx, [i]
        inc ecx
        mov ebx, [tmp]
        add ebx, 4
        jmp putVecLoop
endOutputVector:
        mov esp, [tmpStack]
        ret
;--------------------------------------------------------------------------
FormVecB:
        mov [tmpStack], esp
        xor ecx, ecx

formVecBLoop:
        cmp ecx, [vec_size]
        je endFormB

        mov [i], esp

        mov ebx, dword [vec + 4 * ecx]
        cmp ebx, 5
        jg plusFive

        cmp ebx, -5
        jl minusFive

        jmp other

plusFive:
        add ebx, 5
        mov [vecB + ecx * 4], ebx
        jmp continueGen

minusFive:
        sub ebx, 5
        mov [vecB + ecx * 4], ebx
        jmp continueGen

other:
        mov [vecB + ecx * 4], 0
        jmp continueGen

continueGen:
        mov esp, [i]
        inc ecx
        jmp formVecBLoop

endFormB:
        mov esp, [tmpStack]
        ret
;--------------------------------------------------------------------------------
PrintB:
        xor ecx, ecx
        mov [tmpStack], esp


printLoopB:
        cmp ecx, [vec_size]
        je endOutputB

        mov [i], ecx

        push dword [vecB + ecx * 4]
        push ecx
        push strVecElemOut
        call [printf]

        mov ecx, [i]

        inc ecx
        jmp printLoopB

endOutputB:
        mov esp, [tmpStack]
        ret
;---------------------------------------------------------
                                                 
section '.idata' import data readable
    library kernel, 'kernel32.dll',\
            msvcrt, 'msvcrt.dll',\
            user32,'USER32.DLL'

include 'api\user32.inc'
include 'api\kernel32.inc'
    import kernel,\
           ExitProcess, 'ExitProcess',\
           HeapCreate,'HeapCreate',\
           HeapAlloc,'HeapAlloc'
  include 'api\kernel32.inc'
    import msvcrt,\
           printf, 'printf',\
           scanf, 'scanf',\
           getch, '_getch'