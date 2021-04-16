; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s --check-prefixes=CHECK

define <vscale x 2 x i64> @insert_v2i64_nxv2i64(<vscale x 2 x i64> %vec, <2 x i64> %subvec) nounwind {
; CHECK-LABEL: insert_v2i64_nxv2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    st1d { z0.d }, p0, [sp]
; CHECK-NEXT:    str q1, [sp]
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [sp]
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %retval = call <vscale x 2 x i64> @llvm.experimental.vector.insert.nxv2i64.v2i64(<vscale x 2 x i64> %vec, <2 x i64> %subvec, i64 0)
  ret <vscale x 2 x i64> %retval
}

define <vscale x 2 x i64> @insert_v2i64_nxv2i64_idx1(<vscale x 2 x i64> %vec, <2 x i64> %subvec) nounwind {
; CHECK-LABEL: insert_v2i64_nxv2i64_idx1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    st1d { z0.d }, p0, [sp]
; CHECK-NEXT:    stur q1, [sp, #8]
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [sp]
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %retval = call <vscale x 2 x i64> @llvm.experimental.vector.insert.nxv2i64.v2i64(<vscale x 2 x i64> %vec, <2 x i64> %subvec, i64 1)
  ret <vscale x 2 x i64> %retval
}

define <vscale x 4 x i32> @insert_v4i32_nxv4i32(<vscale x 4 x i32> %vec, <4 x i32> %subvec) nounwind {
; CHECK-LABEL: insert_v4i32_nxv4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    st1w { z0.s }, p0, [sp]
; CHECK-NEXT:    str q1, [sp]
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [sp]
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %retval = call <vscale x 4 x i32> @llvm.experimental.vector.insert.nxv4i32.v4i32(<vscale x 4 x i32> %vec, <4 x i32> %subvec, i64 0)
  ret <vscale x 4 x i32> %retval
}

define <vscale x 4 x i32> @insert_v4i32_nxv4i32_idx1(<vscale x 4 x i32> %vec, <4 x i32> %subvec) nounwind {
; CHECK-LABEL: insert_v4i32_nxv4i32_idx1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    st1w { z0.s }, p0, [sp]
; CHECK-NEXT:    stur q1, [sp, #4]
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [sp]
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %retval = call <vscale x 4 x i32> @llvm.experimental.vector.insert.nxv4i32.v4i32(<vscale x 4 x i32> %vec, <4 x i32> %subvec, i64 1)
  ret <vscale x 4 x i32> %retval
}

define <vscale x 8 x i16> @insert_v8i16_nxv8i16(<vscale x 8 x i16> %vec, <8 x i16> %subvec) nounwind {
; CHECK-LABEL: insert_v8i16_nxv8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    st1h { z0.h }, p0, [sp]
; CHECK-NEXT:    str q1, [sp]
; CHECK-NEXT:    ld1h { z0.h }, p0/z, [sp]
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %retval = call <vscale x 8 x i16> @llvm.experimental.vector.insert.nxv8i16.v8i16(<vscale x 8 x i16> %vec, <8 x i16> %subvec, i64 0)
  ret <vscale x 8 x i16> %retval
}

define <vscale x 8 x i16> @insert_v8i16_nxv8i16_idx1(<vscale x 8 x i16> %vec, <8 x i16> %subvec) nounwind {
; CHECK-LABEL: insert_v8i16_nxv8i16_idx1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    st1h { z0.h }, p0, [sp]
; CHECK-NEXT:    stur q1, [sp, #2]
; CHECK-NEXT:    ld1h { z0.h }, p0/z, [sp]
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %retval = call <vscale x 8 x i16> @llvm.experimental.vector.insert.nxv8i16.v8i16(<vscale x 8 x i16> %vec, <8 x i16> %subvec, i64 1)
  ret <vscale x 8 x i16> %retval
}

define <vscale x 16 x i8> @insert_v16i8_nxv16i8(<vscale x 16 x i8> %vec, <16 x i8> %subvec) nounwind {
; CHECK-LABEL: insert_v16i8_nxv16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    ptrue p0.b
; CHECK-NEXT:    st1b { z0.b }, p0, [sp]
; CHECK-NEXT:    str q1, [sp]
; CHECK-NEXT:    ld1b { z0.b }, p0/z, [sp]
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %retval = call <vscale x 16 x i8> @llvm.experimental.vector.insert.nxv16i8.v16i8(<vscale x 16 x i8> %vec, <16 x i8> %subvec, i64 0)
  ret <vscale x 16 x i8> %retval
}

define <vscale x 16 x i8> @insert_v16i8_nxv16i8_idx1(<vscale x 16 x i8> %vec, <16 x i8> %subvec) nounwind {
; CHECK-LABEL: insert_v16i8_nxv16i8_idx1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    ptrue p0.b
; CHECK-NEXT:    st1b { z0.b }, p0, [sp]
; CHECK-NEXT:    stur q1, [sp, #1]
; CHECK-NEXT:    ld1b { z0.b }, p0/z, [sp]
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %retval = call <vscale x 16 x i8> @llvm.experimental.vector.insert.nxv16i8.v16i8(<vscale x 16 x i8> %vec, <16 x i8> %subvec, i64 1)
  ret <vscale x 16 x i8> %retval
}


; Insert subvectors into illegal vectors

define void @insert_nxv8i64_nxv16i64(<vscale x 8 x i64> %sv0, <vscale x 8 x i64> %sv1, <vscale x 16 x i64>* %out) {
; CHECK-LABEL: insert_nxv8i64_nxv16i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    st1d { z7.d }, p0, [x0, #7, mul vl]
; CHECK-NEXT:    st1d { z6.d }, p0, [x0, #6, mul vl]
; CHECK-NEXT:    st1d { z5.d }, p0, [x0, #5, mul vl]
; CHECK-NEXT:    st1d { z4.d }, p0, [x0, #4, mul vl]
; CHECK-NEXT:    st1d { z3.d }, p0, [x0, #3, mul vl]
; CHECK-NEXT:    st1d { z2.d }, p0, [x0, #2, mul vl]
; CHECK-NEXT:    st1d { z1.d }, p0, [x0, #1, mul vl]
; CHECK-NEXT:    st1d { z0.d }, p0, [x0]
; CHECK-NEXT:    ret
  %v0 = call <vscale x 16 x i64> @llvm.experimental.vector.insert.nxv8i64.nxv16i64(<vscale x 16 x i64> undef, <vscale x 8 x i64> %sv0, i64 0)
  %v = call <vscale x 16 x i64> @llvm.experimental.vector.insert.nxv8i64.nxv16i64(<vscale x 16 x i64> %v0, <vscale x 8 x i64> %sv1, i64 8)
  store <vscale x 16 x i64> %v, <vscale x 16 x i64>* %out
  ret void
}

define void @insert_nxv8i64_nxv16i64_lo(<vscale x 8 x i64> %sv0, <vscale x 16 x i64>* %out) {
; CHECK-LABEL: insert_nxv8i64_nxv16i64_lo:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    st1d { z3.d }, p0, [x0, #3, mul vl]
; CHECK-NEXT:    st1d { z2.d }, p0, [x0, #2, mul vl]
; CHECK-NEXT:    st1d { z1.d }, p0, [x0, #1, mul vl]
; CHECK-NEXT:    st1d { z0.d }, p0, [x0]
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i64> @llvm.experimental.vector.insert.nxv8i64.nxv16i64(<vscale x 16 x i64> undef, <vscale x 8 x i64> %sv0, i64 0)
  store <vscale x 16 x i64> %v, <vscale x 16 x i64>* %out
  ret void
}

define void @insert_nxv8i64_nxv16i64_hi(<vscale x 8 x i64> %sv0, <vscale x 16 x i64>* %out) {
; CHECK-LABEL: insert_nxv8i64_nxv16i64_hi:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    st1d { z3.d }, p0, [x0, #7, mul vl]
; CHECK-NEXT:    st1d { z2.d }, p0, [x0, #6, mul vl]
; CHECK-NEXT:    st1d { z1.d }, p0, [x0, #5, mul vl]
; CHECK-NEXT:    st1d { z0.d }, p0, [x0, #4, mul vl]
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i64> @llvm.experimental.vector.insert.nxv8i64.nxv16i64(<vscale x 16 x i64> undef, <vscale x 8 x i64> %sv0, i64 8)
  store <vscale x 16 x i64> %v, <vscale x 16 x i64>* %out
  ret void
}

define void @insert_v2i64_nxv16i64(<2 x i64> %sv0, <2 x i64> %sv1, <vscale x 16 x i64>* %out) {
; CHECK-LABEL: insert_v2i64_nxv16i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-4
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0c, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x20, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 32 * VG
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    mov x8, sp
; CHECK-NEXT:    st1d { z0.d }, p0, [sp]
; CHECK-NEXT:    str q1, [sp, #32]
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x8, #1, mul vl]
; CHECK-NEXT:    ld1d { z1.d }, p0/z, [x8, #2, mul vl]
; CHECK-NEXT:    ld1d { z2.d }, p0/z, [x8, #3, mul vl]
; CHECK-NEXT:    ld1d { z3.d }, p0/z, [sp]
; CHECK-NEXT:    st1d { z2.d }, p0, [x0, #3, mul vl]
; CHECK-NEXT:    st1d { z1.d }, p0, [x0, #2, mul vl]
; CHECK-NEXT:    st1d { z0.d }, p0, [x0, #1, mul vl]
; CHECK-NEXT:    st1d { z3.d }, p0, [x0]
; CHECK-NEXT:    addvl sp, sp, #4
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %v0 = call <vscale x 16 x i64> @llvm.experimental.vector.insert.v2i64.nxv16i64(<vscale x 16 x i64> undef, <2 x i64> %sv0, i64 0)
  %v = call <vscale x 16 x i64> @llvm.experimental.vector.insert.v2i64.nxv16i64(<vscale x 16 x i64> %v0, <2 x i64> %sv1, i64 4)
  store <vscale x 16 x i64> %v, <vscale x 16 x i64>* %out
  ret void
}

define void @insert_v2i64_nxv16i64_lo0(<2 x i64>* %psv, <vscale x 16 x i64>* %out) {
; CHECK-LABEL: insert_v2i64_nxv16i64_lo0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    st1d { z0.d }, p0, [x1]
; CHECK-NEXT:    ret
  %sv = load <2 x i64>, <2 x i64>* %psv
  %v = call <vscale x 16 x i64> @llvm.experimental.vector.insert.v2i64.nxv16i64(<vscale x 16 x i64> undef, <2 x i64> %sv, i64 0)
  store <vscale x 16 x i64> %v, <vscale x 16 x i64>* %out
  ret void
}

define void @insert_v2i64_nxv16i64_lo2(<2 x i64>* %psv, <vscale x 16 x i64>* %out) {
; CHECK-LABEL: insert_v2i64_nxv16i64_lo2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-2
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0c, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x10, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 16 * VG
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    mov x8, sp
; CHECK-NEXT:    str q0, [sp, #16]
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x8, #1, mul vl]
; CHECK-NEXT:    ld1d { z1.d }, p0/z, [sp]
; CHECK-NEXT:    st1d { z0.d }, p0, [x1, #1, mul vl]
; CHECK-NEXT:    st1d { z1.d }, p0, [x1]
; CHECK-NEXT:    addvl sp, sp, #2
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %sv = load <2 x i64>, <2 x i64>* %psv
  %v = call <vscale x 16 x i64> @llvm.experimental.vector.insert.v2i64.nxv16i64(<vscale x 16 x i64> undef, <2 x i64> %sv, i64 2)
  store <vscale x 16 x i64> %v, <vscale x 16 x i64>* %out
  ret void
}


declare <vscale x 2 x i64> @llvm.experimental.vector.insert.nxv2i64.v2i64(<vscale x 2 x i64>, <2 x i64>, i64)
declare <vscale x 4 x i32> @llvm.experimental.vector.insert.nxv4i32.v4i32(<vscale x 4 x i32>, <4 x i32>, i64)
declare <vscale x 8 x i16> @llvm.experimental.vector.insert.nxv8i16.v8i16(<vscale x 8 x i16>, <8 x i16>, i64)
declare <vscale x 16 x i8> @llvm.experimental.vector.insert.nxv16i8.v16i8(<vscale x 16 x i8>, <16 x i8>, i64)

declare <vscale x 16 x i64> @llvm.experimental.vector.insert.nxv8i64.nxv16i64(<vscale x 16 x i64>, <vscale x 8 x i64>, i64)
declare <vscale x 16 x i64> @llvm.experimental.vector.insert.v2i64.nxv16i64(<vscale x 16 x i64>, <2 x i64>, i64)
