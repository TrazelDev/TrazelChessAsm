dosseg 
.model small
.stack 1000h
.data
	starting_msg1 db "welcome trzel chess geame$"
	starting_msg2 db "the game functions like a normal chess game except one execption:$"
	starting_msg3 db "the game does not recognize pins they are your responseblity don't move$"
	starting_msg4 db "pieces that are pined and ilgal to move$"
	starting_msg5 db "this is the only exception the other things are normal working$"
	starting_msg6 db "but when you lose the game it wont just say you lost and will exit$"
	starting_msg7 db "it will wait untill you just exit so you can ispect the position$"
	starting_msg8 db "you can start playing the game by pressing any key$"

	debugingcounter1 db 0	
	debugingcounter2 db 0

	loop_counter_dw dw 0	;basicaly instead of cx because cx is useful for another stuff
	
	counter1 db 0			;for checking random stuff just temporary 
	counter2 db 0			;for checking random stuff just temporary 

	specail_one_use_counter_for_the_king db 0
	counter1dw dw 0

	;each place of representing a spot of the chess board if there is a number in a spot that means a chess piece is in this spot:
	where_is_each_piece db 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32
	;each piece of the chess board is represented by a number (1-32):
	
	array_of_each_piece_y dw 32 dup (?)
	array_of_each_piece_x dw 32 dup (?)
	
	array_of_each_spot_y dw 2,52,102,152,202,252,302,352
	array_of_each_spot_x dw 238,288,338,388,438,488,538,588

	right_y dw 0
	right_x dw 0

	mouse_press_location db 0
	
	firts_mouse_press_location db 0
	second_mouse_press_location db 0
	
	firts_mouse_press_location_piece db 0
	second_mouse_press_location_piece db 0

	mouse_press_location_color db 0
	
	first_square_value_of_x dw 0

	first_queen_value_of_x dw 0 
	first_knight_value_of_x dw 0 
	first_bishop_value_of_x dw 0 
	first_rock_value_of_x dw 0 
	first_pawn_value_of_x dw 0

	first_king_value_of_x dw 0
	first_king_value_of_y dw 0

	queen_d1_x dw 388
	queen_d1_y dw 352
	
	queen_d8_x dw 388
	queen_d8_y dw 2
	
	knight_b1_x dw 288
	knight_b1_y dw 352
	
	knight_g1_x dw 538
	knight_g1_y dw 352
	
	knight_b8_x dw 288
	knight_b8_y dw 2
	
	knight_g8_x dw 538
	knight_g8_y dw 2
	
	bishop_c1_x dw 338
	bishop_c1_y dw 352
	
	bishop_f1_x dw 488
	bishop_f1_y dw 352
	
	bishop_c8_x dw 338
	bishop_c8_y dw 2
	
	bishop_f8_x dw 488
	bishop_f8_y dw 2
	
	rock_a8_x dw 238
	rock_a8_y dw 2
	
	rock_h8_x dw 588
	rock_h8_y dw 2
	
	rock_a1_x dw 238
	rock_a1_y dw 352
	
	rock_h1_x dw 588
	rock_h1_y dw 352

	white_king_x dw 438
	white_king_y dw 352
	
	black_king_x dw 438
	black_king_y dw 2
	
	pawn_a2_y dw 302
	pawn_a2_x dw 238
	
	pawn_b2_y dw 302
	pawn_b2_x dw 288
	
	pawn_c2_y dw 302
	pawn_c2_x dw 338
	
	pawn_d2_y dw 302
	pawn_d2_x dw 388
	
	pawn_e2_y dw 302
	pawn_e2_x dw 438
	
	pawn_f2_y dw 302
	pawn_f2_x dw 488
	
	pawn_g2_y dw 302
	pawn_g2_x dw 538
	
	pawn_h2_y dw 302
	pawn_h2_x dw 588
	
	pawn_a7_y dw 52
	pawn_a7_x dw 238
	
	pawn_b7_y dw 52
	pawn_b7_x dw 288
	
	pawn_c7_y dw 52
	pawn_c7_x dw 338
	
	pawn_d7_y dw 52
	pawn_d7_x dw 388
	
	pawn_e7_y dw 52
	pawn_e7_x dw 438
	
	pawn_f7_y dw 52
	pawn_f7_x dw 488
	
	pawn_g7_y dw 52
	pawn_g7_x dw 538
	
	pawn_h7_y dw 52
	pawn_h7_x dw 588
	
	;this part is for vars that are checking if the move is legal or ilegal
	the_color_of_the_lgal_moves_squres_that_show_up db 0
	first_leagal_square_value_of_x dw 0
	first_leagal_square_value_of_y dw 0
	the_move_is_legal db 0 							; this var is a flag and when somthing ilgal is happning than i turn off the flag and if evrything is legal than this flag stays turn on
	black_or_white_turn db 0 						;( 0 - white mov, 1 - black move )
	legal_location_that_needs_to_be_printed db 0
	the_disapear_part_the_mkaing_the_drawing_of_the_legal_moves db 0
	first_piece_pressed_color db 0  				;(0 - black piece, 1- white piece)

	array_of_flags_for_checks_of_knight_moves db 8 dup (0) ; the array checks by order: {-17,-15,-10,-6,+6,+10,+15,+17}
	array_of_legal_moves_for_all_off_the_picess db 64 dup (0) ; i update to here all of the legal moves of each picse  
	array_of_pawns_that_can_go_two_moves db 16 dup (1)

	array_of_all_opnnents_squares_that_are_controlled db 64 dup (0)
	; if pawn can go forward it does not mean it controll this squares only the places it can eat count and the king still control
	; the squares if they ilegal because of checks

	there_is_somthing_blocking_the_first_move_for_the_pawn_so_it_cant_go_two_moves db 0

	array_of_pawn_states db 16 dup (1)

	the_type_of_premotion_that_the_user_choose db 0

	which_direction_the_function_is_checking_for_the_bishop_movement dw 0
	which_direction_the_function_is_checking_for_the_rock_movement dw 0

	number_of_squares dw 0
	when_chking_squares_controlled_dont_do_certain_code db 0

	the_piece_does_not_exists db 0 
	the_final_piece_to_check db 0 

	array_of_rocks_taht_are_abel_to_castle db 4 dup (1)
	array_of_kings_that_are_abel_to_castle db 2 dup (1)

	need_to_check_more_bishops db 1
	need_to_check_more_rocks db 1
	need_to_check_more_pawns db 1

	king_value db 0

	king_is_in_check_flag db 0

	array_of_squares_that_the_bishop_controls_in_direction_of_the_check db 64 dup (0)
	array_of_squares_that_the_pawn_controls_in_direction_of_the_check db 64 dup (0)
	array_of_squares_that_the_kngiht_controls_in_direction_of_the_check db 64 dup (0)
	array_of_squares_that_the_rock_controls_in_direction_of_the_check db 64 dup (0)

	array_of_what_pieces_check_the_king db 4 dup (0) ; knight, bishop, rock and pawn
	dont_need_to_update_the_array_of_the_checks_squares db 0
	count_checks db 0

	last_location_to_compare db 0
	pointer_to_the_array_off_places dw 0
	check_for_moves_that_block_the_check db 0
	king_is_check_for_checks_mode db 0

	check_for_normal_bishop_move db 1
	check_for_normal_rock_move db 1
	
	exit_flag db 0
	
.stack 100h
.code
start:
mov ax,@data
mov ds,ax 
mov ax,0b800h
mov es,ax
call main 
mov ah,4ch 
int 21h

; this funtion is the main function of the project
main proc
	; clean the screen and print the welcme msg and wait until key press
	call cls
	call print_staring_msg 
	mov ah,01h
  	int 21h

	; set prrgramm to game mode 
	mov ah,00h 
	mov al,12h 
	int 10h   

	; creates two arrays of pointers for all of the x and y values of all of the pieces that on the screen
	call create_an_array_of_pointers

	; print all of the board and 
	call draw_board
	call draw_starting_position
	call print_the_letters_and_number_next_to_the_board

	; print msg that expalins how to exit the game
	call reset_the_cursor
	call print_msg_how_to_exit

	the_chess_game_loop:
		call set_the_mouse_to_apear
		
		get_mouse_first_click:
			; loop that waits for the mouse to click and when it clicks getting the location into the var ( mouse_press_location )
			call get_the_mouse_click
			
			; check if the user exited the game
			mov al,1
			cmp exit_flag,al
			je end_of_the_game

			;get the mouse press location form the var ( mouse_press_location ) to the firts_mouse_press_location
			mov al,mouse_press_location
			mov firts_mouse_press_location,al

		; resting the array of leagl moves 
		call reset_the_array_of_legal_moves
		
		; calulating the legal moves for the piece that was choosen 
		call check_what_leagal_moves_there_are_for_this_piece
	
		; taking the square from the array of legal moves and printing on the screen all of the options 
		call print_all_the_squres_that_are_legal

		;start delay (i need delay baceuse the code is running too fast and the first press of the mouse is happening togather with the second)
		call delay
		
		get_mouse_second_click:
			; loop that waits for the mouse to click and when it clicks getting the location into the var ( mouse_press_location )
			call get_the_mouse_click
			
			; check if the user exited the game
			mov al,1
			cmp exit_flag,al
			je end_of_the_game

			; get the mouse press location to the the var of the ( second_mouse_press_location )
			mov al,mouse_press_location
			mov second_mouse_press_location,al
			mov ax,0
			
		; turn of the mouse curser ( this is needed because if this not happing while 
		; chaning the visuel the mouse distryes the printing of the new pieces ) 
		mov ax,2 	
		int 33h	


		move_the_piece:
			; caluslting if the move that the user tried to make is legal
			mov the_disapear_part_the_mkaing_the_drawing_of_the_legal_moves,1
			call print_all_the_squres_that_are_legal

			call check_if_the_move_is_leagal
			cmp the_move_is_legal, 1
			jne end_calling_the_function_do_everything_related_to_moving_a_piece

			; making the move if it is legal
			call do_everything_related_to_moving_a_piece
			call make_the_arryay_of_the_knight_moves_to_be_zero_at_each_index
			mov ax,0
			mov check_for_moves_that_block_the_check,al
			
		end_calling_the_function_do_everything_related_to_moving_a_piece:
			; the delay is needed because the program runs too fast and the mosue preses haping togther
			call delay

			mov al,1
			cmp exit_flag,al
			jne the_chess_game_loop

	end_of_the_game:
		; print the msg than if the user wants to keep plaing than he should enter the word chess
		call print_exit_msg

	ret
main endp


