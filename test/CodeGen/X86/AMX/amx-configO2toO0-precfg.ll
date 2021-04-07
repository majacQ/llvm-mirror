; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: opt < %s -mtriple=x86_64-unknown-unknown -mattr=+amx-int8 -mattr=+avx512f -pre-amx-config -S | FileCheck %s

@buf = dso_local global [1024 x i8] zeroinitializer, align 16
@buf2 = dso_local global [1024 x i8] zeroinitializer, align 16

; Function Attrs: nounwind uwtable
define dso_local void @test_api(i32 %cond, i16 signext %row, i16 signext %col) local_unnamed_addr {
; CHECK-LABEL:  entry:
; CHECK:        %{{[0-9]+}} = alloca <16 x i32>, align 4
; CHECK-NEXT:   %{{[0-9]+}} = alloca <16 x i32>, align 4
; CHECK-NEXT:   %{{[0-9]+}} = alloca <16 x i32>, align 4
; CHECK-NEXT:   %{{[0-9]+}} = alloca <16 x i32>, align 4
; CHECK-NEXT:   %{{[0-9]+}} = alloca <16 x i32>, align 4
; CHECK-NEXT:   %{{[0-9]+}} = alloca <16 x i32>, align 4
; CHECK-NEXT:   %{{[0-9]+}} = alloca <16 x i32>, align 4
; CHECK-NEXT:   %{{[0-9]+}} = alloca <16 x i32>, align 4
; CHECK-NEXT:   %{{[0-9]+}} = alloca <256 x i32>, align 1024
; CHECK-NEXT:   %{{[0-9]+}} = bitcast <256 x i32>* %{{[0-9]+}} to i8*
; CHECK-NEXT:   %{{[0-9]+}} = alloca <256 x i32>, align 1024
; CHECK-NEXT:   %{{[0-9]+}} = bitcast <256 x i32>* %{{[0-9]+}} to i8*
; CHECK-NEXT:   %{{[0-9]+}} = alloca <256 x i32>, align 1024
; CHECK-NEXT:   %{{[0-9]+}} = bitcast <256 x i32>* %{{[0-9]+}} to i8*
; CHECK-NEXT:   %{{[0-9]+}} = alloca <256 x i32>, align 1024
; CHECK-NEXT:   %{{[0-9]+}} = bitcast <256 x i32>* %{{[0-9]+}} to i8*
; CHECK-NEXT:   %tobool.not = icmp eq i32 %cond, 0
; CHECK-NEXT:   br i1 %tobool.not, label %if.else, label %if.then
; CHECK:     if.then:                                          ; preds = %entry
; CHECK-NEXT:   %{{[0-9]+}} = bitcast <16 x i32>* %{{[0-9]+}} to i8*
; CHECK-NEXT:   store <16 x i32> zeroinitializer, <16 x i32>* %{{[0-9]+}}, align 4
; CHECK-NEXT:   %{{[0-9]+}} = getelementptr i8, i8* %{{[0-9]+}}, i64 0
; CHECK-NEXT:   store volatile i8 1, i8* %{{[0-9]+}}, align 1
; CHECK-NEXT:   %amx.tmm.0.shape.row{{.*}} = getelementptr i8, i8* %{{[0-9]+}}, i64 48
; CHECK-NEXT:   %{{[0-9]+}} = getelementptr i8, i8* %{{[0-9]+}}, i64 16
; CHECK-NEXT:   %amx.tmm.0.shape.col{{.*}} = bitcast i8* %{{[0-9]+}} to i16*
; CHECK-NEXT:   %{{[0-9]+}} = trunc i16 %row to i8
; CHECK-NEXT:   store volatile i8 %{{[0-9]+}}, i8* %amx.tmm.0.shape.row{{.*}}, align 1
; CHECK-NEXT:   store volatile i16 8, i16* %amx.tmm.0.shape.col{{.*}}, align 2
; CHECK-NEXT:   call void @llvm.x86.ldtilecfg(i8* %{{[0-9]+}})
; CHECK-NEXT:   %{{[0-9]+}} = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 %row, i16 8, i8* getelementptr inbounds ([1024 x i8], [1024 x i8]* @buf, i64 0, i64 0), i64 32)
; CHECK-NEXT:   call void @llvm.x86.tilestored64.internal(i16 %row, i16 8, i8* %{{[0-9]+}}, i64 64, x86_amx %{{[0-9]+}})
; CHECK-NEXT:   %{{[0-9]+}} = bitcast <16 x i32>* %{{[0-9]+}} to i8*
; CHECK-NEXT:   store <16 x i32> zeroinitializer, <16 x i32>* %{{[0-9]+}}, align 4
; CHECK-NEXT:   %{{[0-9]+}} = getelementptr i8, i8* %{{[0-9]+}}, i64 0
; CHECK-NEXT:   store volatile i8 1, i8* %{{[0-9]+}}, align 1
; CHECK-NEXT:   %amx.tmm.0.shape.row{{.*}} = getelementptr i8, i8* %{{[0-9]+}}, i64 48
; CHECK-NEXT:   %{{[0-9]+}} = getelementptr i8, i8* %{{[0-9]+}}, i64 16
; CHECK-NEXT:   %amx.tmm.0.shape.col{{.*}} = bitcast i8* %{{[0-9]+}} to i16*
; CHECK-NEXT:   %{{[0-9]+}} = trunc i16 8 to i8
; CHECK-NEXT:   store volatile i8 %{{[0-9]+}}, i8* %amx.tmm.0.shape.row{{.*}}, align 1
; CHECK-NEXT:   store volatile i16 %col, i16* %amx.tmm.0.shape.col{{.*}}, align 2
; CHECK-NEXT:   call void @llvm.x86.ldtilecfg(i8* %{{[0-9]+}})
; CHECK-NEXT:   %{{[0-9]+}} = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 8, i16 %col, i8* getelementptr inbounds ([1024 x i8], [1024 x i8]* @buf, i64 0, i64 0), i64 32)
; CHECK-NEXT:   call void @llvm.x86.tilestored64.internal(i16 8, i16 %col, i8* %{{[0-9]+}}, i64 64, x86_amx %{{[0-9]+}})
; CHECK-NEXT:   %{{[0-9]+}} = bitcast <16 x i32>* %{{[0-9]+}} to i8*
; CHECK-NEXT:   store <16 x i32> zeroinitializer, <16 x i32>* %{{[0-9]+}}, align 4
; CHECK-NEXT:   %{{[0-9]+}} = getelementptr i8, i8* %{{[0-9]+}}, i64 0
; CHECK-NEXT:   store volatile i8 1, i8* %{{[0-9]+}}, align 1
; CHECK-NEXT:   %amx.tmm.0.shape.row{{.*}} = getelementptr i8, i8* %{{[0-9]+}}, i64 48
; CHECK-NEXT:   %{{[0-9]+}} = getelementptr i8, i8* %{{[0-9]+}}, i64 16
; CHECK-NEXT:   %amx.tmm.0.shape.col{{.*}} = bitcast i8* %{{[0-9]+}} to i16*
; CHECK-NEXT:   %{{[0-9]+}} = trunc i16 %row to i8
; CHECK-NEXT:   store volatile i8 %{{[0-9]+}}, i8* %amx.tmm.0.shape.row{{.*}}, align 1
; CHECK-NEXT:   store volatile i16 %col, i16* %amx.tmm.0.shape.col{{.*}}, align 2
; CHECK-NEXT:   call void @llvm.x86.ldtilecfg(i8* %{{[0-9]+}})
; CHECK-NEXT:   %{{[0-9]+}} = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 %row, i16 %col, i8* getelementptr inbounds ([1024 x i8], [1024 x i8]* @buf, i64 0, i64 0), i64 32)
; CHECK-NEXT:   call void @llvm.x86.tilestored64.internal(i16 %row, i16 %col, i8* %{{[0-9]+}}, i64 64, x86_amx %{{[0-9]+}})
; CHECK-NEXT:   br label %if.end
; CHECK:   if.else:
; CHECK-NEXT:   %{{[0-9]+}} = bitcast <16 x i32>* %{{[0-9]+}} to i8*
; CHECK-NEXT:   store <16 x i32> zeroinitializer, <16 x i32>* %{{[0-9]+}}, align 4
; CHECK-NEXT:   %{{[0-9]+}} = getelementptr i8, i8* %{{[0-9]+}}, i64 0
; CHECK-NEXT:   store volatile i8 1, i8* %{{[0-9]+}}, align 1
; CHECK-NEXT:   %amx.tmm.0.shape.row{{.*}} = getelementptr i8, i8* %{{[0-9]+}}, i64 48
; CHECK-NEXT:   %{{[0-9]+}} = getelementptr i8, i8* %{{[0-9]+}}, i64 16
; CHECK-NEXT:   %amx.tmm.0.shape.col{{.*}} = bitcast i8* %{{[0-9]+}} to i16*
; CHECK-NEXT:   %{{[0-9]+}} = trunc i16 %row to i8
; CHECK-NEXT:   store volatile i8 %{{[0-9]+}}, i8* %amx.tmm.0.shape.row{{.*}}, align 1
; CHECK-NEXT:   store volatile i16 8, i16* %amx.tmm.0.shape.col{{.*}}, align 2
; CHECK-NEXT:   call void @llvm.x86.ldtilecfg(i8* %{{[0-9]+}})
; CHECK-NEXT:   %{{[0-9]+}} = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 %row, i16 8, i8* getelementptr inbounds ([1024 x i8], [1024 x i8]* @buf2, i64 0, i64 0), i64 32)
; CHECK-NEXT:   call void @llvm.x86.tilestored64.internal(i16 %row, i16 8, i8* %{{[0-9]+}}, i64 64, x86_amx %{{[0-9]+}})
; CHECK-NEXT:   %{{[0-9]+}} = bitcast <16 x i32>* %{{[0-9]+}} to i8*
; CHECK-NEXT:   store <16 x i32> zeroinitializer, <16 x i32>* %{{[0-9]+}}, align 4
; CHECK-NEXT:   %{{[0-9]+}} = getelementptr i8, i8* %{{[0-9]+}}, i64 0
; CHECK-NEXT:   store volatile i8 1, i8* %{{[0-9]+}}, align 1
; CHECK-NEXT:   %amx.tmm.0.shape.row{{.*}} = getelementptr i8, i8* %{{[0-9]+}}, i64 48
; CHECK-NEXT:   %{{[0-9]+}} = getelementptr i8, i8* %{{[0-9]+}}, i64 16
; CHECK-NEXT:   %amx.tmm.0.shape.col{{.*}} = bitcast i8* %{{[0-9]+}} to i16*
; CHECK-NEXT:   %{{[0-9]+}} = trunc i16 8 to i8
; CHECK-NEXT:   store volatile i8 %{{[0-9]+}}, i8* %amx.tmm.0.shape.row{{.*}}, align 1
; CHECK-NEXT:   store volatile i16 %col, i16* %amx.tmm.0.shape.col{{.*}}, align 2
; CHECK-NEXT:   call void @llvm.x86.ldtilecfg(i8* %{{[0-9]+}})
; CHECK-NEXT:   %{{[0-9]+}} = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 8, i16 %col, i8* getelementptr inbounds ([1024 x i8], [1024 x i8]* @buf2, i64 0, i64 0), i64 32)
; CHECK-NEXT:   call void @llvm.x86.tilestored64.internal(i16 8, i16 %col, i8* %{{[0-9]+}}, i64 64, x86_amx %{{[0-9]+}})
; CHECK-NEXT:   %{{[0-9]+}} = bitcast <16 x i32>* %{{[0-9]+}} to i8*
; CHECK-NEXT:   store <16 x i32> zeroinitializer, <16 x i32>* %{{[0-9]+}}, align 4
; CHECK-NEXT:   %{{[0-9]+}} = getelementptr i8, i8* %{{[0-9]+}}, i64 0
; CHECK-NEXT:   store volatile i8 1, i8* %{{[0-9]+}}, align 1
; CHECK-NEXT:   %amx.tmm.0.shape.row{{.*}} = getelementptr i8, i8* %{{[0-9]+}}, i64 48
; CHECK-NEXT:   %{{[0-9]+}} = getelementptr i8, i8* %{{[0-9]+}}, i64 16
; CHECK-NEXT:   %amx.tmm.0.shape.col{{.*}} = bitcast i8* %{{[0-9]+}} to i16*
; CHECK-NEXT:   %{{[0-9]+}} = trunc i16 %row to i8
; CHECK-NEXT:   store volatile i8 %{{[0-9]+}}, i8* %amx.tmm.0.shape.row{{.*}}, align 1
; CHECK-NEXT:   store volatile i16 %col, i16* %amx.tmm.0.shape.col{{.*}}, align 2
; CHECK-NEXT:   call void @llvm.x86.ldtilecfg(i8* %{{[0-9]+}})
; CHECK-NEXT:   %{{[0-9]+}} = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 %row, i16 %col, i8* getelementptr inbounds ([1024 x i8], [1024 x i8]* @buf2, i64 0, i64 0), i64 32)
; CHECK-NEXT:   call void @llvm.x86.tilestored64.internal(i16 %row, i16 %col, i8* %{{[0-9]+}}, i64 64, x86_amx %{{[0-9]+}})
; CHECK-NEXT:   br label %if.end
; CHECK:   if.end:                                           ; preds = %if.else, %if.then
; CHECK-NEXT:   %{{[0-9]+}} = bitcast <16 x i32>* %{{[0-9]+}} to i8*
; CHECK-NEXT:   store <16 x i32> zeroinitializer, <16 x i32>* %{{[0-9]+}}, align 4
; CHECK-NEXT:   %{{[0-9]+}} = getelementptr i8, i8* %{{[0-9]+}}, i64 0
; CHECK-NEXT:   store volatile i8 1, i8* %{{[0-9]+}}, align 1
; CHECK-NEXT:   %amx.tmm.0.shape.row{{.*}} = getelementptr i8, i8* %{{[0-9]+}}, i64 48
; CHECK-NEXT:   %{{[0-9]+}} = getelementptr i8, i8* %{{[0-9]+}}, i64 16
; CHECK-NEXT:   %amx.tmm.0.shape.col{{.*}} = bitcast i8* %{{[0-9]+}} to i16*
; CHECK-NEXT:   %{{[0-9]+}} = trunc i16 %row to i8
; CHECK-NEXT:   store volatile i8 %{{[0-9]+}}, i8* %amx.tmm.0.shape.row{{.*}}, align 1
; CHECK-NEXT:   store volatile i16 %col, i16* %amx.tmm.0.shape.col{{.*}}, align 2
; CHECK-NEXT:   %amx.tmm.1.shape.row{{.*}} = getelementptr i8, i8* %{{[0-9]+}}, i64 49
; CHECK-NEXT:   %{{[0-9]+}} = getelementptr i8, i8* %{{[0-9]+}}, i64 18
; CHECK-NEXT:   %amx.tmm.1.shape.col{{.*}} = bitcast i8* %{{[0-9]+}} to i16*
; CHECK-NEXT:   %{{[0-9]+}} = trunc i16 %row to i8
; CHECK-NEXT:   store volatile i8 %{{[0-9]+}}, i8* %amx.tmm.1.shape.row{{.*}}, align 1
; CHECK-NEXT:   store volatile i16 8, i16* %amx.tmm.1.shape.col{{.*}}, align 2
; CHECK-NEXT:   %amx.tmm.2.shape.row{{.*}} = getelementptr i8, i8* %{{[0-9]+}}, i64 50
; CHECK-NEXT:   %{{[0-9]+}} = getelementptr i8, i8* %{{[0-9]+}}, i64 20
; CHECK-NEXT:   %amx.tmm.2.shape.col{{.*}} = bitcast i8* %{{[0-9]+}} to i16*
; CHECK-NEXT:   %{{[0-9]+}} = trunc i16 8 to i8
; CHECK-NEXT:   store volatile i8 %{{[0-9]+}}, i8* %amx.tmm.2.shape.row{{.*}}, align 1
; CHECK-NEXT:   store volatile i16 %col, i16* %amx.tmm.2.shape.col{{.*}}, align 2
; CHECK-NEXT:   %amx.tmm.3.shape.row{{.*}} = getelementptr i8, i8* %{{[0-9]+}}, i64 51
; CHECK-NEXT:   %{{[0-9]+}} = getelementptr i8, i8* %{{[0-9]+}}, i64 22
; CHECK-NEXT:   %amx.tmm.3.shape.col{{.*}} = bitcast i8* %{{[0-9]+}} to i16*
; CHECK-NEXT:   %{{[0-9]+}} = trunc i16 %row to i8
; CHECK-NEXT:   store volatile i8 %{{[0-9]+}}, i8* %amx.tmm.3.shape.row{{.*}}, align 1
; CHECK-NEXT:   store volatile i16 %col, i16* %amx.tmm.3.shape.col{{.*}}, align 2
; CHECK-NEXT:   call void @llvm.x86.ldtilecfg(i8* %{{[0-9]+}})
; CHECK-NEXT:   %{{[0-9]+}} = call x86_amx @llvm.x86.tileloadd64.internal(i16 %row, i16 8, i8* %{{[0-9]+}}, i64 64)
; CHECK-NEXT:   %{{[0-9]+}} = call x86_amx @llvm.x86.tileloadd64.internal(i16 8, i16 %col, i8* %{{[0-9]+}}, i64 64)
; CHECK-NEXT:   %{{[0-9]+}} = call x86_amx @llvm.x86.tileloadd64.internal(i16 %row, i16 %col, i8* %{{[0-9]+}}, i64 64)
; CHECK-NEXT:   %{{[0-9]+}} = tail call x86_amx @llvm.x86.tdpbssd.internal(i16 %row, i16 %col, i16 8, x86_amx %{{[0-9]+}}, x86_amx %{{[0-9]+}}, x86_amx %{{[0-9]+}})
; CHECK-NEXT:   call void @llvm.x86.tilestored64.internal(i16 %row, i16 %col, i8* %{{[0-9]+}}, i64 64, x86_amx %{{[0-9]+}})
; CHECK-NEXT:   %{{[0-9]+}} = bitcast <16 x i32>* %{{[0-9]+}} to i8*
; CHECK-NEXT:   store <16 x i32> zeroinitializer, <16 x i32>* %{{[0-9]+}}, align 4
; CHECK-NEXT:   %{{[0-9]+}} = getelementptr i8, i8* %{{[0-9]+}}, i64 0
; CHECK-NEXT:   store volatile i8 1, i8* %{{[0-9]+}}, align 1
; CHECK-NEXT:   %amx.tmm.0.shape.row{{.*}} = getelementptr i8, i8* %{{[0-9]+}}, i64 48
; CHECK-NEXT:   %{{[0-9]+}} = getelementptr i8, i8* %{{[0-9]+}}, i64 16
; CHECK-NEXT:   %amx.tmm.0.shape.col{{.*}} = bitcast i8* %{{[0-9]+}} to i16*
; CHECK-NEXT:   %{{[0-9]+}} = trunc i16 %row to i8
; CHECK-NEXT:   store volatile i8 %{{[0-9]+}}, i8* %amx.tmm.0.shape.row{{.*}}, align 1
; CHECK-NEXT:   store volatile i16 %col, i16* %amx.tmm.0.shape.col{{.*}}, align 2
; CHECK-NEXT:   call void @llvm.x86.ldtilecfg(i8* %{{[0-9]+}})
; CHECK-NEXT:   %{{[0-9]+}} = call x86_amx @llvm.x86.tileloadd64.internal(i16 %row, i16 %col, i8* %{{[0-9]+}}, i64 64)
; CHECK-NEXT:   tail call void @llvm.x86.tilestored64.internal(i16 %row, i16 %col, i8* getelementptr inbounds ([1024 x i8], [1024 x i8]* @buf, i64 0, i64 0), i64 32, x86_amx %{{[0-9]+}})
; CHECK-NEXT:   ret void

