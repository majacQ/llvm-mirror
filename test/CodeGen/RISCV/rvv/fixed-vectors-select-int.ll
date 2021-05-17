; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+experimental-v -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefixes=CHECK,RV32
; RUN: llc -mtriple=riscv64 -mattr=+experimental-v -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefixes=CHECK,RV64

define <1 x i1> @select_v1i1(i1 zeroext %c, <1 x i1> %a, <1 x i1> %b) {
; CHECK-LABEL: select_v1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, zero, 1
; CHECK-NEXT:    bnez a0, .LBB0_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a1, zero
; CHECK-NEXT:  .LBB0_2:
; CHECK-NEXT:    vsetivli a0, 1, e8,mf8,ta,mu
; CHECK-NEXT:    vmv.v.x v25, a1
; CHECK-NEXT:    vmsne.vi v26, v25, 0
; CHECK-NEXT:    vmandnot.mm v25, v8, v26
; CHECK-NEXT:    vmand.mm v26, v0, v26
; CHECK-NEXT:    vmor.mm v0, v26, v25
; CHECK-NEXT:    ret
  %v = select i1 %c, <1 x i1> %a, <1 x i1> %b
  ret <1 x i1> %v
}

define <1 x i1> @selectcc_v1i1(i1 signext %a, i1 signext %b, <1 x i1> %c, <1 x i1> %d) {
; CHECK-LABEL: selectcc_v1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xor a0, a0, a1
; CHECK-NEXT:    andi a1, a0, 1
; CHECK-NEXT:    addi a0, zero, 1
; CHECK-NEXT:    bnez a1, .LBB1_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a0, zero
; CHECK-NEXT:  .LBB1_2:
; CHECK-NEXT:    vsetivli a1, 1, e8,mf8,ta,mu
; CHECK-NEXT:    vmv.v.x v25, a0
; CHECK-NEXT:    vmsne.vi v26, v25, 0
; CHECK-NEXT:    vmandnot.mm v25, v8, v26
; CHECK-NEXT:    vmand.mm v26, v0, v26
; CHECK-NEXT:    vmor.mm v0, v26, v25
; CHECK-NEXT:    ret
  %cmp = icmp ne i1 %a, %b
  %v = select i1 %cmp, <1 x i1> %c, <1 x i1> %d
  ret <1 x i1> %v
}

define <2 x i1> @select_v2i1(i1 zeroext %c, <2 x i1> %a, <2 x i1> %b) {
; CHECK-LABEL: select_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, zero, 1
; CHECK-NEXT:    bnez a0, .LBB2_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a1, zero
; CHECK-NEXT:  .LBB2_2:
; CHECK-NEXT:    vsetivli a0, 2, e8,mf8,ta,mu
; CHECK-NEXT:    vmv.v.x v25, a1
; CHECK-NEXT:    vmsne.vi v26, v25, 0
; CHECK-NEXT:    vmandnot.mm v25, v8, v26
; CHECK-NEXT:    vmand.mm v26, v0, v26
; CHECK-NEXT:    vmor.mm v0, v26, v25
; CHECK-NEXT:    ret
  %v = select i1 %c, <2 x i1> %a, <2 x i1> %b
  ret <2 x i1> %v
}

define <2 x i1> @selectcc_v2i1(i1 signext %a, i1 signext %b, <2 x i1> %c, <2 x i1> %d) {
; CHECK-LABEL: selectcc_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xor a0, a0, a1
; CHECK-NEXT:    andi a1, a0, 1
; CHECK-NEXT:    addi a0, zero, 1
; CHECK-NEXT:    bnez a1, .LBB3_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a0, zero
; CHECK-NEXT:  .LBB3_2:
; CHECK-NEXT:    vsetivli a1, 2, e8,mf8,ta,mu
; CHECK-NEXT:    vmv.v.x v25, a0
; CHECK-NEXT:    vmsne.vi v26, v25, 0
; CHECK-NEXT:    vmandnot.mm v25, v8, v26
; CHECK-NEXT:    vmand.mm v26, v0, v26
; CHECK-NEXT:    vmor.mm v0, v26, v25
; CHECK-NEXT:    ret
  %cmp = icmp ne i1 %a, %b
  %v = select i1 %cmp, <2 x i1> %c, <2 x i1> %d
  ret <2 x i1> %v
}

define <4 x i1> @select_v4i1(i1 zeroext %c, <4 x i1> %a, <4 x i1> %b) {
; CHECK-LABEL: select_v4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, zero, 1
; CHECK-NEXT:    bnez a0, .LBB4_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a1, zero
; CHECK-NEXT:  .LBB4_2:
; CHECK-NEXT:    vsetivli a0, 4, e8,mf4,ta,mu
; CHECK-NEXT:    vmv.v.x v25, a1
; CHECK-NEXT:    vmsne.vi v26, v25, 0
; CHECK-NEXT:    vmandnot.mm v25, v8, v26
; CHECK-NEXT:    vmand.mm v26, v0, v26
; CHECK-NEXT:    vmor.mm v0, v26, v25
; CHECK-NEXT:    ret
  %v = select i1 %c, <4 x i1> %a, <4 x i1> %b
  ret <4 x i1> %v
}

define <4 x i1> @selectcc_v4i1(i1 signext %a, i1 signext %b, <4 x i1> %c, <4 x i1> %d) {
; CHECK-LABEL: selectcc_v4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xor a0, a0, a1
; CHECK-NEXT:    andi a1, a0, 1
; CHECK-NEXT:    addi a0, zero, 1
; CHECK-NEXT:    bnez a1, .LBB5_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a0, zero
; CHECK-NEXT:  .LBB5_2:
; CHECK-NEXT:    vsetivli a1, 4, e8,mf4,ta,mu
; CHECK-NEXT:    vmv.v.x v25, a0
; CHECK-NEXT:    vmsne.vi v26, v25, 0
; CHECK-NEXT:    vmandnot.mm v25, v8, v26
; CHECK-NEXT:    vmand.mm v26, v0, v26
; CHECK-NEXT:    vmor.mm v0, v26, v25
; CHECK-NEXT:    ret
  %cmp = icmp ne i1 %a, %b
  %v = select i1 %cmp, <4 x i1> %c, <4 x i1> %d
  ret <4 x i1> %v
}

