format PE console
entry start
include 'win32a.inc'

section '.data' data readable writeable

prompt db 'What is your age? ', 0
outstr db 'You age is %d', 0
inputStr db '%d', 0

age dd ?
NULL = 0


section '.code' code readable executable
start:
push prompt
call [printf]

push age
push inputStr
call [scanf]

push [age]
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
