	.text
	.intel_syntax noprefix
	.file	"_lib/popcnt_slice.c"
	.section	.rodata.cst32,"aM",@progbits,32
	.p2align	5
.LCPI0_0:
	.zero	32,15
.LCPI0_1:
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
	.globl	popcnt_slice_avx2
	.p2align	4, 0x90
	.type	popcnt_slice_avx2,@function
popcnt_slice_avx2:                      # @popcnt_slice_avx2
# BB#0:
	push	rbp
	mov	rbp, rsp
	and	rsp, -8
	xor	eax, eax
	test	rsi, rsi
	jle	.LBB0_10
# BB#1:
	lea	r10, [rdi + 8*rsi]
	lea	rcx, [rdi + 8]
	cmp	r10, rcx
	cmova	rcx, r10
	mov	r9, rdi
	not	r9
	add	r9, rcx
	shr	r9, 3
	inc	r9
	cmp	r9, 16
	jae	.LBB0_3
# BB#2:
	mov	rcx, rdi
	jmp	.LBB0_8
.LBB0_3:
	movabs	r8, 4611686018427387888
	and	r8, r9
	je	.LBB0_4
# BB#5:
	lea	rcx, [rdi + 8*r8]
	add	rdi, 96
	vpxor	xmm0, xmm0, xmm0
	vmovdqa	ymm1, ymmword ptr [rip + .LCPI0_0] # ymm1 = [15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15]
	vmovdqa	ymm2, ymmword ptr [rip + .LCPI0_1] # ymm2 = [0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4,0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4]
	vpxor	ymm3, ymm3, ymm3
	mov	rsi, r8
	vpxor	xmm4, xmm4, xmm4
	vpxor	xmm5, xmm5, xmm5
	vpxor	xmm6, xmm6, xmm6
	.p2align	4, 0x90
.LBB0_6:                                # =>This Inner Loop Header: Depth=1
	vmovdqu	ymm7, ymmword ptr [rdi - 96]
	vmovdqu	ymm8, ymmword ptr [rdi - 64]
	vmovdqu	ymm9, ymmword ptr [rdi - 32]
	vmovdqu	ymm10, ymmword ptr [rdi]
	vpand	ymm11, ymm7, ymm1
	vpshufb	ymm11, ymm2, ymm11
	vpsrlw	ymm7, ymm7, 4
	vpand	ymm7, ymm7, ymm1
	vpshufb	ymm7, ymm2, ymm7
	vpaddb	ymm7, ymm7, ymm11
	vpsadbw	ymm7, ymm7, ymm3
	vpand	ymm11, ymm8, ymm1
	vpshufb	ymm11, ymm2, ymm11
	vpsrlw	ymm8, ymm8, 4
	vpand	ymm8, ymm8, ymm1
	vpshufb	ymm8, ymm2, ymm8
	vpaddb	ymm8, ymm8, ymm11
	vpsadbw	ymm8, ymm8, ymm3
	vpand	ymm11, ymm9, ymm1
	vpshufb	ymm11, ymm2, ymm11
	vpsrlw	ymm9, ymm9, 4
	vpand	ymm9, ymm9, ymm1
	vpshufb	ymm9, ymm2, ymm9
	vpaddb	ymm9, ymm9, ymm11
	vpsadbw	ymm9, ymm9, ymm3
	vpand	ymm11, ymm10, ymm1
	vpshufb	ymm11, ymm2, ymm11
	vpsrlw	ymm10, ymm10, 4
	vpand	ymm10, ymm10, ymm1
	vpshufb	ymm10, ymm2, ymm10
	vpaddb	ymm10, ymm10, ymm11
	vpsadbw	ymm10, ymm10, ymm3
	vpshufd	ymm7, ymm7, 232         # ymm7 = ymm7[0,2,2,3,4,6,6,7]
	vpermq	ymm7, ymm7, 232         # ymm7 = ymm7[0,2,2,3]
	vpshufd	ymm8, ymm8, 232         # ymm8 = ymm8[0,2,2,3,4,6,6,7]
	vpermq	ymm8, ymm8, 232         # ymm8 = ymm8[0,2,2,3]
	vpshufd	ymm9, ymm9, 232         # ymm9 = ymm9[0,2,2,3,4,6,6,7]
	vpermq	ymm9, ymm9, 232         # ymm9 = ymm9[0,2,2,3]
	vpshufd	ymm10, ymm10, 232       # ymm10 = ymm10[0,2,2,3,4,6,6,7]
	vpermq	ymm10, ymm10, 232       # ymm10 = ymm10[0,2,2,3]
	vpaddd	xmm0, xmm7, xmm0
	vpaddd	xmm4, xmm8, xmm4
	vpaddd	xmm5, xmm9, xmm5
	vpaddd	xmm6, xmm10, xmm6
	sub	rdi, -128
	add	rsi, -16
	jne	.LBB0_6