define <8 x i1> @select_v8i1(i1 zeroext %c, <8 x i1> %a, <8 x i1> %b) {
; CHECK-LABEL: select_v8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, zero, 1
; CHECK-NEXT:    bnez a0, .LBB6_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a1, zero
; CHECK-NEXT:  .LBB6_2:
; CHECK-NEXT:    vsetivli a0, 8, e8,mf2,ta,mu
; CHECK-NEXT:    vmv.v.x v25, a1
; CHECK-NEXT:    vmsne.vi v26, v25, 0
; CHECK-NEXT:    vmandnot.mm v25, v8, v26
; CHECK-NEXT:    vmand.mm v26, v0, v26
; CHECK-NEXT:    vmor.mm v0, v26, v25
; CHECK-NEXT:    ret
  %v = select i1 %c, <8 x i1> %a, <8 x i1> %b
  ret <8 x i1> %v
}

define <8 x i1> @selectcc_v8i1(i1 signext %a, i1 signext %b, <8 x i1> %c, <8 x i1> %d) {
; CHECK-LABEL: selectcc_v8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xor a0, a0, a1
; CHECK-NEXT:    andi a1, a0, 1
; CHECK-NEXT:    addi a0, zero, 1
; CHECK-NEXT:    bnez a1, .LBB7_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a0, zero
; CHECK-NEXT:  .LBB7_2:
; CHECK-NEXT:    vsetivli a1, 8, e8,mf2,ta,mu
; CHECK-NEXT:    vmv.v.x v25, a0
; CHECK-NEXT:    vmsne.vi v26, v25, 0
; CHECK-NEXT:    vmandnot.mm v25, v8, v26
; CHECK-NEXT:    vmand.mm v26, v0, v26
; CHECK-NEXT:    vmor.mm v0, v26, v25
; CHECK-NEXT:    ret
  %cmp = icmp ne i1 %a, %b
  %v = select i1 %cmp, <8 x i1> %c, <8 x i1> %d
  ret <8 x i1> %v
}

define <16 x i1> @select_v16i1(i1 zeroext %c, <16 x i1> %a, <16 x i1> %b) {
; CHECK-LABEL: select_v16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, zero, 1
; CHECK-NEXT:    bnez a0, .LBB8_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a1, zero
; CHECK-NEXT:  .LBB8_2:
; CHECK-NEXT:    vsetivli a0, 16, e8,m1,ta,mu
; CHECK-NEXT:    vmv.v.x v25, a1
; CHECK-NEXT:    vmsne.vi v26, v25, 0
; CHECK-NEXT:    vmandnot.mm v25, v8, v26
; CHECK-NEXT:    vmand.mm v26, v0, v26
; CHECK-NEXT:    vmor.mm v0, v26, v25
; CHECK-NEXT:    ret
  %v = select i1 %c, <16 x i1> %a, <16 x i1> %b
  ret <16 x i1> %v
}

define <16 x i1> @selectcc_v16i1(i1 signext %a, i1 signext %b, <16 x i1> %c, <16 x i1> %d) {
; CHECK-LABEL: selectcc_v16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xor a0, a0, a1
; CHECK-NEXT:    andi a1, a0, 1
; CHECK-NEXT:    addi a0, zero, 1
; CHECK-NEXT:    bnez a1, .LBB9_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a0, zero
; CHECK-NEXT:  .LBB9_2:
; CHECK-NEXT:    vsetivli a1, 16, e8,m1,ta,mu
; CHECK-NEXT:    vmv.v.x v25, a0
; CHECK-NEXT:    vmsne.vi v26, v25, 0
; CHECK-NEXT:    vmandnot.mm v25, v8, v26
; CHECK-NEXT:    vmand.mm v26, v0, v26
; CHECK-NEXT:    vmor.mm v0, v26, v25
; CHECK-NEXT:    ret
  %cmp = icmp ne i1 %a, %b
  %v = select i1 %cmp, <16 x i1> %c, <16 x i1> %d
  ret <16 x i1> %v
}

define <2 x i8> @select_v2i8(i1 zeroext %c, <2 x i8> %a, <2 x i8> %b) {
; CHECK-LABEL: select_v2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, zero, -1
; CHECK-NEXT:    bnez a0, .LBB10_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a1, zero
; CHECK-NEXT:  .LBB10_2:
; CHECK-NEXT:    vsetivli a0, 2, e8,mf8,ta,mu
; CHECK-NEXT:    vand.vx v25, v8, a1
; CHECK-NEXT:    vmv.v.x v26, a1
; CHECK-NEXT:    vxor.vi v26, v26, -1
; CHECK-NEXT:    vand.vv v26, v9, v26
; CHECK-NEXT:    vor.vv v8, v25, v26
; CHECK-NEXT:    ret
  %v = select i1 %c, <2 x i8> %a, <2 x i8> %b
  ret <2 x i8> %v
}

define <2 x i8> @selectcc_v2i8(i8 signext %a, i8 signext %b, <2 x i8> %c, <2 x i8> %d) {
; CHECK-LABEL: selectcc_v2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a2, zero, -1
; CHECK-NEXT:    bne a0, a1, .LBB11_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a2, zero
; CHECK-NEXT:  .LBB11_2:
; CHECK-NEXT:    vsetivli a0, 2, e8,mf8,ta,mu
; CHECK-NEXT:    vand.vx v25, v8, a2
; CHECK-NEXT:    vmv.v.x v26, a2
; CHECK-NEXT:    vxor.vi v26, v26, -1
; CHECK-NEXT:    vand.vv v26, v9, v26
; CHECK-NEXT:    vor.vv v8, v25, v26
; CHECK-NEXT:    ret
  %cmp = icmp ne i8 %a, %b
  %v = select i1 %cmp, <2 x i8> %c, <2 x i8> %d
  ret <2 x i8> %v
}

