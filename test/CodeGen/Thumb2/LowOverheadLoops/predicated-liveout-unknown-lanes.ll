; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+mve.fp -O3 -tail-predication=force-enabled-no-reductions %s -o - | FileCheck %s

define arm_aapcs_vfpcc <4 x float> @arm_max_no_idx_f32_mve(float* %pSrc, i32 %blockSize, float* nocapture %pResult) {
; CHECK-LABEL: arm_max_no_idx_f32_mve:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r7, lr}
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    subs r2, r1, #4
; CHECK-NEXT:    movw r3, #0
; CHECK-NEXT:    movt r3, #65408
; CHECK-NEXT:    vdup.32 q0, r3
; CHECK-NEXT:    dlstp.32 lr, r1
; CHECK-NEXT:  .LBB0_1: @ %do.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrw.u32 q1, [r0], #16
; CHECK-NEXT:    vmaxnm.f32 q0, q1, q0
; CHECK-NEXT:    letp lr, .LBB0_1
; CHECK-NEXT:  @ %bb.2: @ %do.end
; CHECK-NEXT:    pop {r7, pc}
entry:
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %blockSize.addr.0 = phi i32 [ %blockSize, %entry ], [ %sub, %do.body ]
  %curExtremValVec.0 = phi <4 x float> [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %entry ], [ %3, %do.body ]
  %pSrc.addr.0 = phi float* [ %pSrc, %entry ], [ %add.ptr, %do.body ]
  %0 = tail call <4 x i1> @llvm.arm.mve.vctp32(i32 %blockSize.addr.0)
  %1 = bitcast float* %pSrc.addr.0 to <4 x float>*
  %2 = tail call fast <4 x float> @llvm.masked.load.v4f32.p0v4f32(<4 x float>* %1, i32 4, <4 x i1> %0, <4 x float> zeroinitializer)
  %3 = tail call fast <4 x float> @llvm.arm.mve.max.predicated.v4f32.v4i1(<4 x float> %2, <4 x float> %curExtremValVec.0, i32 0, <4 x i1> %0, <4 x float> %curExtremValVec.0)
  %add.ptr = getelementptr inbounds float, float* %pSrc.addr.0, i32 4
  %sub = add i32 %blockSize.addr.0, -4
  %cmp = icmp sgt i32 %sub, 0
  br i1 %cmp, label %do.body, label %do.end

do.end:                                           ; preds = %do.body
  ret <4 x float> %3
}

declare <4 x i1> @llvm.arm.mve.vctp32(i32)

declare <4 x float> @llvm.masked.load.v4f32.p0v4f32(<4 x float>*, i32 immarg, <4 x i1>, <4 x float>)

declare <4 x float> @llvm.arm.mve.max.predicated.v4f32.v4i1(<4 x float>, <4 x float>, i32, <4 x i1>, <4 x float>)
