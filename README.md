# Singly Linked List Management System

## Members: Dimitris Tzovanis, Elpida Stasinou


This project is a MIPS assembly program designed to manage a singly linked list through a simple console-based menu. 
Users can interact with the program to perform operations such as adding a new node, deleting an existing node, 
printing the list in ascending order, creating a new list, and exiting the program.

### Features

- Create a List: Initialize a new singly linked list.
- Add Node: Insert a new node with an integer value into the list in its correct position to maintain ascending order.
- Delete Node: Remove a node with a specified integer value from the list.
- Print List: Display the contents of the list in ascending order.
- Exit: Terminate the program.

### How to Run

To run this program, you will need a MIPS simulator that supports the MIPS assembly language, 
such as MARS or SPIM. Load the .asm file into your simulator and execute the program.

### Implementation Details

- The linked list is implemented as a series of dynamically allocated nodes, 
each containing an integer value and a pointer to the next node.
- The list maintains ascending order by inserting new nodes into their correct
- position as determined by their value.
- The program handles edge cases such as attempting to delete from an empty list
- or insert into a non-existent list by displaying appropriate messages.



