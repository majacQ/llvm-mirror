; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32I %s
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64I %s

;; There are a few different ways to lower (select (or A, B), X, Y). This test
;; ensures that we do so with as few branches as possible.

define signext i32 @select_of_or(i1 zeroext %a, i1 zeroext %b, i32 signext %c, i32 signext %d) nounwind {
; RV32I-LABEL: select_of_or:
; RV32I:       # %bb.0:
; RV32I-NEXT:    mv a4, a2
; RV32I-NEXT:    beqz a1, .LBB0_3
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    beqz a0, .LBB0_4
; RV32I-NEXT:  .LBB0_2:
; RV32I-NEXT:    mv a0, a2
; RV32I-NEXT:    ret
; RV32I-NEXT:  .LBB0_3:
; RV32I-NEXT:    mv a4, a3
; RV32I-NEXT:    bnez a0, .LBB0_2
; RV32I-NEXT:  .LBB0_4:
; RV32I-NEXT:    mv a2, a4
; RV32I-NEXT:    mv a0, a2
; RV32I-NEXT:    ret
;
; RV64I-LABEL: select_of_or:
; RV64I:       # %bb.0:
; RV64I-NEXT:    mv a4, a2
; RV64I-NEXT:    beqz a1, .LBB0_3
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    beqz a0, .LBB0_4
; RV64I-NEXT:  .LBB0_2:
; RV64I-NEXT:    mv a0, a2
; RV64I-NEXT:    ret
; RV64I-NEXT:  .LBB0_3:
; RV64I-NEXT:    mv a4, a3
; RV64I-NEXT:    bnez a0, .LBB0_2
; RV64I-NEXT:  .LBB0_4:
; RV64I-NEXT:    mv a2, a4
; RV64I-NEXT:    mv a0, a2
; RV64I-NEXT:    ret
  %1 = or i1 %a, %b
  %2 = select i1 %1, i32 %c, i32 %d
  ret i32 %2
}

declare signext i32 @either() nounwind
declare signext i32 @neither() nounwind

define signext i32 @if_of_or(i1 zeroext %a, i1 zeroext %b) nounwind {
; RV32I-LABEL: if_of_or:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp)
; RV32I-NEXT:    bnez a0, .LBB1_3
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    bnez a1, .LBB1_3
; RV32I-NEXT:  # %bb.2: # %if.else
; RV32I-NEXT:    call neither
; RV32I-NEXT:    j .LBB1_4
; RV32I-NEXT:  .LBB1_3: # %if.then
; RV32I-NEXT:    call either
; RV32I-NEXT:  .LBB1_4: # %if.end
; RV32I-NEXT:    lw ra, 12(sp)
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: if_of_or:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp)
; RV64I-NEXT:    bnez a0, .LBB1_3
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    bnez a1, .LBB1_3
; RV64I-NEXT:  # %bb.2: # %if.else
; RV64I-NEXT:    call neither
; RV64I-NEXT:    j .LBB1_4
; RV64I-NEXT:  .LBB1_3: # %if.then
; RV64I-NEXT:    call either
; RV64I-NEXT:  .LBB1_4: # %if.end
; RV64I-NEXT:    ld ra, 8(sp)
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = or i1 %a, %b
  br i1 %1, label %if.then, label %if.else

if.then:
  %2 = tail call i32 @either()
  br label %if.end

if.else:
  %3 = tail call i32 @neither()
  br label %if.end

if.end:
  %4 = phi i32 [%2, %if.then], [%3, %if.else]
  ret i32 %4
}
