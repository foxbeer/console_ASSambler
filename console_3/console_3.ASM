format PE console
entry start
include 'win32a.inc'

section '.data' data readable writeable

        infoStr db 'How much slaves do you need?', 0
        infoStr2 db 'Here they are',0
        resStr db 'Ready to work!', 0
        emptyStr db ' %d', 0
        newLine db '', 10, 0

NULL = 0
A dd ?

section '.code' code readable executable
        start:
        push infoStr
        call [printf]

        push A
        push emptyStr
        call[scanf]

        mov ebx,1
                lp:
            push resStr
            call [printf]

            push newLine
            call [printf]
            add ebx,1
            cmp ebx, [A]
            jle lp
            jmp finish


        finish:
          push infoStr2
          call [printf]
        call [getch]

        push NULL
          call [ExitProcess]
   section '.idata' import data readable

        library kernel, 'kernel32.dll' ,\
                msvcrt, 'msvcrt.dll'

        import kernel ,\
               ExitProcess, 'ExitProcess'

        import msvcrt ,\
               printf, 'printf',\
               scanf, 'scanf',\
               getch, '_getch'