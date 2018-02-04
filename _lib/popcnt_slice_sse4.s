	.text
	.intel_syntax noprefix
	.file	"_lib/popcnt_slice.c"
	.globl	popcnt_slice_sse4
	.p2align	4, 0x90
	.type	popcnt_slice_sse4,@function
popcnt_slice_sse4:                      # @popcnt_slice_sse4
# BB#0:
	push	rbp
	mov	rbp, rsp
	and	rsp, -8
	xor	ecx, ecx
	test	rsi, rsi
	jle	.LBB0_7
# BB#1:
	lea	r9, [rdi + 8*rsi]
	lea	rsi, [rdi + 8]
	cmp	r9, rsi
	cmova	rsi, r9
	mov	r8, rdi
	not	r8
	add	r8, rsi
	mov	esi, r8d
	shr	esi, 3
	inc	esi
	and	rsi, 7
	je	.LBB0_4
# BB#2:
	neg	rsi
	xor	ecx, ecx
	.p2align	4, 0x90
.LBB0_3:                                # =>This Inner Loop Header: Depth=1
	popcnt	rax, qword ptr [rdi]
	add	ecx, eax
	add	rdi, 8
	inc	rsi
	jne	.LBB0_3
.LBB0_4:
	cmp	r8, 56
	jb	.LBB0_6
	.p2align	4, 0x90
.LBB0_5:                                # =>This Inner Loop Header: Depth=1
	popcnt	rax, qword ptr [rdi]
	add	eax, ecx
	popcnt	rcx, qword ptr [rdi + 8]
	add	ecx, eax
	popcnt	rax, qword ptr [rdi + 16]
	add	eax, ecx
	popcnt	rcx, qword ptr [rdi + 24]
	add	ecx, eax
	popcnt	rax, qword ptr [rdi + 32]
	add	eax, ecx
	popcnt	rcx, qword ptr [rdi + 40]
	add	ecx, eax
	popcnt	rax, qword ptr [rdi + 48]
	add	eax, ecx
	popcnt	rcx, qword ptr [rdi + 56]
	add	ecx, eax
	add	rdi, 64
	cmp	rdi, r9
	jb	.LBB0_5
.LBB0_6:
	movsxd	rcx, ecx
.LBB0_7:
	mov	qword ptr [rdx], rcx
	mov	rsp, rbp
	pop	rbp
	ret
.Lfunc_end0:
	.size	popcnt_slice_sse4, .Lfunc_end0-popcnt_slice_sse4

	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4
.LCPI1_0:
	.zero	16,15
.LCPI1_1:
	.byte	0                       # 0x0
	.byte	1                       # 0x1
	.byte	1                       # 0x1
	.byte	2                       # 0x2
	.byte	1                       # 0x1
	.byte	2                       # 0x2
	.byte	2                       # 0x2
	.byte	3                       # 0x3
	.byte	1                       # 0x1
	.byte	2                       # 0x2
	.byte	2                       # 0x2
	.byte	3                       # 0x3
	.byte	2                       # 0x2
	.byte	3                       # 0x3
	.byte	3                       # 0x3
	.byte	4                       # 0x4
	.text
	.globl	popcnt_mask_slice_sse4
	.p2align	4, 0x90
	.type	popcnt_mask_slice_sse4,@function
popcnt_mask_slice_sse4:                 # @popcnt_mask_slice_sse4
# BB#0:
	push	rbp
	mov	rbp, rsp
	and	rsp, -8
	xor	r9d, r9d
	test	rdx, rdx
	je	.LBB1_11
# BB#1:
	cmp	rdx, 3
	ja	.LBB1_5
# BB#2:
	xor	r8d, r8d
	jmp	.LBB1_3
.LBB1_5:
	mov	r8, rdx
	and	r8, -4
	je	.LBB1_6
# BB#7:
	lea	r9, [rdi + 16]
	lea	rax, [rsi + 16]
	pxor	xmm8, xmm8
	movdqa	xmm1, xmmword ptr [rip + .LCPI1_0] # xmm1 = [15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15]
	movdqa	xmm3, xmmword ptr [rip + .LCPI1_1] # xmm3 = [0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4]
	mov	r10, r8
	pxor	xmm4, xmm4
	pxor	xmm2, xmm2
	.p2align	4, 0x90
