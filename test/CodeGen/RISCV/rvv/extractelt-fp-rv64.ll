; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -mattr=+d,+experimental-zfh,+experimental-v -target-abi=lp64d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s

define half @extractelt_nxv1f16_0(<vscale x 1 x half> %v) {
; CHECK-LABEL: extractelt_nxv1f16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, zero, e16,mf4,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 1 x half> %v, i32 0
  ret half %r
}

define half @extractelt_nxv1f16_imm(<vscale x 1 x half> %v) {
; CHECK-LABEL: extractelt_nxv1f16_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 1, e16,mf4,ta,mu
; CHECK-NEXT:    vslidedown.vi v25, v8, 2
; CHECK-NEXT:    vsetvli zero, zero, e16,mf4,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v25
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 1 x half> %v, i32 2
  ret half %r
}

define half @extractelt_nxv1f16_idx(<vscale x 1 x half> %v, i32 signext %idx) {
; CHECK-LABEL: extractelt_nxv1f16_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a1, 1, e16,mf4,ta,mu
; CHECK-NEXT:    vslidedown.vx v25, v8, a0
; CHECK-NEXT:    vsetvli zero, zero, e16,mf4,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v25
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 1 x half> %v, i32 %idx
  ret half %r
}

define half @extractelt_nxv2f16_0(<vscale x 2 x half> %v) {
; CHECK-LABEL: extractelt_nxv2f16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, zero, e16,mf2,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 2 x half> %v, i32 0
  ret half %r
}

define half @extractelt_nxv2f16_imm(<vscale x 2 x half> %v) {
; CHECK-LABEL: extractelt_nxv2f16_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 1, e16,mf2,ta,mu
; CHECK-NEXT:    vslidedown.vi v25, v8, 2
; CHECK-NEXT:    vsetvli zero, zero, e16,mf2,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v25
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 2 x half> %v, i32 2
  ret half %r
}

define half @extractelt_nxv2f16_idx(<vscale x 2 x half> %v, i32 signext %idx) {
; CHECK-LABEL: extractelt_nxv2f16_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a1, 1, e16,mf2,ta,mu
; CHECK-NEXT:    vslidedown.vx v25, v8, a0
; CHECK-NEXT:    vsetvli zero, zero, e16,mf2,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v25
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 2 x half> %v, i32 %idx
  ret half %r
}

define half @extractelt_nxv4f16_0(<vscale x 4 x half> %v) {
; CHECK-LABEL: extractelt_nxv4f16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, zero, e16,m1,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 4 x half> %v, i32 0
  ret half %r
}

define half @extractelt_nxv4f16_imm(<vscale x 4 x half> %v) {
; CHECK-LABEL: extractelt_nxv4f16_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 1, e16,m1,ta,mu
; CHECK-NEXT:    vslidedown.vi v25, v8, 2
; CHECK-NEXT:    vsetvli zero, zero, e16,m1,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v25
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 4 x half> %v, i32 2
  ret half %r
}

define half @extractelt_nxv4f16_idx(<vscale x 4 x half> %v, i32 signext %idx) {
; CHECK-LABEL: extractelt_nxv4f16_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a1, 1, e16,m1,ta,mu
; CHECK-NEXT:    vslidedown.vx v25, v8, a0
; CHECK-NEXT:    vsetvli zero, zero, e16,m1,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v25
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 4 x half> %v, i32 %idx
  ret half %r
}

define half @extractelt_nxv8f16_0(<vscale x 8 x half> %v) {
; CHECK-LABEL: extractelt_nxv8f16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, zero, e16,m2,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 8 x half> %v, i32 0
  ret half %r
}

define half @extractelt_nxv8f16_imm(<vscale x 8 x half> %v) {
; CHECK-LABEL: extractelt_nxv8f16_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 1, e16,m2,ta,mu
; CHECK-NEXT:    vslidedown.vi v26, v8, 2
; CHECK-NEXT:    vsetvli zero, zero, e16,m2,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v26
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 8 x half> %v, i32 2
  ret half %r
}

