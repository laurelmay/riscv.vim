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
syntax match   riscvLabel      /^\s*\.\?\h\w*:/ contains=riscvLabelColon
syntax match   riscvLabel      /^\s*\d\+:/ contains=riscvLabelColon
" A reference to a local label using <num>[BF]
syntax match   riscvLabelRef   /\<\d\+[bf]\>/

" Registers
" Numbered registers
syntax match   riscvRegister /\<x\([1-2]\?[0-9]\|3[0-1]\)\>/
" Including floating-point ones
syntax match   riscvRegister /\<f\([1-2]\?[0-9]\|3[0-1]\)\>/
" Invalid registers
syntax match   riscvBadRegister /\<\(x\([1-2]\?[0-9]\|3[0-1]\)\($\|\D\)\)\@!x[0-9]\+\>/
syntax match   riscvBadRegister /\<\(f\([1-2]\?[0-9]\|3[0-1]\)\($\|\D\)\)\@!f[0-9]\+\>/

" psABI
" Symbolic register names
syntax keyword riscvRegister zero ra sp gp tp fp pc
syntax match   riscvRegister /\<a[0-7]\>/
syntax match   riscvRegister /\<t[0-6]\>/
syntax match   riscvRegister /\<s\([0-9]\|1[01]\)\>/
" Including floating-point ones
syntax match   riscvRegister /\<f[st]\([0-9]\|1[01]\)\>/
syntax match   riscvRegister /\<fa[0-7]\>/
" Invalid ABI registers
syntax match   riscvBadRegister /\<\(a[0-7]\($\|\D\)\)\@!a[0-9]\+\>/
syntax match   riscvBadRegister /\<\(t[0-6]\($\|\D\)\)\@!t[0-9]\+\>/
syntax match   riscvBadRegister /\<\(s\([0-9]\|1[01]\)\($\|\D\)\)\@!s[0-9]\+\>/
syntax match   riscvBadRegister /\<\(f[st]\([0-9]\|1[01]\)\($\|\D\)\)\@!f[st][0-9]\+\>/
syntax match   riscvBadRegister /\<\(fa[0-7]\($\|\D\)\)\@!fa[0-9]\+\>/

" Control/Status registers (from Privileged Specification)
" Unprivileged
syntax keyword riscvCSRegister fflags frm fcsr
syntax keyword riscvCSRegister cycle time instret
syntax match   riscvCSRegister /\<hpmcounter\([3-9]\|[1-2][0-9]\|3[0-1]\)\>/
syntax match   riscvBadRegister /\<\(hpmcounter\([3-9]\|[1-2][0-9]\|3[0-1]\)\($\|\D\)\)\@!hpmcounter[0-9]\+\>/
syntax keyword riscvCSRegister cycleh timeh instreth
syntax match   riscvCSRegister /\<hpmcounter\([3-9]\|[1-2][0-9]\|3[0-1]\)h\>/
syntax match   riscvBadRegister /\<\(hpmcounter\([3-9]\|[1-2][0-9]\|3[0-1]\)h\($\|\D\)\)\@!hpmcounter[0-9]\+h\>/
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
syntax match   riscvBadRegister /\<\(pmpcfg\([0-9]\|1[0-5]\)\($\|\D\)\)\@!pmpcfg[0-9]\+\>/
syntax match   riscvCSRegister /\<pmpaddr\([0-9]\|[1-5][0-9]\|6[0-3]\)\>/
syntax match   riscvBadRegister /\<\(pmpaddr\([0-9]\|[1-5][0-9]\|6[0-3]\)\($\|\D\)\)\@!pmpaddr[0-9]\+\>/
syntax keyword riscvCSRegister mcycle minstret
syntax match   riscvCSRegister /\<mhpmcounter\([3-9]\|[1-2][0-9]\|3[0-1]\)\>/
syntax match   riscvBadRegister /\<\(mhpmcounter\([3-9]\|[1-2][0-9]\|3[0-1]\)\($\|\D\)\)\@!mhpmcounter[0-9]\+\>/
syntax keyword riscvCSRegister mcycleh minstreth
syntax match   riscvCSRegister /\<mhpmcounter\([3-9]\|[1-2][0-9]\|3[0-1]\)h\>/
syntax match   riscvBadRegister /\<\(mhpmcounter\([3-9]\|[1-2][0-9]\|3[0-1]\)h\($\|\D\)\)\@!mhpmcounter[0-9]\+h\>/
syntax keyword riscvCSRegister mcountinhibit
syntax match   riscvCSRegister /\<mhpmevent\([3-9]\|[1-2][0-9]\|3[0-1]\)\>/
syntax match   riscvBadRegister /\<\(mhpmevent\([3-9]\|[1-2][0-9]\|3[0-1]\)\($\|\D\)\)\@!mhpmevent[0-9]\+\>/
syntax keyword riscvCSRegister tselect mcontext
syntax match   riscvCSRegister /\<tdata[1-3]\>/
syntax match   riscvBadRegister /\<\(tdata[1-3]\($\|\D\)\)\@!tdata[0-9]\+\>/
syntax keyword riscvCSRegister dcsr dpc
syntax match   riscvCSRegister /\<dscratch[0-1]\?\>/
syntax match   riscvBadRegister /\<\(dscratch[0-1]\($\|\D\)\)\@!dscratch[0-9]\+\>/