.LBB1_8:                                # =>This Inner Loop Header: Depth=1
	movdqu	xmm5, xmmword ptr [r9 - 16]
	movdqu	xmm6, xmmword ptr [r9]
	movdqu	xmm7, xmmword ptr [rax - 16]
	movdqu	xmm0, xmmword ptr [rax]
	pandn	xmm7, xmm5
	pandn	xmm0, xmm6
	movdqa	xmm5, xmm7
	pand	xmm5, xmm1
	movdqa	xmm6, xmm3
	pshufb	xmm6, xmm5
	psrlw	xmm7, 4
	pand	xmm7, xmm1
	movdqa	xmm5, xmm3
	pshufb	xmm5, xmm7
	paddb	xmm5, xmm6
	psadbw	xmm5, xmm8
	movdqa	xmm6, xmm0
	pand	xmm6, xmm1
	movdqa	xmm7, xmm3
	pshufb	xmm7, xmm6
	psrlw	xmm0, 4
	pand	xmm0, xmm1
	movdqa	xmm6, xmm3
	pshufb	xmm6, xmm0
	paddb	xmm6, xmm7
	psadbw	xmm6, xmm8
	paddq	xmm4, xmm5
	paddq	xmm2, xmm6
	add	r9, 32
	add	rax, 32
	add	r10, -4
	jne	.LBB1_8
# BB#9:
	paddq	xmm2, xmm4
	pshufd	xmm0, xmm2, 78          # xmm0 = xmm2[2,3,0,1]
	paddq	xmm0, xmm2
	movd	r9d, xmm0
	cmp	r8, rdx
	jne	.LBB1_3
	jmp	.LBB1_10
.LBB1_6:
	xor	r8d, r8d
	xor	r9d, r9d
.LBB1_3:
	lea	rsi, [rsi + 8*r8]
	lea	rdi, [rdi + 8*r8]
	sub	rdx, r8
	.p2align	4, 0x90
.LBB1_4:                                # =>This Inner Loop Header: Depth=1
	mov	rax, qword ptr [rsi]
	not	rax
	and	rax, qword ptr [rdi]
	popcnt	rax, rax
	add	r9d, eax
	add	rsi, 8
	add	rdi, 8
	dec	rdx
	jne	.LBB1_4
.LBB1_10:
	movsxd	r9, r9d
.LBB1_11:
	mov	qword ptr [rcx], r9
	mov	rsp, rbp
	pop	rbp
	ret
.Lfunc_end1:
	.size	popcnt_mask_slice_sse4, .Lfunc_end1-popcnt_mask_slice_sse4

	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4
.LCPI2_0:
	.zero	16,15
.LCPI2_1:
	.byte	0                       # 0x0
	.byte	1                       # 0x1
	.byte	1                       # 0x1
	.byte	2                       # 0x2
	.byte	1                       # 0x1
	.byte	2                       # 0x2
	.byte	2                       # 0x2
	.byte	3                       # 0x3
	.byte	1                       # 0x1
	.byte	2                       # 0x2
	.byte	2                       # 0x2
	.byte	3                       # 0x3
	.byte	2                       # 0x2
	.byte	3                       # 0x3
	.byte	3                       # 0x3
	.byte	4                       # 0x4
	.text
	.globl	popcnt_and_slice_sse4
	.p2align	4, 0x90
	.type	popcnt_and_slice_sse4,@function
popcnt_and_slice_sse4:                  # @popcnt_and_slice_sse4
# BB#0:
	push	rbp
	mov	rbp, rsp
	and	rsp, -8
	xor	r9d, r9d
	test	rdx, rdx
	je	.LBB2_15
# BB#1:
	cmp	rdx, 3
	ja	.LBB2_5
# BB#2:
	xor	r8d, r8d
	jmp	.LBB2_3
.LBB2_5:
	mov	r8, rdx
	and	r8, -4
	je	.LBB2_6
# BB#7:
	lea	rax, [r8 - 4]
	mov	r9, rax
	shr	r9, 2
	bt	eax, 2
	jb	.LBB2_8
