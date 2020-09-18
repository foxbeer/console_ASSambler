format PE console

entry Start

include 'win32a.inc'

section '.data' data readable writable
        firstPromt db 'How old your girlfriend?', 0
        secondPromt db 'Okay, chill out', 0
        thirdPromt db 'Im calling the FBI', 0
        paceStr db ' %d',0
        emptyStr db '%d',0
        formatStr db '%s',0
    age rd 1
    NULL = 0

section '.code' code readable executable

    Start: 
        push firstPromt
        call[printf]

        push age
        push emptyStr
        call [scanf]

        cmp [age], 18
        jl label2
                push secondPromt
                jmp finish
        label2:
                push thirdPromt
                jmp finish
        finish:
        call [printf]
        call [getch]
        push  NULL
        call[ExitProcess]




section '.idata' import data readable
    
        library kernel, 'kernel32.dll' ,\
                msvcrt, 'msvcrt.dll'

        import kernel ,\
               ExitProcess, 'ExitProcess'

        import msvcrt ,\
               printf, 'printf',\
               scanf, 'scanf',\
               getch, '_getch'