# x86_64 Assembly Conversion – Parameter Passing Game

**Author:** Emoshoke Saliu
**Module:** Assembly and C   
**Original Author:** Phillip Bourke  
**Converted On:** April 2025

---

## Project Summary

This program is a direct x86_64 NASM conversion of a 68000 Assembly program. It demonstrates:
- Parameter passing via **registers**
- Integer **input/output**
- A **loop** that runs three times
- Accumulation of a **running sum**

The core logic was preserved from the 68000 version, including its structure and subroutine behavior.

---

## How It Works

The program:
1. Prompts the user to enter two numbers.
2. Adds the numbers using a subroutine `register_adder`.
3. Repeats this 3 times.
4. Displays the final running sum.

---

## Conversion Notes

### Register Mapping

| 68000     | x86_64     |
|-----------|------------|
| D1, D2    | rbx, rcx   |
| A0, A1    | rsi, rdi   |
| Stack ops | Registers used only |

- Parameter passing in subroutines uses **rdi/rsi** (as per Linux x86_64 calling convention).
- Return value from subroutine in **rax**.

### Subroutine Translations
- `REGISTER_ADDER` is now `register_adder` and uses register parameters.
- `NEW_LINE` converted to a reusable `print_newline` syscall-based function.

---

## Security Considerations

### Intentionally Left Unsafe (To Match Original)
- Input reading is naive (no bounds checks, uses ASCII to int conversion).
- No buffer overflow protection.
- No stack guards or input sanitization.

**These issues are noted but kept to match the simplicity of the original 68000 version.**

---

## Testing

- A test C file will be used to call this ASM routine for automated testing.
- Manual CLI testing involves entering values like `3` and `4` for repeatability.

---

## Build & Run

```bash
nasm -f elf64 -o main.o main.asm
ld -o main main.o
./main