# BB#9:
	movdqu	xmm0, xmmword ptr [rdi]
	movdqu	xmm1, xmmword ptr [rdi + 16]
	movdqu	xmm2, xmmword ptr [rsi]
	movdqu	xmm3, xmmword ptr [rsi + 16]
	pand	xmm2, xmm0
	pand	xmm3, xmm1
	movdqa	xmm4, xmmword ptr [rip + .LCPI2_0] # xmm4 = [15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15]
	movdqa	xmm0, xmm2
	pand	xmm0, xmm4
	movdqa	xmm1, xmmword ptr [rip + .LCPI2_1] # xmm1 = [0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4]
	movdqa	xmm5, xmm1
	pshufb	xmm5, xmm0
	psrlw	xmm2, 4
	pand	xmm2, xmm4
	movdqa	xmm0, xmm1
	pshufb	xmm0, xmm2
	paddb	xmm0, xmm5
	pxor	xmm2, xmm2
	psadbw	xmm0, xmm2
	movdqa	xmm5, xmm3
	pand	xmm5, xmm4
	movdqa	xmm6, xmm1
	pshufb	xmm6, xmm5
	psrlw	xmm3, 4
	pand	xmm3, xmm4
	pshufb	xmm1, xmm3
	paddb	xmm1, xmm6
	psadbw	xmm1, xmm2
	mov	eax, 4
	test	r9, r9
	jne	.LBB2_11
	jmp	.LBB2_13
.LBB2_6:
	xor	r8d, r8d
	xor	r9d, r9d
	jmp	.LBB2_3
.LBB2_8:
	pxor	xmm0, xmm0
	xor	eax, eax
	pxor	xmm1, xmm1
	test	r9, r9
	je	.LBB2_13
.LBB2_11:
	mov	r9, r8
	sub	r9, rax
	lea	r10, [rdi + 8*rax + 48]
	lea	rax, [rsi + 8*rax + 48]
	movdqa	xmm11, xmmword ptr [rip + .LCPI2_0] # xmm11 = [15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15]
	movdqa	xmm12, xmmword ptr [rip + .LCPI2_1] # xmm12 = [0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4]
	pxor	xmm8, xmm8
	.p2align	4, 0x90
.LBB2_12:                               # =>This Inner Loop Header: Depth=1
	movdqu	xmm3, xmmword ptr [r10 - 48]
	movdqu	xmm6, xmmword ptr [r10 - 32]
	movdqu	xmm10, xmmword ptr [r10 - 16]
	movdqu	xmm9, xmmword ptr [r10]
	movdqu	xmm2, xmmword ptr [rax - 48]
	movdqu	xmm4, xmmword ptr [rax - 32]
	movdqu	xmm7, xmmword ptr [rax - 16]
	movdqu	xmm13, xmmword ptr [rax]
	pand	xmm2, xmm3
	pand	xmm4, xmm6
	movdqa	xmm3, xmm2
	pand	xmm3, xmm11
	movdqa	xmm5, xmm12
	pshufb	xmm5, xmm3
	psrlw	xmm2, 4
	pand	xmm2, xmm11
	movdqa	xmm6, xmm12
	pshufb	xmm6, xmm2
	paddb	xmm6, xmm5
	psadbw	xmm6, xmm8
	movdqa	xmm2, xmm4
	pand	xmm2, xmm11
	movdqa	xmm5, xmm12
	pshufb	xmm5, xmm2
	psrlw	xmm4, 4
	pand	xmm4, xmm11
	movdqa	xmm3, xmm12
	pshufb	xmm3, xmm4
	paddb	xmm3, xmm5
	psadbw	xmm3, xmm8
	paddq	xmm6, xmm0
	paddq	xmm3, xmm1
	pand	xmm7, xmm10
	pand	xmm13, xmm9
	movdqa	xmm0, xmm7
	pand	xmm0, xmm11
	movdqa	xmm1, xmm12
	pshufb	xmm1, xmm0
	psrlw	xmm7, 4
	pand	xmm7, xmm11
	movdqa	xmm0, xmm12
	pshufb	xmm0, xmm7
	paddb	xmm0, xmm1
	psadbw	xmm0, xmm8
	movdqa	xmm1, xmm13
	pand	xmm1, xmm11
	movdqa	xmm2, xmm12
	pshufb	xmm2, xmm1
	psrlw	xmm13, 4
	pand	xmm13, xmm11
	movdqa	xmm1, xmm12
	pshufb	xmm1, xmm13
	paddb	xmm1, xmm2
	psadbw	xmm1, xmm8
	paddq	xmm0, xmm6
	paddq	xmm1, xmm3
	add	r10, 64
	add	rax, 64
	add	r9, -8
	jne	.LBB2_12
