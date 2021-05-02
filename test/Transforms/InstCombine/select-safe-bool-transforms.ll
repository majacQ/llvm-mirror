; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s

; TODO: All of these should be optimized to less than or equal to a single
; instruction of select/and/or.

; --- (A op B) op' A   /   (B op A) op' A ---

; (A land B) land A
define i1 @land_land_left1(i1 %A, i1 %B) {
; CHECK-LABEL: @land_land_left1(
; CHECK-NEXT:    [[C:%.*]] = select i1 [[A:%.*]], i1 [[B:%.*]], i1 false
; CHECK-NEXT:    ret i1 [[C]]
;
  %c = select i1 %A, i1 %B, i1 false
  %res = select i1 %c, i1 %A, i1 false
  ret i1 %res
}
define i1 @land_land_left2(i1 %A, i1 %B) {
; CHECK-LABEL: @land_land_left2(
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[B:%.*]], i1 [[A:%.*]], i1 false
; CHECK-NEXT:    ret i1 [[RES]]
;
  %c = select i1 %B, i1 %A, i1 false
  %res = select i1 %c, i1 %A, i1 false
  ret i1 %res
}

; (A land B) band A
define i1 @land_band_left1(i1 %A, i1 %B) {
; CHECK-LABEL: @land_band_left1(
; CHECK-NEXT:    [[C:%.*]] = select i1 [[A:%.*]], i1 [[B:%.*]], i1 false
; CHECK-NEXT:    ret i1 [[C]]
;
  %c = select i1 %A, i1 %B, i1 false
  %res = and i1 %c, %A
  ret i1 %res
}
define i1 @land_band_left2(i1 %A, i1 %B) {
; CHECK-LABEL: @land_band_left2(
; CHECK-NEXT:    [[C:%.*]] = select i1 [[B:%.*]], i1 [[A:%.*]], i1 false
; CHECK-NEXT:    ret i1 [[C]]
;
  %c = select i1 %B, i1 %A, i1 false
  %res = and i1 %c, %A
  ret i1 %res
}

; (A land B) lor A
define i1 @land_lor_left1(i1 %A, i1 %B) {
; CHECK-LABEL: @land_lor_left1(
; CHECK-NEXT:    ret i1 [[A:%.*]]
;
  %c = select i1 %A, i1 %B, i1 false
  %res = select i1 %c, i1 true, i1 %A
  ret i1 %res
}
define i1 @land_lor_left2(i1 %A, i1 %B) {
; CHECK-LABEL: @land_lor_left2(
; CHECK-NEXT:    [[C:%.*]] = select i1 [[B:%.*]], i1 [[A:%.*]], i1 false
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[C]], i1 true, i1 [[A]]
; CHECK-NEXT:    ret i1 [[RES]]
;
  %c = select i1 %B, i1 %A, i1 false
  %res = select i1 %c, i1 true, i1 %A
  ret i1 %res
}

; (A land B) bor A
define i1 @land_bor_left1(i1 %A, i1 %B) {
; CHECK-LABEL: @land_bor_left1(
; CHECK-NEXT:    ret i1 [[A:%.*]]
;
  %c = select i1 %A, i1 %B, i1 false
  %res = or i1 %c, %A
  ret i1 %res
}
define i1 @land_bor_left2(i1 %A, i1 %B) {
; CHECK-LABEL: @land_bor_left2(
; CHECK-NEXT:    ret i1 [[A:%.*]]
;
  %c = select i1 %B, i1 %A, i1 false
  %res = or i1 %c, %A
  ret i1 %res
}

; (A band B) land A
define i1 @band_land_left1(i1 %A, i1 %B) {
; CHECK-LABEL: @band_land_left1(
; CHECK-NEXT:    [[C:%.*]] = and i1 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    ret i1 [[C]]
;
  %c = and i1 %A, %B
  %res = select i1 %c, i1 %A, i1 false
  ret i1 %res
}
define i1 @band_land_left2(i1 %A, i1 %B) {
; CHECK-LABEL: @band_land_left2(
; CHECK-NEXT:    [[C:%.*]] = and i1 [[B:%.*]], [[A:%.*]]
; CHECK-NEXT:    ret i1 [[C]]
;
  %c = and i1 %B, %A
  %res = select i1 %c, i1 %A, i1 false
  ret i1 %res
}

; (A band B) lor A
define i1 @band_lor_left1(i1 %A, i1 %B) {
; CHECK-LABEL: @band_lor_left1(
; CHECK-NEXT:    ret i1 [[A:%.*]]
;
  %c = and i1 %A, %B
  %res = select i1 %c, i1 true, i1 %A
  ret i1 %res
}
define i1 @band_lor_left2(i1 %A, i1 %B) {
; CHECK-LABEL: @band_lor_left2(
; CHECK-NEXT:    ret i1 [[A:%.*]]
;
  %c = and i1 %B, %A
  %res = select i1 %c, i1 true, i1 %A
  ret i1 %res
}

; (A lor B) land A
define i1 @lor_land_left1(i1 %A, i1 %B) {
; CHECK-LABEL: @lor_land_left1(
; CHECK-NEXT:    ret i1 [[A:%.*]]
;
  %c = select i1 %A, i1 true, i1 %B
  %res = select i1 %c, i1 %A, i1 false
  ret i1 %res
}
define i1 @lor_land_left2(i1 %A, i1 %B) {
; CHECK-LABEL: @lor_land_left2(
; CHECK-NEXT:    [[C:%.*]] = select i1 [[B:%.*]], i1 true, i1 [[A:%.*]]
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[C]], i1 [[A]], i1 false
; CHECK-NEXT:    ret i1 [[RES]]
;
  %c = select i1 %B, i1 true, i1 %A
  %res = select i1 %c, i1 %A, i1 false
  ret i1 %res
}

; (A lor B) band A
define i1 @lor_band_left1(i1 %A, i1 %B) {
; CHECK-LABEL: @lor_band_left1(
; CHECK-NEXT:    ret i1 [[A:%.*]]
;
  %c = select i1 %A, i1 true, i1 %B
  %res = and i1 %c, %A
  ret i1 %res
}
define i1 @lor_band_left2(i1 %A, i1 %B) {
; CHECK-LABEL: @lor_band_left2(
; CHECK-NEXT:    ret i1 [[A:%.*]]
;
  %c = select i1 %B, i1 true, i1 %A
  %res = and i1 %c, %A
  ret i1 %res
}

; (A lor B) lor A
define i1 @lor_lor_left1(i1 %A, i1 %B) {
; CHECK-LABEL: @lor_lor_left1(
; CHECK-NEXT:    [[C:%.*]] = select i1 [[A:%.*]], i1 true, i1 [[B:%.*]]
; CHECK-NEXT:    ret i1 [[C]]
;
  %c = select i1 %A, i1 true, i1 %B
  %res = select i1 %c, i1 true, i1 %A
  ret i1 %res
}
define i1 @lor_lor_left2(i1 %A, i1 %B) {
; CHECK-LABEL: @lor_lor_left2(
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[B:%.*]], i1 true, i1 [[A:%.*]]
; CHECK-NEXT:    ret i1 [[RES]]
;
  %c = select i1 %B, i1 true, i1 %A
  %res = select i1 %c, i1 true, i1 %A
  ret i1 %res
}

; (A lor B) bor A
define i1 @lor_bor_left1(i1 %A, i1 %B) {
; CHECK-LABEL: @lor_bor_left1(
; CHECK-NEXT:    [[C:%.*]] = select i1 [[A:%.*]], i1 true, i1 [[B:%.*]]
; CHECK-NEXT:    ret i1 [[C]]
;
  %c = select i1 %A, i1 true, i1 %B
  %res = or i1 %c, %A
  ret i1 %res
}
define i1 @lor_bor_left2(i1 %A, i1 %B) {
; CHECK-LABEL: @lor_bor_left2(
; CHECK-NEXT:    [[C:%.*]] = select i1 [[B:%.*]], i1 true, i1 [[A:%.*]]
; CHECK-NEXT:    ret i1 [[C]]
;
  %c = select i1 %B, i1 true, i1 %A
  %res = or i1 %c, %A
  ret i1 %res
}

; (A bor B) land A
define i1 @bor_land_left1(i1 %A, i1 %B) {
; CHECK-LABEL: @bor_land_left1(
; CHECK-NEXT:    ret i1 [[A:%.*]]
;
  %c = or i1 %A, %B
  %res = select i1 %c, i1 %A, i1 false
  ret i1 %res
}
define i1 @bor_land_left2(i1 %A, i1 %B) {
; CHECK-LABEL: @bor_land_left2(
; CHECK-NEXT:    ret i1 [[A:%.*]]
;
  %c = or i1 %B, %A
  %res = select i1 %c, i1 %A, i1 false
  ret i1 %res
}

; (A bor B) lor A
define i1 @bor_lor_left1(i1 %A, i1 %B) {
; CHECK-LABEL: @bor_lor_left1(
; CHECK-NEXT:    [[C:%.*]] = or i1 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    ret i1 [[C]]
;
  %c = or i1 %A, %B
  %res = select i1 %c, i1 true, i1 %A
  ret i1 %res
}
define i1 @bor_lor_left2(i1 %A, i1 %B) {
; CHECK-LABEL: @bor_lor_left2(
; CHECK-NEXT:    [[C:%.*]] = or i1 [[B:%.*]], [[A:%.*]]
; CHECK-NEXT:    ret i1 [[C]]
;
  %c = or i1 %B, %A
  %res = select i1 %c, i1 true, i1 %A
  ret i1 %res
}

; --- A op (A op' B)   /   A op (B op' A) ---

; A land (A land B)
define i1 @land_land_right1(i1 %A, i1 %B) {
; CHECK-LABEL: @land_land_right1(
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[A:%.*]], i1 [[B:%.*]], i1 false
; CHECK-NEXT:    ret i1 [[RES]]
;
  %c = select i1 %A, i1 %B, i1 false
  %res = select i1 %A, i1 %c, i1 false
  ret i1 %res
}
define i1 @land_land_right2(i1 %A, i1 %B) {
; CHECK-LABEL: @land_land_right2(
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[A:%.*]], i1 [[B:%.*]], i1 false
; CHECK-NEXT:    ret i1 [[RES]]
;
  %c = select i1 %B, i1 %A, i1 false
  %res = select i1 %A, i1 %c, i1 false
  ret i1 %res
}

; A band (A land B)
define i1 @land_band_right1(i1 %A, i1 %B) {
; CHECK-LABEL: @land_band_right1(
; CHECK-NEXT:    [[C:%.*]] = select i1 [[A:%.*]], i1 [[B:%.*]], i1 false
; CHECK-NEXT:    ret i1 [[C]]
;
  %c = select i1 %A, i1 %B, i1 false
  %res = and i1 %A, %c
  ret i1 %res
}
define i1 @land_band_right2(i1 %A, i1 %B) {
; CHECK-LABEL: @land_band_right2(
; CHECK-NEXT:    [[C:%.*]] = select i1 [[B:%.*]], i1 [[A:%.*]], i1 false
; CHECK-NEXT:    ret i1 [[C]]
;
  %c = select i1 %B, i1 %A, i1 false
  %res = and i1 %A, %c
  ret i1 %res
}

; A lor (A land B)
define i1 @land_lor_right1(i1 %A, i1 %B) {
; CHECK-LABEL: @land_lor_right1(
; CHECK-NEXT:    ret i1 [[A:%.*]]
;
  %c = select i1 %A, i1 %B, i1 false
  %res = select i1 %A, i1 true, i1 %c
  ret i1 %res
}
define i1 @land_lor_right2(i1 %A, i1 %B) {
; CHECK-LABEL: @land_lor_right2(
; CHECK-NEXT:    ret i1 [[A:%.*]]
;
  %c = select i1 %B, i1 %A, i1 false
  %res = select i1 %A, i1 true, i1 %c
  ret i1 %res
}

; A bor (A land B)
define i1 @land_bor_right1(i1 %A, i1 %B) {
; CHECK-LABEL: @land_bor_right1(
; CHECK-NEXT:    ret i1 [[A:%.*]]
;
  %c = select i1 %A, i1 %B, i1 false
  %res = or i1 %A, %c
  ret i1 %res
}
define i1 @land_bor_right2(i1 %A, i1 %B) {
; CHECK-LABEL: @land_bor_right2(
; CHECK-NEXT:    ret i1 [[A:%.*]]
;
  %c = select i1 %B, i1 %A, i1 false
  %res = or i1 %A, %c
  ret i1 %res
}

; A land (A band B)
define i1 @band_land_right1(i1 %A, i1 %B) {
; CHECK-LABEL: @band_land_right1(
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[A:%.*]], i1 [[B:%.*]], i1 false
; CHECK-NEXT:    ret i1 [[RES]]
;
  %c = and i1 %A, %B
  %res = select i1 %A, i1 %c, i1 false
  ret i1 %res
}
define i1 @band_land_right2(i1 %A, i1 %B) {
; CHECK-LABEL: @band_land_right2(
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[A:%.*]], i1 [[B:%.*]], i1 false
; CHECK-NEXT:    ret i1 [[RES]]
;
  %c = and i1 %B, %A
  %res = select i1 %A, i1 %c, i1 false
  ret i1 %res
}

; A lor (A band B)
define i1 @band_lor_right1(i1 %A, i1 %B) {
; CHECK-LABEL: @band_lor_right1(
; CHECK-NEXT:    ret i1 [[A:%.*]]
;
  %c = and i1 %A, %B
  %res = select i1 %A, i1 true, i1 %c
  ret i1 %res
}
define i1 @band_lor_right2(i1 %A, i1 %B) {
; CHECK-LABEL: @band_lor_right2(
; CHECK-NEXT:    ret i1 [[A:%.*]]
;
  %c = and i1 %B, %A
  %res = select i1 %A, i1 true, i1 %c
  ret i1 %res
}

; A land (A lor B)
define i1 @lor_land_right1(i1 %A, i1 %B) {
; CHECK-LABEL: @lor_land_right1(
; CHECK-NEXT:    ret i1 [[A:%.*]]
;
  %c = select i1 %A, i1 true, i1 %B
  %res = select i1 %A, i1 %c, i1 false
  ret i1 %res
}
define i1 @lor_land_right2(i1 %A, i1 %B) {
; CHECK-LABEL: @lor_land_right2(
; CHECK-NEXT:    ret i1 [[A:%.*]]
;
  %c = select i1 %B, i1 true, i1 %A
  %res = select i1 %A, i1 %c, i1 false
  ret i1 %res
}

; A band (A lor B)
define i1 @lor_band_right1(i1 %A, i1 %B) {
; CHECK-LABEL: @lor_band_right1(
; CHECK-NEXT:    ret i1 [[A:%.*]]
;
  %c = select i1 %A, i1 true, i1 %B
  %res = and i1 %A, %c
  ret i1 %res
}
define i1 @lor_band_right2(i1 %A, i1 %B) {
; CHECK-LABEL: @lor_band_right2(
; CHECK-NEXT:    ret i1 [[A:%.*]]
;
  %c = select i1 %B, i1 true, i1 %A
  %res = and i1 %A, %c
  ret i1 %res
}

; A lor (A lor B)
define i1 @lor_lor_right1(i1 %A, i1 %B) {
; CHECK-LABEL: @lor_lor_right1(
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[A:%.*]], i1 true, i1 [[B:%.*]]
; CHECK-NEXT:    ret i1 [[RES]]
;
  %c = select i1 %A, i1 true, i1 %B
  %res = select i1 %A, i1 true, i1 %c
  ret i1 %res
}
define i1 @lor_lor_right2(i1 %A, i1 %B) {
; CHECK-LABEL: @lor_lor_right2(
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[A:%.*]], i1 true, i1 [[B:%.*]]
; CHECK-NEXT:    ret i1 [[RES]]
;
  %c = select i1 %B, i1 true, i1 %A
  %res = select i1 %A, i1 true, i1 %c
  ret i1 %res
}

; A bor (A lor B)
define i1 @lor_bor_right1(i1 %A, i1 %B) {
; CHECK-LABEL: @lor_bor_right1(
; CHECK-NEXT:    [[C:%.*]] = select i1 [[A:%.*]], i1 true, i1 [[B:%.*]]
; CHECK-NEXT:    ret i1 [[C]]
;
  %c = select i1 %A, i1 true, i1 %B
  %res = or i1 %A, %c
  ret i1 %res
}
define i1 @lor_bor_right2(i1 %A, i1 %B) {
; CHECK-LABEL: @lor_bor_right2(
; CHECK-NEXT:    [[C:%.*]] = select i1 [[B:%.*]], i1 true, i1 [[A:%.*]]
; CHECK-NEXT:    ret i1 [[C]]
;
  %c = select i1 %B, i1 true, i1 %A
  %res = or i1 %A, %c
  ret i1 %res
}

; A land (A bor B)
define i1 @bor_land_right1(i1 %A, i1 %B) {
; CHECK-LABEL: @bor_land_right1(
; CHECK-NEXT:    ret i1 [[A:%.*]]
;
  %c = or i1 %A, %B
  %res = select i1 %A, i1 %c, i1 false
  ret i1 %res
}
define i1 @bor_land_right2(i1 %A, i1 %B) {
; CHECK-LABEL: @bor_land_right2(
; CHECK-NEXT:    ret i1 [[A:%.*]]
;
  %c = or i1 %B, %A
  %res = select i1 %A, i1 %c, i1 false
  ret i1 %res
}

; A lor (A bor B)
define i1 @bor_lor_right1(i1 %A, i1 %B) {
; CHECK-LABEL: @bor_lor_right1(
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[A:%.*]], i1 true, i1 [[B:%.*]]
; CHECK-NEXT:    ret i1 [[RES]]
;
  %c = or i1 %A, %B
  %res = select i1 %A, i1 true, i1 %c
  ret i1 %res
}
define i1 @bor_lor_right2(i1 %A, i1 %B) {
; CHECK-LABEL: @bor_lor_right2(
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[A:%.*]], i1 true, i1 [[B:%.*]]
; CHECK-NEXT:    ret i1 [[RES]]
;
  %c = or i1 %B, %A
  %res = select i1 %A, i1 true, i1 %c
  ret i1 %res
}

