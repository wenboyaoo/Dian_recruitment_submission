	.file	"vending_machine.c"
	.text
	.globl	state
	.bss
	.align 4
state:
	.space 4
	.globl	operation
	.align 4
operation:
	.space 4
	.globl	validity
	.align 4
validity:
	.space 4
	.globl	rewindcount
	.align 4
rewindcount:
	.space 4
	.globl	memoswitch
	.align 4
memoswitch:
	.space 4
	.globl	memo
	.align 32
memo:
	.space 384
	.globl	tmpint
	.align 4
tmpint:
	.space 4
	.globl	tmpint1
	.align 4
tmpint1:
	.space 4
	.globl	tmpint2
	.align 4
tmpint2:
	.space 4
	.globl	tmpint3
	.align 4
tmpint3:
	.space 4
	.globl	item
item:
	.space 6
	.globl	price
	.align 16
price:
	.space 24
	.globl	quantity
	.align 16
quantity:
	.space 24
	.globl	tmpchar
tmpchar:
	.space 1
	.globl	cost
	.align 4
cost:
	.space 4
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	call	__main
.L10:
	movl	state(%rip), %eax
	cmpl	$3, %eax
	je	.L2
	call	eventcheck
.L2:
	movl	validity(%rip), %eax
	cmpl	$1, %eax
	jne	.L10
	movl	state(%rip), %eax
	cmpl	$3, %eax
	je	.L4
	cmpl	$3, %eax
	jg	.L5
	cmpl	$2, %eax
	je	.L6
	cmpl	$2, %eax
	jg	.L5
	testl	%eax, %eax
	je	.L7
	cmpl	$1, %eax
	je	.L8
	jmp	.L5
.L7:
	call	place
	jmp	.L5
.L8:
	call	select
	jmp	.L5
.L6:
	call	pay
	jmp	.L5
.L4:
	call	change
	nop
.L5:
	movl	memoswitch(%rip), %eax
	testl	%eax, %eax
	jne	.L9
	movl	$1, memo(%rip)
	movl	$2, 4+memo(%rip)
	movl	$1, memoswitch(%rip)
.L9:
	call	memowind
	jmp	.L10
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "%4s\0"
.LC1:
	.ascii "END\0"
.LC2:
	.ascii "\345\275\223\345\211\215\346\255\245\351\252\244\344\270\215\350\203\275\350\267\263\350\277\207,\0"
	.align 8
.LC3:
	.ascii "\346\223\215\344\275\234\345\220\216\346\211\215\350\203\275\350\277\233\350\241\214\344\270\213\344\270\200\346\255\245\357\274\214\0"
.LC4:
	.ascii "BACK\0"
	.align 8
.LC5:
	.ascii "\350\276\223\345\205\245\351\224\231\350\257\257\357\274\214\350\257\267\351\207\215\346\226\260\350\276\223\345\205\245\343\200\202\0"
	.text
	.globl	eventcheck
	.def	eventcheck;	.scl	2;	.type	32;	.endef
	.seh_proc	eventcheck
eventcheck:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movl	$0, validity(%rip)
	movl	$0, tmpint3(%rip)
	movb	$0, tmpchar(%rip)
	movl	state(%rip), %eax
	cmpl	$-1, %eax
	jne	.L12
	movl	state(%rip), %eax
	addl	$1, %eax
	movl	%eax, state(%rip)
.L12:
	leaq	-5(%rbp), %rax
	movq	%rax, %rdx
	leaq	.LC0(%rip), %rax
	movq	%rax, %rcx
	call	scanf
	cmpl	$1, %eax
	jne	.L13
	leaq	-5(%rbp), %rax
	leaq	.LC1(%rip), %rdx
	movq	%rax, %rcx
	call	strcmp
	testl	%eax, %eax
	jne	.L14
	movl	state(%rip), %eax
	cmpl	$1, %eax
	jle	.L15
	leaq	.LC2(%rip), %rax
	movq	%rax, %rcx
	call	printf
	jmp	.L14
