; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+m,+experimental-v -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+m,+experimental-v -verify-machineinstrs < %s | FileCheck %s

declare <vscale x 1 x i8> @llvm.experimental.stepvector.nxv1i8()

define <vscale x 1 x i8> @stepvector_nxv1i8() {
; CHECK-LABEL: stepvector_nxv1i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf8, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x i8> @llvm.experimental.stepvector.nxv1i8()
  ret <vscale x 1 x i8> %v
}

declare <vscale x 2 x i8> @llvm.experimental.stepvector.nxv2i8()

define <vscale x 2 x i8> @stepvector_nxv2i8() {
; CHECK-LABEL: stepvector_nxv2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf4, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i8> @llvm.experimental.stepvector.nxv2i8()
  ret <vscale x 2 x i8> %v
}

declare <vscale x 4 x i8> @llvm.experimental.stepvector.nxv4i8()

define <vscale x 4 x i8> @stepvector_nxv4i8() {
; CHECK-LABEL: stepvector_nxv4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf2, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i8> @llvm.experimental.stepvector.nxv4i8()
  ret <vscale x 4 x i8> %v
}

declare <vscale x 8 x i8> @llvm.experimental.stepvector.nxv8i8()

define <vscale x 8 x i8> @stepvector_nxv8i8() {
; CHECK-LABEL: stepvector_nxv8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m1, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i8> @llvm.experimental.stepvector.nxv8i8()
  ret <vscale x 8 x i8> %v
}

define <vscale x 8 x i8> @add_stepvector_nxv8i8() {
; CHECK-LABEL: add_stepvector_nxv8i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, zero, e8, m1, ta, mu
; CHECK-NEXT:    vid.v v25
; CHECK-NEXT:    vsll.vi v8, v25, 1
; CHECK-NEXT:    ret
entry:
  %0 = call <vscale x 8 x i8> @llvm.experimental.stepvector.nxv8i8()
  %1 = call <vscale x 8 x i8> @llvm.experimental.stepvector.nxv8i8()
  %2 = add <vscale x 8 x i8> %0, %1
  ret <vscale x 8 x i8> %2
}

define <vscale x 8 x i8> @mul_stepvector_nxv8i8() {
; CHECK-LABEL: mul_stepvector_nxv8i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, zero, e8, m1, ta, mu
; CHECK-NEXT:    vid.v v25
; CHECK-NEXT:    addi a0, zero, 3
; CHECK-NEXT:    vmul.vx v8, v25, a0
; CHECK-NEXT:    ret
entry:
  %0 = insertelement <vscale x 8 x i8> poison, i8 3, i32 0
  %1 = shufflevector <vscale x 8 x i8> %0, <vscale x 8 x i8> poison, <vscale x 8 x i32> zeroinitializer
  %2 = call <vscale x 8 x i8> @llvm.experimental.stepvector.nxv8i8()
  %3 = mul <vscale x 8 x i8> %2, %1
  ret <vscale x 8 x i8> %3
}

define <vscale x 8 x i8> @shl_stepvector_nxv8i8() {
; CHECK-LABEL: shl_stepvector_nxv8i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, zero, e8, m1, ta, mu
; CHECK-NEXT:    vid.v v25
; CHECK-NEXT:    vsll.vi v8, v25, 2
; CHECK-NEXT:    ret
entry:
  %0 = insertelement <vscale x 8 x i8> poison, i8 2, i32 0
  %1 = shufflevector <vscale x 8 x i8> %0, <vscale x 8 x i8> poison, <vscale x 8 x i32> zeroinitializer
  %2 = call <vscale x 8 x i8> @llvm.experimental.stepvector.nxv8i8()
  %3 = shl <vscale x 8 x i8> %2, %1
  ret <vscale x 8 x i8> %3
}

declare <vscale x 16 x i8> @llvm.experimental.stepvector.nxv16i8()

define <vscale x 16 x i8> @stepvector_nxv16i8() {
; CHECK-LABEL: stepvector_nxv16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m2, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i8> @llvm.experimental.stepvector.nxv16i8()
  ret <vscale x 16 x i8> %v
}

declare <vscale x 32 x i8> @llvm.experimental.stepvector.nxv32i8()

define <vscale x 32 x i8> @stepvector_nxv32i8() {
; CHECK-LABEL: stepvector_nxv32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m4, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x i8> @llvm.experimental.stepvector.nxv32i8()
  ret <vscale x 32 x i8> %v
}

declare <vscale x 64 x i8> @llvm.experimental.stepvector.nxv64i8()

define <vscale x 64 x i8> @stepvector_nxv64i8() {
; CHECK-LABEL: stepvector_nxv64i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m8, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 64 x i8> @llvm.experimental.stepvector.nxv64i8()
  ret <vscale x 64 x i8> %v
}

