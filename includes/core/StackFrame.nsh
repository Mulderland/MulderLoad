!ifndef __STACKFRAME_NSH__
!define __STACKFRAME_NSH__

!macro SAVE_REGISTERS_N COUNT
    # Save $0-$9
    !if ${COUNT} >= 1
        Push $0
    !endif
    !if ${COUNT} >= 2
        Push $1
    !endif
    !if ${COUNT} >= 3
        Push $2
    !endif
    !if ${COUNT} >= 4
        Push $3
    !endif
    !if ${COUNT} >= 5
        Push $4
    !endif
    !if ${COUNT} >= 6
        Push $5
    !endif
    !if ${COUNT} >= 7
        Push $6
    !endif
    !if ${COUNT} >= 8
        Push $7
    !endif
    !if ${COUNT} >= 9
        Push $8
    !endif
    !if ${COUNT} = 10
        Push $9
    !endif
!macroend

!macro SAVE_REGISTERS_R COUNT
    # Save $R0-$R9
    !if ${COUNT} >= 1
        Push $R0
    !endif
    !if ${COUNT} >= 2
        Push $R1
    !endif
    !if ${COUNT} >= 3
        Push $R2
    !endif
    !if ${COUNT} >= 4
        Push $R3
    !endif
    !if ${COUNT} >= 5
        Push $R4
    !endif
    !if ${COUNT} >= 6
        Push $R5
    !endif
    !if ${COUNT} >= 7
        Push $R6
    !endif
    !if ${COUNT} >= 8
        Push $R7
    !endif
    !if ${COUNT} >= 9
        Push $R8
    !endif
    !if ${COUNT} = 10
        Push $R9
    !endif
!macroend

!macro RESTORE_REGISTERS_R COUNT
    # Restore $R0-$R9
    !if ${COUNT} = 10
        Pop $R9
    !endif
    !if ${COUNT} >= 9
        Pop $R8
    !endif
    !if ${COUNT} >= 8
        Pop $R7
    !endif
    !if ${COUNT} >= 7
        Pop $R6
    !endif
    !if ${COUNT} >= 6
        Pop $R5
    !endif
    !if ${COUNT} >= 5
        Pop $R4
    !endif
    !if ${COUNT} >= 4
        Pop $R3
    !endif
    !if ${COUNT} >= 3
        Pop $R2
    !endif
    !if ${COUNT} >= 2
        Pop $R1
    !endif
    !if ${COUNT} >= 1
        Pop $R0
    !endif
!macroend

!macro RESTORE_REGISTERS_N COUNT
    # Restore $0-$9
    !if ${COUNT} = 10
        Pop $9
    !endif
    !if ${COUNT} >= 9
        Pop $8
    !endif
    !if ${COUNT} >= 8
        Pop $7
    !endif
    !if ${COUNT} >= 7
        Pop $6
    !endif
    !if ${COUNT} >= 6
        Pop $5
    !endif
    !if ${COUNT} >= 5
        Pop $4
    !endif
    !if ${COUNT} >= 4
        Pop $3
    !endif
    !if ${COUNT} >= 3
        Pop $2
    !endif
    !if ${COUNT} >= 2
        Pop $1
    !endif
    !if ${COUNT} >= 1
        Pop $0
    !endif
!macroend

!macro GET_ARGS COUNT
    # Extract arguments into $0..$9 (first argument first)
    !if ${COUNT} >= 1
        Exch ${COUNT}
        Pop $0
    !endif
    !if ${COUNT} >= 2
        Exch ${COUNT}
        Pop $1
    !endif
    !if ${COUNT} >= 3
        Exch ${COUNT}
        Pop $2
    !endif
    !if ${COUNT} >= 4
        Exch ${COUNT}
        Pop $3
    !endif
    !if ${COUNT} >= 5
        Exch ${COUNT}
        Pop $4
    !endif
    !if ${COUNT} >= 6
        Exch ${COUNT}
        Pop $5
    !endif
    !if ${COUNT} >= 7
        Exch ${COUNT}
        Pop $6
    !endif
    !if ${COUNT} >= 8
        Exch ${COUNT}
        Pop $7
    !endif
    !if ${COUNT} >= 9
        Exch ${COUNT}
        Pop $8
    !endif
    !if ${COUNT} = 10
        Exch ${COUNT}
        Pop $9
    !endif
!macroend

!macro STACKFRAME_BEGIN ARGS LOCALS
    !insertmacro SAVE_REGISTERS_N ${ARGS}
    !if ${ARGS} > 0
        !insertmacro GET_ARGS ${ARGS}
    !endif
    !insertmacro SAVE_REGISTERS_R ${LOCALS}
!macroend

!macro STACKFRAME_END ARGS LOCALS
    !insertmacro RESTORE_REGISTERS_R ${LOCALS}
    !insertmacro RESTORE_REGISTERS_N ${ARGS}
!macroend

!macro STACKFRAME_RETURN ARGS LOCALS VALUE
    !if ${ARGS} < 0
        !error "STACKFRAME_RETURN: ARGS must be >= 0"
    !endif
    !if ${ARGS} > 10
        !error "STACKFRAME_RETURN: ARGS must be <= 10"
    !endif

    !if ${LOCALS} < 0
        !error "STACKFRAME_RETURN: LOCALS must be >= 0"
    !endif
    !if ${LOCALS} > 10
        !error "STACKFRAME_RETURN: LOCALS must be <= 10"
    !endif

    # Push the result to the stack
    Push ${VALUE} ; takes a "pushable token" (may already be quoted), so do not force quoting here.

    # Calculate total stack offset
    !define /redef /math STACK_OFFSET ${ARGS} + ${LOCALS}

    # Move the result down the stack
    !if ${STACK_OFFSET} >= 20
        Exch 20
    !endif
    !if ${STACK_OFFSET} >= 19
        Exch 19
    !endif
    !if ${STACK_OFFSET} >= 18
        Exch 18
    !endif
    !if ${STACK_OFFSET} >= 17
        Exch 17
    !endif
    !if ${STACK_OFFSET} >= 16
        Exch 16
    !endif
    !if ${STACK_OFFSET} >= 15
        Exch 15
    !endif
    !if ${STACK_OFFSET} >= 14
        Exch 14
    !endif
    !if ${STACK_OFFSET} >= 13
        Exch 13
    !endif
    !if ${STACK_OFFSET} >= 12
        Exch 12
    !endif
    !if ${STACK_OFFSET} >= 11
        Exch 11
    !endif
    !if ${STACK_OFFSET} >= 10
        Exch 10
    !endif
    !if ${STACK_OFFSET} >= 9
        Exch 9
    !endif
    !if ${STACK_OFFSET} >= 8
        Exch 8
    !endif
    !if ${STACK_OFFSET} >= 7
        Exch 7
    !endif
    !if ${STACK_OFFSET} >= 6
        Exch 6
    !endif
    !if ${STACK_OFFSET} >= 5
        Exch 5
    !endif
    !if ${STACK_OFFSET} >= 4
        Exch 4
    !endif
    !if ${STACK_OFFSET} >= 3
        Exch 3
    !endif
    !if ${STACK_OFFSET} >= 2
        Exch 2
    !endif
    !if ${STACK_OFFSET} >= 1
        Exch 1
    !endif
!macroend

!endif ; __STACKFRAME_NSH__
