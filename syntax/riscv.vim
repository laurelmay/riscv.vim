" Maintainer: Kyle Laker <kyle@laker.email>
" Last Change: 2020 Jul 11

if exists("b:current_syntax")
    finish
endif

setlocal iskeyword+=-
syntax case match

syntax match   riscvComment    /#.*/
syntax match   riscvTodo       /\v\c<(fix(me)?|note[s]?|todo|issue|bug|task)[:]?/ containedin=.*Comment
" Decimal numbers
syntax match   riscvNumber     /\<[-]\?\d\+\>/
" Hex numbers
syntax match   riscvNumber     /\<-\?0\(x\|X\)[0-9a-fA-F]\+\>/
syntax region  riscvString     start=/"/ skip=/\\"/ end=/"/
syntax region  riscvChar       start=/'/ skip=/\\'/ end=/'/
syntax match   riscvLabelColon /:/ contained
syntax match   riscvLabel      /\w\+:/ contains=riscvLabelColon

" Registers
" Numbered registers
syntax match   riscvRegister /\<x\([1-2]?[0-9]\|3[0-1]\)\>/

" Symbolic register names
syntax keyword riscvRegister zero ra sp gp tp fp pc
syntax keyword riscvRegister a0 a1 a2 a3 a4 a5 a6 a7
syntax keyword riscvRegister t0 t1 t2 t3 t4 t5 t6
syntax keyword riscvRegister s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 s10 s11
syntax keyword riscvRegister mepc mscratch mtvec mstatus mcause mie mpie mtval mip mpp

" Assembler directives
syntax match riscvDirective /\.align/
syntax match riscvDirective /\.file/
syntax match riscvDirective /\.globl/
syntax match riscvDirective /\.local/
syntax match riscvDirective /\.comm/
syntax match riscvDirective /\.common/
syntax match riscvDirective /\.ident/
syntax match riscvDirective /\.section/
syntax match riscvDirective /\.size/
syntax match riscvDirective /\.text/
syntax match riscvDirective /\.data/
syntax match riscvDirective /\.rodata/
syntax match riscvDirective /\.bss/
syntax match riscvDirective /\.string/
syntax match riscvDirective /\.asciz/
syntax match riscvDirective /\.equ/
syntax match riscvDirective /\.macro/
syntax match riscvDirective /\.endm/
syntax match riscvDirective /\.type/
syntax match riscvDirective /\.option/
syntax match riscvDirective /\.byte/
syntax match riscvDirective /\.2byte/
syntax match riscvDirective /\.half/
syntax match riscvDirective /\.short/
syntax match riscvDirective /\.4byte/
syntax match riscvDirective /\.word/
syntax match riscvDirective /\.long/
syntax match riscvDirective /\.8byte/
syntax match riscvDirective /\.dword/
syntax match riscvDirective /\.quad/
syntax match riscvDirective /\.skip/
syntax match riscvDirective /\.dtprelword/
syntax match riscvDirective /\.dtpreldword/
syntax match riscvDirective /\.sleb128/
syntax match riscvDirective /\.uleb128/
syntax match riscvDirective /\.p2align/
syntax match riscvDirective /\.balign/
syntax match riscvDirective /\.zero/
syntax match riscvDirective /\.global/
syntax match riscvDirective /\.float/
syntax match riscvDirective /\.double/

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
syntax keyword riscvInstruction csrrw csrrs csrrc csrrwi csrrsi csrrci csrr csrw
" change level
syntax keyword riscvInstruction ecall ebreak eret
" trap redirect
syntax keyword riscvInstruction mrts mrth hrts mret
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

" RV64I
" load and store
syntax keyword riscvInstruction lwu ld sd
" shift
syntax keyword riscvInstruction sllw srlw sraw slliw srliw sraiw
" add / sub
syntax keyword riscvInstruction addw subw addiw

" RV64M
syntax keyword riscvInstruction mulw divw divuw remw remuw

" pseudo-instructions
syntax keyword riscvInstruction nop li la mv
syntax keyword riscvInstruction not neg negw
syntax match   riscvInstruction "sext\.w"
syntax keyword riscvInstruction seqz snez sltz sgtz
syntax keyword riscvInstruction beqz bnez blez bgtz bgt ble bgtu bleu bgez bltz
syntax keyword riscvInstruction j jr ret call

hi def link riscvComment        Comment
hi def link riscvTodo           Todo
hi def link riscvNumber         Number
hi def link riscvString         String
hi def link riscvChar           String
hi def link riscvRegister       Identifier
hi def link riscvLabel          Label
hi def link riscvDirective      Type
hi def link riscvInstruction    Statement

let b:current_syntax = "riscv"