define half @extractelt_nxv8f16_idx(<vscale x 8 x half> %v, i32 signext %idx) {
; CHECK-LABEL: extractelt_nxv8f16_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a1, 1, e16,m2,ta,mu
; CHECK-NEXT:    vslidedown.vx v26, v8, a0
; CHECK-NEXT:    vsetvli zero, zero, e16,m2,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v26
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 8 x half> %v, i32 %idx
  ret half %r
}

define half @extractelt_nxv16f16_0(<vscale x 16 x half> %v) {
; CHECK-LABEL: extractelt_nxv16f16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, zero, e16,m4,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 16 x half> %v, i32 0
  ret half %r
}

define half @extractelt_nxv16f16_imm(<vscale x 16 x half> %v) {
; CHECK-LABEL: extractelt_nxv16f16_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 1, e16,m4,ta,mu
; CHECK-NEXT:    vslidedown.vi v28, v8, 2
; CHECK-NEXT:    vsetvli zero, zero, e16,m4,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v28
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 16 x half> %v, i32 2
  ret half %r
}

define half @extractelt_nxv16f16_idx(<vscale x 16 x half> %v, i32 signext %idx) {
; CHECK-LABEL: extractelt_nxv16f16_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a1, 1, e16,m4,ta,mu
; CHECK-NEXT:    vslidedown.vx v28, v8, a0
; CHECK-NEXT:    vsetvli zero, zero, e16,m4,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v28
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 16 x half> %v, i32 %idx
  ret half %r
}

define half @extractelt_nxv32f16_0(<vscale x 32 x half> %v) {
; CHECK-LABEL: extractelt_nxv32f16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, zero, e16,m8,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 32 x half> %v, i32 0
  ret half %r
}

define half @extractelt_nxv32f16_imm(<vscale x 32 x half> %v) {
; CHECK-LABEL: extractelt_nxv32f16_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 1, e16,m8,ta,mu
; CHECK-NEXT:    vslidedown.vi v8, v8, 2
; CHECK-NEXT:    vsetvli zero, zero, e16,m8,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 32 x half> %v, i32 2
  ret half %r
}

define half @extractelt_nxv32f16_idx(<vscale x 32 x half> %v, i32 signext %idx) {
; CHECK-LABEL: extractelt_nxv32f16_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a1, 1, e16,m8,ta,mu
; CHECK-NEXT:    vslidedown.vx v8, v8, a0
; CHECK-NEXT:    vsetvli zero, zero, e16,m8,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 32 x half> %v, i32 %idx
  ret half %r
}

define float @extractelt_nxv1f32_0(<vscale x 1 x float> %v) {
; CHECK-LABEL: extractelt_nxv1f32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, zero, e32,mf2,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 1 x float> %v, i32 0
  ret float %r
}

define float @extractelt_nxv1f32_imm(<vscale x 1 x float> %v) {
; CHECK-LABEL: extractelt_nxv1f32_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 1, e32,mf2,ta,mu
; CHECK-NEXT:    vslidedown.vi v25, v8, 2
; CHECK-NEXT:    vsetvli zero, zero, e32,mf2,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v25
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 1 x float> %v, i32 2
  ret float %r
}

define float @extractelt_nxv1f32_idx(<vscale x 1 x float> %v, i32 signext %idx) {
; CHECK-LABEL: extractelt_nxv1f32_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a1, 1, e32,mf2,ta,mu
; CHECK-NEXT:    vslidedown.vx v25, v8, a0
; CHECK-NEXT:    vsetvli zero, zero, e32,mf2,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v25
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 1 x float> %v, i32 %idx
  ret float %r
}

define float @extractelt_nxv2f32_0(<vscale x 2 x float> %v) {
; CHECK-LABEL: extractelt_nxv2f32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, zero, e32,m1,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 2 x float> %v, i32 0
  ret float %r
}

