; 	Defining the rows and columns

;	 Col2 Col1 Col0
;	+----+----+----+
;	|  1 |  2 |  3 |	Row3 
;	+----+----+----+
;	|  4 |  5 |  6 |	Row2
;	+----+----|----+
;	|  7 |  8 |  9 |	Row1
;	+----+----+----+
;	|  * |  0 |  # |	Row0
;	+----+----+----+



mov a,#0FEh
mov b,#0FFh



		    ;Scan Row3
Begin:		CLR P0.3			;Clear Row3
			CALL IDCode0		;Call scan column subroutine
			SetB P0.3			;Set Row 3
			JB F0,Done  		;If F0 is set, end program 
						
			;Scan Row2
			CLR P0.2			;Clear Row2
			CALL IDCode1		;Call scan column subroutine
			SetB P0.2			;Set Row 2
			JB F0,Done		 	;If F0 is set, end program 						

			;Scan Row1
			CLR P0.1			;Clear Row1
			CALL IDCode2		;Call scan column subroutine
			SetB P0.1			;Set Row 1
			JB F0,Done			;If F0 is set, end program 

			;Scan Row0			
			CLR P0.0			;Clear Row0
			CALL IDCode3		;Call scan column subroutine
			SetB P0.0			;Set Row 0
			JB F0,Done			;If F0 is set, end program 
														
			JMP Begin			;Go back to scan Row3
							
Done:		JMP $				;Program execution ends and stay here




;Scan column subroutine




;From 1 to 3
IDCode0:	JNB P0.4, KeyCode03	;If Col0 Row3 is cleared - key found
			JNB P0.5, KeyCode13	;If Col1 Row3 is cleared - key found
			JNB P0.6, KeyCode23	;If Col2 Row3 is cleared - key found
			RET					

KeyCode03:	SETB F0			;Key found - set F0
		    acall dot	    ;Code for '3'
			acall dot
            acall dot
            acall dash
            acall dash
            ret

KeyCode13:	SETB F0			;Key found - set F0
			acall dot       ;Code for '2'
			acall dot
            acall dash
            acall dash
            acall dash
            ret		

KeyCode23:	SETB F0			;Key found - set F0
			acall dot   	;Code for '1'
		    acall dash
            acall dash
            acall dash
            acall dash			
			ret			




;From 4 to 6
IDCode1:	JNB P0.4, KeyCode02	;If Col0 Row2 is cleared - key found
			JNB P0.5, KeyCode12	;If Col1 Row2 is cleared - key found
			JNB P0.6, KeyCode22	;If Col2 Row2 is cleared - key found
			RET					

KeyCode02:	SETB F0			;Key found - set F0
			acall dash 	    ;Code for '6'
			acall dot
            acall dot
            acall dot
            acall dot
            ret		

KeyCode12:	SETB F0			;Key found - set F0
			acall dot   	;Code for '5'
			acall dot
            acall dot
            acall dot
            acall dot
            ret	

KeyCode22:	SETB F0			;Key found - set F0
			acall dot   	;Code for '4'
			acall dot
            acall dot
            acall dot
            acall dash
            ret	




;From 7 to 9
IDCode2:	JNB P0.4, KeyCode01	;If Col0 Row1 is cleared - key found
			JNB P0.5, KeyCode11	;If Col1 Row1 is cleared - key found
			JNB P0.6, KeyCode21	;If Col2 Row1 is cleared - key found
			RET					

KeyCode01:	SETB F0			;Key found - set F0
			acall dash  	;Code for '9'
			acall dash
            acall dash
            acall dash
            acall dot
            ret

KeyCode11:	SETB F0			;Key found - set F0
			acall dash  	;Code for '8'
			acall dash
            acall dash
            acall dot
            acall dot
            ret	

KeyCode21:	SETB F0			;Key found - set F0
			acall dash  	;Code for '7'
			acall dash
            acall dot
            acall dot
            acall dot
            ret




;For 0
IDCode3:	JNB P0.5, KeyCode10	;If Col1 Row0 is cleared - key found
			RET					

KeyCode10:	SETB F0			;Key found - set F0
			acall dash  	;Code for '0'
			acall dash
            acall dash
            acall dash
            acall dash
            ret




dot: mov p1,a
     acall delay
     acall off
     ret

dash: mov p1,a
      acall delay2
      acall off
      ret

off: mov p1,b
     acall delay
     ret
     
delay: mov r0,#80h
again: mov r1,#0FFh
here:  djnz r1,here
       djnz r0,again
       ret

delay2: mov r3,#0FFh
again2: mov r2,#0FFh
here2:  djnz r2,here2
        djnz r3,again2
        ret				

end	  