define <4 x i8> @select_v4i8(i1 zeroext %c, <4 x i8> %a, <4 x i8> %b) {
; CHECK-LABEL: select_v4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, zero, -1
; CHECK-NEXT:    bnez a0, .LBB12_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a1, zero
; CHECK-NEXT:  .LBB12_2:
; CHECK-NEXT:    vsetivli a0, 4, e8,mf4,ta,mu
; CHECK-NEXT:    vand.vx v25, v8, a1
; CHECK-NEXT:    vmv.v.x v26, a1
; CHECK-NEXT:    vxor.vi v26, v26, -1
; CHECK-NEXT:    vand.vv v26, v9, v26
; CHECK-NEXT:    vor.vv v8, v25, v26
; CHECK-NEXT:    ret
  %v = select i1 %c, <4 x i8> %a, <4 x i8> %b
  ret <4 x i8> %v
}

define <4 x i8> @selectcc_v4i8(i8 signext %a, i8 signext %b, <4 x i8> %c, <4 x i8> %d) {
; CHECK-LABEL: selectcc_v4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a2, zero, -1
; CHECK-NEXT:    bne a0, a1, .LBB13_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a2, zero
; CHECK-NEXT:  .LBB13_2:
; CHECK-NEXT:    vsetivli a0, 4, e8,mf4,ta,mu
; CHECK-NEXT:    vand.vx v25, v8, a2
; CHECK-NEXT:    vmv.v.x v26, a2
; CHECK-NEXT:    vxor.vi v26, v26, -1
; CHECK-NEXT:    vand.vv v26, v9, v26
; CHECK-NEXT:    vor.vv v8, v25, v26
; CHECK-NEXT:    ret
  %cmp = icmp ne i8 %a, %b
  %v = select i1 %cmp, <4 x i8> %c, <4 x i8> %d
  ret <4 x i8> %v
}

define <8 x i8> @select_v8i8(i1 zeroext %c, <8 x i8> %a, <8 x i8> %b) {
; CHECK-LABEL: select_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, zero, -1
; CHECK-NEXT:    bnez a0, .LBB14_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a1, zero
; CHECK-NEXT:  .LBB14_2:
; CHECK-NEXT:    vsetivli a0, 8, e8,mf2,ta,mu
; CHECK-NEXT:    vand.vx v25, v8, a1
; CHECK-NEXT:    vmv.v.x v26, a1
; CHECK-NEXT:    vxor.vi v26, v26, -1
; CHECK-NEXT:    vand.vv v26, v9, v26
; CHECK-NEXT:    vor.vv v8, v25, v26
; CHECK-NEXT:    ret
  %v = select i1 %c, <8 x i8> %a, <8 x i8> %b
  ret <8 x i8> %v
}

define <8 x i8> @selectcc_v8i8(i8 signext %a, i8 signext %b, <8 x i8> %c, <8 x i8> %d) {
; CHECK-LABEL: selectcc_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a2, zero, -1
; CHECK-NEXT:    bne a0, a1, .LBB15_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a2, zero
; CHECK-NEXT:  .LBB15_2:
; CHECK-NEXT:    vsetivli a0, 8, e8,mf2,ta,mu
; CHECK-NEXT:    vand.vx v25, v8, a2
; CHECK-NEXT:    vmv.v.x v26, a2
; CHECK-NEXT:    vxor.vi v26, v26, -1
; CHECK-NEXT:    vand.vv v26, v9, v26
; CHECK-NEXT:    vor.vv v8, v25, v26
; CHECK-NEXT:    ret
  %cmp = icmp ne i8 %a, %b
  %v = select i1 %cmp, <8 x i8> %c, <8 x i8> %d
  ret <8 x i8> %v
}

define <16 x i8> @select_v16i8(i1 zeroext %c, <16 x i8> %a, <16 x i8> %b) {
; CHECK-LABEL: select_v16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, zero, -1
; CHECK-NEXT:    bnez a0, .LBB16_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a1, zero
; CHECK-NEXT:  .LBB16_2:
; CHECK-NEXT:    vsetivli a0, 16, e8,m1,ta,mu
; CHECK-NEXT:    vand.vx v25, v8, a1
; CHECK-NEXT:    vmv.v.x v26, a1
; CHECK-NEXT:    vxor.vi v26, v26, -1
; CHECK-NEXT:    vand.vv v26, v9, v26
; CHECK-NEXT:    vor.vv v8, v25, v26
; CHECK-NEXT:    ret
  %v = select i1 %c, <16 x i8> %a, <16 x i8> %b
  ret <16 x i8> %v
}

define <16 x i8> @selectcc_v16i8(i8 signext %a, i8 signext %b, <16 x i8> %c, <16 x i8> %d) {
; CHECK-LABEL: selectcc_v16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a2, zero, -1
; CHECK-NEXT:    bne a0, a1, .LBB17_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a2, zero
; CHECK-NEXT:  .LBB17_2:
; CHECK-NEXT:    vsetivli a0, 16, e8,m1,ta,mu
; CHECK-NEXT:    vand.vx v25, v8, a2
; CHECK-NEXT:    vmv.v.x v26, a2
; CHECK-NEXT:    vxor.vi v26, v26, -1
; CHECK-NEXT:    vand.vv v26, v9, v26
; CHECK-NEXT:    vor.vv v8, v25, v26
; CHECK-NEXT:    ret
  %cmp = icmp ne i8 %a, %b
  %v = select i1 %cmp, <16 x i8> %c, <16 x i8> %d
  ret <16 x i8> %v
}

define <2 x i16> @select_v2i16(i1 zeroext %c, <2 x i16> %a, <2 x i16> %b) {
; CHECK-LABEL: select_v2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, zero, -1
; CHECK-NEXT:    bnez a0, .LBB18_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a1, zero
; CHECK-NEXT:  .LBB18_2:
; CHECK-NEXT:    vsetivli a0, 2, e16,mf4,ta,mu
; CHECK-NEXT:    vand.vx v25, v8, a1
; CHECK-NEXT:    vmv.v.x v26, a1
; CHECK-NEXT:    vxor.vi v26, v26, -1
; CHECK-NEXT:    vand.vv v26, v9, v26
; CHECK-NEXT:    vor.vv v8, v25, v26
; CHECK-NEXT:    ret
  %v = select i1 %c, <2 x i16> %a, <2 x i16> %b
  ret <2 x i16> %v
}