define float @extractelt_nxv2f32_imm(<vscale x 2 x float> %v) {
; CHECK-LABEL: extractelt_nxv2f32_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 1, e32,m1,ta,mu
; CHECK-NEXT:    vslidedown.vi v25, v8, 2
; CHECK-NEXT:    vsetvli zero, zero, e32,m1,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v25
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 2 x float> %v, i32 2
  ret float %r
}

define float @extractelt_nxv2f32_idx(<vscale x 2 x float> %v, i32 signext %idx) {
; CHECK-LABEL: extractelt_nxv2f32_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a1, 1, e32,m1,ta,mu
; CHECK-NEXT:    vslidedown.vx v25, v8, a0
; CHECK-NEXT:    vsetvli zero, zero, e32,m1,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v25
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 2 x float> %v, i32 %idx
  ret float %r
}

define float @extractelt_nxv4f32_0(<vscale x 4 x float> %v) {
; CHECK-LABEL: extractelt_nxv4f32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, zero, e32,m2,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 4 x float> %v, i32 0
  ret float %r
}

define float @extractelt_nxv4f32_imm(<vscale x 4 x float> %v) {
; CHECK-LABEL: extractelt_nxv4f32_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 1, e32,m2,ta,mu
; CHECK-NEXT:    vslidedown.vi v26, v8, 2
; CHECK-NEXT:    vsetvli zero, zero, e32,m2,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v26
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 4 x float> %v, i32 2
  ret float %r
}

define float @extractelt_nxv4f32_idx(<vscale x 4 x float> %v, i32 signext %idx) {
; CHECK-LABEL: extractelt_nxv4f32_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a1, 1, e32,m2,ta,mu
; CHECK-NEXT:    vslidedown.vx v26, v8, a0
; CHECK-NEXT:    vsetvli zero, zero, e32,m2,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v26
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 4 x float> %v, i32 %idx
  ret float %r
}

define float @extractelt_nxv8f32_0(<vscale x 8 x float> %v) {
; CHECK-LABEL: extractelt_nxv8f32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, zero, e32,m4,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 8 x float> %v, i32 0
  ret float %r
}

define float @extractelt_nxv8f32_imm(<vscale x 8 x float> %v) {
; CHECK-LABEL: extractelt_nxv8f32_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 1, e32,m4,ta,mu
; CHECK-NEXT:    vslidedown.vi v28, v8, 2
; CHECK-NEXT:    vsetvli zero, zero, e32,m4,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v28
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 8 x float> %v, i32 2
  ret float %r
}

define float @extractelt_nxv8f32_idx(<vscale x 8 x float> %v, i32 signext %idx) {
; CHECK-LABEL: extractelt_nxv8f32_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a1, 1, e32,m4,ta,mu
; CHECK-NEXT:    vslidedown.vx v28, v8, a0
; CHECK-NEXT:    vsetvli zero, zero, e32,m4,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v28
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 8 x float> %v, i32 %idx
  ret float %r
}

define float @extractelt_nxv16f32_0(<vscale x 16 x float> %v) {
; CHECK-LABEL: extractelt_nxv16f32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, zero, e32,m8,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 16 x float> %v, i32 0
  ret float %r
}

define float @extractelt_nxv16f32_imm(<vscale x 16 x float> %v) {
; CHECK-LABEL: extractelt_nxv16f32_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 1, e32,m8,ta,mu
; CHECK-NEXT:    vslidedown.vi v8, v8, 2
; CHECK-NEXT:    vsetvli zero, zero, e32,m8,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 16 x float> %v, i32 2
  ret float %r
}

define float @extractelt_nxv16f32_idx(<vscale x 16 x float> %v, i32 signext %idx) {
; CHECK-LABEL: extractelt_nxv16f32_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a1, 1, e32,m8,ta,mu
; CHECK-NEXT:    vslidedown.vx v8, v8, a0
; CHECK-NEXT:    vsetvli zero, zero, e32,m8,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 16 x float> %v, i32 %idx
  ret float %r
}

define double @extractelt_nxv1f64_0(<vscale x 1 x double> %v) {
; CHECK-LABEL: extractelt_nxv1f64_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, zero, e64,m1,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 1 x double> %v, i32 0
  ret double %r
}