declare <vscale x 1 x i16> @llvm.experimental.stepvector.nxv1i16()

define <vscale x 1 x i16> @stepvector_nxv1i16() {
; CHECK-LABEL: stepvector_nxv1i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf4, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x i16> @llvm.experimental.stepvector.nxv1i16()
  ret <vscale x 1 x i16> %v
}

declare <vscale x 2 x i16> @llvm.experimental.stepvector.nxv2i16()

define <vscale x 2 x i16> @stepvector_nxv2i16() {
; CHECK-LABEL: stepvector_nxv2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf2, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i16> @llvm.experimental.stepvector.nxv2i16()
  ret <vscale x 2 x i16> %v
}

declare <vscale x 4 x i16> @llvm.experimental.stepvector.nxv4i16()

define <vscale x 4 x i16> @stepvector_nxv4i16() {
; CHECK-LABEL: stepvector_nxv4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m1, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i16> @llvm.experimental.stepvector.nxv4i16()
  ret <vscale x 4 x i16> %v
}

declare <vscale x 8 x i16> @llvm.experimental.stepvector.nxv8i16()

define <vscale x 8 x i16> @stepvector_nxv8i16() {
; CHECK-LABEL: stepvector_nxv8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m2, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i16> @llvm.experimental.stepvector.nxv8i16()
  ret <vscale x 8 x i16> %v
}

declare <vscale x 16 x i16> @llvm.experimental.stepvector.nxv16i16()

define <vscale x 16 x i16> @stepvector_nxv16i16() {
; CHECK-LABEL: stepvector_nxv16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m4, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i16> @llvm.experimental.stepvector.nxv16i16()
  ret <vscale x 16 x i16> %v
}

define <vscale x 16 x i16> @add_stepvector_nxv16i16() {
; CHECK-LABEL: add_stepvector_nxv16i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, zero, e16, m4, ta, mu
; CHECK-NEXT:    vid.v v28
; CHECK-NEXT:    vsll.vi v8, v28, 1
; CHECK-NEXT:    ret
entry:
  %0 = call <vscale x 16 x i16> @llvm.experimental.stepvector.nxv16i16()
  %1 = call <vscale x 16 x i16> @llvm.experimental.stepvector.nxv16i16()
  %2 = add <vscale x 16 x i16> %0, %1
  ret <vscale x 16 x i16> %2
}

define <vscale x 16 x i16> @mul_stepvector_nxv16i16() {
; CHECK-LABEL: mul_stepvector_nxv16i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, zero, e16, m4, ta, mu
; CHECK-NEXT:    vid.v v28
; CHECK-NEXT:    addi a0, zero, 3
; CHECK-NEXT:    vmul.vx v8, v28, a0
; CHECK-NEXT:    ret
entry:
  %0 = insertelement <vscale x 16 x i16> poison, i16 3, i32 0
  %1 = shufflevector <vscale x 16 x i16> %0, <vscale x 16 x i16> poison, <vscale x 16 x i32> zeroinitializer
  %2 = call <vscale x 16 x i16> @llvm.experimental.stepvector.nxv16i16()
  %3 = mul <vscale x 16 x i16> %2, %1
  ret <vscale x 16 x i16> %3
}

define <vscale x 16 x i16> @shl_stepvector_nxv16i16() {
; CHECK-LABEL: shl_stepvector_nxv16i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, zero, e16, m4, ta, mu
; CHECK-NEXT:    vid.v v28
; CHECK-NEXT:    vsll.vi v8, v28, 2
; CHECK-NEXT:    ret
entry:
  %0 = insertelement <vscale x 16 x i16> poison, i16 2, i32 0
  %1 = shufflevector <vscale x 16 x i16> %0, <vscale x 16 x i16> poison, <vscale x 16 x i32> zeroinitializer
  %2 = call <vscale x 16 x i16> @llvm.experimental.stepvector.nxv16i16()
  %3 = shl <vscale x 16 x i16> %2, %1
  ret <vscale x 16 x i16> %3
}

declare <vscale x 32 x i16> @llvm.experimental.stepvector.nxv32i16()

define <vscale x 32 x i16> @stepvector_nxv32i16() {
; CHECK-LABEL: stepvector_nxv32i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m8, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x i16> @llvm.experimental.stepvector.nxv32i16()
  ret <vscale x 32 x i16> %v
}

declare <vscale x 1 x i32> @llvm.experimental.stepvector.nxv1i32()

define <vscale x 1 x i32> @stepvector_nxv1i32() {
; CHECK-LABEL: stepvector_nxv1i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, mf2, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x i32> @llvm.experimental.stepvector.nxv1i32()
  ret <vscale x 1 x i32> %v
}