define <2 x i16> @selectcc_v2i16(i16 signext %a, i16 signext %b, <2 x i16> %c, <2 x i16> %d) {
; CHECK-LABEL: selectcc_v2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a2, zero, -1
; CHECK-NEXT:    bne a0, a1, .LBB19_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a2, zero
; CHECK-NEXT:  .LBB19_2:
; CHECK-NEXT:    vsetivli a0, 2, e16,mf4,ta,mu
; CHECK-NEXT:    vand.vx v25, v8, a2
; CHECK-NEXT:    vmv.v.x v26, a2
; CHECK-NEXT:    vxor.vi v26, v26, -1
; CHECK-NEXT:    vand.vv v26, v9, v26
; CHECK-NEXT:    vor.vv v8, v25, v26
; CHECK-NEXT:    ret
  %cmp = icmp ne i16 %a, %b
  %v = select i1 %cmp, <2 x i16> %c, <2 x i16> %d
  ret <2 x i16> %v
}

define <4 x i16> @select_v4i16(i1 zeroext %c, <4 x i16> %a, <4 x i16> %b) {
; CHECK-LABEL: select_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, zero, -1
; CHECK-NEXT:    bnez a0, .LBB20_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a1, zero
; CHECK-NEXT:  .LBB20_2:
; CHECK-NEXT:    vsetivli a0, 4, e16,mf2,ta,mu
; CHECK-NEXT:    vand.vx v25, v8, a1
; CHECK-NEXT:    vmv.v.x v26, a1
; CHECK-NEXT:    vxor.vi v26, v26, -1
; CHECK-NEXT:    vand.vv v26, v9, v26
; CHECK-NEXT:    vor.vv v8, v25, v26
; CHECK-NEXT:    ret
  %v = select i1 %c, <4 x i16> %a, <4 x i16> %b
  ret <4 x i16> %v
}

define <4 x i16> @selectcc_v4i16(i16 signext %a, i16 signext %b, <4 x i16> %c, <4 x i16> %d) {
; CHECK-LABEL: selectcc_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a2, zero, -1
; CHECK-NEXT:    bne a0, a1, .LBB21_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a2, zero
; CHECK-NEXT:  .LBB21_2:
; CHECK-NEXT:    vsetivli a0, 4, e16,mf2,ta,mu
; CHECK-NEXT:    vand.vx v25, v8, a2
; CHECK-NEXT:    vmv.v.x v26, a2
; CHECK-NEXT:    vxor.vi v26, v26, -1
; CHECK-NEXT:    vand.vv v26, v9, v26
; CHECK-NEXT:    vor.vv v8, v25, v26
; CHECK-NEXT:    ret
  %cmp = icmp ne i16 %a, %b
  %v = select i1 %cmp, <4 x i16> %c, <4 x i16> %d
  ret <4 x i16> %v
}

define <8 x i16> @select_v8i16(i1 zeroext %c, <8 x i16> %a, <8 x i16> %b) {
; CHECK-LABEL: select_v8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, zero, -1
; CHECK-NEXT:    bnez a0, .LBB22_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a1, zero
; CHECK-NEXT:  .LBB22_2:
; CHECK-NEXT:    vsetivli a0, 8, e16,m1,ta,mu
; CHECK-NEXT:    vand.vx v25, v8, a1
; CHECK-NEXT:    vmv.v.x v26, a1
; CHECK-NEXT:    vxor.vi v26, v26, -1
; CHECK-NEXT:    vand.vv v26, v9, v26
; CHECK-NEXT:    vor.vv v8, v25, v26
; CHECK-NEXT:    ret
  %v = select i1 %c, <8 x i16> %a, <8 x i16> %b
  ret <8 x i16> %v
}

define <8 x i16> @selectcc_v8i16(i16 signext %a, i16 signext %b, <8 x i16> %c, <8 x i16> %d) {
; CHECK-LABEL: selectcc_v8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a2, zero, -1
; CHECK-NEXT:    bne a0, a1, .LBB23_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a2, zero
; CHECK-NEXT:  .LBB23_2:
; CHECK-NEXT:    vsetivli a0, 8, e16,m1,ta,mu
; CHECK-NEXT:    vand.vx v25, v8, a2
; CHECK-NEXT:    vmv.v.x v26, a2
; CHECK-NEXT:    vxor.vi v26, v26, -1
; CHECK-NEXT:    vand.vv v26, v9, v26
; CHECK-NEXT:    vor.vv v8, v25, v26
; CHECK-NEXT:    ret
  %cmp = icmp ne i16 %a, %b
  %v = select i1 %cmp, <8 x i16> %c, <8 x i16> %d
  ret <8 x i16> %v
}

define <16 x i16> @select_v16i16(i1 zeroext %c, <16 x i16> %a, <16 x i16> %b) {
; CHECK-LABEL: select_v16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, zero, -1
; CHECK-NEXT:    bnez a0, .LBB24_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a1, zero
; CHECK-NEXT:  .LBB24_2:
; CHECK-NEXT:    vsetivli a0, 16, e16,m2,ta,mu
; CHECK-NEXT:    vand.vx v26, v8, a1
; CHECK-NEXT:    vmv.v.x v28, a1
; CHECK-NEXT:    vxor.vi v28, v28, -1
; CHECK-NEXT:    vand.vv v28, v10, v28
; CHECK-NEXT:    vor.vv v8, v26, v28
; CHECK-NEXT:    ret
  %v = select i1 %c, <16 x i16> %a, <16 x i16> %b
  ret <16 x i16> %v
}

define <16 x i16> @selectcc_v16i16(i16 signext %a, i16 signext %b, <16 x i16> %c, <16 x i16> %d) {
; CHECK-LABEL: selectcc_v16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a2, zero, -1
; CHECK-NEXT:    bne a0, a1, .LBB25_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a2, zero
; CHECK-NEXT:  .LBB25_2:
; CHECK-NEXT:    vsetivli a0, 16, e16,m2,ta,mu
; CHECK-NEXT:    vand.vx v26, v8, a2
; CHECK-NEXT:    vmv.v.x v28, a2
; CHECK-NEXT:    vxor.vi v28, v28, -1
; CHECK-NEXT:    vand.vv v28, v10, v28
; CHECK-NEXT:    vor.vv v8, v26, v28
; CHECK-NEXT:    ret
  %cmp = icmp ne i16 %a, %b
  %v = select i1 %cmp, <16 x i16> %c, <16 x i16> %d
  ret <16 x i16> %v
}