# BB#7:
	vpaddd	xmm0, xmm4, xmm0
	vpaddd	xmm0, xmm5, xmm0
	vpaddd	xmm0, xmm6, xmm0
	vpshufd	xmm1, xmm0, 78          # xmm1 = xmm0[2,3,0,1]
	vpaddd	xmm0, xmm0, xmm1
	vphaddd	xmm0, xmm0, xmm0
	vmovd	eax, xmm0
	cmp	r9, r8
	jne	.LBB0_8
	jmp	.LBB0_9
.LBB0_4:
	mov	rcx, rdi
	.p2align	4, 0x90
.LBB0_8:                                # =>This Inner Loop Header: Depth=1
	popcnt	rsi, qword ptr [rcx]
	add	eax, esi
	add	rcx, 8
	cmp	rcx, r10
	jb	.LBB0_8
.LBB0_9:
	cdqe
.LBB0_10:
	mov	qword ptr [rdx], rax
	mov	rsp, rbp
	pop	rbp
	vzeroupper
	ret
.Lfunc_end0:
	.size	popcnt_slice_avx2, .Lfunc_end0-popcnt_slice_avx2

	.section	.rodata.cst32,"aM",@progbits,32
	.p2align	5
.LCPI1_0:
	.zero	32,15
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
	.globl	popcnt_mask_slice_avx2
	.p2align	4, 0x90
	.type	popcnt_mask_slice_avx2,@function
popcnt_mask_slice_avx2:                 # @popcnt_mask_slice_avx2
# BB#0:
	push	rbp
	mov	rbp, rsp
	and	rsp, -8
	xor	r9d, r9d
	test	rdx, rdx
	je	.LBB1_11
# BB#1:
	cmp	rdx, 15
	ja	.LBB1_5
# BB#2:
	xor	r8d, r8d
	jmp	.LBB1_3
.LBB1_5:
	mov	r8, rdx
	and	r8, -16
	je	.LBB1_6
# BB#7:
	lea	r9, [rdi + 96]
	lea	rax, [rsi + 96]
	vpxor	xmm0, xmm0, xmm0
	vmovdqa	ymm1, ymmword ptr [rip + .LCPI1_0] # ymm1 = [15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15]
	vmovdqa	ymm2, ymmword ptr [rip + .LCPI1_1] # ymm2 = [0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4,0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4]
	vpxor	ymm3, ymm3, ymm3
	mov	r10, r8
	vpxor	xmm4, xmm4, xmm4
	vpxor	xmm5, xmm5, xmm5
	vpxor	xmm6, xmm6, xmm6
	.p2align	4, 0x90
