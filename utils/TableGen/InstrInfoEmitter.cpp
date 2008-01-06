//===- InstrInfoEmitter.cpp - Generate a Instruction Set Desc. ------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This tablegen backend is responsible for emitting a description of the target
// instruction set for the code generator.
//
//===----------------------------------------------------------------------===//

#include "InstrInfoEmitter.h"
#include "CodeGenTarget.h"
#include "Record.h"
#include <algorithm>
#include <iostream>
using namespace llvm;

static void PrintDefList(const std::vector<Record*> &Uses,
                         unsigned Num, std::ostream &OS) {
  OS << "static const unsigned ImplicitList" << Num << "[] = { ";
  for (unsigned i = 0, e = Uses.size(); i != e; ++i)
    OS << getQualifiedName(Uses[i]) << ", ";
  OS << "0 };\n";
}

//===----------------------------------------------------------------------===//
// Instruction Itinerary Information.
//===----------------------------------------------------------------------===//

struct RecordNameComparator {
  bool operator()(const Record *Rec1, const Record *Rec2) const {
    return Rec1->getName() < Rec2->getName();
  }
};

void InstrInfoEmitter::GatherItinClasses() {
  std::vector<Record*> DefList =
  Records.getAllDerivedDefinitions("InstrItinClass");
  std::sort(DefList.begin(), DefList.end(), RecordNameComparator());
  
  for (unsigned i = 0, N = DefList.size(); i < N; i++)
    ItinClassMap[DefList[i]->getName()] = i;
}  

unsigned InstrInfoEmitter::getItinClassNumber(const Record *InstRec) {
  return ItinClassMap[InstRec->getValueAsDef("Itinerary")->getName()];
}

//===----------------------------------------------------------------------===//
// Operand Info Emission.
//===----------------------------------------------------------------------===//

std::vector<std::string>
InstrInfoEmitter::GetOperandInfo(const CodeGenInstruction &Inst) {
  std::vector<std::string> Result;
  
  for (unsigned i = 0, e = Inst.OperandList.size(); i != e; ++i) {
    // Handle aggregate operands and normal operands the same way by expanding
    // either case into a list of operands for this op.
    std::vector<CodeGenInstruction::OperandInfo> OperandList;

    // This might be a multiple operand thing.  Targets like X86 have
    // registers in their multi-operand operands.  It may also be an anonymous
    // operand, which has a single operand, but no declared class for the
    // operand.
    DagInit *MIOI = Inst.OperandList[i].MIOperandInfo;
    
    if (!MIOI || MIOI->getNumArgs() == 0) {
      // Single, anonymous, operand.
      OperandList.push_back(Inst.OperandList[i]);
    } else {
      for (unsigned j = 0, e = Inst.OperandList[i].MINumOperands; j != e; ++j) {
        OperandList.push_back(Inst.OperandList[i]);

        Record *OpR = dynamic_cast<DefInit*>(MIOI->getArg(j))->getDef();
        OperandList.back().Rec = OpR;
      }
    }

    for (unsigned j = 0, e = OperandList.size(); j != e; ++j) {
      Record *OpR = OperandList[j].Rec;
      std::string Res;
      
      if (OpR->isSubClassOf("RegisterClass"))
        Res += getQualifiedName(OpR) + "RegClassID, ";
      else
        Res += "0, ";
      // Fill in applicable flags.
      Res += "0";
        
      // Ptr value whose register class is resolved via callback.
      if (OpR->getName() == "ptr_rc")
        Res += "|M_LOOK_UP_PTR_REG_CLASS";

      // Predicate operands.  Check to see if the original unexpanded operand
      // was of type PredicateOperand.
      if (Inst.OperandList[i].Rec->isSubClassOf("PredicateOperand"))
        Res += "|M_PREDICATE_OPERAND";
        
      // Optional def operands.  Check to see if the original unexpanded operand
      // was of type OptionalDefOperand.
      if (Inst.OperandList[i].Rec->isSubClassOf("OptionalDefOperand"))
        Res += "|M_OPTIONAL_DEF_OPERAND";

      // Fill in constraint info.
      Res += ", " + Inst.OperandList[i].Constraints[j];
      Result.push_back(Res);
    }
  }

  return Result;
}