.LBB2_13:
	paddq	xmm0, xmm1
	pshufd	xmm1, xmm0, 78          # xmm1 = xmm0[2,3,0,1]
	paddq	xmm1, xmm0
	movd	r9d, xmm1
	cmp	r8, rdx
	je	.LBB2_14
.LBB2_3:
	lea	rsi, [rsi + 8*r8]
	lea	rdi, [rdi + 8*r8]
	sub	rdx, r8
	.p2align	4, 0x90
.LBB2_4:                                # =>This Inner Loop Header: Depth=1
	mov	rax, qword ptr [rsi]
	and	rax, qword ptr [rdi]
	popcnt	rax, rax
	add	r9d, eax
	add	rsi, 8
	add	rdi, 8
	dec	rdx
	jne	.LBB2_4
.LBB2_14:
	movsxd	r9, r9d
.LBB2_15:
	mov	qword ptr [rcx], r9
	mov	rsp, rbp
	pop	rbp
	ret
.Lfunc_end2:
	.size	popcnt_and_slice_sse4, .Lfunc_end2-popcnt_and_slice_sse4

	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4
.LCPI3_0:
	.zero	16,15
.LCPI3_1:
	.byte	0                       # 0x0
	.byte	1                       # 0x1
	.byte	1                       # 0x1
	.byte	2                       # 0x2
	.byte	1                       # 0x1
	.byte	2                       # 0x2
	.byte	2                       # 0x2
	.byte	3                       # 0x3
	.byte	1                       # 0x1
	.byte	2                       # 0x2
	.byte	2                       # 0x2
	.byte	3                       # 0x3
	.byte	2                       # 0x2
	.byte	3                       # 0x3
	.byte	3                       # 0x3
	.byte	4                       # 0x4
	.text
	.globl	popcnt_or_slice_sse4
	.p2align	4, 0x90
	.type	popcnt_or_slice_sse4,@function
popcnt_or_slice_sse4:                   # @popcnt_or_slice_sse4
# BB#0:
	push	rbp
	mov	rbp, rsp
	and	rsp, -8
	xor	r9d, r9d
	test	rdx, rdx
	je	.LBB3_15
# BB#1:
	cmp	rdx, 3
	ja	.LBB3_5
# BB#2:
	xor	r8d, r8d
	jmp	.LBB3_3
.LBB3_5:
	mov	r8, rdx
	and	r8, -4
	je	.LBB3_6
# BB#7:
	lea	rax, [r8 - 4]
	mov	r9, rax
	shr	r9, 2
	bt	eax, 2
	jb	.LBB3_8
# BB#9:
	movdqu	xmm0, xmmword ptr [rdi]
	movdqu	xmm1, xmmword ptr [rdi + 16]
	movdqu	xmm2, xmmword ptr [rsi]
	movdqu	xmm3, xmmword ptr [rsi + 16]
	por	xmm2, xmm0
	por	xmm3, xmm1
	movdqa	xmm4, xmmword ptr [rip + .LCPI3_0] # xmm4 = [15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15]
	movdqa	xmm0, xmm2
	pand	xmm0, xmm4
	movdqa	xmm1, xmmword ptr [rip + .LCPI3_1] # xmm1 = [0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4]
	movdqa	xmm5, xmm1
	pshufb	xmm5, xmm0
	psrlw	xmm2, 4
	pand	xmm2, xmm4
	movdqa	xmm0, xmm1
	pshufb	xmm0, xmm2
	paddb	xmm0, xmm5
	pxor	xmm2, xmm2
	psadbw	xmm0, xmm2
	movdqa	xmm5, xmm3
	pand	xmm5, xmm4
	movdqa	xmm6, xmm1
	pshufb	xmm6, xmm5
	psrlw	xmm3, 4
	pand	xmm3, xmm4
	pshufb	xmm1, xmm3
	paddb	xmm1, xmm6
	psadbw	xmm1, xmm2
	mov	eax, 4
	test	r9, r9
	jne	.LBB3_11
	jmp	.LBB3_13
