; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -loop-vectorize -force-vector-width=4 -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+mve.fp -tail-predication=force-enabled -S %s -o - | FileCheck %s

define void @test_stride1_4i32(i32* readonly %data, i32* noalias nocapture %dst, i32 %n) {
; CHECK-LABEL: @test_stride1_4i32(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_RND_UP:%.*]] = add i32 [[N:%.*]], 3
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i32 [[N_RND_UP]], 4
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i32 [[N_RND_UP]], [[N_MOD_VF]]
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <4 x i32> undef, i32 [[INDEX]], i32 0
; CHECK-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <4 x i32> [[BROADCAST_SPLATINSERT]], <4 x i32> undef, <4 x i32> zeroinitializer
; CHECK-NEXT:    [[INDUCTION:%.*]] = add <4 x i32> [[BROADCAST_SPLAT]], <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[TMP0:%.*]] = add i32 [[INDEX]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = mul nuw nsw i32 [[TMP0]], 1
; CHECK-NEXT:    [[TMP2:%.*]] = add nuw nsw i32 [[TMP1]], 2
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i32, i32* [[DATA:%.*]], i32 [[TMP2]]
; CHECK-NEXT:    [[ACTIVE_LANE_MASK:%.*]] = call <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32 [[TMP0]], i32 [[N]])
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i32, i32* [[TMP3]], i32 0
; CHECK-NEXT:    [[TMP5:%.*]] = bitcast i32* [[TMP4]] to <4 x i32>*
; CHECK-NEXT:    [[WIDE_MASKED_LOAD:%.*]] = call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* [[TMP5]], i32 4, <4 x i1> [[ACTIVE_LANE_MASK]], <4 x i32> undef)
; CHECK-NEXT:    [[TMP6:%.*]] = add nsw <4 x i32> <i32 5, i32 5, i32 5, i32 5>, [[WIDE_MASKED_LOAD]]
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds i32, i32* [[DST:%.*]], i32 [[TMP0]]
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds i32, i32* [[TMP7]], i32 0
; CHECK-NEXT:    [[TMP9:%.*]] = bitcast i32* [[TMP8]] to <4 x i32>*
; CHECK-NEXT:    call void @llvm.masked.store.v4i32.p0v4i32(<4 x i32> [[TMP6]], <4 x i32>* [[TMP9]], i32 4, <4 x i1> [[ACTIVE_LANE_MASK]])
; CHECK-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], 4
; CHECK-NEXT:    [[TMP10:%.*]] = icmp eq i32 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP10]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], [[LOOP0:!llvm.loop !.*]]
; CHECK:       middle.block:
; CHECK-NEXT:    br i1 true, label [[END:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_023:%.*]] = phi i32 [ [[INC:%.*]], [[FOR_BODY]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[MUL:%.*]] = mul nuw nsw i32 [[I_023]], 1
; CHECK-NEXT:    [[ADD5:%.*]] = add nuw nsw i32 [[MUL]], 2
; CHECK-NEXT:    [[ARRAYIDX6:%.*]] = getelementptr inbounds i32, i32* [[DATA]], i32 [[ADD5]]
; CHECK-NEXT:    [[TMP11:%.*]] = load i32, i32* [[ARRAYIDX6]], align 4
; CHECK-NEXT:    [[ADD7:%.*]] = add nsw i32 5, [[TMP11]]
; CHECK-NEXT:    [[ARRAYIDX9:%.*]] = getelementptr inbounds i32, i32* [[DST]], i32 [[I_023]]
; CHECK-NEXT:    store i32 [[ADD7]], i32* [[ARRAYIDX9]], align 4
; CHECK-NEXT:    [[INC]] = add nuw nsw i32 [[I_023]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i32 [[INC]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[END]], label [[FOR_BODY]], [[LOOP2:!llvm.loop !.*]]
; CHECK:       end:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body
for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.023 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
  %mul = mul nuw nsw i32 %i.023, 1
  %add5 = add nuw nsw i32 %mul, 2
  %arrayidx6 = getelementptr inbounds i32, i32* %data, i32 %add5
  %0 = load i32, i32* %arrayidx6, align 4
  %add7 = add nsw i32 5, %0
  %arrayidx9 = getelementptr inbounds i32, i32* %dst, i32 %i.023
  store i32 %add7, i32* %arrayidx9, align 4
  %inc = add nuw nsw i32 %i.023, 1
  %exitcond.not = icmp eq i32 %inc, %n
  br i1 %exitcond.not, label %end, label %for.body
end:                                 ; preds = %end, %entry
  ret void
}

define void @test_stride-1_4i32(i32* readonly %data, i32* noalias nocapture %dst, i32 %n) {
; CHECK-LABEL: @test_stride-1_4i32(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i32 [[N:%.*]], 4
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_SCEVCHECK:%.*]]
; CHECK:       vector.scevcheck:
; CHECK-NEXT:    [[TMP0:%.*]] = add i32 [[N]], -1
; CHECK-NEXT:    [[MUL1:%.*]] = call { i32, i1 } @llvm.umul.with.overflow.i32(i32 1, i32 [[TMP0]])
; CHECK-NEXT:    [[MUL_RESULT:%.*]] = extractvalue { i32, i1 } [[MUL1]], 0
; CHECK-NEXT:    [[MUL_OVERFLOW:%.*]] = extractvalue { i32, i1 } [[MUL1]], 1
; CHECK-NEXT:    [[TMP1:%.*]] = add i32 2, [[MUL_RESULT]]
; CHECK-NEXT:    [[TMP2:%.*]] = sub i32 2, [[MUL_RESULT]]
; CHECK-NEXT:    [[TMP3:%.*]] = icmp sgt i32 [[TMP2]], 2
; CHECK-NEXT:    [[TMP4:%.*]] = icmp slt i32 [[TMP1]], 2
; CHECK-NEXT:    [[TMP5:%.*]] = select i1 true, i1 [[TMP3]], i1 [[TMP4]]
; CHECK-NEXT:    [[TMP6:%.*]] = or i1 [[TMP5]], [[MUL_OVERFLOW]]
; CHECK-NEXT:    [[TMP7:%.*]] = or i1 false, [[TMP6]]
; CHECK-NEXT:    br i1 [[TMP7]], label [[SCALAR_PH]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i32 [[N]], 4
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i32 [[N]], [[N_MOD_VF]]
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP8:%.*]] = add i32 [[INDEX]], 0
; CHECK-NEXT:    [[TMP9:%.*]] = mul nuw nsw i32 [[TMP8]], -1
; CHECK-NEXT:    [[TMP10:%.*]] = add nuw nsw i32 [[TMP9]], 2
; CHECK-NEXT:    [[TMP11:%.*]] = getelementptr inbounds i32, i32* [[DATA:%.*]], i32 [[TMP10]]
; CHECK-NEXT:    [[TMP12:%.*]] = getelementptr inbounds i32, i32* [[TMP11]], i32 0
; CHECK-NEXT:    [[TMP13:%.*]] = getelementptr inbounds i32, i32* [[TMP12]], i32 -3
; CHECK-NEXT:    [[TMP14:%.*]] = bitcast i32* [[TMP13]] to <4 x i32>*
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i32>, <4 x i32>* [[TMP14]], align 4
; CHECK-NEXT:    [[REVERSE:%.*]] = shufflevector <4 x i32> [[WIDE_LOAD]], <4 x i32> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:    [[TMP15:%.*]] = add nsw <4 x i32> <i32 5, i32 5, i32 5, i32 5>, [[REVERSE]]
; CHECK-NEXT:    [[TMP16:%.*]] = getelementptr inbounds i32, i32* [[DST:%.*]], i32 [[TMP8]]
; CHECK-NEXT:    [[TMP17:%.*]] = getelementptr inbounds i32, i32* [[TMP16]], i32 0
; CHECK-NEXT:    [[TMP18:%.*]] = bitcast i32* [[TMP17]] to <4 x i32>*
; CHECK-NEXT:    store <4 x i32> [[TMP15]], <4 x i32>* [[TMP18]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], 4
; CHECK-NEXT:    [[TMP19:%.*]] = icmp eq i32 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP19]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], [[LOOP4:!llvm.loop !.*]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i32 [[N]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[END:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ], [ 0, [[VECTOR_SCEVCHECK]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_023:%.*]] = phi i32 [ [[INC:%.*]], [[FOR_BODY]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[MUL:%.*]] = mul nuw nsw i32 [[I_023]], -1
; CHECK-NEXT:    [[ADD5:%.*]] = add nuw nsw i32 [[MUL]], 2
; CHECK-NEXT:    [[ARRAYIDX6:%.*]] = getelementptr inbounds i32, i32* [[DATA]], i32 [[ADD5]]
; CHECK-NEXT:    [[TMP20:%.*]] = load i32, i32* [[ARRAYIDX6]], align 4
; CHECK-NEXT:    [[ADD7:%.*]] = add nsw i32 5, [[TMP20]]
; CHECK-NEXT:    [[ARRAYIDX9:%.*]] = getelementptr inbounds i32, i32* [[DST]], i32 [[I_023]]
; CHECK-NEXT:    store i32 [[ADD7]], i32* [[ARRAYIDX9]], align 4
; CHECK-NEXT:    [[INC]] = add nuw nsw i32 [[I_023]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i32 [[INC]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[END]], label [[FOR_BODY]], [[LOOP5:!llvm.loop !.*]]
; CHECK:       end:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body
for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.023 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
  %mul = mul nuw nsw i32 %i.023, -1
  %add5 = add nuw nsw i32 %mul, 2
  %arrayidx6 = getelementptr inbounds i32, i32* %data, i32 %add5
  %0 = load i32, i32* %arrayidx6, align 4
  %add7 = add nsw i32 5, %0
  %arrayidx9 = getelementptr inbounds i32, i32* %dst, i32 %i.023
  store i32 %add7, i32* %arrayidx9, align 4
  %inc = add nuw nsw i32 %i.023, 1
  %exitcond.not = icmp eq i32 %inc, %n
  br i1 %exitcond.not, label %end, label %for.body
end:                                 ; preds = %end, %entry
  ret void
}

define void @test_stride2_4i32(i32* readonly %data, i32* noalias nocapture %dst, i32 %n) {
;
; CHECK-LABEL: @test_stride2_4i32(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ule i32 [[N:%.*]], 4
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i32 [[N]], 4
; CHECK-NEXT:    [[TMP0:%.*]] = icmp eq i32 [[N_MOD_VF]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = select i1 [[TMP0]], i32 4, i32 [[N_MOD_VF]]
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i32 [[N]], [[TMP1]]
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP2:%.*]] = add i32 [[INDEX]], 0
; CHECK-NEXT:    [[TMP3:%.*]] = mul nuw nsw i32 [[TMP2]], 2
; CHECK-NEXT:    [[TMP4:%.*]] = add nuw nsw i32 [[TMP3]], 2
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds i32, i32* [[DATA:%.*]], i32 [[TMP4]]
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds i32, i32* [[TMP5]], i32 0
; CHECK-NEXT:    [[TMP7:%.*]] = bitcast i32* [[TMP6]] to <8 x i32>*
; CHECK-NEXT:    [[WIDE_VEC:%.*]] = load <8 x i32>, <8 x i32>* [[TMP7]], align 4
; CHECK-NEXT:    [[STRIDED_VEC:%.*]] = shufflevector <8 x i32> [[WIDE_VEC]], <8 x i32> undef, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
; CHECK-NEXT:    [[TMP8:%.*]] = add nsw <4 x i32> <i32 5, i32 5, i32 5, i32 5>, [[STRIDED_VEC]]
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i32, i32* [[DST:%.*]], i32 [[TMP2]]
; CHECK-NEXT:    [[TMP10:%.*]] = getelementptr inbounds i32, i32* [[TMP9]], i32 0
; CHECK-NEXT:    [[TMP11:%.*]] = bitcast i32* [[TMP10]] to <4 x i32>*
; CHECK-NEXT:    store <4 x i32> [[TMP8]], <4 x i32>* [[TMP11]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], 4
; CHECK-NEXT:    [[TMP12:%.*]] = icmp eq i32 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP12]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], [[LOOP6:!llvm.loop !.*]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i32 [[N]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[END:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_023:%.*]] = phi i32 [ [[INC:%.*]], [[FOR_BODY]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[MUL:%.*]] = mul nuw nsw i32 [[I_023]], 2
; CHECK-NEXT:    [[ADD5:%.*]] = add nuw nsw i32 [[MUL]], 2
; CHECK-NEXT:    [[ARRAYIDX6:%.*]] = getelementptr inbounds i32, i32* [[DATA]], i32 [[ADD5]]
; CHECK-NEXT:    [[TMP13:%.*]] = load i32, i32* [[ARRAYIDX6]], align 4
; CHECK-NEXT:    [[ADD7:%.*]] = add nsw i32 5, [[TMP13]]
; CHECK-NEXT:    [[ARRAYIDX9:%.*]] = getelementptr inbounds i32, i32* [[DST]], i32 [[I_023]]
; CHECK-NEXT:    store i32 [[ADD7]], i32* [[ARRAYIDX9]], align 4
; CHECK-NEXT:    [[INC]] = add nuw nsw i32 [[I_023]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i32 [[INC]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[END]], label [[FOR_BODY]], [[LOOP7:!llvm.loop !.*]]
; CHECK:       end:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body
for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.023 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
  %mul = mul nuw nsw i32 %i.023, 2
  %add5 = add nuw nsw i32 %mul, 2
  %arrayidx6 = getelementptr inbounds i32, i32* %data, i32 %add5
  %0 = load i32, i32* %arrayidx6, align 4
  %add7 = add nsw i32 5, %0
  %arrayidx9 = getelementptr inbounds i32, i32* %dst, i32 %i.023
  store i32 %add7, i32* %arrayidx9, align 4
  %inc = add nuw nsw i32 %i.023, 1
  %exitcond.not = icmp eq i32 %inc, %n
  br i1 %exitcond.not, label %end, label %for.body
end:                                 ; preds = %end, %entry
  ret void
}

define void @test_stride3_4i32(i32* readonly %data, i32* noalias nocapture %dst, i32 %n) {
; CHECK-LABEL: @test_stride3_4i32(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_RND_UP:%.*]] = add i32 [[N:%.*]], 3
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i32 [[N_RND_UP]], 4
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i32 [[N_RND_UP]], [[N_MOD_VF]]
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_IND:%.*]] = phi <4 x i32> [ <i32 0, i32 1, i32 2, i32 3>, [[VECTOR_PH]] ], [ [[VEC_IND_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = add i32 [[INDEX]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = add i32 [[INDEX]], 1
; CHECK-NEXT:    [[TMP2:%.*]] = add i32 [[INDEX]], 2
; CHECK-NEXT:    [[TMP3:%.*]] = add i32 [[INDEX]], 3
; CHECK-NEXT:    [[TMP4:%.*]] = mul nuw nsw <4 x i32> [[VEC_IND]], <i32 3, i32 3, i32 3, i32 3>
; CHECK-NEXT:    [[TMP5:%.*]] = add nuw nsw <4 x i32> [[TMP4]], <i32 2, i32 2, i32 2, i32 2>
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds i32, i32* [[DATA:%.*]], <4 x i32> [[TMP5]]
; CHECK-NEXT:    [[ACTIVE_LANE_MASK:%.*]] = call <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32 [[TMP0]], i32 [[N]])
; CHECK-NEXT:    [[WIDE_MASKED_GATHER:%.*]] = call <4 x i32> @llvm.masked.gather.v4i32.v4p0i32(<4 x i32*> [[TMP6]], i32 4, <4 x i1> [[ACTIVE_LANE_MASK]], <4 x i32> undef)
; CHECK-NEXT:    [[TMP7:%.*]] = add nsw <4 x i32> <i32 5, i32 5, i32 5, i32 5>, [[WIDE_MASKED_GATHER]]
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds i32, i32* [[DST:%.*]], i32 [[TMP0]]
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i32, i32* [[TMP8]], i32 0
; CHECK-NEXT:    [[TMP10:%.*]] = bitcast i32* [[TMP9]] to <4 x i32>*
; CHECK-NEXT:    call void @llvm.masked.store.v4i32.p0v4i32(<4 x i32> [[TMP7]], <4 x i32>* [[TMP10]], i32 4, <4 x i1> [[ACTIVE_LANE_MASK]])
; CHECK-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], 4
; CHECK-NEXT:    [[VEC_IND_NEXT]] = add <4 x i32> [[VEC_IND]], <i32 4, i32 4, i32 4, i32 4>
; CHECK-NEXT:    [[TMP11:%.*]] = icmp eq i32 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP11]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], [[LOOP8:!llvm.loop !.*]]
; CHECK:       middle.block:
; CHECK-NEXT:    br i1 true, label [[END:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_023:%.*]] = phi i32 [ [[INC:%.*]], [[FOR_BODY]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[MUL:%.*]] = mul nuw nsw i32 [[I_023]], 3
; CHECK-NEXT:    [[ADD5:%.*]] = add nuw nsw i32 [[MUL]], 2
; CHECK-NEXT:    [[ARRAYIDX6:%.*]] = getelementptr inbounds i32, i32* [[DATA]], i32 [[ADD5]]
; CHECK-NEXT:    [[TMP12:%.*]] = load i32, i32* [[ARRAYIDX6]], align 4
; CHECK-NEXT:    [[ADD7:%.*]] = add nsw i32 5, [[TMP12]]
; CHECK-NEXT:    [[ARRAYIDX9:%.*]] = getelementptr inbounds i32, i32* [[DST]], i32 [[I_023]]
; CHECK-NEXT:    store i32 [[ADD7]], i32* [[ARRAYIDX9]], align 4
; CHECK-NEXT:    [[INC]] = add nuw nsw i32 [[I_023]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i32 [[INC]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[END]], label [[FOR_BODY]], [[LOOP9:!llvm.loop !.*]]
; CHECK:       end:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body
for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.023 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
  %mul = mul nuw nsw i32 %i.023, 3
  %add5 = add nuw nsw i32 %mul, 2
  %arrayidx6 = getelementptr inbounds i32, i32* %data, i32 %add5
  %0 = load i32, i32* %arrayidx6, align 4
  %add7 = add nsw i32 5, %0
  %arrayidx9 = getelementptr inbounds i32, i32* %dst, i32 %i.023
  store i32 %add7, i32* %arrayidx9, align 4
  %inc = add nuw nsw i32 %i.023, 1
  %exitcond.not = icmp eq i32 %inc, %n
  br i1 %exitcond.not, label %end, label %for.body
end:                                 ; preds = %end, %entry
  ret void
}

define void @test_stride4_4i32(i32* readonly %data, i32* noalias nocapture %dst, i32 %n) {
; CHECK-LABEL: @test_stride4_4i32(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_RND_UP:%.*]] = add i32 [[N:%.*]], 3
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i32 [[N_RND_UP]], 4
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i32 [[N_RND_UP]], [[N_MOD_VF]]
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_IND:%.*]] = phi <4 x i32> [ <i32 0, i32 1, i32 2, i32 3>, [[VECTOR_PH]] ], [ [[VEC_IND_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = add i32 [[INDEX]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = add i32 [[INDEX]], 1
; CHECK-NEXT:    [[TMP2:%.*]] = add i32 [[INDEX]], 2
; CHECK-NEXT:    [[TMP3:%.*]] = add i32 [[INDEX]], 3
; CHECK-NEXT:    [[TMP4:%.*]] = mul nuw nsw <4 x i32> [[VEC_IND]], <i32 4, i32 4, i32 4, i32 4>
; CHECK-NEXT:    [[TMP5:%.*]] = add nuw nsw <4 x i32> [[TMP4]], <i32 2, i32 2, i32 2, i32 2>
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds i32, i32* [[DATA:%.*]], <4 x i32> [[TMP5]]
; CHECK-NEXT:    [[ACTIVE_LANE_MASK:%.*]] = call <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32 [[TMP0]], i32 [[N]])
; CHECK-NEXT:    [[WIDE_MASKED_GATHER:%.*]] = call <4 x i32> @llvm.masked.gather.v4i32.v4p0i32(<4 x i32*> [[TMP6]], i32 4, <4 x i1> [[ACTIVE_LANE_MASK]], <4 x i32> undef)
; CHECK-NEXT:    [[TMP7:%.*]] = add nsw <4 x i32> <i32 5, i32 5, i32 5, i32 5>, [[WIDE_MASKED_GATHER]]
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds i32, i32* [[DST:%.*]], i32 [[TMP0]]
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i32, i32* [[TMP8]], i32 0
; CHECK-NEXT:    [[TMP10:%.*]] = bitcast i32* [[TMP9]] to <4 x i32>*
; CHECK-NEXT:    call void @llvm.masked.store.v4i32.p0v4i32(<4 x i32> [[TMP7]], <4 x i32>* [[TMP10]], i32 4, <4 x i1> [[ACTIVE_LANE_MASK]])
; CHECK-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], 4
; CHECK-NEXT:    [[VEC_IND_NEXT]] = add <4 x i32> [[VEC_IND]], <i32 4, i32 4, i32 4, i32 4>
; CHECK-NEXT:    [[TMP11:%.*]] = icmp eq i32 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP11]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], [[LOOP10:!llvm.loop !.*]]
; CHECK:       middle.block:
; CHECK-NEXT:    br i1 true, label [[END:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_023:%.*]] = phi i32 [ [[INC:%.*]], [[FOR_BODY]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[MUL:%.*]] = mul nuw nsw i32 [[I_023]], 4
; CHECK-NEXT:    [[ADD5:%.*]] = add nuw nsw i32 [[MUL]], 2
; CHECK-NEXT:    [[ARRAYIDX6:%.*]] = getelementptr inbounds i32, i32* [[DATA]], i32 [[ADD5]]
; CHECK-NEXT:    [[TMP12:%.*]] = load i32, i32* [[ARRAYIDX6]], align 4
; CHECK-NEXT:    [[ADD7:%.*]] = add nsw i32 5, [[TMP12]]
; CHECK-NEXT:    [[ARRAYIDX9:%.*]] = getelementptr inbounds i32, i32* [[DST]], i32 [[I_023]]
; CHECK-NEXT:    store i32 [[ADD7]], i32* [[ARRAYIDX9]], align 4
; CHECK-NEXT:    [[INC]] = add nuw nsw i32 [[I_023]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i32 [[INC]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[END]], label [[FOR_BODY]], [[LOOP11:!llvm.loop !.*]]
; CHECK:       end:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body
for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.023 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
  %mul = mul nuw nsw i32 %i.023, 4
  %add5 = add nuw nsw i32 %mul, 2
  %arrayidx6 = getelementptr inbounds i32, i32* %data, i32 %add5
  %0 = load i32, i32* %arrayidx6, align 4
  %add7 = add nsw i32 5, %0
  %arrayidx9 = getelementptr inbounds i32, i32* %dst, i32 %i.023
  store i32 %add7, i32* %arrayidx9, align 4
  %inc = add nuw nsw i32 %i.023, 1
  %exitcond.not = icmp eq i32 %inc, %n
  br i1 %exitcond.not, label %end, label %for.body
end:                                 ; preds = %end, %entry
  ret void
}

define void @test_stride_loopinvar_4i32(i32* readonly %data, i32* noalias nocapture %dst, i32 %n, i32 %stride) {
; CHECK-LABEL: @test_stride_loopinvar_4i32(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_SCEVCHECK:%.*]]
; CHECK:       vector.scevcheck:
; CHECK-NEXT:    [[IDENT_CHECK:%.*]] = icmp ne i32 [[STRIDE:%.*]], 1
; CHECK-NEXT:    [[TMP0:%.*]] = or i1 false, [[IDENT_CHECK]]
; CHECK-NEXT:    br i1 [[TMP0]], label [[SCALAR_PH]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_RND_UP:%.*]] = add i32 [[N:%.*]], 3
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i32 [[N_RND_UP]], 4
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i32 [[N_RND_UP]], [[N_MOD_VF]]
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <4 x i32> undef, i32 [[INDEX]], i32 0
; CHECK-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <4 x i32> [[BROADCAST_SPLATINSERT]], <4 x i32> undef, <4 x i32> zeroinitializer
; CHECK-NEXT:    [[INDUCTION:%.*]] = add <4 x i32> [[BROADCAST_SPLAT]], <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[TMP1:%.*]] = add i32 [[INDEX]], 0
; CHECK-NEXT:    [[TMP2:%.*]] = mul nuw nsw i32 [[TMP1]], [[STRIDE]]
; CHECK-NEXT:    [[TMP3:%.*]] = add nuw nsw i32 [[TMP2]], 2
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i32, i32* [[DATA:%.*]], i32 [[TMP3]]
; CHECK-NEXT:    [[ACTIVE_LANE_MASK:%.*]] = call <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32 [[TMP1]], i32 [[N]])
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds i32, i32* [[TMP4]], i32 0
; CHECK-NEXT:    [[TMP6:%.*]] = bitcast i32* [[TMP5]] to <4 x i32>*
; CHECK-NEXT:    [[WIDE_MASKED_LOAD:%.*]] = call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* [[TMP6]], i32 4, <4 x i1> [[ACTIVE_LANE_MASK]], <4 x i32> undef)
; CHECK-NEXT:    [[TMP7:%.*]] = add nsw <4 x i32> <i32 5, i32 5, i32 5, i32 5>, [[WIDE_MASKED_LOAD]]
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds i32, i32* [[DST:%.*]], i32 [[TMP1]]
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i32, i32* [[TMP8]], i32 0
; CHECK-NEXT:    [[TMP10:%.*]] = bitcast i32* [[TMP9]] to <4 x i32>*
; CHECK-NEXT:    call void @llvm.masked.store.v4i32.p0v4i32(<4 x i32> [[TMP7]], <4 x i32>* [[TMP10]], i32 4, <4 x i1> [[ACTIVE_LANE_MASK]])
; CHECK-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], 4
; CHECK-NEXT:    [[TMP11:%.*]] = icmp eq i32 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP11]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], [[LOOP12:!llvm.loop !.*]]
; CHECK:       middle.block:
; CHECK-NEXT:    br i1 true, label [[END:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ], [ 0, [[VECTOR_SCEVCHECK]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_023:%.*]] = phi i32 [ [[INC:%.*]], [[FOR_BODY]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[MUL:%.*]] = mul nuw nsw i32 [[I_023]], [[STRIDE]]
; CHECK-NEXT:    [[ADD5:%.*]] = add nuw nsw i32 [[MUL]], 2
; CHECK-NEXT:    [[ARRAYIDX6:%.*]] = getelementptr inbounds i32, i32* [[DATA]], i32 [[ADD5]]
; CHECK-NEXT:    [[TMP12:%.*]] = load i32, i32* [[ARRAYIDX6]], align 4
; CHECK-NEXT:    [[ADD7:%.*]] = add nsw i32 5, [[TMP12]]
; CHECK-NEXT:    [[ARRAYIDX9:%.*]] = getelementptr inbounds i32, i32* [[DST]], i32 [[I_023]]
; CHECK-NEXT:    store i32 [[ADD7]], i32* [[ARRAYIDX9]], align 4
; CHECK-NEXT:    [[INC]] = add nuw nsw i32 [[I_023]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i32 [[INC]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[END]], label [[FOR_BODY]], [[LOOP13:!llvm.loop !.*]]
; CHECK:       end:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body
for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.023 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
  %mul = mul nuw nsw i32 %i.023, %stride
  %add5 = add nuw nsw i32 %mul, 2
  %arrayidx6 = getelementptr inbounds i32, i32* %data, i32 %add5
  %0 = load i32, i32* %arrayidx6, align 4
  %add7 = add nsw i32 5, %0
  %arrayidx9 = getelementptr inbounds i32, i32* %dst, i32 %i.023
  store i32 %add7, i32* %arrayidx9, align 4
  %inc = add nuw nsw i32 %i.023, 1
  %exitcond.not = icmp eq i32 %inc, %n
  br i1 %exitcond.not, label %end, label %for.body
end:                                 ; preds = %end, %entry
  ret void
}

define void @test_stride_noninvar_4i32(i32* readonly %data, i32* noalias nocapture %dst, i32 %n) {
; CHECK-LABEL: @test_stride_noninvar_4i32(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i32 [[N:%.*]], 4
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i32 [[N]], 4
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i32 [[N]], [[N_MOD_VF]]
; CHECK-NEXT:    [[TMP0:%.*]] = mul i32 [[N_VEC]], 8
; CHECK-NEXT:    [[IND_END:%.*]] = add i32 3, [[TMP0]]
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_IND:%.*]] = phi <4 x i32> [ <i32 0, i32 1, i32 2, i32 3>, [[VECTOR_PH]] ], [ [[VEC_IND_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_IND2:%.*]] = phi <4 x i32> [ <i32 3, i32 11, i32 19, i32 27>, [[VECTOR_PH]] ], [ [[VEC_IND_NEXT3:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP1:%.*]] = add i32 [[INDEX]], 0
; CHECK-NEXT:    [[TMP2:%.*]] = add i32 [[INDEX]], 1
; CHECK-NEXT:    [[TMP3:%.*]] = add i32 [[INDEX]], 2
; CHECK-NEXT:    [[TMP4:%.*]] = add i32 [[INDEX]], 3
; CHECK-NEXT:    [[TMP5:%.*]] = mul nuw nsw <4 x i32> [[VEC_IND]], [[VEC_IND2]]
; CHECK-NEXT:    [[TMP6:%.*]] = add nuw nsw <4 x i32> [[TMP5]], <i32 2, i32 2, i32 2, i32 2>
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds i32, i32* [[DATA:%.*]], <4 x i32> [[TMP6]]
; CHECK-NEXT:    [[WIDE_MASKED_GATHER:%.*]] = call <4 x i32> @llvm.masked.gather.v4i32.v4p0i32(<4 x i32*> [[TMP7]], i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x i32> undef)
; CHECK-NEXT:    [[TMP8:%.*]] = add nsw <4 x i32> <i32 5, i32 5, i32 5, i32 5>, [[WIDE_MASKED_GATHER]]
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i32, i32* [[DST:%.*]], i32 [[TMP1]]
; CHECK-NEXT:    [[TMP10:%.*]] = getelementptr inbounds i32, i32* [[TMP9]], i32 0
; CHECK-NEXT:    [[TMP11:%.*]] = bitcast i32* [[TMP10]] to <4 x i32>*
; CHECK-NEXT:    store <4 x i32> [[TMP8]], <4 x i32>* [[TMP11]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], 4
; CHECK-NEXT:    [[VEC_IND_NEXT]] = add <4 x i32> [[VEC_IND]], <i32 4, i32 4, i32 4, i32 4>
; CHECK-NEXT:    [[VEC_IND_NEXT3]] = add <4 x i32> [[VEC_IND2]], <i32 32, i32 32, i32 32, i32 32>
; CHECK-NEXT:    [[TMP12:%.*]] = icmp eq i32 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP12]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], [[LOOP14:!llvm.loop !.*]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i32 [[N]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[END:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[BC_RESUME_VAL1:%.*]] = phi i32 [ [[IND_END]], [[MIDDLE_BLOCK]] ], [ 3, [[ENTRY]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_023:%.*]] = phi i32 [ [[INC:%.*]], [[FOR_BODY]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[STRIDE:%.*]] = phi i32 [ [[NEXT_STRIDE:%.*]], [[FOR_BODY]] ], [ [[BC_RESUME_VAL1]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[MUL:%.*]] = mul nuw nsw i32 [[I_023]], [[STRIDE]]
; CHECK-NEXT:    [[ADD5:%.*]] = add nuw nsw i32 [[MUL]], 2
; CHECK-NEXT:    [[ARRAYIDX6:%.*]] = getelementptr inbounds i32, i32* [[DATA]], i32 [[ADD5]]
; CHECK-NEXT:    [[TMP13:%.*]] = load i32, i32* [[ARRAYIDX6]], align 4
; CHECK-NEXT:    [[ADD7:%.*]] = add nsw i32 5, [[TMP13]]
; CHECK-NEXT:    [[ARRAYIDX9:%.*]] = getelementptr inbounds i32, i32* [[DST]], i32 [[I_023]]
; CHECK-NEXT:    store i32 [[ADD7]], i32* [[ARRAYIDX9]], align 4
; CHECK-NEXT:    [[INC]] = add nuw nsw i32 [[I_023]], 1
; CHECK-NEXT:    [[NEXT_STRIDE]] = add nuw nsw i32 [[STRIDE]], 8
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i32 [[INC]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[END]], label [[FOR_BODY]], [[LOOP15:!llvm.loop !.*]]
; CHECK:       end:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body
for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.023 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
  %stride = phi i32 [ %next.stride, %for.body ], [ 3, %entry ]
  %mul = mul nuw nsw i32 %i.023, %stride
  %add5 = add nuw nsw i32 %mul, 2
  %arrayidx6 = getelementptr inbounds i32, i32* %data, i32 %add5
  %0 = load i32, i32* %arrayidx6, align 4
  %add7 = add nsw i32 5, %0
  %arrayidx9 = getelementptr inbounds i32, i32* %dst, i32 %i.023
  store i32 %add7, i32* %arrayidx9, align 4
  %inc = add nuw nsw i32 %i.023, 1
  %next.stride = add nuw nsw i32 %stride, 8
  %exitcond.not = icmp eq i32 %inc, %n
  br i1 %exitcond.not, label %end, label %for.body
end:                                 ; preds = %end, %entry
  ret void
}

define void @test_stride_noninvar2_4i32(i32* readonly %data, i32* noalias nocapture %dst, i32 %n) {
; CHECK-LABEL: @test_stride_noninvar2_4i32(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_023:%.*]] = phi i32 [ [[INC:%.*]], [[FOR_BODY]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[STRIDE:%.*]] = phi i32 [ [[NEXT_STRIDE:%.*]], [[FOR_BODY]] ], [ 3, [[ENTRY]] ]
; CHECK-NEXT:    [[MUL:%.*]] = mul nuw nsw i32 [[I_023]], [[STRIDE]]
; CHECK-NEXT:    [[ADD5:%.*]] = add nuw nsw i32 [[MUL]], 2
; CHECK-NEXT:    [[ARRAYIDX6:%.*]] = getelementptr inbounds i32, i32* [[DATA:%.*]], i32 [[ADD5]]
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, i32* [[ARRAYIDX6]], align 4
; CHECK-NEXT:    [[ADD7:%.*]] = add nsw i32 5, [[TMP0]]
; CHECK-NEXT:    [[ARRAYIDX9:%.*]] = getelementptr inbounds i32, i32* [[DST:%.*]], i32 [[I_023]]
; CHECK-NEXT:    store i32 [[ADD7]], i32* [[ARRAYIDX9]], align 4
; CHECK-NEXT:    [[INC]] = add nuw nsw i32 [[I_023]], 1
; CHECK-NEXT:    [[NEXT_STRIDE]] = mul nuw nsw i32 [[STRIDE]], 8
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i32 [[INC]], [[N:%.*]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[END:%.*]], label [[FOR_BODY]]
; CHECK:       end:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body
for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.023 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
  %stride = phi i32 [ %next.stride, %for.body ], [ 3, %entry ]
  %mul = mul nuw nsw i32 %i.023, %stride
  %add5 = add nuw nsw i32 %mul, 2
  %arrayidx6 = getelementptr inbounds i32, i32* %data, i32 %add5
  %0 = load i32, i32* %arrayidx6, align 4
  %add7 = add nsw i32 5, %0
  %arrayidx9 = getelementptr inbounds i32, i32* %dst, i32 %i.023
  store i32 %add7, i32* %arrayidx9, align 4
  %inc = add nuw nsw i32 %i.023, 1
  %next.stride = mul nuw nsw i32 %stride, 8
  %exitcond.not = icmp eq i32 %inc, %n
  br i1 %exitcond.not, label %end, label %for.body
end:                                 ; preds = %end, %entry
  ret void
}

define void @test_stride_noninvar3_4i32(i32* readonly %data, i32* noalias nocapture %dst, i32 %n, i32 %x) {
; CHECK-LABEL: @test_stride_noninvar3_4i32(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i32 [[N:%.*]], 4
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i32 [[N]], 4
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i32 [[N]], [[N_MOD_VF]]
; CHECK-NEXT:    [[TMP0:%.*]] = mul i32 [[N_VEC]], [[X:%.*]]
; CHECK-NEXT:    [[IND_END:%.*]] = add i32 3, [[TMP0]]
; CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <4 x i32> undef, i32 [[X]], i32 0
; CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <4 x i32> [[DOTSPLATINSERT]], <4 x i32> undef, <4 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP1:%.*]] = mul <4 x i32> <i32 0, i32 1, i32 2, i32 3>, [[DOTSPLAT]]
; CHECK-NEXT:    [[INDUCTION:%.*]] = add <4 x i32> <i32 3, i32 3, i32 3, i32 3>, [[TMP1]]
; CHECK-NEXT:    [[TMP2:%.*]] = mul i32 [[X]], 4
; CHECK-NEXT:    [[DOTSPLATINSERT2:%.*]] = insertelement <4 x i32> undef, i32 [[TMP2]], i32 0
; CHECK-NEXT:    [[DOTSPLAT3:%.*]] = shufflevector <4 x i32> [[DOTSPLATINSERT2]], <4 x i32> undef, <4 x i32> zeroinitializer
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_IND:%.*]] = phi <4 x i32> [ <i32 0, i32 1, i32 2, i32 3>, [[VECTOR_PH]] ], [ [[VEC_IND_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_IND4:%.*]] = phi <4 x i32> [ [[INDUCTION]], [[VECTOR_PH]] ], [ [[VEC_IND_NEXT5:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP3:%.*]] = add i32 [[INDEX]], 0
; CHECK-NEXT:    [[TMP4:%.*]] = add i32 [[INDEX]], 1
; CHECK-NEXT:    [[TMP5:%.*]] = add i32 [[INDEX]], 2
; CHECK-NEXT:    [[TMP6:%.*]] = add i32 [[INDEX]], 3
; CHECK-NEXT:    [[TMP7:%.*]] = mul nuw nsw <4 x i32> [[VEC_IND]], [[VEC_IND4]]
; CHECK-NEXT:    [[TMP8:%.*]] = add nuw nsw <4 x i32> [[TMP7]], <i32 2, i32 2, i32 2, i32 2>
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i32, i32* [[DATA:%.*]], <4 x i32> [[TMP8]]
; CHECK-NEXT:    [[WIDE_MASKED_GATHER:%.*]] = call <4 x i32> @llvm.masked.gather.v4i32.v4p0i32(<4 x i32*> [[TMP9]], i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x i32> undef)
; CHECK-NEXT:    [[TMP10:%.*]] = add nsw <4 x i32> <i32 5, i32 5, i32 5, i32 5>, [[WIDE_MASKED_GATHER]]
; CHECK-NEXT:    [[TMP11:%.*]] = getelementptr inbounds i32, i32* [[DST:%.*]], i32 [[TMP3]]
; CHECK-NEXT:    [[TMP12:%.*]] = getelementptr inbounds i32, i32* [[TMP11]], i32 0
; CHECK-NEXT:    [[TMP13:%.*]] = bitcast i32* [[TMP12]] to <4 x i32>*
; CHECK-NEXT:    store <4 x i32> [[TMP10]], <4 x i32>* [[TMP13]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], 4
; CHECK-NEXT:    [[VEC_IND_NEXT]] = add <4 x i32> [[VEC_IND]], <i32 4, i32 4, i32 4, i32 4>
; CHECK-NEXT:    [[VEC_IND_NEXT5]] = add <4 x i32> [[VEC_IND4]], [[DOTSPLAT3]]
; CHECK-NEXT:    [[TMP14:%.*]] = icmp eq i32 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP14]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], [[LOOP16:!llvm.loop !.*]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i32 [[N]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[END:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[BC_RESUME_VAL1:%.*]] = phi i32 [ [[IND_END]], [[MIDDLE_BLOCK]] ], [ 3, [[ENTRY]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_023:%.*]] = phi i32 [ [[INC:%.*]], [[FOR_BODY]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[STRIDE:%.*]] = phi i32 [ [[NEXT_STRIDE:%.*]], [[FOR_BODY]] ], [ [[BC_RESUME_VAL1]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[MUL:%.*]] = mul nuw nsw i32 [[I_023]], [[STRIDE]]
; CHECK-NEXT:    [[ADD5:%.*]] = add nuw nsw i32 [[MUL]], 2
; CHECK-NEXT:    [[ARRAYIDX6:%.*]] = getelementptr inbounds i32, i32* [[DATA]], i32 [[ADD5]]
; CHECK-NEXT:    [[TMP15:%.*]] = load i32, i32* [[ARRAYIDX6]], align 4
; CHECK-NEXT:    [[ADD7:%.*]] = add nsw i32 5, [[TMP15]]
; CHECK-NEXT:    [[ARRAYIDX9:%.*]] = getelementptr inbounds i32, i32* [[DST]], i32 [[I_023]]
; CHECK-NEXT:    store i32 [[ADD7]], i32* [[ARRAYIDX9]], align 4
; CHECK-NEXT:    [[INC]] = add nuw nsw i32 [[I_023]], 1
; CHECK-NEXT:    [[NEXT_STRIDE]] = add nuw nsw i32 [[STRIDE]], [[X]]
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i32 [[INC]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[END]], label [[FOR_BODY]], [[LOOP17:!llvm.loop !.*]]
; CHECK:       end:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body
for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.023 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
  %stride = phi i32 [ %next.stride, %for.body ], [ 3, %entry ]
  %mul = mul nuw nsw i32 %i.023, %stride
  %add5 = add nuw nsw i32 %mul, 2
  %arrayidx6 = getelementptr inbounds i32, i32* %data, i32 %add5
  %0 = load i32, i32* %arrayidx6, align 4
  %add7 = add nsw i32 5, %0
  %arrayidx9 = getelementptr inbounds i32, i32* %dst, i32 %i.023
  store i32 %add7, i32* %arrayidx9, align 4
  %inc = add nuw nsw i32 %i.023, 1
  %next.stride = add nuw nsw i32 %stride, %x
  %exitcond.not = icmp eq i32 %inc, %n
  br i1 %exitcond.not, label %end, label %for.body
end:                                 ; preds = %end, %entry
  ret void
}

declare i32 @llvm.experimental.vector.reduce.add.v4i32(<4 x i32>)
declare <4 x i32> @llvm.masked.gather.v4i32.v4p0i32(<4 x i32*>, i32, <4 x i1>, <4 x i32>)
declare <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32, i32)
declare <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>*, i32, <4 x i1>, <4 x i32>)
declare void @llvm.masked.scatter.v4i32.v4p0i32(<4 x i32>, <4 x i32*>, i32, <4 x i1>)