" Assembler directives
syntax keyword riscvDirective .align .ascii .file .globl .local .comm .common .ident
syntax keyword riscvDirective .section .size .text .data .rodata .bss .string .asciz .asciiz
syntax keyword riscvDirective .equ .macro .endm .type .option .byte .2byte .half .short
syntax keyword riscvDirective .4byte .word .long .8byte .dword .quad .skip
syntax keyword riscvDirective .dtprelword .dtpreldword .sleb128 .uleb128
syntax keyword riscvDirective .p2align .balign
syntax keyword riscvDirective .global .float .double .set .attribute
syntax keyword riscvDirective .cfi_sections .cfi_startproc .cfi_endproc .cfi_def_cfa
syntax keyword riscvDirective .cfi_offset .cfi_def_cfa_offset .cfi_restore
syntax keyword riscvDirective .octa .debug_frame .loc .weak

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
syntax keyword riscvInstruction csrrw csrrs csrrc csrrwi csrrsi csrrci
syntax keyword riscvInstruction csrr csrw csrc csrs
syntax keyword riscvInstruction csrwi csrsi csrci
syntax keyword riscvInstruction frcsr fscsr frrm fsrm frflags fsflags
syntax keyword riscvInstruction fsrmi fsflagsi

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
syntax keyword riscvInstruction fsgnj.s fsgnjn.s fsgnjx.s
syntax keyword riscvInstruction fmv.x.w fmv.w.x
syntax keyword riscvInstruction fmv.x.s fmv.s.x
syntax keyword riscvInstruction feq.s flt.s fle.s
syntax keyword riscvInstruction fclass.s

" Rounding modes
syntax keyword riscvDirective rne rtz rdn rup rmm dyn

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

" N extension (draft)
syntax keyword riscvCSRegister  ustatus uscratch uepc ucause utvec utval uip uie
syntax keyword riscvCSRegister  sedeleg sideleg
syntax keyword riscvInstruction uret

