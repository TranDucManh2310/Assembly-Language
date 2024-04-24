.data
prompt: .asciiz "Nhap n: "
number: .asciiz " "
.text
.globl main

main:
    li $v0, 4          # syscall để in chuỗi
    la $a0, prompt     # địa chỉ chuỗi prompt
    syscall

    li $v0, 5          # syscall để đọc số nguyên
    syscall
    move $s0, $v0      # lưu giá trị n vào $s0

    li $t0, 0          # i = 0

print_loop:
    move $a0, $t0
    jal fibonacci      # gọi hàm fibonacci(i)
    move $t1, $v0      # lưu kết quả fibonacci vào $t1

    blt $t1, $s0, print_fib # nếu fibonacci(i) < n, in ra
    j end_loop

print_fib:
    li $v0, 1          # syscall để in số nguyên
    move $a0, $t1      # chuyển kết quả fibonacci sang $a0
    syscall

    li $v0, 4          # syscall để in khoảng trắng
    la $a0, number
    syscall

    addi $t0, $t0, 1   # i++
    j print_loop

end_loop:
    li $v0, 10         # syscall để kết thúc chương trình
    syscall

# Hàm fibonacci
fibonacci:
    li $v0, 0          # f0 = 0
    li $t1, 1          # f1 = 1
    li $t2, 1          # fn = 1
    move $t0, $a0      # n = $a0

    bltz $t0, fib_end  # nếu n < 0, trả về -1
    beqz $t0, fib_end  # nếu n = 0, trả về 0
    li $v0, 1          # Đặt kết quả mặc định là 1 cho n = 1
    blez $t0, fib_end  # nếu n <= 1, trả về kết quả

    li $t3, 2          # i = 2
fib_loop:
    bge $t3, $t0, fib_end  # nếu i >= n, kết thúc
    move $t4, $t1      # f0 = f1
    move $t1, $t2      # f1 = fn
    add $t2, $t4, $t1  # fn = f0 + f1
    addi $t3, $t3, 1   # i++
    j fib_loop

fib_end:
    move $v0, $t2      # Trả về kết quả fn
    jr $ra             # Trở về hàm gọi
