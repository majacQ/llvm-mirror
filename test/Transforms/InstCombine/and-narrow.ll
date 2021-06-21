; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -data-layout="n8:16:32" -S | FileCheck %s
; RUN: opt < %s -instcombine -data-layout="n16"      -S | FileCheck %s

; PR35792 - https://bugs.llvm.org/show_bug.cgi?id=35792

define i16 @zext_add(i8 %x) {
; CHECK-LABEL: @zext_add(
; CHECK-NEXT:    [[TMP1:%.*]] = add i8 [[X:%.*]], 44
; CHECK-NEXT:    [[TMP2:%.*]] = and i8 [[TMP1]], [[X]]
; CHECK-NEXT:    [[R:%.*]] = zext i8 [[TMP2]] to i16
; CHECK-NEXT:    ret i16 [[R]]
;
  %z = zext i8 %x to i16
  %b = add i16 %z, 44
  %r = and i16 %b, %z
  ret i16 %r
}

define i16 @zext_sub(i8 %x) {
; CHECK-LABEL: @zext_sub(
; CHECK-NEXT:    [[TMP1:%.*]] = sub i8 -5, [[X:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = and i8 [[TMP1]], [[X]]
; CHECK-NEXT:    [[R:%.*]] = zext i8 [[TMP2]] to i16
; CHECK-NEXT:    ret i16 [[R]]
;
  %z = zext i8 %x to i16
  %b = sub i16 -5, %z
  %r = and i16 %b, %z
  ret i16 %r
}

define i16 @zext_mul(i8 %x) {
; CHECK-LABEL: @zext_mul(
; CHECK-NEXT:    [[TMP1:%.*]] = mul i8 [[X:%.*]], 3
; CHECK-NEXT:    [[TMP2:%.*]] = and i8 [[TMP1]], [[X]]
; CHECK-NEXT:    [[R:%.*]] = zext i8 [[TMP2]] to i16
; CHECK-NEXT:    ret i16 [[R]]
;
  %z = zext i8 %x to i16
  %b = mul i16 %z, 3
  %r = and i16 %b, %z
  ret i16 %r
}

define i16 @zext_lshr(i8 %x) {
; CHECK-LABEL: @zext_lshr(
; CHECK-NEXT:    [[TMP1:%.*]] = lshr i8 [[X:%.*]], 4
; CHECK-NEXT:    [[TMP2:%.*]] = and i8 [[TMP1]], [[X]]
; CHECK-NEXT:    [[R:%.*]] = zext i8 [[TMP2]] to i16
; CHECK-NEXT:    ret i16 [[R]]
;
  %z = zext i8 %x to i16
  %b = lshr i16 %z, 4
  %r = and i16 %b, %z
  ret i16 %r
}

define i16 @zext_ashr(i8 %x) {
; CHECK-LABEL: @zext_ashr(
; CHECK-NEXT:    [[TMP1:%.*]] = lshr i8 [[X:%.*]], 2
; CHECK-NEXT:    [[TMP2:%.*]] = and i8 [[TMP1]], [[X]]
; CHECK-NEXT:    [[R:%.*]] = zext i8 [[TMP2]] to i16
; CHECK-NEXT:    ret i16 [[R]]
;
  %z = zext i8 %x to i16
  %b = ashr i16 %z, 2
  %r = and i16 %b, %z
  ret i16 %r
}

define i16 @zext_shl(i8 %x) {
; CHECK-LABEL: @zext_shl(
; CHECK-NEXT:    [[TMP1:%.*]] = shl i8 [[X:%.*]], 3
; CHECK-NEXT:    [[TMP2:%.*]] = and i8 [[TMP1]], [[X]]
; CHECK-NEXT:    [[R:%.*]] = zext i8 [[TMP2]] to i16
; CHECK-NEXT:    ret i16 [[R]]
;
  %z = zext i8 %x to i16
  %b = shl i16 %z, 3
  %r = and i16 %b, %z
  ret i16 %r
}

define <2 x i16> @zext_add_vec(<2 x i8> %x) {
; CHECK-LABEL: @zext_add_vec(
; CHECK-NEXT:    [[TMP1:%.*]] = add <2 x i8> [[X:%.*]], <i8 44, i8 42>
; CHECK-NEXT:    [[TMP2:%.*]] = and <2 x i8> [[TMP1]], [[X]]
; CHECK-NEXT:    [[R:%.*]] = zext <2 x i8> [[TMP2]] to <2 x i16>
; CHECK-NEXT:    ret <2 x i16> [[R]]
;
  %z = zext <2 x i8> %x to <2 x i16>
  %b = add <2 x i16> %z, <i16 44, i16 42>
  %r = and <2 x i16> %b, %z
  ret <2 x i16> %r
}

define <2 x i16> @zext_sub_vec(<2 x i8> %x) {
; CHECK-LABEL: @zext_sub_vec(
; CHECK-NEXT:    [[TMP1:%.*]] = sub <2 x i8> <i8 -5, i8 -4>, [[X:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = and <2 x i8> [[TMP1]], [[X]]
; CHECK-NEXT:    [[R:%.*]] = zext <2 x i8> [[TMP2]] to <2 x i16>
; CHECK-NEXT:    ret <2 x i16> [[R]]
;
  %z = zext <2 x i8> %x to <2 x i16>
  %b = sub <2 x i16> <i16 -5, i16 -4>, %z
  %r = and <2 x i16> %b, %z
  ret <2 x i16> %r
}

define <2 x i16> @zext_mul_vec(<2 x i8> %x) {
; CHECK-LABEL: @zext_mul_vec(
; CHECK-NEXT:    [[TMP1:%.*]] = mul <2 x i8> [[X:%.*]], <i8 3, i8 -2>
; CHECK-NEXT:    [[TMP2:%.*]] = and <2 x i8> [[TMP1]], [[X]]
; CHECK-NEXT:    [[R:%.*]] = zext <2 x i8> [[TMP2]] to <2 x i16>
; CHECK-NEXT:    ret <2 x i16> [[R]]
;
  %z = zext <2 x i8> %x to <2 x i16>
  %b = mul <2 x i16> %z, <i16 3, i16 -2>
  %r = and <2 x i16> %b, %z
  ret <2 x i16> %r
}

define <2 x i16> @zext_lshr_vec(<2 x i8> %x) {
; CHECK-LABEL: @zext_lshr_vec(
; CHECK-NEXT:    [[TMP1:%.*]] = lshr <2 x i8> [[X:%.*]], <i8 4, i8 2>
; CHECK-NEXT:    [[TMP2:%.*]] = and <2 x i8> [[TMP1]], [[X]]
; CHECK-NEXT:    [[R:%.*]] = zext <2 x i8> [[TMP2]] to <2 x i16>
; CHECK-NEXT:    ret <2 x i16> [[R]]
;
  %z = zext <2 x i8> %x to <2 x i16>
  %b = lshr <2 x i16> %z, <i16 4, i16 2>
  %r = and <2 x i16> %b, %z
  ret <2 x i16> %r
}

define <2 x i16> @zext_ashr_vec(<2 x i8> %x) {
; CHECK-LABEL: @zext_ashr_vec(
; CHECK-NEXT:    [[TMP1:%.*]] = lshr <2 x i8> [[X:%.*]], <i8 2, i8 3>
; CHECK-NEXT:    [[TMP2:%.*]] = and <2 x i8> [[TMP1]], [[X]]
; CHECK-NEXT:    [[R:%.*]] = zext <2 x i8> [[TMP2]] to <2 x i16>
; CHECK-NEXT:    ret <2 x i16> [[R]]
;
  %z = zext <2 x i8> %x to <2 x i16>
  %b = ashr <2 x i16> %z, <i16 2, i16 3>
  %r = and <2 x i16> %b, %z
  ret <2 x i16> %r
}

define <2 x i16> @zext_shl_vec(<2 x i8> %x) {
; CHECK-LABEL: @zext_shl_vec(
; CHECK-NEXT:    [[TMP1:%.*]] = shl <2 x i8> [[X:%.*]], <i8 3, i8 2>
; CHECK-NEXT:    [[TMP2:%.*]] = and <2 x i8> [[TMP1]], [[X]]
; CHECK-NEXT:    [[R:%.*]] = zext <2 x i8> [[TMP2]] to <2 x i16>
; CHECK-NEXT:    ret <2 x i16> [[R]]
;
  %z = zext <2 x i8> %x to <2 x i16>
  %b = shl <2 x i16> %z, <i16 3, i16 2>
  %r = and <2 x i16> %b, %z
  ret <2 x i16> %r
}

; Don't create poison by narrowing a shift below the shift amount.

define <2 x i16> @zext_lshr_vec_overshift(<2 x i8> %x) {
; CHECK-LABEL: @zext_lshr_vec_overshift(
; CHECK-NEXT:    [[Z:%.*]] = zext <2 x i8> [[X:%.*]] to <2 x i16>
; CHECK-NEXT:    [[B:%.*]] = lshr <2 x i16> [[Z]], <i16 4, i16 8>
; CHECK-NEXT:    [[R:%.*]] = and <2 x i16> [[B]], [[Z]]
; CHECK-NEXT:    ret <2 x i16> [[R]]
;
  %z = zext <2 x i8> %x to <2 x i16>
  %b = lshr <2 x i16> %z, <i16 4, i16 8>
  %r = and <2 x i16> %b, %z
  ret <2 x i16> %r
}

define <2 x i16> @zext_lshr_vec_undef(<2 x i8> %x) {
; CHECK-LABEL: @zext_lshr_vec_undef(
; CHECK-NEXT:    ret <2 x i16> poison
;
  %z = zext <2 x i8> %x to <2 x i16>
  %b = lshr <2 x i16> %z, undef
  %r = and <2 x i16> %b, %z
  ret <2 x i16> %r
}

; Don't create poison by narrowing a shift below the shift amount.

define <2 x i16> @zext_shl_vec_overshift(<2 x i8> %x) {
; CHECK-LABEL: @zext_shl_vec_overshift(
; CHECK-NEXT:    [[Z:%.*]] = zext <2 x i8> [[X:%.*]] to <2 x i16>
; CHECK-NEXT:    [[B:%.*]] = shl <2 x i16> [[Z]], <i16 8, i16 2>
; CHECK-NEXT:    [[R:%.*]] = and <2 x i16> [[B]], [[Z]]
; CHECK-NEXT:    ret <2 x i16> [[R]]
;
  %z = zext <2 x i8> %x to <2 x i16>
  %b = shl <2 x i16> %z, <i16 8, i16 2>
  %r = and <2 x i16> %b, %z
  ret <2 x i16> %r
}

define <2 x i16> @zext_shl_vec_undef(<2 x i8> %x) {
; CHECK-LABEL: @zext_shl_vec_undef(
; CHECK-NEXT:    ret <2 x i16> poison
;
  %z = zext <2 x i8> %x to <2 x i16>
  %b = shl <2 x i16> %z, undef
  %r = and <2 x i16> %b, %z
  ret <2 x i16> %r
}