; this function is printing all of the info in the start of the game the welcome msg 
; ( the only place that this function can be called is at the start of the game because the program does not changing the gamemode yet ther
print_staring_msg proc 
	mov di,160
	lea si,starting_msg1
	call print_msg

	mov di,160 * 2
	lea si,starting_msg2
	call print_msg

	mov di,160 * 3
	lea si,starting_msg3
	call print_msg

	mov di,160 * 4
	lea si,starting_msg4
	call print_msg

	mov di,160 * 5
	lea si,starting_msg5
	call print_msg

	mov di,160 * 6
	lea si,starting_msg6
	call print_msg

	mov di,160 * 7
	lea si,starting_msg7
	call print_msg

	mov di,160 * 10
	lea si,starting_msg8
	call print_msg

	ret
print_staring_msg endp

; this function prints to the user the messages in the right place
; its getting the di to be the location in the screen array and si contains the msg that the function wants to print
print_msg proc
	c1:
		mov dl,[si]
		cmp dl,'$'
		je sof
		mov dh,7h
		mov es:[di],dx
		add di,2
		inc si
		jmp c1
		sof:
	ret
print_msg endp

; this function is reseting the screen and making all of it to be black
cls proc
	mov cx,80*25
	mov dl,' '
	mov dh,0
	mov si,0
	cls1:
			mov es:[si],dx
			add si,2
	loop cls1

	ret
cls endp


; this function prints the msg how to exit it has to printed in this way becuse the game mode is changing and the program cant print 
; in the standert way
print_msg_how_to_exit proc
	mov dl,'t'
	call print_char 
	mov dl,'o'
	call print_char 
	mov dl,' '
	call print_char 
	mov dl,'e'
	call print_char 
	mov dl,'x'
	call print_char 
	mov dl,'i'
	call print_char 
	mov dl,'t'
	call print_char 
	mov dl,' '
	call print_char 
	mov dl,'e'
	call print_char 
	mov dl,'n'
	call print_char 
	mov dl,'t'
	call print_char 
	mov dl,'e'
	call print_char 
	mov dl,'r'
	call print_char 
	mov dl,' '
	call print_char 
	mov dl,'e'
	call print_char 
	mov dl,'s'
	call print_char 
	mov dl,'c'
	call print_char 
	mov dl,10 ; enter 
	call print_char 
	ret
print_msg_how_to_exit endp


; this function prints the exit msg it has to printed in this way becuse the game mode changing and the program cant print 
; in the standert way
print_exit_msg proc 
	mov dl,'e'
	call print_char 
	
	mov dl,'n'
	call print_char 

	mov dl,'t'
	call print_char 

	mov dl,'e'
	call print_char 

	mov dl,'r'
	call print_char 

	mov dl,' '
	call print_char 

	mov dl,'c'
	call print_char 

	mov dl,'h'
	call print_char 

	mov dl,'e'
	call print_char 

	mov dl,'s'
	call print_char 

	mov dl,'s'
	call print_char 

	mov dl,' '
	call print_char 

	mov dl,'f'
	call print_char 
	
	mov dl,'o'
	call print_char 

	mov dl,'r'
	call print_char 

	mov dl,''
	call print_char 

	mov dl,'n'
	call print_char 
	
	mov dl,'e'
	call print_char 
	
	mov dl,'w'
	call print_char 

	mov dl,' '
	call print_char 

	mov dl,'g'
	call print_char 

	mov dl,'a'
	call print_char 

	mov dl,'m'
	call print_char 

	mov dl,'e'
	call print_char
	ret
print_exit_msg endp


; this function is creating an 2 array of pointers one for all of the x values of all of the pieces and 
; one for all of the y values of all of pieces (this function exsits because when i started this project i was not 
; thinking about the visuels on the screen and how hard it would be to access the y and x value of each piece
; without an array of each x and y)
create_an_array_of_pointers proc	
	lea si,array_of_each_piece_y
	
	lea di,rock_a8_y
	mov [si], di
	
	add si,2
	lea di,knight_b8_y
	mov [si], di

	add si,2
	lea di,bishop_c8_y
	mov [si], di
	
	add si,2
	lea di,queen_d8_y
	mov [si], di
	
	add si,2
	lea di,black_king_y
	mov [si], di
	
	add si,2
	lea di,bishop_f8_y
	mov [si], di
	
	add si,2
	lea di,knight_g8_y
	mov [si], di
	
	add si,2
	lea di,rock_h8_y
	mov [si], di
	
	add si,2
	lea di,pawn_a7_y
	mov [si], di
	
	add si,2
	lea di,pawn_b7_y
	mov [si], di
	
	add si,2
	lea di,pawn_c7_y
	mov [si], di
	
	add si,2
	lea di,pawn_d7_y
	mov [si], di
	
	add si,2
	lea di,pawn_e7_y
	mov [si], di
	
	add si,2
	lea di,pawn_f7_y
	mov [si], di
	
	add si,2
	lea di,pawn_g7_y
	mov [si], di
	
	add si,2
	lea di,pawn_h7_y
	mov [si], di
	
	add si,2
	lea di,pawn_a2_y
	mov [si], di
	
	add si,2
	lea di,pawn_b2_y
	mov [si], di
	
	add si,2
	lea di,pawn_c2_y
	mov [si], di
	
	add si,2
	lea di,pawn_d2_y
	mov [si], di
	
	add si,2
	lea di,pawn_e2_y
	mov [si], di
	
	add si,2
	lea di,pawn_f2_y
	mov [si], di
	
	add si,2
	lea di,pawn_g2_y
	mov [si], di
	
	add si,2
	lea di,pawn_h2_y
	mov [si], di
	
	add si,2
	lea di,rock_a1_y
	mov [si], di
	
	add si,2
	lea di,knight_b1_y
	mov [si], di

	add si,2
	lea di,bishop_c1_y
	mov [si], di
	
	add si,2
	lea di,queen_d1_y
	mov [si], di
	
	add si,2
	lea di,white_king_y
	mov [si], di
	
	add si,2
	lea di,bishop_f1_y
	mov [si], di
	
	add si,2
	lea di,knight_g1_y
	mov [si], di
	
	add si,2
	lea di,rock_h1_y
	mov [si], di
	
	;this part is for the x:
	
	lea si,array_of_each_piece_x
	
	lea di,rock_a8_x
	mov [si], di
	
	add si,2
	lea di,knight_b8_x
	mov [si], di

	add si,2
	lea di,bishop_c8_x
	mov [si], di
	
	add si,2
	lea di,queen_d8_x
	mov [si], di
	
	add si,2
	lea di,black_king_x
	mov [si], di
	
	add si,2
	lea di,bishop_f8_x
	mov [si], di
	
	add si,2
	lea di,knight_g8_x
	mov [si], di
	
	add si,2
	lea di,rock_h8_x
	mov [si], di
	
	add si,2
	lea di,pawn_a7_x
	mov [si], di
	
	add si,2
	lea di,pawn_b7_x
	mov [si], di
	
	add si,2
	lea di,pawn_c7_x
	mov [si], di
	
	add si,2
	lea di,pawn_d7_x
	mov [si], di
	
	add si,2
	lea di,pawn_e7_x
	mov [si], di
	
	add si,2
	lea di,pawn_f7_x
	mov [si], di
	
	add si,2
	lea di,pawn_g7_x
	mov [si], di
	
	add si,2
	lea di,pawn_h7_x
	mov [si], di
	
	add si,2
	lea di,pawn_a2_x
	mov [si], di
	
	add si,2
	lea di,pawn_b2_x
	mov [si], di
	
	add si,2
	lea di,pawn_c2_x
	mov [si], di
	
	add si,2
	lea di,pawn_d2_x
	mov [si], di
	
	add si,2
	lea di,pawn_e2_x
	mov [si], di
	
	add si,2
	lea di,pawn_f2_x
	mov [si], di
	
	add si,2
	lea di,pawn_g2_x
	mov [si], di
	
	add si,2
	lea di,pawn_h2_x
	mov [si], di
	
	add si,2
	lea di,rock_a1_x
	mov [si], di
	
	add si,2
	lea di,knight_b1_x
	mov [si], di

	add si,2
	lea di,bishop_c1_x
	mov [si], di
	
	add si,2
	lea di,queen_d1_x
	mov [si], di
	
	add si,2
	lea di,white_king_x
	mov [si], di
	
	add si,2
	lea di,bishop_f1_x
	mov [si], di
	
	add si,2
	lea di,knight_g1_x
	mov [si], di
	
	add si,2
	lea di,rock_h1_x
	mov [si], di
	
	ret
create_an_array_of_pointers endp 


; this function is a delay
delay proc
	mov bx, 1
	mov si, 100
	delay1:
		cmp al,27
		dec bx
		;nop
		jnz delay1
		dec si
		cmp si,0    
		jnz delay1
		; end delay
	ret
delay endp



mouse_section:
	; this function is setting the mouse to apear and setting its boundries
	set_the_mouse_to_apear proc
		mov ax,1 	;set mouse curser in graphics mode
		int 33h		;excute configuration 
		
		mov cx,238	;min-x
		mov dx,638  ;max-x
		mov ax,7	;set mouse horizontel range
		int 33h 	;excute configuration
		
		mov cx,0	;min-y
		mov dx,399  ;max-y
		mov ax,8	;set mouse vertical range
		int 33h 	;excute configuration

		ret
	set_the_mouse_to_apear endp


	; this function is checking witch square was pressed by the user and puts the the number that 
	; repsent this square in the var that called mouse_press_location
	; (1 - 64 are the numbers that represent the squares on the board)
	check_what_square_mouse_pressing proc
		mov mouse_press_location,0 	;reset the value
		mov counter1,0
		
		; check what column the mouse pressed
		check_mouse_press_column:
		
			mov loop_counter_dw,50	;reset the counter
			
			get_back_to_the_first_column_with_cx:
			
				dec loop_counter_dw
				cmp cx,loop_counter_dw
				je finished_checking_column
				cmp loop_counter_dw,0
				jne get_back_to_the_first_column_with_cx
			
			sub cx,50
			inc counter1
			jmp check_mouse_press_column
			
		finished_checking_column:
		mov al,counter1
		inc al
		mov mouse_press_location,al
		mov counter1,0 						   ;reset the variable
			
		mov loop_counter_dw,0 
		
		; check what row the mouse pressed
		check_mouse_press_row:
			mov loop_counter_dw,50	;reset the counter
			
			get_back_to_the_first_row_with_dx:
				dec loop_counter_dw
				cmp dx,loop_counter_dw
				je finished_checking_row
				cmp loop_counter_dw,0
				jne get_back_to_the_first_row_with_dx
			
			
			sub dx,50
			inc counter1
			jmp check_mouse_press_row
			
		finished_checking_row:
		mov al,counter1
		
		; get the final square that the mouse pressed
		mul_mouse_press_location_by_8_for_check_what_square_mouse_pressing:
			cmp al,0
			je end_check_what_square_mouse_pressing
			add mouse_press_location,8
			dec al
			jmp mul_mouse_press_location_by_8_for_check_what_square_mouse_pressing
		
		
		end_check_what_square_mouse_pressing:
		mov cx,0
		mov dx,0
		ret
	check_what_square_mouse_pressing endp


	; the function is getting the click of the mouse from the user than detect what square the user pressed and puts 
	; it in the var called ( mouse_press_location ) 
	get_the_mouse_click proc
		mov mouse_press_location,0
		mov bl,27

		mov ax,0
		mouse_loop_first_click:   ;loop that checks if the left mouse button is clicked is yet
			; check if the user press to exist the program
			mov ax,0
			mov ah,01h
			int 16h
			cmp al,27
			je the_user_want_to_exit
			mov ax,0

			mov ax,5
			int 33h

			cmp ax,1
			jne mouse_loop_first_click
		
		mov cx,0
		mov dx,0
		mov ax,3		;set mouse to show his horizontel position in cx and his vertical position in dx
		int 33h			;excute configurtion 
		sub cx,238 	;to use as (0,0)
		call check_what_square_mouse_pressing
		ret
	
		the_user_want_to_exit:
			mov al,1
			mov exit_flag,al
			ret
	get_the_mouse_click endp
endp


visual_section:
	; this function draws the 64 squares of the chess on the screen
	draw_board proc 
		mov cx,238 ;set the column (x) for start
		mov dx,0   ; set the line (y) for
		mov al,07h ; choose light gray as color 
		
		draw_board_line:
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration 
			inc cx     					  ;inc the cordinates of the x
			cmp cx,289					  ;check if need to switch board square color
			je switch_board_square_colors ;jump to switch_board_square_colors
			cmp cx,339					  ;check if need to switch board square color
			je switch_board_square_colors ;jump to switch_board_square_colors
			cmp cx,389					  ;check if need to switch board square color
			je switch_board_square_colors ;jump to switch_board_square_colors
			cmp cx,439 					  ;check if need to switch board square color
			je switch_board_square_colors ;jump to switch_board_square_colors
			cmp cx,489					  ;check if need to switch board square color
			je switch_board_square_colors ;jump to switch_board_square_colors
			cmp cx,539					  ;check if need to switch board square color
			je switch_board_square_colors ;jump to switch_board_square_colors
			cmp cx,589					  ;check if need to switch board square color
			je switch_board_square_colors ;jump to switch_board_square_colors
			cmp cx,639 					  ;cheks if the x cordinates is the max
			jne draw_board_line 		  ;if it is we jump to next_board_line
			jmp next_board_line 	      ;else start the loop draw_board_line
			
		next_board_line:
			add dx,1					   ;adds one to the cordinatesof the y
			mov cx,238					   ;reset the x cordinates
			cmp dx,399				       ;checks if the y is the max 
			je end_board				   ;if it is finish drawing the board
			cmp dx,49					   ;checks if board next line 
			je draw_board_line			   ;if it is not switching colors and jumping back to draw_board_line
			cmp dx,99					   ;checks if board next line 
			je draw_board_line			   ;if it is not switching colors and jumping back to draw_board_line
			cmp dx,149					   ;checks if board next line 
			je draw_board_line			   ;if it is not switching colors and jumping back to draw_board_line
			cmp dx,199					   ;checks if board next line 
			je draw_board_line			   ;if it is not switching colors and jumping back to draw_board_line
			cmp dx,249					   ;checks if board next line 
			je draw_board_line			   ;if it is not switching colors and jumping back to draw_board_line
			cmp dx,299					   ;checks if board next line 
			je draw_board_line			   ;if it is not switching colors and jumping back to draw_board_line
			cmp dx,349					   ;checks if board next line 
			je draw_board_line			   ;if it is not switching colors and jumping back to draw_board_line
			
			jmp switch_board_square_colors ;if not jump back to switch switch_board_square_colors
			
		switch_board_square_colors:
			cmp al,07h				  ;check if the color of the square dark
			je switch_to_light_corlor ;jump to switch_to_light_corlor
			cmp al,08h				  ;check if the color of the square
			je switch_to_dark_corlor  ;jump to switch_to_dark_corlor
			
			switch_to_light_corlor:
				mov al,08h 			;switch the board square color to light
				jmp draw_board_line ;jump back to draw_board_line
			switch_to_dark_corlor:
				mov al,07h 			;switch the board square color to dark
				jmp draw_board_line ;jump back to draw_board_line
				
		end_board:
		ret
	draw_board endp


	;this function is printing the number nad letters next to the board
	print_the_letters_and_number_next_to_the_board proc 
		mov counter2,56
		mov dl,10
		mov ah,2
		int 21h

		loop_to_print_all_of_the_number_in_the_right_side:
			mov bl,27
			call get_enough_spaces_untill_the_letter
			mov dl,counter2
			mov ah,2
			int 21h
			mov dl,10
			mov ah,2
			int 21h
			mov dl,10
			mov ah,2
			int 21h
			mov dl,10
			mov ah,2
			int 21h
			dec counter2
			cmp counter2, 48
			jne loop_to_print_all_of_the_number_in_the_right_side
		
		mov counter2,65
		mov bl, 34
		call get_enough_spaces_untill_the_letter
		loop_to_print_all_of_the_letters_in_the_bottom:
			mov dl,counter2
			mov ah,2
			int 21h
			mov dl,0
			mov ah,2
			int 21h
			mov dl,0
			mov ah,2
			int 21h
			mov dl,0
			mov ah,2
			int 21h
			mov dl,0
			mov ah,2
			int 21h
			mov dl,0
			mov ah,2
			int 21h
			inc counter2
			cmp counter2, 73
			jne loop_to_print_all_of_the_letters_in_the_bottom

		
		ret
	print_the_letters_and_number_next_to_the_board endp 


	;this function is drawing the spaces untill the letters needs to be printed
	get_enough_spaces_untill_the_letter proc

		mov counter1,0
		loop_to_get_infe_spaces_until_the_ltters:
			mov dl,0
			mov ah,2
			int 21h
			inc counter1
			cmp counter1,bl
			jne loop_to_get_infe_spaces_until_the_ltters

		ret
	get_enough_spaces_untill_the_letter endp


	; this is the function that draws all of the pieces in the starting position
	draw_starting_position proc
		d1_queen_starting_position_draw:
			mov first_queen_value_of_x,388	  ;set reltive value of x to 238
			mov cx,queen_d1_x				  ;set x cordinates for start
			mov dx,queen_d1_y 				  ;set y cordinates
			mov al,0fh 					  	  ;choose white as color
			call draw_queen
		
		d8_knight_starting_position_draw:
			mov first_queen_value_of_x,388	  ;set reltive value of x to 238
			mov cx,queen_d8_x				  ;set x cordinates for start
			mov dx,queen_d8_y 				  ;set y cordinates
			mov al,0h 					  	  ;choose white as color
			call draw_queen
		
		b1_knight_starting_position_draw:
			mov first_knight_value_of_x,288	  ;set reltive value of x to 238
			mov cx,knight_b1_x				  ;set x cordinates for start
			mov dx,knight_b1_y 				  ;set y cordinates
			mov al,0fh 					  	  ;choose white as color
			call draw_knight
		
		g1_knight_starting_position_draw:
			mov first_knight_value_of_x,538	  ;set reltive value of x to 238
			mov cx,knight_g1_x				  ;set x cordinates for start
			mov dx,knight_g1_y 				  ;set y cordinates
			mov al,0fh 					  	  ;choose white as color
			call draw_knight
		
		b8_knight_starting_position_draw:
			mov first_knight_value_of_x,288	  ;set reltive value of x to 238
			mov cx,knight_b8_x				  ;set x cordinates for start
			mov dx,knight_b8_y 				  ;set y cordinates
			mov al,0h 					  	  ;choose white as color
			call draw_knight
		
		g8_knight_starting_position_draw:
			mov first_knight_value_of_x,538	  ;set reltive value of x to 238
			mov cx,knight_g8_x				  ;set x cordinates for start
			mov dx,knight_g8_y 				  ;set y cordinates
			mov al,0h 					  	  ;choose white as color
			call draw_knight
			
		c1_bishop_starting_position_draw:
			mov first_bishop_value_of_x,338	  ;set reltive value of x to 238
			mov cx,bishop_c1_x				  ;set x cordinates for start
			mov dx,bishop_c1_y 				  ;set y cordinates
			mov al,0fh 					  	  ;choose white as color
			call draw_bishop
			
		f1_bishop_starting_position_draw:
			mov first_bishop_value_of_x,488	  ;set reltive value of x to 238
			mov cx,bishop_f1_x				  ;set x cordinates for start
			mov dx,bishop_f1_y 				  ;set y cordinates
			mov al,0fh 					  	  ;choose white as color
			call draw_bishop
		
		c8_bishop_starting_position_draw:
			mov first_bishop_value_of_x,338	  ;set reltive value of x to 238
			mov cx,bishop_c8_x				  ;set x cordinates for start
			mov dx,bishop_c8_y 				  ;set y cordinates
			mov al,0h 					  	  ;choose black as color
			call draw_bishop
			
		f8_bishop_starting_position_draw:
			mov first_bishop_value_of_x,488	  ;set reltive value of x to 238
			mov cx,bishop_f8_x				  ;set x cordinates for start
			mov dx,bishop_f8_y 				  ;set y cordinates
			mov al,0h 					  	  ;choose black as color
			call draw_bishop
			
		a1_rock_starting_position_draw:
			mov first_rock_value_of_x,238	  ;set reltive value of x to 238
			mov cx,rock_a1_x				  ;set x cordinates for start
			mov dx,rock_a1_y 				  ;set y cordinates
			mov al,0fh 					  	  ;choose black as color
			call draw_rock 
		
		a8_rock_starting_position_draw:
			mov first_rock_value_of_x,238	  ;set reltive value of x to 588
			mov cx,rock_a8_x				  ;set x cordinates for start
			mov dx,rock_a8_y 				  ;set y cordinates
			mov al,0h 					  	  ;choose black as color
			call draw_rock
			
		h1_rock_starting_position_draw:
			mov first_rock_value_of_x,588	  ;set reltive value of x to 238
			mov cx,rock_h1_x				  ;set x cordinates for start
			mov dx,rock_h1_y 				  ;set y cordinates
			mov al,0fh 					  	  ;choose black as color
			call draw_rock 
		
		h8_rock_starting_position_draw:
			mov first_rock_value_of_x,588	  ;set reltive value of x to 588
			mov cx,rock_h8_x				  ;set x cordinates for start
			mov dx,rock_h8_y 				  ;set y cordinates
			mov al,0h 					  	  ;choose black as color
			call draw_rock
			
		black_king_starting_position_draw:
			mov first_king_value_of_x,438	  ;set reltive value of x to 438
			mov first_king_value_of_y,2		  ;set reltive value of y to 2
			mov cx,black_king_x				  ;set x cordinates for start
			mov dx,black_king_y				  ;set y cordinates for start
			mov al,0h 					  	  ;choose black as color
			call draw_king
			
		white_king_starting_position_draw:
			mov first_king_value_of_x,438	  ;set reltive value of x to 438
			mov first_king_value_of_y,352	  ;set reltive value of y to 352
			mov cx,white_king_x				  ;set x cordinates for start
			mov dx,white_king_y				  ;set y cordinates for start
			mov al,0fh 					  	  ;choose white as color
			call draw_king
			
		a2_starting_position_draw:
			mov first_pawn_value_of_x,238 ;set the realtive x to 238
			mov cx,pawn_a2_x 			  ;set the column (x) for start
			mov dx,pawn_a2_y   			  ;set the line (y) for start 
			mov al,0fh 					  ;choose white as color 
			call draw_pawn
			
		b2_starting_position_draw:
			mov first_pawn_value_of_x,288 ;set the realtive x to 288
			mov cx,pawn_b2_x 			  ;set the column (x) for start
			mov dx,pawn_b2_y   			  ;set the line (y) for start 
			mov al,0fh 					  ;choose white as color 
			call draw_pawn
		c2_starting_position_draw:
			mov first_pawn_value_of_x,338 ;set the realtive x to 338
			mov cx,pawn_c2_x 			  ;set the column (x) for start
			mov dx,pawn_c2_y   			  ;set the line (y) for start 
			mov al,0fh 					  ;choose white as color 
			call draw_pawn
		d2_starting_position_draw:
			mov first_pawn_value_of_x,388 ;set the realtive x to 388
			mov cx,pawn_d2_x 			  ;set the column (x) for start
			mov dx,pawn_d2_y   			  ;set the line (y) for start 
			mov al,0fh 					  ;choose white as color 
			call draw_pawn
		e2_starting_position_draw:
			mov first_pawn_value_of_x,438 ;set the realtive x to 438
			mov cx,pawn_e2_x 			  ;set the column (x) for start
			mov dx,pawn_e2_y   			  ;set the line (y) for start 
			mov al,0fh 					  ;choose white as color 
			call draw_pawn
		f2_starting_position_draw:
			mov first_pawn_value_of_x,488 ;set the realtive x to 488
			mov cx,pawn_f2_x 			  ;set the column (x) for start
			mov dx,pawn_f2_y   			  ;set the line (y) for start 
			mov al,0fh 					  ;choose white as color 
			call draw_pawn
		g2_starting_position_draw:
			mov first_pawn_value_of_x,538 ;set the realtive x to 538
			mov cx,pawn_g2_x 			  ;set the column (x) for start
			mov dx,pawn_g2_y   			  ;set the line (y) for start 
			mov al,0fh 					  ;choose white as color 
			call draw_pawn
		h2_starting_position_draw:
			mov first_pawn_value_of_x,588 ;set the realtive x to 588
			mov cx,pawn_h2_x 			  ;set the column (x) for start
			mov dx,pawn_h2_y   			  ;set the line (y) for start 
			mov al,0fh 					  ;choose white as color 
			call draw_pawn
		a7_starting_position_draw:
			mov first_pawn_value_of_x,238 ;set the realtive x to 238
			mov cx,pawn_a7_x 			  ;set the column (x) for start
			mov dx,pawn_a7_y   			  ;set the line (y) for start 
			mov al,0h 					  ;choose white as color 
			call draw_pawn
			
		b7_starting_position_draw:
			mov first_pawn_value_of_x,288 ;set the realtive x to 288
			mov cx,pawn_b7_x 			  ;set the column (x) for start
			mov dx,pawn_b7_y   			  ;set the line (y) for start 
			mov al,0h 					  ;choose white as color 
			call draw_pawn
		c7_starting_position_draw:
			mov first_pawn_value_of_x,338 ;set the realtive x to 338
			mov cx,pawn_c7_x 			  ;set the column (x) for start
			mov dx,pawn_c7_y   			  ;set the line (y) for start 
			mov al,0h 					  ;choose white as color 
			call draw_pawn
		d7_starting_position_draw:
			mov first_pawn_value_of_x,388 ;set the realtive x to 388
			mov cx,pawn_d7_x 			  ;set the column (x) for start
			mov dx,pawn_d7_y   			  ;set the line (y) for start 
			mov al,0h 					  ;choose white as color 
			call draw_pawn
		e7_starting_position_draw:
			mov first_pawn_value_of_x,438 ;set the realtive x to 438
			mov cx,pawn_e7_x 			  ;set the column (x) for start
			mov dx,pawn_e7_y   			  ;set the line (y) for start 
			mov al,0h 					  ;choose white as color 
			call draw_pawn
		f7_starting_position_draw:
			mov first_pawn_value_of_x,488 ;set the realtive x to 488
			mov cx,pawn_f7_x 			  ;set the column (x) for start
			mov dx,pawn_f7_y   			  ;set the line (y) for start 
			mov al,0h 					  ;choose white as color 
			call draw_pawn
		g7_starting_position_draw:
			mov first_pawn_value_of_x,538 ;set the realtive x to 538
			mov cx,pawn_g7_x 			  ;set the column (x) for start
			mov dx,pawn_g7_y   			  ;set the line (y) for start 
			mov al,0h 					  ;choose white as color 
			call draw_pawn
		h7_starting_position_draw:
			mov first_pawn_value_of_x,588 ;set the realtive x to 588
			mov cx,pawn_h7_x 			  ;set the column (x) for start
			mov dx,pawn_h7_y   			  ;set the line (y) for start 
			mov al,0h 					  ;choose white as color 
			call draw_pawn
			
		ret
	draw_starting_position endp


	; this function calls all of the 8 the eight functions below it and makes purpose of this functions is
	; to draw the pieces in the right location int the right color ( right color means the color of the square if it is called to make 
	; it disapear or in the color of the piece if it is to to draw the piece in the new location ) 
	draw_the_in_the_right_location proc
		mov di,0
		call darw_the_right_piece_ti_the_right_cordinates_for_black_first_part
		cmp di,1
		je end_draw_the_piece_in_the_color_of_her_squre_to_make_her_disapear_commends
		call darw_the_right_piece_ti_the_right_cordinates_for_black_second_part
		
		cmp di,1
		je end_draw_the_piece_in_the_color_of_her_squre_to_make_her_disapear_commends
		call darw_the_right_piece_ti_the_right_cordinates_for_black_third_part
		cmp di,1
		je end_draw_the_piece_in_the_color_of_her_squre_to_make_her_disapear_commends
		call darw_the_right_piece_ti_the_right_cordinates_for_black_fourth_part
		cmp di,1
		je end_draw_the_piece_in_the_color_of_her_squre_to_make_her_disapear_commends
		call darw_the_right_piece_ti_the_right_cordinates_for_white_first_part
		cmp di,1
		je end_draw_the_piece_in_the_color_of_her_squre_to_make_her_disapear_commends
		call darw_the_right_piece_ti_the_right_cordinates_for_white_second_part
		cmp di,1
		je end_draw_the_piece_in_the_color_of_her_squre_to_make_her_disapear_commends
		call darw_the_right_piece_ti_the_right_cordinates_for_white_third_part
		cmp di,1
		je end_draw_the_piece_in_the_color_of_her_squre_to_make_her_disapear_commends
		call darw_the_right_piece_ti_the_right_cordinates_for_white_fourth_part
		cmp di,1
		je end_draw_the_piece_in_the_color_of_her_squre_to_make_her_disapear_commends

		end_draw_the_piece_in_the_color_of_her_squre_to_make_her_disapear_commends:
			ret

	draw_the_in_the_right_location	endp


	; there are 8 function is here and all of them draws the right piece in the right location that were taken from the vars of its 
	; location this functions can be called when the program wants to draw the piece on top of it self to make 
	; it disapear of if the programm wants to draw the piece that moves in its new right location
	; the function are comaring the value of the piece that is moving 
	; i needed more than one function to do it because of limit of how many bytes the programm can jump
	; all of this functions are called by the draw_the_in_the_right_location function to make
	; it one function
	functions_that_draws_the_the_same_piece_one_top_of_it_self_in_a_way_thta_makes_it_disapear:
		darw_the_right_piece_ti_the_right_cordinates_for_black_first_part proc 
			cmp al,1
			je draw_a8_for_the_second_time_to_make_him_disapear
			
			cmp al,2
			je draw_b8_for_the_second_time_to_make_him_disapear
			
			cmp al,3
			je draw_c8_for_the_second_time_to_make_him_disapear
			
			cmp al,4
			je draw_d8_for_the_second_time_to_make_him_disapear

			jmp end_darw_the_right_piece_ti_the_right_cordinates_for_black_first_part
			
			draw_a8_for_the_second_time_to_make_him_disapear:
				mov ax,rock_a8_x				  
				mov first_rock_value_of_x,ax	  ;set reltive value of x to the first value
				mov cx,rock_a8_x				  ;set x cordinates for start
				mov dx,rock_a8_y 				  ;set y cordinates
				mov al,mouse_press_location_color
				call draw_rock
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_black_first_part
				
			draw_b8_for_the_second_time_to_make_him_disapear:
				
				mov ax,knight_b8_x				  
				mov first_knight_value_of_x,ax	  ;set reltive value of x to the first value
				mov cx,knight_b8_x				  ;set x cordinates for start
				mov dx,knight_b8_y 				  ;set y cordinates
				mov al,mouse_press_location_color
				call draw_knight
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_black_first_part
				
			draw_c8_for_the_second_time_to_make_him_disapear:
				
				mov ax,bishop_c8_x				  
				mov first_bishop_value_of_x,ax	  ;set reltive value of x to the first value
				mov cx,bishop_c8_x				  ;set x cordinates for start
				mov dx,bishop_c8_y 				  ;set y cordinates
				mov al,mouse_press_location_color
				call draw_bishop
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_black_first_part
				
			draw_d8_for_the_second_time_to_make_him_disapear:
				
				mov ax,queen_d8_x				  
				mov first_queen_value_of_x,ax	  ;set reltive value of x to the first value
				mov cx,queen_d8_x				  ;set x cordinates for start
				mov dx,queen_d8_y 				  ;set y cordinates
				mov al,mouse_press_location_color
				call draw_queen
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_black_first_part
			
			
			end_darw_the_right_piece_ti_the_right_cordinates_for_black_first_part:
			
			ret
		darw_the_right_piece_ti_the_right_cordinates_for_black_first_part endp

		darw_the_right_piece_ti_the_right_cordinates_for_black_second_part proc 
			
			cmp al,5
			je draw_e8_for_the_second_time_to_make_him_disapear
			
			cmp al,6
			je draw_f8_for_the_second_time_to_make_him_disapear
			
			cmp al,7
			je draw_g8_for_the_second_time_to_make_him_disapear
			
			cmp al,8
			je draw_h8_for_the_second_time_to_make_him_disapear
			
			jmp end_darw_the_right_piece_ti_the_right_cordinates_for_black_second_part 
			
			draw_e8_for_the_second_time_to_make_him_disapear:
				
				mov ax,black_king_x				  
				mov first_king_value_of_x,ax	  ;set reltive value of x to the first value
				mov ax,black_king_y				  
				mov first_king_value_of_y,ax	  ;set reltive value of x to the first value
				mov cx,black_king_x				  ;set x cordinates for start
				mov dx,black_king_y 		      ;set y cordinates
				mov al,mouse_press_location_color
				call draw_king
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_black_second_part
				
			draw_f8_for_the_second_time_to_make_him_disapear:
				
				mov ax,bishop_f8_x				  
				mov first_bishop_value_of_x,ax	  ;set reltive value of x to the first value
				mov cx,bishop_f8_x				  ;set x cordinates for start
				mov dx,bishop_f8_y 				  ;set y cordinates
				mov al,mouse_press_location_color
				call draw_bishop
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_black_second_part
				
			draw_g8_for_the_second_time_to_make_him_disapear:
				
				mov ax,knight_g8_x				  
				mov first_knight_value_of_x,ax	  ;set reltive value of x to the first value
				mov cx,knight_g8_x				  ;set x cordinates for start
				mov dx,knight_g8_y 				  ;set y cordinates
				mov al,mouse_press_location_color
				call draw_knight
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_black_second_part
				
			draw_h8_for_the_second_time_to_make_him_disapear:
				
				mov ax,rock_h8_x				  
				mov first_rock_value_of_x,ax	  ;set reltive value of x to the first value
				mov cx,rock_h8_x				  ;set x cordinates for start
				mov dx,rock_h8_y 				  ;set y cordinates
				mov al,mouse_press_location_color
				call draw_rock
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_black_second_part
			
			
			
			end_darw_the_right_piece_ti_the_right_cordinates_for_black_second_part:
			

			ret
		darw_the_right_piece_ti_the_right_cordinates_for_black_second_part endp

		darw_the_right_piece_ti_the_right_cordinates_for_black_third_part proc 
			
			cmp al,9
			je draw_a7_for_the_second_time_to_make_him_disapear
			
			cmp al,10
			je draw_b7_for_the_second_time_to_make_him_disapear
			
			cmp al,11
			je draw_c7_for_the_second_time_to_make_him_disapear
			
			cmp al,12
			je draw_d7_for_the_second_time_to_make_him_disapear
			
			jmp end_darw_the_right_piece_ti_the_right_cordinates_for_black_third_part
			
			draw_a7_for_the_second_time_to_make_him_disapear:
				
				mov ax,pawn_a7_x				  
				mov cx,pawn_a7_x				  ;set x cordinates for start
				mov dx,pawn_a7_y 				  ;set y cordinates
				mov al,mouse_press_location_color
				call check_what_kind_of_piece_needs_to_be_drawn_if_the_piece_is_pawn
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_black_third_part
				
			draw_b7_for_the_second_time_to_make_him_disapear:
				
				mov ax,pawn_b7_x				  
				mov cx,pawn_b7_x				  ;set x cordinates for start
				mov dx,pawn_b7_y 				  ;set y cordinates
				mov al,mouse_press_location_color
				call check_what_kind_of_piece_needs_to_be_drawn_if_the_piece_is_pawn
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_black_third_part
				
			draw_c7_for_the_second_time_to_make_him_disapear:
				
				mov ax,pawn_c7_x				  
				mov cx,pawn_c7_x				  ;set x cordinates for start
				mov dx,pawn_c7_y 				  ;set y cordinates
				mov al,mouse_press_location_color
				call check_what_kind_of_piece_needs_to_be_drawn_if_the_piece_is_pawn
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_black_third_part
				
			draw_d7_for_the_second_time_to_make_him_disapear:
				
				mov ax,pawn_d7_x				  
				mov cx,pawn_d7_x				  ;set x cordinates for start
				mov dx,pawn_d7_y 				  ;set y cordinates
				mov al,mouse_press_location_color
				call check_what_kind_of_piece_needs_to_be_drawn_if_the_piece_is_pawn
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_black_third_part
			
			
			
			end_darw_the_right_piece_ti_the_right_cordinates_for_black_third_part:
			
			ret
		darw_the_right_piece_ti_the_right_cordinates_for_black_third_part endp

		darw_the_right_piece_ti_the_right_cordinates_for_black_fourth_part proc 
			
			cmp al,13
			je draw_e7_for_the_second_time_to_make_him_disapear
			
			cmp al,14
			je draw_f7_for_the_second_time_to_make_him_disapear
			
			cmp al,15
			je draw_g7_for_the_second_time_to_make_him_disapear
			
			cmp al,16
			je draw_h7_for_the_second_time_to_make_him_disapear
			
			jmp end_darw_the_right_piece_ti_the_right_cordinates_for_black_fourth_part
			
			draw_e7_for_the_second_time_to_make_him_disapear:
				
				mov ax,pawn_e7_x				  
				mov first_pawn_value_of_x,ax	  ;set reltive value of x to the first value
				mov cx,pawn_e7_x				  ;set x cordinates for start
				mov dx,pawn_e7_y 				  ;set y cordinates
				mov al,mouse_press_location_color
				call check_what_kind_of_piece_needs_to_be_drawn_if_the_piece_is_pawn
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_black_fourth_part
				
			draw_f7_for_the_second_time_to_make_him_disapear:
				
				mov ax,pawn_f7_x				  
				mov first_pawn_value_of_x,ax	  ;set reltive value of x to the first value
				mov cx,pawn_f7_x				  ;set x cordinates for start
				mov dx,pawn_f7_y 				  ;set y cordinates
				mov al,mouse_press_location_color
				call check_what_kind_of_piece_needs_to_be_drawn_if_the_piece_is_pawn
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_black_fourth_part
				
			draw_g7_for_the_second_time_to_make_him_disapear:
				
				mov ax,pawn_g7_x				  
				mov first_pawn_value_of_x,ax	  ;set reltive value of x to the first value
				mov cx,pawn_g7_x				  ;set x cordinates for start
				mov dx,pawn_g7_y 				  ;set y cordinates
				mov al,mouse_press_location_color
				call check_what_kind_of_piece_needs_to_be_drawn_if_the_piece_is_pawn
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_black_fourth_part
				
			draw_h7_for_the_second_time_to_make_him_disapear:
				
				mov ax,pawn_h7_x				  
				mov first_pawn_value_of_x,ax	  ;set reltive value of x to the first value
				mov cx,pawn_h7_x				  ;set x cordinates for start
				mov dx,pawn_h7_y 				  ;set y cordinates
				mov al,mouse_press_location_color
				call check_what_kind_of_piece_needs_to_be_drawn_if_the_piece_is_pawn
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_black_fourth_part
			
			
			end_darw_the_right_piece_ti_the_right_cordinates_for_black_fourth_part:
			
			ret
		darw_the_right_piece_ti_the_right_cordinates_for_black_fourth_part endp

		darw_the_right_piece_ti_the_right_cordinates_for_white_first_part proc
			cmp al,25
			je draw_a1_for_the_second_time_to_make_him_disapear
			
			cmp al,26
			je draw_b1_for_the_second_time_to_make_him_disapear
			
			cmp al,27
			je draw_c1_for_the_second_time_to_make_him_disapear
			
			cmp al,28
			je draw_d1_for_the_second_time_to_make_him_disapear
			
			
			jmp end_darw_the_right_piece_ti_the_right_cordinates_for_white_first_part
			
			draw_a1_for_the_second_time_to_make_him_disapear:
				
				mov ax,rock_a1_x				  
				mov first_rock_value_of_x,ax	  ;set reltive value of x to the first value
				mov cx,rock_a1_x				  ;set x cordinates for start
				mov dx,rock_a1_y 				  ;set y cordinates
				mov al,mouse_press_location_color
				call draw_rock
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_white_first_part
				
			draw_b1_for_the_second_time_to_make_him_disapear:
				
				mov ax,knight_b1_x				  
				mov first_knight_value_of_x,ax	  ;set reltive value of x to the first value
				mov cx,knight_b1_x				  ;set x cordinates for start
				mov dx,knight_b1_y 				  ;set y cordinates
				mov al,mouse_press_location_color
				call draw_knight
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_white_first_part
				
			draw_c1_for_the_second_time_to_make_him_disapear:
				
				mov ax,bishop_c1_x				  
				mov first_bishop_value_of_x,ax	  ;set reltive value of x to the first value
				mov cx,bishop_c1_x				  ;set x cordinates for start
				mov dx,bishop_c1_y 				  ;set y cordinates
				mov al,mouse_press_location_color
				call draw_bishop
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_white_first_part
				
			draw_d1_for_the_second_time_to_make_him_disapear:
				
				mov ax,queen_d1_x				  
				mov first_queen_value_of_x,ax	  ;set reltive value of x to the first value
				mov cx,queen_d1_x				  ;set x cordinates for start
				mov dx,queen_d1_y 				  ;set y cordinates
				mov al,mouse_press_location_color
				call draw_queen
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_white_first_part


			end_darw_the_right_piece_ti_the_right_cordinates_for_white_first_part:
				
			
			ret
		darw_the_right_piece_ti_the_right_cordinates_for_white_first_part endp

		darw_the_right_piece_ti_the_right_cordinates_for_white_second_part proc
			
			cmp al,29
			je draw_e1_for_the_second_time_to_make_him_disapear
			
			cmp al,30
			je draw_f1_for_the_second_time_to_make_him_disapear
			
			cmp al,31
			je draw_g1_for_the_second_time_to_make_him_disapear
			
			cmp al,32
			je draw_h1_for_the_second_time_to_make_him_disapear
			
			jmp end_darw_the_right_piece_ti_the_right_cordinates_for_white_second_part
			
			draw_e1_for_the_second_time_to_make_him_disapear:
				
				mov ax,white_king_x				  
				mov first_king_value_of_x,ax	  ;set reltive value of x to the first value
				mov ax,white_king_y				  
				mov first_king_value_of_y,ax	  ;set reltive value of x to the first value
				mov cx,white_king_x				  ;set x cordinates for start
				mov dx,white_king_y 		      ;set y cordinates
				mov al,mouse_press_location_color
				call draw_king
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_white_second_part
				
			draw_f1_for_the_second_time_to_make_him_disapear:
				
				mov ax,bishop_f1_x				  
				mov first_bishop_value_of_x,ax	  ;set reltive value of x to the first value
				mov cx,bishop_f1_x				  ;set x cordinates for start
				mov dx,bishop_f1_y 				  ;set y cordinates
				mov al,mouse_press_location_color
				call draw_bishop
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_white_second_part
				
			draw_g1_for_the_second_time_to_make_him_disapear:
				
				mov ax,knight_g1_x				  
				mov first_knight_value_of_x,ax	  ;set reltive value of x to the first value
				mov cx,knight_g1_x				  ;set x cordinates for start
				mov dx,knight_g1_y 				  ;set y cordinates
				mov al,mouse_press_location_color
				call draw_knight
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_white_second_part
				
			draw_h1_for_the_second_time_to_make_him_disapear:
				
				mov ax,rock_h1_x				  
				mov first_rock_value_of_x,ax	  ;set reltive value of x to the first value
				mov cx,rock_h1_x				  ;set x cordinates for start
				mov dx,rock_h1_y 				  ;set y cordinates
				mov al,mouse_press_location_color
				call draw_rock
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_white_second_part
			
			
			end_darw_the_right_piece_ti_the_right_cordinates_for_white_second_part:
				
			
			ret
		darw_the_right_piece_ti_the_right_cordinates_for_white_second_part endp

		darw_the_right_piece_ti_the_right_cordinates_for_white_third_part proc
			cmp al,17
			je draw_a2_for_the_second_time_to_make_him_disapear
			
			cmp al,18
			je draw_b2_for_the_second_time_to_make_him_disapear
			
			cmp al,19
			je draw_c2_for_the_second_time_to_make_him_disapear
			
			cmp al,20
			je draw_d2_for_the_second_time_to_make_him_disapear
			
			jmp end_darw_the_right_piece_ti_the_right_cordinates_for_white_third_part
			
			draw_a2_for_the_second_time_to_make_him_disapear:
				mov ax,pawn_a2_x				  
				mov cx,pawn_a2_x				  ;set x cordinates for start
				mov dx,pawn_a2_y 				  ;set y cordinates
				call check_what_kind_of_piece_needs_to_be_drawn_if_the_piece_is_pawn
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_white_third_part
				
			draw_b2_for_the_second_time_to_make_him_disapear:
				
				mov ax,pawn_b2_x				  
				mov cx,pawn_b2_x				  ;set x cordinates for start
				mov dx,pawn_b2_y 				  ;set y cordinates
				mov al,mouse_press_location_color
				call check_what_kind_of_piece_needs_to_be_drawn_if_the_piece_is_pawn
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_white_third_part
				
			draw_c2_for_the_second_time_to_make_him_disapear:
				
				mov ax,pawn_c2_x				  
				mov cx,pawn_c2_x				  ;set x cordinates for start
				mov dx,pawn_c2_y 				  ;set y cordinates
				mov al,mouse_press_location_color
				call check_what_kind_of_piece_needs_to_be_drawn_if_the_piece_is_pawn
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_white_third_part
				
			draw_d2_for_the_second_time_to_make_him_disapear:
				
				mov ax,pawn_d2_x				  
				mov cx,pawn_d2_x				  ;set x cordinates for start
				mov dx,pawn_d2_y 				  ;set y cordinates
				mov al,mouse_press_location_color
				call check_what_kind_of_piece_needs_to_be_drawn_if_the_piece_is_pawn
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_white_third_part
			
			
			end_darw_the_right_piece_ti_the_right_cordinates_for_white_third_part:
				
			
			ret
		darw_the_right_piece_ti_the_right_cordinates_for_white_third_part endp

		darw_the_right_piece_ti_the_right_cordinates_for_white_fourth_part proc
			
			cmp al,21
			je draw_e2_for_the_second_time_to_make_him_disapear
			
			cmp al,22
			je draw_f2_for_the_second_time_to_make_him_disapear
			
			cmp al,23
			je draw_g2_for_the_second_time_to_make_him_disapear
			
			cmp al,24
			je draw_h2_for_the_second_time_to_make_him_disapear
			
			jmp end_darw_the_right_piece_ti_the_right_cordinates_for_white_fourth_part
			
			draw_e2_for_the_second_time_to_make_him_disapear:
				
				mov ax,pawn_e2_x				  
				mov cx,pawn_e2_x				  ;set x cordinates for start
				mov dx,pawn_e2_y 				  ;set y cordinates
				mov al,mouse_press_location_color
				call check_what_kind_of_piece_needs_to_be_drawn_if_the_piece_is_pawn
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_white_fourth_part
				
			draw_f2_for_the_second_time_to_make_him_disapear:
				
				mov ax,pawn_f2_x				  
				mov cx,pawn_f2_x				  ;set x cordinates for start
				mov dx,pawn_f2_y 				  ;set y cordinates
				mov al,mouse_press_location_color
				call check_what_kind_of_piece_needs_to_be_drawn_if_the_piece_is_pawn
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_white_fourth_part
				
				
			draw_g2_for_the_second_time_to_make_him_disapear:
				
				mov ax,pawn_g2_x				  
				mov cx,pawn_g2_x				  ;set x cordinates for start
				mov dx,pawn_g2_y 				  ;set y cordinates
				mov al,mouse_press_location_color
				call check_what_kind_of_piece_needs_to_be_drawn_if_the_piece_is_pawn
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_white_fourth_part
				
			draw_h2_for_the_second_time_to_make_him_disapear:
			
				mov ax,pawn_h2_x				  
				mov cx,pawn_h2_x				  ;set x cordinates for start
				mov dx,pawn_h2_y 				  ;set y cordinates
				mov al,mouse_press_location_color
				call check_what_kind_of_piece_needs_to_be_drawn_if_the_piece_is_pawn
				mov di,1
				jmp end_darw_the_right_piece_ti_the_right_cordinates_for_white_fourth_part
				
				
			end_darw_the_right_piece_ti_the_right_cordinates_for_white_fourth_part:
				
			
			ret
		darw_the_right_piece_ti_the_right_cordinates_for_white_fourth_part endp
	endp


	; this function is checking what color square is the number that in the (al register)
	; the funtion workes in a very primitive and inefficient way but the time it takes to
	; code in this way is very fast so i preferred coding it this way
	; (1 - 64 are the numbers that represent the squares on the board)
	check_if_the_squre_that_was_pressed_is_light_or_dark_proc proc
		;this proc is getting the mouse press location and caluclates if it is dark squre or light squre and puts the color in the variable mouse_press_location_color
		cmp al,1
		je mov_the_first_squre_color_to_light
		cmp al,2
		je mov_the_first_squre_color_to_dark
		cmp al,3
		je mov_the_first_squre_color_to_light
		cmp al,4
		je mov_the_first_squre_color_to_dark
		cmp al,5
		je mov_the_first_squre_color_to_light
		cmp al,6
		je mov_the_first_squre_color_to_dark
		cmp al,7
		je mov_the_first_squre_color_to_light
		cmp al,8
		je mov_the_first_squre_color_to_dark
		cmp al,9
		je mov_the_first_squre_color_to_dark
		cmp al,10
		je mov_the_first_squre_color_to_light
		cmp al,11
		je mov_the_first_squre_color_to_dark
		cmp al,12
		je mov_the_first_squre_color_to_light
		cmp al,13
		je mov_the_first_squre_color_to_dark
		cmp al,14
		je mov_the_first_squre_color_to_light
		cmp al,15
		je mov_the_first_squre_color_to_dark
		cmp al,16
		je mov_the_first_squre_color_to_light
		cmp al,17
		je mov_the_first_squre_color_to_light
		cmp al,18
		je mov_the_first_squre_color_to_dark
		cmp al,19
		je mov_the_first_squre_color_to_light
		cmp al,20
		je mov_the_first_squre_color_to_dark
		cmp al,21
		je mov_the_first_squre_color_to_light
		cmp al,22
		je mov_the_first_squre_color_to_dark
		cmp al,23
		je mov_the_first_squre_color_to_light
		cmp al,24
		je mov_the_first_squre_color_to_dark
		cmp al,25
		je mov_the_first_squre_color_to_dark
		cmp al,26
		je mov_the_first_squre_color_to_light
		cmp al,27
		je mov_the_first_squre_color_to_dark
		cmp al,28
		je mov_the_first_squre_color_to_light
		cmp al,29
		je mov_the_first_squre_color_to_dark
		
		jmp continue_to_mov_the_first_squre_color_to_light_or_dark_second_part
		
		mov_the_first_squre_color_to_light:
			mov mouse_press_location_color,07h
			jmp end_check_if_the_squre_is_light_or_dark
			
		mov_the_first_squre_color_to_dark:
			mov mouse_press_location_color,08h
			jmp end_check_if_the_squre_is_light_or_dark
		
		
		continue_to_mov_the_first_squre_color_to_light_or_dark_second_part:
		
		cmp al,30
		je mov_the_first_squre_color_to_light
		cmp al,31
		je mov_the_first_squre_color_to_dark
		cmp al,32
		je mov_the_first_squre_color_to_light
		cmp al,33
		je mov_the_first_squre_color_to_light_second_part
		cmp al,34
		je mov_the_first_squre_color_to_dark_second_part
		cmp al,35
		je mov_the_first_squre_color_to_light_second_part
		cmp al,36
		je mov_the_first_squre_color_to_dark_second_part
		cmp al,37
		je mov_the_first_squre_color_to_light_second_part
		cmp al,38
		je mov_the_first_squre_color_to_dark_second_part
		cmp al,39
		je mov_the_first_squre_color_to_light_second_part
		cmp al,40
		je mov_the_first_squre_color_to_dark_second_part
		cmp al,41
		je mov_the_first_squre_color_to_dark_second_part
		cmp al,42
		je mov_the_first_squre_color_to_light_second_part
		cmp al,43
		je mov_the_first_squre_color_to_dark_second_part
		cmp al,44
		je mov_the_first_squre_color_to_light_second_part
		cmp al,45
		je mov_the_first_squre_color_to_dark_second_part
		cmp al,46
		je mov_the_first_squre_color_to_light_second_part
		cmp al,47
		je mov_the_first_squre_color_to_dark_second_part
		cmp al,48
		je mov_the_first_squre_color_to_light_second_part
		cmp al,49
		je mov_the_first_squre_color_to_light_second_part
		cmp al,50
		je mov_the_first_squre_color_to_dark_second_part
		cmp al,51
		je mov_the_first_squre_color_to_light_second_part
		cmp al,52
		je mov_the_first_squre_color_to_dark_second_part
		cmp al,53
		je mov_the_first_squre_color_to_light_second_part
		cmp al,54
		je mov_the_first_squre_color_to_dark_second_part
		cmp al,55
		je mov_the_first_squre_color_to_light_second_part
		cmp al,56
		je mov_the_first_squre_color_to_dark_second_part
		cmp al,57
		je mov_the_first_squre_color_to_dark_second_part
		cmp al,58
		je mov_the_first_squre_color_to_light_second_part
		cmp al,59
		je mov_the_first_squre_color_to_dark_second_part
		
		jmp continue2_to_mov_the_first_squre_color_to_light_or_dark_second_part
		
		mov_the_first_squre_color_to_light_second_part:
			mov mouse_press_location_color,07h
			jmp end_check_if_the_squre_is_light_or_dark
			
		mov_the_first_squre_color_to_dark_second_part:
			mov mouse_press_location_color,08h
			jmp end_check_if_the_squre_is_light_or_dark
		
		continue2_to_mov_the_first_squre_color_to_light_or_dark_second_part:
		
		cmp al,60
		je mov_the_first_squre_color_to_light_second_part
		cmp al,61
		je mov_the_first_squre_color_to_dark_second_part
		cmp al,62
		je mov_the_first_squre_color_to_light_second_part
		cmp al,63
		je mov_the_first_squre_color_to_dark_second_part
		cmp al,64
		je mov_the_first_squre_color_to_light_second_part
		
		end_check_if_the_squre_is_light_or_dark:

		ret
	check_if_the_squre_that_was_pressed_is_light_or_dark_proc endp	


	; this function is changing the cordinates of the piece that moves to its new cordinates where
	; the piece supose to stand
	change_the_cordinates_of_the_piece proc
		;all of this getting the right y to right_y:
		mov ax,0
		mov al, second_mouse_press_location			;get the loaction of the second press
		mov bl, 8									
		div bl										;(al - have the row, ah - have the coulmn)

		lea di, array_of_each_spot_y				;get the di to have the array of the y of each line
		mov cx,0									
		mov cl, al									;get the ah the coulmn to cx
		
		; incase this is the last row we want to remove one
		cmp ah,0
		je remove_one_number_from_the_cl_for_the_x_of_the_last_row
		jmp after_remove_one_number_from_the_cl_for_the_x_of_the_last_row

		remove_one_number_from_the_cl_for_the_x_of_the_last_row:
			dec cl

		after_remove_one_number_from_the_cl_for_the_x_of_the_last_row:
			add di, cx									;get the right y for the the first piece that was pressed
			add di, cx 									;because this is a dw
			mov dx, [di]								;puts this y in dx
			mov right_y, dx
			mov dx, 0

			;get the right y from the the right_y:
			mov ax, 0									;reset the ax
			mov al, firts_mouse_press_location_piece	;get the al to have the number that evry the first piece that was pressed repersent 
			
			lea si, array_of_each_piece_y				;get the array of the y of evry piece to be pointed by the si	
			add si, ax									;get the array of ax to be in the loaction of first piece y
			add si, ax									;the second type is beacuse this array is dw
			sub si, 2										;than dec by 1 because the array is starting with zero

			mov di, [si] 
			mov dx, right_y				
			mov [di], dx								;gets this y that is in dx into the y of the piece that i want to move 

		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;this part is for the x

		;all of this getting the right x to right_x:
		mov ax,0
		mov al, second_mouse_press_location			;get the loaction of the second press
		mov bl, 8									
		div bl										;(al - have the row, ah - have the coulmn)

		lea di, array_of_each_spot_x				;get the di to have the array of the x of each line
		mov cx,0									
		mov cl, ah									;get the ah the coulmn to cx
		dec cl
		;incase this is the final row
		cmp cl, -1
		jne dont_set_to_seven_because_not_final_row
		mov cl,7

		dont_set_to_seven_because_not_final_row:
			add di, cx									;get the right x for the the first piece that was pressed
			add di, cx 									;because this is a dw
			mov dx, [di]								;puts this x in dx
			mov right_x, dx
			mov dx, 0

			;get the right x from the the right_x:
			mov ax, 0									;reset the ax
			mov al, firts_mouse_press_location_piece	;get the al to have the number that evry the first piece that was pressed repersent 
			
			lea si, array_of_each_piece_x				;get the array of the x of evry piece to be pointed by the si	
			add si, ax									;get the array of ax to be in the loaction of first piece x
			add si, ax									;the second type is beacuse this array is dw
			sub si, 2										;than dec by 1 because the array is starting with zero

			mov di, [si] 
			mov dx, right_x				
			mov [di], dx								;gets this x that is in dx into the x of the piece that i want to move 

		ret 
	change_the_cordinates_of_the_piece endp 
endp


; this function is making the the pieces that i cliked to disapear and draws the piece that supposed to move
; in the location that it needs to move to after chaning the cordinates the function does it only if the move is legal 
do_everything_related_to_moving_a_piece proc
	;prosses to get the si to point to the place of the first mouse press and than to put nothing in this place and save 
	;what was in this place (firts_mouse_press_location_piece has the number that indicates the type of the piece)
	mov si,0
	mov ax,0								;reset ax 
	mov al,firts_mouse_press_location		;mov the firs press location to al
	lea si,where_is_each_piece			;set the si to point on this array
	add si,ax		;get to the place of the first mouse press
	dec si
	mov al,[si]
	mov firts_mouse_press_location_piece,al
	;this part is checking if the move should acour or not:
	

	mov al,0
	mov [si],al
	
	;prosses to get the si to point to the place of the second mouse press and than to put the first press in this spot
	mov si,0
	mov ax,0								;reset ax 
	mov al,second_mouse_press_location	;mov the first press location to al
	lea si,where_is_each_piece			;set the si to point on this array
	add si,ax		;get to the place of the first mouse press
	dec si
	mov al,[si]
	mov second_mouse_press_location_piece,al
	mov al,firts_mouse_press_location_piece
	mov [si],al
	
	mov ax,0
	mov al,firts_mouse_press_location_piece
	
	
	cmp al,0
	jne update_the_location_of_the_pices
	
	
	jmp end_do_everything_related_to_moving_a_piece
	
	update_the_location_of_the_pices:
		the_first_part_of_moving_the_piece:
			;checks the color of the first mouse press location and put in the var mouse_press_location_color
			mov mouse_press_location_color,0
			mov ax,0						  ;reset the ax register 
			mov al,firts_mouse_press_location
			call check_if_the_squre_that_was_pressed_is_light_or_dark_proc
			mov bx,0
			mov bl, firts_mouse_press_location_piece
			;remove the piece from her old place
			mov ax,0
			mov al,firts_mouse_press_location_piece
			call draw_the_in_the_right_location
		
		the_second_part_of_moving_piece:
			mov bx,0
			mov bl, second_mouse_press_location_piece
			;checks the color of the second mouse press location and put in the var mouse_press_location_color
			mov mouse_press_location_color,0
			mov ax,0						  ;reset the ax register 
			mov al,second_mouse_press_location
			call check_if_the_squre_that_was_pressed_is_light_or_dark_proc

			;remove the place that the piece that standing in the place that the new pice is going to:
			mov ax,0
			mov al,second_mouse_press_location_piece
			call draw_the_in_the_right_location
			
		the_third_part_of_moving_piece:
			call change_the_cordinates_of_the_piece
			mov mouse_press_location_color,00h
			cmp firts_mouse_press_location_piece,17
			jl the_piece_is_black_already_so_no_need_to_change_to_white
			mov mouse_press_location_color,0fh

			the_piece_is_black_already_so_no_need_to_change_to_white:	
				call check_if_the_pawn_needs_to_be_queen
				mov bx,0
				mov bl, firts_mouse_press_location_piece				
				mov al,firts_mouse_press_location_piece
				call draw_the_in_the_right_location 
			
	end_do_everything_related_to_moving_a_piece:
		ret
do_everything_related_to_moving_a_piece endp


legalty_section:
	; this function is using the array of legal moves that i create in the process of checking what legal 
	; moves are allowed to be played for a specific piece that the user clicked to draw all of the legal moves 
	; arouned the squares that the piece can move in the color turquoise and this function is called again after the user 
	; made the move to make the squares disapear
	print_all_the_squres_that_are_legal proc 
		mov bl,0
		lea di, array_of_legal_moves_for_all_off_the_picess
		mov counter1,0

		; loop over the array of legal moves and call the function that draws the turquoise square if the move is legal
		; and check if this the time to make the square disapear or the time the draw
		loop_that_prints_the_legal_squars_for_the_knight:
			; check if the move is legal
			cmp [di],bl
			je dont_call_the_proc_that_prints_the_squars

			; get the var ( legal_location_that_needs_to_be_printed ) to have the number repesention of
			; the square that needs to be changed
			mov al, counter1
			inc al
			mov legal_location_that_needs_to_be_printed,al
			
			; check if this time the function was called because it the squares should 
			; disapear and jumps if this not this time
			cmp the_disapear_part_the_mkaing_the_drawing_of_the_legal_moves, 1
			jne this_is_not_the_time_that_makes_it_disapear

			; if this is the time to make the square disapear than checks what is the color of the spesific 
			; square to make the turquoise square disapear
			call check_if_the_squre_that_was_pressed_is_light_or_dark_proc
			mov al,mouse_press_location_color
			mov the_color_of_the_lgal_moves_squres_that_show_up,al

			this_is_not_the_time_that_makes_it_disapear:
				; printing the square
				push bx
				call print_square_around_the_legal_moves
				pop bx
		
			dont_call_the_proc_that_prints_the_squars:
				inc di
				inc counter1
				cmp counter1,64
				jne loop_that_prints_the_legal_squars_for_the_knight

		
		ret 
	print_all_the_squres_that_are_legal endp


	; this function is getting the numbers that represent the locations that the user pressed on 
	; and than checks what pieces stand in there and puts this pieces in the right vars
	get_the_pieces_that_were_pressed_to_the_right_vars proc
		mov si,0
		mov ax,0								;reset ax 
		mov al,firts_mouse_press_location		;mov the first press location to al
		lea si,where_is_each_piece			;set the si to point on this array
		add si,ax		;get to the place of the first mouse press
		dec si
		mov al,[si]
		mov firts_mouse_press_location_piece,al

		mov si,0
		mov ax,0								;reset ax 
		mov al,second_mouse_press_location	;mov the first press location to al
		lea si,where_is_each_piece			;set the si to point on this array
		add si,ax		;get to the place of the first mouse press
		dec si
		mov al,[si]
		mov second_mouse_press_location_piece,al

		ret
	get_the_pieces_that_were_pressed_to_the_right_vars endp


	; this function is getting an array of legal moves for the piece that the user to press and the 
	; var that represent if the move is legal based on more criterions ( this var name is the_move_is_legal)
	; and than the funtion is checking if the move that the user wanted to make is legal or not 
	; if the function final decision that the move is legal than the funtion is also changing a var that is called
	; (black_or_white_turn) that says if turn belongs to white or black to the oposite value because the turn is changing 
	; also its checks if the the king, rock or pawn and if update the array of pieces that move to each piece 
	; ( pawn - array_of_pawn_states, rock - array_of_rocks_taht_are_abel_to_castle, king - array_of_kings_that_are_abel_to_castle )
	check_if_the_move_is_leagal proc
		mov cl,1
		cmp the_move_is_legal, 0
		je end_check_if_the_move_is_leagal

		; check if the second mouse press location is to a legal place and if it is not the function is changing the val 
		; of the var ( the_move_is_legal ) to zero
		lea si, array_of_legal_moves_for_all_off_the_picess 
		mov ax,0
		mov al,second_mouse_press_location
		add si,ax
		dec si
		cmp [si],cl
		je end_check_if_the_move_is_leagal
		
		mov the_move_is_legal, 0

		end_check_if_the_move_is_leagal:
		;this part is checking if the move turned legal or ilegal and if the move is legal this part is changing the who's turn it is
			cmp the_move_is_legal, 0
			je end_the_end_of_check_if_the_move_is_leagal	;if the is iligal than jumping to the end
			
			cmp black_or_white_turn,0
			je change_from_white_to_black
			jmp change_the_turn_from_black_to_white

			change_the_turn_from_black_to_white:
				mov black_or_white_turn, 0
				jmp end_the_end_of_check_if_the_move_is_leagal
			
			change_from_white_to_black:
				mov black_or_white_turn, 1
		
		end_the_end_of_check_if_the_move_is_leagal:
			; check if the move is ilegal and stop the function if it is not
			cmp the_move_is_legal,0
			jne things_that_needs_to_be_changed_if_the_move_is_legal
			ret
		
		things_that_needs_to_be_changed_if_the_move_is_legal:
			; if the move is legal than change the array of the pieces that moved if the piece that moves has an array like that 
			; also if the move is castling the function moves the rock to the right place
			call move_the_rock_if_the_king_castle
			call update_the_array_of_rocks_that_moved
			call update_the_array_of_kings_that_moved
			mov al, firts_mouse_press_location_piece
			mov bl,8
			cmp al,bl
			jg second_check_if_the_piece_that_is_moving_is_knight
			ret 

			second_check_if_the_piece_that_is_moving_is_knight:
				mov bl,25
				cmp al,bl
				jl the_piece_that_going_to_move_is_pawn
				ret

			the_piece_that_going_to_move_is_pawn:
				mov ax,0
				mov al, firts_mouse_press_location_piece
				sub al, 9
				add di, ax
				mov bl,0
				mov [di], bl
				ret
			

	check_if_the_move_is_leagal endp


	; this function is checking what leagal moves can the first piece that user pressed can go to 
	; and puts this moves into the array of legal spots that the piece can go to (this array is called array_of_legal_moves_for_all_off_the_picess )
	check_what_leagal_moves_there_are_for_this_piece proc
		call get_the_pieces_that_were_pressed_to_the_right_vars
		mov the_move_is_legal, 1				;first i will turn the flag of the_move_is_legal

		; checking if the function was called because of the king moves checking and if it is than skips all of this 
		; legalty thing 
		mov al,1
		cmp when_chking_squares_controlled_dont_do_certain_code,1
		je the_move_is_legal_so_far
	
		; this part is checking wather the the right color piece was played
		cmp black_or_white_turn, 0				
		je check_if_the_piece_is_white			;if the flag of the trun is white checking if the first that was pressed is white
		jmp check_if_the_piece_is_black			;if the flag of the trun is black checking if the first that was pressed is black


		check_if_the_piece_is_white:
			cmp firts_mouse_press_location_piece, 16
			jg end_checking_black_or_white_turn	;if the the piece that was pressed is white ending the part of checking if the piece that was pressed is white or black

			mov the_move_is_legal, 0				;the piece that was pressed is black than the move is legal flag trunnig of
			jmp dont_check_checks

		check_if_the_piece_is_black:
			cmp firts_mouse_press_location_piece, 17	
			jl end_checking_black_or_white_turn				;if the the piece that was pressed is black ending the part of checking if the piece that was pressed is white or black

			mov the_move_is_legal, 0					;the piece that was pressed is black than the move is legal flag trunnig of
			jmp dont_check_checks

		end_checking_black_or_white_turn:
			; check if the king is in check and checks if the checks is a double check if it is only the king can move
			cmp when_chking_squares_controlled_dont_do_certain_code,0
			jne dont_check_checks 
			call check_if_king_is_in_check

			mov al,1
			cmp king_is_in_check_flag,al
			jne dont_check_checks
		
			mov king_is_in_check_flag,0
			ret

			dont_check_checks:
				cmp the_move_is_legal,0
				jne the_move_is_legal_so_far
				ret

		the_move_is_legal_so_far:
		
		; checking the type of the piece that was pressed
		cmp firts_mouse_press_location_piece, 1
		je check_if_move_is_legal_for_rock

		cmp firts_mouse_press_location_piece, 2
		je check_if_the_move_is_legal_for_knight

		cmp firts_mouse_press_location_piece, 3
		je check_if_move_is_legal_for_bishop

		cmp firts_mouse_press_location_piece, 4
		je check_if_move_legal_for_queen

		cmp firts_mouse_press_location_piece, 5
		je check_if_move_legal_for_king

		cmp firts_mouse_press_location_piece, 6
		je check_if_move_is_legal_for_bishop

		cmp firts_mouse_press_location_piece, 7
		je check_if_the_move_is_legal_for_knight

		cmp firts_mouse_press_location_piece, 8
		je check_if_move_is_legal_for_rock

		cmp firts_mouse_press_location_piece, 25
		je check_if_move_is_legal_for_rock

		cmp firts_mouse_press_location_piece, 26
		je check_if_the_move_is_legal_for_knight

		cmp firts_mouse_press_location_piece, 27
		je check_if_move_is_legal_for_bishop

		cmp firts_mouse_press_location_piece, 28
		je check_if_move_legal_for_queen

		cmp firts_mouse_press_location_piece, 29
		je check_if_move_legal_for_king

		cmp firts_mouse_press_location_piece, 30
		je check_if_move_is_legal_for_bishop

		cmp firts_mouse_press_location_piece, 31
		je check_if_the_move_is_legal_for_knight

		cmp firts_mouse_press_location_piece, 32
		je check_if_move_is_legal_for_rock

		cmp firts_mouse_press_location_piece, 0
		je end_checking_if_the_moves_are_legal_with_the_movement_of_the_piece

		cmp firts_mouse_press_location_piece,25
		jl check_if_the_move_is_legal_for_pawn
		
		; check what is the legal moves for the piece that was pressed
		check_if_move_is_legal_for_rock:
			call check_if_the_mov_is_leagal_for_the_rock
			jmp end_checking_if_the_moves_are_legal_with_the_movement_of_the_piece

		check_if_the_move_is_legal_for_knight:
			call check_if_moves_legal_for_knight
			jmp end_checking_if_the_moves_are_legal_with_the_movement_of_the_piece

		check_if_move_is_legal_for_bishop:
			call check_if_the_mov_is_leagal_for_the_bishop
			jmp end_checking_if_the_moves_are_legal_with_the_movement_of_the_piece

		check_if_move_legal_for_king:
			call check_if_the_mov_is_leagal_for_the_king
			jmp end_checking_if_the_moves_are_legal_with_the_movement_of_the_piece

		check_if_move_legal_for_queen:
			call check_if_the_mov_is_leagal_for_the_rock
			call check_if_the_mov_is_leagal_for_the_bishop
			jmp end_checking_if_the_moves_are_legal_with_the_movement_of_the_piece
		
		check_if_the_move_is_legal_for_pawn:
			; the pawn can be premoted to another piece so i needed to check if the pawn is still a pawn or if 
			; it beacame another piece it can become the pieces: ( queen, rock, bishop or knight ):
		
			lea si,array_of_pawn_states 
			mov bx,0
			mov bl,firts_mouse_press_location_piece
			sub bl,9
			add si,bx

			mov bl,5
			cmp [si],bl
			je check_if_move_legal_for_queen

			mov bl,4
			cmp [si],bl
			je check_if_move_is_legal_for_rock

			mov bl,3
			cmp [si],bl
			je check_if_move_is_legal_for_bishop

			mov bl,2
			cmp [si],bl
			je check_if_the_move_is_legal_for_knight

			; when calculating the squares that the pawn controls we dont need the moves of the pawn but the plcaes 
			; to the side of the pawn:
			cmp when_chking_squares_controlled_dont_do_certain_code,1
			je only_checking_the_squares_that_the_pawn_controls
 
			call change_if_move_is_legal_for_the_pawn
			jmp end_checking_if_the_moves_are_legal_with_the_movement_of_the_piece
			
			only_checking_the_squares_that_the_pawn_controls:
				; if king function is the one calling this function than giveing the squares to the side of the pawn
				call make_the_pawn_tobe_abel_eat_other_pieces_to_the_side
				call check_if_the_pawn_checking_and_if_it_is_update_the_array_of_pawns_check_direcion

		end_checking_if_the_moves_are_legal_with_the_movement_of_the_piece:
			; check if the king is the one that called the function and if it is than skip the removel of the squares that has the same color piece as yours 
			; because this are still plcaes you control
			cmp when_chking_squares_controlled_dont_do_certain_code,1
			je dont_need_to_check_beacuse_calculating_pieces_controled
		
			; block the places that has the your own side pieces in them
			call change_the_aaray_of_legal_moves_in_a_way_that_blocks_moves_if_there_same_color_piece_in_that_square
		
			dont_need_to_check_beacuse_calculating_pieces_controled: 
				cmp the_move_is_legal,0
				je end_check_what_leagal_moves_there_are_for_this_piece
		
		mov the_disapear_part_the_mkaing_the_drawing_of_the_legal_moves,0
		mov the_color_of_the_lgal_moves_squres_that_show_up, 03

		end_check_what_leagal_moves_there_are_for_this_piece:
			; if the king is in normal check and not double check than search for moves that
			; remove the moves that dont block the check and if the king not in check than skip 
			; this part
			mov al,0
			cmp al,check_for_moves_that_block_the_check
			je dont_search_for_moves_that_block_the_check

			mov al,1
			cmp when_chking_squares_controlled_dont_do_certain_code,al
			je dont_search_for_moves_that_block_the_check

			call check_is_this_piece_moves_block_the_check

			dont_search_for_moves_that_block_the_check:
				ret	
	check_what_leagal_moves_there_are_for_this_piece endp


	; this function is using the var that is called ( firts_mouse_press_location_piece ) and checking if the first piece that the user pressed on is
	; white or black and puts it in the var that's name is ( first_piece_pressed_color )
	; the black color is represnted by the number 0, and the white color is reprsented by the number 1
	check_what_colored_piece_was_pressed proc
		mov first_piece_pressed_color, 0
		mov al, firts_mouse_press_location_piece
		cmp al, 17
		jl the_piece_is_not_white
		mov first_piece_pressed_color,1

		the_piece_is_not_white:
			ret

	check_what_colored_piece_was_pressed endp


	; this function is changing the array of legal spots the first piece can go to by deleting the spots that have the the same color piece as 
	; the piece that the user wants to move
	change_the_aaray_of_legal_moves_in_a_way_that_blocks_moves_if_there_same_color_piece_in_that_square proc
		call check_what_colored_piece_was_pressed
		mov al,0
		mov bh,16
		mov counter1,0
		lea si, array_of_legal_moves_for_all_off_the_picess
		lea di, where_is_each_piece

		; loop to through all of the squares that piece can go to and check for each spot if there is 
		; the same color piece standing there if thre is than block the move 
		loop_that_turnes_off_moves_that_have_the_same_colored_piece_in_it:
			cmp first_piece_pressed_color,1
			je the_white_piece_check_that_check_if_the_same_colored_piece
			
			the_black_piece_check_that_check_if_the_same_colored_piece:
				mov bh,16
				cmp [di],al
				je end_to_the_if_the_same_colored_piece
				cmp [di],bh
				jg end_to_the_if_the_same_colored_piece
				mov al,0
				mov [si],al
				jmp end_to_the_if_the_same_colored_piece

			the_white_piece_check_that_check_if_the_same_colored_piece:
				mov bh,16
				cmp [di],bh
				jng end_to_the_if_the_same_colored_piece
				mov al,0
				mov [si],al
				jmp end_to_the_if_the_same_colored_piece

			end_to_the_if_the_same_colored_piece:
				inc di
				inc si
				inc counter1
				cmp counter1,64
				jne loop_that_turnes_off_moves_that_have_the_same_colored_piece_in_it

		ret
	change_the_aaray_of_legal_moves_in_a_way_that_blocks_moves_if_there_same_color_piece_in_that_square endp


	; this function is resting the array of legal moves that is called ( array_of_legal_moves_for_all_off_the_picess ) 
	; and puting a zero at each index of the array
	reset_the_array_of_legal_moves proc
		mov dh,0
		lea di, array_of_legal_moves_for_all_off_the_picess
		mov counter1dw,0

		loop_to_get_the_array_of_legal_moves_for_all_off_the_picess_spots_ilegal:
			lea di, array_of_legal_moves_for_all_off_the_picess
			add di, counter1dw
			mov [di],dh
			inc counter1dw
			cmp counter1dw,64
			jne loop_to_get_the_array_of_legal_moves_for_all_off_the_picess_spots_ilegal
		
		mov di,0
		ret 
	reset_the_array_of_legal_moves endp

	; this function is getting the array address in the bx and reset a db array with 64 squares in it 
	reset_the_array_in_the_bx proc
		mov counter1, 0
		
		loop_toresret_the_array:
			inc counter1
			mov al,0
			mov [bx],al
			inc bx
			cmp counter1,64
			jne loop_toresret_the_array
		ret
	reset_the_array_in_the_bx endp

endp


knight_moves_section:
	; this function is using the array of that's called ( array_of_flags_for_checks_of_knight_moves ) 
	; and changing this array idexes of what moves can be for the knight this array is needed because 
	; for example if the knight in the corner going 6 squres forward its ilegal but in the midle going forward 6 steps 
	; is legal ( almost half of the spots are working like this example so this function is very important)
	change_the_array_of_the_legal_options_for_the_knight proc
		call make_the_arryay_of_the_knight_moves_to_be_zero_at_each_index ; reset the array

		; evry single one if this are very spesific and based on the square that knight stands i check what the legal move that 
		; that the knight can go to
		;{-17,-15,-10,-6,+6,+10,+15,+17}
		mov dl,1
		mov ax,0
		mov al,firts_mouse_press_location
		lea si, array_of_flags_for_checks_of_knight_moves
		
		mov cl,1
		cmp al,cl
		jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_1

		add si,5
		mov [si] ,dl 		;+10 flag
		add si, 2
		mov [si],dl			;+17 flag
		lea si, array_of_flags_for_checks_of_knight_moves
		ret 

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_1:
			mov cl,2
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_2

		mov [si + 5],dl 	;+10 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_2:
			mov cl,3
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_3

		mov [si + 4],dl		;+6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_3:
			mov cl,4
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_4

		mov [si + 4],dl		;+6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_4:
			mov cl,5
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_5

		mov [si + 4],dl		;+6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_5:
			mov cl,6
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_6

		mov [si + 4],dl		;+6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 6],dl		;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_6:
			mov cl,7
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_7

		mov [si + 4],dl		;+6 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_7:
		mov cl,8
		cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_8

		mov [si + 4],dl		;+6 flag
		mov [si + 6],dl 	;+15 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_8:
			mov cl,9
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_9

		mov [si + 3],dl 	;-6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_9:	
			mov cl,10
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_10

		mov [si + 3],dl 	;-6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_10:
			mov cl,11
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_11

		mov [si + 2],dl  	;-10 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_11:
			mov cl,12
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_12

		mov [si + 2],dl  	;-10 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_12:
			mov cl,13
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_13

		mov [si + 2],dl  	;-10 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_13:		
			mov cl,14
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_14

		mov [si + 2],dl  	;-10 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_14:
			mov cl,15
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_15

		mov [si + 2],dl  	;-10 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_15:
			mov cl,16
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_16

		mov [si + 2],dl  	;-10 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 6],dl 	;+15 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_16:
			mov cl,17
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_17

		mov [si + 1],dl 	;-15 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_17:
			mov cl,18
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_18

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_18:
			mov cl,19
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_19

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_19:
			mov cl,20
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_20

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_20:
			mov cl,21
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_21

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_21:
			mov cl,22
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_22

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_22:
			mov cl,23
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_23

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_23:
			mov cl,24
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_24

		mov [si], dl		;-17 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 6],dl 	;+15 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_24:
			mov cl,25
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_25

		mov [si + 1],dl 	;-15 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_25:
			mov cl,26
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_26

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_26:
			mov cl,27
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_27

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_27:
			mov cl,28
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_28

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_28:
			mov cl,29
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_29

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_29:
			mov cl,30
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_30

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_30:
			mov cl,31
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_31

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_31:
			mov cl,32
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_32

		mov [si], dl		;-17 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 6],dl 	;+15 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_32:
			mov cl,33
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_33

		mov [si + 1],dl 	;-15 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_33:
			mov cl,34
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_34

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_34:
			mov cl,35
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_35

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_35:
			mov cl,36
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_36

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_36:
			mov cl,37
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_37

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_37:
			mov cl,38
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_38

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_38:
			mov cl,39
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_39

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_39:
			mov cl,40
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_40

		mov [si], dl		;-17 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 6],dl 	;+15 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_40:
			mov cl,41
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_41

		mov [si + 1],dl 	;-15 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_41:
			mov cl,42
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_42

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_42:
			mov cl,43
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_43

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_43:
			mov cl,44
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_44

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_44:
			mov cl,45
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_45

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_45:
			mov cl,46
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_46

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 5],dl 	;+10 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_46:
			mov cl,47
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_47

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 6],dl 	;+15 flag
		mov [si + 7],dl		;+17 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_47:
			mov cl,48
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_48

		mov [si], dl		;-17 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 6],dl 	;+15 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_48:
			mov cl,49
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_49

		mov [si + 1],dl 	;-15 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 5],dl 	;+10 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_49:
			mov cl,50
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_50

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 5],dl 	;+10 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_50:
			mov cl,51
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_51

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 5],dl 	;+10 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_51:
			mov cl,52
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_52

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 5],dl 	;+10 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_52:
			mov cl,53
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_53

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 5],dl 	;+10 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_53:
			mov cl,54
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_54

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 3],dl 	;-6 flag
		mov [si + 4],dl		;+6 flag
		mov [si + 5],dl 	;+10 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_54:
			mov cl,55
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_55

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 4],dl		;+6 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_55:
			mov cl,56
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_56

		mov [si], dl		;-17 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 4],dl		;+6 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_56:
			mov cl,57
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_57

		mov [si + 1],dl 	;-15 flag
		mov [si + 3],dl 	;-6 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_57:
			mov cl,58
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_58

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 3],dl 	;-6 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_58:
			mov cl,59
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_59

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 3],dl 	;-6 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_59:
			mov cl,60
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_60

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 3],dl 	;-6 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_60:
			mov cl,61
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_61

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 3],dl 	;-6 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_61:
			mov cl,62
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_62

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 2],dl  	;-10 flag
		mov [si + 3],dl 	;-6 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_62:
			mov cl,63
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_63

		mov [si], dl		;-17 flag
		mov [si + 1],dl 	;-15 flag
		mov [si + 2],dl  	;-10 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_63:
			mov cl,64
			cmp al,cl
			jne end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_64

		mov [si], dl		;-17 flag
		mov [si + 2],dl  	;-10 flag
		ret

		end_changing_the_array_of_the_legal_options_for_the_knight_if_the_first_press_is_64:

		ret
	change_the_array_of_the_legal_options_for_the_knight endp


	; after the array ( array_of_flags_for_checks_of_knight_moves ) was change ( deeper explentaion in the description of the funtion on top ) 
	; than i need to check what moves are legal for the knight and put them in the array ( array_of_legal_moves_for_all_off_the_picess )
	; that is containing all of the legal moves of the piece that the user wants to move 
	check_if_moves_legal_for_knight proc 
		call change_the_array_of_the_legal_options_for_the_knight

		; again all of this very specific examples and have to check individually 
		; going throw the array of spots and jump the amount of squares from the location that the knight stands
		; and make the move legal
		lea si, array_of_flags_for_checks_of_knight_moves ;the array checks by order: {-17,-15,-10,-6,+6,+10,+15,+17}
		lea di, array_of_legal_moves_for_all_off_the_picess
		mov ax, 0
		mov al, firts_mouse_press_location
		dec al
		
		mov cl,1
		cmp [si], cl
		jne finished_to_check_the_1_plcae_of_the_array_of_legal_moves_for_all_off_the_picess
		
		add di, ax
		sub di,17
		mov [di],cl

		finished_to_check_the_1_plcae_of_the_array_of_legal_moves_for_all_off_the_picess:
			mov cl,1
			cmp [si + 1], cl
			jne finished_to_check_the_2_plcae_of_the_array_of_legal_moves_for_all_off_the_picess

		lea di, array_of_legal_moves_for_all_off_the_picess
		add di, ax
		sub di,15
		mov [di],cl

		finished_to_check_the_2_plcae_of_the_array_of_legal_moves_for_all_off_the_picess:
			mov cl,1
			cmp [si + 2], cl
			jne finished_to_check_the_3_plcae_of_the_array_of_legal_moves_for_all_off_the_picess

		lea di, array_of_legal_moves_for_all_off_the_picess
		add di, ax
		sub di,10
		mov [di],cl

		finished_to_check_the_3_plcae_of_the_array_of_legal_moves_for_all_off_the_picess:
			mov cl,1
			cmp [si + 3], cl
			jne finished_to_check_the_4_plcae_of_the_array_of_legal_moves_for_all_off_the_picess

		lea di, array_of_legal_moves_for_all_off_the_picess
		add di, ax
		sub di,6
		mov [di],cl

		finished_to_check_the_4_plcae_of_the_array_of_legal_moves_for_all_off_the_picess:
			mov cl,1
			cmp [si + 4], cl
			jne finished_to_check_the_5_plcae_of_the_array_of_legal_moves_for_all_off_the_picess

		lea di, array_of_legal_moves_for_all_off_the_picess
		add di, ax
		add di,6
		mov [di],cl

		finished_to_check_the_5_plcae_of_the_array_of_legal_moves_for_all_off_the_picess:
			mov cl,1
			cmp [si + 5], cl
			jne finished_to_check_the_6_plcae_of_the_array_of_legal_moves_for_all_off_the_picess

		lea di, array_of_legal_moves_for_all_off_the_picess
		add di, ax
		add di,10
		mov [di],cl

		finished_to_check_the_6_plcae_of_the_array_of_legal_moves_for_all_off_the_picess:
			mov cl,1
			cmp [si + 6], cl
			jne finished_to_check_the_7_plcae_of_the_array_of_legal_moves_for_all_off_the_picess

		lea di, array_of_legal_moves_for_all_off_the_picess
		add di, ax
		add di,15
		mov [di],cl

		finished_to_check_the_7_plcae_of_the_array_of_legal_moves_for_all_off_the_picess:
			mov cl,1
			cmp [si + 7], cl
			jne finished_to_check_the_8_plcae_of_the_array_of_legal_moves_for_all_off_the_picess

		lea di, array_of_legal_moves_for_all_off_the_picess
		add di, ax
		add di,17
		mov [di],cl

	
		finished_to_check_the_8_plcae_of_the_array_of_legal_moves_for_all_off_the_picess:
			call check_if_knight_checks_the_king
			ret
	check_if_moves_legal_for_knight endp

	check_if_knight_checks_the_king proc
		lea si,where_is_each_piece
		mov bx,0
		lea bx,array_of_legal_moves_for_all_off_the_picess
		mov counter1,0

		; check what is the color of the piece that was pressed and jump to the right location black or white
		call check_what_colored_piece_was_pressed
		mov al,first_piece_pressed_color
		cmp al,1
		je the_king_is_black

		; based of the king value determine what is the value of the king that checking for
		the_king_is_white:
			mov al,29
			mov king_value,al
			jmp loop_to_check_if_there_is_legal_move_that_hits_the_king
		the_king_is_black:
			mov al,5
			mov king_value,al
			jmp loop_to_check_if_there_is_legal_move_that_hits_the_king

		; loop through all of the legal moves of the knight and if of this moves is hitiing the king than
		; make so the plcae of the knight will be marked in the array where the knight checks the king
		loop_to_check_if_there_is_legal_move_that_hits_the_king:
			inc counter1
			mov al,1
			cmp [bx],al
			jne dont_need_to_check_if_king_stands_there
			
			mov al,king_value
			cmp [si],al

			je the_knight_is_checking
			dont_need_to_check_if_king_stands_there:
				inc bx
				inc si
				mov al,64
				cmp counter1,al
				jne loop_to_check_if_there_is_legal_move_that_hits_the_king
		ret

		the_knight_is_checking:
			; make the spot of the knight to be marked in the array where the kinght checks the king
			lea di, array_of_squares_that_the_kngiht_controls_in_direction_of_the_check
			mov ax,0
			mov al,firts_mouse_press_location
			add di,ax
			dec di
			mov al,1
			mov [di],al
			mov di,0

			; make so the fact that knight check the king will be marked in and array
			lea di,array_of_what_pieces_check_the_king
			mov al,1
			mov [di],al
			inc count_checks
	
			ret
	check_if_knight_checks_the_king endp

	; this funtion is basicaly resting the array ( array_of_flags_for_checks_of_knight_moves )
	; this funtion puts a zero at each index of the array
	make_the_arryay_of_the_knight_moves_to_be_zero_at_each_index proc
		lea si,array_of_flags_for_checks_of_knight_moves
		mov counter1,0
		mov cl,0

		loop_that_puts_zero_at_the_index_of_the_user_choice:
			mov [si],cl
			inc si
			inc counter1
			cmp counter1,8
			jne loop_that_puts_zero_at_the_index_of_the_user_choice

		ret 
	make_the_arryay_of_the_knight_moves_to_be_zero_at_each_index endp