" V extension (draft https://github.com/riscv/riscv-v-spec/releases/tag/v1.0)
syntax keyword riscvCSRegister  vstart vxsat vxrm vcsr vtype vl vlenb
syntax keyword riscvOption      e8 e16 e32 e64 mf8 mf4 mf2 m1 m2 m4 m8
syntax keyword riscvOption      ta tu ma mu
syntax match   riscvRegister    /\<v\([1-2]\?[0-9]\|3[0-1]\)\>/
syntax match   riscvBadRegister /\<\(v\([1-2]\?[0-9]\|3[0-1]\)\($\|\D\)\)\@!v[0-9]\+\>/
syntax match   riscvOption      /\<v\([1-2]\?[0-9]\|3[0-1]\)\.t\>/
syntax match   riscvBadRegister /\<\(v\([1-2]\?[0-9]\|3[0-1]\)\.t\($\|\D\)\)\@!v[0-9]\+\.t\>/
syntax keyword riscvInstruction vsetvli vsetivli vsetvl
syntax keyword riscvInstruction flh fsh
syntax match   riscvInstruction /\<v[sl]s\?e\(8\|16\|32\|64\)\.v\>/
syntax match   riscvInstruction /\<vle\(8\|16\|32\|64\)ff\.v\>/
syntax match   riscvInstruction /\<v[sl][ou]xei\(8\|16\|32\|64\)\.v\>/
syntax keyword riscvInstruction vlm.v vsm.v vle1.v vse1.v
" These likely support some instructions that may not be valid as it would
" result in EMUL * NFIELD > 8.
syntax match   riscvInstruction /\<v[sl]s\?seg[1-8]e\(8\|16\|32\|64\)\.v\>/
syntax match   riscvInstruction /\<vlseg[1-8]e\(8\|16\|32\|64\)ff\.v\>/
syntax match   riscvInstruction /\<v[sl][ou]xseg[1-8]ei\(8\|16\|32\|64\)\.v\>/
" Load/Store Whole Register Instructions
syntax match   riscvInstruction /\<vl[1248]re\(8\|16\|32\|64\)\.v\>/
syntax match   riscvInstruction /\<v[sl][1248]r\.v\>/
" Vector Integer Arithmetic Instructions
syntax keyword riscvInstruction vadd.vv vadd.vx vadd.vi
syntax keyword riscvInstruction vsub.vv vsub.vx vrsub.vx vrsub.vi
syntax match   riscvInstruction /\<vwaddu\?\.[vw][vx]\>/
syntax match   riscvInstruction /\<vwsubu\?\.[vw][vx]\>/
syntax keyword riscvInstruction vwcvt.x.x.v vwcvtu.x.x.v
syntax match   riscvInstruction /\<v[sz]ext\.vf[248]\>/
syntax match   riscvInstruction /\<vadc\.v[vix]m\>/
syntax match   riscvInstruction /\<vmadc\.v[vix]m\?\>/
syntax match   riscvInstruction /\<vsbc\.v[vx]m\>/
syntax match   riscvInstruction /\<vmsbc\.v[vx]m\?\>/
syntax match   riscvInstruction /\<vand\.v[vxi]\>/
syntax match   riscvInstruction /\<vx\?or\.v[vxi]\>/
syntax keyword riscvInstruction vnot.v
syntax match   riscvInstruction /\<vs\([lr]l\|ra\)\.v[vxi]\>/
syntax match   riscvInstruction /\<vnsr[la]\.w[vxi]\>/
syntax keyword riscvInstruction vncvt.x.x.w
syntax match   riscvInstruction /\<vmseq\.v[vxi]\>/
syntax match   riscvInstruction /\<vmsne\.v[vxi]\>/
syntax match   riscvInstruction /\<vmsltu\?\.v[vx]\>/
syntax match   riscvInstruction /\<vmsleu\?\.v[vxi]\>/
syntax match   riscvInstruction /\<vmsgtu\?\.v[xi]\>/
" Compare Pseudoinstructions
syntax match   riscvInstruction /\<vmsg[te]u\?\.vv\>/
syntax keyword riscvInstruction vmslt.vi vmsltu.vi
syntax keyword riscvInstruction vmsge.vi vmsgeu.vi
syntax keyword riscvInstruction vmsge.vx vmsgeu.vx
" Integer Minx/Max instructions
syntax match   riscvInstruction /\<vminu\?\.v[vx]\>/
syntax match   riscvInstruction /\<vmaxu\?\.v[vx]\>/
" Single-width integer multiplication
syntax match   riscvInstruction /\<vmul\(h\(s\?u\)\?\)\?\.v[vx]\>/
syntax match   riscvInstruction /\<vdivu\?\.v[vx]\>/
syntax match   riscvInstruction /\<vremu\?\.v[vx]\>/