declare <vscale x 2 x i32> @llvm.experimental.stepvector.nxv2i32()

define <vscale x 2 x i32> @stepvector_nxv2i32() {
; CHECK-LABEL: stepvector_nxv2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m1, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i32> @llvm.experimental.stepvector.nxv2i32()
  ret <vscale x 2 x i32> %v
}

declare <vscale x 4 x i32> @llvm.experimental.stepvector.nxv4i32()

define <vscale x 4 x i32> @stepvector_nxv4i32() {
; CHECK-LABEL: stepvector_nxv4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m2, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i32> @llvm.experimental.stepvector.nxv4i32()
  ret <vscale x 4 x i32> %v
}

declare <vscale x 8 x i32> @llvm.experimental.stepvector.nxv8i32()

define <vscale x 8 x i32> @stepvector_nxv8i32() {
; CHECK-LABEL: stepvector_nxv8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m4, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i32> @llvm.experimental.stepvector.nxv8i32()
  ret <vscale x 8 x i32> %v
}

declare <vscale x 16 x i32> @llvm.experimental.stepvector.nxv16i32()

define <vscale x 16 x i32> @stepvector_nxv16i32() {
; CHECK-LABEL: stepvector_nxv16i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i32> @llvm.experimental.stepvector.nxv16i32()
  ret <vscale x 16 x i32> %v
}

define <vscale x 16 x i32> @add_stepvector_nxv16i32() {
; CHECK-LABEL: add_stepvector_nxv16i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vsll.vi v8, v8, 1
; CHECK-NEXT:    ret
entry:
  %0 = call <vscale x 16 x i32> @llvm.experimental.stepvector.nxv16i32()
  %1 = call <vscale x 16 x i32> @llvm.experimental.stepvector.nxv16i32()
  %2 = add <vscale x 16 x i32> %0, %1
  ret <vscale x 16 x i32> %2
}

define <vscale x 16 x i32> @mul_stepvector_nxv16i32() {
; CHECK-LABEL: mul_stepvector_nxv16i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    addi a0, zero, 3
; CHECK-NEXT:    vmul.vx v8, v8, a0
; CHECK-NEXT:    ret
entry:
  %0 = insertelement <vscale x 16 x i32> poison, i32 3, i32 0
  %1 = shufflevector <vscale x 16 x i32> %0, <vscale x 16 x i32> poison, <vscale x 16 x i32> zeroinitializer
  %2 = call <vscale x 16 x i32> @llvm.experimental.stepvector.nxv16i32()
  %3 = mul <vscale x 16 x i32> %2, %1
  ret <vscale x 16 x i32> %3
}

define <vscale x 16 x i32> @shl_stepvector_nxv16i32() {
; CHECK-LABEL: shl_stepvector_nxv16i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vsll.vi v8, v8, 2
; CHECK-NEXT:    ret
entry:
  %0 = insertelement <vscale x 16 x i32> poison, i32 2, i32 0
  %1 = shufflevector <vscale x 16 x i32> %0, <vscale x 16 x i32> poison, <vscale x 16 x i32> zeroinitializer
  %2 = call <vscale x 16 x i32> @llvm.experimental.stepvector.nxv16i32()
  %3 = shl <vscale x 16 x i32> %2, %1
  ret <vscale x 16 x i32> %3
}

declare <vscale x 1 x i64> @llvm.experimental.stepvector.nxv1i64()

define <vscale x 1 x i64> @stepvector_nxv1i64() {
; CHECK-LABEL: stepvector_nxv1i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x i64> @llvm.experimental.stepvector.nxv1i64()
  ret <vscale x 1 x i64> %v
}

declare <vscale x 2 x i64> @llvm.experimental.stepvector.nxv2i64()

define <vscale x 2 x i64> @stepvector_nxv2i64() {
; CHECK-LABEL: stepvector_nxv2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m2, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i64> @llvm.experimental.stepvector.nxv2i64()
  ret <vscale x 2 x i64> %v
}

declare <vscale x 4 x i64> @llvm.experimental.stepvector.nxv4i64()

define <vscale x 4 x i64> @stepvector_nxv4i64() {
; CHECK-LABEL: stepvector_nxv4i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m4, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i64> @llvm.experimental.stepvector.nxv4i64()
  ret <vscale x 4 x i64> %v
}

declare <vscale x 8 x i64> @llvm.experimental.stepvector.nxv8i64()

define <vscale x 8 x i64> @stepvector_nxv8i64() {
; CHECK-LABEL: stepvector_nxv8i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i64> @llvm.experimental.stepvector.nxv8i64()
  ret <vscale x 8 x i64> %v
}