.LBB1_8:                                # =>This Inner Loop Header: Depth=1
	vmovdqu	ymm7, ymmword ptr [rax - 96]
	vmovdqu	ymm8, ymmword ptr [rax - 64]
	vmovdqu	ymm9, ymmword ptr [rax - 32]
	vmovdqu	ymm10, ymmword ptr [rax]
	vpandn	ymm7, ymm7, ymmword ptr [r9 - 96]
	vpandn	ymm8, ymm8, ymmword ptr [r9 - 64]
	vpandn	ymm9, ymm9, ymmword ptr [r9 - 32]
	vpandn	ymm10, ymm10, ymmword ptr [r9]
	vpand	ymm11, ymm7, ymm1
	vpshufb	ymm11, ymm2, ymm11
	vpsrlw	ymm7, ymm7, 4
	vpand	ymm7, ymm7, ymm1
	vpshufb	ymm7, ymm2, ymm7
	vpaddb	ymm7, ymm7, ymm11
	vpsadbw	ymm7, ymm7, ymm3
	vpand	ymm11, ymm8, ymm1
	vpshufb	ymm11, ymm2, ymm11
	vpsrlw	ymm8, ymm8, 4
	vpand	ymm8, ymm8, ymm1
	vpshufb	ymm8, ymm2, ymm8
	vpaddb	ymm8, ymm8, ymm11
	vpsadbw	ymm8, ymm8, ymm3
	vpand	ymm11, ymm9, ymm1
	vpshufb	ymm11, ymm2, ymm11
	vpsrlw	ymm9, ymm9, 4
	vpand	ymm9, ymm9, ymm1
	vpshufb	ymm9, ymm2, ymm9
	vpaddb	ymm9, ymm9, ymm11
	vpsadbw	ymm9, ymm9, ymm3
	vpand	ymm11, ymm10, ymm1
	vpshufb	ymm11, ymm2, ymm11
	vpsrlw	ymm10, ymm10, 4
	vpand	ymm10, ymm10, ymm1
	vpshufb	ymm10, ymm2, ymm10
	vpaddb	ymm10, ymm10, ymm11
	vpsadbw	ymm10, ymm10, ymm3
	vpshufd	ymm7, ymm7, 232         # ymm7 = ymm7[0,2,2,3,4,6,6,7]
	vpermq	ymm7, ymm7, 232         # ymm7 = ymm7[0,2,2,3]
	vpshufd	ymm8, ymm8, 232         # ymm8 = ymm8[0,2,2,3,4,6,6,7]
	vpermq	ymm8, ymm8, 232         # ymm8 = ymm8[0,2,2,3]
	vpshufd	ymm9, ymm9, 232         # ymm9 = ymm9[0,2,2,3,4,6,6,7]
	vpermq	ymm9, ymm9, 232         # ymm9 = ymm9[0,2,2,3]
	vpshufd	ymm10, ymm10, 232       # ymm10 = ymm10[0,2,2,3,4,6,6,7]
	vpermq	ymm10, ymm10, 232       # ymm10 = ymm10[0,2,2,3]
	vpaddd	xmm0, xmm7, xmm0
	vpaddd	xmm4, xmm8, xmm4
	vpaddd	xmm5, xmm9, xmm5
	vpaddd	xmm6, xmm10, xmm6
	sub	r9, -128
	sub	rax, -128
	add	r10, -16
	jne	.LBB1_8
# BB#9:
	vpaddd	xmm0, xmm4, xmm0
	vpaddd	xmm0, xmm5, xmm0
	vpaddd	xmm0, xmm6, xmm0
	vpshufd	xmm1, xmm0, 78          # xmm1 = xmm0[2,3,0,1]
	vpaddd	xmm0, xmm0, xmm1
	vphaddd	xmm0, xmm0, xmm0
	vmovd	r9d, xmm0
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
	vzeroupper
	ret
.Lfunc_end1:
	.size	popcnt_mask_slice_avx2, .Lfunc_end1-popcnt_mask_slice_avx2

	.section	.rodata.cst32,"aM",@progbits,32
	.p2align	5
.LCPI2_0:
	.zero	32,15
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
	.globl	popcnt_and_slice_avx2
	.p2align	4, 0x90
	.type	popcnt_and_slice_avx2,@function
popcnt_and_slice_avx2:                  # @popcnt_and_slice_avx2
# BB#0:
	push	rbp
	mov	rbp, rsp
	and	rsp, -8
	xor	r9d, r9d
	test	rdx, rdx
	je	.LBB2_11
# BB#1:
	cmp	rdx, 15
	ja	.LBB2_5
# BB#2:
	xor	r8d, r8d
	jmp	.LBB2_3
.LBB2_5:
	mov	r8, rdx
	and	r8, -16
	je	.LBB2_6
