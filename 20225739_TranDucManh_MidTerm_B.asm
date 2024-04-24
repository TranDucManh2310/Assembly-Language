.data
    arraySpace: .space 400 
    promptSize: .asciiz "Nhap kich thuoc mang: "
    promptElement: .asciiz "\nNhap pha tu: "
    sumOddMsg: .asciiz "\nTong cac phan tu le la:  "
    sumNegativeMsg: .asciiz "\nTong cac phan tu am la: "
.text
.globl main

main:
    # Nhập kích thước mảng
    li $v0, 4
    la $a0, promptSize
    syscall
    
    li $v0, 5 # Đọc số nguyên
    syscall
    move $t0, $v0 # Lưu kích thước mảng vào $t0
    
    # Kiểm tra kích thước mảng
    blez $t0, exit # Nếu kích thước <= 0 thì thoát
    
    # Nhập các phần tử mảng
    li $t1, 0 # Index i = 0
    li $t2, 0 # Tổng các phần tử lẻ
    li $t3, 0 # Tổng các phần tử âm
    la $t4, arraySpace # Địa chỉ bắt đầu của mảng
    
input_loop:
    # In thông điệp nhập phần tử
    li $v0, 4
    la $a0, promptElement
    syscall
    
    # Đọc phần tử mảng
    li $v0, 5
    syscall
    sw $v0, 0($t4) # Lưu phần tử vào mảng
    
    # Kiểm tra và cập nhật tổng lẻ
    andi $t5, $v0, 1 # $t5 = $v0 % 2
    bnez $t5, update_odd_sum
    
    # Kiểm tra và cập nhật tổng âm
    bltz $v0, update_negative_sum
    j update_index
    
update_odd_sum:
    add $t2, $t2, $v0 # Cập nhật tổng lẻ
    
update_negative_sum:
    bltz $v0, add_negative_sum # Chỉ cập nhật tổng âm nếu phần tử < 0
    j update_index
    
add_negative_sum:
    add $t3, $t3, $v0 # Cập nhật tổng âm
    
update_index:
    addi $t4, $t4, 4 # Cập nhật địa chỉ mảng cho phần tử tiếp theo
    addi $t1, $t1, 1 # Tăng index
    blt $t1, $t0, input_loop # Nếu i < kích thước mảng, tiếp tục vòng lặp
    
    # In tổng các phần tử lẻ
    li $v0, 4
    la $a0, sumOddMsg
    syscall
    li $v0, 1
    move $a0, $t2
    syscall
    
    # In tổng các phần tử âm
    li $v0, 4
    la $a0, sumNegativeMsg
    syscall
    li $v0, 1
    move $a0, $t3
    syscall
    
exit:
    li $v0, 10 # Thoát chương trình
    syscall