.LBB3_6:
	xor	r8d, r8d
	xor	r9d, r9d
	jmp	.LBB3_3
.LBB3_8:
	pxor	xmm0, xmm0
	xor	eax, eax
	pxor	xmm1, xmm1
	test	r9, r9
	je	.LBB3_13
.LBB3_11:
	mov	r9, r8
	sub	r9, rax
	lea	r10, [rdi + 8*rax + 48]
	lea	rax, [rsi + 8*rax + 48]
	movdqa	xmm11, xmmword ptr [rip + .LCPI3_0] # xmm11 = [15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15]
	movdqa	xmm12, xmmword ptr [rip + .LCPI3_1] # xmm12 = [0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4]
	pxor	xmm8, xmm8
	.p2align	4, 0x90
.LBB3_12:                               # =>This Inner Loop Header: Depth=1
	movdqu	xmm3, xmmword ptr [r10 - 48]
	movdqu	xmm6, xmmword ptr [r10 - 32]
	movdqu	xmm10, xmmword ptr [r10 - 16]
	movdqu	xmm9, xmmword ptr [r10]
	movdqu	xmm2, xmmword ptr [rax - 48]
	movdqu	xmm4, xmmword ptr [rax - 32]
	movdqu	xmm7, xmmword ptr [rax - 16]
	movdqu	xmm13, xmmword ptr [rax]
	por	xmm2, xmm3
	por	xmm4, xmm6
	movdqa	xmm3, xmm2
	pand	xmm3, xmm11
	movdqa	xmm5, xmm12
	pshufb	xmm5, xmm3
	psrlw	xmm2, 4
	pand	xmm2, xmm11
	movdqa	xmm6, xmm12
	pshufb	xmm6, xmm2
	paddb	xmm6, xmm5
	psadbw	xmm6, xmm8
	movdqa	xmm2, xmm4
	pand	xmm2, xmm11
	movdqa	xmm5, xmm12
	pshufb	xmm5, xmm2
	psrlw	xmm4, 4
	pand	xmm4, xmm11
	movdqa	xmm3, xmm12
	pshufb	xmm3, xmm4
	paddb	xmm3, xmm5
	psadbw	xmm3, xmm8
	paddq	xmm6, xmm0
	paddq	xmm3, xmm1
	por	xmm7, xmm10
	por	xmm13, xmm9
	movdqa	xmm0, xmm7
	pand	xmm0, xmm11
	movdqa	xmm1, xmm12
	pshufb	xmm1, xmm0
	psrlw	xmm7, 4
	pand	xmm7, xmm11
	movdqa	xmm0, xmm12
	pshufb	xmm0, xmm7
	paddb	xmm0, xmm1
	psadbw	xmm0, xmm8
	movdqa	xmm1, xmm13
	pand	xmm1, xmm11
	movdqa	xmm2, xmm12
	pshufb	xmm2, xmm1
	psrlw	xmm13, 4
	pand	xmm13, xmm11
	movdqa	xmm1, xmm12
	pshufb	xmm1, xmm13
	paddb	xmm1, xmm2
	psadbw	xmm1, xmm8
	paddq	xmm0, xmm6
	paddq	xmm1, xmm3
	add	r10, 64
	add	rax, 64
	add	r9, -8
	jne	.LBB3_12
.LBB3_13:
	paddq	xmm0, xmm1
	pshufd	xmm1, xmm0, 78          # xmm1 = xmm0[2,3,0,1]
	paddq	xmm1, xmm0
	movd	r9d, xmm1
	cmp	r8, rdx
	je	.LBB3_14