define <2 x i32> @select_v2i32(i1 zeroext %c, <2 x i32> %a, <2 x i32> %b) {
; CHECK-LABEL: select_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, zero, -1
; CHECK-NEXT:    bnez a0, .LBB26_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a1, zero
; CHECK-NEXT:  .LBB26_2:
; CHECK-NEXT:    vsetivli a0, 2, e32,mf2,ta,mu
; CHECK-NEXT:    vand.vx v25, v8, a1
; CHECK-NEXT:    vmv.v.x v26, a1
; CHECK-NEXT:    vxor.vi v26, v26, -1
; CHECK-NEXT:    vand.vv v26, v9, v26
; CHECK-NEXT:    vor.vv v8, v25, v26
; CHECK-NEXT:    ret
  %v = select i1 %c, <2 x i32> %a, <2 x i32> %b
  ret <2 x i32> %v
}

define <2 x i32> @selectcc_v2i32(i32 signext %a, i32 signext %b, <2 x i32> %c, <2 x i32> %d) {
; CHECK-LABEL: selectcc_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a2, zero, -1
; CHECK-NEXT:    bne a0, a1, .LBB27_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a2, zero
; CHECK-NEXT:  .LBB27_2:
; CHECK-NEXT:    vsetivli a0, 2, e32,mf2,ta,mu
; CHECK-NEXT:    vand.vx v25, v8, a2
; CHECK-NEXT:    vmv.v.x v26, a2
; CHECK-NEXT:    vxor.vi v26, v26, -1
; CHECK-NEXT:    vand.vv v26, v9, v26
; CHECK-NEXT:    vor.vv v8, v25, v26
; CHECK-NEXT:    ret
  %cmp = icmp ne i32 %a, %b
  %v = select i1 %cmp, <2 x i32> %c, <2 x i32> %d
  ret <2 x i32> %v
}

define <4 x i32> @select_v4i32(i1 zeroext %c, <4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: select_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, zero, -1
; CHECK-NEXT:    bnez a0, .LBB28_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a1, zero
; CHECK-NEXT:  .LBB28_2:
; CHECK-NEXT:    vsetivli a0, 4, e32,m1,ta,mu
; CHECK-NEXT:    vand.vx v25, v8, a1
; CHECK-NEXT:    vmv.v.x v26, a1
; CHECK-NEXT:    vxor.vi v26, v26, -1
; CHECK-NEXT:    vand.vv v26, v9, v26
; CHECK-NEXT:    vor.vv v8, v25, v26
; CHECK-NEXT:    ret
  %v = select i1 %c, <4 x i32> %a, <4 x i32> %b
  ret <4 x i32> %v
}

define <4 x i32> @selectcc_v4i32(i32 signext %a, i32 signext %b, <4 x i32> %c, <4 x i32> %d) {
; CHECK-LABEL: selectcc_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a2, zero, -1
; CHECK-NEXT:    bne a0, a1, .LBB29_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a2, zero
; CHECK-NEXT:  .LBB29_2:
; CHECK-NEXT:    vsetivli a0, 4, e32,m1,ta,mu
; CHECK-NEXT:    vand.vx v25, v8, a2
; CHECK-NEXT:    vmv.v.x v26, a2
; CHECK-NEXT:    vxor.vi v26, v26, -1
; CHECK-NEXT:    vand.vv v26, v9, v26
; CHECK-NEXT:    vor.vv v8, v25, v26
; CHECK-NEXT:    ret
  %cmp = icmp ne i32 %a, %b
  %v = select i1 %cmp, <4 x i32> %c, <4 x i32> %d
  ret <4 x i32> %v
}

define <8 x i32> @select_v8i32(i1 zeroext %c, <8 x i32> %a, <8 x i32> %b) {
; CHECK-LABEL: select_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, zero, -1
; CHECK-NEXT:    bnez a0, .LBB30_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a1, zero
; CHECK-NEXT:  .LBB30_2:
; CHECK-NEXT:    vsetivli a0, 8, e32,m2,ta,mu
; CHECK-NEXT:    vand.vx v26, v8, a1
; CHECK-NEXT:    vmv.v.x v28, a1
; CHECK-NEXT:    vxor.vi v28, v28, -1
; CHECK-NEXT:    vand.vv v28, v10, v28
; CHECK-NEXT:    vor.vv v8, v26, v28
; CHECK-NEXT:    ret
  %v = select i1 %c, <8 x i32> %a, <8 x i32> %b
  ret <8 x i32> %v
}

define <8 x i32> @selectcc_v8i32(i32 signext %a, i32 signext %b, <8 x i32> %c, <8 x i32> %d) {
; CHECK-LABEL: selectcc_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a2, zero, -1
; CHECK-NEXT:    bne a0, a1, .LBB31_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a2, zero
; CHECK-NEXT:  .LBB31_2:
; CHECK-NEXT:    vsetivli a0, 8, e32,m2,ta,mu
; CHECK-NEXT:    vand.vx v26, v8, a2
; CHECK-NEXT:    vmv.v.x v28, a2
; CHECK-NEXT:    vxor.vi v28, v28, -1
; CHECK-NEXT:    vand.vv v28, v10, v28
; CHECK-NEXT:    vor.vv v8, v26, v28
; CHECK-NEXT:    ret
  %cmp = icmp ne i32 %a, %b
  %v = select i1 %cmp, <8 x i32> %c, <8 x i32> %d
  ret <8 x i32> %v
}

define <16 x i32> @select_v16i32(i1 zeroext %c, <16 x i32> %a, <16 x i32> %b) {
; CHECK-LABEL: select_v16i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, zero, -1
; CHECK-NEXT:    bnez a0, .LBB32_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a1, zero
; CHECK-NEXT:  .LBB32_2:
; CHECK-NEXT:    vsetivli a0, 16, e32,m4,ta,mu
; CHECK-NEXT:    vand.vx v28, v8, a1
; CHECK-NEXT:    vmv.v.x v8, a1
; CHECK-NEXT:    vxor.vi v8, v8, -1
; CHECK-NEXT:    vand.vv v8, v12, v8
; CHECK-NEXT:    vor.vv v8, v28, v8
; CHECK-NEXT:    ret
  %v = select i1 %c, <16 x i32> %a, <16 x i32> %b
  ret <16 x i32> %v
}