.L15:
	movl	operation(%rip), %eax
	testl	%eax, %eax
	jne	.L16
	leaq	.LC3(%rip), %rax
	movq	%rax, %rcx
	call	printf
	jmp	.L14
.L16:
	movl	state(%rip), %eax
	addl	$1, %eax
	movl	%eax, state(%rip)
	movl	$0, operation(%rip)
	movl	$2, validity(%rip)
	call	clear_buffer
	call	memowind
.L14:
	leaq	-5(%rbp), %rax
	leaq	.LC4(%rip), %rdx
	movq	%rax, %rcx
	call	strcmp
	testl	%eax, %eax
	jne	.L17
	call	memorewind
	call	clear_buffer
.L17:
	leaq	-5(%rbp), %rax
	movq	%rax, %rcx
	call	strlen
	cmpq	$1, %rax
	jne	.L13
	movzbl	-5(%rbp), %eax
	cmpb	$64, %al
	jle	.L18
	movzbl	-5(%rbp), %eax
	cmpb	$90, %al
	jg	.L18
	movzbl	-5(%rbp), %eax
	movb	%al, tmpchar(%rip)
	movl	$1, validity(%rip)
.L18:
	movzbl	-5(%rbp), %eax
	cmpb	$47, %al
	jle	.L13
	movzbl	-5(%rbp), %eax
	cmpb	$57, %al
	jg	.L13
	movl	state(%rip), %eax
	cmpl	$2, %eax
	jne	.L13
	movzbl	-5(%rbp), %eax
	movsbl	%al, %eax
	subl	$48, %eax
	movl	%eax, tmpint(%rip)
	movl	$1, validity(%rip)
.L13:
	movl	validity(%rip), %eax
	testl	%eax, %eax
	jne	.L20
	leaq	.LC5(%rip), %rax
	movq	%rax, %rcx
	call	puts
	call	clear_buffer
.L20:
	nop
	addq	$48, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	memowind
	.def	memowind;	.scl	2;	.type	32;	.endef
	.seh_proc	memowind
memowind:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movl	$0, -4(%rbp)
	jmp	.L22
.L27:
	movl	$0, -8(%rbp)
	jmp	.L23
.L26:
	movl	$3, -12(%rbp)
	jmp	.L24
.L25:
	movl	-12(%rbp), %eax
	subl	$1, %eax
	movl	-8(%rbp), %edx
	movslq	%edx, %r8
	cltq
	movl	-4(%rbp), %edx
	movslq	%edx, %rcx
	movq	%rax, %rdx
	addq	%rdx, %rdx
	addq	%rax, %rdx
	leaq	0(,%rdx,8), %rax
	movq	%rax, %rdx
	movq	%rcx, %rax
	addq	%rax, %rax
	addq	%rcx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%r8, %rax
	leaq	0(,%rax,4), %rdx
	leaq	memo(%rip), %rax
	movl	(%rdx,%rax), %r8d
	movl	-8(%rbp), %eax
	movslq	%eax, %r9
	movl	-12(%rbp), %eax
	cltq
	movl	-4(%rbp), %edx
	movslq	%edx, %rcx
	movq	%rax, %rdx
	addq	%rdx, %rdx
	addq	%rax, %rdx
	leaq	0(,%rdx,8), %rax
	movq	%rax, %rdx
	movq	%rcx, %rax
	addq	%rax, %rax
	addq	%rcx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%r9, %rax
	leaq	0(,%rax,4), %rdx
	leaq	memo(%rip), %rax
	movl	%r8d, (%rdx,%rax)
	subl	$1, -12(%rbp)
.L24:
	cmpl	$0, -12(%rbp)
	jg	.L25
	addl	$1, -8(%rbp)
.L23:
	cmpl	$5, -8(%rbp)
	jle	.L26
	addl	$1, -4(%rbp)
.L22:
	cmpl	$3, -4(%rbp)
	jle	.L27
	movl	$1, memo(%rip)
	movl	state(%rip), %eax
	cmpl	$3, %eax
	jne	.L28
	movl	$1, 4+memo(%rip)