void InstrInfoEmitter::EmitOperandInfo(std::ostream &OS, 
                                       OperandInfoMapTy &OperandInfoIDs) {
  // ID #0 is for no operand info.
  unsigned OperandListNum = 0;
  OperandInfoIDs[std::vector<std::string>()] = ++OperandListNum;
  
  OS << "\n";
  const CodeGenTarget &Target = CDP.getTargetInfo();
  for (CodeGenTarget::inst_iterator II = Target.inst_begin(),
       E = Target.inst_end(); II != E; ++II) {
    std::vector<std::string> OperandInfo = GetOperandInfo(II->second);
    unsigned &N = OperandInfoIDs[OperandInfo];
    if (N != 0) continue;
    
    N = ++OperandListNum;
    OS << "static const TargetOperandInfo OperandInfo" << N << "[] = { ";
    for (unsigned i = 0, e = OperandInfo.size(); i != e; ++i)
      OS << "{ " << OperandInfo[i] << " }, ";
    OS << "};\n";
  }
}

//===----------------------------------------------------------------------===//
// Instruction Analysis
//===----------------------------------------------------------------------===//

class InstAnalyzer {
  const CodeGenDAGPatterns &CDP;
  bool &isStore;
  bool &isLoad;
  bool &NeverHasSideEffects;
public:
  InstAnalyzer(const CodeGenDAGPatterns &cdp,
               bool &isstore, bool &isload, bool &nhse)
    : CDP(cdp), isStore(isstore), isLoad(isload), NeverHasSideEffects(nhse) {
  }
  
  void Analyze(Record *InstRecord) {
    const TreePattern *Pattern = CDP.getInstruction(InstRecord).getPattern();
    if (Pattern == 0) return;  // No pattern.
    
    // Assume there is no side-effect unless we see one.
    // FIXME: Enable this.
    //NeverHasSideEffects = true;

    
    // FIXME: Assume only the first tree is the pattern. The others are clobber
    // nodes.
    AnalyzeNode(Pattern->getTree(0));
  }
  
private:
  void AnalyzeNode(const TreePatternNode *N) {
    if (N->isLeaf()) {
      return;
    }

    if (N->getOperator()->getName() != "set") {
      // Get information about the SDNode for the operator.
      const SDNodeInfo &OpInfo = CDP.getSDNodeInfo(N->getOperator());
      
      // If this is a store node, it obviously stores to memory.
      if (OpInfo.getEnumName() == "ISD::STORE") {
        isStore = true;
        
      } else if (const CodeGenIntrinsic *IntInfo = N->getIntrinsicInfo(CDP)) {
        // If this is an intrinsic, analyze it.
        if (IntInfo->ModRef >= CodeGenIntrinsic::WriteArgMem)
          isStore = true;  // Intrinsics that can write to memory are 'isStore'.
      }
    }

    for (unsigned i = 0, e = N->getNumChildren(); i != e; ++i)
      AnalyzeNode(N->getChild(i));
  }
  
};

void InstrInfoEmitter::InferFromPattern(const CodeGenInstruction &Inst, 
                                        bool &isStore, bool &isLoad, 
                                        bool &NeverHasSideEffects) {
  isStore             = Inst.isStore;
  isLoad              = Inst.isLoad;
  NeverHasSideEffects = Inst.neverHasSideEffects;
  
  InstAnalyzer(CDP, isStore, isLoad, NeverHasSideEffects).Analyze(Inst.TheDef);
  
  // If the .td file explicitly says there is no side effect, believe it.
  if (Inst.neverHasSideEffects)
    NeverHasSideEffects = true;
}


//===----------------------------------------------------------------------===//
// Main Output.
//===----------------------------------------------------------------------===//

