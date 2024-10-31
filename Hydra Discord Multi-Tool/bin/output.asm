START
        LDM $4          ; High nibble of letter 'H'
        WRR             ; Write to ROM output port
        LDM $8          ; Low nibble of letter 'H'
        WRR             ; Write to ROM output port

        LDM $6          ; High nibble of letter 'e'
        WRR             ; Write to ROM output port
        LDM $5          ; Low nibble of letter 'e'
        WRR             ; Write to ROM output port

        LDM $6          ; High nibble of letter 'l'
        WRR             ; Write to ROM output port
        LDM $C          ; Low nibble of letter 'l'
        WRR             ; Write to ROM output port

        LDM $6          ; High nibble of letter 'l'
        WRR             ; Write to ROM output port
        LDM $C          ; Low nibble of letter 'l'
        WRR             ; Write to ROM output port

        LDM $6          ; High nibble of letter 'o'
        WRR             ; Write to ROM output port
        LDM $F          ; Low nibble of letter 'o'
        WRR             ; Write to ROM output port

        LDM $2          ; High nibble of 'space'
        WRR             ; Write to ROM output port
        LDM $0          ; Low nibble of 'space'
        WRR             ; Write to ROM output port


        LDM $5          ; High nibble of letter 'W'
        WRR             ; Write to ROM output port
        LDM $7          ; Low nibble of letter 'W'
        WRR             ; Write to ROM output port

        LDM $6          ; High nibble of letter 'o'
        WRR             ; Write to ROM output port
        LDM $F          ; Low nibble of letter 'o'
        WRR             ; Write to ROM output port

        LDM $7          ; High nibble of letter 'r'
        WRR             ; Write to ROM output port
        LDM $2          ; Low nibble of letter 'r'
        WRR             ; Write to ROM output port

        LDM $6          ; High nibble of letter 'l'
        WRR             ; Write to ROM output port
        LDM $C          ; Low nibble of letter 'l'
        WRR             ; Write to ROM output port

        LDM $6          ; High nibble of letter 'd'
        WRR             ; Write to ROM output port
        LDM $4          ; Low nibble of letter 'd'
        WRR             ; Write to ROM output port
END
        JUN END