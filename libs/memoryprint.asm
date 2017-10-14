;expects address of hex data in si and how many bytes to print in bx
print_hex_data:
    push si ; temporalily save si
    cmp bx, byte 0x00
	je end_of_programm
	next_byte:
        dec bx
    mov al,[si]    
    call print_hex_value
    inc si;
    cmp bx, byte 0x00
    jne next_byte
    end_of_programm:
	pop si
	ret

; expects hex value in al
print_hex_value:
    push ax
    push bx
	
	mov bx,ax
	and bl,0xF0
	cmp bl,0x90
	
;-------------------------------
    ja first_part_of_hexadigit_no_number
    call print_hex_number_high_nipple
    jmp end_of_statement
    first_part_of_hexadigit_no_number:
        call print_hex_char_high_nipple
    end_of_statement:
;--------------------------------
    
	mov bx,ax
	and bl,0x0F
    cmp bl,0x09
;--------------------------------
    ja second_part_of_hexadigit_no_number
    call print_hex_number_low_nipple
    jmp end_of_statement_part2
    second_part_of_hexadigit_no_number:
        call print_hex_char_low_nipple
    end_of_statement_part2:
;---------------------------------
    pop bx
	pop ax
    ret

; Expect in al

print_hex_number_high_nipple:
    push ax

;----------------
    shr al, 4
	and al,0x0F
	add al, 0x30
    call print_char
;--------------
    
    pop ax
    ret

; Expect in al
print_hex_number_low_nipple:
    push ax
    and al,0x0F
    add al, 0x30
    call print_char
    pop ax
    ret

print_hex_char_high_nipple:
    push ax
    ;and al, 0xF0
	shr al, 4
	and al, 0x0F
	add al,0x37
    call print_char
    pop ax
    ret

print_hex_char_low_nipple:
    push ax
	and al, 0x0F
	add al, 0x37
	call print_char
	pop ax
	ret

; Expects char to print in al
print_char:
    mov ah, 0x0e ; BIOS scrolling teletpye funciton
    int 0x10
    ret