// run - Emit the main instruction description records for the target...
void InstrInfoEmitter::run(std::ostream &OS) {
  GatherItinClasses();

  EmitSourceFileHeader("Target Instruction Descriptors", OS);
  OS << "namespace llvm {\n\n";

  CodeGenTarget Target;
  const std::string &TargetName = Target.getName();
  Record *InstrInfo = Target.getInstructionSet();

  // Keep track of all of the def lists we have emitted already.
  std::map<std::vector<Record*>, unsigned> EmittedLists;
  unsigned ListNumber = 0;
 
  // Emit all of the instruction's implicit uses and defs.
  for (CodeGenTarget::inst_iterator II = Target.inst_begin(),
         E = Target.inst_end(); II != E; ++II) {
    Record *Inst = II->second.TheDef;
    std::vector<Record*> Uses = Inst->getValueAsListOfDefs("Uses");
    if (!Uses.empty()) {
      unsigned &IL = EmittedLists[Uses];
      if (!IL) PrintDefList(Uses, IL = ++ListNumber, OS);
    }
    std::vector<Record*> Defs = Inst->getValueAsListOfDefs("Defs");
    if (!Defs.empty()) {
      unsigned &IL = EmittedLists[Defs];
      if (!IL) PrintDefList(Defs, IL = ++ListNumber, OS);
    }
  }

  OperandInfoMapTy OperandInfoIDs;
  
  // Emit all of the operand info records.
  EmitOperandInfo(OS, OperandInfoIDs);
  
  // Emit all of the TargetInstrDescriptor records in their ENUM ordering.
  //
  OS << "\nstatic const TargetInstrDescriptor " << TargetName
     << "Insts[] = {\n";
  std::vector<const CodeGenInstruction*> NumberedInstructions;
  Target.getInstructionsByEnumValue(NumberedInstructions);

  for (unsigned i = 0, e = NumberedInstructions.size(); i != e; ++i)
    emitRecord(*NumberedInstructions[i], i, InstrInfo, EmittedLists,
               OperandInfoIDs, OS);
  OS << "};\n";
  OS << "} // End llvm namespace \n";
}

void InstrInfoEmitter::emitRecord(const CodeGenInstruction &Inst, unsigned Num,
                                  Record *InstrInfo,
                         std::map<std::vector<Record*>, unsigned> &EmittedLists,
                                  const OperandInfoMapTy &OpInfo,
                                  std::ostream &OS) {
  // Determine properties of the instruction from its pattern.
  bool isStore, isLoad, NeverHasSideEffects;
  InferFromPattern(Inst, isStore, isLoad, NeverHasSideEffects);
  
  if (NeverHasSideEffects && Inst.mayHaveSideEffects) {
    std::cerr << "error: Instruction '" << Inst.getName()
      << "' is marked with 'mayHaveSideEffects', but it can never have them!\n";
    exit(1);
  }
  
  int MinOperands = 0;
  if (!Inst.OperandList.empty())
    // Each logical operand can be multiple MI operands.
    MinOperands = Inst.OperandList.back().MIOperandNo +
                  Inst.OperandList.back().MINumOperands;
  
  OS << "  { ";
  OS << Num << ",\t" << MinOperands << ",\t"
     << Inst.NumDefs << ",\t\"" << Inst.getName();
  OS << "\",\t" << getItinClassNumber(Inst.TheDef) << ", 0";

  // Emit all of the target indepedent flags...
  if (Inst.isReturn)     OS << "|M_RET_FLAG";
  if (Inst.isBranch)     OS << "|M_BRANCH_FLAG";
  if (Inst.isIndirectBranch) OS << "|M_INDIRECT_FLAG";
  if (Inst.isBarrier)    OS << "|M_BARRIER_FLAG";
  if (Inst.hasDelaySlot) OS << "|M_DELAY_SLOT_FLAG";
  if (Inst.isCall)       OS << "|M_CALL_FLAG";
  if (isLoad)            OS << "|M_LOAD_FLAG";
  if (isStore)           OS << "|M_STORE_FLAG";
  if (Inst.isImplicitDef)OS << "|M_IMPLICIT_DEF_FLAG";
  if (Inst.isPredicable) OS << "|M_PREDICABLE";
  if (Inst.isConvertibleToThreeAddress) OS << "|M_CONVERTIBLE_TO_3_ADDR";
  if (Inst.isCommutable) OS << "|M_COMMUTABLE";
  if (Inst.isTerminator) OS << "|M_TERMINATOR_FLAG";
  if (Inst.isReMaterializable) OS << "|M_REMATERIALIZIBLE";
  if (Inst.isNotDuplicable)    OS << "|M_NOT_DUPLICABLE";
  if (Inst.hasOptionalDef)     OS << "|M_HAS_OPTIONAL_DEF";
  if (Inst.usesCustomDAGSchedInserter)
    OS << "|M_USES_CUSTOM_DAG_SCHED_INSERTION";
  if (Inst.hasVariableNumberOfOperands) OS << "|M_VARIABLE_OPS";
  if (Inst.mayHaveSideEffects)          OS << "|M_MAY_HAVE_SIDE_EFFECTS";
  if (NeverHasSideEffects)              OS << "|M_NEVER_HAS_SIDE_EFFECTS";
  OS << ", 0";

  // Emit all of the target-specific flags...
  ListInit *LI    = InstrInfo->getValueAsListInit("TSFlagsFields");
  ListInit *Shift = InstrInfo->getValueAsListInit("TSFlagsShifts");
  if (LI->getSize() != Shift->getSize())
    throw "Lengths of " + InstrInfo->getName() +
          ":(TargetInfoFields, TargetInfoPositions) must be equal!";

  for (unsigned i = 0, e = LI->getSize(); i != e; ++i)
    emitShiftedValue(Inst.TheDef, dynamic_cast<StringInit*>(LI->getElement(i)),
                     dynamic_cast<IntInit*>(Shift->getElement(i)), OS);

  OS << ", ";

  // Emit the implicit uses and defs lists...
  std::vector<Record*> UseList = Inst.TheDef->getValueAsListOfDefs("Uses");
  if (UseList.empty())
    OS << "NULL, ";
  else
    OS << "ImplicitList" << EmittedLists[UseList] << ", ";

  std::vector<Record*> DefList = Inst.TheDef->getValueAsListOfDefs("Defs");
  if (DefList.empty())
    OS << "NULL, ";
  else
    OS << "ImplicitList" << EmittedLists[DefList] << ", ";

  // Emit the operand info.
  std::vector<std::string> OperandInfo = GetOperandInfo(Inst);
  if (OperandInfo.empty())
    OS << "0";
  else
    OS << "OperandInfo" << OpInfo.find(OperandInfo)->second;
  
  OS << " },  // Inst #" << Num << " = " << Inst.TheDef->getName() << "\n";
}