entry:
  %0 = alloca <256 x i32>, align 1024
  %1 = bitcast <256 x i32>* %0 to i8*
  %2 = alloca <256 x i32>, align 1024
  %3 = bitcast <256 x i32>* %2 to i8*
  %4 = alloca <256 x i32>, align 1024
  %5 = bitcast <256 x i32>* %4 to i8*
  %6 = alloca <256 x i32>, align 1024
  %7 = bitcast <256 x i32>* %6 to i8*
  %tobool.not = icmp eq i32 %cond, 0
  br i1 %tobool.not, label %if.else, label %if.then

if.then:                                          ; preds = %entry
  %8 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 %row, i16 8, i8* getelementptr inbounds ([1024 x i8], [1024 x i8]* @buf, i64 0, i64 0), i64 32)
  call void @llvm.x86.tilestored64.internal(i16 %row, i16 8, i8* %5, i64 64, x86_amx %8)
  %9 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 8, i16 %col, i8* getelementptr inbounds ([1024 x i8], [1024 x i8]* @buf, i64 0, i64 0), i64 32)
  call void @llvm.x86.tilestored64.internal(i16 8, i16 %col, i8* %3, i64 64, x86_amx %9)
  %10 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 %row, i16 %col, i8* getelementptr inbounds ([1024 x i8], [1024 x i8]* @buf, i64 0, i64 0), i64 32)
  call void @llvm.x86.tilestored64.internal(i16 %row, i16 %col, i8* %1, i64 64, x86_amx %10)
  br label %if.end

