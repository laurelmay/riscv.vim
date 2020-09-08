" Maintainer: Kyle Laker <kyle@laker.email>
" Last Change: 2020 Jul 11

if exists("b:current_syntax")
    syntax clear
endif

setlocal iskeyword+=-,$
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
" Including floating-point ones
syntax match   riscvRegister /\<f\([1-2]?[0-9]\|3[0-1]\)\>/

" psABI
" Symbolic register names
syntax keyword riscvRegister zero ra sp gp tp fp pc
syntax keyword riscvRegister a0 a1 a2 a3 a4 a5 a6 a7
syntax keyword riscvRegister t0 t1 t2 t3 t4 t5 t6
syntax keyword riscvRegister s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 s10 s11
" Including floating-point ones
syntax keyword riscvRegister ft0 ft1 ft2 ft3 ft4 ft5 ft6 ft7 ft8 ft9 ft10 ft11
syntax keyword riscvRegister fs0 fs1 fs2 fs3 fs4 fs5 fs6 fs7 fs8 fs9 fs10 fs11
syntax keyword riscvRegister fa0 fa1 fa2 fa3 fa4 fa5 fa6 fa7

" Control/Status registers
syntax keyword riscvCSRegister ustatus uie utvec uscratch uepc ucause utval uip
syntax keyword riscvCSRegister fflags frm fcsr cycle time instret
syntax match   riscvCSRegister /\<hpmcounter\([3-9]\|[1-2][0-9]\|3[0-1]\)\>/
syntax keyword riscvCSRegister cycleh timeh instreth
syntax match   riscvCSRegister /\<hpmcounter\([3-9]\|[1-2][0-9]\|3[0-1]\)h\>/
syntax keyword riscvCSRegister sstatus sedeleg sideleg sie stvec scounteren
syntax keyword riscvCSRegister sscratch sepc scause stval sip satp mvendorid
syntax keyword riscvCSRegister marchid mimpid mhartid mstatus misa medeleg
syntax keyword riscvCSRegister mideleg mie mtvec mcounteren mscratch mepc
syntax keyword riscvCSRegister mcause mtval mip
syntax match   riscvCSRegister /\<pmpcfg[0-3]\>/
syntax match   riscvCSRegister /\<pmpaddr\([0-9]\|1[0-5]\)\>/
syntax keyword riscvCSRegister mcycle minstret
syntax match   riscvCSRegister /\<mhpmcounter\([3-9]\|[1-2][0-9]\|3[0-1]\)\>/
syntax keyword riscvCSRegister mcycleh minstreth
syntax match   riscvCSRegister /\<mhpmcounter\([3-9]\|[1-2][0-9]\|3[0-1]\)h\>/
syntax match   riscvCSRegister /\<mhpmevent\([3-9]\|[1-2][0-9]\|3[0-1]\)\>/
syntax keyword riscvCSRegister tselect
syntax match   riscvCSRegister /\<tdata[1-3]\>/
syntax keyword riscvCSRegister dcsr dpc dscratch

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

" C extension
syntax match   riscvInstruction "c\.addi4spn"
syntax match   riscvInstruction "c\.fld"
syntax match   riscvInstruction "c\.lq"
syntax match   riscvInstruction "c\.lw"
syntax match   riscvInstruction "c\.flw"
syntax match   riscvInstruction "c\.ld"
syntax match   riscvInstruction "c\.fsd"
syntax match   riscvInstruction "c\.sq"
syntax match   riscvInstruction "c\.sw"
syntax match   riscvInstruction "c\.fsw"
syntax match   riscvInstruction "c\.sd"
syntax match   riscvInstruction "c\.nop"
syntax match   riscvInstruction "c\.addi"
syntax match   riscvInstruction "c\.jal"
syntax match   riscvInstruction "c\.addiw"
syntax match   riscvInstruction "c\.li"
syntax match   riscvInstruction "c\.addi16sp"
syntax match   riscvInstruction "c\.lui"
syntax match   riscvInstruction "c\.srli"
syntax match   riscvInstruction "c\.srli64"
syntax match   riscvInstruction "c\.srai"
syntax match   riscvInstruction "c\.srai64"
syntax match   riscvInstruction "c\.andi"
syntax match   riscvInstruction "c\.sub"
syntax match   riscvInstruction "c\.xor"
syntax match   riscvInstruction "c\.or"
syntax match   riscvInstruction "c\.and"
syntax match   riscvInstruction "c\.subw"
syntax match   riscvInstruction "c\.addw"
syntax match   riscvInstruction "c\.j"
syntax match   riscvInstruction "c\.beqz"
syntax match   riscvInstruction "c\.bnez"
syntax match   riscvInstruction "c\.slli"
syntax match   riscvInstruction "c\.slli64"
syntax match   riscvInstruction "c\.fldsp"
syntax match   riscvInstruction "c\.lqsp"
syntax match   riscvInstruction "c\.lwsp"
syntax match   riscvInstruction "c\.flwsp"
syntax match   riscvInstruction "c\.ldsp"
syntax match   riscvInstruction "c\.jr"
syntax match   riscvInstruction "c\.mv"
syntax match   riscvInstruction "c\.ebreak"
syntax match   riscvInstruction "c\.jalr"
syntax match   riscvInstruction "c\.add"
syntax match   riscvInstruction "c\.fsdsp"
syntax match   riscvInstruction "c\.sqsp"
syntax match   riscvInstruction "c\.swsp"
syntax match   riscvInstruction "c\.fswsp"
syntax match   riscvInstruction "c\.sdsp"