syntax match   riscvInstruction /\<vwmul\(s\?u\)\?\.v[vx]\>/
syntax match   riscvInstruction /\<vma\(cc\|dd\)\.v[vx]\>/
syntax match   riscvInstruction /\<vnms\(ac\|ub\)\.v[vx]\>/
syntax match   riscvInstruction /\<vwmaccu\?\.v[vx]\>/
syntax match   riscvInstruction /\<vwmaccsu\.v[vx]\>/
syntax keyword riscvInstruction vwmaccus.vx
syntax match   riscvInstruction /\<vmerge\.v[vxi]m\>/
syntax match   riscvInstruction /\<vmv\.v\.[vxi]\>/

syntax match   riscvInstruction /\<vsaddu\?\.v[vxi]\>/
syntax match   riscvInstruction /\<vaaddu\?\.v[vx]\>/
syntax match   riscvInstruction /\<v[as]subu\?\.v[vx]\>/
syntax match   riscvInstruction /\<vsmul\.v[vx]\>/
syntax match   riscvInstruction /\<vssr[la]\.v[vxi]\>/
syntax match   riscvInstruction /\<vnclipu\?\.w[vxi]\>/

syntax match   riscvInstruction /\<vfadd\.v[vf]\>/
syntax match   riscvInstruction /\<vfsub\.v[vf]\>/
syntax keyword riscvInstruction vfrsub.vf
syntax match   riscvInstruction /\<vfwadd\.[wv][vf]\>/
syntax match   riscvInstruction /\<vfwsub\.[wv][vf]\>/
syntax match   riscvInstruction /\<vfmul\.v[vf]\>/
syntax match   riscvInstruction /\<vfdiv\.v[vf]\>/
syntax keyword riscvInstruction vfrdiv.vf
syntax match   riscvInstruction /\<vfwmul\.v[vf]\>/
syntax match   riscvInstruction /\<vfw\?n\?macc\.v[vf]\>/
syntax match   riscvInstruction /\<vfw\?n\?msac\.v[vf]\>/
syntax match   riscvInstruction /\<vfn\?madd\.v[vf]\>/
syntax match   riscvInstruction /\<vfn\?msub\.v[vf]\>/
syntax keyword riscvInstruction vfsqrt.v vfrsqrt7.v vfrsqrte7.v
syntax keyword riscvInstruction vfrec7.v vfrece7.v
syntax match   riscvInstruction /\<vfmin\.v[vf]\>/
syntax match   riscvInstruction /\<vfmax\.v[vf]\>/
syntax match   riscvInstruction /\<vfsgnj[nx]\?\.v[vf]\>/
syntax keyword riscvInstruction vfneg.v vfabs.v
syntax match   riscvInstruction /\<vmfeq\.v[vf]\>/
syntax match   riscvInstruction /\<vmfne\.v[vf]\>/
syntax match   riscvInstruction /\<vmfl[te]\.v[vf]\>/
" The .vv variants are provided as Pseudoinstructions
syntax match   riscvInstruction /\<vmfg[te]\.v[vf]\>/
syntax keyword riscvInstruction vfclass.v
syntax keyword riscvInstruction vfmerge.vfm
syntax keyword riscvInstruction vfmv.v.f
syntax keyword riscvInstruction vfcvt.xu.f.v vfcvt.x.f.v
syntax keyword riscvInstruction vfcvt.rtz.xu.f.v vfcvt.rtz.x.f.v
syntax keyword riscvInstruction vfcvt.f.xu.v vfcvt.f.x.v
syntax keyword riscvInstruction vfwcvt.xu.f.v vfwcvt.x.f.v
syntax keyword riscvInstruction vfwcvt.rtz.xu.f.v vfwcvt.rtz.x.f.v
syntax keyword riscvInstruction vfwcvt.f.xu.v vfwcvt.f.x.v vfwcvt.f.f.v
syntax keyword riscvInstruction vfncvt.xu.f.w vfncvt.x.f.w
syntax keyword riscvInstruction vfncvt.rtz.xu.f.w vfncvt.rtz.x.f.w
syntax keyword riscvInstruction vfncvt.f.xu.w vfncvt.f.x.w
syntax keyword riscvInstruction vfncvt.f.f.w vfncvt.rod.f.f.w

