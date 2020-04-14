; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s

declare void @use(<4 x i16>)

define void @test(<16 x i8> %w, i32* %o1, float* %o2) {
; CHECK-LABEL: @test(
; CHECK-NEXT:    [[V_BC:%.*]] = bitcast <16 x i8> [[W:%.*]] to <4 x i32>
; CHECK-NEXT:    [[V_EXTRACT:%.*]] = extractelement <4 x i32> [[V_BC]], i32 3
; CHECK-NEXT:    [[V_BC1:%.*]] = bitcast <16 x i8> [[W]] to <4 x float>
; CHECK-NEXT:    [[V_EXTRACT2:%.*]] = extractelement <4 x float> [[V_BC1]], i32 3
; CHECK-NEXT:    store i32 [[V_EXTRACT]], i32* [[O1:%.*]], align 4
; CHECK-NEXT:    store float [[V_EXTRACT2]], float* [[O2:%.*]], align 4
; CHECK-NEXT:    ret void
;
  %v = shufflevector <16 x i8> %w, <16 x i8> undef, <4 x i32> <i32 12, i32 13, i32 14, i32 15>
  %f = bitcast <4 x i8> %v to float
  %i = bitcast <4 x i8> %v to i32
  store i32 %i, i32* %o1, align 4
  store float %f, float* %o2, align 4
  ret void
}

; Shuffle-of-bitcast-splat --> splat-bitcast

define <4 x i16> @splat_bitcast_operand(<8 x i8> %x) {
; CHECK-LABEL: @splat_bitcast_operand(
; CHECK-NEXT:    [[S1:%.*]] = shufflevector <8 x i8> [[X:%.*]], <8 x i8> undef, <8 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
; CHECK-NEXT:    [[S2:%.*]] = bitcast <8 x i8> [[S1]] to <4 x i16>
; CHECK-NEXT:    ret <4 x i16> [[S2]]
;
  %s1 = shufflevector <8 x i8> %x, <8 x i8> undef, <8 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %bc = bitcast <8 x i8> %s1 to <4 x i16>
  %s2 = shufflevector <4 x i16> %bc, <4 x i16> undef, <4 x i32> <i32 0, i32 2, i32 1, i32 0>
  ret <4 x i16> %s2
}

; Shuffle-of-bitcast-splat --> splat-bitcast

define <4 x i16> @splat_bitcast_operand_uses(<8 x i8> %x) {
; CHECK-LABEL: @splat_bitcast_operand_uses(
; CHECK-NEXT:    [[S1:%.*]] = shufflevector <8 x i8> [[X:%.*]], <8 x i8> undef, <8 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
; CHECK-NEXT:    [[BC:%.*]] = bitcast <8 x i8> [[S1]] to <4 x i16>
; CHECK-NEXT:    call void @use(<4 x i16> [[BC]])
; CHECK-NEXT:    [[S2:%.*]] = bitcast <8 x i8> [[S1]] to <4 x i16>
; CHECK-NEXT:    ret <4 x i16> [[S2]]
;
  %s1 = shufflevector <8 x i8> %x, <8 x i8> undef, <8 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %bc = bitcast <8 x i8> %s1 to <4 x i16>
  call void @use(<4 x i16> %bc)
  %s2 = shufflevector <4 x i16> %bc, <4 x i16> undef, <4 x i32> <i32 0, i32 2, i32 1, i32 0>
  ret <4 x i16> %s2
}

; Shuffle-of-bitcast-splat --> splat-bitcast

define <4 x i32> @splat_bitcast_operand_same_size_src_elt(<4 x float> %x) {
; CHECK-LABEL: @splat_bitcast_operand_same_size_src_elt(
; CHECK-NEXT:    [[S1:%.*]] = shufflevector <4 x float> [[X:%.*]], <4 x float> undef, <4 x i32> <i32 2, i32 2, i32 2, i32 2>
; CHECK-NEXT:    [[S2:%.*]] = bitcast <4 x float> [[S1]] to <4 x i32>
; CHECK-NEXT:    ret <4 x i32> [[S2]]
;
  %s1 = shufflevector <4 x float> %x, <4 x float> undef, <4 x i32> <i32 2, i32 2, i32 2, i32 2>
  %bc = bitcast <4 x float> %s1 to <4 x i32>
  %s2 = shufflevector <4 x i32> %bc, <4 x i32> undef, <4 x i32> <i32 0, i32 2, i32 1, i32 0>
  ret <4 x i32> %s2
}

; Scaled mask is inverse of first mask.

define <4 x i32> @shuf_bitcast_operand(<16 x i8> %x) {
; CHECK-LABEL: @shuf_bitcast_operand(
; CHECK-NEXT:    [[S2:%.*]] = bitcast <16 x i8> [[X:%.*]] to <4 x i32>
; CHECK-NEXT:    ret <4 x i32> [[S2]]
;
  %s1 = shufflevector <16 x i8> %x, <16 x i8> undef, <16 x i32> <i32 12, i32 13, i32 14, i32 15, i32 8, i32 9, i32 10, i32 11, i32 4, i32 5, i32 6, i32 7, i32 0, i32 1, i32 2, i32 3>
  %bc = bitcast <16 x i8> %s1 to <4 x i32>
  %s2 = shufflevector <4 x i32> %bc, <4 x i32> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  ret <4 x i32> %s2
}

; TODO: Could allow fold for length-changing shuffles.

define <5 x i16> @splat_bitcast_operand_change_type(<8 x i8> %x) {
; CHECK-LABEL: @splat_bitcast_operand_change_type(
; CHECK-NEXT:    [[S1:%.*]] = shufflevector <8 x i8> [[X:%.*]], <8 x i8> undef, <8 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
; CHECK-NEXT:    [[BC:%.*]] = bitcast <8 x i8> [[S1]] to <4 x i16>
; CHECK-NEXT:    [[S2:%.*]] = shufflevector <4 x i16> [[BC]], <4 x i16> undef, <5 x i32> <i32 0, i32 2, i32 1, i32 0, i32 3>
; CHECK-NEXT:    ret <5 x i16> [[S2]]
;
  %s1 = shufflevector <8 x i8> %x, <8 x i8> undef, <8 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %bc = bitcast <8 x i8> %s1 to <4 x i16>
  %s2 = shufflevector <4 x i16> %bc, <4 x i16> undef, <5 x i32> <i32 0, i32 2, i32 1, i32 0, i32 3>
  ret <5 x i16> %s2
}

; Shuffle-of-bitcast-splat --> splat-bitcast

define <4 x i16> @splat_bitcast_operand_wider_src_elt(<2 x i32> %x) {
; CHECK-LABEL: @splat_bitcast_operand_wider_src_elt(
; CHECK-NEXT:    [[S1:%.*]] = shufflevector <2 x i32> [[X:%.*]], <2 x i32> undef, <2 x i32> <i32 1, i32 1>
; CHECK-NEXT:    [[S2:%.*]] = bitcast <2 x i32> [[S1]] to <4 x i16>
; CHECK-NEXT:    ret <4 x i16> [[S2]]
;
  %s1 = shufflevector <2 x i32> %x, <2 x i32> undef, <2 x i32> <i32 1, i32 1>
  %bc = bitcast <2 x i32> %s1 to <4 x i16>
  %s2 = shufflevector <4 x i16> %bc, <4 x i16> undef, <4 x i32> <i32 0, i32 1, i32 0, i32 1>
  ret <4 x i16> %s2
}

; Shuffle-of-bitcast-splat --> splat-bitcast

define <4 x i16> @splat_bitcast_operand_wider_src_elt_uses(<2 x i32> %x) {
; CHECK-LABEL: @splat_bitcast_operand_wider_src_elt_uses(
; CHECK-NEXT:    [[S1:%.*]] = shufflevector <2 x i32> [[X:%.*]], <2 x i32> undef, <2 x i32> <i32 1, i32 1>
; CHECK-NEXT:    [[BC:%.*]] = bitcast <2 x i32> [[S1]] to <4 x i16>
; CHECK-NEXT:    call void @use(<4 x i16> [[BC]])
; CHECK-NEXT:    [[S2:%.*]] = bitcast <2 x i32> [[S1]] to <4 x i16>
; CHECK-NEXT:    ret <4 x i16> [[S2]]
;
  %s1 = shufflevector <2 x i32> %x, <2 x i32> undef, <2 x i32> <i32 1, i32 1>
  %bc = bitcast <2 x i32> %s1 to <4 x i16>
  call void @use(<4 x i16> %bc)
  %s2 = shufflevector <4 x i16> %bc, <4 x i16> undef, <4 x i32> <i32 0, i32 1, i32 0, i32 1>
  ret <4 x i16> %s2
}

; Scaled mask is inverse of first mask.

define <16 x i8> @shuf_bitcast_operand_wider_src(<4 x i32> %x) {
; CHECK-LABEL: @shuf_bitcast_operand_wider_src(
; CHECK-NEXT:    [[S2:%.*]] = bitcast <4 x i32> [[X:%.*]] to <16 x i8>
; CHECK-NEXT:    ret <16 x i8> [[S2]]
;
  %s1 = shufflevector <4 x i32> %x, <4 x i32> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  %bc = bitcast <4 x i32> %s1 to <16 x i8>
  %s2 = shufflevector <16 x i8> %bc, <16 x i8> undef, <16 x i32> <i32 12, i32 13, i32 14, i32 15, i32 8, i32 9, i32 10, i32 11, i32 4, i32 5, i32 6, i32 7, i32 0, i32 1, i32 2, i32 3>
  ret <16 x i8> %s2
}

; Negative test - the 2nd mask can't be widened

define <16 x i8> @shuf_bitcast_operand_cannot_widen(<4 x i32> %x) {
; CHECK-LABEL: @shuf_bitcast_operand_cannot_widen(
; CHECK-NEXT:    [[S1:%.*]] = shufflevector <4 x i32> [[X:%.*]], <4 x i32> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:    [[BC:%.*]] = bitcast <4 x i32> [[S1]] to <16 x i8>
; CHECK-NEXT:    [[S2:%.*]] = shufflevector <16 x i8> [[BC]], <16 x i8> undef, <16 x i32> <i32 12, i32 13, i32 12, i32 13, i32 8, i32 9, i32 10, i32 11, i32 4, i32 5, i32 6, i32 7, i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    ret <16 x i8> [[S2]]
;
  %s1 = shufflevector <4 x i32> %x, <4 x i32> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  %bc = bitcast <4 x i32> %s1 to <16 x i8>
  %s2 = shufflevector <16 x i8> %bc, <16 x i8> undef, <16 x i32> <i32 12, i32 13, i32 12, i32 13, i32 8, i32 9, i32 10, i32 11, i32 4, i32 5, i32 6, i32 7, i32 0, i32 1, i32 2, i32 3>
  ret <16 x i8> %s2
}

; Negative test - the 2nd mask can't be widened

define <16 x i8> @shuf_bitcast_operand_cannot_widen_undef(<4 x i32> %x) {
; CHECK-LABEL: @shuf_bitcast_operand_cannot_widen_undef(
; CHECK-NEXT:    [[S1:%.*]] = shufflevector <4 x i32> [[X:%.*]], <4 x i32> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:    [[BC:%.*]] = bitcast <4 x i32> [[S1]] to <16 x i8>
; CHECK-NEXT:    [[S2:%.*]] = shufflevector <16 x i8> [[BC]], <16 x i8> undef, <16 x i32> <i32 12, i32 undef, i32 14, i32 15, i32 8, i32 9, i32 10, i32 11, i32 4, i32 5, i32 6, i32 7, i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    ret <16 x i8> [[S2]]
;
  %s1 = shufflevector <4 x i32> %x, <4 x i32> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  %bc = bitcast <4 x i32> %s1 to <16 x i8>
  %s2 = shufflevector <16 x i8> %bc, <16 x i8> undef, <16 x i32> <i32 12, i32 undef, i32 14, i32 15, i32 8, i32 9, i32 10, i32 11, i32 4, i32 5, i32 6, i32 7, i32 0, i32 1, i32 2, i32 3>
  ret <16 x i8> %s2
}
