# architecture: mips or riscv 
ARCH=riscv

# board specific parameters
BAUDRATE=57600
F_CLK=25000000
SERIAL_DEV=/dev/ttyUSB0

# compiler flags
CFLAGS_STRIP = -fdata-sections -ffunction-sections
LDFLAGS_STRIP = --gc-sections
LD_SCRIPT = hf-risc.ld

CFLAGS_NO_HW_MULDIV = -mnohwmult -mnohwdiv -ffixed-lo -ffixed-hi
GCC_mips = mips-elf-gcc -Wall -O2 -c -mips2 -mno-branch-likely -mpatfree -mfix-r4000 -mno-check-zero-division -msoft-float -ffreestanding -nostdlib -fomit-frame-pointer -G 0 -I ./include -DCPU_SPEED=${F_CLK} -DBIG_ENDIAN $(CFLAGS_NO_HW_MULDIV) $(CFLAGS_STRIP) #-DDEBUG_PORT
AS_mips = mips-elf-as -mips1 -msoft-float
LD_mips = mips-elf-ld -mips1 $(LDFLAGS_STRIP)
DUMP_mips = mips-elf-objdump
READ_mips = mips-elf-readelf
OBJ_mips = mips-elf-objcopy
SIZE_mips = mips-elf-size

GCC_riscv = riscv32-unknown-elf-gcc -march=rv32i -mabi=ilp32 -Wall -O2 -c -mstrict-align -ffreestanding -nostdlib -ffixed-s10 -ffixed-s11 -I ./include -DCPU_SPEED=${F_CLK} -DLITTLE_ENDIAN $(CFLAGS_STRIP) $(IFTEST)
#-DDEBUG_PORT #-ffixed-s10 -ffixed-s11 -mno-div -mrvc -fPIC -DDEBUG_PORT
AS_riscv = riscv32-unknown-elf-as -march=rv32i -mabi=ilp32 #-fPIC
LD_riscv = riscv32-unknown-elf-ld -melf32lriscv $(LDFLAGS_STRIP)
DUMP_riscv = riscv32-unknown-elf-objdump -Mno-aliases
READ_riscv = riscv32-unknown-elf-readelf
OBJ_riscv = riscv32-unknown-elf-objcopy
SIZE_riscv = riscv32-unknown-elf-size