define <16 x i32> @selectcc_v16i32(i32 signext %a, i32 signext %b, <16 x i32> %c, <16 x i32> %d) {
; CHECK-LABEL: selectcc_v16i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a2, zero, -1
; CHECK-NEXT:    bne a0, a1, .LBB33_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a2, zero
; CHECK-NEXT:  .LBB33_2:
; CHECK-NEXT:    vsetivli a0, 16, e32,m4,ta,mu
; CHECK-NEXT:    vand.vx v28, v8, a2
; CHECK-NEXT:    vmv.v.x v8, a2
; CHECK-NEXT:    vxor.vi v8, v8, -1
; CHECK-NEXT:    vand.vv v8, v12, v8
; CHECK-NEXT:    vor.vv v8, v28, v8
; CHECK-NEXT:    ret
  %cmp = icmp ne i32 %a, %b
  %v = select i1 %cmp, <16 x i32> %c, <16 x i32> %d
  ret <16 x i32> %v
}

define <2 x i64> @select_v2i64(i1 zeroext %c, <2 x i64> %a, <2 x i64> %b) {
; RV32-LABEL: select_v2i64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi a1, zero, -1
; RV32-NEXT:    bnez a0, .LBB34_2
; RV32-NEXT:  # %bb.1:
; RV32-NEXT:    mv a1, zero
; RV32-NEXT:  .LBB34_2:
; RV32-NEXT:    vsetivli a0, 4, e32,m1,ta,mu
; RV32-NEXT:    vmv.v.x v25, a1
; RV32-NEXT:    vsetivli a0, 2, e64,m1,ta,mu
; RV32-NEXT:    vand.vv v26, v8, v25
; RV32-NEXT:    vsetivli a0, 4, e32,m1,ta,mu
; RV32-NEXT:    vmv.v.i v27, -1
; RV32-NEXT:    vsetivli a0, 2, e64,m1,ta,mu
; RV32-NEXT:    vxor.vv v25, v25, v27
; RV32-NEXT:    vand.vv v25, v9, v25
; RV32-NEXT:    vor.vv v8, v26, v25
; RV32-NEXT:    ret
;
; RV64-LABEL: select_v2i64:
; RV64:       # %bb.0:
; RV64-NEXT:    addi a1, zero, -1
; RV64-NEXT:    bnez a0, .LBB34_2
; RV64-NEXT:  # %bb.1:
; RV64-NEXT:    mv a1, zero
; RV64-NEXT:  .LBB34_2:
; RV64-NEXT:    vsetivli a0, 2, e64,m1,ta,mu
; RV64-NEXT:    vand.vx v25, v8, a1
; RV64-NEXT:    vmv.v.x v26, a1
; RV64-NEXT:    vxor.vi v26, v26, -1
; RV64-NEXT:    vand.vv v26, v9, v26
; RV64-NEXT:    vor.vv v8, v25, v26
; RV64-NEXT:    ret
  %v = select i1 %c, <2 x i64> %a, <2 x i64> %b
  ret <2 x i64> %v
}

define <2 x i64> @selectcc_v2i64(i64 signext %a, i64 signext %b, <2 x i64> %c, <2 x i64> %d) {
; RV32-LABEL: selectcc_v2i64:
; RV32:       # %bb.0:
; RV32-NEXT:    xor a1, a1, a3
; RV32-NEXT:    xor a0, a0, a2
; RV32-NEXT:    or a1, a0, a1
; RV32-NEXT:    addi a0, zero, -1
; RV32-NEXT:    bnez a1, .LBB35_2
; RV32-NEXT:  # %bb.1:
; RV32-NEXT:    mv a0, zero
; RV32-NEXT:  .LBB35_2:
; RV32-NEXT:    vsetivli a1, 4, e32,m1,ta,mu
; RV32-NEXT:    vmv.v.x v25, a0
; RV32-NEXT:    vsetivli a0, 2, e64,m1,ta,mu
; RV32-NEXT:    vand.vv v26, v8, v25
; RV32-NEXT:    vsetivli a0, 4, e32,m1,ta,mu
; RV32-NEXT:    vmv.v.i v27, -1
; RV32-NEXT:    vsetivli a0, 2, e64,m1,ta,mu
; RV32-NEXT:    vxor.vv v25, v25, v27
; RV32-NEXT:    vand.vv v25, v9, v25
; RV32-NEXT:    vor.vv v8, v26, v25
; RV32-NEXT:    ret
;
; RV64-LABEL: selectcc_v2i64:
; RV64:       # %bb.0:
; RV64-NEXT:    addi a2, zero, -1
; RV64-NEXT:    bne a0, a1, .LBB35_2
; RV64-NEXT:  # %bb.1:
; RV64-NEXT:    mv a2, zero
; RV64-NEXT:  .LBB35_2:
; RV64-NEXT:    vsetivli a0, 2, e64,m1,ta,mu
; RV64-NEXT:    vand.vx v25, v8, a2
; RV64-NEXT:    vmv.v.x v26, a2
; RV64-NEXT:    vxor.vi v26, v26, -1
; RV64-NEXT:    vand.vv v26, v9, v26
; RV64-NEXT:    vor.vv v8, v25, v26
; RV64-NEXT:    ret
  %cmp = icmp ne i64 %a, %b
  %v = select i1 %cmp, <2 x i64> %c, <2 x i64> %d
  ret <2 x i64> %v
}