syntax keyword riscvInstruction vredsum.vs vredmaxu.vs vredmax.vs vredminu.vs vredmin.vs
syntax keyword riscvInstruction vredand.vs vredor.vs vredxor.vs
syntax keyword riscvInstruction vwredsumu.vs vwredsum.vs
syntax match   riscvInstruction /\<vfw\?red[ou]\?sum\.vs\>/
syntax keyword riscvInstruction vfredmax.vs vfredmin.vs

syntax keyword riscvInstruction vmand.mm vmnand.mm vmandn.mm
syntax keyword riscvInstruction vmxor.mm vmor.mm vmnor.mm vmorn.mm vmxnor.mm
syntax keyword riscvInstruction vmandnot.mm vmornot.mm
syntax keyword riscvInstruction vmmv.m vmclr.m cmset.m vmnot.m vmcpy.m
syntax keyword riscvInstruction vcpop.m vpopc.m
syntax keyword riscvInstruction vfirst.m
syntax keyword riscvInstruction vmsbf.m
syntax keyword riscvInstruction vmsif.m
syntax keyword riscvInstruction vmsof.m
syntax keyword riscvInstruction viota.m
syntax keyword riscvInstruction vid.v

syntax keyword riscvInstruction vmv.x.s vmv.s.x
syntax keyword riscvInstruction vfmv.f.s vfmv.s.f
syntax keyword riscvInstruction vslideup.vx vslideup.vi
syntax keyword riscvInstruction vslidedown.vx vslidedown.vi
syntax keyword riscvInstruction vslide1up.vx vfslide1up.vf
syntax keyword riscvInstruction vslide1down.vx vfslide1down.vf
syntax match   riscvInstruction /\<vrgather\.v[vxi]\>/
syntax keyword riscvInstruction vrgatherei16.vv
syntax keyword riscvInstruction vcompress.vm
syntax match   riscvInstruction /\<vmv[1248]r\.v\>/

" pseudo-instructions
syntax keyword riscvInstruction li la lla lga
syntax keyword riscvInstruction subi
syntax keyword riscvInstruction nop mv
syntax keyword riscvInstruction not neg negw
syntax keyword riscvInstruction sext.b sext.h sext.w zext.b zext.h zext.w
syntax keyword riscvInstruction seqz snez sltz sgtz
syntax keyword riscvInstruction fmv.s fabs.s fneg.s
syntax keyword riscvInstruction fmv.d fabs.d fneg.d
syntax keyword riscvInstruction fmv.q fabs.q fneg.q
syntax keyword riscvInstruction beqz bnez blez bgez bltz bgtz bgt ble bgtu bleu
syntax keyword riscvInstruction j jr ret call tail jump

" The unimp/c.unimp instruction should almost always trap
syntax keyword riscvDebug unimp c.unimp

" Option Values
syntax keyword riscvOption rvc norvc
syntax keyword riscvOption pic nopic
syntax keyword riscvOption relax norelax
syntax keyword riscvOption push pop

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
hi def link riscvChar           Character
hi def link riscvRegister       Type
hi def link riscvCSRegister     Function
hi def link riscvBadRegister    Error
hi def link riscvLabel          Label
hi def link riscvDirective      Preproc
hi def link riscvInstruction    Keyword
hi def link riscvDebug          Debug
hi def link riscvOption         Identifier
hi def link riscvLabelRef       Identifier

let b:current_syntax = "riscv"