if.else:                                          ; preds = %entry
  %11 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 %row, i16 8, i8* getelementptr inbounds ([1024 x i8], [1024 x i8]* @buf2, i64 0, i64 0), i64 32)
  call void @llvm.x86.tilestored64.internal(i16 %row, i16 8, i8* %5, i64 64, x86_amx %11)
  %12 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 8, i16 %col, i8* getelementptr inbounds ([1024 x i8], [1024 x i8]* @buf2, i64 0, i64 0), i64 32)
  call void @llvm.x86.tilestored64.internal(i16 8, i16 %col, i8* %3, i64 64, x86_amx %12)
  %13 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 %row, i16 %col, i8* getelementptr inbounds ([1024 x i8], [1024 x i8]* @buf2, i64 0, i64 0), i64 32)
  call void @llvm.x86.tilestored64.internal(i16 %row, i16 %col, i8* %1, i64 64, x86_amx %13)
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %14 = call x86_amx @llvm.x86.tileloadd64.internal(i16 %row, i16 8, i8* %5, i64 64)
  %15 = call x86_amx @llvm.x86.tileloadd64.internal(i16 8, i16 %col, i8* %3, i64 64)
  %16 = call x86_amx @llvm.x86.tileloadd64.internal(i16 %row, i16 %col, i8* %1, i64 64)
  %17 = tail call x86_amx @llvm.x86.tdpbssd.internal(i16 %row, i16 %col, i16 8, x86_amx %16, x86_amx %14, x86_amx %15)
  call void @llvm.x86.tilestored64.internal(i16 %row, i16 %col, i8* %7, i64 64, x86_amx %17)
  %18 = call x86_amx @llvm.x86.tileloadd64.internal(i16 %row, i16 %col, i8* %7, i64 64)
  tail call void @llvm.x86.tilestored64.internal(i16 %row, i16 %col, i8* getelementptr inbounds ([1024 x i8], [1024 x i8]* @buf, i64 0, i64 0), i64 32, x86_amx %18)
  ret void
}

; Function Attrs: nounwind
declare x86_amx @llvm.x86.tileloadd64.internal(i16, i16, i8*, i64)

; Function Attrs: nounwind
declare x86_amx @llvm.x86.tdpbssd.internal(i16, i16, i16, x86_amx, x86_amx, x86_amx)

; Function Attrs: nounwind
declare void @llvm.x86.tilestored64.internal(i16, i16, i8*, i64, x86_amx)
