# With B extension:
# RUN: llvm-mc %s -triple=riscv32 -mattr=+experimental-b -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ASM,CHECK-ASM-AND-OBJ %s
# RUN: llvm-mc -filetype=obj -triple=riscv32 -mattr=+experimental-b < %s \
# RUN:     | llvm-objdump --mattr=+experimental-b -d -r - \
# RUN:     | FileCheck --check-prefixes=CHECK-OBJ,CHECK-ASM-AND-OBJ %s

# With Bitmanip permutation extension:
# RUN: llvm-mc %s -triple=riscv32 -mattr=+experimental-zbp -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ASM,CHECK-ASM-AND-OBJ %s
# RUN: llvm-mc -filetype=obj -triple=riscv32 -mattr=+experimental-zbp < %s \
# RUN:     | llvm-objdump --mattr=+experimental-zbp -d -r - \
# RUN:     | FileCheck --check-prefixes=CHECK-OBJ,CHECK-ASM-AND-OBJ %s

# CHECK-ASM-AND-OBJ: slo t0, t1, t2
# CHECK-ASM: encoding: [0xb3,0x12,0x73,0x20]
slo t0, t1, t2
# CHECK-ASM-AND-OBJ: sro t0, t1, t2
# CHECK-ASM: encoding: [0xb3,0x52,0x73,0x20]
sro t0, t1, t2
# CHECK-ASM-AND-OBJ: sloi t0, t1, 0
# CHECK-ASM: encoding: [0x93,0x12,0x03,0x20]
sloi t0, t1, 0
# CHECK-ASM-AND-OBJ: sroi t0, t1, 0
# CHECK-ASM: encoding: [0x93,0x52,0x03,0x20]
sroi t0, t1, 0
# CHECK-ASM-AND-OBJ: gorc t0, t1, t2
# CHECK-ASM: encoding: [0xb3,0x52,0x73,0x28]
gorc t0, t1, t2
# CHECK-ASM-AND-OBJ: grev t0, t1, t2
# CHECK-ASM: encoding: [0xb3,0x52,0x73,0x68]
grev t0, t1, t2
# CHECK-ASM-AND-OBJ: gorci t0, t1, 0
# CHECK-ASM: encoding: [0x93,0x52,0x03,0x28]
gorci t0, t1, 0
# CHECK-ASM-AND-OBJ: grevi t0, t1, 0
# CHECK-ASM: encoding: [0x93,0x52,0x03,0x68]
grevi t0, t1, 0
# CHECK-ASM-AND-OBJ: shfl t0, t1, t2
# CHECK-ASM: encoding: [0xb3,0x12,0x73,0x08]
shfl t0, t1, t2
# CHECK-ASM-AND-OBJ: unshfl t0, t1, t2
# CHECK-ASM: encoding: [0xb3,0x52,0x73,0x08]
unshfl t0, t1, t2
# CHECK-ASM-AND-OBJ: shfli t0, t1, 0
# CHECK-ASM: encoding: [0x93,0x12,0x03,0x08]
shfli t0, t1, 0
# CHECK-ASM-AND-OBJ: unshfli t0, t1, 0
# CHECK-ASM: encoding: [0x93,0x52,0x03,0x08]
unshfli t0, t1, 0
# CHECK-ASM-AND-OBJ: pack t0, t1, t2
# CHECK-ASM: encoding: [0xb3,0x42,0x73,0x08]
pack t0, t1, t2
# CHECK-ASM-AND-OBJ: packu t0, t1, t2
# CHECK-ASM: encoding: [0xb3,0x42,0x73,0x48]
packu t0, t1, t2
# CHECK-ASM-AND-OBJ: packh t0, t1, t2
# CHECK-ASM: encoding: [0xb3,0x72,0x73,0x08]
packh t0, t1, t2
# CHECK-ASM-AND-OBJ: zext.h t0, t1
# CHECK-ASM: encoding: [0xb3,0x42,0x03,0x08]
zext.h t0, t1
# CHECK-ASM: pack t0, t1, zero
# CHECK-OBJ: zext.h t0, t1
# CHECK-ASM: encoding: [0xb3,0x42,0x03,0x08]
pack t0, t1, x0
# CHECK-ASM-AND-OBJ: rev8 t0, t1
# CHECK-ASM: encoding: [0x93,0x52,0x83,0x69]
rev8 t0, t1
# CHECK-ASM: grevi t0, t1, 24
# CHECK-OBJ: rev8 t0, t1
# CHECK-ASM: encoding: [0x93,0x52,0x83,0x69]
grevi t0, t1, 24
# CHECK-ASM-AND-OBJ: orc.b t0, t1
# CHECK-ASM: encoding: [0x93,0x52,0x73,0x28]
orc.b t0, t1
# CHECK-ASM: gorci t0, t1, 7
# CHECK-OBJ: orc.b t0, t1
# CHECK-ASM: encoding: [0x93,0x52,0x73,0x28]
gorci t0, t1, 7
# CHECK-ASM-AND-OBJ: xperm.n t0, t1, t2
# CHECK-ASM: encoding: [0xb3,0x22,0x73,0x28]
xperm.n t0, t1, t2
# CHECK-ASM-AND-OBJ: xperm.b t0, t1, t2
# CHECK-ASM: encoding: [0xb3,0x42,0x73,0x28]
xperm.b t0, t1, t2
# CHECK-ASM-AND-OBJ: xperm.h t0, t1, t2
# CHECK-ASM: encoding: [0xb3,0x62,0x73,0x28
xperm.h t0, t1, t2
