format PE console
entry start
include 'win32a.inc'

section '.data' data readable writeable

prompt db 'What is your age? ', 0
outstr db 'You age is %s', 0
inputStr db '%s', 0

name dd ?

NULL = 0


section '.code' code readable executable
start:
push prompt
call [printf]

push name
push inputStr
call [scanf]

push name
push outstr
call [printf]

call [getch]

push NULL
call [ExitProcess]

section 'idata' import data readable
library kernel, 'kernel32.dll', \
msvcrt, 'msvcrt.dll'
import kernel, \
ExitProcess, 'ExitProcess'

import msvcrt, \
scanf, 'scanf', \
printf, 'printf', \
getch, '_getch'
