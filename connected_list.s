######  MELH OMADAS  ######

#Stasinou Elpida p3200277
#Tzovanis Dimitrios p3200195

##########################


      	.text
      	.globl main
main:


    li $s0,0		 # head = NULL


##################################################################
#MENU
##################################################################


again:
		la $a0, menu     #print menu
		li $v0, 4
		syscall

		li $v0,5       #ask for a number
		syscall


		beq $v0,1,AddNode        #check number
		beq $v0,2,DeleteNode
		beq $v0,3,Printlist
    beq $v0,4,CreateList
    beq $v0,5,exit
		j again

AddNode:
		jal Insertion   #add node
		j again

DeleteNode:
		jal Delete     #delete node
		j again

Printlist:
		jal Print    #print list
		j again

CreateList:
    jal CreateL    #create list
    j again



##################################################################
#NEW NODE
##################################################################



Insertion:
    beq $s1, $0, ListDoesntExist

		la $a0, node    	# prompt user to enter a value
		li $v0, 4
		syscall


    li $v0,5     #read data (first int)
    syscall
		move $t2,$v0

		li $t3,0             # prev = NULL
    move $t4,$s1			 	 # cur = head

checklist:
    beq $t4, $0, createNode		# if cur == null, create node

    lw $t0, 0($t4)				    # t0 = current.int

		##if new node smaller than head
		blt $t2,$t0,createNode		 #if new < cur, create node

    move $t3, $t4				  # previous = current
	  lw $t4, 4($t4)				# current = current.next
	  j checklist



createNode:
    li $a0,8      # create node
    li $v0,9
    syscall
	  sw $t2, 0($v0)        # new.int = int
    sw $t4, 4($v0)				# new.next = current

    beq $t3, $0, newHead		# if previous == null then update head

	  sw $v0, 4($t3)	#previous.next = newNode
	  jr $ra


newHead:
    move $s1, $v0				# head = newNode
	  jr $ra					    # return




#############################################################################
#CREATE LIST
#############################################################################

CreateL:

    li $v0, 9    # create new node
    li $a0, 8
    syscall
    move $s1, $v0


    la $a0, node			# prompt user to enter a value
    li $v0, 4
    syscall

    li $v0, 5			#read data (first int)
    syscall
    sw $v0, 0($s1)
    sw $0, 4($s1)   #head.next = null

    jr $ra					# return

ListDoesntExist:

    la $a0, listDoesntExistmsg		# load message
    li $v0, 4
    syscall

    la $a0,newline    #print new line
    li $v0,4
    syscall

    jr $ra






#############################################################################
#DELETE NODE
#############################################################################

Delete:
    beq $s1, $0, EmptyList   # check if list is empty

    move $t0, $s1           # current = LinkedList.head

    la $a0, node       	# prompt user to enter a value
    li $v0, 4
    syscall

    li $v0,5        # read int
    syscall
    move $t1,$v0

    li $t2, 0     #previous = 0

DeleteLoop:
    beq $t0, $0, DeleteNodeNotFound	      # if current == nullptr, return
	  lw $t3, 0($t0)				                 # current.data
	  beq $t1, $t3, DeleteNodeFound   	# leave if current.data == $t1
    move $t2, $t0			                   	# if it doesn't, previous = current
    lw $t0, 4($t0)			                   # if it doesn't, current = current.next
    j DeleteLoop			               # and loop



DeleteNodeNotFound:
    la $a0, notFoundmsg			 # load message
    li $v0, 4
    syscall

    la $a0,newline    #print new line
    li $v0,4
    syscall

    jr $ra


DeleteNodeFound:

    la $a0, Foundmsg			 # load message
    li $v0, 4
    syscall

    la $a0,newline    #print new line
    li $v0,4
    syscall

    beq $t2, $0, HeadDeletion

    lw $t3, 4($t0)				# current.next
    sw $t3, 4($t2)				# previous.next = current.next

	  jr $ra					# return

HeadDeletion:

    lw $t2, 4($t0)				# newHead = head.next
    move $s1, $t2				# head = newHead
    jr $ra

EmptyList:

    la $a0, emptylistmsg			# load message
    li $v0, 4
    syscall

    la      $a0,newline    #print new line
    li      $v0,4
    syscall

    jr $ra


#############################################################################
#PRINT LIST
#############################################################################



Print:
    beq $s1, $0, DonePrintingEmpty

    add $sp,$sp,-4
    sw $ra,0($sp)     # save $ra

    move $t0, $s1     # current = LinkedListhead

PrintLoop:
    beq $t0, $0, DonePrinting
    lw $t1,0($t0)               #get int of cur
    jal PrintNode               #print int of cur
    lw $t0,4($t0)               # cur = cur.next
    j PrintLoop

DonePrinting:

    la $a0, donePrintingmsg			# load message
    li $v0, 4
    syscall

    la      $a0,newline    #print new line
    li      $v0,4
    syscall

    lw $ra,0($sp)
    add $sp,$sp,4      # load $ra
    jr $ra

PrintNode:
		move $a0,$t1         #print int
		li $v0,1
		syscall

    la      $a0,newline    #print new line
    li      $v0,4
    syscall
    jr $ra

DonePrintingEmpty:
    la $a0, emptylistmsg			# load message
    li $v0, 4
    syscall

    la $a0,newline    #print new line
    li $v0,4
    syscall
    jr $ra

#############################################################################
#EXIT
#############################################################################


exit:
		li $v0,10    # exit
		syscall


      	.data
menu: .asciiz  "Menu:  Type 1 to insert element,   Type 2 to remove element,   Type 3 to print list auxousa seira,      Type 4 to create list,    Type 5 for EXIT"
node: .asciiz  "Grapse ta data (int)"
notFoundmsg: .asciiz "Node not found"
Foundmsg: .asciiz "Node Deleted"
emptylistmsg: .asciiz "List is empty"
donePrintingmsg: .asciiz "Done Printing List"
newline: .asciiz "\n"
listDoesntExistmsg: .asciiz "List doesnt exist"