endp


pawn_moves_section:
	; this function is checking for the vaiable moves that the pawn can do and make, the places that the pawn can go are marked in the array of legal moves
	; thats called ( array_of_legal_moves_for_all_off_the_picess ) 
	change_if_move_is_legal_for_the_pawn proc
		lea si, array_of_legal_moves_for_all_off_the_picess
		lea di, array_of_pawns_that_can_go_two_moves

		; check what is the color of the pawn and checking acordingly
		call check_what_colored_piece_was_pressed
		cmp first_piece_pressed_color, 0
		je the_black_checks_of_the_pawn
		jmp the_whie_checks_of_the_pawn



		the_black_checks_of_the_pawn:
			; make the one move forward legal
			mov ax, 0 
			mov al, firts_mouse_press_location
			add al, 8
			dec al
			add si,ax
			mov bl,1
			mov [si],bl
			
			; block the move forward if there is a piece standing there
			mov there_is_somthing_blocking_the_first_move_for_the_pawn_so_it_cant_go_two_moves,0
			call block_the_pawn_moves_forward_if_the_is_piece_there
			cmp there_is_somthing_blocking_the_first_move_for_the_pawn_so_it_cant_go_two_moves,1
			je black_pawn_that_cant_move_2_moves

			lea si, array_of_legal_moves_for_all_off_the_picess
			lea di, array_of_pawns_that_can_go_two_moves
			mov ax, 0 
			mov al, firts_mouse_press_location
			add al, 8
			dec al
			add si,ax
			mov bl,1
			mov [si],bl

			; check if there is a piece one square forward and dont alow to go two square if there is
			mov ax,0
			mov al, firts_mouse_press_location_piece
			sub al, 9
			add di, ax
			mov bl,0
			cmp [di],bl
			je black_pawn_that_cant_move_2_moves

			; make the pawn go forward 2 times
			lea si, array_of_legal_moves_for_all_off_the_picess 
			mov ax,0
			mov al, firts_mouse_press_location
			add al, 16
			dec al
			add si,ax 
			mov bl,1
			mov [si],bl


			black_pawn_that_cant_move_2_moves:
				jmp end_the_color_checks_of_the_pawn

		the_whie_checks_of_the_pawn:
			; make one move forward to be legal
			mov ax, 0 
			mov al, firts_mouse_press_location
			sub al, 8
			dec al
			add si,ax
			mov bl,1
			mov [si],bl

			; block the move forward if there is a piece standing there
			mov there_is_somthing_blocking_the_first_move_for_the_pawn_so_it_cant_go_two_moves,0
			call block_the_pawn_moves_forward_if_the_is_piece_there
			cmp there_is_somthing_blocking_the_first_move_for_the_pawn_so_it_cant_go_two_moves,1
			je black_pawn_that_cant_move_2_moves

			lea si, array_of_legal_moves_for_all_off_the_picess
			lea di, array_of_pawns_that_can_go_two_moves
			mov ax, 0 
			mov al, firts_mouse_press_location
			sub al, 8
			dec al
			add si,ax
			mov bl,1
			mov [si],bl
			
			; check if the there is piece forward and dont let two squares forward to be legal
			mov ax,0
			mov al, firts_mouse_press_location_piece
			sub al, 9
			add di, ax
			mov bl,0
			cmp [di],bl
			je white_pawn_that_cant_move_2_moves

			; make two squares forward move legal
			lea si, array_of_legal_moves_for_all_off_the_picess 
			mov ax,0
			mov al, firts_mouse_press_location
			sub al, 16
			dec al
			add si,ax 
			mov bl,1
			mov [si],bl


			white_pawn_that_cant_move_2_moves:
				jmp end_the_color_checks_of_the_pawn

		end_the_color_checks_of_the_pawn:
			call block_the_pawn_moves_forward_if_the_is_piece_there
			
			; give the pawn the option to go to the side if there is a piece standing there
			call make_the_pawn_tobe_abel_eat_other_pieces_to_the_side 
			
			mov al,need_to_check_more_pawns
			cmp al,1
			je check_if_pawn_is_checking
			ret

			check_if_pawn_is_checking:
				call check_if_the_pawn_checking_and_if_it_is_update_the_array_of_pawns_check_direcion 
				ret 
	change_if_move_is_legal_for_the_pawn endp


	; this function is removing the pawn moves forward cant be done beacause there is a piece one square a head that is blocking the movement
	block_the_pawn_moves_forward_if_the_is_piece_there proc
		mov al,0
		mov counter1,0
		lea si, array_of_legal_moves_for_all_off_the_picess
		lea di, where_is_each_piece

		; pwan cant move forward even if there is a piece a head so there is loop going though the moves and turniing them off if there is 
		; piece standing forwards
		loop_that_turnes_off_moves_that_cant_be_made_because_of_piece_that_is_blocking_them:
			cmp [di],al
			je this_spot_is_legal_for_the_pwan
			cmp [si],al
			je this_spot_is_legal_for_the_pwan

			mov there_is_somthing_blocking_the_first_move_for_the_pawn_so_it_cant_go_two_moves,1
			mov al,0
			mov [si],al
			jmp this_spot_is_legal_for_the_pwan

			
			this_spot_is_legal_for_the_pwan:
				inc di
				inc si
				inc counter1
				cmp counter1,64
				jne loop_that_turnes_off_moves_that_cant_be_made_because_of_piece_that_is_blocking_them
		

		ret
	block_the_pawn_moves_forward_if_the_is_piece_there endp


	; this function is checking if there the pawn can eat the enemy pieces diagonally 
	; the function updates the array of legal moves that called ( array_of_legal_moves_for_all_off_the_picess )
	make_the_pawn_tobe_abel_eat_other_pieces_to_the_side proc
		; check if the pawn is white or black and jmp to the right place
		call check_what_colored_piece_was_pressed
		cmp first_piece_pressed_color,0
		je the_black_pawn_that_eats_to_the_side
		lea si,	where_is_each_piece
		lea di, array_of_legal_moves_for_all_off_the_picess

		the_white_pawn_that_eats_to_the_side:
			; get the pointers to point to one square forward to the right of the pawn
			mov ax, 0
			mov al, firts_mouse_press_location		
			
			add si, ax 
			dec si 
			sub si, 7

			add di, ax 
			dec di 
			sub di, 7
			
			; if the function was called becaues of the king than skip because does not matter if there is enemy piece standing
			cmp when_chking_squares_controlled_dont_do_certain_code,1
			je there_is_no_need_to_check_if_there_is_piece_in_right_side_white_pawn
			
			; check if there is enemy piece standing to the right of the pawn 
			mov bl,0
			cmp [si],bl
			je the_white_pawn_cant_eat_right_side
			mov bl, 16
			cmp [si], bl
			jg the_white_pawn_cant_eat_right_side

			there_is_no_need_to_check_if_there_is_piece_in_right_side_white_pawn:
				; check if there is square to the lefet side forward of the pawn
				mov ax,0
				mov al,firts_mouse_press_location 
				mov bl,8
				div bl
				mov bl,0
				cmp ah,bl
				je the_white_pawn_cant_eat_right_side

			the_white_pawn_can_eat_right_side:
				; make the move eating to the right side leagl
				mov bl,1
				mov [di],bl
				
			the_white_pawn_cant_eat_right_side:
				; point the left foward side of the pawn
				sub si,2
				sub di,2	
				mov bl,0

				; check if the funciton was called because of the king and there is no need to check if there is enemy piece 
				; standing in that square
				cmp when_chking_squares_controlled_dont_do_certain_code,1
				je there_is_no_need_to_check_if_there_is_piece_in_left_side_white_pawn

				; check if there is enemy piece standing there
				cmp [si],bl
				je the_white_pawn_cant_eat_left_side
				mov bl, 16
				cmp [si], bl
				jg the_white_pawn_cant_eat_left_side

				there_is_no_need_to_check_if_there_is_piece_in_left_side_white_pawn:
					; check if there is a square to the left of the pawn
					mov ax,0
					mov al,firts_mouse_press_location 
					mov bl,8
					div bl
					mov bl,1
					cmp ah,bl
					je the_white_pawn_cant_eat_left_side


			the_white_pawn_can_eat_left_side:
				; make the move to the right of the pawn legal
				mov bl,1
				mov [di],bl

			the_white_pawn_cant_eat_left_side:
				ret

		the_black_pawn_that_eats_to_the_side:
			; get the pointer to point to the side right side of the pawn
			lea si,	where_is_each_piece
			lea di, array_of_legal_moves_for_all_off_the_picess

			mov ax, 0
			mov al, firts_mouse_press_location		
			
			add si, ax 
			dec si 
			add si, 7

			add di, ax 
			dec di 
			add di, 7

			mov bl, 17

			; check if the function was called because of the king and there is no need to check if there is a piece standing there
			cmp when_chking_squares_controlled_dont_do_certain_code,1
			je there_is_no_need_to_check_if_there_is_piece_in_right_side_black_pawn

			; check if there is enemy piece standing there
			cmp [si], bl
			jl the_black_pawn_cant_eat_right_side

			there_is_no_need_to_check_if_there_is_piece_in_right_side_black_pawn:
				; check if the square to right side of the pawn exists
				mov ax,0
				mov al,firts_mouse_press_location 
				mov bl,8
				div bl
				mov bl,1
				cmp ah,bl
				je the_black_pawn_cant_eat_right_side


			the_black_pawn_can_eat_right_side:
				; make the move for the pawn legal
				mov bl,1
				mov [di],bl
				
			the_black_pawn_cant_eat_right_side:
				; point to the left forwads square of the pawn
				add si,2
				add di,2	
				mov bl, 17

				; check if the function was called becaues of the king and there is no need to check if there is enemy piece standing there
				cmp when_chking_squares_controlled_dont_do_certain_code,1
				je there_is_no_need_to_check_if_there_is_piece_in_left_side_black_pawn
				
				; check if there is enemy piece standing there
				cmp [si], bl
				jl the_black_pawn_cant_eat_left_side

				there_is_no_need_to_check_if_there_is_piece_in_left_side_black_pawn:
					; check if the square to the left of the pawn actually exists
					mov ax,0
					mov al,firts_mouse_press_location 
					mov bl,8
					div bl
					mov bl,0
					cmp ah,bl
					je the_black_pawn_cant_eat_left_side

			the_black_pawn_can_eat_left_side:
				; make the move to the right side of the pawn exists
				mov bl,1
				mov [di],bl

			the_black_pawn_cant_eat_left_side:
				ret
	make_the_pawn_tobe_abel_eat_other_pieces_to_the_side endp


	; this function is drawing the options of premotions that the pawn can become than it makes so the user can choose an option withe the mouse 
	; after that the function changes the state of the pawn to the user choice of premotion in the array that is called ( array_of_pawn_states )
	check_if_the_pawn_needs_to_be_queen proc 
		; check if the piece is pawn in two parts:
		mov al,firts_mouse_press_location_piece
		cmp al, 8
		jg second_check_if_the_piece_is_a_pawn
		ret

		second_check_if_the_piece_is_a_pawn:
			cmp al, 25
			jl the_piece_is_a_pawn
			ret ; if the piece does not exists than the function stops
		
		the_piece_is_a_pawn:
			; check what is the color of the square and jumps to the right location acordingly
			call check_what_colored_piece_was_pressed
			cmp first_piece_pressed_color, 1
			je check_if_needs_to_be_promtion_for_white

		check_if_needs_to_be_promtion_for_black:
			; check if the square that was played is on the final row of the board and the piece should be promted
			mov cl, 57	
			mov bx,0
			mov bl,second_mouse_press_location
			cmp bl,cl
			jl dont_premote_the_black_pawn

			; check if the already was promted and it does not need to be promted 
			lea si, array_of_pawn_states
			mov bx,0
			mov bl,firts_mouse_press_location_piece
			add si,bx
			sub si,9
			mov bl,1
			cmp [si], bl
			jne dont_premote_the_black_pawn

			; give the user to choose a new piece and update the state of the pawn based on the piece that it choosed
			call draw_the_select_menu_for_the_new_piece
			lea si, array_of_pawn_states
			mov bx,0
			mov bl,firts_mouse_press_location_piece
			add si,bx
			sub si,9
			mov bx,0
			mov bl,the_type_of_premotion_that_the_user_choose
			mov [si],bl

			dont_premote_the_black_pawn:
				ret
		
		check_if_needs_to_be_promtion_for_white:
			; check if the square that user choose to move the pawn is on the final row
			mov cl, 8	
			mov bx,0
			mov bl,second_mouse_press_location
			cmp bl,cl
			jg dont_premote_the_white_pawn
			
			; check if the pawn was already promted
			lea si, array_of_pawn_states
			mov bx,0
			mov bl,firts_mouse_press_location_piece
			add si,bx
			sub si,9
			mov bl,1
			cmp [si],bl
			jne dont_premote_the_white_pawn

			; give the user to choose a new piece and update the state of the pawn based on the piece that it choosed
			call draw_the_select_menu_for_the_new_piece
			lea si, array_of_pawn_states
			mov bx,0
			mov bl,firts_mouse_press_location_piece
			add si,bx
			sub si,9
			mov bx,0
			mov bl,the_type_of_premotion_that_the_user_choose
			mov [si],bl

			dont_premote_the_white_pawn:
				ret
			
	check_if_the_pawn_needs_to_be_queen endp


	; this function is checking if the pawn of one the sides needs to become be preomted than it gives the user the option to choose 
	; what piece it wants to be premoted and than the function is changing the state of the pawn to the new piece
	; ( the state means what king of piece the pawn is becoming), there are 5 states 
	; ( 1 - means pawn, 2 - means knight, 3 - means bishop, 4 - means rock and 5 - means queen )
	draw_the_select_menu_for_the_new_piece proc
		; drawing the select menu for the promtion of the pawn 
		call draw_the_option_selcet_menu_of_the_pawn_premotion

		mov ax,1 	;set mouse curser in graphics mode
		int 33h		;excute configuration 
		
		mov cx,0	;min-x
		mov dx,50  ;max-x
		mov ax,7	;set mouse horizontel range
		int 33h 	;excute configuration
		
		mov cx,0	;min-y
		mov dx,195  ;max-y
		mov ax,8	;set mouse vertical range
		int 33h 	;excute configuration

		
		call delay ; the delay is need becaues the program runs too fast and mouse press from befor will be detect here

		get_mouse_third_click:
			mov ax,0
			mouse_loop_third_click:   ;loop that checks if the left mouse button is clicked is yet
				mov ax,5
				int 33h
				cmp ax,1
				jne mouse_loop_third_click
			
			mov cx,0
			mov dx,0
			mov mouse_press_location,0
			mov ax,3		;set mouse to show his horizontel position in cx and his vertical position in dx
			int 33h			;excute configurtion 

			call check_what_square_mouse_pressing
			mov ax,0 	;set mouse curser in graphics mode
			int 33h		;excute configuration 
			
		call make_the_select_menu_of_the_pawn_premotion_to_disapear
	
		; check what is the piece that the user pressed and change tha var called ( the_type_of_premotion_that_the_user_choose _
		; value to be the king of piece that the user choose 
		mov al,mouse_press_location
		mov bl,1
		cmp al,bl
		je the_user_choose_to_premote_queen

		mov bl,9
		cmp al,bl
		je the_user_choose_to_premote_rock

		mov bl,17
		cmp al,bl
		je the_user_choose_to_premote_bishop

		mov bl,25
		cmp al,bl
		je the_user_choose_to_premote_knight

		the_user_choose_to_premote_queen:
			mov the_type_of_premotion_that_the_user_choose, 5
			ret
		
		the_user_choose_to_premote_rock:
			mov the_type_of_premotion_that_the_user_choose, 4
			ret

		the_user_choose_to_premote_bishop:
			mov the_type_of_premotion_that_the_user_choose, 3
			ret

		the_user_choose_to_premote_knight:
			mov the_type_of_premotion_that_the_user_choose, 2
			ret	

	draw_the_select_menu_for_the_new_piece endp


	; this function is drawing the options of premotions that the pawn can become than it makes so the user can choose an option withe the mouse 
	; after that the function changes the state of the pawn to the user choice of premotion in the array that is called ( array_of_pawn_states )
	draw_the_option_selcet_menu_of_the_pawn_premotion proc
		; printing all of the squares that the piece in the menu stand in them 
		mov first_square_value_of_x,2	  ;set reltive value of x to 238
		mov cx,2					  	  ;set x cordinates for start
		mov dx,0		 				  ;set y cordinates
		mov al,08h 					  	  
		call draw_square

		mov first_square_value_of_x,2	  ;set reltive value of x to 238
		mov cx,2					  	  ;set x cordinates for start
		mov dx,50		 				  ;set y cordinates
		mov al,07h 					  	  
		call draw_square

		mov first_square_value_of_x,2	  ;set reltive value of x to 238
		mov cx,2					  	  ;set x cordinates for start
		mov dx,100		 				  ;set y cordinates
		mov al,08h 					  	  
		call draw_square

		mov first_square_value_of_x,2	  ;set reltive value of x to 238
		mov cx,2					  	  ;set x cordinates for start
		mov dx,150		 				  ;set y cordinates
		mov al,07h 					  	  
		call draw_square

		; check if what is the color of the player that is promting his piece
		call check_what_colored_piece_was_pressed
		mov al,0fh 					  	  ;choose white as color
		cmp first_piece_pressed_color,1
		je the_color_of_the_piece_is_white_there_is_ne_need_th_change_to_black
		
		mov al,00h 					  	  ;choose black as color
		the_color_of_the_piece_is_white_there_is_ne_need_th_change_to_black:
			; print the acuatel pieces that the user can choose to prmote his pawn
			mov first_queen_value_of_x,2	  ;set reltive value of x to 238
			mov cx,2					  	  ;set x cordinates for start
			mov dx,2		 				  ;set y cordinates
			call draw_queen

			mov first_rock_value_of_x,2	  	  ;set reltive value of x to 238
			mov cx,2					  	  ;set x cordinates for start
			mov dx,52		 				  ;set y cordinates
			call draw_rock

			mov first_bishop_value_of_x,2	  ;set reltive value of x to 238
			mov cx,2					  	  ;set x cordinates for start
			mov dx,102		 				  ;set y cordinates
			call draw_bishop

			mov first_knight_value_of_x,2	  ;set reltive value of x to 238
			mov cx,2					  	  ;set x cordinates for start
			mov dx,152		 				  ;set y cordinates
			call draw_knight

		ret
	draw_the_option_selcet_menu_of_the_pawn_premotion endp


	; make the selcect menu of the pawn premotion that is in the upper right corner to disapear
	make_the_select_menu_of_the_pawn_premotion_to_disapear proc
		mov counter1,0
		mov al,00h 
		mov dx,0

		loop_to_make_the_pawn_select_menu_to_disapear:
			mov cx,2

			loop_to_draw_lines_in_black_color:
				mov ah,0ch 					  ;set configuration to writing pixel 
				mov bh,00h 					  ;set the page number
				int 10h    					  ;excute configuration
				inc cx
				cmp cx,53
				jne loop_to_draw_lines_in_black_color

			inc dx
			inc counter1
			cmp counter1,201
			jne loop_to_make_the_pawn_select_menu_to_disapear

		ret 
	make_the_select_menu_of_the_pawn_premotion_to_disapear endp 


	; this function is drawing the square for the menu of pieces of the premotions of the pawn the function is getting the x and y of 
	; the square ( cx - x, y - dx ) and drawing the square
	draw_square proc
		mov counter1,0
		loop_to_draw_the_square:
			mov cx,0

			loop_to_draw_lines_of_the_square:
				add cx,first_square_value_of_x
				mov ah,0ch 					  ;set configuration to writing pixel 
				mov bh,00h 					  ;set the page number
				int 10h    					  ;excute configuration
				inc cx
				sub cx,first_square_value_of_x
				cmp cx,51
				jne loop_to_draw_lines_of_the_square

			inc dx
			inc counter1
			cmp counter1,51
			jne loop_to_draw_the_square
		
		ret
	draw_square endp


	; this function is checking what is the state of the pawn ( state means what king of piece this pawn is if it is a normal pawn 
	; or if it is a pawn after promotion that can be queen, rock, bishop and a knight ) and than it draws the "pawn" acoring to it state 
	; the function is using the ( array array_of_pawn_states ) wich stores all of the "states" of all of the pawns
	check_what_kind_of_piece_needs_to_be_drawn_if_the_piece_is_pawn proc
		; check what is the "state" of the pawn and go to the right place
		lea si, array_of_pawn_states
		add si,	bx
		sub si,9
		mov ax,0
		mov al,mouse_press_location_color

		mov bl,1
		cmp [si],bl
		je the_pawn_needs_to_be_drawen_as_pawn

		mov bl,2
		cmp [si],bl
		je the_pawn_needs_to_be_drawen_as_knight

		mov bl,3
		cmp [si],bl
		je the_pawn_needs_to_be_drawen_as_bishop

		mov bl,4
		cmp [si],bl
		je the_pawn_needs_to_be_drawen_as_rock

		mov bl,5
		cmp [si],bl
		je the_pawn_needs_to_be_drawen_as_queen

		; draw the right acording to the right pawn "state"
		the_pawn_needs_to_be_drawen_as_pawn:
			mov first_pawn_value_of_x, cx
			call draw_pawn
			ret

		the_pawn_needs_to_be_drawen_as_knight:
			mov first_knight_value_of_x, cx
			call draw_knight
			ret

		the_pawn_needs_to_be_drawen_as_bishop:
			mov first_bishop_value_of_x, cx
			call draw_bishop
			ret

		the_pawn_needs_to_be_drawen_as_rock:
			mov first_rock_value_of_x, cx
			call draw_rock
			ret

		the_pawn_needs_to_be_drawen_as_queen:
			mov first_queen_value_of_x, cx
			call draw_queen
			ret
		
	check_what_kind_of_piece_needs_to_be_drawn_if_the_piece_is_pawn endp

	; this function is going through the moves that the pawn can go to and than checks if one of this moves
	; is to a place that the king is standing there than the function is updating the array of the plcaes that 
	; the pawn checks the king
	check_if_the_pawn_checking_and_if_it_is_update_the_array_of_pawns_check_direcion proc
		; check if there is already pawn that checks the king and if there is returns
		mov al,need_to_check_more_pawns
		cmp al,0
		jne need_to_check
		ret
		need_to_check:
			; intailes all of the vars vals that are needed for this func
			lea si,array_of_squares_that_the_pawn_controls_in_direction_of_the_check
			lea di,array_of_legal_moves_for_all_off_the_picess
			mov bx,0
			lea bx,where_is_each_piece
			mov al,0
			mov counter1,al

		; check what is the color of the piece that was pressed and get the king right value acording to it
			call check_what_colored_piece_was_pressed
			mov al,first_piece_pressed_color
			cmp al,0
			je the_opposite_king_is_white

		the_opposite_king_is_black:
			mov al,5
			mov king_value,al
			jmp loop_to_check_if_there_pawn_is_checking_the_king

		the_opposite_king_is_white:
			mov al,29
			mov king_value,al
			jmp loop_to_check_if_there_pawn_is_checking_the_king

		; loop to thrugh the places that the king can go to and check if the enemy king is in them 
		; if it is not the func returns
		loop_to_check_if_there_pawn_is_checking_the_king:
			inc counter1
			mov al,1
			cmp [di],al
			jne king_is_not_stading_there

			mov al,king_value
			cmp [bx],al
			je put_the_square_the_pawn_standing_on_it_in_the_array

			king_is_not_stading_there:
				inc bx
				inc di
				mov al,64
				cmp counter1,al
				jne loop_to_check_if_there_pawn_is_checking_the_king
		ret

		put_the_square_the_pawn_standing_on_it_in_the_array:
			; save the location of the pawn in the array where the pawn checks the king 
			mov al,0
			mov need_to_check_more_pawns,al

			mov bx,0
			lea bx,array_of_squares_that_the_pawn_controls_in_direction_of_the_check
			mov ax,0
			add al,firts_mouse_press_location
			dec al
			add bx,ax
			mov al,1
			mov [bx],al
			mov bx,0

			; save the fact the pawn checks the king
			lea di,array_of_what_pieces_check_the_king
			add di,3
			mov al,1
			mov [di],al
			inc count_checks
	
		ret
	check_if_the_pawn_checking_and_if_it_is_update_the_array_of_pawns_check_direcion endp

endp


bishop_moves_section:
	; this function is checking what legal moves there for a bishop and puts this moves in the arr of legal moves wich is called 
	; ( array_of_legal_moves_for_all_off_the_picess ) on top of that this function is using mainly the function that is called 
	; ( calculate_all_of_the_bishop_moves_in_spesific_direction ) to calculate the bishop move in a spesipic direction and it changes the direction
	; in the var thats called ( which_direction_the_function_is_checking_for_the_bishop_movement )
	check_if_the_mov_is_leagal_for_the_bishop proc	
		call check_what_is_the_king_value

		; check if the bishop can move to the left side 
		mov ax,0
		mov al,firts_mouse_press_location
		mov cx,8
		div cl
		mov dl,1
		cmp ah,dl
		je the_bishop_right_side_check

		; check if the bishop can move dawn
		mov ax,0
		mov al,firts_mouse_press_location
		cmp al, 55
		jg in_the_left_check_cant_move_up

		; check the bishop in the left lower direction
		mov which_direction_the_function_is_checking_for_the_bishop_movement,7
		call calculate_all_of_the_bishop_moves_in_spesific_direction
		
		in_the_left_check_cant_move_up:
			; check if the bihsop can move up
			mov ax,0
			mov al,firts_mouse_press_location
			cmp al, 10
			jl the_bishop_right_side_check

			; check the bishop in the left upper direction
			mov which_direction_the_function_is_checking_for_the_bishop_movement,-9
			call calculate_all_of_the_bishop_moves_in_spesific_direction

		the_bishop_right_side_check:
			; check if the bishop can move to the left side
			mov ax,0
			mov al,firts_mouse_press_location
			mov cx,8
			div cl
			mov dl,0
			cmp ah,dl
			je end_the_bishop_right_side_check

			; check if the bishop can move dawn 
			mov ax,0
			mov al,firts_mouse_press_location
			cmp al, 9
			jl in_the_right_check_cant_move_up

			; check the bishop in the right upper direction
			mov which_direction_the_function_is_checking_for_the_bishop_movement,-7
			call calculate_all_of_the_bishop_moves_in_spesific_direction

			in_the_right_check_cant_move_up:
				; check if the bishop can move up
				mov ax,0
				mov al,firts_mouse_press_location
				cmp al, 55
				jg end_the_bishop_right_side_check

				; check the bishop in the right lower direction
				mov which_direction_the_function_is_checking_for_the_bishop_movement,9
				call calculate_all_of_the_bishop_moves_in_spesific_direction

		end_the_bishop_right_side_check:
			ret

	check_if_the_mov_is_leagal_for_the_bishop endp


	; this function is calculating all of the bishop moves in a specsific direction and the direction we chose is in the var that is
	; called ( which_direction_the_function_is_checking_for_the_bishop_movement ) its also check what direction and if the bishop is checking 
	; the enemy king
	calculate_all_of_the_bishop_moves_in_spesific_direction proc
		; loading the array that will be used no matter what:
		lea si,array_of_legal_moves_for_all_off_the_picess
		lea di,where_is_each_piece
		dec si
		dec di

		; inintails the counter with the first spot in the direction that this function is checking:
		mov ax,which_direction_the_function_is_checking_for_the_bishop_movement
		mov counter1dw,ax
		
		; checking if this function is called becaues of checking the king or because wanting to check where the bishop can move for 
		; beacuse the player wants to move the bishop, if it is called beacuse of the king than the function is loading the array of 
		; the spaces that the player can block the check of the bishop in them
		mov al,when_chking_squares_controlled_dont_do_certain_code
		cmp al,1
		jne check_bishop_in_this_direction

		;loading the array of spaces that the player can block the check of the bishop in them
		lea bx,array_of_squares_that_the_bishop_controls_in_direction_of_the_check
		dec bx

		check_bishop_in_this_direction:
			; inc the bishop loaction in the array to the right location and not just the first one
			mov cx,0
			mov cl,firts_mouse_press_location
			add di,cx
			add si,cx

			; checking if the function was called beacuse was the king function and if the array of spaces that the player can block the check of the bishop in them
			; should be updated with the the first square where the bishop is standing 
			mov al,when_chking_squares_controlled_dont_do_certain_code
			cmp al,1
			jne keep_taking_the_bishop_in_this_direction

			; this part is checking if the check of the bishop is already detected and if the array shouldn't be updated 
			mov al,0
			cmp need_to_check_more_bishops,al
			je keep_taking_the_bishop_in_this_direction 
			
			; check if dont need to update the array of array of spaces that the player can block the check of the bishop in them 
			; beause this itrations are only checking the squares that the emenmy controls behind the king
			mov al,1
			cmp dont_need_to_update_the_array_of_the_checks_squares,al
			je keep_taking_the_bishop_in_this_direction

			; update the array of places the check of the bishop can be blocked
			add bx,cx
			mov dl,1
			mov [bx],dl

			keep_taking_the_bishop_in_this_direction:
				;inc the counter to the next square:
				mov ax,which_direction_the_function_is_checking_for_the_bishop_movement
				add counter1dw,ax
			
			
				; increase the arrays to the next square
				mov cx,which_direction_the_function_is_checking_for_the_bishop_movement
				add si,cx
				add di,cx

				;make this squrae legal for the bishop:
				mov cl,1
				mov [si],cl
				
				; check if dont need to update the array of array of spaces that the player can block the check of the bishop in them 
				; beause this itrations are only checking the squares that the emenmy controls behind the king
				mov al,1
				cmp dont_need_to_update_the_array_of_the_checks_squares,al
				je dont_need_to_check_anymore_bishops

				; checking if the function was called beacuse was the king function and if the array of spaces that the player can block the check of the bishop in them
				; should be updated with the next square
				mov al,when_chking_squares_controlled_dont_do_certain_code
				cmp al,1
				jne dont_need_to_check_anymore_bishops

				; this part is checking if the check of the bishop is already detected and if the array shouldn't be updated 
				mov al,0
				cmp need_to_check_more_bishops,al
				je dont_need_to_check_anymore_bishops

				;updating the array of places that the enemy can block the check of the bishop in them 
				mov ax,which_direction_the_function_is_checking_for_the_bishop_movement
				mov cl,1
				add bx,ax
				mov [bx],cl

				dont_need_to_check_anymore_bishops:
					; check if this function was called becuase of the king and if is is makes that the function will also detect
					; if the piece that is stoping the king from moving is the king and keep going to check where the king can't go behind him
					mov cl,1
					mov al,when_chking_squares_controlled_dont_do_certain_code
					cmp al,cl
					je check_if_piece_is_king_bishop_func
					jmp not_in_king_checks_mode_bishop_func

					; this part is when checking when the checking where the king cant go 
					check_if_piece_is_king_bishop_func:
						; to check if the there is a piece standing in the location and keep going if there is not
						mov cl,0
						cmp [di],cl
						je end_checking_for_pieces_standing_bisho_func
						
						; if there is piece standing in the location than checking if there is king standing there if there is the function 
						; goes to a state when only the array of squares that bishop controls is update and if this just a normal piece than the 
						; function stops to calculate bishop moves in that direction
						mov cl,king_value
						cmp [di],cl
						jne the_location_of_the_bishop_is_hitting_something
						
						; enter the state and save the piece in the last place where bishop can realy go to compare it later
						mov al,[di]
						mov last_location_to_compare,al
						dont_update_the_last_location:
						mov al,1
						mov dont_need_to_update_the_array_of_the_checks_squares,al
						jmp end_checking_for_pieces_standing_bisho_func

					; this function is not when the function wasn't called by the king and it just need to check if the bishop can move anymore
					; forwards becuse a piece blocks it
					not_in_king_checks_mode_bishop_func:
						;to check if the there is a piece standing in the location and keep going if there is not
						mov cl,0
						cmp [di],cl
						jne the_location_of_the_bishop_is_hitting_something

				end_checking_for_pieces_standing_bisho_func:
					;this part is checking if the bishop is hitting something in this specific direction
					mov ax,0 
					mov al,firts_mouse_press_location
					add ax,counter1dw
					sub ax,which_direction_the_function_is_checking_for_the_bishop_movement
					cmp ax,9
					jl the_location_of_the_bishop_is_hitting_something
					cmp ax,55
					jg the_location_of_the_bishop_is_hitting_something
					mov cx,8
					div cl
					cmp ah,1
					je the_location_of_the_bishop_is_hitting_something
					cmp ah,0
					je the_location_of_the_bishop_is_hitting_something
					
					; if the bishop just strted in the edge of the board than keep going and calculating moves for the bishop
					jmp keep_taking_the_bishop_in_this_direction

				the_location_of_the_bishop_is_hitting_something:
					; check if the bishop hitted the king and kept calculating or it just hitted something
					; if it is just hitted something than save the last location is has hit 
					mov al,1
					cmp dont_need_to_update_the_array_of_the_checks_squares,al
					je dont_need_to_upadte_di
					

					dont_need_to_upadte_di:
						; check if the the direction where bishop checks the king was already found in previes time when calling the function 
						; than dont nned to check if this is the time the bishop checks
						mov al,0
						cmp need_to_check_more_bishops,al
						je dont_mess_up_with_that_bishop_array

						; check if the function just was just called to calculate where to player can move the bishop 
						mov al,when_chking_squares_controlled_dont_do_certain_code
						cmp al,1
						jne dont_mess_up_with_that_bishop_array

					;check if the bishop is hitting the king and this the time the squares of the direction of the bishop should be saved
					call cehck_if_the_last_square_hitting_is_the_king_for_bishop
					
					dont_mess_up_with_that_bishop_array:
						; if the function kept calulting after the king than resting this moed for the next time the function will be called
						mov al,0
						mov dont_need_to_update_the_array_of_the_checks_squares,al
					
						ret
	calculate_all_of_the_bishop_moves_in_spesific_direction endp 


	; checking if the last square that the bishop is the king and if it is update the fact the bishop checks
	; the king and if its not reset the array of the places that the check of the bishop can be blocked
	cehck_if_the_last_square_hitting_is_the_king_for_bishop proc
		mov al,1
		cmp dont_need_to_update_the_array_of_the_checks_squares,al
		je dont_need_to_go_one_square_back
		
		; go one square befor this 
		mov ax,which_direction_the_function_is_checking_for_the_bishop_movement
		sub bx,ax
		
		dont_need_to_go_one_square_back:
			; check what is the value of the piece and if the check of the king 
			; shold be black or white
			call check_what_colored_piece_was_pressed
			cmp first_piece_pressed_color,0
			je check_if_the_white_king_standing_there
			jmp check_if_the_black_king_standing_there

		check_if_the_black_king_standing_there:
			; check if the bishop is checking the king
			mov al,5
			cmp last_location_to_compare,al
			jne there_is_no_black_king_standing_there

			; block the last place in the array of squares that bishop controls in the direction of the check
			; because in the last place there is a king so its needs to be blocked
			mov al,0
			mov [bx],al
			mov al,0
			mov need_to_check_more_bishops,al
			
			; update the fact the bishop checks the king
			lea si,array_of_what_pieces_check_the_king
			add si,1
			mov ax,1
			mov [si],al
			inc count_checks
			ret
			
			there_is_no_black_king_standing_there:
				; if the bishp does not check the king than reset the array of the squares that bishop check in the direction of the king
				lea bx,array_of_squares_that_the_bishop_controls_in_direction_of_the_check
				call reset_the_array_in_the_bx
				ret

		check_if_the_white_king_standing_there:
			; check if the bishop is checking the king
			mov al,29
			cmp last_location_to_compare,al
			jne there_is_no_white_king_standing_there

			; block the last place in the array of squares that bishop controls in the direction of the check
			; because in the last place there is a king so its needs to be blocked
			mov al,0
			mov [bx],al
			mov al,0
			mov need_to_check_more_bishops,al

			lea si,array_of_what_pieces_check_the_king
			add si,1
			mov ax,1
			mov [si],al
			inc count_checks
			ret

			there_is_no_white_king_standing_there:
				; if the bishp does not check the king than reset the array of the squares that bishop check in the direction of the king
				lea bx,array_of_squares_that_the_bishop_controls_in_direction_of_the_check
				call reset_the_array_in_the_bx
				ret
	cehck_if_the_last_square_hitting_is_the_king_for_bishop endp
endp


rock_moves_section:
	; this function is checking what legal moves there for the rock and puts this moves in the arr of legal moves wich is called 
	; ( array_of_legal_moves_for_all_off_the_picess ) on top of that this function is using mainly in the function that is called 
	; ( check_for_rock_moves_in_spesific_dir ) to calculate the rock moves in a spesipic direction and it changes the direction
	; in the var thats called ( which_direction_the_function_is_checking_for_the_rock_movement ) 
	check_if_the_mov_is_leagal_for_the_rock proc
		call check_what_is_the_king_value

		; check if the rock can go left side based on were it stands
		mov al,firts_mouse_press_location
		mov cx,8
		div cl
		mov dl,1
		cmp ah,dl
		je the_rock_right_side_check
		
		; check how what squares the rock can go to the left side
		mov which_direction_the_function_is_checking_for_the_rock_movement,1
		call check_for_rock_moves_in_spesific_dir
		mov al,0
		mov dont_need_to_update_the_array_of_the_checks_squares,al

		the_rock_right_side_check:
			; check if the rock can go right side based on were it stands
			mov al,firts_mouse_press_location
			mov cx,8
			div cl
			mov dl,0
			cmp ah,dl
			je end_the_rock_right_side_check

			; check how what squares the rock can go to the right side
			mov which_direction_the_function_is_checking_for_the_rock_movement,-1
			call check_for_rock_moves_in_spesific_dir
			mov al,0
			mov dont_need_to_update_the_array_of_the_checks_squares,al

		end_the_rock_right_side_check:
			; check if the rock can go up based on were it stands
			mov ax,0
			mov al,firts_mouse_press_location
			cmp al, 9
			jl the_roc_cant_move_up

			; check how what squares the rock can go to the upper side 
			mov which_direction_the_function_is_checking_for_the_rock_movement,8
			call check_for_rock_moves_in_spesific_dir
			mov al,0
			mov dont_need_to_update_the_array_of_the_checks_squares,al

			the_roc_cant_move_up:
				; check if the rock can go dawn based on were it stands
				mov ax,0
				mov al,firts_mouse_press_location
				cmp al, 55
				jg the_roc_cant_move_dawn
				
				; check how what squares the rock can go to the lower side
				mov which_direction_the_function_is_checking_for_the_rock_movement,-8
				call check_for_rock_moves_in_spesific_dir
				mov al,0
				mov dont_need_to_update_the_array_of_the_checks_squares,al
	
		the_roc_cant_move_dawn:
			; check if the function was called becaues of the king and if it sholdnt block squares that 
			; have the same color piece in them
			mov al,when_chking_squares_controlled_dont_do_certain_code
			cmp al,0
			jne the_square_is_not_controlled_so_right_corner_dawn_is_ilegal

			call change_the_aaray_of_legal_moves_in_a_way_that_blocks_moves_if_there_same_color_piece_in_that_square
			mov al,0
			mov dont_need_to_update_the_array_of_the_checks_squares,al
			
			; make the last square in the board to be legal if the one square befor is legal 
			; becaues of some defect code its not working
			lea di,array_of_legal_moves_for_all_off_the_picess
			add di,55
			mov al,1
			cmp [di],al
			jne the_square_is_not_controlled_so_right_corner_dawn_is_ilegal

			mov al,1
			add di,8
			mov [di], al

			the_square_is_not_controlled_so_right_corner_dawn_is_ilegal:
				ret
	check_if_the_mov_is_leagal_for_the_rock endp


	; this function is calculating all of the rock moves in a specsific direction and the direction we chose is in the var that is 
	; called ( which_direction_the_function_is_checking_for_the_bishop_movement )
	check_for_rock_moves_in_spesific_dir proc
		; loading the arrays that will be used no matter what:
		lea si,array_of_legal_moves_for_all_off_the_picess
		lea di,where_is_each_piece
		dec si
		dec di

		; inintails the counter with the first spot in the direction that this function is checking:
		mov ax,which_direction_the_function_is_checking_for_the_rock_movement
		mov counter1dw,ax

		; checking if this function is called becaues of checking the king or because wanting to check where the rock can move for 
		; beacuse the player wants to move the rock, if it is called beacuse of the king than the function is loading the array of 
		; the spaces that the player can block the check of the bishop in them
		mov al,when_chking_squares_controlled_dont_do_certain_code
		cmp al,1
		jne the_rock_is_trevaling

		;loading the array of spaces that the player can block the check of the rock in them
		lea bx,array_of_squares_that_the_rock_controls_in_direction_of_the_check
		dec bx
	
		the_rock_is_trevaling:
			; inc the rock loaction in the array to the right location and not just the first one
			mov dx,0
			mov dl,firts_mouse_press_location
			add di,dx
			add si,dx

			; checking if the function was called beacuse was the king function and if the array of spaces that the player can block the check of the rock in them
			; should be updated with the the first square where the rock is standing 
			mov al,0
			cmp need_to_check_more_rocks,al
			je keep_taking_the_rock 
			
			; this part is checking if the check of the rock is already detected and if the array shouldn't be updated 
			mov al,1
			cmp dont_need_to_update_the_array_of_the_checks_squares,al
			je keep_taking_the_rock
			
			; check if dont need to update the array of array of spaces that the player can block the check of the bishop in them 
			; beause this itrations are only checking the squares that the emenmy controls behind the king
			mov al,when_chking_squares_controlled_dont_do_certain_code
			cmp al,1
			jne keep_taking_the_rock

			; update the array of places the check of the rock can be blocked
			add bx,dx
			mov dl,1
			mov [bx],dl

			keep_taking_the_rock:
				; increase the arrays to the next square
				mov dx,which_direction_the_function_is_checking_for_the_rock_movement
				sub si,dx
				sub di,dx

				;inc the counter to the next square:
				mov ax,which_direction_the_function_is_checking_for_the_rock_movement
				add counter1dw,ax

				;make this squrae legal for the rock:
				mov dl,1
				mov [si],dl

				; checking if the function was called beacuse was the king function and if the array of spaces that the player can block the check of the rock in them
				; should be updated with the the first square where the rock is standing 
				mov al,0
				cmp need_to_check_more_rocks,al
				je dont_need_this_beacuse_the_array_aleady_fixed_on_the_rock_route

				; this part is checking if the check of the rock is already detected and if the array shouldn't be updated 
				mov al,1
				cmp dont_need_to_update_the_array_of_the_checks_squares,al
				je dont_need_this_beacuse_the_array_aleady_fixed_on_the_rock_route

				; check if dont need to update the array of array of spaces that the player can block the check of the bishop in them 
				; beause this itrations are only checking the squares that the emenmy controls behind the king
				mov al,when_chking_squares_controlled_dont_do_certain_code
				cmp al,1
				jne dont_need_this_beacuse_the_array_aleady_fixed_on_the_rock_route

				;updating the array of places that the enemy can block the check of the rock in them
				mov ax,which_direction_the_function_is_checking_for_the_rock_movement
				mov dl,1
				sub bx,ax
				mov [bx],dl

				dont_need_this_beacuse_the_array_aleady_fixed_on_the_rock_route:
					; check if this function was called becuase of the king and if is is makes that the function will also detect
					; if the piece that is stoping the king from moving is the king and keep going to check where the king can't go behind him
					mov al,when_chking_squares_controlled_dont_do_certain_code
					cmp al,1
					jne not_in_king_checks_mode

					;to check if the there is a piece standing in the location
					mov dl,0
					cmp [di],dl
					jne check_if_piece_is_king
					jmp end_checking_for_pieces_standing

				check_if_piece_is_king:
					;to check if there is a piece standing in the location
					mov dl,0
					cmp [di],dl
					je end_checking_for_pieces_standing
					
					; check if it is juest the king and needs to keep going
					mov dl,king_value
					cmp [di],dl
					je change_the_right_thing_for_the_rock 
					
					call cehck_if_the_last_square_hitting_is_the_king_for_rock
					mov al,0
					mov dont_need_to_update_the_array_of_the_checks_squares,al
					ret

					change_the_right_thing_for_the_rock:
						; save the last leagl move
						mov al,[di]
						mov last_location_to_compare,al

						; save te fact the rock is checking the king
						mov al,1
						mov dont_need_to_update_the_array_of_the_checks_squares,al
						jmp end_checking_for_pieces_standing
					
				not_in_king_checks_mode:
					;to check if there is a piece standing in the location
					mov dl,0
					cmp [di],dl
					je end_checking_for_pieces_standing

					call cehck_if_the_last_square_hitting_is_the_king_for_rock
					mov al,0
					mov dont_need_to_update_the_array_of_the_checks_squares,al
					ret

				end_checking_for_pieces_standing:
				
					;to check if the piece is hitting the one of the borders
					mov ax,0 
					mov al,firts_mouse_press_location
					sub ax,counter1dw
					add ax,which_direction_the_function_is_checking_for_the_rock_movement
					mov dx,9
					cmp ax,dx
					jl the_rock_hitted_barrier_dawn
					mov dx,55
					cmp ax,dx
					jg the_rock_hiited_barrier_up
					mov cx,8
					div cl
					mov dl,1
					cmp ah,dl
					je the_rock_hiited_barrier_right
					mov dl,0
					cmp ah,dl
					je the_rock_hiited_barrier_left
				
				jmp keep_taking_the_rock

			; this place is checking if the rock actouly hitted the border or if it just started
			; on one of the borders
			the_rock_hitted_barrier_dawn:
				mov ax,0 
				mov al,firts_mouse_press_location	
				mov dx,9
				cmp ax,dx
				jl the_loop_keeps_going
				call cehck_if_the_last_square_hitting_is_the_king_for_rock
				mov al,0
				mov dont_need_to_update_the_array_of_the_checks_squares,al
				ret

			the_rock_hiited_barrier_up:
				mov ax,0 
				mov al,firts_mouse_press_location	
				mov dx,55
				cmp ax,dx
				jg the_loop_keeps_going
				call cehck_if_the_last_square_hitting_is_the_king_for_rock
				mov al,0
				mov dont_need_to_update_the_array_of_the_checks_squares,al
				ret

			the_rock_hiited_barrier_right:
				mov ax,0 
				mov al,firts_mouse_press_location	
				mov cx,8
				div cl
				mov dl,1
				cmp ah,dl
				call cehck_if_the_last_square_hitting_is_the_king_for_rock
				mov al,0
				mov dont_need_to_update_the_array_of_the_checks_squares,al
				ret
			
			the_rock_hiited_barrier_left:
				mov ax,0 
				mov al,firts_mouse_press_location	
				mov cx,8
				div cl
				mov dl,0
				cmp ah,dl
				je the_loop_keeps_going
				call cehck_if_the_last_square_hitting_is_the_king_for_rock
				mov al,0
				mov dont_need_to_update_the_array_of_the_checks_squares,al
				ret

			the_loop_keeps_going:
				jmp keep_taking_the_rock

		the_end_of_this_rock_func:
			call cehck_if_the_last_square_hitting_is_the_king_for_rock
			mov al,0
			mov dont_need_to_update_the_array_of_the_checks_squares,al
			ret
	check_for_rock_moves_in_spesific_dir endp


	; check if the piece that moved is rock and if it is rock than updating the array of rocks
	; that move this array is need becaues the rock cant castle if it moved and came back to its original location
	update_the_array_of_rocks_that_moved proc
		mov cl,0
		mov al, firts_mouse_press_location_piece
		mov bl,1
		cmp al,bl
		je update_first_rock
	
		mov bl,8
		cmp al,bl
		je update_second_rock
	
		mov bl,25
		cmp al,bl
		je update_third_rock
	
		mov bl,32
		cmp al,bl
		je update_fourth_rock

		ret
		update_first_rock:
			lea si,array_of_rocks_taht_are_abel_to_castle
			mov [si],cl
			ret
		update_second_rock:
			lea si,array_of_rocks_taht_are_abel_to_castle
			mov [si + 1],cl
			ret
		update_third_rock:
			lea si,array_of_rocks_taht_are_abel_to_castle
			mov [si + 2],cl
			ret
		update_fourth_rock:
			lea si,array_of_rocks_taht_are_abel_to_castle
			mov [si + 3],cl
			ret

	update_the_array_of_rocks_that_moved endp


	; check if the king is castling and also the rock should move
	move_the_rock_if_the_king_castle proc
		; check what is the color of the piece that was pressed on go to the corect place acordingly
		call check_what_colored_piece_was_pressed
		mov al,first_piece_pressed_color
		mov bl,1
		cmp al,bl
		je move_white_rocks
		jmp move_black_rocks

		move_white_rocks:
			; check if the white is castling or not
			mov al,firts_mouse_press_location_piece
			cmp al,29
			jne the_white_king_is_not_casteling
			lea si,array_of_kings_that_are_abel_to_castle
			mov al,0
			cmp [si + 1],al
			je the_white_king_is_not_casteling

			; check with what rock the white king castle
			mov al,second_mouse_press_location
			cmp al,63
			je the_white_king_castle_with_right_rock
			cmp al,59
			je the_white_king_castle_with_left_rock

			jmp the_white_king_is_not_casteling


			the_white_king_castle_with_left_rock:
				; move the left rock
				mov ax,0
				mov al,firts_mouse_press_location
				push ax
				mov ax,0
				mov al,second_mouse_press_location
				push ax
				
				mov al,57
				mov firts_mouse_press_location,al

				mov al,60
				mov second_mouse_press_location,al

				call get_the_pieces_that_were_pressed_to_the_right_vars
				call do_everything_related_to_moving_a_piece
				
				pop ax
				mov second_mouse_press_location,al
				pop ax
				mov firts_mouse_press_location,al

				ret
			the_white_king_castle_with_right_rock:
				; move the left rock
				mov ax,0
				mov al,firts_mouse_press_location
				push ax
				mov ax,0
				mov al,second_mouse_press_location
				push ax
				
				mov al,64
				mov firts_mouse_press_location,al

				mov al,62
				mov second_mouse_press_location,al

				call get_the_pieces_that_were_pressed_to_the_right_vars
				call do_everything_related_to_moving_a_piece
				
				pop ax
				mov second_mouse_press_location,al
				pop ax
				mov firts_mouse_press_location,al
				ret
			the_white_king_is_not_casteling:
				ret
		move_black_rocks:
			; check if the black is castling or not
			mov al,firts_mouse_press_location_piece
			cmp al,5
			jne the_black_king_is_not_casteling
			lea si,array_of_kings_that_are_abel_to_castle
			mov al,0
			cmp [si],al
			je the_black_king_is_not_casteling

			; check if the black rokc castle left or right
			mov al,second_mouse_press_location
			cmp al,7
			je the_black_king_castle_with_right_rock
			cmp al,3
			je the_black_king_castle_with_left_rock

			jmp the_black_king_is_not_casteling


			the_black_king_castle_with_left_rock:
				; move the right rock
				mov ax,0
				mov al,firts_mouse_press_location
				push ax
				mov ax,0
				mov al,second_mouse_press_location
				push ax
				
				mov al,1
				mov firts_mouse_press_location,al

				mov al,4
				mov second_mouse_press_location,al

				call get_the_pieces_that_were_pressed_to_the_right_vars
				call do_everything_related_to_moving_a_piece
				
				pop ax
				mov second_mouse_press_location,al
				pop ax
				mov firts_mouse_press_location,al
				ret
			the_black_king_castle_with_right_rock:
				; move the left rock
				mov ax,0
				mov al,firts_mouse_press_location
				push ax
				mov ax,0
				mov al,second_mouse_press_location
				push ax
				
				mov al,8
				mov firts_mouse_press_location,al

				mov al,6
				mov second_mouse_press_location,al

				call get_the_pieces_that_were_pressed_to_the_right_vars
				call do_everything_related_to_moving_a_piece
				
				pop ax
				mov second_mouse_press_location,al
				pop ax
				mov firts_mouse_press_location,al
				ret
			the_black_king_is_not_casteling:
				ret
	move_the_rock_if_the_king_castle endp


	; checking if the last square that the rock is in is the king and if it is update the fact the rock checks
	; the king and if its not reset the array of the places that the check of the rock can be blocked
	cehck_if_the_last_square_hitting_is_the_king_for_rock proc
		mov al,need_to_check_more_rocks
		cmp al,0
		jne the_next_step
		ret 
	
		the_next_step:
			; checking if the function was called because of king function and if its not skips to the endo
			mov al,when_chking_squares_controlled_dont_do_certain_code
			cmp al,1
			jne dont_mess_up_anything

		; check if the last square of the legal moves of the rock was already found out and if not 
		; than finding ount now
		mov al,1
		cmp dont_need_to_update_the_array_of_the_checks_squares,al
		je dont_need_to_upadte_di_rock
		
		mov al,[di]
		mov last_location_to_compare,al

		dont_need_to_upadte_di_rock:
			; check if the rock was detecet hitting the king and if its is skips this part
			mov al,1
			cmp dont_need_to_update_the_array_of_the_checks_squares,al
			je dont_need_to_go_one_square_back_rock
		
		; goes when square back
		mov ax,which_direction_the_function_is_checking_for_the_rock_movement
		sub bx,ax

		dont_need_to_go_one_square_back_rock:
			; check if the rock is white or black and goes to the right place acodingly
			call check_what_colored_piece_was_pressed
			cmp first_piece_pressed_color,0
			je check_if_the_white_king_standing_therein_the_rock_checking

		check_if_the_black_king_standing_there_in_the_rock_checking:
			; check if there is enemy king in the last square
			mov al,5
			cmp last_location_to_compare,al
			jne there_is_no_black_king_standing_there_for_rock
		
			; trun off last square because the king is standing there
			mov al,0
			mov [bx],al
			mov need_to_check_more_rocks,0

			; save the fact the rock is checking the king
			lea di,array_of_what_pieces_check_the_king
			add di,2
			mov al,1
			mov [di],al
			inc count_checks
			
			ret

			there_is_no_black_king_standing_there_for_rock:
				; reset the array of the squares that the rock check can be blocked
				mov bx,0
				lea bx,array_of_squares_that_the_rock_controls_in_direction_of_the_check
				call reset_the_array_in_the_bx
				ret

		check_if_the_white_king_standing_therein_the_rock_checking:
			; check if there is enemy king in the last square
			mov al,29
			cmp last_location_to_compare,al
			jne there_is_no_white_king_standing_there_for_rock
		
			; trun off last square because the king is standing there
			mov al,0
			mov [bx],al
			mov need_to_check_more_rocks,0

			; save the fact the rock is checking the king
			lea di,array_of_what_pieces_check_the_king
			add di,2
			mov al,1
			mov [di],al
			inc count_checks
			ret
			there_is_no_white_king_standing_there_for_rock:
				; reset the array of the squares that the rock check can be blocked
				lea bx,array_of_squares_that_the_rock_controls_in_direction_of_the_check
				call reset_the_array_in_the_bx
				ret
		
		dont_mess_up_anything:
			ret
	cehck_if_the_last_square_hitting_is_the_king_for_rock endp

endp

king_moves_section:
	; this func is checking what are the legal moves for the king and saves them in the array of legal moves for this piece
	check_if_the_mov_is_leagal_for_the_king proc
		; check if the function was called from the king function and skips the checks for all of the other piece sos the king
		; wont go to a place that eat can be eaten i do this skip so the code wont be recursive and endless
		cmp when_chking_squares_controlled_dont_do_certain_code,0
		jne there_is_no_need_to_check_anything ; this is beacuase i use the same function to check the legal moves of the opnent and if this wont be here there will be infinite recurtion	
		
		; check all of the squares that the opnent controls:
		call resrt_the_array_of_the_squares_the_opnent_controlls
		call create_array_of_squres_conroled_by_the_enmy_pieces

		jmp turn_of_the_moves_that_are_in_enemy_pieces_control
	
		there_is_no_need_to_check_anything:
			; check only the base movement of the king
			call check_the_base_moves_that_king_can_move_by_piece_movement
			ret 
		
		turn_of_the_moves_that_are_in_enemy_pieces_control:
			; check the base moves of the king and turn off moves that the emenmy pieces controlls
			call check_the_base_moves_that_king_can_move_by_piece_movement
			call turn_of_the_moves_that_are_in_enemy_pieces_control_function

			mov al,1
			cmp king_is_check_for_checks_mode,al
			je the_king_is_in_check_mode

			; check if the king can also castle
			call check_if_can_castle
			call turn_of_the_moves_that_are_in_enemy_pieces_control_function
			
			the_king_is_in_check_mode:
				mov al,1
				mov need_to_check_more_pawns,al
				mov need_to_check_more_bishops,al
				mov need_to_check_more_rocks,al

			ret 
	check_if_the_mov_is_leagal_for_the_king endp


	; this function is checking what are the basic moves of the king and put them in the array of legal moves for this piece
	check_the_base_moves_that_king_can_move_by_piece_movement proc
		lea si,array_of_legal_moves_for_all_off_the_picess
		
		; get the pointer to point at the place of the king
		mov ax,0
		mov al,firts_mouse_press_location
		add si,ax
		dec si

		king_moves_one_square_to_the_right:
			; check if the king can move to the right
			mov ax,0
			mov al,firts_mouse_press_location
			mov cl,8
			div cl 

			cmp ah, 0
			je king_moves_one_square_to_the_left

			mov number_of_squares,1
			call get_king_move_to_spesific_direction

		king_moves_one_square_to_the_left:
			; check if the king can move to the left
			mov ax,0
			mov al,firts_mouse_press_location
			mov cl,8
			div cl

			cmp ah, 1
			je king_moves_one_square_to_the_up

			mov number_of_squares,-1
			call get_king_move_to_spesific_direction

		king_moves_one_square_to_the_up:
			; check if the king can move to the up
			mov ax,0
			mov al,firts_mouse_press_location
		
			cmp al, 55
			jg king_moves_one_square_to_the_dawn

			mov number_of_squares,8
			call get_king_move_to_spesific_direction

		king_moves_one_square_to_the_dawn:
			; check if the king can move to the dawn
			cmp al, 9
			jl king_moves_one_square_to_the_left_upper_corner

			mov number_of_squares,-8
			call get_king_move_to_spesific_direction
		
		king_moves_one_square_to_the_left_upper_corner:
			; check if the king can move to the left up
			mov ax,0
			mov al,firts_mouse_press_location
			mov cl,8
			div cl

			cmp ah, 1
			je king_moves_one_square_to_the_right_upper_corner

			mov ax,0
			mov al,firts_mouse_press_location

			cmp al, 10
			jl king_moves_one_square_to_the_right_upper_corner
			
			mov number_of_squares,-9
			call get_king_move_to_spesific_direction

		king_moves_one_square_to_the_right_upper_corner:
			; check if the king can move to the right up
			mov ax,0
			mov al,firts_mouse_press_location
			mov cl,8
			div cl

			cmp ah, 0
			je king_moves_one_square_to_the_right_lower_corner

			mov ax,0
			mov al,firts_mouse_press_location

			cmp al, 9
			jl king_moves_one_square_to_the_right_lower_corner
			
			mov number_of_squares,-7
			call get_king_move_to_spesific_direction
		
		king_moves_one_square_to_the_right_lower_corner:
			; check if the king can move to the right dawn
			mov ax,0
			mov al,firts_mouse_press_location
			mov cl,8
			div cl

			cmp ah, 0
			je king_moves_one_square_to_the_left_lower_corner

			mov ax,0
			mov al,firts_mouse_press_location

			cmp al, 54
			jg king_moves_one_square_to_the_left_lower_corner
			
			mov number_of_squares,9
			call get_king_move_to_spesific_direction
		
		king_moves_one_square_to_the_left_lower_corner:
			; check if the king can move to the left dawn
			mov ax,0
			mov al,firts_mouse_press_location
			mov cl,8
			div cl

			cmp ah,1
			je end_king_moves_one_square_to_the_left_lower_corner

			mov ax,0
			mov al,firts_mouse_press_location

			cmp al, 55
			jg end_king_moves_one_square_to_the_left_lower_corner
			
			mov number_of_squares,7
			call get_king_move_to_spesific_direction

		end_king_moves_one_square_to_the_left_lower_corner:

		ret
	check_the_base_moves_that_king_can_move_by_piece_movement endp


	; move certain number of squares that in the ( number_of_squares ) var and make the square there legal in the array of legal moves for this piece
	get_king_move_to_spesific_direction proc
		add si,number_of_squares
		mov dl,1
		mov [si],dl
		sub si,number_of_squares
		ret
	get_king_move_to_spesific_direction endp


	; this function is checking what is the king color and get the right valus in the vars ( specail_one_use_counter_for_the_king , the_final_piece_to_check )
	; and than calling the function create_an_array_of_the_enemy_piece_controled_squares_template_for_both_sides to actouly detect what are the squares that the 
	; the enmey controls
	create_array_of_squres_conroled_by_the_enmy_pieces proc 
		call check_what_colored_piece_was_pressed
		mov al,first_piece_pressed_color
		cmp al,0
		je check_all_of_the_legal_white_moves
		cmp al,1
		je check_all_of_the_legal_black_moves

		check_all_of_the_legal_black_moves:
			mov specail_one_use_counter_for_the_king, 0
			mov the_final_piece_to_check,16
			call create_an_array_of_the_enemy_piece_controled_squares_template_for_both_sides
			ret
		check_all_of_the_legal_white_moves:
			mov specail_one_use_counter_for_the_king, 16
			mov the_final_piece_to_check,32
			call create_an_array_of_the_enemy_piece_controled_squares_template_for_both_sides
			ret	
	create_array_of_squres_conroled_by_the_enmy_pieces endp


	; this function is decting what are the enemy pieces moves and putting all of this moves in the array ( array_of_all_opnnents_squares_that_are_controlled ) 
	create_an_array_of_the_enemy_piece_controled_squares_template_for_both_sides proc 
		; save this values:
		mov ax,0
		mov al,firts_mouse_press_location_piece
		push ax
		mov ax,0
		mov al,firts_mouse_press_location
		push ax

		loop_for_each_move:
			; inc the values to the next values
			mov the_piece_does_not_exists,0
			inc specail_one_use_counter_for_the_king
			mov al,specail_one_use_counter_for_the_king
			mov firts_mouse_press_location_piece,al

			; get the lcoation of the pieces in the right vars
			call get_the_location_of_the_piece
		
			; if the piece was eaten and now there is no piece like that than skip this part
			cmp the_piece_does_not_exists,1
			je skip_evry_thing_because_piece_does_not_exists

			call reset_the_array_of_legal_moves
			mov when_chking_squares_controlled_dont_do_certain_code,1
		
			; check what are the squares that the piece controls and transfters them to the array ( array_of_all_opnnents_squares_that_are_controlled )
			call check_what_leagal_moves_there_are_for_this_piece
			call transefar_the_array_of_legal_to_the_array_of_squares_that_the_oponetnt_controlls
			mov when_chking_squares_controlled_dont_do_certain_code,0

			skip_evry_thing_because_piece_does_not_exists:
				mov al,the_final_piece_to_check
				cmp specail_one_use_counter_for_the_king,al
				jne loop_for_each_move
		
		call reset_the_array_of_legal_moves

		;restore the right values to the right vars:
		pop ax
		mov firts_mouse_press_location,al
		pop ax
		mov firts_mouse_press_location_piece,al
		ret
	create_an_array_of_the_enemy_piece_controled_squares_template_for_both_sides endp


	; this function is throught the arr ( array_of_legal_moves_for_all_off_the_picess ) and activate the legal moves in the arr 
	; ( array_of_all_opnnents_squares_that_are_controlled )
	transefar_the_array_of_legal_to_the_array_of_squares_that_the_oponetnt_controlls proc 
		lea si, array_of_all_opnnents_squares_that_are_controlled
		lea di, array_of_legal_moves_for_all_off_the_picess
		mov dx,0

		loop_to_move_all_of_the_first_array_to_the_second: 
			; check if the move is legal
			mov bl,[di]
			cmp bl,0
			je dont_need_to_trasefer

			mov [si],bl
			dont_need_to_trasefer:		;dont need to transfer all of the zeros because we dont wont to earse anything
				inc si
				inc di
				inc dx
				cmp dx,64
				jne loop_to_move_all_of_the_first_array_to_the_second

		ret
	transefar_the_array_of_legal_to_the_array_of_squares_that_the_oponetnt_controlls endp


	; check what is the location of the piece that in the ( firts_mouse_press_location_piece ) var and puts location
	; in the var ( firts_mouse_press_location ) if the piece does not exists than turning the flag that says that piece does not exists
	get_the_location_of_the_piece proc
		lea si,where_is_each_piece
		mov counter1,0
		
		get_the_piece_location_to_the_location_var:
			inc counter1
			mov al, firts_mouse_press_location_piece
			cmp [si],al
			jne dont_update_the_piece_location

			mov al,counter1
			mov firts_mouse_press_location,al
			ret
			dont_update_the_piece_location:
				inc si 
				mov al,64
				cmp counter1,al
				jne get_the_piece_location_to_the_location_var

		mov the_piece_does_not_exists,1
		ret
	get_the_location_of_the_piece endp


	; the function is resting the array ( array_of_all_opnnents_squares_that_are_controlled )
	resrt_the_array_of_the_squares_the_opnent_controlls proc 
		lea si,array_of_all_opnnents_squares_that_are_controlled
		mov counter1, 0

		loop_to_reset_this_array:
			inc counter1
			mov al,0
			mov [si],al
			inc si
			cmp counter1,64
			jne loop_to_reset_this_array

		ret
	resrt_the_array_of_the_squares_the_opnent_controlls endp


	; this function is using the array ( array_of_all_opnnents_squares_that_are_controlled ) and turn off the king moves that run into 
	; a place that the enemy controls
	turn_of_the_moves_that_are_in_enemy_pieces_control_function proc
		lea si,array_of_legal_moves_for_all_off_the_picess
		lea di,array_of_all_opnnents_squares_that_are_controlled
		mov counter1, 0

		loop_to_that_turn_of_ilegal_king_moves:
			; check if the enemy controls the square
			mov al,1
			cmp [di],al
			jne no_need_to_turn_of_the_move

			; if its controlling than turn off the move
			mov al,0
			mov [si],al
			no_need_to_turn_of_the_move:
				inc si
				inc di
				inc counter1
				mov al,64
				cmp counter1,64
				jne loop_to_that_turn_of_ilegal_king_moves
		ret 
	turn_of_the_moves_that_are_in_enemy_pieces_control_function endp


	; check if the king can castle and turn on the castling moves that are legal
	check_if_can_castle proc 
		mov al,1
		cmp check_for_moves_that_block_the_check,al
		jne mybe_the_king_can_castle
		ret

		mybe_the_king_can_castle:
			; check if the black king can needs to be check or the white
			lea si,array_of_legal_moves_for_all_off_the_picess
			lea di,where_is_each_piece
			call check_what_colored_piece_was_pressed
			cmp first_piece_pressed_color,0
			je black_king_casteling

			call white_king_casteling
			ret
		black_king_casteling:
			; checking all of the necessary checks to make sure short caslting posible
			lea si,array_of_legal_moves_for_all_off_the_picess
			add si,5
			mov al,1
			cmp [si],al
			jne cant_castle_short_for_black
			
			lea di,where_is_each_piece
			add di,5
			mov al,0
			cmp [di],al
			jne cant_castle_short_for_black

			add di,1
			mov al,0
			cmp [di],al
			jne cant_castle_short_for_black
			
			add di,1
			mov al,8
			cmp [di],al
			jne cant_castle_short_for_black

			lea si,array_of_rocks_taht_are_abel_to_castle
			add si,1
			mov al,1
			cmp [si],al
			jne cant_castle_short_for_black

			; check if the king can castle at all
			lea si, array_of_kings_that_are_abel_to_castle
			mov ax,0
			cmp [si],al
			je cant_castle_long_for_black

			lea di,where_is_each_piece
			add di,4
			mov al,5
			cmp [di],al
			jne cant_castle_long_for_black

			short_castling_black:
				; make short castling legal
				lea si,array_of_legal_moves_for_all_off_the_picess
				add si,6
				mov al,1
				mov [si],al

			cant_castle_short_for_black:
				; checking all of the necessary checks to make sure long caslting posible
				lea si,array_of_rocks_taht_are_abel_to_castle
				mov al,1
				cmp [si],al
				jne cant_castle_long_for_black

				lea si, array_of_legal_moves_for_all_off_the_picess
				add si,4
				dec si
				mov al,1
				cmp [si],al
				jne cant_castle_long_for_black
			
				lea di, where_is_each_piece
				add di,4
				sub di,1
				mov al,0
				cmp [di],al
				jne cant_castle_long_for_black

				sub di,1
				sub al,0
				cmp [di],al
				jne cant_castle_long_for_black
				
				sub di,1
				sub al,0
				cmp [di],al
				jne cant_castle_long_for_black

				sub di,1
				mov al,1
				cmp [di],al
				jne cant_castle_long_for_black

			long_castling_black:
				; make long castling legal
				lea si,array_of_legal_moves_for_all_off_the_picess
				add si,2
				mov al,1
				mov [si],al

			cant_castle_long_for_black:			
				ret
	check_if_can_castle endp 


	; check if the white king castle
	white_king_casteling proc
		; checking all of the necessary checks to make sure short caslting posible
		lea si,array_of_legal_moves_for_all_off_the_picess
		add si,61
		mov al,1
		cmp [si],al
		jne cant_castle_short_for_white
		
		lea di,where_is_each_piece
		add di,61
		mov al,0
		cmp [di],al
		jne cant_castle_short_for_white

		add di,1
		mov al,0
		cmp [di],al
		jne cant_castle_short_for_white
		
		add di,1
		mov al,32
		cmp [di],al
		jne cant_castle_short_for_white

		lea si,array_of_rocks_taht_are_abel_to_castle
		add si,3
		mov al,1
		cmp [si],al
		jne cant_castle_short_for_white
		
		;check if king castle at all
		lea si, array_of_kings_that_are_abel_to_castle
		inc si
		mov ax,0
		cmp [si],al
		je cant_castle_long_for_white

		lea di,where_is_each_piece
		add di,60
		mov al,29
		cmp [di],al
		jne cant_castle_long_for_white

		short_castling_white:
			; make short castling posible
			lea si,array_of_legal_moves_for_all_off_the_picess
			add si,62
			mov al,1
			mov [si],al
		cant_castle_short_for_white:
			; checking all of the necessary checks to make sure long caslting posible
			lea si,array_of_rocks_taht_are_abel_to_castle
			add si,2
			mov al,1
			cmp [si],al
			jne cant_castle_long_for_white

			lea si, array_of_legal_moves_for_all_off_the_picess
			dec si
			mov al,1
			cmp [si],al
			jne cant_castle_long_for_white
		
			lea di, where_is_each_piece
			add di,60
			sub di,1
			mov al,0
			cmp [di],al
			jne cant_castle_long_for_white

			sub di,1
			sub al,0
			cmp [di],al
			jne cant_castle_long_for_white
			
			sub di,1
			sub al,0
			cmp [di],al
			jne cant_castle_long_for_white

			sub di,1
			mov al,25
			cmp [di],al
			jne cant_castle_long_for_white

		long_castling_white:
			lea si,array_of_legal_moves_for_all_off_the_picess
			add si,58
			mov al,1
			mov [si],al

		cant_castle_long_for_white:			
			ret

	white_king_casteling endp


	; this function is checking if the king is in check
	check_if_king_is_in_check proc
		mov al,1
		mov king_is_check_for_checks_mode,al

		lea bx,array_of_squares_that_the_kngiht_controls_in_direction_of_the_check
		call reset_the_array_in_the_bx

		lea bx,array_of_squares_that_the_pawn_controls_in_direction_of_the_check
		call reset_the_array_in_the_bx
		
		;save the data:
		mov ax,0
		mov al,firts_mouse_press_location_piece
		push ax
		mov ax,0
		mov al,firts_mouse_press_location
		push ax
		
		; check if needs to be checked for black or white
		call check_what_colored_piece_was_pressed
		mov al,1
		cmp first_piece_pressed_color,0
		je replace_the_piece_with_black_king
		jmp replace_the_piece_with_white_king
		
		; get the the right vals for the the vars of the location and of the piece
		replace_the_piece_with_black_king:
			mov firts_mouse_press_location_piece, 5 
			call get_the_location_of_the_piece
			jmp end_replacing_the_kings

		replace_the_piece_with_white_king:
			mov firts_mouse_press_location_piece, 29
			call get_the_location_of_the_piece
			jmp end_replacing_the_kings

		end_replacing_the_kings:
			call check_if_the_mov_is_leagal_for_the_king
			call reset_the_array_of_legal_moves

		lea di,array_of_all_opnnents_squares_that_are_controlled
		mov ax,0
		mov al,firts_mouse_press_location
		add di,ax
		dec di
		
		;get the data back
		pop ax
		mov firts_mouse_press_location,al
		pop ax
		mov firts_mouse_press_location_piece,al

		mov al,0
		mov king_is_check_for_checks_mode,0

		; checking if the king place is controled by enemy piece
		mov al,1
		cmp [di],al
		je the_king_in_check

		mov count_checks,0
		ret

		the_king_in_check:
			; check if the king in double check or not
			mov ax,0
			mov al,firts_mouse_press_location_piece
			cmp al,5
			je the_piece_is_king_so_maybe_there_legal_moves
			cmp al,29
			je the_piece_is_king_so_maybe_there_legal_moves

			mov ax,2
			cmp count_checks,al
			jl the_piece_is_king_so_maybe_there_legal_moves

			mov check_for_moves_that_block_the_check,1
			mov king_is_in_check_flag,1
			mov count_checks,0
			ret

			the_piece_is_king_so_maybe_there_legal_moves:
				mov check_for_moves_that_block_the_check,1
				mov count_checks,0
				call load_the_pointer_with_the_allowed_places
				call reset_the_array_of_what_pieces_are_checking
				ret
		
	check_if_king_is_in_check endp 


	; this fnction is checking if the pieces that moved is the king and update the king in the array of kings that moved
	update_the_array_of_kings_that_moved proc
		mov ax,0
		mov al,firts_mouse_press_location_piece
		cmp al,5
		je the_moving_piece_is_black_king

		cmp al,29
		je the_moving_piece_is_white_king

		ret
		the_moving_piece_is_black_king:
			lea si, array_of_kings_that_are_abel_to_castle
			mov al,0
			mov [si],al
			ret
		the_moving_piece_is_white_king:
			lea si, array_of_kings_that_are_abel_to_castle
			inc si
			mov al,0
			mov [si],al
			ret
	update_the_array_of_kings_that_moved endp


	; this func is checking what is the king value of the king in the color of your side
	check_what_is_the_king_value proc
		call check_what_colored_piece_was_pressed
		mov al,first_piece_pressed_color
		cmp al,1
		je black_king

		white_king:
			mov al,29
			mov king_value,al
			ret
		black_king:
			mov al,5
			mov king_value,al
			ret
	check_what_is_the_king_value endp 


	; reseting the array of the pieces that check the king
	reset_the_array_of_what_pieces_are_checking proc
		lea bx,array_of_what_pieces_check_the_king
		mov counter1,0
		mov al,4
		mov cl,0

		loop_to_reset_this_array_of_pieces:
			inc counter1
			mov [bx],cl
			inc bx
			cmp counter1,al
			jne loop_to_reset_this_array_of_pieces

		ret
	reset_the_array_of_what_pieces_are_checking endp 


	; this function is checking if the move that was played is blocing the check to your king or not
	check_is_this_piece_moves_block_the_check proc
		; if the move is of the king so this is not needed
		cmp firts_mouse_press_location_piece,5
		je the_end_of_the_func
		cmp firts_mouse_press_location_piece,29
		je the_end_of_the_func

		mov si, pointer_to_the_array_off_places
		lea di, array_of_legal_moves_for_all_off_the_picess
		mov bx,0
		mov counter1,0
		mov al,64
		mov cl,1
		mov dl,0

		loop_that_turnes_off_the_moves_that_dont_block_check:
			inc counter1

			; checking if the block the check and it is legal
			cmp [si],cl
			je dont_turn_off_the_move

			mov [di],dl
			dont_turn_off_the_move:
				inc si
				inc di
				cmp counter1,al
				jne loop_that_turnes_off_the_moves_that_dont_block_check
		
		the_end_of_the_func:
			ret
	check_is_this_piece_moves_block_the_check endp


	; this function is using the array of piece that check the king and load the var pointer called ( pointer_to_the_array_off_places )
	; with the corect array of the places that the user can block the check in them
	load_the_pointer_with_the_allowed_places proc
		lea si,array_of_what_pieces_check_the_king

		mov al,1
		cmp [si],al
		je the_pointer_need_the_knight_array

		mov al,1
		inc si
		cmp [si],al
		je the_pointer_need_the_bishop_array

		mov al,1
		inc si
		cmp [si],al
		je the_pointer_need_the_rock_array

		mov al,1
		inc si
		cmp [si],al
		je the_pointer_need_the_pawn_array

		the_pointer_need_the_knight_array:
			lea bx, array_of_squares_that_the_kngiht_controls_in_direction_of_the_check
			mov pointer_to_the_array_off_places, bx
			ret
		
		the_pointer_need_the_bishop_array:
			lea bx, array_of_squares_that_the_bishop_controls_in_direction_of_the_check
			mov pointer_to_the_array_off_places, bx
			ret
		
		the_pointer_need_the_rock_array:
			lea bx, array_of_squares_that_the_rock_controls_in_direction_of_the_check
			mov pointer_to_the_array_off_places, bx
			ret
		
		the_pointer_need_the_pawn_array:
			lea bx, array_of_squares_that_the_pawn_controls_in_direction_of_the_check
			mov pointer_to_the_array_off_places, bx
			ret
		
	load_the_pointer_with_the_allowed_places endp 
endp


; this function is dtawing squres around the square number that is represented in
; the var (legal_location_that_needs_to_be_printed)
; (1 - 64 are the numbers that represent the squares on the board)
print_square_around_the_legal_moves proc
	;this part is getting the cordinates of the location that the function wants to draw the square in:
	mov ax,0
	mov al, legal_location_that_needs_to_be_printed		
	dec al
	mov bx,8
	div bl

	lea si, array_of_each_spot_x
	mov bx,0
	mov bl,ah
	add si, bx
	add si, bx
	mov cx,[si]
	mov first_leagal_square_value_of_x, cx

	lea si, array_of_each_spot_y
	mov bx,0
	mov bl,al
	add si, bx
	add si,bx
	mov dx,[si]
	cmp dx,2
	je dont_dec_the_dx_by_3_because_there_will_be_a_minus
	sub dx,1

	dont_dec_the_dx_by_3_because_there_will_be_a_minus:
		sub dx,2
		mov first_leagal_square_value_of_y,dx

	;this part is drawing the acuatel square in the right position:
	mov al,the_color_of_the_lgal_moves_squres_that_show_up
	mov cx,0
	
	draw_the_leagal_square_option_up_part: 
		inc cx						  ;move to the next pixel
		add cx,first_leagal_square_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		sub cx,first_leagal_square_value_of_x  ;remove the reltive value
		cmp cx,50					  ;check if cx is 50
		jne draw_the_leagal_square_option_up_part	   ;repeat the loop if not final pixel

	mov cx, first_leagal_square_value_of_x
	inc cx
	mov dx,-1
	draw_the_leagal_square_option_left_part: 
		inc dx						  ;move to the next pixel
		add dx,first_leagal_square_value_of_y  ;add the reltive value of the king i want to print
		call draw_pixel
		sub dx,first_leagal_square_value_of_y  ;remove the reltive value
		cmp dx,49					  ;check if cx is 50
		jne draw_the_leagal_square_option_left_part	   ;repeat the loop if not final pixel

	add dx,first_leagal_square_value_of_y
	sub cx, first_leagal_square_value_of_x
	draw_the_leagal_square_option_dawn_part: 
		inc cx						  ;move to the next pixel
		add cx,first_leagal_square_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		sub cx,first_leagal_square_value_of_x  ;remove the reltive value
		cmp cx,50					  ;check if cx is 50
		jne draw_the_leagal_square_option_dawn_part	   ;repeat the loop if not final pixel
	
	add cx,first_leagal_square_value_of_x
	sub dx, first_leagal_square_value_of_y
	draw_the_leagal_square_option_right_part: 
		dec dx						  ;move to the next pixel
		add dx,first_leagal_square_value_of_y  ;add the reltive value of the king i want to print
		call draw_pixel
		sub dx,first_leagal_square_value_of_y  ;remove the reltive value
		cmp dx,0					  ;check if cx is 50
		jne draw_the_leagal_square_option_right_part	   ;repeat the loop if not final pixel

	ret
print_square_around_the_legal_moves endp


; reset the place that the inturpt ( mov dl,?, mov ah,2 int 21h ) prints in 
reset_the_cursor proc
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov dl,0
	mov dh,0
	mov bh,0
	mov ah,02h
	int 10h
	;;;;;;;;;;;;;;;;;;;;;;;;;
	ret
reset_the_cursor endp


; this function just print the char that in dl
print_char proc 
	mov ah,2
	int 21h
	ret
print_char endp 


; this place is printing all of pieces in the game ( pixel art ):
; ( all of this funtions are getting the x in the cx register and the y in the dx register and draws acording to this info) :
pixel_art_section:
	draw_pawn proc 
		; i use the notes cordinates to indicate from (1,1) to (50,50)  
		
		mov cx,24					  ;set x to 25
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,25					  ;set x to 26
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 4
		mov cx,21					  ;set x to 22
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,22					  ;set x to 23
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,23					  ;set x to 24
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,26					  ;set x to 27
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,27					  ;set x to 28
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,28					  ;set x to 29
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 5
		mov cx,19					  ;set x to 20
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,20					  ;set x to 21
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,21					  ;set x to 22
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,28					  ;set x to 29
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,29					  ;set x to 30
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,30					  ;set x to 31
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1 					  ;sets y to 6
		mov cx,17					  ;set x to 18
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,18					  ;set x to 19
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,19					  ;set x to 20
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,30					  ;set x to 31
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,31					  ;set x to 32
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,32					  ;set x to 33
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 7
		mov cx,16					  ;set x to 17
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,17					  ;set x to 18
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,32					  ;set x to 33
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,33					  ;set x to 34
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 8
		mov cx,15					  ;set x to 16
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,16					  ;set x to 17
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,22					  ;set x to 23
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,23					  ;set x to 24
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,24					  ;set x to 25
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,25					  ;set x to 26
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,26					  ;set x to 27
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,27					  ;set x to 28
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,33					  ;set x to 34
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,34					  ;set x to 35
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 9
		mov cx,15					  ;set x to 16
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,21					  ;set x to 22
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,22					  ;set x to 23
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,23					  ;set x to 24
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,26					  ;set x to 27
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,27					  ;set x to 28
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,28					  ;set x to 29
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,34					  ;set x to 35
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 10
		mov cx,14					  ;set x to 15
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,20					  ;set x to 21
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,21					  ;set x to 22
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,28					  ;set x to 29
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,29					  ;set x to 30
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,35					  ;set x to 36
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 11
		mov cx,14					  ;set x to 15
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,20					  ;set x to 21
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,29					  ;set x to 30
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,35					  ;set x to 36
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 12
		mov cx,14					  ;set x to 15
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,20					  ;set x to 21
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,29					  ;set x to 30
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,35					  ;set x to 36
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 13
		mov cx,14					  ;set x to 15
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,20					  ;set x to 21
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,29					  ;set x to 30
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,35					  ;set x to 36
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 14
		mov cx,14					  ;set x to 15
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,20					  ;set x to 21
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,21					  ;set x to 22
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,28					  ;set x to 29
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,29					  ;set x to 30
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,35					  ;set x to 36 
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 15
		mov cx,14					  ;set x to 15
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,21					  ;set x to 22
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,22					  ;set x to 23
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,27					  ;set x to 28
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,28					  ;set x to 29
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,35					  ;set x to 36
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 17
		mov cx,15					  ;set x to 16
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,22					  ;set x to 23
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,23					  ;set x to 24
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,26					  ;set x to 27
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,27					  ;set x to 28
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,34					  ;set x to 35
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 18
		mov cx,16					  ;set x to 17
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,17					  ;set x to 18
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,32					  ;set x to 33
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,33					  ;set x to 34
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1 					  ;set y to 19
		mov cx,17					  ;set x to 18
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,18					  ;set x to 19
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,19					  ;set x to 20
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,30					  ;set x to 31
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,31					  ;set x to 32
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,32					  ;set x to 33
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 20
		mov cx,20					  ;set x to 21
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,29					  ;set x to 30
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 21
		mov cx,21					  ;set x to 22
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,28					  ;set x to 29
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 22
		mov cx,21					  ;set x to 22
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,28					  ;set x to 29
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 23
		mov cx,21					  ;set x to 22
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,28					  ;set x to 29
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 24
		mov cx,21					  ;set x to 22
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,28					  ;set x to 29
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 215
		mov cx,21					  ;set x to 22
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,28					  ;set x to 29
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 26
		mov cx,21					  ;set x to 22
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,28					  ;set x to 29
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 27
		mov cx,21					  ;set x to 22
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,28					  ;set x to 29
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 28
		mov cx,21					  ;set x to 22
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,28					  ;set x to 29
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 29
		mov cx,20					  ;set x to 21
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,21					  ;set x to 22
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,28					  ;set x to 29
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,29					  ;set x to 30
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 30
		mov cx,20					  ;set x to 21
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,29					  ;set x to 30
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 31
		mov cx,20					  ;set x to 21
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,29					  ;set x to 30
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 32
		mov cx,20					  ;set x to 21
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,29					  ;set x to 30
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 33
		mov cx,19					  ;set x to 20
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,20					  ;set x to 21
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		
		mov cx,29					  ;set x to 30
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,30					  ;set x to 31
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 34
		mov cx,19					  ;set x to 20
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,30					  ;set x to 31
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 35
		mov cx,19					  ;set x to 20
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,30					  ;set x to 31
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 36
		mov cx,19					  ;set x to 20
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,30					  ;set x to 31
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 37
		mov cx,18					  ;set x to 19
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,19					  ;set x to 20
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,30					  ;set x to 31
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,31					  ;set x to 32
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 38
		mov cx,17					  ;set x to 18
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,18					  ;set x to 19
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,31					  ;set x to 32
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,32					  ;set x to 33
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 39
		mov cx,16					  ;set x to 17
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,17					  ;set x to 18
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,32					  ;set x to 33
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,33					  ;set x to 34
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 40
		mov cx,13					  ;set x to 14
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print 
		call draw_pixel
		add cx,1					  

		call draw_pixel
		add cx,1
		
		call draw_pixel
		add cx,1
		
		call draw_pixel
		add cx,1
		
		call draw_pixel
		add cx,1
		
		call draw_pixel
		add cx,1
		
		call draw_pixel
		add cx,1
		
		call draw_pixel
		add cx,1
		
		call draw_pixel
		add cx,1
		
		call draw_pixel
		add cx,1
		
		call draw_pixel
		add cx,1
		
		call draw_pixel
		add cx,1
		
		call draw_pixel
		add cx,1
		
		call draw_pixel
		add cx,1
		
		call draw_pixel
		add cx,1
		
		call draw_pixel
		add cx,1
		
		call draw_pixel
		add cx,1
		
		call draw_pixel
		add cx,1
		
		call draw_pixel
		add cx,1
		
		call draw_pixel
		add cx,1
		
		call draw_pixel
		add cx,1
		
		call draw_pixel
		add cx,1
		
		call draw_pixel
		add cx,1
		
		call draw_pixel
		add cx,1
		
		add dx,1					  ;set y to 41
		mov cx,10					  ;set x to 11
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,11					  ;set x to 12
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,12					  ;set x to 13
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,13					  ;set x to 14
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,36					  ;set x to 37
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,37					  ;set x to 38
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,38					  ;set x to 39
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,39					  ;set x to 40
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 42
		mov cx,8					  ;set x to 9
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,9					  ;set x to 10
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,10					  ;set x to 11
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,39					  ;set x to 40
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,40					  ;set x to 41
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,41					  ;set x to 42
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 43
		mov cx,6					  ;set x to 7
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,7					  ;set x to 8
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,8					  ;set x to 9
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,41					  ;set x to 42
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,42					  ;set x to 43
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,43					  ;set x to 44
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1					  ;set y to 44
		mov cx,6					  ;set x to 7
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,7					  ;set x to 8
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,42					  ;set x to 43
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		mov cx,43					  ;set x to 44
		add cx,first_pawn_value_of_x  ;add the reltive value of the pawn i want to print
		call draw_pixel
		
		add dx,1 					  ;set y to 45
		mov cx,6					  ;set x to 7
		add cx,first_pawn_value_of_x  ;add x reltive x pawn value
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		call draw_pixel
		inc cx 						 ;inc x cordinates to next value
		
		add dx,5					  ;solve a problem with drawing the board
		add cx,13					  ;solve a problem with drawing the board
		
		ret 						  

	draw_pawn endp
		

	draw_king proc
		mov cx,24					  ;set x to 25
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,25					  ;set x to 26
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx						  ;set y to 4
		mov cx,24					  ;set x to 25
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,25					  ;set x to 26
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx						  ;set y to 5
		mov cx,24					  ;set x to 25
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,25					  ;set x to 26
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx						  ;set y to 6
		mov cx,22					  ;set x to 23
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,23					  ;set x to 24
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,24					  ;set x to 25
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,25					  ;set x to 26
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,26					  ;set x to 27
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,27					  ;set x to 28
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx						  ;set y to 7
		mov cx,22					  ;set x to 23
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,23					  ;set x to 24
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,24					  ;set x to 25
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,25					  ;set x to 26
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,26					  ;set x to 27
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,27					  ;set x to 28
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx						  ;set y to 8
		mov cx,18					  ;set x to 19
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
			
		mov cx,19					  ;set x to 20
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,24					  ;set x to 25
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,25					  ;set x to 26
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,30					  ;set x to 31
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,31					  ;set x to 32
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx						  ;set y to 9
		mov cx,16					  ;set x to 17
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,17					  ;set x to 18
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,18					  ;set x to 19
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,19					  ;set x to 20
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,20					  ;set x to 21
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,21					  ;set x to 22
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,24					  ;set x to 25
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,25					  ;set x to 26
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,28					  ;set x to 29
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,29					  ;set x to 30
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,30					  ;set x to 31
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,31					  ;set x to 32
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,32					  ;set x to 33
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,33					  ;set x to 34
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx						  ;set y to 10
		mov cx,13					  ;set x to 15
		
		draw_king_line_10_first_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,22					  ;check if cx is 23 
			jne draw_king_line_10_first_part   ;repeat the loop if not final pixel
		
		mov cx,24					  ;set the x to 25
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel

		mov cx,25					  ;set the x to 26
		add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,26					  ;set x to 27
		
		draw_king_line_10_second_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,35					  ;check if cx is 36 
			jne draw_king_line_10_second_part   ;repeat the loop if not final pixel
		
		inc dx						  ;set y to 11
		mov cx,11					  ;set x to 13
		
		draw_king_line_11: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,37					  ;check if cx is 38 
			jne draw_king_line_11		      ;repeat the loop if not final pixel
			
		inc dx						  ;set y to 12
		mov cx,11					  ;set x to 11
		
		draw_king_line_12: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,37					  ;check if cx is 38 
			jne draw_king_line_12		      ;repeat the loop if not final pixel
		
		inc dx						  ;set y to 13
		mov cx,10					  ;set x to 10
		
		draw_king_line_13: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,38					  ;check if cx is 39 
			jne draw_king_line_13		      ;repeat the loop if not final pixel
		
		inc dx						  ;set y to 14
		mov cx,10					  ;set x to 10
		
		draw_king_line_14: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,38					  ;check if cx is 39 
			jne draw_king_line_14		      ;repeat the loop if not final pixel
		
		inc dx						  ;set y to 15
		mov cx,9					  ;set x to 10
		
		draw_king_line_15_first_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,16					  ;check if cx is 39 
			jne draw_king_line_15_first_part;repeat the loop if not final pixel
		
		mov cx,20					  ;set x to 21
		
		draw_king_line_15_second_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,30					  ;check if cx is 39 
			jne draw_king_line_15_second_part;repeat the loop if not final pixel
		
		mov cx,33					  ;set x to 34
		
		draw_king_line_15_third_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,40					  ;check if cx is 39 
			jne draw_king_line_15_third_part;repeat the loop if not final pixel
		
		inc dx						  ;set y to 16
		mov cx,9					  ;set x to 10
		
		draw_king_line_16_first_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,15					  ;check if cx is 39 
			jne draw_king_line_16_first_part;repeat the loop if not final pixel
		
		mov cx,21					  ;set x to 22
		
		draw_king_line_16_second_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,28					  ;check if cx is 39 
			jne draw_king_line_16_second_part;repeat the loop if not final pixel
		
		mov cx,34					  ;set x to 35
		
		draw_king_line_16_third_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,40					  ;check if cx is 39 
			jne draw_king_line_16_third_part;repeat the loop if not final pixel
		
		inc dx						  ;set y to 17
		mov cx,9					  ;set x to 10
		
		draw_king_line_17_first_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,14					  ;check if cx is 39 
			jne draw_king_line_17_first_part;repeat the loop if not final pixel
		
		mov cx,22					  ;set x to 22
		
		draw_king_line_17_second_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,27					  ;check if cx is 39 
			jne draw_king_line_17_second_part;repeat the loop if not final pixel
		
		mov cx,35					  ;set x to 35
		
		draw_king_line_17_third_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,40					  ;check if cx is 39 
			jne draw_king_line_17_third_part;repeat the loop if not final pixel
		
		sub dx,first_king_value_of_y  ;remove the realtive value for a check
		
		draw_king_midel_line:
			add dx,first_king_value_of_y  ;add the reltive value of king y
			inc dx						  ;increas y value
			mov cx,24					  ;set x to 25
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			
			mov cx,25					  ;set x to 26
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			
			mov cx,26					  ;set x to 27
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub dx,first_king_value_of_y  ;remove the realtive value for a check
			
			cmp dx,30					  ;check if the y is 34 yet
			jne draw_king_midel_line	  ;reapit the loop if it is not 
		
		add dx,first_king_value_of_y  	  ;we removed befor enterd the loop so we need to add again 
		sub dx,16 						  ;to get back to line to draw the other parts
		
		inc dx 							  ;set y to 18
		mov cx,8						  ;set x to 9
		draw_king_line_18_first_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,14					  ;check if cx is 39 
			jne draw_king_line_18_first_part;repeat the loop if not final pixel
		
		mov cx,35					  ;set x to 36
		
		draw_king_line_18_second_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,41					  ;check if cx is 39 
			jne draw_king_line_18_second_part;repeat the loop if not final pixel
		
		inc dx 							  ;set y to 19
		mov cx,8						  ;set x to 9
		draw_king_line_19_first_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,13					  ;check if cx is 39 
			jne draw_king_line_19_first_part;repeat the loop if not final pixel
		
		mov cx,36					 	  ;set x to 37
		
		draw_king_line_19_second_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,41					  ;check if cx is 39 
			jne draw_king_line_19_second_part;repeat the loop if not final pixel
		
		inc dx 							  ;set y to 20
		mov cx,8						  ;set x to 9
		draw_king_line_20_first_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,13					  ;check if cx is 39 
			jne draw_king_line_20_first_part;repeat the loop if not final pixel
		
		mov cx,36					 	  ;set x to 37
		
		draw_king_line_20_second_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,41					  ;check if cx is 39 
			jne draw_king_line_20_second_part;repeat the loop if not final pixel
		
		inc dx 							  ;set y to 21
		mov cx,8						  ;set x to 9
		draw_king_line_21_first_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,13					  ;check if cx is 39 
			jne draw_king_line_21_first_part;repeat the loop if not final pixel
		
		mov cx,36					 	  ;set x to 37
		
		draw_king_line_21_second_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,41					  ;check if cx is 39 
			jne draw_king_line_21_second_part;repeat the loop if not final pixel
		
		inc dx 							  ;set y to 22
		mov cx,8						  ;set x to 9
		draw_king_line_22_first_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,12					  ;check if cx is 39 
			jne draw_king_line_22_first_part;repeat the loop if not final pixel
		
		mov cx,37					 	  ;set x to 37
		
		draw_king_line_22_second_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,41					  ;check if cx is 39 
			jne draw_king_line_22_second_part;repeat the loop if not final pixel
		
		inc dx 							  ;set y to 23
		mov cx,7						  ;set x to 9
		draw_king_line_23_first_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,12					  ;check if cx is 39 
			jne draw_king_line_23_first_part;repeat the loop if not final pixel
		
		mov cx,37					 	  ;set x to 37
		
		draw_king_line_23_second_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,42					  ;check if cx is 39 
			jne draw_king_line_23_second_part;repeat the loop if not final pixel
		
		inc dx 							  ;set y to 24
		mov cx,7						  ;set x to 9
		draw_king_line_24_first_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,12					  ;check if cx is 39 
			jne draw_king_line_24_first_part;repeat the loop if not final pixel
		
		mov cx,37					 	  ;set x to 37
		
		draw_king_line_24_second_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,42					  ;check if cx is 39 
			jne draw_king_line_24_second_part;repeat the loop if not final pixel
		
		inc dx 							  ;set y to 25
		mov cx,7						  ;set x to 9
		draw_king_line_25_first_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,12					  ;check if cx is 39 
			jne draw_king_line_25_first_part;repeat the loop if not final pixel
		
		mov cx,37					 	  ;set x to 37
		
		draw_king_line_25_second_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,42					  ;check if cx is 39 
			jne draw_king_line_25_second_part;repeat the loop if not final pixel
		
		inc dx 							  ;set y to 26
		mov cx,7						  ;set x to 9
		draw_king_line_26_first_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,13					  ;check if cx is 39 
			jne draw_king_line_26_first_part;repeat the loop if not final pixel
		
		mov cx,36					 	  ;set x to 37
		
		draw_king_line_26_second_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,42					  ;check if cx is 39 
			jne draw_king_line_26_second_part;repeat the loop if not final pixel
		
		inc dx 							  ;set y to 27
		mov cx,8						  ;set x to 9
		draw_king_line_27_first_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,14					  ;check if cx is 39 
			jne draw_king_line_27_first_part;repeat the loop if not final pixel
		
		mov cx,35					 	  ;set x to 37
		
		draw_king_line_27_second_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,41					  ;check if cx is 39 
			jne draw_king_line_27_second_part;repeat the loop if not final pixel
		
		inc dx 							  ;set y to 28
		mov cx,9						  ;set x to 9
		draw_king_line_28_first_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,15					  ;check if cx is 39 
			jne draw_king_line_28_first_part;repeat the loop if not final pixel
		
		mov cx,34					 	  ;set x to 37
		
		draw_king_line_28_second_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,40					  ;check if cx is 39 
			jne draw_king_line_28_second_part;repeat the loop if not final pixel
		
		inc dx 							  ;set y to 29
		mov cx,9						  ;set x to 9
		draw_king_line_29_first_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,16					  ;check if cx is 39 
			jne draw_king_line_29_first_part;repeat the loop if not final pixel
		
		mov cx,33					 	  ;set x to 37
		
		draw_king_line_29_second_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,40					  ;check if cx is 39 
			jne draw_king_line_29_second_part;repeat the loop if not final pixel
		
		inc dx 							  ;set y to 30
		mov cx,11						  ;set x to 9
		
		draw_king_line_30_first_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,17					  ;check if cx is 39 
			jne draw_king_line_30_first_part;repeat the loop if not final pixel
		
		mov cx,32					 	  ;set x to 37
		
		draw_king_line_30_second_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,38					  ;check if cx is 39 
			jne draw_king_line_30_second_part;repeat the loop if not final pixel
		
		inc dx 							  ;set y to 31
		mov cx,12						  ;set x to 9
		
		draw_king_line_31_first_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,19					  ;check if cx is 39 
			jne draw_king_line_31_first_part;repeat the loop if not final pixel
		
		mov cx,30					 	  ;set x to 37
		
		draw_king_line_31_second_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,37					  ;check if cx is 39 
			jne draw_king_line_31_second_part;repeat the loop if not final pixel
		
		inc dx 							  ;set y to 32
		mov cx,13						  ;set x to 9
		
		draw_king_line_32_first_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,21					  ;check if cx is 39 
			jne draw_king_line_32_first_part;repeat the loop if not final pixel
		
		mov cx,28					 	  ;set x to 37
		
		draw_king_line_32_second_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,36					  ;check if cx is 39 
			jne draw_king_line_32_second_part;repeat the loop if not final pixel
		
		inc dx 							  ;set y to 33
		mov cx,13						  ;set x to 9
		
		draw_king_line_33_first_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,22					  ;check if cx is 39 
			jne draw_king_line_33_first_part;repeat the loop if not final pixel
		
		mov cx,27					 	  ;set x to 37
		
		draw_king_line_33_second_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,36					  ;check if cx is 39 
			jne draw_king_line_33_second_part;repeat the loop if not final pixel
		
		inc dx 							  ;set y to 34
		mov cx,16						  ;set x to 9
		
		draw_king_line_34_first_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,26					  ;check if cx is 39 
			jne draw_king_line_34_first_part;repeat the loop if not final pixel
		
		mov cx,26					 	  ;set x to 37
		
		draw_king_line_34_second_part: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,33					  ;check if cx is 39 
			jne draw_king_line_34_second_part;repeat the loop if not final pixel
		
		inc dx 							  ;set y to 34
		mov cx,17					 	  ;set x to 37
		
		draw_king_line_35: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,31					  ;check if cx is 39 
			jne draw_king_line_35;repeat the loop if not final pixel
		
		inc dx 							  ;set y to 36
		mov cx,19					 	  ;set x to 37
		
		draw_king_line_36: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,29					  ;check if cx is 39 
			jne draw_king_line_36;repeat the loop if not final pixel
		
		inc dx 							  ;set y to 36
		mov cx,19					 	  ;set x to 37
		
		draw_king_line_37: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,29					  ;check if cx is 39 
			jne draw_king_line_37;repeat the loop if not final pixel
		
		inc dx 							  ;set y to 38
		mov cx,11					 	  ;set x to 37
		
		draw_king_line_38: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,37					  ;check if cx is 39 
			jne draw_king_line_38;repeat the loop if not final pixel
		
		inc dx 							  ;set y to 39
		mov cx,9					 	  ;set x to 37
		
		draw_king_line_39: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,39					  ;check if cx is 39 
			jne draw_king_line_39;repeat the loop if not final pixel
		
		inc dx 							  ;set y to 40
		mov cx,8					 	  ;set x to 37
		
		draw_king_line_40: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,40					  ;check if cx is 39 
			jne draw_king_line_40;repeat the loop if not final pixel
		
		inc dx 							  ;set y to 41
		mov cx,8					 	  ;set x to 37
		
		draw_king_line_41: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,40					  ;check if cx is 39 
			jne draw_king_line_41;repeat the loop if not final pixel
		
		inc dx 							  ;set y to 42
		mov cx,7					 	  ;set x to 37
		
		draw_king_line_42: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,41					  ;check if cx is 39 
			jne draw_king_line_42		  ;repeat the loop if not final pixel
		
		inc dx 							  ;set y to 43
		mov cx,6					 	  ;set x to 37
		
		draw_king_line_43: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,42					  ;check if cx is 39 
			jne draw_king_line_43		  ;repeat the loop if not final pixel
		
		inc dx 							  ;set y to 44
		mov cx,6					 	  ;set x to 37
		
		draw_king_line_44: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,42					  ;check if cx is 39 
			jne draw_king_line_44		  ;repeat the loop if not final pixel
		
		inc dx 							  ;set y to 45
		mov cx,6					 	  ;set x to 37
		
		draw_king_line_45: 
			inc cx						  ;move to the next pixel
			add cx,first_king_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_king_value_of_x  ;remove the reltive value
			cmp cx,42					  ;check if cx is 39 
			jne draw_king_line_45		  ;repeat the loop if not final pixel
		
		mov dx,50					  ;solve a problem with drawing the board		
		mov cx,488				      ;solve a problem with drawing the board


		ret
	draw_king endp


	draw_rock proc
		
		mov cx,11					  ;set x to 12
		
		draw_rock_line_1_first_part: 
			inc cx						  ;move to the next pixel
			add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_rock_value_of_x  ;remove the reltive value
			cmp cx,16					  ;check if cx is 17 
			jne draw_rock_line_1_first_part   ;repeat the loop if not final pixel
		
		mov cx,21					  ;set x to 22
		
		draw_rock_line_1_second_part: 
			inc cx						  ;move to the next pixel
			add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_rock_value_of_x  ;remove the reltive value
			cmp cx,27					  ;check if cx is 28 
			jne draw_rock_line_1_second_part   ;repeat the loop if not final pixel
		
		mov cx,32					  ;set x to 33
		
		draw_rock_line_1_third_part: 
			inc cx						  ;move to the next pixel
			add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_rock_value_of_x  ;remove the reltive value
			cmp cx,37					  ;check if cx is 38 
			jne draw_rock_line_1_third_part   ;repeat the loop if not final pixel
			
		inc dx						  ;set y to 4
		mov cx,11					  ;set x to 12
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
			
		mov cx,17					  ;set x to 18
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
				
		mov cx,21					  ;set x to 22
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
				
		mov cx,28					  ;set x to 29
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
				
		mov cx,32					  ;set x to 33
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
			
		mov cx,38					  ;set x to 39
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel		
			
		inc dx						  ;set y to 5
		mov cx,10					  ;set x to 11
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
			
		mov cx,17					  ;set x to 18
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
				
		mov cx,21					  ;set x to 22
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
				
		mov cx,28					  ;set x to 29
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
				
		mov cx,32					  ;set x to 33
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
			
		mov cx,39					  ;set x to 40
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx 						  ;set y to 6
		mov cx,10					  ;set x to 11
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel		
			
		mov cx,18					  ;set x to 19
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel		
		
		mov cx,20					  ;set x to 21
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel		
			
		mov cx,29					  ;set x to 30
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel		
			
		mov cx,31					  ;set x to 32
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel		
			
		mov cx,39					  ;set x to 40
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel		
			
		inc dx 						  ;set y to 7
		mov cx,10					  ;set x to 11
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel		
			
		mov cx,18					  ;set x to 19
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel		
		
		mov cx,20					  ;set x to 21
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel		
			
		mov cx,29					  ;set x to 30
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel		
			
		mov cx,31					  ;set x to 32
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel		
			
		mov cx,39					  ;set x to 40
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel			
			
		inc dx 						  ;set y to 8
		mov cx,9					  ;set x to 10
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
			
		mov cx,19					  ;set x to 20
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
			
		mov cx,30					  ;set x to 31
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,40					  ;set x to 41
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 9
		mov cx,9					  ;set x to 10
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,40					  ;set x to 41
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 10
		mov cx,9					  ;set x to 10
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,40					  ;set x to 41
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 11
		mov cx,9					  ;set x to 10
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,40					  ;set x to 41
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 12
		mov cx,9					  ;set x to 10
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,40					  ;set x to 41
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 13
		mov cx,10					  ;set x to 11
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,39					  ;set x to 40
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 14
		mov cx,10					  ;set x to 11
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,39					  ;set x to 40
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 15
		mov cx,10					  ;set x to 11
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,39					  ;set x to 40
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 16
		mov cx,11					  ;set x to 12
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,38					  ;set x to 39
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 17
		mov cx,11					  ;set x to 12
		
		draw_rock_line_17: 
			inc cx						  ;move to the next pixel
			add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_rock_value_of_x  ;remove the reltive value
			cmp cx,37					  ;check if cx is 38 
			jne draw_rock_line_17   ;repeat the loop if not final pixel
		
		inc dx 						  ;set y to 18
		mov cx,13					  ;set x to 14
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,36					  ;set x to 37
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 19
		mov cx,14					  ;set x to 15
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,35					  ;set x to 36
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 20
		mov cx,14					  ;set x to 15
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,35					  ;set x to 36
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 21
		mov cx,14					  ;set x to 15
		
		draw_rock_line_21: 
			inc cx						  ;move to the next pixel
			add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_rock_value_of_x  ;remove the reltive value
			cmp cx,34					  ;check if cx is 35 
			jne draw_rock_line_21	      ;repeat the loop if not final pixel
		
		inc dx 						  ;set y to 22
		mov cx,15					  ;set x to 16
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,34					  ;set x to 35
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 23
		mov cx,15					  ;set x to 16
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,34					  ;set x to 35
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 24
		mov cx,15					  ;set x to 16
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,34					  ;set x to 35
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,16					  ;set x to 17
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,33					  ;set x to 34
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 25
		mov cx,16					  ;set x to 17
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,33					  ;set x to 34
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 26
		mov cx,16					  ;set x to 17
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,33					  ;set x to 34
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,17					  ;set x to 18
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,32					  ;set x to 32
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 27
		mov cx,17					  ;set x to 18
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,32					  ;set x to 32
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 28
		mov cx,17					  ;set x to 18
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,32					  ;set x to 32
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 29
		mov cx,17					  ;set x to 18
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,32					  ;set x to 32
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,18					  ;set x to 19
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,31					  ;set x to 32
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 30
		mov cx,18					  ;set x to 19
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,31					  ;set x to 32
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 31
		mov cx,18					  ;set x to 19
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,31					  ;set x to 32
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 32
		mov cx,18					  ;set x to 19
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,31					  ;set x to 32
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,17					  ;set x to 18
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,32					  ;set x to 33
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 33
		mov cx,17					  ;set x to 18
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,32					  ;set x to 33
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 34
		mov cx,17					  ;set x to 18
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,32					  ;set x to 33
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,16					  ;set x to 17
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,33					  ;set x to 34
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 35
		mov cx,16					  ;set x to 17
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,33					  ;set x to 34
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 36
		mov cx,16					  ;set x to 17
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,33					  ;set x to 34
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,15					  ;set x to 16
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,34					  ;set x to 35
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 37
		mov cx,15					  ;set x to 16
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,34					  ;set x to 35
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 38
		mov cx,15					  ;set x to 16
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,34					  ;set x to 35
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,14					  ;set x to 15
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,35					  ;set x to 36
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 39
		mov cx,14					  ;set x to 15
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,35					  ;set x to 36
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 40
		mov cx,10					  ;set x to 11
		
		draw_rock_line_40:
			inc cx						  ;move to the next pixel
			add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_rock_value_of_x  ;remove the reltive value
			cmp cx,38					  ;check if cx is 35 
			jne draw_rock_line_40	      ;repeat the loop if not final pixel
		
		inc dx 						  ;set y to 41
		mov cx,10					  ;set x to 11
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,39					  ;set x to 40
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 42
		mov cx,9					  ;set x to 10
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,40					  ;set x to 41
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 43
		mov cx,9					  ;set x to 10
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,40					  ;set x to 41
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 44
		mov cx,8					  ;set x to 9
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,41					  ;set x to 42
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 45
		mov cx,8					  ;set x to 9
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,41					  ;set x to 42
		add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set y to 45 
		mov cx,7					  ;set x to 8
		
		draw_rock_line_45:
			inc cx						  ;move to the next pixel
			add cx,first_rock_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_rock_value_of_x  ;remove the reltive value
			cmp cx,41					  ;check if cx is 42 
			jne draw_rock_line_45	      ;repeat the loop if not final pixel
		
		mov dx,50					  ;solve a problem with drawing the board		
		mov cx,488				      ;solve a problem with drawing the board
		ret
	draw_rock endp
		

	draw_bishop proc
		mov cx,23					  ;set x to 24
		add dx,2 					  ;set y to 5
		
		draw_first_bishop_line: 
			inc cx						  ;move to the next pixel
			add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_bishop_value_of_x  ;remove the reltive value
			cmp cx,27					  ;check if cx is 28 
			jne draw_first_bishop_line   ;repeat the loop if not final pixel
		
		inc dx						  ;set y to 6
		mov cx,23					  ;set x to 24
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,24					  ;set x to 25
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,27					  ;set x to 28
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,28					  ;set x to 29
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 7
		mov cx,24					  ;set x to 25
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,25					  ;set x to 26
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,28					  ;set x to 29
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,29					  ;set x to 30
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 8
		mov cx,25					  ;set x to 26
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,29					  ;set x to 30
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 9
		mov cx,20					  ;set x to 21
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,25					  ;set x to 26
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,26					  ;set x to 27
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,30					  ;set x to 31
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 10
		mov cx,19					  ;set x to 20
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,20					  ;set x to 21
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,19					  ;set x to 20
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,20					  ;set x to 21
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,26					  ;set x to 27
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,31					  ;set x to 31
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 11
		mov cx,19					  ;set x to 20
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,20					  ;set x to 21
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,19					  ;set x to 20
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,20					  ;set x to 21
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,21					  ;set x to 22
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,26					  ;set x to 27
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,31					  ;set x to 31
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 12
		mov cx,18					  ;set x to 19
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,19					  ;set x to 20
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,21					  ;set x to 22
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,22					  ;set x to 23
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,25					  ;set x to 26
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,26					  ;set x to 27
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,31					  ;set x to 32
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx						  ;set y to 13
		mov cx,18					  ;set x to 19
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,19					  ;set x to 20
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,22					  ;set x to 23
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,23					  ;set x to 24
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,24					  ;set x to 25
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,25					  ;set x to 26
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,30					  ;set x to 31
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,31					  ;set x to 32
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx						  ;set y to 14
		mov cx,19					  ;set x to 20
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,30					  ;set x to 31
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 15
		mov cx,19					  ;set x to 20
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,20					  ;set x to 21
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,29					  ;set x to 30
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,30					  ;set x to 31
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 16
		mov cx,20					  ;set x to 21
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,29					  ;set x to 30
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 17
		mov cx,20					  ;set x to 21
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,29					  ;set x to 30
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,15					  ;set x to 16
		inc dx	 					  ;set y to 18
		
		draw_bishop_line_18: 
			inc cx						  ;move to the next pixel
			add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_bishop_value_of_x  ;remove the reltive value
			cmp cx,33					  ;check if cx is 34 
			jne draw_bishop_line_18	   ;repeat the loop if not final pixel
		
		inc dx						  ;set y to 19
		mov cx,16					  ;set x to 17
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,33					  ;set x to 34
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 20
		mov cx,16					  ;set x to 17
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,17					  ;set x to 18
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,32					  ;set x to 33
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,33					  ;set x to 34
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx						  ;set y to 21
		mov cx,17					  ;set x to 18
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,18					  ;set x to 19
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,19					  ;set x to 20
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,20					  ;set x to 21
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,29					  ;set x to 30
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,30					  ;set x to 31
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,31					  ;set x to 32
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,32					  ;set x to 33
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx						  ;set y to 22
		mov cx,20					  ;set x to 21
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,29					  ;set x to 30
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 23
		mov cx,20					  ;set x to 21
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,29					  ;set x to 30
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 24
		mov cx,20					  ;set x to 21
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,29					  ;set x to 30
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 25
		mov cx,20					  ;set x to 21
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,29					  ;set x to 30
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 26
		mov cx,20					  ;set x to 21
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,29					  ;set x to 30
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,19					  ;set x to 20
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,30					  ;set x to 31
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 27
		mov cx,19					  ;set x to 20
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,30					  ;set x to 31
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 28
		mov cx,19					  ;set x to 20
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,30					  ;set x to 31
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 29
		mov cx,19					  ;set x to 20
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,30					  ;set x to 31
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 30
		mov cx,19					  ;set x to 20
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,30					  ;set x to 31
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 31
		mov cx,19					  ;set x to 20
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,30					  ;set x to 31
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 32
		mov cx,19					  ;set x to 20
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,30					  ;set x to 31
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,18					  ;set x to 19
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,31					  ;set x to 32
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 32
		mov cx,18					  ;set x to 19
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,31					  ;set x to 32
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,18					  ;set x to 19
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,31					  ;set x to 32
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 33
		mov cx,18					  ;set x to 19
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,31					  ;set x to 32
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 34
		mov cx,18					  ;set x to 19
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,31					  ;set x to 32
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 35
		mov cx,18					  ;set x to 19
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,31					  ;set x to 32
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,17					  ;set x to 18
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,32					  ;set x to 33
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 36
		mov cx,17					  ;set x to 18
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,32					  ;set x to 33
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 37
		mov cx,17					  ;set x to 18
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,32					  ;set x to 33
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,16					  ;set x to 17
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,33					  ;set x to 34
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 38
		mov cx,16					  ;set x to 17
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,33					  ;set x to 34
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,15					  ;set x to 16
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,34					  ;set x to 35
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,13					  ;set x to 14
		inc dx	 					  ;set y to 39
		
		draw_bishop_line_39: 
			inc cx						  ;move to the next pixel
			add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_bishop_value_of_x  ;remove the reltive value
			cmp cx,35					  ;check if cx is 36 
			jne draw_bishop_line_39	   ;repeat the loop if not final pixel
		
		inc dx						  ;set y to 40
		mov cx,12					  ;set x to 13
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,13					  ;set x to 14
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,36					  ;set x to 37
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,37					  ;set x to 38
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 41
		mov cx,10					  ;set x to 11
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,11					  ;set x to 12
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,38					  ;set x to 39
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,39					  ;set x to 40
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 42
		mov cx,10					  ;set x to 11
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,39					  ;set x to 40
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 43
		mov cx,9					  ;set x to 10
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,10					  ;set x to 11
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,39					  ;set x to 40
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,40					  ;set x to 41
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		inc dx						  ;set y to 43
		mov cx,9					  ;set x to 10
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		mov cx,40					  ;set x to 41
		add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel	
		
		
		mov cx,8					  ;set x to 9
		inc dx 						  ;set y to 45
		draw_bishop_line_45: 
			inc cx						  ;move to the next pixel
			add cx,first_bishop_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_bishop_value_of_x  ;remove the reltive value
			cmp cx,40					  ;check if cx is 41 
			jne draw_bishop_line_45	   ;repeat the loop if not final pixel
		
		mov dx,50					  ;solve a problem with drawing the board		
		mov cx,488				      ;solve a problem with drawing the board

		ret
	draw_bishop endp
		

	draw_knight proc	

		dec dx  					  ;set y to 2
		mov cx,26					  ;set x to 27
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,27					  ;set x to 28
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 3
		mov cx,23					  ;set x to 24
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,24					  ;set x to 25
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,25					  ;set x to 26
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,27					  ;set x to 28
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 4
		mov cx,21					  ;set x to 22
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,22					  ;set x to 23
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,23					  ;set x to 24
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,28					  ;set x to 29
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 5
		mov cx,19					  ;set x to 20
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,20					  ;set x to 21
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,21					  ;set x to 22
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,28					  ;set x to 29
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,29					  ;set x to 30
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 6
		mov cx,17					  ;set x to 18
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,18					  ;set x to 19
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,19					  ;set x to 20
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,29					  ;set x to 30
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 7
		mov cx,16					  ;set x to 17
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,17					  ;set x to 18
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,29					  ;set x to 30
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 8
		mov cx,14					  ;set x to 15
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,15					  ;set x to 16
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,30					  ;set x to 31
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,31					  ;set x to 32
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 9
		mov cx,14					  ;set x to 15
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,31					  ;set x to 32
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,32					  ;set x to 33
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,33					  ;set x to 34
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 10
		mov cx,13					  ;set x to 14
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,24					  ;set x to 25
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,33					  ;set x to 34
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,34					  ;set x to 35
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 11
		mov cx,12					  ;set x to 13
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,13					  ;set x to 14
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,22					  ;set x to 23
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,23					  ;set x to 24
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,24					  ;set x to 25
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,25					  ;set x to 26
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,34					  ;set x to 35
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,35					  ;set x to 36
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 12
		mov cx,11					  ;set x to 12
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,12					  ;set x to 13
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,21					  ;set x to 22
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,22					  ;set x to 23
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,23					  ;set x to 24
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,24					  ;set x to 25
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,35					  ;set x to 36
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,36					  ;set x to 37
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 13
		mov cx,10					  ;set x to 11
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,11					  ;set x to 12
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,20					  ;set x to 21
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,21					  ;set x to 22
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,22					  ;set x to 23
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,23					  ;set x to 24
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,36					  ;set x to 37
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 14
		mov cx,10					  ;set x to 11
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,20					  ;set x to 21
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,21					  ;set x to 22
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,22					  ;set x to 23
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,36					  ;set x to 37
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,37					  ;set x to 38
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 15
		mov cx,9					  ;set x to 10
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,10					  ;set x to 11
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,19					  ;set x to 20
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,20					  ;set x to 21
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,21					  ;set x to 22
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,37					  ;set x to 38
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,38					  ;set x to 39
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 16
		mov cx,7					  ;set x to 8
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,8					  ;set x to 9
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,9					  ;set x to 10
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,20					  ;set x to 21
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,38					  ;set x to 39
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,39					  ;set x to 40
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 17
		mov cx,7					  ;set x to 8
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,39					  ;set x to 40
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 18
		mov cx,7					  ;set x to 8
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,39					  ;set x to 40
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 19
		mov cx,6					  ;set x to 7
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,39					  ;set x to 40
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 20
		mov cx,6					  ;set x to 7
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,40					  ;set x to 41
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 21
		mov cx,6					  ;set x to 7
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,9					  ;set x to 10
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,10					  ;set x to 11
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,11					  ;set x to 12
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,19					  ;set x to 20
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,20					  ;set x to 21
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,21					  ;set x to 22
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,22					  ;set x to 23
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,23					  ;set x to 24
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,40					  ;set x to 41
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 22
		mov cx,6					  ;set x to 7
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,9					  ;set x to 10
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,12					  ;set x to 13
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,18					  ;set x to 19
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,19					  ;set x to 20
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,21					  ;set x to 22
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,22					  ;set x to 23
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,23					  ;set x to 24
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,40					  ;set x to 41
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 23
		mov cx,7					  ;set x to 8
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,8					  ;set x to 9
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,12					  ;set x to 13
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,17					  ;set x to 18
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,18					  ;set x to 19
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,23					  ;set x to 24
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,24					  ;set x to 25
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,39					  ;set x to 40
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,40					  ;set x to 41
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 24
		mov cx,11					  ;set x to 12
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,12					  ;set x to 13
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,16					  ;set x to 17
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,17					  ;set x to 18
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,24					  ;set x to 25
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,39					  ;set x to 40
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 25
		mov cx,10					  ;set x to 11
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,11					  ;set x to 12
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,15					  ;set x to 16
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,16					  ;set x to 17
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,23					  ;set x to 24
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,24					  ;set x to 25
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,39					  ;set x to 40
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 26
		mov cx,10					  ;set x to 11
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,14					  ;set x to 15
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,15					  ;set x to 16
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,23					  ;set x to 24
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,38					  ;set x to 39
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,39					  ;set x to 40
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 27
		mov cx,10					  ;set x to 11
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,11					  ;set x to 12
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,12					  ;set x to 13
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,13					  ;set x to 14
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,14					  ;set x to 15
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,22					  ;set x to 23
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,23					  ;set x to 24
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,38					  ;set x to 39
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 28
		mov cx,21					  ;set x to 22
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,22					  ;set x to 23
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,37					  ;set x to 38
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,38					  ;set x to 39
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 29
		mov cx,20					  ;set x to 21
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,21					  ;set x to 22
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,22					  ;set x to 23
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,37					  ;set x to 38
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 30
		mov cx,18					  ;set x to 19
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,19					  ;set x to 20
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,20					  ;set x to 21
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,36					  ;set x to 37
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,37					  ;set x to 38
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 31
		mov cx,17					  ;set x to 18
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,18					  ;set x to 19
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,36					  ;set x to 37
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 32
		mov cx,16					  ;set x to 17
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,17					  ;set x to 18
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,35					  ;set x to 36
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 33
		mov cx,16					  ;set x to 17
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,34					  ;set x to 35
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 34
		mov cx,15					  ;set x to 16
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,16					  ;set x to 17
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,33					  ;set x to 34
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,34					  ;set x to 35
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 35
		mov cx,15					  ;set x to 16
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,33					  ;set x to 34
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 36
		mov cx,14					  ;set x to 15
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,15					  ;set x to 16
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,33					  ;set x to 34
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 37
		mov cx,14					  ;set x to 15
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,15					  ;set x to 16
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,34					  ;set x to 35
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 38
		mov cx,14					  ;set x to 15
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,15					  ;set x to 16
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,35					  ;set x to 36
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,12					  ;set x to 13
		inc dx 						  ;set y to 39
		
		draw_knight_line_39: 
			inc cx						  ;move to the next pixel
			add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_knight_value_of_x  ;remove the reltive value
			cmp cx,36					  ;check if cx is 37
			jne draw_knight_line_39	   ;repeat the loop if not final pixel
		
		inc dx  					  ;set y to 40
		mov cx,12					  ;set x to 13
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,37					  ;set x to 38
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 41
		mov cx,9					  ;set x to 10
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,10					  ;set x to 11
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,11					  ;set x to 12
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,38					  ;set x to 39
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,39					  ;set x to 40
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,40					  ;set x to 41
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 42
		mov cx,8					  ;set x to 9
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,9					  ;set x to 10
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,40					  ;set x to 41
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,41					  ;set x to 42
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 43
		mov cx,7					  ;set x to 8
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,8					  ;set x to 9
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,41					  ;set x to 42
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,42					  ;set x to 43
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx  					  ;set y to 44
		mov cx,6					  ;set x to 7
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,43					  ;set x to 44
		add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,5					  ;set x to 6
		inc dx 						  ;set y to 45
		
		draw_knight_line_45: 
			inc cx						  ;move to the next pixel
			add cx,first_knight_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_knight_value_of_x  ;remove the reltive value
			cmp cx,43					  ;check if cx is 44
			jne draw_knight_line_45	   ;repeat the loop if not final pixel
		
		mov dx,50					  ;solve a problem with drawing the board		
		mov cx,488				      ;solve a problem with drawing the board
		ret
	draw_knight endp


	draw_queen proc	
		
		mov cx,7					  ;set x to 8
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel

		mov cx,8					  ;set x to 9
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,9					  ;set x to 10
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,22					  ;set x to 23
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,23					  ;set x to 24
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,24					  ;set x to 25
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,25					  ;set x to 26
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,26					  ;set x to 27
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,27					  ;set x to 28
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,40					  ;set x to 41
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,41					  ;set x to 42
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,42					  ;set x to 43
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 4
		mov cx,6					  ;set x to 7
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,10					  ;set x to 11
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,21					  ;set x to 22
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,28					  ;set x to 29
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,39					  ;set x to 40
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,43					  ;set x to 44
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 5
		mov cx,6					  ;set x to 7
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,10					  ;set x to 11
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,21					  ;set x to 22
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,28					  ;set x to 29
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,39					  ;set x to 40
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,43					  ;set x to 44
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 6
		mov cx,7					  ;set x to 8
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,8					  ;set x to 9
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,9					  ;set x to 10
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel

		mov cx,21					  ;set x to 22
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,28					  ;set x to 29
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,40					  ;set x to 41
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel

		mov cx,41					  ;set x to 42
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,42					  ;set x to 43
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 7
		mov cx,7					  ;set x to 8
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,21					  ;set x to 22
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,28					  ;set x to 29
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,42					  ;set x to 43
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 8
		mov cx,8					  ;set x to 9
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,22					  ;set x to 23
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,27					  ;set x to 28
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,41					  ;set x to 42
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 9
		mov cx,9					  ;set x to 10
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,9					  ;set x to 10
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,23					  ;set x to 24
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,26					  ;set x to 27
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,40					  ;set x to 41
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 10
		mov cx,7					  ;set x to 8
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,8					  ;set x to 9
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,9					  ;set x to 10
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,10						  ;set x to 11
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,23					  ;set x to 24
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,26						  ;set x to 27
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,39					  ;set x to 40
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,40						  ;set x to 41
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,41					  ;set x to 42
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,42						  ;set x to 43
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 11
		mov cx,6					  ;set x to 7
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,11					  ;set x to 12
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,12					  ;set x to 13
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,23					  ;set x to 24
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,26					  ;set x to 27
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,37					  ;set x to 38
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,38					  ;set x to 39
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,43					  ;set x to 44
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 12
		mov cx,5					  ;set x to 6
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,12					  ;set x to 13
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,23					  ;set x to 24
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,26					  ;set x to 27
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,37					  ;set x to 38
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,44					  ;set x to 45
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 13
		mov cx,4					  ;set x to 5
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,13					  ;set x to 14
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,22					  ;set x to 23
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,23					  ;set x to 24
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,26					  ;set x to 27
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,27					  ;set x to 28
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,36					  ;set x to 37
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,45					  ;set x to 46
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 14
		mov cx,4					  ;set x to 5
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,13					  ;set x to 14
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,14					  ;set x to 15
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,22					  ;set x to 23
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,27					  ;set x to 28
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,35					  ;set x to 36
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,36					  ;set x to 37
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,45					  ;set x to 46
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 15
		mov cx,4					  ;set x to 5
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,14					  ;set x to 15
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,15					  ;set x to 16
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,16					  ;set x to 17
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,21					  ;set x to 22
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,22					  ;set x to 23
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,27					  ;set x to 28
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,28					  ;set x to 29
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,33					  ;set x to 34
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,34					  ;set x to 35
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,35					  ;set x to 36
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,45					  ;set x to 46
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 16
		mov cx,4					  ;set x to 5
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,5					  ;set x to 6
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,15					  ;set x to 16
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,16					  ;set x to 17
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,20					  ;set x to 21
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,21					  ;set x to 22
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,28					  ;set x to 29
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,29					  ;set x to 30
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,33					  ;set x to 34
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,34					  ;set x to 35
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,44					  ;set x to 45
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,45					  ;set x to 46
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 17
		mov cx,5					  ;set x to 6
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,15					  ;set x to 16
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,16					  ;set x to 17
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,17					  ;set x to 18
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,18					  ;set x to 19
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,19					  ;set x to 20
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,20					  ;set x to 21
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,29					  ;set x to 30
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,30					  ;set x to 31
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,31					  ;set x to 32
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,32					  ;set x to 33
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,33					  ;set x to 34
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,34					  ;set x to 35
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,44					  ;set x to 45
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 18
		mov cx,5					  ;set x to 6
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,44					  ;set x to 45
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 19
		mov cx,6					  ;set x to 7
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,43					  ;set x to 44
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 20
		mov cx,6					  ;set x to 7
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,7					  ;set x to 8
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,42					  ;set x to 43
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,43					  ;set x to 44
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 21
		mov cx,7					  ;set x to 8
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,42					  ;set x to 43
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 22
		mov cx,7					  ;set x to 8
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,8					  ;set x to 9
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,41					  ;set x to 42
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,42					  ;set x to 43
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 23
		mov cx,8					  ;set x to 9
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,22					  ;set x to 23
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,23					  ;set x to 24
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,24					  ;set x to 25
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,25					  ;set x to 26
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,26					  ;set x to 27
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,27					  ;set x to 28
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,41					  ;set x to 42
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 24
		mov cx,8					  ;set x to 9
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,9					  ;set x to 10
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,20					  ;set x to 21
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,21					  ;set x to 22
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,22					  ;set x to 23
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,23					  ;set x to 24
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,26					  ;set x to 27
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,27					  ;set x to 28
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,28					  ;set x to 29
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,29					  ;set x to 30
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,40					  ;set x to 41
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,41					  ;set x to 42
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 25
		mov cx,9					  ;set x to 10
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,10					  ;set x to 11
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,17					  ;set x to 18
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,18					  ;set x to 19
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,19					  ;set x to 20
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,30					  ;set x to 31
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,31					  ;set x to 32
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,32					  ;set x to 33
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,39					  ;set x to 40
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,40					  ;set x to 41
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 26
		mov cx,10					  ;set x to 11
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,15					  ;set x to 16
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,16					  ;set x to 17
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,17					  ;set x to 18
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,32					  ;set x to 33
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,33					  ;set x to 34
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,34					  ;set x to 35
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,39					  ;set x to 40
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 27
		mov cx,10					  ;set x to 11
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,11					  ;set x to 12
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,13					  ;set x to 14
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,14					  ;set x to 15
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,35					  ;set x to 36
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,36					  ;set x to 37
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,38					  ;set x to 39
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,39					  ;set x to 40
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 28
		mov cx,11					  ;set x to 12
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,12					  ;set x to 13
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,13					  ;set x to 14
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,36					  ;set x to 37
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,37					  ;set x to 38
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,38					  ;set x to 39
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 29
		mov cx,12					  ;set x to 13
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,22					  ;set x to 23
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,23					  ;set x to 24
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,24					  ;set x to 25
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,25					  ;set x to 26
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,26					  ;set x to 27
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,27					  ;set x to 28
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,28					  ;set x to 29
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,37					  ;set x to 38
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 30
		mov cx,12					  ;set x to 13
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,13					  ;set x to 14
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,19					  ;set x to 20
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,20					  ;set x to 21
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,21					  ;set x to 22
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,22					  ;set x to 23
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,23					  ;set x to 24
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,26					  ;set x to 27
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,27					  ;set x to 28
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,28					  ;set x to 29
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,29					  ;set x to 30
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,30					  ;set x to 31
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,36					  ;set x to 37
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,37					  ;set x to 38
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 31
		mov cx,13					  ;set x to 14
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,17					  ;set x to 18
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,18					  ;set x to 19
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,19					  ;set x to 20
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,30					  ;set x to 31
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,31					  ;set x to 32
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,32					  ;set x to 33
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,36					  ;set x to 37
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 32
		mov cx,13					  ;set x to 14
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,14					  ;set x to 15
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,15					  ;set x to 16
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,16					  ;set x to 17
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,33					  ;set x to 34
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,34					  ;set x to 35
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,35					  ;set x to 36
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,36					  ;set x to 37
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 33
		mov cx,14					  ;set x to 15
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,35					  ;set x to 36
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 34
		mov cx,14					  ;set x to 15
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,15					  ;set x to 16
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,34					  ;set x to 35
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,35					  ;set x to 36
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 35
		mov cx,15					  ;set x to 16
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel

		mov cx,34					  ;set x to 35
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 36
		mov cx,16					  ;set x to 17
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel

		mov cx,33					  ;set x to 34
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 37
		mov cx,16					  ;set x to 17
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel

		mov cx,33					  ;set x to 34
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 38
		mov cx,16					  ;set x to 17
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,17					  ;set x to 18
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,32					  ;set x to 33
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,33					  ;set x to 34
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 39
		mov cx,13					  ;set x to 14
		
		draw_queen_line_39: 
			inc cx						  ;move to the next pixel
			add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_queen_value_of_x  ;remove the reltive value
			cmp cx,35					  ;check if cx is 36
			jne draw_queen_line_39	   ;repeat the loop if not final pixel
		
		inc dx 						  ;set the value of y to 40
		mov cx,10					  ;set x to 11
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,11					  ;set x to 12
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,12					  ;set x to 13
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,13					  ;set x to 14
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,36					  ;set x to 37
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,37					  ;set x to 38
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,38					  ;set x to 39
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,39					  ;set x to 40
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 41
		mov cx,9					  ;set x to 10
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,40					  ;set x to 41
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 42
		mov cx,8					  ;set x to 9
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,41					  ;set x to 42
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 43
		mov cx,7					  ;set x to 8
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,42					  ;set x to 43
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 44
		mov cx,6					  ;set x to 7
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		mov cx,43					  ;set x to 44
		add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
		call draw_pixel
		
		inc dx 						  ;set the value of y to 45
		mov cx,5					  ;set x to 6
		
		draw_queen_line_45: 
			inc cx						  ;move to the next pixel
			add cx,first_queen_value_of_x  ;add the reltive value of the king i want to print
			mov ah,0ch 					  ;set configuration to writing pixel 
			mov bh,00h 					  ;set the page number
			int 10h    					  ;excute configuration
			sub cx,first_queen_value_of_x  ;remove the reltive value
			cmp cx,43					  ;check if cx is 44
			jne draw_queen_line_45	   ;repeat the loop if not final pixel
		
		mov dx,50					  ;solve a problem with drawing the board		
		mov cx,488				      ;solve a problem with drawing the board
		
		ret
	draw_queen endp


	draw_pixel proc
		mov ah,0ch 					  ;set configuration to writing pixel 
		mov bh,00h 					  ;set the page number
		int 10h    					  ;excute configuration
		ret
	draw_pixel endp
endp 


;this place from now on is for functions that help debuging there is no reason to check this function they do nothing in 
;the actoul code but they were very usefull while debuging the code ( they are also easly changebell to suit the array or parts of array that i want to see)
debugging_section:
	print_digit_number proc         
		;initialize count
		push bx
		push dx
		push cx
		mov cx,0
		mov dx,0

		label1:
			; if ax is zero
			cmp ax,0
			je print1     
			
			;initialize bx to 10
			mov bx,10       
			
			; extract the last digit
			div bx            
			
			;push it in the stack
			push dx             
			
			;increment the count
			inc cx             
			
			;set dx to 0
			xor dx,dx
			jmp label1
		print1:
			;check if count
			;is greater than zero
			cmp cx,0
			je exit
			
			;pop the top of stack
			pop dx
			
			;add 48 so that it
			;represents the ascii
			;value of digits
			add dx,48
			
			;interrupt to print a
			;character
			mov ah,02h
			int 21h
			
			;decrease the count
			dec cx
			jmp print1
		exit:
		pop cx
		pop dx
		pop bx
		ret
	print_digit_number endp

	print_array_of_pices proc         
		mov debugingcounter1,64
		mov debugingcounter2,0 
		lea si,[array_of_squares_that_the_rock_controls_in_direction_of_the_check]	;set the si to point on this array two option (array_of_each_piece_x, array_of_each_piece_y)
		
		print_array_of_pices_loop:
			mov ax,0								;reset ax 
			mov al,[si]
			;mov ax,di

			call print_digit_number
			cmp ax, 0
			je print_the_zero
			jmp end_print_the_zero
			print_the_zero:
				mov dl,48
				mov ah,2
				int 21h

			end_print_the_zero:
			mov dl,',' 
			mov ah,2
			int 21h

			add si,1
			inc debugingcounter2

			cmp debugingcounter2,8
			jne continue_print_array_of_pices_loop
			
			mov debugingcounter2, 0
			mov dl,10 
			mov ah,2
			int 21h

			continue_print_array_of_pices_loop:
				dec debugingcounter1 	
				cmp debugingcounter1,0
				jne print_array_of_pices_loop
		
		;mov dl,10 
		;mov ah,2
		;int 21h

		ret
	print_array_of_pices endp
endp

end start