.LBB3_3:
	lea	rsi, [rsi + 8*r8]
	lea	rdi, [rdi + 8*r8]
	sub	rdx, r8
	.p2align	4, 0x90
.LBB3_4:                                # =>This Inner Loop Header: Depth=1
	mov	rax, qword ptr [rsi]
	or	rax, qword ptr [rdi]
	popcnt	rax, rax
	add	r9d, eax
	add	rsi, 8
	add	rdi, 8
	dec	rdx
	jne	.LBB3_4
.LBB3_14:
	movsxd	r9, r9d
.LBB3_15:
	mov	qword ptr [rcx], r9
	mov	rsp, rbp
	pop	rbp
	ret
.Lfunc_end3:
	.size	popcnt_or_slice_sse4, .Lfunc_end3-popcnt_or_slice_sse4

	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4
.LCPI4_0:
	.zero	16,15
.LCPI4_1:
	.byte	0                       # 0x0
	.byte	1                       # 0x1
	.byte	1                       # 0x1
	.byte	2                       # 0x2
	.byte	1                       # 0x1
	.byte	2                       # 0x2
	.byte	2                       # 0x2
	.byte	3                       # 0x3
	.byte	1                       # 0x1
	.byte	2                       # 0x2
	.byte	2                       # 0x2
	.byte	3                       # 0x3
	.byte	2                       # 0x2
	.byte	3                       # 0x3
	.byte	3                       # 0x3
	.byte	4                       # 0x4
	.text
	.globl	popcnt_xor_slice_sse4
	.p2align	4, 0x90
	.type	popcnt_xor_slice_sse4,@function
popcnt_xor_slice_sse4:                  # @popcnt_xor_slice_sse4
# BB#0:
	push	rbp
	mov	rbp, rsp
	and	rsp, -8
	xor	r9d, r9d
	test	rdx, rdx
	je	.LBB4_15
# BB#1:
	cmp	rdx, 3
	ja	.LBB4_5
# BB#2:
	xor	r8d, r8d
	jmp	.LBB4_3
.LBB4_5:
	mov	r8, rdx
	and	r8, -4
	je	.LBB4_6
# BB#7:
	lea	rax, [r8 - 4]
	mov	r9, rax
	shr	r9, 2
	bt	eax, 2
	jb	.LBB4_8
# BB#9:
	movdqu	xmm0, xmmword ptr [rdi]
	movdqu	xmm1, xmmword ptr [rdi + 16]
	movdqu	xmm2, xmmword ptr [rsi]
	movdqu	xmm3, xmmword ptr [rsi + 16]
	pxor	xmm2, xmm0
	pxor	xmm3, xmm1
	movdqa	xmm4, xmmword ptr [rip + .LCPI4_0] # xmm4 = [15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15]
	movdqa	xmm0, xmm2
	pand	xmm0, xmm4
	movdqa	xmm1, xmmword ptr [rip + .LCPI4_1] # xmm1 = [0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4]
	movdqa	xmm5, xmm1
	pshufb	xmm5, xmm0
	psrlw	xmm2, 4
	pand	xmm2, xmm4
	movdqa	xmm0, xmm1
	pshufb	xmm0, xmm2
	paddb	xmm0, xmm5
	pxor	xmm2, xmm2
	psadbw	xmm0, xmm2
	movdqa	xmm5, xmm3
	pand	xmm5, xmm4
	movdqa	xmm6, xmm1
	pshufb	xmm6, xmm5
	psrlw	xmm3, 4
	pand	xmm3, xmm4
	pshufb	xmm1, xmm3
	paddb	xmm1, xmm6
	psadbw	xmm1, xmm2
	mov	eax, 4
	test	r9, r9
	jne	.LBB4_11
	jmp	.LBB4_13
.LBB4_6:
	xor	r8d, r8d
	xor	r9d, r9d
	jmp	.LBB4_3
.LBB4_8:
	pxor	xmm0, xmm0
	xor	eax, eax
	pxor	xmm1, xmm1
	test	r9, r9
	je	.LBB4_13