# BB#7:
	lea	r9, [rdi + 96]
	lea	rax, [rsi + 96]
	vpxor	xmm0, xmm0, xmm0
	vmovdqa	ymm1, ymmword ptr [rip + .LCPI2_0] # ymm1 = [15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15]
	vmovdqa	ymm2, ymmword ptr [rip + .LCPI2_1] # ymm2 = [0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4,0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4]
	vpxor	ymm3, ymm3, ymm3
	mov	r10, r8
	vpxor	xmm4, xmm4, xmm4
	vpxor	xmm5, xmm5, xmm5
	vpxor	xmm6, xmm6, xmm6
	.p2align	4, 0x90
.LBB2_8:                                # =>This Inner Loop Header: Depth=1
	vmovdqu	ymm7, ymmword ptr [rax - 96]
	vmovdqu	ymm8, ymmword ptr [rax - 64]
	vmovdqu	ymm9, ymmword ptr [rax - 32]
	vmovdqu	ymm10, ymmword ptr [rax]
	vpand	ymm7, ymm7, ymmword ptr [r9 - 96]
	vpand	ymm8, ymm8, ymmword ptr [r9 - 64]
	vpand	ymm9, ymm9, ymmword ptr [r9 - 32]
	vpand	ymm10, ymm10, ymmword ptr [r9]
	vpand	ymm11, ymm7, ymm1
	vpshufb	ymm11, ymm2, ymm11
	vpsrlw	ymm7, ymm7, 4
	vpand	ymm7, ymm7, ymm1
	vpshufb	ymm7, ymm2, ymm7
	vpaddb	ymm7, ymm7, ymm11
	vpsadbw	ymm7, ymm7, ymm3
	vpand	ymm11, ymm8, ymm1
	vpshufb	ymm11, ymm2, ymm11
	vpsrlw	ymm8, ymm8, 4
	vpand	ymm8, ymm8, ymm1
	vpshufb	ymm8, ymm2, ymm8
	vpaddb	ymm8, ymm8, ymm11
	vpsadbw	ymm8, ymm8, ymm3
	vpand	ymm11, ymm9, ymm1
	vpshufb	ymm11, ymm2, ymm11
	vpsrlw	ymm9, ymm9, 4
	vpand	ymm9, ymm9, ymm1
	vpshufb	ymm9, ymm2, ymm9
	vpaddb	ymm9, ymm9, ymm11
	vpsadbw	ymm9, ymm9, ymm3
	vpand	ymm11, ymm10, ymm1
	vpshufb	ymm11, ymm2, ymm11
	vpsrlw	ymm10, ymm10, 4
	vpand	ymm10, ymm10, ymm1
	vpshufb	ymm10, ymm2, ymm10
	vpaddb	ymm10, ymm10, ymm11
	vpsadbw	ymm10, ymm10, ymm3
	vpshufd	ymm7, ymm7, 232         # ymm7 = ymm7[0,2,2,3,4,6,6,7]
	vpermq	ymm7, ymm7, 232         # ymm7 = ymm7[0,2,2,3]
	vpshufd	ymm8, ymm8, 232         # ymm8 = ymm8[0,2,2,3,4,6,6,7]
	vpermq	ymm8, ymm8, 232         # ymm8 = ymm8[0,2,2,3]
	vpshufd	ymm9, ymm9, 232         # ymm9 = ymm9[0,2,2,3,4,6,6,7]
	vpermq	ymm9, ymm9, 232         # ymm9 = ymm9[0,2,2,3]
	vpshufd	ymm10, ymm10, 232       # ymm10 = ymm10[0,2,2,3,4,6,6,7]
	vpermq	ymm10, ymm10, 232       # ymm10 = ymm10[0,2,2,3]
	vpaddd	xmm0, xmm7, xmm0
	vpaddd	xmm4, xmm8, xmm4
	vpaddd	xmm5, xmm9, xmm5
	vpaddd	xmm6, xmm10, xmm6
	sub	r9, -128
	sub	rax, -128
	add	r10, -16
	jne	.LBB2_8