void InstrInfoEmitter::emitShiftedValue(Record *R, StringInit *Val,
                                        IntInit *ShiftInt, std::ostream &OS) {
  if (Val == 0 || ShiftInt == 0)
    throw std::string("Illegal value or shift amount in TargetInfo*!");
  RecordVal *RV = R->getValue(Val->getValue());
  int Shift = ShiftInt->getValue();

  if (RV == 0 || RV->getValue() == 0) {
    // This isn't an error if this is a builtin instruction.
    if (R->getName() != "PHI" &&
        R->getName() != "INLINEASM" &&
        R->getName() != "LABEL" &&
        R->getName() != "EXTRACT_SUBREG" &&
        R->getName() != "INSERT_SUBREG")
      throw R->getName() + " doesn't have a field named '" + 
            Val->getValue() + "'!";
    return;
  }

  Init *Value = RV->getValue();
  if (BitInit *BI = dynamic_cast<BitInit*>(Value)) {
    if (BI->getValue()) OS << "|(1<<" << Shift << ")";
    return;
  } else if (BitsInit *BI = dynamic_cast<BitsInit*>(Value)) {
    // Convert the Bits to an integer to print...
    Init *I = BI->convertInitializerTo(new IntRecTy());
    if (I)
      if (IntInit *II = dynamic_cast<IntInit*>(I)) {
        if (II->getValue()) {
          if (Shift)
            OS << "|(" << II->getValue() << "<<" << Shift << ")";
          else
            OS << "|" << II->getValue();
        }
        return;
      }

  } else if (IntInit *II = dynamic_cast<IntInit*>(Value)) {
    if (II->getValue()) {
      if (Shift)
        OS << "|(" << II->getValue() << "<<" << Shift << ")";
      else
        OS << II->getValue();
    }
    return;
  }

  std::cerr << "Unhandled initializer: " << *Val << "\n";
  throw "In record '" + R->getName() + "' for TSFlag emission.";
}