.LBB4_11:
	mov	r9, r8
	sub	r9, rax
	lea	r10, [rdi + 8*rax + 48]
	lea	rax, [rsi + 8*rax + 48]
	movdqa	xmm11, xmmword ptr [rip + .LCPI4_0] # xmm11 = [15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15]
	movdqa	xmm12, xmmword ptr [rip + .LCPI4_1] # xmm12 = [0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4]
	pxor	xmm8, xmm8
	.p2align	4, 0x90
.LBB4_12:                               # =>This Inner Loop Header: Depth=1
	movdqu	xmm3, xmmword ptr [r10 - 48]
	movdqu	xmm6, xmmword ptr [r10 - 32]
	movdqu	xmm10, xmmword ptr [r10 - 16]
	movdqu	xmm9, xmmword ptr [r10]
	movdqu	xmm2, xmmword ptr [rax - 48]
	movdqu	xmm4, xmmword ptr [rax - 32]
	movdqu	xmm7, xmmword ptr [rax - 16]
	movdqu	xmm13, xmmword ptr [rax]
	pxor	xmm2, xmm3
	pxor	xmm4, xmm6
	movdqa	xmm3, xmm2
	pand	xmm3, xmm11
	movdqa	xmm5, xmm12
	pshufb	xmm5, xmm3
	psrlw	xmm2, 4
	pand	xmm2, xmm11
	movdqa	xmm6, xmm12
	pshufb	xmm6, xmm2
	paddb	xmm6, xmm5
	psadbw	xmm6, xmm8
	movdqa	xmm2, xmm4
	pand	xmm2, xmm11
	movdqa	xmm5, xmm12
	pshufb	xmm5, xmm2
	psrlw	xmm4, 4
	pand	xmm4, xmm11
	movdqa	xmm3, xmm12
	pshufb	xmm3, xmm4
	paddb	xmm3, xmm5
	psadbw	xmm3, xmm8
	paddq	xmm6, xmm0
	paddq	xmm3, xmm1
	pxor	xmm7, xmm10
	pxor	xmm13, xmm9
	movdqa	xmm0, xmm7
	pand	xmm0, xmm11
	movdqa	xmm1, xmm12
	pshufb	xmm1, xmm0
	psrlw	xmm7, 4
	pand	xmm7, xmm11
	movdqa	xmm0, xmm12
	pshufb	xmm0, xmm7
	paddb	xmm0, xmm1
	psadbw	xmm0, xmm8
	movdqa	xmm1, xmm13
	pand	xmm1, xmm11
	movdqa	xmm2, xmm12
	pshufb	xmm2, xmm1
	psrlw	xmm13, 4
	pand	xmm13, xmm11
	movdqa	xmm1, xmm12
	pshufb	xmm1, xmm13
	paddb	xmm1, xmm2
	psadbw	xmm1, xmm8
	paddq	xmm0, xmm6
	paddq	xmm1, xmm3
	add	r10, 64
	add	rax, 64
	add	r9, -8
	jne	.LBB4_12
.LBB4_13:
	paddq	xmm0, xmm1
	pshufd	xmm1, xmm0, 78          # xmm1 = xmm0[2,3,0,1]
	paddq	xmm1, xmm0
	movd	r9d, xmm1
	cmp	r8, rdx
	je	.LBB4_14
.LBB4_3:
	lea	rsi, [rsi + 8*r8]
	lea	rdi, [rdi + 8*r8]
	sub	rdx, r8
	.p2align	4, 0x90
.LBB4_4:                                # =>This Inner Loop Header: Depth=1
	mov	rax, qword ptr [rsi]
	xor	rax, qword ptr [rdi]
	popcnt	rax, rax
	add	r9d, eax
	add	rsi, 8
	add	rdi, 8
	dec	rdx
	jne	.LBB4_4
.LBB4_14:
	movsxd	r9, r9d
.LBB4_15:
	mov	qword ptr [rcx], r9
	mov	rsp, rbp
	pop	rbp
	ret
.Lfunc_end4:
	.size	popcnt_xor_slice_sse4, .Lfunc_end4-popcnt_xor_slice_sse4


	.ident	"Apple LLVM version 9.0.0 (clang-900.0.39.2)"
	.section	".note.GNU-stack","",@progbits