# BB#9:
	vpaddd	xmm0, xmm4, xmm0
	vpaddd	xmm0, xmm5, xmm0
	vpaddd	xmm0, xmm6, xmm0
	vpshufd	xmm1, xmm0, 78          # xmm1 = xmm0[2,3,0,1]
	vpaddd	xmm0, xmm0, xmm1
	vphaddd	xmm0, xmm0, xmm0
	vmovd	r9d, xmm0
	cmp	r8, rdx
	jne	.LBB2_3
	jmp	.LBB2_10
.LBB2_6:
	xor	r8d, r8d
	xor	r9d, r9d
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
.LBB2_10:
	movsxd	r9, r9d
.LBB2_11:
	mov	qword ptr [rcx], r9
	mov	rsp, rbp
	pop	rbp
	vzeroupper
	ret
.Lfunc_end2:
	.size	popcnt_and_slice_avx2, .Lfunc_end2-popcnt_and_slice_avx2

	.section	.rodata.cst32,"aM",@progbits,32
	.p2align	5
.LCPI3_0:
	.zero	32,15
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
	.globl	popcnt_or_slice_avx2
	.p2align	4, 0x90
	.type	popcnt_or_slice_avx2,@function
popcnt_or_slice_avx2:                   # @popcnt_or_slice_avx2
# BB#0:
	push	rbp
	mov	rbp, rsp
	and	rsp, -8
	xor	r9d, r9d
	test	rdx, rdx
	je	.LBB3_11
# BB#1:
	cmp	rdx, 15
	ja	.LBB3_5
# BB#2:
	xor	r8d, r8d
	jmp	.LBB3_3
.LBB3_5:
	mov	r8, rdx
	and	r8, -16
	je	.LBB3_6
# BB#7:
	lea	r9, [rdi + 96]
	lea	rax, [rsi + 96]
	vpxor	xmm0, xmm0, xmm0
	vmovdqa	ymm1, ymmword ptr [rip + .LCPI3_0] # ymm1 = [15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15]
	vmovdqa	ymm2, ymmword ptr [rip + .LCPI3_1] # ymm2 = [0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4,0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4]
	vpxor	ymm3, ymm3, ymm3
	mov	r10, r8
	vpxor	xmm4, xmm4, xmm4
	vpxor	xmm5, xmm5, xmm5
	vpxor	xmm6, xmm6, xmm6
	.p2align	4, 0x90
.LBB3_8:                                # =>This Inner Loop Header: Depth=1
	vmovdqu	ymm7, ymmword ptr [rax - 96]
	vmovdqu	ymm8, ymmword ptr [rax - 64]
	vmovdqu	ymm9, ymmword ptr [rax - 32]
	vmovdqu	ymm10, ymmword ptr [rax]
	vpor	ymm7, ymm7, ymmword ptr [r9 - 96]
	vpor	ymm8, ymm8, ymmword ptr [r9 - 64]
	vpor	ymm9, ymm9, ymmword ptr [r9 - 32]
	vpor	ymm10, ymm10, ymmword ptr [r9]
	vpand	ymm11, ymm7, ymm1
	vpshufb	ymm11, ymm2, ymm11
	vpsrlw	ymm7, ymm7, 4
	vpand	ymm7, ymm7, ymm1
	vpshufb	ymm7, ymm2, ymm7
	vpaddb	ymm7, ymm7, ymm11
	vpsadbw	ymm7, ymm7, ymm3
	vpand	ymm11, ymm8, ymm1
	vpshufb	ymm11, ymm2, ymm11
	vpsrlw	ymm8, ymm8, 4
	vpand	ymm8, ymm8, ymm1
	vpshufb	ymm8, ymm2, ymm8
	vpaddb	ymm8, ymm8, ymm11
	vpsadbw	ymm8, ymm8, ymm3
	vpand	ymm11, ymm9, ymm1
	vpshufb	ymm11, ymm2, ymm11
	vpsrlw	ymm9, ymm9, 4
	vpand	ymm9, ymm9, ymm1
	vpshufb	ymm9, ymm2, ymm9
	vpaddb	ymm9, ymm9, ymm11
	vpsadbw	ymm9, ymm9, ymm3
	vpand	ymm11, ymm10, ymm1
	vpshufb	ymm11, ymm2, ymm11
	vpsrlw	ymm10, ymm10, 4
	vpand	ymm10, ymm10, ymm1
	vpshufb	ymm10, ymm2, ymm10
	vpaddb	ymm10, ymm10, ymm11
	vpsadbw	ymm10, ymm10, ymm3
	vpshufd	ymm7, ymm7, 232         # ymm7 = ymm7[0,2,2,3,4,6,6,7]
	vpermq	ymm7, ymm7, 232         # ymm7 = ymm7[0,2,2,3]
	vpshufd	ymm8, ymm8, 232         # ymm8 = ymm8[0,2,2,3,4,6,6,7]
	vpermq	ymm8, ymm8, 232         # ymm8 = ymm8[0,2,2,3]
	vpshufd	ymm9, ymm9, 232         # ymm9 = ymm9[0,2,2,3,4,6,6,7]
	vpermq	ymm9, ymm9, 232         # ymm9 = ymm9[0,2,2,3]
	vpshufd	ymm10, ymm10, 232       # ymm10 = ymm10[0,2,2,3,4,6,6,7]
	vpermq	ymm10, ymm10, 232       # ymm10 = ymm10[0,2,2,3]
	vpaddd	xmm0, xmm7, xmm0
	vpaddd	xmm4, xmm8, xmm4
	vpaddd	xmm5, xmm9, xmm5
	vpaddd	xmm6, xmm10, xmm6
	sub	r9, -128
	sub	rax, -128
	add	r10, -16
	jne	.LBB3_8
