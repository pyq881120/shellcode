 ;  The MIT License:
 ;
 ;  Copyright (c) 2014 Kevin Devine
 ;
 ;  Permission is hereby granted,  free of charge,  to any person obtaining a 
 ;  copy of this software and associated documentation files (the "Software"),
 ;  to deal in the Software without restriction,  including without limitation 
 ;  the rights to use,  copy,  modify,  merge,  publish,  distribute,  
 ;  sublicense,  and/or sell copies of the Software,  and to permit persons to 
 ;  whom the Software is furnished to do so,  subject to the following 
 ;  conditions:
 ;
 ;  The above copyright notice and this permission notice shall be included in
 ;  all copies or substantial portions of the Software.
 ;
 ;  THE SOFTWARE IS PROVIDED "AS IS",  WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 ;  IMPLIED,  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 ;  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 ;  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,  DAMAGES OR OTHER
 ;  LIABILITY,  WHETHER IN AN ACTION OF CONTRACT,  TORT OR OTHERWISE,  
 ;  ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR 
 ;  OTHER DEALINGS IN THE SOFTWARE.
 ;
 ;
 ; Current Size = 94 bytes
 
    .x64
    ifndef TEST_CODE
      .model flat, fastcall
    endif
    .code
entrypoint:
    push   rbx
    push   rsi
    push   rdi
    push   rbp
    sub    rsp, 48h
    jmp    init_param
calc_pos:
    push   60h
    pop    rcx
    mov    rsi, [gs:rcx]
    mov    rsi, [rsi+18h]
    mov    rsi, [rsi+10h]
    lodsq
    mov    rsi, [rax]
    mov    rdi, [rsi+30h] 
    add    ecx, [rdi+3ch]
    mov    ebx, [rdi+rcx+28h]
    
    mov    esi, [rdi+rbx+20h]
    add    rsi, rdi
    
    mov    ecx, [rdi+rbx+24h]
    add    rcx, rdi
    xor    edx, edx
find_loop:
    movzx  ebp, word ptr[rcx+2*rdx]
    inc    edx
    lodsd
    cmp    dword ptr[rdi+rax], 'daoL'   ; LoadLibraryA
    jne    find_loop
    cmp    byte ptr[rdi+rax+0bh], 'A'
    jne    find_loop
    
    mov    esi, [rdi+rbx+1ch]
    add    rsi, rdi
    mov    eax, [rsi+4*rbp]
    add    rax, rdi    
    pop    rcx
    call   rax
    add    rsp, 48h
    
    pop    rbp
    pop    rdi
    pop    rsi
    pop    rbx
    ret
init_param:
    call  calc_pos
dll_path:
ifdef TEST_CODE
    db 'ws2_32.dll', 00h
endif
    end entrypoint
