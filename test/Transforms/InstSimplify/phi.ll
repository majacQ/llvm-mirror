; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instsimplify -S | FileCheck %s

; PR12189
define i1 @test1(i32 %x) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:    br i1 true, label [[A:%.*]], label [[B:%.*]]
; CHECK:       a:
; CHECK-NEXT:    [[AA:%.*]] = or i32 [[X:%.*]], 10
; CHECK-NEXT:    br label [[C:%.*]]
; CHECK:       b:
; CHECK-NEXT:    [[BB:%.*]] = or i32 [[X]], 10
; CHECK-NEXT:    br label [[C]]
; CHECK:       c:
; CHECK-NEXT:    [[CC:%.*]] = phi i32 [ [[BB]], [[B]] ], [ [[AA]], [[A]] ]
; CHECK-NEXT:    [[D:%.*]] = urem i32 [[CC]], 2
; CHECK-NEXT:    [[E:%.*]] = icmp eq i32 [[D]], 0
; CHECK-NEXT:    ret i1 [[E]]
;
  br i1 true, label %a, label %b

a:
  %aa = or i32 %x, 10
  br label %c

b:
  %bb = or i32 %x, 10
  br label %c

c:
  %cc = phi i32 [ %bb, %b ], [%aa, %a ]
  %d = urem i32 %cc, 2
  %e = icmp eq i32 %d, 0
  ret i1 %e
}

; D63489 - https://reviews.llvm.org/D63489
; If this single-value phi form needs to be preserved to enable
; further analysis, then -instsimplify should not be running?

define i32 @lcssa-phi(i32 %x) {
; CHECK-LABEL: @lcssa-phi(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[END:%.*]]
; CHECK:       end:
; CHECK-NEXT:    ret i32 [[X:%.*]]
;
entry:
  br label %end

end:
  %counter.lcssa = phi i32 [ %x, %entry ]
  ret i32 %counter.lcssa
}

define i32 @poison(i1 %cond, i32 %v) {
; CHECK-LABEL: @poison(
; CHECK-NEXT:    br i1 [[COND:%.*]], label [[A:%.*]], label [[B:%.*]]
; CHECK:       A:
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       B:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       EXIT:
; CHECK-NEXT:    ret i32 [[V:%.*]]
;
  br i1 %cond, label %A, label %B
A:
  br label %EXIT
B:
  br label %EXIT
EXIT:
  %w = phi i32 [%v, %A], [poison, %B]
  ret i32 %w
}
