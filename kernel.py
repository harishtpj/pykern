# A Simple kernel program written in Python.

def kmain() -> int:
    msg: const__char__link = 'Hello, World!, This is pykernos written in Python. Version 2.0'
    vidptr: char__link =  ptr(char, 0xb8000)
    i: unsigned__int = 0
    j: unsigned__int = 0

    while j < 80 * 25 * 2:
        vidptr[j] = 0x20  # 0x20 = 32 = ' ' ASCII Space
        vidptr[j+1] = 0x07
        j += 2

    j = 0

    while msg[j] != 0x00: # 0x00 = 0 ASCII Null
        vidptr[i] = msg[j]
        vidptr[i+1] = 0x07
        j += 1
        i += 2
    
    return 0