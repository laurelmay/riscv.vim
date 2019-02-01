" Maintainer: Kyle Laker
" Last Change: 2019 Feb 1

if exists("b:current_syntax")
    finish
endif

setlocal iskeyword+=-
syntax case match

syntax match  riscvComment /#.*/
" Decimal numbers
syntax match  riscvNumber  /\<[-]\?\d\+\>/
" Hex numbers
syntax match  riscvNumber  /\<-\?0\(x\|X\)[0-9a-fA-F]\+\>/
syntax region riscvString  start=/"/ skip=/\\"/ end=/"/
syntax match  riscvLabelColol /:/ contained
syntax match  riscvLabel /\w\+:/ contains=risvLabelColon

" Registers
" Numbered registers
syntax match   riscvRegister /x[0-9]/
syntax match   riscvRegister /x[1-2][0-9]/
syntax match   riscvRegister /x3[0-1]/

" Symbolic register names
syntax keyword riscvRegister zero ra sp gp tp fp
syntax match   riscvRegister /a[0-7]/
syntax match   riscvRegister /t[0-6]/
syntax match   riscvRegister /s[0-9]/
syntax match   riscvRegister /s1[0-1]/

" Assembler directives
syntax match riscvDirective "\.data"
syntax match riscvDirective "\.text"
syntax match riscvDirective "\.byte"
syntax match riscvDirective "\.asciiz"
syntax match riscvDirective "\.word"
syntax match riscvDirective "\.globl"
syntax match riscvDirective "\.float"
syntax match riscvDirective "\.double"
syntax match riscvDirective "\.align"
syntax match riscvDirective "\.string"

" Instructions
" loads
syntax keyword riscvInstruction lb lh lw lbu lhu
" stores
syntax keyword riscvInstruction sb sh sw
" shifts
syntax keyword riscvInstruction sll slli srl srli sra srai
" arithmetic
syntax keyword riscvInstruction add addi sub lui auipc
" logical
syntax keyword riscvInstruction xor xori or ori and andi
" compare
syntax keyword riscvInstruction slt slti sltu sltiu
" branches
syntax keyword riscvInstruction beq bne blt bge bltu bgeu
" jump & link
syntax keyword riscvInstruction jal jalr
" synch
syntax keyword riscvInstruction fence
syntax match   riscvInstruction "fence\.i"
" system call
syntax keyword riscvInstruction scall sbreak
" counters
syntax keyword riscvInstruction rdcycle rdcycleh rdtime rdtimeh rdinstret rdinstreth
" csr access
syntax keyword riscvInstruction csrrw csrrs csrrc csrrwi csrrsi csrrci
" change level
syntax keyword riscvInstruction ecall ebreak eret
" trap redirect
syntax keyword riscvInstruction mrts mrth hrts
" interrupt
syntax keyword riscvInstruction wfi
" mmu
syntax match   riscvInstruction "sfence\.vm"

" M extension
" multiply
syntax keyword riscvInstruction mul mulh mulhsu mulhu
" divide
syntax keyword riscvInstruction div divu rem remu

" A extension
syntax match   riscvInstruction "lr\.w"
syntax match   riscvInstruction "sc\.w"
syntax match   riscvInstruction "amoswap\.w"
syntax match   riscvInstruction "amoadd\.w"
syntax match   riscvInstruction "amoxor\.w"
syntax match   riscvInstruction "amoand\.w"
syntax match   riscvInstruction "amoor\.w"
syntax match   riscvInstruction "amomin\.w"
syntax match   riscvInstruction "amomax\.w"
syntax match   riscvInstruction "amominu\.w"
syntax match   riscvInstruction "amomaxu\.w"

" pseudo-instructions
syntax keyword riscvInstruction nop li la mv
syntax keyword riscvInstruction not neg negw
syntax match   riscvInstruction "sext\.w"
syntax keyword riscvInstruction seqz snez sltz sgtz
syntax keyword riscvInstruction beqz bnez blez bgtz bgt ble bgtu bleu
syntax keyword riscvInstruction j jr ret

hi def link riscvComment        Comment
hi def link riscvNumber         Number
hi def link riscvString         String
hi def link riscvRegister       Identifier
hi def link riscvLabel          Label
hi def link riscvDirective      Type
hi def link riscvInstruction    Statement

let b:current_syntax = "riscv"