define <vscale x 8 x i64> @add_stepvector_nxv8i64() {
; CHECK-LABEL: add_stepvector_nxv8i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vsll.vi v8, v8, 1
; CHECK-NEXT:    ret
entry:
  %0 = call <vscale x 8 x i64> @llvm.experimental.stepvector.nxv8i64()
  %1 = call <vscale x 8 x i64> @llvm.experimental.stepvector.nxv8i64()
  %2 = add <vscale x 8 x i64> %0, %1
  ret <vscale x 8 x i64> %2
}

define <vscale x 8 x i64> @mul_stepvector_nxv8i64() {
; CHECK-LABEL: mul_stepvector_nxv8i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    addi a0, zero, 3
; CHECK-NEXT:    vmul.vx v8, v8, a0
; CHECK-NEXT:    ret
entry:
  %0 = insertelement <vscale x 8 x i64> poison, i64 3, i32 0
  %1 = shufflevector <vscale x 8 x i64> %0, <vscale x 8 x i64> poison, <vscale x 8 x i32> zeroinitializer
  %2 = call <vscale x 8 x i64> @llvm.experimental.stepvector.nxv8i64()
  %3 = mul <vscale x 8 x i64> %2, %1
  ret <vscale x 8 x i64> %3
}

define <vscale x 8 x i64> @shl_stepvector_nxv8i64() {
; CHECK-LABEL: shl_stepvector_nxv8i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vsll.vi v8, v8, 2
; CHECK-NEXT:    ret
entry:
  %0 = insertelement <vscale x 8 x i64> poison, i64 2, i32 0
  %1 = shufflevector <vscale x 8 x i64> %0, <vscale x 8 x i64> poison, <vscale x 8 x i32> zeroinitializer
  %2 = call <vscale x 8 x i64> @llvm.experimental.stepvector.nxv8i64()
  %3 = shl <vscale x 8 x i64> %2, %1
  ret <vscale x 8 x i64> %3
}

declare <vscale x 16 x i64> @llvm.experimental.stepvector.nxv16i64()

define <vscale x 16 x i64> @stepvector_nxv16i64() {
; CHECK-LABEL: stepvector_nxv16i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    vsetvli a1, zero, e64, m8, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vadd.vx v16, v8, a0
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i64> @llvm.experimental.stepvector.nxv16i64()
  ret <vscale x 16 x i64> %v
}

define <vscale x 16 x i64> @add_stepvector_nxv16i64() {
; CHECK-LABEL: add_stepvector_nxv16i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 1
; CHECK-NEXT:    vsetvli a1, zero, e64, m8, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vsll.vi v8, v8, 1
; CHECK-NEXT:    vadd.vx v16, v8, a0
; CHECK-NEXT:    ret
entry:
  %0 = call <vscale x 16 x i64> @llvm.experimental.stepvector.nxv16i64()
  %1 = call <vscale x 16 x i64> @llvm.experimental.stepvector.nxv16i64()
  %2 = add <vscale x 16 x i64> %0, %1
  ret <vscale x 16 x i64> %2
}

define <vscale x 16 x i64> @mul_stepvector_nxv16i64() {
; CHECK-LABEL: mul_stepvector_nxv16i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    addi a0, zero, 3
; CHECK-NEXT:    vmul.vx v8, v8, a0
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a1, a0, 1
; CHECK-NEXT:    add a0, a1, a0
; CHECK-NEXT:    vadd.vx v16, v8, a0
; CHECK-NEXT:    ret
entry:
  %0 = insertelement <vscale x 16 x i64> poison, i64 3, i32 0
  %1 = shufflevector <vscale x 16 x i64> %0, <vscale x 16 x i64> poison, <vscale x 16 x i32> zeroinitializer
  %2 = call <vscale x 16 x i64> @llvm.experimental.stepvector.nxv16i64()
  %3 = mul <vscale x 16 x i64> %2, %1
  ret <vscale x 16 x i64> %3
}

define <vscale x 16 x i64> @shl_stepvector_nxv16i64() {
; CHECK-LABEL: shl_stepvector_nxv16i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 2
; CHECK-NEXT:    vsetvli a1, zero, e64, m8, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vsll.vi v8, v8, 2
; CHECK-NEXT:    vadd.vx v16, v8, a0
; CHECK-NEXT:    ret
entry:
  %0 = insertelement <vscale x 16 x i64> poison, i64 2, i32 0
  %1 = shufflevector <vscale x 16 x i64> %0, <vscale x 16 x i64> poison, <vscale x 16 x i32> zeroinitializer
  %2 = call <vscale x 16 x i64> @llvm.experimental.stepvector.nxv16i64()
  %3 = shl <vscale x 16 x i64> %2, %1
  ret <vscale x 16 x i64> %3
}