define <4 x i64> @select_v4i64(i1 zeroext %c, <4 x i64> %a, <4 x i64> %b) {
; RV32-LABEL: select_v4i64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi a1, zero, -1
; RV32-NEXT:    bnez a0, .LBB36_2
; RV32-NEXT:  # %bb.1:
; RV32-NEXT:    mv a1, zero
; RV32-NEXT:  .LBB36_2:
; RV32-NEXT:    vsetivli a0, 8, e32,m2,ta,mu
; RV32-NEXT:    vmv.v.x v26, a1
; RV32-NEXT:    vsetivli a0, 4, e64,m2,ta,mu
; RV32-NEXT:    vand.vv v28, v8, v26
; RV32-NEXT:    vsetivli a0, 8, e32,m2,ta,mu
; RV32-NEXT:    vmv.v.i v30, -1
; RV32-NEXT:    vsetivli a0, 4, e64,m2,ta,mu
; RV32-NEXT:    vxor.vv v26, v26, v30
; RV32-NEXT:    vand.vv v26, v10, v26
; RV32-NEXT:    vor.vv v8, v28, v26
; RV32-NEXT:    ret
;
; RV64-LABEL: select_v4i64:
; RV64:       # %bb.0:
; RV64-NEXT:    addi a1, zero, -1
; RV64-NEXT:    bnez a0, .LBB36_2
; RV64-NEXT:  # %bb.1:
; RV64-NEXT:    mv a1, zero
; RV64-NEXT:  .LBB36_2:
; RV64-NEXT:    vsetivli a0, 4, e64,m2,ta,mu
; RV64-NEXT:    vand.vx v26, v8, a1
; RV64-NEXT:    vmv.v.x v28, a1
; RV64-NEXT:    vxor.vi v28, v28, -1
; RV64-NEXT:    vand.vv v28, v10, v28
; RV64-NEXT:    vor.vv v8, v26, v28
; RV64-NEXT:    ret
  %v = select i1 %c, <4 x i64> %a, <4 x i64> %b
  ret <4 x i64> %v
}

define <4 x i64> @selectcc_v4i64(i64 signext %a, i64 signext %b, <4 x i64> %c, <4 x i64> %d) {
; RV32-LABEL: selectcc_v4i64:
; RV32:       # %bb.0:
; RV32-NEXT:    xor a1, a1, a3
; RV32-NEXT:    xor a0, a0, a2
; RV32-NEXT:    or a1, a0, a1
; RV32-NEXT:    addi a0, zero, -1
; RV32-NEXT:    bnez a1, .LBB37_2
; RV32-NEXT:  # %bb.1:
; RV32-NEXT:    mv a0, zero
; RV32-NEXT:  .LBB37_2:
; RV32-NEXT:    vsetivli a1, 8, e32,m2,ta,mu
; RV32-NEXT:    vmv.v.x v26, a0
; RV32-NEXT:    vsetivli a0, 4, e64,m2,ta,mu
; RV32-NEXT:    vand.vv v28, v8, v26
; RV32-NEXT:    vsetivli a0, 8, e32,m2,ta,mu
; RV32-NEXT:    vmv.v.i v30, -1
; RV32-NEXT:    vsetivli a0, 4, e64,m2,ta,mu
; RV32-NEXT:    vxor.vv v26, v26, v30
; RV32-NEXT:    vand.vv v26, v10, v26
; RV32-NEXT:    vor.vv v8, v28, v26
; RV32-NEXT:    ret
;
; RV64-LABEL: selectcc_v4i64:
; RV64:       # %bb.0:
; RV64-NEXT:    addi a2, zero, -1
; RV64-NEXT:    bne a0, a1, .LBB37_2
; RV64-NEXT:  # %bb.1:
; RV64-NEXT:    mv a2, zero
; RV64-NEXT:  .LBB37_2:
; RV64-NEXT:    vsetivli a0, 4, e64,m2,ta,mu
; RV64-NEXT:    vand.vx v26, v8, a2
; RV64-NEXT:    vmv.v.x v28, a2
; RV64-NEXT:    vxor.vi v28, v28, -1
; RV64-NEXT:    vand.vv v28, v10, v28
; RV64-NEXT:    vor.vv v8, v26, v28
; RV64-NEXT:    ret
  %cmp = icmp ne i64 %a, %b
  %v = select i1 %cmp, <4 x i64> %c, <4 x i64> %d
  ret <4 x i64> %v
}

define <8 x i64> @select_v8i64(i1 zeroext %c, <8 x i64> %a, <8 x i64> %b) {
; RV32-LABEL: select_v8i64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi a1, zero, -1
; RV32-NEXT:    bnez a0, .LBB38_2
; RV32-NEXT:  # %bb.1:
; RV32-NEXT:    mv a1, zero
; RV32-NEXT:  .LBB38_2:
; RV32-NEXT:    vsetivli a0, 16, e32,m4,ta,mu
; RV32-NEXT:    vmv.v.x v28, a1
; RV32-NEXT:    vsetivli a0, 8, e64,m4,ta,mu
; RV32-NEXT:    vand.vv v8, v8, v28
; RV32-NEXT:    vsetivli a0, 16, e32,m4,ta,mu
; RV32-NEXT:    vmv.v.i v16, -1
; RV32-NEXT:    vsetivli a0, 8, e64,m4,ta,mu
; RV32-NEXT:    vxor.vv v28, v28, v16
; RV32-NEXT:    vand.vv v28, v12, v28
; RV32-NEXT:    vor.vv v8, v8, v28
; RV32-NEXT:    ret
;
; RV64-LABEL: select_v8i64:
; RV64:       # %bb.0:
; RV64-NEXT:    addi a1, zero, -1
; RV64-NEXT:    bnez a0, .LBB38_2
; RV64-NEXT:  # %bb.1:
; RV64-NEXT:    mv a1, zero
; RV64-NEXT:  .LBB38_2:
; RV64-NEXT:    vsetivli a0, 8, e64,m4,ta,mu
; RV64-NEXT:    vand.vx v28, v8, a1
; RV64-NEXT:    vmv.v.x v8, a1
; RV64-NEXT:    vxor.vi v8, v8, -1
; RV64-NEXT:    vand.vv v8, v12, v8
; RV64-NEXT:    vor.vv v8, v28, v8
; RV64-NEXT:    ret
  %v = select i1 %c, <8 x i64> %a, <8 x i64> %b
  ret <8 x i64> %v
}