# BB#9:
	vpaddd	xmm0, xmm4, xmm0
	vpaddd	xmm0, xmm5, xmm0
	vpaddd	xmm0, xmm6, xmm0
	vpshufd	xmm1, xmm0, 78          # xmm1 = xmm0[2,3,0,1]
	vpaddd	xmm0, xmm0, xmm1
	vphaddd	xmm0, xmm0, xmm0
	vmovd	r9d, xmm0
	cmp	r8, rdx
	jne	.LBB3_3
	jmp	.LBB3_10
.LBB3_6:
	xor	r8d, r8d
	xor	r9d, r9d
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
.LBB3_10:
	movsxd	r9, r9d
.LBB3_11:
	mov	qword ptr [rcx], r9
	mov	rsp, rbp
	pop	rbp
	vzeroupper
	ret
.Lfunc_end3:
	.size	popcnt_or_slice_avx2, .Lfunc_end3-popcnt_or_slice_avx2

	.section	.rodata.cst32,"aM",@progbits,32
	.p2align	5
.LCPI4_0:
	.zero	32,15
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
	.globl	popcnt_xor_slice_avx2
	.p2align	4, 0x90
	.type	popcnt_xor_slice_avx2,@function
popcnt_xor_slice_avx2:                  # @popcnt_xor_slice_avx2
# BB#0:
	push	rbp
	mov	rbp, rsp
	and	rsp, -8
	xor	r9d, r9d
	test	rdx, rdx
	je	.LBB4_11
# BB#1:
	cmp	rdx, 15
	ja	.LBB4_5
# BB#2:
	xor	r8d, r8d
	jmp	.LBB4_3
.LBB4_5:
	mov	r8, rdx
	and	r8, -16
	je	.LBB4_6
# BB#7:
	lea	r9, [rdi + 96]
	lea	rax, [rsi + 96]
	vpxor	xmm0, xmm0, xmm0
	vmovdqa	ymm1, ymmword ptr [rip + .LCPI4_0] # ymm1 = [15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15]
	vmovdqa	ymm2, ymmword ptr [rip + .LCPI4_1] # ymm2 = [0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4,0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4]
	vpxor	ymm3, ymm3, ymm3
	mov	r10, r8
	vpxor	xmm4, xmm4, xmm4
	vpxor	xmm5, xmm5, xmm5
	vpxor	xmm6, xmm6, xmm6
	.p2align	4, 0x90
