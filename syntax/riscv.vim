" Maintainer: Kyle Laker <kyle@laker.email>
" Last Change: 2022 Apr 30
" Based on Unprivileged ISA document version 20191213 and Privileged ISA
" document version 20211203.

if exists("b:current_syntax")
    syntax clear
endif

setlocal iskeyword+=-,$,.
syntax case match

" Accept single-line comments (starting with # or //) and multi-line comments (within a /* */)
syntax match   riscvComment    /\(#\|\/\/\).*/
syntax region  riscvComment    start=/\/\*/ end=/\*\//
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
syntax match   riscvRegister /\<x\([1-2]\?[0-9]\|3[0-1]\)\>/
" Including floating-point ones
syntax match   riscvRegister /\<f\([1-2]\?[0-9]\|3[0-1]\)\>/

" psABI
" Symbolic register names
syntax keyword riscvRegister zero ra sp gp tp fp pc
syntax match   riscvRegister /\<a[0-7]\>/
syntax match   riscvRegister /\<t[0-6]\>/
syntax match   riscvRegister /\<s\([0-9]\|1[01]\)\>/
" Including floating-point ones
syntax match   riscvRegister /\<f[st]\([0-9]\|1[01]\)\>/
syntax match   riscvRegister /\<fa[0-7]\>/

" Control/Status registers (from Privileged Specification)
" Unprivileged
syntax keyword riscvCSRegister fflags frm fcsr
syntax keyword riscvCSRegister cycle time instret
syntax match   riscvCSRegister /\<hpmcounter\([3-9]\|[1-2][0-9]\|3[0-1]\)\>/
syntax keyword riscvCSRegister cycleh timeh instreth
syntax match   riscvCSRegister /\<hpmcounter\([3-9]\|[1-2][0-9]\|3[0-1]\)h\>/
" Supervisor-level CSR
syntax keyword riscvCSRegister sstatus sie stvec scounteren
syntax keyword riscvCSRegister senvcfg
syntax keyword riscvCSRegister sscratch sepc scause stval sip
syntax keyword riscvCSRegister satp
syntax keyword riscvCSRegister scontext
" Hypervisor and VS CSR
syntax keyword riscvCSRegister hstatus hedeleg hideleg hie hcounteren hgeie
syntax keyword riscvCSRegister htval hip hvip htinst hgeip
syntax keyword riscvCSRegister henvcfg henvcfgh
syntax keyword riscvCSRegister hgatp
syntax keyword riscvCSRegister hcountext
syntax keyword riscvCSRegister htimedelta htimedeltah
syntax keyword riscvCSRegister vsstatus vsie vstvec vsscratch vsepc vscause vstval vsip vsatp
" Machine-level CSR
syntax keyword riscvCSRegister mvendorid marchid mimpid mhartid mconfigptr
syntax keyword riscvCSRegister mstatus misa medeleg mideleg mie mtvec mcounteren mstatush
syntax keyword riscvCSRegister mscratch mepc mcause mtval mip mtinst mtval2
syntax keyword riscvCSRegister menvcfg menvcfgh mseccfg mseccfgh
syntax match   riscvCSRegister /\<pmpcfg\([0-9]\|1[0-5]\)\>/
syntax match   riscvCSRegister /\<pmpaddr\([0-9]\|[1-5][0-9]\|6[0-3]\)\>/
syntax keyword riscvCSRegister mcycle minstret
syntax match   riscvCSRegister /\<mhpmcounter\([3-9]\|[1-2][0-9]\|3[0-1]\)\>/
syntax keyword riscvCSRegister mcycleh minstreth
syntax match   riscvCSRegister /\<mhpmcounter\([3-9]\|[1-2][0-9]\|3[0-1]\)h\>/
syntax keyword riscvCSRegister mcountinhibit
syntax match   riscvCSRegister /\<mhpmevent\([3-9]\|[1-2][0-9]\|3[0-1]\)\>/
syntax keyword riscvCSRegister tselect mcontext
syntax match   riscvCSRegister /\<tdata[1-3]\>/
syntax keyword riscvCSRegister dcsr dpc
syntax match   riscvCSRegister /\<dscratch[0-1]\?\>/
" CSR from previous versions
syntax keyword riscvCSRegister ustatus uie utvec uscratch uepc ucause utval uip
syntax keyword riscvCSRegister sedeleg sideleg

" Assembler directives
syntax keyword riscvDirective .align .ascii .file .globl .local .comm .common .ident
syntax keyword riscvDirective .section .size .text .data .rodata .bss .string .asciz
syntax keyword riscvDirective .equ .macro .endm .type .option .byte .2byte .half .short
syntax keyword riscvDirective .4byte .word .long .8byte .dword .quad .skip
syntax keyword riscvDirective .dtprelword .dtpreldword .sleb128 .uleb128
syntax keyword riscvDirective .p2align .balign
syntax keyword riscvDirective .global .float .double .set .attribute

" RV32I
" Integer Register-Immediate Instructions
syntax keyword riscvInstruction addi slti sltiu
syntax keyword riscvInstruction andi ori xori
syntax keyword riscvInstruction slli srli srai
syntax keyword riscvInstruction lui auipc
" Integer Register-Register Operations
syntax keyword riscvInstruction add slt sltu and or xor sll srl sub sra
" Control Transfer
syntax keyword riscvInstruction jal jalr
syntax keyword riscvInstruction beq bne blt bltu bge bgeu
" Load and Store
syntax keyword riscvInstruction lw lh lhu lb lbu
syntax keyword riscvInstruction sw sh sb
" Memory Ordering
syntax keyword riscvInstruction fence fence.tso
" Environment Call and Breakpoints
syntax keyword riscvInstruction ecall ebreak eret
syntax keyword riscvInstruction scall sbreak

" Zifencei
syntax keyword riscvInstruction fence.i

" RV64I
syntax keyword riscvInstruction addiw slliw srliw sraiw
syntax keyword riscvInstruction addw sllw srlw subw sraw
syntax keyword riscvInstruction ld lwu sd

" RV128I
syntax keyword riscvInstruction ldu lq sq

" M extension
syntax keyword riscvInstruction mul mulh mulhsu mulhu
syntax keyword riscvInstruction div divu rem remu
syntax keyword riscvInstruction mulw divw divuw remw remuw

" A extension
syntax keyword riscvInstruction lr.w lr.d sc.w sc.d
syntax keyword riscvInstruction amoswap.w amoswap.d
syntax keyword riscvInstruction amoadd.w amoadd.d
syntax keyword riscvInstruction amoand.w amoand.d
syntax keyword riscvInstruction amoor.w amoor.d
syntax keyword riscvInstruction amoxor.w amoxor.d
syntax keyword riscvInstruction amomax.w amomax.d
syntax keyword riscvInstruction amomin.w amomin.d
syntax keyword riscvInstruction amomaxu.w amomaxu.d
syntax keyword riscvInstruction amominu.w amominu.d

" Zicsr
syntax keyword riscvInstruction csrrw csrrs csrrc csrrwi csrrsi csrrci csrr csrw
syntax keyword riscvInstruction csrwi csrsi csrci
syntax keyword riscvInstruction frcsr fscsr frrm fsrm frflags fsflags

" Counters
syntax keyword riscvInstruction rdcycle rdcycleh rdtime rdtimeh rdinstret rdinstreth

" C extension
syntax keyword riscvInstruction c.lwsp c.ldsp c.lqsp c.flwsp c.fldsp
syntax keyword riscvInstruction c.swsp c.sdsp c.sqsp c.fswsp c.fsdsp
syntax keyword riscvInstruction c.lw c.ld c.lq c.flw c.fld
syntax keyword riscvInstruction c.sw c.sd c.sq c.fsw c.fsd
syntax keyword riscvInstruction c.j c.jal c.jr c.jalr
syntax keyword riscvInstruction c.beqz c.bnez
syntax keyword riscvInstruction c.li c.lui
syntax keyword riscvInstruction c.addi c.addiw c.addi16sp c.addi4spn
syntax keyword riscvInstruction c.slli c.srli c.srai c.slli64 cc.srli64 c.srai64
syntax keyword riscvInstruction c.andi
syntax keyword riscvInstruction c.mv c.add c.and c.or c.xor c.sub c.addw c.subw
syntax keyword riscvInstruction c.nop
syntax keyword riscvInstruction c.ebreak

" F extension
syntax keyword riscvInstruction flw fsw
syntax keyword riscvInstruction fadd.s fsub.s
syntax keyword riscvInstruction fmul.s fdiv.s
syntax keyword riscvInstruction fmadd.s fmsub.s fnmadd.s fnmsub.s
syntax keyword riscvInstruction fsqrt.s
syntax keyword riscvInstruction fmin.s fmax.s

syntax keyword riscvInstruction fcvt.w.s fcvt.wu.s fcvt.l.s fcvt.lu.s
syntax keyword riscvInstruction fcvt.s.w fcvt.s.wu fcvt.s.l fcvt.s.lu
syntax keyword riscvInstruction fsgnj.s fsgnj.n.s fsgnjx.s
syntax keyword riscvInstruction fmv.s fneg.s fabs.s
syntax keyword riscvInstruction fmv.x.w fmv.w.x
syntax keyword riscvInstruction fmv.x.s fmv.s.x
syntax keyword riscvInstruction feq.s flt.s fle.s
syntax keyword riscvInstruction fclass.s

" D extension
syntax keyword riscvInstruction fld fsd
syntax keyword riscvInstruction fadd.d fsub.d
syntax keyword riscvInstruction fmul.d fdiv.d
syntax keyword riscvInstruction fmin.d fmax.d
syntax keyword riscvInstruction fsqrt.d
syntax keyword riscvInstruction fmadd.d fmsub.d fnmadd.d fnmsub.d

syntax keyword riscvInstruction fcvt.w.d fcvt.wu.d fcvt.l.d fcvt.lu.d
syntax keyword riscvInstruction fcvt.d.w fcvt.d.wu fcvt.d.l fcvt.d.lu
syntax keyword riscvInstruction fcvt.s.d fcvt.d.s
syntax keyword riscvInstruction fsgnj.d fsgnjn.d fsgnjx.d
syntax keyword riscvInstruction fmv.d fneg.d fabs.d
syntax keyword riscvInstruction fmv.x.d fmv.d.x
syntax keyword riscvInstruction feq.d flt.d fle.d
syntax keyword riscvInstruction fclass.d

" Q extension
syntax keyword riscvInstruction flq fsq
syntax keyword riscvInstruction fadd.q fsub.q
syntax keyword riscvInstruction fmul.q fdiv.q
syntax keyword riscvInstruction fmin.q fmax.q
syntax keyword riscvInstruction fsqrt.q
syntax keyword riscvInstruction fmadd.q fmsub.q fnmadd.q fnmsub.q

syntax keyword riscvInstruction fcvt.w.q fcvt.wu.q fcvt.l.q fcvt.lu.q
syntax keyword riscvInstruction fcvt.q.w fcvt.q.wu fcvt.q.l fcvt.q.lu
syntax keyword riscvInstruction fcvt.s.q fcvt.q.s fcvt.d.q fcvt.q.d
syntax keyword riscvInstruction fsgnj.q fsgnjn.q fsgnjx.q
syntax keyword riscvInstruction fmv.x.q fmv.q.x
syntax keyword riscvInstruction feq.d flt.d fle.d
syntax keyword riscvInstruction fclass.q

" float rouding modes
syntax keyword riscvDirective rne rtz rdn rup rmm dyn

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
syntax keyword riscvInstruction li la lla
syntax keyword riscvInstruction nop mv
syntax keyword riscvInstruction not neg negw
syntax keyword riscvInstruction sext.w
syntax keyword riscvInstruction seqz snez sltz sgtz
syntax keyword riscvInstruction fmv.s fabs.s fneg.s
syntax keyword riscvInstruction fmv.d fabs.d fneg.d
syntax keyword riscvInstruction fmv.q fabs.q fneg.q
syntax keyword riscvInstruction beqz bnez blez bgez bltz bgtz bgt ble bgtu bleu
syntax keyword riscvInstruction j jr ret call tail jump

" Privileged Instructions
" Machine-Mode Privileged instructions
syntax keyword riscvInstruction mret sret
syntax keyword riscvInstruction wfi
" Supervisor Instructions
syntax keyword riscvInstruction sfence.vma
" Svinval
syntax keyword riscvInstruction sinval.vma sfence.w.inval sfence.inval.ir
" Hypervisor Instructions
syntax keyword riscvInstruction hlv.b hlv.bu hlv.h hlv.hu hlv.w hlv.wu hlv.d
syntax keyword riscvInstruction hsv.b hsv.h hsv.w hsv.d
syntax keyword riscvInstruction hlvx.hu hlvx.wu
syntax keyword riscvInstruction hfence.vvma hfence.gvma
syntax keyword riscvInstruction hinval.vvma hinval.gvma
" In older versions of privileged spec
syntax keyword riscvInstruction mrts mrth hrts sfence.vm

" relocations
syntax match   riscvDirective "\<%hi\>"
syntax match   riscvDirective "\<%lo\>"
syntax match   riscvDirective "\<%pcrel_hi\>"
syntax match   riscvDirective "\<%pcrel_lo\>"
syntax match   riscvDirective "\<%tprel_hi\>"
syntax match   riscvDirective "\<%tprel_lo\>"
syntax match   riscvDirective "\<%tprel_add\>"
syntax match   riscvDirective "\<%tls_ie_pcrel_hi\>"
syntax match   riscvDirective "\<%tls_gd_pcrel_hi\>"
syntax match   riscvDirective "\<%got_pcrel_hi\>"

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
