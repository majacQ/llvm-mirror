; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -simplifycfg -S | FileCheck %s

; This is the naive implementation of x86 BZHI/BEXTR instruction:
; it takes input and bit count, and extracts low nbits up to bit width.
; I.e. unlike shift it does not have any UB when nbits >= bitwidth.
; Which means we don't need a while PHI here, simple select will do.
define i32 @extract_low_bits(i32 %input, i32 %nbits) {
; CHECK-LABEL: @extract_low_bits(
; CHECK-NEXT:  begin:
; CHECK-NEXT:    [[SHOULD_MASK:%.*]] = icmp ult i32 [[NBITS:%.*]], 32
; CHECK-NEXT:    br i1 [[SHOULD_MASK]], label [[PERFORM_MASKING:%.*]], label [[END:%.*]]
; CHECK:       perform_masking:
; CHECK-NEXT:    [[MASK_NOT:%.*]] = shl nsw i32 -1, [[NBITS]]
; CHECK-NEXT:    [[MASK:%.*]] = xor i32 [[MASK_NOT]], -1
; CHECK-NEXT:    [[MASKED:%.*]] = and i32 [[MASK]], [[INPUT:%.*]]
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[RES:%.*]] = phi i32 [ [[MASKED]], [[PERFORM_MASKING]] ], [ [[INPUT]], [[BEGIN:%.*]] ]
; CHECK-NEXT:    ret i32 [[RES]]
;
begin:
  %should_mask = icmp ult i32 %nbits, 32
  br i1 %should_mask, label %perform_masking, label %end

perform_masking: ; preds = %begin
  %mask.not = shl nsw i32 -1, %nbits
  %mask = xor i32 %mask.not, -1
  %masked = and i32 %mask, %input
  br label %end

end:             ; preds = %perform_masking, %begin
  %res = phi i32 [ %masked, %perform_masking ], [ %input, %begin ]
  ret i32 %res
}
