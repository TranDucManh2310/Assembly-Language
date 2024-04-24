.data
    inputString: .space 100 
    prompt: .asciiz "Nhap xau: "
    countMsg: .asciiz "\nSo nguyen am trong xau la: "
.text
.globl main

main:
    # Nhập xâu ký tự
    li $v0, 4
    la $a0, prompt
    syscall
    
    li $v0, 8 # Đọc xâu ký tự
    la $a0, inputString
    li $a1, 100 # Độ dài tối đa của xâu
    syscall
    
    # Đếm số nguyên âm
    li $t0, 0 # Số nguyên âm
    li $t1, 0 # Index i = 0
    
lowercase_loop:
    lb $t2, inputString($t1) # Đọc ký tự tại vị trí i
    
    # Chuyển ký tự về chữ thường nếu là chữ hoa
    li $t3, 65 # 'A' - ASCII
    li $t4, 90 # 'Z' - ASCII
    blt $t2, $t3, not_uppercase
    bgt $t2, $t4, not_uppercase
    addi $t2, $t2, 32 # Chuyển chữ hoa về chữ thường
    
not_uppercase:
    sb $t2, inputString($t1) # Lưu ký tự vào xâu
    
    addi $t1, $t1, 1 # Tăng index i lên 1
    bnez $t2, lowercase_loop # Nếu chưa kết thúc xâu, tiếp tục vòng lặp
    
    # Đếm số nguyên âm
    li $t1, 0 # Reset index i = 0
    
count_vowels_loop:
    lb $t2, inputString($t1) # Đọc ký tự tại vị trí i
    
    # Kiểm tra ký tự có phải nguyên âm không
    li $t3, 0 # Flag để kiểm tra nguyên âm
    li $t4, 97 # 'a' - ASCII
    li $t5, 111 # 'o' - ASCII
    
    blt $t2, $t4, not_vowel
    bgt $t2, $t5, not_vowel
    
    li $t3, 1 # Đánh dấu là nguyên âm
    
    beq $t2, 101, is_vowel_e # Kiểm tra nguyên âm 'e'
    beq $t2, 105, is_vowel_i # Kiểm tra nguyên âm 'i'
    beq $t2, 97, is_vowel_a # Kiểm tra nguyên âm 'a'
    beq $t2, 111, is_vowel_o # Kiểm tra nguyên âm 'o'
    beq $t2, 117, is_vowel_u # Kiểm tra nguyên âm 'u'
    
not_vowel:
    addi $t1, $t1, 1 # Tăng index i lên 1
    bnez $t2, count_vowels_loop # Nếu chưa kết thúc xâu, tiếp tục vòng lặp
    
    # In số nguyên âm
    li $v0, 4
    la $a0, countMsg
    syscall
    li $v0, 1
    move $a0, $t0
    syscall
    
    # Kết thúc chương trình
    li $v0, 10
    syscall

is_vowel_a:
is_vowel_e:
is_vowel_i:
is_vowel_o:
is_vowel_u:
    addi $t0, $t0, 1 # Tăng số nguyên âm lên 1
    j not_vowel