" F extension
syntax keyword riscvInstruction flw fsw
syntax match   riscvInstruction "fmadd\.s"
syntax match   riscvInstruction "fmsub\.s"
syntax match   riscvInstruction "fnmsub\.s"
syntax match   riscvInstruction "fnmadd\.s"
syntax match   riscvInstruction "fadd\.s"
syntax match   riscvInstruction "fsub\.s"
syntax match   riscvInstruction "fmul\.s"
syntax match   riscvInstruction "fdiv\.s"
syntax match   riscvInstruction "fsqrt\.s"
syntax match   riscvInstruction "fsgnj\.s"
syntax match   riscvInstruction "fsgnjn\.s"
syntax match   riscvInstruction "fsgnjx\.s"
syntax match   riscvInstruction "fmin\.s"
syntax match   riscvInstruction "fmax\.s"
syntax match   riscvInstruction "fcvt\.w\.s"
syntax match   riscvInstruction "fcvt\.wu\.s"
syntax match   riscvInstruction "fmv\.x\.w"
syntax match   riscvInstruction "feq\.s"
syntax match   riscvInstruction "flt\.s"
syntax match   riscvInstruction "fle\.s"
syntax match   riscvInstruction "fclass\.s"
syntax match   riscvInstruction "fcvt\.s\.w"
syntax match   riscvInstruction "fcvt\.s\.wu"
syntax match   riscvInstruction "fmv\.w\.x"
syntax match   riscvInstruction "fcvt\.l\.s"
syntax match   riscvInstruction "fcvt\.lu\.s"
syntax match   riscvInstruction "fcvt\.s\.l"
syntax match   riscvInstruction "fcvt\.s\.lu"

" D extension
syntax keyword riscvInstruction fld fsd
syntax match   riscvInstruction "fmadd\.d"
syntax match   riscvInstruction "fmsub\.d"
syntax match   riscvInstruction "fnmsub\.d"
syntax match   riscvInstruction "fnmadd\.d"
syntax match   riscvInstruction "fadd\.d"
syntax match   riscvInstruction "fsub\.d"
syntax match   riscvInstruction "fmul\.d"
syntax match   riscvInstruction "fdiv\.d"
syntax match   riscvInstruction "fsqrt\.d"
syntax match   riscvInstruction "fsgnj\.d"
syntax match   riscvInstruction "fsgnjn\.d"
syntax match   riscvInstruction "fsgnjx\.d"
syntax match   riscvInstruction "fmin\.d"
syntax match   riscvInstruction "fmax\.d"
syntax match   riscvInstruction "fcvt\.s\.d"
syntax match   riscvInstruction "fcvt\.d\.s"
syntax match   riscvInstruction "feq\.d"
syntax match   riscvInstruction "flt\.d"
syntax match   riscvInstruction "fle\.d"
syntax match   riscvInstruction "fclass\.d"
syntax match   riscvInstruction "fcvt\.w\.d"
syntax match   riscvInstruction "fcvt\.wu\.d"
syntax match   riscvInstruction "fcvt\.d\.w"
syntax match   riscvInstruction "fcvt\.d\.wu"
syntax match   riscvInstruction "fcvt\.l\.d"
syntax match   riscvInstruction "fcvt\.lu\.d"
syntax match   riscvInstruction "fmv\.x\.d"
syntax match   riscvInstruction "fcvt\.d\.l"
syntax match   riscvInstruction "fcvt\.d\.lu"
syntax match   riscvInstruction "fmv\.d\.x"

" Q extension
syntax keyword riscvInstruction flq fsq
syntax match   riscvInstruction "fmadd\.q"
syntax match   riscvInstruction "fmsub\.q"
syntax match   riscvInstruction "fnmsub\.q"
syntax match   riscvInstruction "fnmadd\.q"
syntax match   riscvInstruction "fadd\.q"
syntax match   riscvInstruction "fsub\.q"
syntax match   riscvInstruction "fmul\.q"
syntax match   riscvInstruction "fdiv\.q"
syntax match   riscvInstruction "fsqrt\.q"
syntax match   riscvInstruction "fsgnj\.q"
syntax match   riscvInstruction "fsgnjn\.q"
syntax match   riscvInstruction "fsgnjx\.q"
syntax match   riscvInstruction "fmin\.q"
syntax match   riscvInstruction "fmax\.q"
syntax match   riscvInstruction "fcvt\.s\.q"
syntax match   riscvInstruction "fcvt\.q\.s"
syntax match   riscvInstruction "fcvt\.d\.q"
syntax match   riscvInstruction "fcvt\.q\.d"
syntax match   riscvInstruction "feq\.q"
syntax match   riscvInstruction "flt\.q"
syntax match   riscvInstruction "fle\.q"
syntax match   riscvInstruction "fclass\.d"
syntax match   riscvInstruction "fcvt\.w\.q"
syntax match   riscvInstruction "fcvt\.wu\.q"
syntax match   riscvInstruction "fcvt\.q\.w"
syntax match   riscvInstruction "fcvt\.q\.wu"
syntax match   riscvInstruction "fcvt\.l\.q"
syntax match   riscvInstruction "fcvt\.lu\.q"
syntax match   riscvInstruction "fcvt\.q\.l"
syntax match   riscvInstruction "fcvt\.q\.lu"

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
hi def link riscvRegister       Type
hi def link riscvCSRegister     Function
hi def link riscvLabel          Label
hi def link riscvDirective      Preproc
hi def link riscvInstruction    Keyword

let b:current_syntax = "riscv"
