; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; First example from Doc/Coroutines.rst (two block loop) converted to retcon
; RUN: opt < %s -enable-coroutines -O2 -S -enable-new-pm=0 | FileCheck --check-prefixes=ALL,OLDPM %s
; RUN: opt < %s -enable-coroutines -passes='default<O2>' -S | FileCheck --check-prefixes=ALL,NEWPM %s

define i8* @f(i8* %buffer, i32 %n) {
; ALL-LABEL: @f(
; ALL-NEXT:  entry:
; ALL-NEXT:    [[N_VAL_SPILL_ADDR:%.*]] = bitcast i8* [[BUFFER:%.*]] to i32*
; ALL-NEXT:    store i32 [[N:%.*]], i32* [[N_VAL_SPILL_ADDR]], align 4
; ALL-NEXT:    tail call void @print(i32 [[N]])
; ALL-NEXT:    ret i8* bitcast (i8* (i8*, i1)* @f.resume.0 to i8*)
;
entry:
  %id = call token @llvm.coro.id.retcon(i32 8, i32 4, i8* %buffer, i8* bitcast (i8* (i8*, i1)* @prototype to i8*), i8* bitcast (i8* (i32)* @allocate to i8*), i8* bitcast (void (i8*)* @deallocate to i8*))
  %hdl = call i8* @llvm.coro.begin(token %id, i8* null)
  br label %loop

loop:
  %n.val = phi i32 [ %n, %entry ], [ %inc, %resume ]
  call void @print(i32 %n.val)
  %unwind0 = call i1 (...) @llvm.coro.suspend.retcon.i1()
  br i1 %unwind0, label %cleanup, label %resume

resume:
  %inc = add i32 %n.val, 1
  br label %loop

cleanup:
  call i1 @llvm.coro.end(i8* %hdl, i1 0)
  unreachable
}



define i32 @main() {
; ALL-LABEL: @main(
; ALL-NEXT:  entry:
; ALL-NEXT:    [[TMP0:%.*]] = alloca [8 x i8], align 4
; ALL-NEXT:    [[DOTSUB:%.*]] = getelementptr inbounds [8 x i8], [8 x i8]* [[TMP0]], i64 0, i64 0
; ALL-NEXT:    [[N_VAL_SPILL_ADDR_I:%.*]] = bitcast [8 x i8]* [[TMP0]] to i32*
; ALL-NEXT:    store i32 4, i32* [[N_VAL_SPILL_ADDR_I]], align 4
; ALL-NEXT:    call void @print(i32 4)
; ALL-NEXT:    call void @llvm.experimental.noalias.scope.decl(metadata [[META0:![0-9]+]])
; ALL-NEXT:    [[N_VAL_RELOAD_I:%.*]] = load i32, i32* [[N_VAL_SPILL_ADDR_I]], align 4, !alias.scope !0
; ALL-NEXT:    [[INC_I:%.*]] = add i32 [[N_VAL_RELOAD_I]], 1
; ALL-NEXT:    store i32 [[INC_I]], i32* [[N_VAL_SPILL_ADDR_I]], align 4, !alias.scope !0
; ALL-NEXT:    call void @print(i32 [[INC_I]]), !noalias !0
; ALL-NEXT:    call void @llvm.experimental.noalias.scope.decl(metadata [[META3:![0-9]+]])
; ALL-NEXT:    [[N_VAL_RELOAD_I1:%.*]] = load i32, i32* [[N_VAL_SPILL_ADDR_I]], align 4, !alias.scope !3
; ALL-NEXT:    [[INC_I2:%.*]] = add i32 [[N_VAL_RELOAD_I1]], 1
; ALL-NEXT:    call void @print(i32 [[INC_I2]]), !noalias !3
; ALL-NEXT:    ret i32 0
;
entry:
  %0 = alloca [8 x i8], align 4
  %buffer = bitcast [8 x i8]* %0 to i8*
  %prepare = call i8* @llvm.coro.prepare.retcon(i8* bitcast (i8* (i8*, i32)* @f to i8*))
  %f = bitcast i8* %prepare to i8* (i8*, i32)*
  %cont0 = call i8* %f(i8* %buffer, i32 4)
  %cont0.cast = bitcast i8* %cont0 to i8* (i8*, i1)*
  %cont1 = call i8* %cont0.cast(i8* %buffer, i1 zeroext false)
  %cont1.cast = bitcast i8* %cont1 to i8* (i8*, i1)*
  %cont2 = call i8* %cont1.cast(i8* %buffer, i1 zeroext false)
  %cont2.cast = bitcast i8* %cont2 to i8* (i8*, i1)*
  call i8* %cont2.cast(i8* %buffer, i1 zeroext true)
  ret i32 0
}

;   Unfortunately, we don't seem to fully optimize this right now due
;   to some sort of phase-ordering thing.

define hidden { i8*, i8* } @g(i8* %buffer, i16* %ptr) {
; OLDPM-LABEL: @g(
; OLDPM-NEXT:  entry:
; OLDPM-NEXT:    [[TMP0:%.*]] = tail call i8* @allocate(i32 8) #[[ATTR0:[0-9]+]]
; OLDPM-NEXT:    [[TMP1:%.*]] = bitcast i8* [[BUFFER:%.*]] to i8**
; OLDPM-NEXT:    store i8* [[TMP0]], i8** [[TMP1]], align 8
; OLDPM-NEXT:    [[PTR_SPILL_ADDR:%.*]] = bitcast i8* [[TMP0]] to i16**
; OLDPM-NEXT:    store i16* [[PTR:%.*]], i16** [[PTR_SPILL_ADDR]], align 8
; OLDPM-NEXT:    [[TMP2:%.*]] = bitcast i16* [[PTR]] to i8*
; OLDPM-NEXT:    [[TMP3:%.*]] = insertvalue { i8*, i8* } { i8* bitcast ({ i8*, i8* } (i8*, i1)* @g.resume.0 to i8*), i8* undef }, i8* [[TMP2]], 1
; OLDPM-NEXT:    ret { i8*, i8* } [[TMP3]]
;
; NEWPM-LABEL: @g(
; NEWPM-NEXT:  entry:
; NEWPM-NEXT:    [[TMP0:%.*]] = tail call i8* @allocate(i32 8)
; NEWPM-NEXT:    [[TMP1:%.*]] = bitcast i8* [[BUFFER:%.*]] to i8**
; NEWPM-NEXT:    store i8* [[TMP0]], i8** [[TMP1]], align 8
; NEWPM-NEXT:    [[PTR_SPILL_ADDR:%.*]] = bitcast i8* [[TMP0]] to i16**
; NEWPM-NEXT:    store i16* [[PTR:%.*]], i16** [[PTR_SPILL_ADDR]], align 8
; NEWPM-NEXT:    [[TMP2:%.*]] = bitcast i16* [[PTR]] to i8*
; NEWPM-NEXT:    [[TMP3:%.*]] = insertvalue { i8*, i8* } { i8* bitcast ({ i8*, i8* } (i8*, i1)* @g.resume.0 to i8*), i8* undef }, i8* [[TMP2]], 1
; NEWPM-NEXT:    ret { i8*, i8* } [[TMP3]]
;
entry:
  %id = call token @llvm.coro.id.retcon(i32 8, i32 4, i8* %buffer, i8* bitcast ({ i8*, i8* } (i8*, i1)* @g_prototype to i8*), i8* bitcast (i8* (i32)* @allocate to i8*), i8* bitcast (void (i8*)* @deallocate to i8*))
  %hdl = call i8* @llvm.coro.begin(token %id, i8* null)
  br label %loop

loop:
  %ptr2 = bitcast i16* %ptr to i8*
  %unwind0 = call i1 (...) @llvm.coro.suspend.retcon.i1(i8* %ptr2)
  br i1 %unwind0, label %cleanup, label %resume

resume:
  br label %loop

cleanup:
  call i1 @llvm.coro.end(i8* %hdl, i1 0)
  unreachable
}

declare token @llvm.coro.id.retcon(i32, i32, i8*, i8*, i8*, i8*)
declare i8* @llvm.coro.begin(token, i8*)
declare i1 @llvm.coro.suspend.retcon.i1(...)
declare i1 @llvm.coro.end(i8*, i1)
declare i8* @llvm.coro.prepare.retcon(i8*)

declare i8* @prototype(i8*, i1 zeroext)
declare {i8*,i8*} @g_prototype(i8*, i1 zeroext)

declare noalias i8* @allocate(i32 %size)
declare void @deallocate(i8* %ptr)

declare void @print(i32)

