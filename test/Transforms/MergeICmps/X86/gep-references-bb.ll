; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -S -mergeicmps -verify-dom-info | FileCheck %s
target triple = "x86_64"

%Triple = type { i32, i32, i32, i32 }

@g = external global i32

; bb1 references a gep introduced in bb0. The gep must remain available after
; the merge.
define i1 @bug(%Triple* nonnull dereferenceable(16) %lhs, %Triple* nonnull dereferenceable(16) %rhs) {
; CHECK-LABEL: @bug(
; CHECK-NEXT:  bb0:
; CHECK-NEXT:    store i32 1, i32* @g, align 4
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr [[TRIPLE:%.*]], %Triple* [[RHS:%.*]], i64 0, i32 0
; CHECK-NEXT:    [[L0_ADDR:%.*]] = getelementptr inbounds [[TRIPLE]], %Triple* [[LHS:%.*]], i64 0, i32 0
; CHECK-NEXT:    [[L0:%.*]] = load i32, i32* [[L0_ADDR]], align 4
; CHECK-NEXT:    [[R0_ADDR:%.*]] = getelementptr inbounds [[TRIPLE]], %Triple* [[RHS]], i64 0, i32 0
; CHECK-NEXT:    [[R0:%.*]] = load i32, i32* [[R0_ADDR]], align 4
; CHECK-NEXT:    [[CMP0:%.*]] = icmp eq i32 [[L0]], [[R0]]
; CHECK-NEXT:    br i1 [[CMP0]], label %"bb1+bb2", label [[FINAL:%.*]]
; CHECK:       "bb1+bb2":
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds [[TRIPLE]], %Triple* [[LHS]], i64 0, i32 2
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i32, i32* [[GEP]], i64 2
; CHECK-NEXT:    [[CSTR:%.*]] = bitcast i32* [[TMP0]] to i8*
; CHECK-NEXT:    [[CSTR1:%.*]] = bitcast i32* [[TMP1]] to i8*
; CHECK-NEXT:    [[MEMCMP:%.*]] = call i32 @memcmp(i8* [[CSTR]], i8* [[CSTR1]], i64 8)
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i32 [[MEMCMP]], 0
; CHECK-NEXT:    br label [[FINAL]]
; CHECK:       final:
; CHECK-NEXT:    [[RET:%.*]] = phi i1 [ false, [[BB0:%.*]] ], [ [[TMP2]], %"bb1+bb2" ]
; CHECK-NEXT:    ret i1 [[RET]]
;
bb0:
  store i32 1, i32* @g
  %gep = getelementptr %Triple, %Triple* %rhs, i64 0, i32 0
  %l0_addr = getelementptr inbounds %Triple, %Triple* %lhs, i64 0, i32 0
  %l0 = load i32, i32* %l0_addr, align 4
  %r0_addr = getelementptr inbounds %Triple, %Triple* %rhs, i64 0, i32 0
  %r0 = load i32, i32* %r0_addr, align 4
  %cmp0 = icmp eq i32 %l0, %r0
  br i1 %cmp0, label %bb1, label %final

bb1:                                           ; preds = %bb0
  %l1_addr = getelementptr inbounds %Triple, %Triple* %lhs, i64 0, i32 2
  %l1 = load i32, i32* %l1_addr, align 4
  %r1_addr = getelementptr inbounds i32, i32* %gep, i64 2
  %r1 = load i32, i32* %r1_addr, align 4
  %cmp1 = icmp eq i32 %l1, %r1
  br i1 %cmp1, label %bb2, label %final

bb2:                                           ; preds = %bb1
  %l2_addr = getelementptr inbounds %Triple, %Triple* %lhs, i64 0, i32 3
  %l2 = load i32, i32* %l2_addr, align 4
  %r2_addr = getelementptr inbounds i32, i32* %gep, i64 3
  %r2 = load i32, i32* %r2_addr, align 4
  %cmp2 = icmp eq i32 %l2, %r2
  br label %final

final:                                            ; preds = %bb2, %bb1, %bb0
  %ret = phi i1 [ false, %bb0 ], [ false, %bb1 ], [ %cmp2, %bb2 ]
  ret i1 %ret
}