define double @extractelt_nxv1f64_imm(<vscale x 1 x double> %v) {
; CHECK-LABEL: extractelt_nxv1f64_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 1, e64,m1,ta,mu
; CHECK-NEXT:    vslidedown.vi v25, v8, 2
; CHECK-NEXT:    vsetvli zero, zero, e64,m1,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v25
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 1 x double> %v, i32 2
  ret double %r
}

define double @extractelt_nxv1f64_idx(<vscale x 1 x double> %v, i32 signext %idx) {
; CHECK-LABEL: extractelt_nxv1f64_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a1, 1, e64,m1,ta,mu
; CHECK-NEXT:    vslidedown.vx v25, v8, a0
; CHECK-NEXT:    vsetvli zero, zero, e64,m1,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v25
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 1 x double> %v, i32 %idx
  ret double %r
}

define double @extractelt_nxv2f64_0(<vscale x 2 x double> %v) {
; CHECK-LABEL: extractelt_nxv2f64_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, zero, e64,m2,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 2 x double> %v, i32 0
  ret double %r
}

define double @extractelt_nxv2f64_imm(<vscale x 2 x double> %v) {
; CHECK-LABEL: extractelt_nxv2f64_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 1, e64,m2,ta,mu
; CHECK-NEXT:    vslidedown.vi v26, v8, 2
; CHECK-NEXT:    vsetvli zero, zero, e64,m2,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v26
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 2 x double> %v, i32 2
  ret double %r
}

define double @extractelt_nxv2f64_idx(<vscale x 2 x double> %v, i32 signext %idx) {
; CHECK-LABEL: extractelt_nxv2f64_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a1, 1, e64,m2,ta,mu
; CHECK-NEXT:    vslidedown.vx v26, v8, a0
; CHECK-NEXT:    vsetvli zero, zero, e64,m2,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v26
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 2 x double> %v, i32 %idx
  ret double %r
}

define double @extractelt_nxv4f64_0(<vscale x 4 x double> %v) {
; CHECK-LABEL: extractelt_nxv4f64_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, zero, e64,m4,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 4 x double> %v, i32 0
  ret double %r
}

define double @extractelt_nxv4f64_imm(<vscale x 4 x double> %v) {
; CHECK-LABEL: extractelt_nxv4f64_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 1, e64,m4,ta,mu
; CHECK-NEXT:    vslidedown.vi v28, v8, 2
; CHECK-NEXT:    vsetvli zero, zero, e64,m4,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v28
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 4 x double> %v, i32 2
  ret double %r
}

define double @extractelt_nxv4f64_idx(<vscale x 4 x double> %v, i32 signext %idx) {
; CHECK-LABEL: extractelt_nxv4f64_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a1, 1, e64,m4,ta,mu
; CHECK-NEXT:    vslidedown.vx v28, v8, a0
; CHECK-NEXT:    vsetvli zero, zero, e64,m4,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v28
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 4 x double> %v, i32 %idx
  ret double %r
}

define double @extractelt_nxv8f64_0(<vscale x 8 x double> %v) {
; CHECK-LABEL: extractelt_nxv8f64_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, zero, e64,m8,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 8 x double> %v, i32 0
  ret double %r
}

define double @extractelt_nxv8f64_imm(<vscale x 8 x double> %v) {
; CHECK-LABEL: extractelt_nxv8f64_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 1, e64,m8,ta,mu
; CHECK-NEXT:    vslidedown.vi v8, v8, 2
; CHECK-NEXT:    vsetvli zero, zero, e64,m8,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 8 x double> %v, i32 2
  ret double %r
}

define double @extractelt_nxv8f64_idx(<vscale x 8 x double> %v, i32 signext %idx) {
; CHECK-LABEL: extractelt_nxv8f64_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a1, 1, e64,m8,ta,mu
; CHECK-NEXT:    vslidedown.vx v8, v8, a0
; CHECK-NEXT:    vsetvli zero, zero, e64,m8,ta,mu
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 8 x double> %v, i32 %idx
  ret double %r
}