define <8 x i64> @selectcc_v8i64(i64 signext %a, i64 signext %b, <8 x i64> %c, <8 x i64> %d) {
; RV32-LABEL: selectcc_v8i64:
; RV32:       # %bb.0:
; RV32-NEXT:    xor a1, a1, a3
; RV32-NEXT:    xor a0, a0, a2
; RV32-NEXT:    or a1, a0, a1
; RV32-NEXT:    addi a0, zero, -1
; RV32-NEXT:    bnez a1, .LBB39_2
; RV32-NEXT:  # %bb.1:
; RV32-NEXT:    mv a0, zero
; RV32-NEXT:  .LBB39_2:
; RV32-NEXT:    vsetivli a1, 16, e32,m4,ta,mu
; RV32-NEXT:    vmv.v.x v28, a0
; RV32-NEXT:    vsetivli a0, 8, e64,m4,ta,mu
; RV32-NEXT:    vand.vv v8, v8, v28
; RV32-NEXT:    vsetivli a0, 16, e32,m4,ta,mu
; RV32-NEXT:    vmv.v.i v16, -1
; RV32-NEXT:    vsetivli a0, 8, e64,m4,ta,mu
; RV32-NEXT:    vxor.vv v28, v28, v16
; RV32-NEXT:    vand.vv v28, v12, v28
; RV32-NEXT:    vor.vv v8, v8, v28
; RV32-NEXT:    ret
;
; RV64-LABEL: selectcc_v8i64:
; RV64:       # %bb.0:
; RV64-NEXT:    addi a2, zero, -1
; RV64-NEXT:    bne a0, a1, .LBB39_2
; RV64-NEXT:  # %bb.1:
; RV64-NEXT:    mv a2, zero
; RV64-NEXT:  .LBB39_2:
; RV64-NEXT:    vsetivli a0, 8, e64,m4,ta,mu
; RV64-NEXT:    vand.vx v28, v8, a2
; RV64-NEXT:    vmv.v.x v8, a2
; RV64-NEXT:    vxor.vi v8, v8, -1
; RV64-NEXT:    vand.vv v8, v12, v8
; RV64-NEXT:    vor.vv v8, v28, v8
; RV64-NEXT:    ret
  %cmp = icmp ne i64 %a, %b
  %v = select i1 %cmp, <8 x i64> %c, <8 x i64> %d
  ret <8 x i64> %v
}

define <16 x i64> @select_v16i64(i1 zeroext %c, <16 x i64> %a, <16 x i64> %b) {
; RV32-LABEL: select_v16i64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi a1, zero, -1
; RV32-NEXT:    bnez a0, .LBB40_2
; RV32-NEXT:  # %bb.1:
; RV32-NEXT:    mv a1, zero
; RV32-NEXT:  .LBB40_2:
; RV32-NEXT:    addi a0, zero, 32
; RV32-NEXT:    vsetvli a2, a0, e32,m8,ta,mu
; RV32-NEXT:    vmv.v.x v24, a1
; RV32-NEXT:    vsetivli a1, 16, e64,m8,ta,mu
; RV32-NEXT:    vand.vv v8, v8, v24
; RV32-NEXT:    vsetvli a0, a0, e32,m8,ta,mu
; RV32-NEXT:    vmv.v.i v0, -1
; RV32-NEXT:    vsetivli a0, 16, e64,m8,ta,mu
; RV32-NEXT:    vxor.vv v24, v24, v0
; RV32-NEXT:    vand.vv v16, v16, v24
; RV32-NEXT:    vor.vv v8, v8, v16
; RV32-NEXT:    ret
;
; RV64-LABEL: select_v16i64:
; RV64:       # %bb.0:
; RV64-NEXT:    addi a1, zero, -1
; RV64-NEXT:    bnez a0, .LBB40_2
; RV64-NEXT:  # %bb.1:
; RV64-NEXT:    mv a1, zero
; RV64-NEXT:  .LBB40_2:
; RV64-NEXT:    vsetivli a0, 16, e64,m8,ta,mu
; RV64-NEXT:    vand.vx v8, v8, a1
; RV64-NEXT:    vmv.v.x v24, a1
; RV64-NEXT:    vxor.vi v24, v24, -1
; RV64-NEXT:    vand.vv v16, v16, v24
; RV64-NEXT:    vor.vv v8, v8, v16
; RV64-NEXT:    ret
  %v = select i1 %c, <16 x i64> %a, <16 x i64> %b
  ret <16 x i64> %v
}

define <16 x i64> @selectcc_v16i64(i64 signext %a, i64 signext %b, <16 x i64> %c, <16 x i64> %d) {
; RV32-LABEL: selectcc_v16i64:
; RV32:       # %bb.0:
; RV32-NEXT:    xor a1, a1, a3
; RV32-NEXT:    xor a0, a0, a2
; RV32-NEXT:    or a1, a0, a1
; RV32-NEXT:    addi a0, zero, -1
; RV32-NEXT:    bnez a1, .LBB41_2
; RV32-NEXT:  # %bb.1:
; RV32-NEXT:    mv a0, zero
; RV32-NEXT:  .LBB41_2:
; RV32-NEXT:    addi a1, zero, 32
; RV32-NEXT:    vsetvli a2, a1, e32,m8,ta,mu
; RV32-NEXT:    vmv.v.x v24, a0
; RV32-NEXT:    vsetivli a0, 16, e64,m8,ta,mu
; RV32-NEXT:    vand.vv v8, v8, v24
; RV32-NEXT:    vsetvli a0, a1, e32,m8,ta,mu
; RV32-NEXT:    vmv.v.i v0, -1
; RV32-NEXT:    vsetivli a0, 16, e64,m8,ta,mu
; RV32-NEXT:    vxor.vv v24, v24, v0
; RV32-NEXT:    vand.vv v16, v16, v24
; RV32-NEXT:    vor.vv v8, v8, v16
; RV32-NEXT:    ret
;
; RV64-LABEL: selectcc_v16i64:
; RV64:       # %bb.0:
; RV64-NEXT:    addi a2, zero, -1
; RV64-NEXT:    bne a0, a1, .LBB41_2
; RV64-NEXT:  # %bb.1:
; RV64-NEXT:    mv a2, zero
; RV64-NEXT:  .LBB41_2:
; RV64-NEXT:    vsetivli a0, 16, e64,m8,ta,mu
; RV64-NEXT:    vand.vx v8, v8, a2
; RV64-NEXT:    vmv.v.x v24, a2
; RV64-NEXT:    vxor.vi v24, v24, -1
; RV64-NEXT:    vand.vv v16, v16, v24
; RV64-NEXT:    vor.vv v8, v8, v16
; RV64-NEXT:    ret
  %cmp = icmp ne i64 %a, %b
  %v = select i1 %cmp, <16 x i64> %c, <16 x i64> %d
  ret <16 x i64> %v
}
