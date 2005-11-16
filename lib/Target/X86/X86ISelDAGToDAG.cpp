//===-- X86ISelPattern.cpp - A DAG pattern matching inst selector for X86 -===//
//
//                     The LLVM Compiler Infrastructure
//
// This file was developed by the Evan Cheng and is distributed under
// the University of Illinois Open Source License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file defines a DAG pattern matching instruction selector for X86,
// converting from a legalized dag to a X86 dag.
//
//===----------------------------------------------------------------------===//

#include "X86.h"
#include "X86Subtarget.h"
#include "X86ISelLowering.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/SelectionDAGISel.h"
#include "llvm/Target/TargetMachine.h"
#include "llvm/Support/Debug.h"
#include "llvm/ADT/Statistic.h"
using namespace llvm;

//===----------------------------------------------------------------------===//
//                      Pattern Matcher Implementation
//===----------------------------------------------------------------------===//

namespace {
  Statistic<>
  NumFPKill("x86-codegen", "Number of FP_REG_KILL instructions added");

  //===--------------------------------------------------------------------===//
  /// ISel - X86 specific code to select X86 machine instructions for
  /// SelectionDAG operations.
  ///
  class X86DAGToDAGISel : public SelectionDAGISel {
    /// ContainsFPCode - Every instruction we select that uses or defines a FP
    /// register should set this to true.
    bool ContainsFPCode;

    /// X86Lowering - This object fully describes how to lower LLVM code to an
    /// X86-specific SelectionDAG.
    X86TargetLowering X86Lowering;

    /// Subtarget - Keep a pointer to the X86Subtarget around so that we can
    /// make the right decision when generating code for different targets.
    const X86Subtarget *Subtarget;
  public:
    X86DAGToDAGISel(TargetMachine &TM)
      : SelectionDAGISel(X86Lowering), X86Lowering(TM) {
      Subtarget = &TM.getSubtarget<X86Subtarget>();
    }

    virtual const char *getPassName() const {
      return "X86 DAG->DAG Instruction Selection";
    }

    /// InstructionSelectBasicBlock - This callback is invoked by
    /// SelectionDAGISel when it has created a SelectionDAG for us to codegen.
    virtual void InstructionSelectBasicBlock(SelectionDAG &DAG);

// Include the pieces autogenerated from the target description.
#include "X86GenDAGISel.inc"

  private:
    SDOperand Select(SDOperand N);

    /// getI16Imm - Return a target constant with the specified value, of type
    /// i16.
    inline SDOperand getI16Imm(unsigned Imm) {
      return CurDAG->getTargetConstant(Imm, MVT::i16);
    }

    /// getI32Imm - Return a target constant with the specified value, of type
    /// i32.
    inline SDOperand getI32Imm(unsigned Imm) {
      return CurDAG->getTargetConstant(Imm, MVT::i32);
    }
  };
}

/// InstructionSelectBasicBlock - This callback is invoked by SelectionDAGISel
/// when it has created a SelectionDAG for us to codegen.
void X86DAGToDAGISel::InstructionSelectBasicBlock(SelectionDAG &DAG) {
  DEBUG(BB->dump());

  // Codegen the basic block.
  DAG.setRoot(Select(DAG.getRoot()));
  DAG.RemoveDeadNodes();

  // Emit machine code to BB. 
  ScheduleAndEmitDAG(DAG);
}

SDOperand X86DAGToDAGISel::Select(SDOperand Op) {
  SDNode *N = Op.Val;
  MVT::ValueType OpVT = Op.getValueType();
  unsigned Opc;

  if (N->getOpcode() >= ISD::BUILTIN_OP_END)
    return Op;   // Already selected.
  
  switch (N->getOpcode()) {
    default: break;
    case ISD::Constant: {
      switch (OpVT) {
        default: assert(0 && "Cannot use constants of this type!");
        case MVT::i1:
        case MVT::i8:  Opc = X86::MOV8ri;  break;
        case MVT::i16: Opc = X86::MOV16ri; break;
        case MVT::i32: Opc = X86::MOV32ri; break;
      }
      unsigned CVal = cast<ConstantSDNode>(N)->getValue();
      SDOperand Op1 = CurDAG->getTargetConstant(CVal, OpVT);
      CurDAG->SelectNodeTo(N, Opc, OpVT, Op1);
      return Op;
    }

    case ISD::RET: {
      SDOperand Chain = Select(N->getOperand(0));     // Token chain.
      switch (N->getNumOperands()) {
        default:
          assert(0 && "Unknown return instruction!");
        case 3:
          assert(0 && "Not yet handled return instruction!");
          break;
        case 2: {
          SDOperand Val = Select(N->getOperand(1));
          switch (N->getOperand(1).getValueType()) {
            default:
              assert(0 && "All other types should have been promoted!!");
            case MVT::i32:
              Chain = CurDAG->getCopyToReg(Chain, X86::EAX, Val);
              break;
            case MVT::f32:
            case MVT::f64:
              assert(0 && "Not yet handled return instruction!");
              break;
          }
        }
        case 1:
          break;
      }
      if (X86Lowering.getBytesToPopOnReturn() == 0)
        CurDAG->SelectNodeTo(N, X86::RET, MVT::Other, Chain);
      else
        CurDAG->SelectNodeTo(N, X86::RET, MVT::Other, Chain,
                             getI16Imm(X86Lowering.getBytesToPopOnReturn()));

      return SDOperand(N, 0);
    }
  }

  return SelectCode(Op);
}

/// createX86ISelDag - This pass converts a legalized DAG into a 
/// X86-specific DAG, ready for instruction scheduling.
///
FunctionPass *llvm::createX86ISelDag(TargetMachine &TM) {
  return new X86DAGToDAGISel(TM);
}
