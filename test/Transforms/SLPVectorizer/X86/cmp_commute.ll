; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -slp-vectorizer -instcombine -S -mtriple=x86_64--- -mattr=+sse2 | FileCheck %s --check-prefixes=CHECK,SSE
; RUN: opt < %s -slp-vectorizer -instcombine -S -mtriple=x86_64--- -mattr=+avx  | FileCheck %s --check-prefixes=CHECK,AVX

;
; Check that we can commute operands based on the predicate.
;

define <4 x i32> @icmp_eq_v4i32(<4 x i32> %a, i32* %b) {
; CHECK-LABEL: @icmp_eq_v4i32(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast i32* [[B:%.*]] to <4 x i32>*
; CHECK-NEXT:    [[TMP2:%.*]] = load <4 x i32>, <4 x i32>* [[TMP1]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = icmp eq <4 x i32> [[TMP2]], [[A:%.*]]
; CHECK-NEXT:    [[R:%.*]] = sext <4 x i1> [[TMP3]] to <4 x i32>
; CHECK-NEXT:    ret <4 x i32> [[R]]
;
  %a0 = extractelement <4 x i32> %a, i32 0
  %a1 = extractelement <4 x i32> %a, i32 1
  %a2 = extractelement <4 x i32> %a, i32 2
  %a3 = extractelement <4 x i32> %a, i32 3
  %p0 = getelementptr inbounds i32, i32* %b, i32 0
  %p1 = getelementptr inbounds i32, i32* %b, i32 1
  %p2 = getelementptr inbounds i32, i32* %b, i32 2
  %p3 = getelementptr inbounds i32, i32* %b, i32 3
  %b0 = load i32, i32* %p0, align 4
  %b1 = load i32, i32* %p1, align 4
  %b2 = load i32, i32* %p2, align 4
  %b3 = load i32, i32* %p3, align 4
  %c0 = icmp eq i32 %a0, %b0
  %c1 = icmp eq i32 %b1, %a1
  %c2 = icmp eq i32 %b2, %a2
  %c3 = icmp eq i32 %a3, %b3
  %d0 = insertelement <4 x i1> undef, i1 %c0, i32 0
  %d1 = insertelement <4 x i1>   %d0, i1 %c1, i32 1
  %d2 = insertelement <4 x i1>   %d1, i1 %c2, i32 2
  %d3 = insertelement <4 x i1>   %d2, i1 %c3, i32 3
  %r = sext <4 x i1> %d3 to <4 x i32>
  ret <4 x i32> %r
}

define <4 x i32> @icmp_ne_v4i32(<4 x i32> %a, i32* %b) {
; CHECK-LABEL: @icmp_ne_v4i32(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast i32* [[B:%.*]] to <4 x i32>*
; CHECK-NEXT:    [[TMP2:%.*]] = load <4 x i32>, <4 x i32>* [[TMP1]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = icmp ne <4 x i32> [[TMP2]], [[A:%.*]]
; CHECK-NEXT:    [[R:%.*]] = sext <4 x i1> [[TMP3]] to <4 x i32>
; CHECK-NEXT:    ret <4 x i32> [[R]]
;
  %a0 = extractelement <4 x i32> %a, i32 0
  %a1 = extractelement <4 x i32> %a, i32 1
  %a2 = extractelement <4 x i32> %a, i32 2
  %a3 = extractelement <4 x i32> %a, i32 3
  %p0 = getelementptr inbounds i32, i32* %b, i32 0
  %p1 = getelementptr inbounds i32, i32* %b, i32 1
  %p2 = getelementptr inbounds i32, i32* %b, i32 2
  %p3 = getelementptr inbounds i32, i32* %b, i32 3
  %b0 = load i32, i32* %p0, align 4
  %b1 = load i32, i32* %p1, align 4
  %b2 = load i32, i32* %p2, align 4
  %b3 = load i32, i32* %p3, align 4
  %c0 = icmp ne i32 %a0, %b0
  %c1 = icmp ne i32 %b1, %a1
  %c2 = icmp ne i32 %b2, %a2
  %c3 = icmp ne i32 %a3, %b3
  %d0 = insertelement <4 x i1> undef, i1 %c0, i32 0
  %d1 = insertelement <4 x i1>   %d0, i1 %c1, i32 1
  %d2 = insertelement <4 x i1>   %d1, i1 %c2, i32 2
  %d3 = insertelement <4 x i1>   %d2, i1 %c3, i32 3
  %r = sext <4 x i1> %d3 to <4 x i32>
  ret <4 x i32> %r
}

define <4 x i32> @fcmp_oeq_v4i32(<4 x float> %a, float* %b) {
; CHECK-LABEL: @fcmp_oeq_v4i32(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast float* [[B:%.*]] to <4 x float>*
; CHECK-NEXT:    [[TMP2:%.*]] = load <4 x float>, <4 x float>* [[TMP1]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = fcmp oeq <4 x float> [[TMP2]], [[A:%.*]]
; CHECK-NEXT:    [[R:%.*]] = sext <4 x i1> [[TMP3]] to <4 x i32>
; CHECK-NEXT:    ret <4 x i32> [[R]]
;
  %a0 = extractelement <4 x float> %a, i32 0
  %a1 = extractelement <4 x float> %a, i32 1
  %a2 = extractelement <4 x float> %a, i32 2
  %a3 = extractelement <4 x float> %a, i32 3
  %p0 = getelementptr inbounds float, float* %b, i32 0
  %p1 = getelementptr inbounds float, float* %b, i32 1
  %p2 = getelementptr inbounds float, float* %b, i32 2
  %p3 = getelementptr inbounds float, float* %b, i32 3
  %b0 = load float, float* %p0, align 4
  %b1 = load float, float* %p1, align 4
  %b2 = load float, float* %p2, align 4
  %b3 = load float, float* %p3, align 4
  %c0 = fcmp oeq float %a0, %b0
  %c1 = fcmp oeq float %b1, %a1
  %c2 = fcmp oeq float %b2, %a2
  %c3 = fcmp oeq float %a3, %b3
  %d0 = insertelement <4 x i1> undef, i1 %c0, i32 0
  %d1 = insertelement <4 x i1>   %d0, i1 %c1, i32 1
  %d2 = insertelement <4 x i1>   %d1, i1 %c2, i32 2
  %d3 = insertelement <4 x i1>   %d2, i1 %c3, i32 3
  %r = sext <4 x i1> %d3 to <4 x i32>
  ret <4 x i32> %r
}

define <4 x i32> @fcmp_uno_v4i32(<4 x float> %a, float* %b) {
; CHECK-LABEL: @fcmp_uno_v4i32(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast float* [[B:%.*]] to <4 x float>*
; CHECK-NEXT:    [[TMP2:%.*]] = load <4 x float>, <4 x float>* [[TMP1]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = fcmp uno <4 x float> [[TMP2]], [[A:%.*]]
; CHECK-NEXT:    [[R:%.*]] = sext <4 x i1> [[TMP3]] to <4 x i32>
; CHECK-NEXT:    ret <4 x i32> [[R]]
;
  %a0 = extractelement <4 x float> %a, i32 0
  %a1 = extractelement <4 x float> %a, i32 1
  %a2 = extractelement <4 x float> %a, i32 2
  %a3 = extractelement <4 x float> %a, i32 3
  %p0 = getelementptr inbounds float, float* %b, i32 0
  %p1 = getelementptr inbounds float, float* %b, i32 1
  %p2 = getelementptr inbounds float, float* %b, i32 2
  %p3 = getelementptr inbounds float, float* %b, i32 3
  %b0 = load float, float* %p0, align 4
  %b1 = load float, float* %p1, align 4
  %b2 = load float, float* %p2, align 4
  %b3 = load float, float* %p3, align 4
  %c0 = fcmp uno float %a0, %b0
  %c1 = fcmp uno float %b1, %a1
  %c2 = fcmp uno float %b2, %a2
  %c3 = fcmp uno float %a3, %b3
  %d0 = insertelement <4 x i1> undef, i1 %c0, i32 0
  %d1 = insertelement <4 x i1>   %d0, i1 %c1, i32 1
  %d2 = insertelement <4 x i1>   %d1, i1 %c2, i32 2
  %d3 = insertelement <4 x i1>   %d2, i1 %c3, i32 3
  %r = sext <4 x i1> %d3 to <4 x i32>
  ret <4 x i32> %r
}

;
; Check that we can commute operands by swapping the predicate.
;

define <4 x i32> @icmp_sgt_slt_v4i32(<4 x i32> %a, i32* %b) {
; CHECK-LABEL: @icmp_sgt_slt_v4i32(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast i32* [[B:%.*]] to <4 x i32>*
; CHECK-NEXT:    [[TMP2:%.*]] = load <4 x i32>, <4 x i32>* [[TMP1]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = icmp slt <4 x i32> [[TMP2]], [[A:%.*]]
; CHECK-NEXT:    [[R:%.*]] = sext <4 x i1> [[TMP3]] to <4 x i32>
; CHECK-NEXT:    ret <4 x i32> [[R]]
;
  %a0 = extractelement <4 x i32> %a, i32 0
  %a1 = extractelement <4 x i32> %a, i32 1
  %a2 = extractelement <4 x i32> %a, i32 2
  %a3 = extractelement <4 x i32> %a, i32 3
  %p0 = getelementptr inbounds i32, i32* %b, i32 0
  %p1 = getelementptr inbounds i32, i32* %b, i32 1
  %p2 = getelementptr inbounds i32, i32* %b, i32 2
  %p3 = getelementptr inbounds i32, i32* %b, i32 3
  %b0 = load i32, i32* %p0, align 4
  %b1 = load i32, i32* %p1, align 4
  %b2 = load i32, i32* %p2, align 4
  %b3 = load i32, i32* %p3, align 4
  %c0 = icmp sgt i32 %a0, %b0
  %c1 = icmp slt i32 %b1, %a1
  %c2 = icmp slt i32 %b2, %a2
  %c3 = icmp sgt i32 %a3, %b3
  %d0 = insertelement <4 x i1> undef, i1 %c0, i32 0
  %d1 = insertelement <4 x i1>   %d0, i1 %c1, i32 1
  %d2 = insertelement <4 x i1>   %d1, i1 %c2, i32 2
  %d3 = insertelement <4 x i1>   %d2, i1 %c3, i32 3
  %r = sext <4 x i1> %d3 to <4 x i32>
  ret <4 x i32> %r
}

define <4 x i32> @icmp_uge_ule_v4i32(<4 x i32> %a, i32* %b) {
; CHECK-LABEL: @icmp_uge_ule_v4i32(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast i32* [[B:%.*]] to <4 x i32>*
; CHECK-NEXT:    [[TMP2:%.*]] = load <4 x i32>, <4 x i32>* [[TMP1]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = icmp ule <4 x i32> [[TMP2]], [[A:%.*]]
; CHECK-NEXT:    [[R:%.*]] = sext <4 x i1> [[TMP3]] to <4 x i32>
; CHECK-NEXT:    ret <4 x i32> [[R]]
;
  %a0 = extractelement <4 x i32> %a, i32 0
  %a1 = extractelement <4 x i32> %a, i32 1
  %a2 = extractelement <4 x i32> %a, i32 2
  %a3 = extractelement <4 x i32> %a, i32 3
  %p0 = getelementptr inbounds i32, i32* %b, i32 0
  %p1 = getelementptr inbounds i32, i32* %b, i32 1
  %p2 = getelementptr inbounds i32, i32* %b, i32 2
  %p3 = getelementptr inbounds i32, i32* %b, i32 3
  %b0 = load i32, i32* %p0, align 4
  %b1 = load i32, i32* %p1, align 4
  %b2 = load i32, i32* %p2, align 4
  %b3 = load i32, i32* %p3, align 4
  %c0 = icmp uge i32 %a0, %b0
  %c1 = icmp ule i32 %b1, %a1
  %c2 = icmp ule i32 %b2, %a2
  %c3 = icmp uge i32 %a3, %b3
  %d0 = insertelement <4 x i1> undef, i1 %c0, i32 0
  %d1 = insertelement <4 x i1>   %d0, i1 %c1, i32 1
  %d2 = insertelement <4 x i1>   %d1, i1 %c2, i32 2
  %d3 = insertelement <4 x i1>   %d2, i1 %c3, i32 3
  %r = sext <4 x i1> %d3 to <4 x i32>
  ret <4 x i32> %r
}

define <4 x i32> @fcmp_ogt_olt_v4i32(<4 x float> %a, float* %b) {
; CHECK-LABEL: @fcmp_ogt_olt_v4i32(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast float* [[B:%.*]] to <4 x float>*
; CHECK-NEXT:    [[TMP2:%.*]] = load <4 x float>, <4 x float>* [[TMP1]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = fcmp olt <4 x float> [[TMP2]], [[A:%.*]]
; CHECK-NEXT:    [[R:%.*]] = sext <4 x i1> [[TMP3]] to <4 x i32>
; CHECK-NEXT:    ret <4 x i32> [[R]]
;
  %a0 = extractelement <4 x float> %a, i32 0
  %a1 = extractelement <4 x float> %a, i32 1
  %a2 = extractelement <4 x float> %a, i32 2
  %a3 = extractelement <4 x float> %a, i32 3
  %p0 = getelementptr inbounds float, float* %b, i32 0
  %p1 = getelementptr inbounds float, float* %b, i32 1
  %p2 = getelementptr inbounds float, float* %b, i32 2
  %p3 = getelementptr inbounds float, float* %b, i32 3
  %b0 = load float, float* %p0, align 4
  %b1 = load float, float* %p1, align 4
  %b2 = load float, float* %p2, align 4
  %b3 = load float, float* %p3, align 4
  %c0 = fcmp ogt float %a0, %b0
  %c1 = fcmp olt float %b1, %a1
  %c2 = fcmp olt float %b2, %a2
  %c3 = fcmp ogt float %a3, %b3
  %d0 = insertelement <4 x i1> undef, i1 %c0, i32 0
  %d1 = insertelement <4 x i1>   %d0, i1 %c1, i32 1
  %d2 = insertelement <4 x i1>   %d1, i1 %c2, i32 2
  %d3 = insertelement <4 x i1>   %d2, i1 %c3, i32 3
  %r = sext <4 x i1> %d3 to <4 x i32>
  ret <4 x i32> %r
}

define <4 x i32> @fcmp_ord_uno_v4i32(<4 x float> %a, float* %b) {
; SSE-LABEL: @fcmp_ord_uno_v4i32(
; SSE-NEXT:    [[A0:%.*]] = extractelement <4 x float> [[A:%.*]], i32 0
; SSE-NEXT:    [[A1:%.*]] = extractelement <4 x float> [[A]], i32 1
; SSE-NEXT:    [[A2:%.*]] = extractelement <4 x float> [[A]], i32 2
; SSE-NEXT:    [[A3:%.*]] = extractelement <4 x float> [[A]], i32 3
; SSE-NEXT:    [[P1:%.*]] = getelementptr inbounds float, float* [[B:%.*]], i64 1
; SSE-NEXT:    [[P2:%.*]] = getelementptr inbounds float, float* [[B]], i64 2
; SSE-NEXT:    [[P3:%.*]] = getelementptr inbounds float, float* [[B]], i64 3
; SSE-NEXT:    [[B0:%.*]] = load float, float* [[B]], align 4
; SSE-NEXT:    [[B1:%.*]] = load float, float* [[P1]], align 4
; SSE-NEXT:    [[B2:%.*]] = load float, float* [[P2]], align 4
; SSE-NEXT:    [[B3:%.*]] = load float, float* [[P3]], align 4
; SSE-NEXT:    [[C0:%.*]] = fcmp ord float [[A0]], [[B0]]
; SSE-NEXT:    [[C1:%.*]] = fcmp uno float [[B1]], [[A1]]
; SSE-NEXT:    [[C2:%.*]] = fcmp uno float [[B2]], [[A2]]
; SSE-NEXT:    [[C3:%.*]] = fcmp ord float [[A3]], [[B3]]
; SSE-NEXT:    [[D0:%.*]] = insertelement <4 x i1> undef, i1 [[C0]], i32 0
; SSE-NEXT:    [[D1:%.*]] = insertelement <4 x i1> [[D0]], i1 [[C1]], i32 1
; SSE-NEXT:    [[D2:%.*]] = insertelement <4 x i1> [[D1]], i1 [[C2]], i32 2
; SSE-NEXT:    [[D3:%.*]] = insertelement <4 x i1> [[D2]], i1 [[C3]], i32 3
; SSE-NEXT:    [[R:%.*]] = sext <4 x i1> [[D3]] to <4 x i32>
; SSE-NEXT:    ret <4 x i32> [[R]]
;
; AVX-LABEL: @fcmp_ord_uno_v4i32(
; AVX-NEXT:    [[A0:%.*]] = extractelement <4 x float> [[A:%.*]], i32 0
; AVX-NEXT:    [[A3:%.*]] = extractelement <4 x float> [[A]], i32 3
; AVX-NEXT:    [[P1:%.*]] = getelementptr inbounds float, float* [[B:%.*]], i64 1
; AVX-NEXT:    [[P3:%.*]] = getelementptr inbounds float, float* [[B]], i64 3
; AVX-NEXT:    [[B0:%.*]] = load float, float* [[B]], align 4
; AVX-NEXT:    [[TMP1:%.*]] = bitcast float* [[P1]] to <2 x float>*
; AVX-NEXT:    [[TMP2:%.*]] = load <2 x float>, <2 x float>* [[TMP1]], align 4
; AVX-NEXT:    [[B3:%.*]] = load float, float* [[P3]], align 4
; AVX-NEXT:    [[C0:%.*]] = fcmp ord float [[A0]], [[B0]]
; AVX-NEXT:    [[TMP3:%.*]] = shufflevector <4 x float> [[A]], <4 x float> undef, <2 x i32> <i32 1, i32 2>
; AVX-NEXT:    [[TMP4:%.*]] = fcmp uno <2 x float> [[TMP2]], [[TMP3]]
; AVX-NEXT:    [[C3:%.*]] = fcmp ord float [[A3]], [[B3]]
; AVX-NEXT:    [[D0:%.*]] = insertelement <4 x i1> undef, i1 [[C0]], i32 0
; AVX-NEXT:    [[TMP5:%.*]] = shufflevector <2 x i1> [[TMP4]], <2 x i1> poison, <4 x i32> <i32 0, i32 1, i32 undef, i32 undef>
; AVX-NEXT:    [[D21:%.*]] = shufflevector <4 x i1> [[D0]], <4 x i1> [[TMP5]], <4 x i32> <i32 0, i32 4, i32 5, i32 undef>
; AVX-NEXT:    [[D3:%.*]] = insertelement <4 x i1> [[D21]], i1 [[C3]], i32 3
; AVX-NEXT:    [[R:%.*]] = sext <4 x i1> [[D3]] to <4 x i32>
; AVX-NEXT:    ret <4 x i32> [[R]]
;
  %a0 = extractelement <4 x float> %a, i32 0
  %a1 = extractelement <4 x float> %a, i32 1
  %a2 = extractelement <4 x float> %a, i32 2
  %a3 = extractelement <4 x float> %a, i32 3
  %p0 = getelementptr inbounds float, float* %b, i32 0
  %p1 = getelementptr inbounds float, float* %b, i32 1
  %p2 = getelementptr inbounds float, float* %b, i32 2
  %p3 = getelementptr inbounds float, float* %b, i32 3
  %b0 = load float, float* %p0, align 4
  %b1 = load float, float* %p1, align 4
  %b2 = load float, float* %p2, align 4
  %b3 = load float, float* %p3, align 4
  %c0 = fcmp ord float %a0, %b0
  %c1 = fcmp uno float %b1, %a1
  %c2 = fcmp uno float %b2, %a2
  %c3 = fcmp ord float %a3, %b3
  %d0 = insertelement <4 x i1> undef, i1 %c0, i32 0
  %d1 = insertelement <4 x i1>   %d0, i1 %c1, i32 1
  %d2 = insertelement <4 x i1>   %d1, i1 %c2, i32 2
  %d3 = insertelement <4 x i1>   %d2, i1 %c3, i32 3
  %r = sext <4 x i1> %d3 to <4 x i32>
  ret <4 x i32> %r
}