.LBB4_8:                                # =>This Inner Loop Header: Depth=1
	vmovdqu	ymm7, ymmword ptr [rax - 96]
	vmovdqu	ymm8, ymmword ptr [rax - 64]
	vmovdqu	ymm9, ymmword ptr [rax - 32]
	vmovdqu	ymm10, ymmword ptr [rax]
	vpxor	ymm7, ymm7, ymmword ptr [r9 - 96]
	vpxor	ymm8, ymm8, ymmword ptr [r9 - 64]
	vpxor	ymm9, ymm9, ymmword ptr [r9 - 32]
	vpxor	ymm10, ymm10, ymmword ptr [r9]
	vpand	ymm11, ymm7, ymm1
	vpshufb	ymm11, ymm2, ymm11
	vpsrlw	ymm7, ymm7, 4
	vpand	ymm7, ymm7, ymm1
	vpshufb	ymm7, ymm2, ymm7
	vpaddb	ymm7, ymm7, ymm11
	vpsadbw	ymm7, ymm7, ymm3
	vpand	ymm11, ymm8, ymm1
	vpshufb	ymm11, ymm2, ymm11
	vpsrlw	ymm8, ymm8, 4
	vpand	ymm8, ymm8, ymm1
	vpshufb	ymm8, ymm2, ymm8
	vpaddb	ymm8, ymm8, ymm11
	vpsadbw	ymm8, ymm8, ymm3
	vpand	ymm11, ymm9, ymm1
	vpshufb	ymm11, ymm2, ymm11
	vpsrlw	ymm9, ymm9, 4
	vpand	ymm9, ymm9, ymm1
	vpshufb	ymm9, ymm2, ymm9
	vpaddb	ymm9, ymm9, ymm11
	vpsadbw	ymm9, ymm9, ymm3
	vpand	ymm11, ymm10, ymm1
	vpshufb	ymm11, ymm2, ymm11
	vpsrlw	ymm10, ymm10, 4
	vpand	ymm10, ymm10, ymm1
	vpshufb	ymm10, ymm2, ymm10
	vpaddb	ymm10, ymm10, ymm11
	vpsadbw	ymm10, ymm10, ymm3
	vpshufd	ymm7, ymm7, 232         # ymm7 = ymm7[0,2,2,3,4,6,6,7]
	vpermq	ymm7, ymm7, 232         # ymm7 = ymm7[0,2,2,3]
	vpshufd	ymm8, ymm8, 232         # ymm8 = ymm8[0,2,2,3,4,6,6,7]
	vpermq	ymm8, ymm8, 232         # ymm8 = ymm8[0,2,2,3]
	vpshufd	ymm9, ymm9, 232         # ymm9 = ymm9[0,2,2,3,4,6,6,7]
	vpermq	ymm9, ymm9, 232         # ymm9 = ymm9[0,2,2,3]
	vpshufd	ymm10, ymm10, 232       # ymm10 = ymm10[0,2,2,3,4,6,6,7]
	vpermq	ymm10, ymm10, 232       # ymm10 = ymm10[0,2,2,3]
	vpaddd	xmm0, xmm7, xmm0
	vpaddd	xmm4, xmm8, xmm4
	vpaddd	xmm5, xmm9, xmm5
	vpaddd	xmm6, xmm10, xmm6
	sub	r9, -128
	sub	rax, -128
	add	r10, -16
	jne	.LBB4_8
# BB#9:
	vpaddd	xmm0, xmm4, xmm0
	vpaddd	xmm0, xmm5, xmm0
	vpaddd	xmm0, xmm6, xmm0
	vpshufd	xmm1, xmm0, 78          # xmm1 = xmm0[2,3,0,1]
	vpaddd	xmm0, xmm0, xmm1
	vphaddd	xmm0, xmm0, xmm0
	vmovd	r9d, xmm0
	cmp	r8, rdx
	jne	.LBB4_3
	jmp	.LBB4_10
.LBB4_6:
	xor	r8d, r8d
	xor	r9d, r9d
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
.LBB4_10:
	movsxd	r9, r9d
.LBB4_11:
	mov	qword ptr [rcx], r9
	mov	rsp, rbp
	pop	rbp
	vzeroupper
	ret
.Lfunc_end4:
	.size	popcnt_xor_slice_avx2, .Lfunc_end4-popcnt_xor_slice_avx2


	.ident	"Apple LLVM version 9.0.0 (clang-900.0.39.2)"
	.section	".note.GNU-stack","",@progbits