.L28:
	movl	state(%rip), %eax
	movl	%eax, 8+memo(%rip)
	movl	operation(%rip), %eax
	movl	%eax, 12+memo(%rip)
	movl	cost(%rip), %eax
	movl	%eax, 16+memo(%rip)
	movl	tmpint(%rip), %eax
	movl	%eax, 116+memo(%rip)
	movl	$1, -16(%rbp)
	jmp	.L29
.L30:
	movl	-16(%rbp), %eax
	cltq
	leaq	item(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	movsbl	%al, %eax
	movl	-16(%rbp), %edx
	movslq	%edx, %rdx
	addq	$6, %rdx
	leaq	0(,%rdx,4), %rcx
	leaq	memo(%rip), %rdx
	movl	%eax, (%rcx,%rdx)
	addl	$1, -16(%rbp)
.L29:
	cmpl	$5, -16(%rbp)
	jle	.L30
	movl	$1, -20(%rbp)
	jmp	.L31
.L32:
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	price(%rip), %rax
	movl	(%rdx,%rax), %ecx
	movl	-20(%rbp), %eax
	cltq
	addq	$12, %rax
	leaq	0(,%rax,4), %rdx
	leaq	memo(%rip), %rax
	movl	%ecx, (%rdx,%rax)
	addl	$1, -20(%rbp)
.L31:
	cmpl	$5, -20(%rbp)
	jle	.L32
	movl	$1, -24(%rbp)
	jmp	.L33
.L34:
	movl	-24(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	quantity(%rip), %rax
	movl	(%rdx,%rax), %ecx
	movl	-24(%rbp), %eax
	cltq
	addq	$18, %rax
	leaq	0(,%rax,4), %rdx
	leaq	memo(%rip), %rax
	movl	%ecx, (%rdx,%rax)
	addl	$1, -24(%rbp)
.L33:
	cmpl	$5, -24(%rbp)
	jle	.L34
	nop
	nop
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC6:
	.ascii "\345\233\236\351\200\200\346\254\241\346\225\260\345\267\262\347\273\217\350\276\276\345\210\260\344\270\212\351\231\220\357\274\214\344\270\215\350\203\275\345\233\236\351\200\200\343\200\202\0"
.LC7:
	.ascii "\346\262\241\346\234\211\345\217\257\345\233\236\351\200\200\347\232\204\346\223\215\344\275\234\343\200\202\0"
.LC8:
	.ascii "\350\257\245\346\223\215\344\275\234\344\270\215\350\203\275\345\233\236\351\200\200\343\200\202\0"
.LC9:
	.ascii "%d\12\0"
	.text
	.globl	memorewind
	.def	memorewind;	.scl	2;	.type	32;	.endef
	.seh_proc	memorewind
memorewind:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$64, %rsp
	.seh_stackalloc	64
	.seh_endprologue
	movl	rewindcount(%rip), %eax
	cmpl	$2, %eax
	jle	.L36
	leaq	.LC6(%rip), %rax
	movq	%rax, %rcx
	call	puts
	jmp	.L37
.L36:
	movl	96+memo(%rip), %eax
	testl	%eax, %eax
	jne	.L38
	leaq	.LC7(%rip), %rax
	movq	%rax, %rcx
	call	puts
	jmp	.L37
.L38:
	movl	100+memo(%rip), %eax
	cmpl	$1, %eax
	jne	.L39
	leaq	.LC8(%rip), %rax
	movq	%rax, %rcx
	call	puts
	jmp	.L37
.L39:
	movl	96+memo(%rip), %eax
	cmpl	$1, %eax
	jne	.L37
	movl	100+memo(%rip), %eax
	cmpl	$1, %eax
	jne	.L40
	leaq	.LC8(%rip), %rax
	movq	%rax, %rcx
	call	puts
.L40:
	movl	104+memo(%rip), %eax
	movl	%eax, state(%rip)
	movl	108+memo(%rip), %eax
	movl	%eax, operation(%rip)
	movl	112+memo(%rip), %eax
	movl	%eax, cost(%rip)
	movl	116+memo(%rip), %eax
	testl	%eax, %eax
	je	.L41
	movl	116+memo(%rip), %eax
	movl	%eax, %edx
	leaq	.LC9(%rip), %rax
	movq	%rax, %rcx
	call	printf
.L41:
	movl	$1, -4(%rbp)
	jmp	.L42
.L43:
	movl	-4(%rbp), %eax
	cltq
	addq	$30, %rax
	leaq	0(,%rax,4), %rdx
	leaq	memo(%rip), %rax
	movl	(%rdx,%rax), %eax
	movl	%eax, %ecx
	movl	-4(%rbp), %eax
	cltq
	leaq	item(%rip), %rdx
	movb	%cl, (%rax,%rdx)
	addl	$1, -4(%rbp)
.L42:
	cmpl	$5, -4(%rbp)
	jle	.L43
	movl	$1, -8(%rbp)
	jmp	.L44
.L45:
	movl	-8(%rbp), %eax
	cltq
	addq	$36, %rax
	leaq	0(,%rax,4), %rdx
	leaq	memo(%rip), %rax
	movl	(%rdx,%rax), %ecx
	movl	-8(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	price(%rip), %rax
	movl	%ecx, (%rdx,%rax)
	addl	$1, -8(%rbp)
.L44:
	cmpl	$5, -8(%rbp)
	jle	.L45
	movl	$1, -12(%rbp)
	jmp	.L46
.L47:
	movl	-12(%rbp), %eax
	cltq
	addq	$42, %rax
	leaq	0(,%rax,4), %rdx
	leaq	memo(%rip), %rax
	movl	(%rdx,%rax), %ecx
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	quantity(%rip), %rax
	movl	%ecx, (%rdx,%rax)
	addl	$1, -12(%rbp)
.L46:
	cmpl	$5, -12(%rbp)
	jle	.L47
.L37:
	movl	$0, -16(%rbp)
	jmp	.L48
.L53:
	movl	$0, -20(%rbp)
	jmp	.L49
.L52:
	movl	$0, -24(%rbp)
	jmp	.L50
.L51:
	movl	-24(%rbp), %eax
	addl	$1, %eax
	movl	-20(%rbp), %edx
	movslq	%edx, %r8
	cltq
	movl	-16(%rbp), %edx
	movslq	%edx, %rcx
	movq	%rax, %rdx
	addq	%rdx, %rdx
	addq	%rax, %rdx
	leaq	0(,%rdx,8), %rax
	movq	%rax, %rdx
	movq	%rcx, %rax
	addq	%rax, %rax
	addq	%rcx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%r8, %rax
	leaq	0(,%rax,4), %rdx
	leaq	memo(%rip), %rax
	movl	(%rdx,%rax), %r8d
	movl	-20(%rbp), %eax
	movslq	%eax, %r9
	movl	-24(%rbp), %eax
	cltq
	movl	-16(%rbp), %edx
	movslq	%edx, %rcx
	movq	%rax, %rdx
	addq	%rdx, %rdx
	addq	%rax, %rdx
	leaq	0(,%rdx,8), %rax
	movq	%rax, %rdx
	movq	%rcx, %rax
	addq	%rax, %rax
	addq	%rcx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%r9, %rax
	leaq	0(,%rax,4), %rdx
	leaq	memo(%rip), %rax
	movl	%r8d, (%rdx,%rax)
	addl	$1, -24(%rbp)
.L50:
	cmpl	$2, -24(%rbp)
	jle	.L51
	addl	$1, -20(%rbp)
.L49:
	cmpl	$5, -20(%rbp)
	jle	.L52
	addl	$1, -16(%rbp)
.L48:
	cmpl	$3, -16(%rbp)
	jle	.L53
	movl	$3, -28(%rbp)
	jmp	.L54
.L58:
	movl	-28(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$5, %rax
	movq	%rax, %rdx
	leaq	memo(%rip), %rax
	movl	(%rdx,%rax), %eax
	cmpl	$1, %eax
	jne	.L55
	movl	-28(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$5, %rax
	movq	%rax, %rdx
	leaq	4+memo(%rip), %rax
	movl	(%rdx,%rax), %eax
	cmpl	$2, %eax
	je	.L59
	movl	-28(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$5, %rax
	movq	%rax, %rdx
	leaq	memo(%rip), %rax
	movl	$0, (%rdx,%rax)
	jmp	.L57
.L55:
	subl	$1, -28(%rbp)
.L54:
	cmpl	$0, -28(%rbp)
	jns	.L58
	jmp	.L57
.L59:
	nop
.L57:
	movl	rewindcount(%rip), %eax
	addl	$1, %eax
	movl	%eax, rewindcount(%rip)
	movl	$3, validity(%rip)
	nop
	addq	$64, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC10:
	.ascii "%d %d %d\0"
.LC11:
	.ascii "\351\200\232\351\201\223\347\274\226\345\217\267\351\224\231\350\257\257\357\274\214\0"
.LC12:
	.ascii "\350\257\245\351\200\232\351\201\223\345\267\262\350\242\253\345\215\240\347\224\250\357\274\214\0"
	.align 8
.LC13:
	.ascii "\344\273\267\346\240\274\344\270\215\345\234\250\350\247\204\345\256\232\350\214\203\345\233\264\345\206\205\357\274\214\0"
	.align 8
.LC14:
	.ascii "\346\225\260\351\207\217\344\270\215\345\234\250\350\247\204\345\256\232\350\214\203\345\233\264\345\206\205\357\274\214\0"
.LC15:
	.ascii "\350\257\267\351\207\215\346\226\260\350\276\223\345\205\245\343\200\202\0"
	.text
	.globl	place
	.def	place;	.scl	2;	.type	32;	.endef
	.seh_proc	place
place:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movb	$1, -1(%rbp)
	leaq	tmpint3(%rip), %r9
	leaq	tmpint2(%rip), %r8
	leaq	tmpint1(%rip), %rax
	movq	%rax, %rdx
	leaq	.LC10(%rip), %rax
	movq	%rax, %rcx
	call	scanf
	cmpl	$3, %eax
	je	.L61
	movb	$0, -1(%rbp)
	jmp	.L62
.L61:
	movl	tmpint1(%rip), %eax
	testl	%eax, %eax
	jle	.L63
	movl	tmpint1(%rip), %eax
	cmpl	$5, %eax
	jle	.L64
.L63:
	movb	$0, -1(%rbp)
	leaq	.LC11(%rip), %rax
	movq	%rax, %rcx
	call	printf
	jmp	.L65
.L64:
	movl	tmpint1(%rip), %eax
	cltq
	leaq	item(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	testb	%al, %al
	je	.L65
	movb	$0, -1(%rbp)
	leaq	.LC12(%rip), %rax
	movq	%rax, %rcx
	call	printf
.L65:
	movl	tmpint2(%rip), %eax
	testl	%eax, %eax
	js	.L66
	movl	tmpint2(%rip), %eax
	cmpl	$9, %eax
	jle	.L67
.L66:
	movb	$0, -1(%rbp)
	leaq	.LC13(%rip), %rax
	movq	%rax, %rcx
	call	printf
.L67:
	movl	tmpint3(%rip), %eax
	testl	%eax, %eax
	jle	.L68
	movl	tmpint3(%rip), %eax
	cmpl	$50, %eax
	jle	.L62
.L68:
	movb	$0, -1(%rbp)
	leaq	.LC14(%rip), %rax
	movq	%rax, %rcx
	call	printf
.L62:
	cmpb	$0, -1(%rbp)
	je	.L69
	movl	tmpint1(%rip), %edx
	movzbl	tmpchar(%rip), %eax
	movslq	%edx, %rdx
	leaq	item(%rip), %rcx
	movb	%al, (%rdx,%rcx)
	movl	tmpint1(%rip), %eax
	movl	tmpint2(%rip), %ecx
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	price(%rip), %rax
	movl	%ecx, (%rdx,%rax)
	movl	tmpint1(%rip), %eax
	movl	tmpint3(%rip), %ecx
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	quantity(%rip), %rax
	movl	%ecx, (%rdx,%rax)
	movl	operation(%rip), %eax
	addl	$1, %eax
	movl	%eax, operation(%rip)
	jmp	.L70
.L69:
	leaq	.LC15(%rip), %rax
	movq	%rax, %rcx
	call	puts
.L70:
	call	clear_buffer
	nop
	addq	$48, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC16:
	.ascii "%d %d\0"
.LC17:
	.ascii "\350\276\223\345\205\245\351\224\231\350\257\257\357\274\214\0"
.LC18:
	.ascii "\350\257\245\351\200\232\351\201\223\344\270\215\345\255\230\345\234\250\357\274\214\0"
.LC19:
	.ascii "\350\257\245\351\200\232\351\201\223\346\262\241\346\234\211\345\225\206\345\223\201\357\274\214\0"
	.align 8
.LC20:
	.ascii "\351\200\211\346\213\251\347\232\204\345\225\206\345\223\201\344\270\216\351\200\232\351\201\223\345\206\205\345\225\206\345\223\201\344\270\215\345\220\214\357\274\214\0"
	.align 8
.LC21:
	.ascii "\346\227\240\346\263\225\350\264\255\344\271\260\350\277\231\344\270\200\346\225\260\351\207\217\347\232\204\345\225\206\345\223\201\357\274\214\0"
	.text
	.globl	select
	.def	select;	.scl	2;	.type	32;	.endef
	.seh_proc	select
select:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movb	$1, -1(%rbp)
	leaq	tmpint2(%rip), %r8
	leaq	tmpint1(%rip), %rax
	movq	%rax, %rdx
	leaq	.LC16(%rip), %rax
	movq	%rax, %rcx
	call	scanf
	cmpl	$2, %eax
	je	.L72
	leaq	.LC17(%rip), %rax
	movq	%rax, %rcx
	call	printf
	movb	$0, -1(%rbp)
	jmp	.L73
.L72:
	movl	tmpint1(%rip), %eax
	testl	%eax, %eax
	jle	.L74
	movl	tmpint1(%rip), %eax
	cmpl	$5, %eax
	jle	.L75
.L74:
	movb	$0, -1(%rbp)
	leaq	.LC18(%rip), %rax
	movq	%rax, %rcx
	call	printf
	jmp	.L76
.L75:
	movl	tmpint1(%rip), %eax
	cltq
	leaq	item(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	testb	%al, %al
	jne	.L77
	movb	$0, -1(%rbp)
	leaq	.LC19(%rip), %rax
	movq	%rax, %rcx
	call	printf
	jmp	.L76
.L77:
	movl	tmpint1(%rip), %eax
	cltq
	leaq	item(%rip), %rdx
	movzbl	(%rax,%rdx), %edx
	movzbl	tmpchar(%rip), %eax
	cmpb	%al, %dl
	je	.L76
	movb	$0, -1(%rbp)
	leaq	.LC20(%rip), %rax
	movq	%rax, %rcx
	call	printf
.L76:
	cmpb	$0, -1(%rbp)
	je	.L73
	movl	tmpint2(%rip), %eax
	testl	%eax, %eax
	jle	.L78
	movl	tmpint1(%rip), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	quantity(%rip), %rax
	movl	(%rdx,%rax), %edx
	movl	tmpint2(%rip), %eax
	cmpl	%eax, %edx
	jge	.L73
.L78:
	movb	$0, -1(%rbp)
	leaq	.LC21(%rip), %rax
	movq	%rax, %rcx
	call	printf
.L73:
	cmpb	$0, -1(%rbp)
	je	.L79
	movl	tmpint1(%rip), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	price(%rip), %rax
	movl	(%rdx,%rax), %edx
	movl	tmpint2(%rip), %eax
	imull	%edx, %eax
	movl	cost(%rip), %edx
	addl	%edx, %eax
	movl	%eax, cost(%rip)
	movl	tmpint1(%rip), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	quantity(%rip), %rax
	movl	(%rdx,%rax), %ecx
	movl	tmpint2(%rip), %eax
	movl	tmpint1(%rip), %edx
	subl	%eax, %ecx
	movslq	%edx, %rax
	leaq	0(,%rax,4), %rdx
	leaq	quantity(%rip), %rax
	movl	%ecx, (%rdx,%rax)
	movl	operation(%rip), %eax
	addl	$1, %eax
	movl	%eax, operation(%rip)
	movl	tmpint1(%rip), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	quantity(%rip), %rax
	movl	(%rdx,%rax), %eax
	testl	%eax, %eax
	jne	.L80
	movl	tmpint1(%rip), %eax
	cltq
	leaq	item(%rip), %rdx
	movb	$0, (%rax,%rdx)
	movl	tmpint1(%rip), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	price(%rip), %rax
	movl	$0, (%rdx,%rax)
	jmp	.L80
.L79:
	leaq	.LC15(%rip), %rax
	movq	%rax, %rcx
	call	puts
.L80:
	call	clear_buffer
	nop
	addq	$48, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC22:
	.ascii "%d\12\346\212\225\345\270\201\351\235\242\351\242\235\351\224\231\350\257\257\357\274\214\350\257\267\351\207\215\346\226\260\350\276\223\345\205\245\343\200\202\12\0"
	.text
	.globl	pay
	.def	pay;	.scl	2;	.type	32;	.endef
	.seh_proc	pay
pay:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movl	tmpint(%rip), %eax
	cmpl	$1, %eax
	je	.L82
	movl	tmpint(%rip), %eax
	cmpl	$2, %eax
	je	.L82
	movl	tmpint(%rip), %eax
	cmpl	$5, %eax
	jne	.L83
.L82:
	movl	cost(%rip), %eax
	movl	tmpint(%rip), %edx
	subl	%edx, %eax
	movl	%eax, cost(%rip)
	movl	operation(%rip), %eax
	addl	$1, %eax
	movl	%eax, operation(%rip)
	jmp	.L84
.L83:
	movl	tmpint(%rip), %eax
	movl	%eax, %edx
	leaq	.LC22(%rip), %rax
	movq	%rax, %rcx
	call	printf
.L84:
	movl	cost(%rip), %eax
	testl	%eax, %eax
	jg	.L85
	movl	state(%rip), %eax
	addl	$1, %eax
	movl	%eax, state(%rip)
.L85:
	call	clear_buffer
	nop
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	change
	.def	change;	.scl	2;	.type	32;	.endef
	.seh_proc	change
change:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	jmp	.L87
.L91:
	movl	cost(%rip), %eax
	cmpl	$-4, %eax
	jge	.L88
	movl	$5, %edx
	leaq	.LC9(%rip), %rax
	movq	%rax, %rcx
	call	printf
	movl	cost(%rip), %eax
	addl	$5, %eax
	movl	%eax, cost(%rip)
	jmp	.L87
.L88:
	movl	cost(%rip), %eax
	cmpl	$-1, %eax
	jge	.L89
	movl	$2, %edx
	leaq	.LC9(%rip), %rax
	movq	%rax, %rcx
	call	printf
	movl	cost(%rip), %eax
	addl	$2, %eax
	movl	%eax, cost(%rip)
	jmp	.L87
.L89:
	movl	$1, %edx
	leaq	.LC9(%rip), %rax
	movq	%rax, %rcx
	call	printf
	movl	cost(%rip), %eax
	addl	$1, %eax
	movl	%eax, cost(%rip)
	jmp	.L90
.L87:
	movl	cost(%rip), %eax
	testl	%eax, %eax
	js	.L91
.L90:
	movl	$1, state(%rip)
	nop
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	clear_buffer
	.def	clear_buffer;	.scl	2;	.type	32;	.endef
	.seh_proc	clear_buffer
clear_buffer:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	jmp	.L93
.L94:
	nop
.L93:
	call	getchar
	cmpl	$10, %eax
	jne	.L94
	nop
	nop
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (x86_64-mcf-seh-rev0, Built by MinGW-Builds project) 14.2.0"
	.def	scanf;	.scl	2;	.type	32;	.endef
	.def	strcmp;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	strlen;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
