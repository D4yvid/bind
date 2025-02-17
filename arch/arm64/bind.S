        .globl        bind_impl_begin
        .globl        bind_impl_end
        .globl        bind_impl_size
        .globl        bind_impl
        .section      .data

bind_impl:
        .int    0x00
        .int    0x00
        .int    0x00
        .int    0x00
bind_impl_begin:
        sub     sp, sp, #0x10
        str     x0,  [sp, #0x10]
        str     x30, [sp, #0x8]
        bl      _label
_label: mov     x9, x30
        ldr     x30, [sp, #0x8]
        ldr     x0,  [sp, #0x10]
        str     xzr, [sp, #0x8]
        sub     x9, x9, _label - bind_impl
        str     x7, [sp, #-0x8]
        mov     x7, x6
        mov     x6, x5
        mov     x5, x4
        mov     x4, x3
        mov     x3, x2
        mov     x2, x1
        mov     x1, x0
        ldr     x0, [x9, #0x8]
        ldr     x9, [x9, #0x0]
        add     sp, sp, #0x10
        br      x9

        ret
bind_impl_end:
bind_impl_size:
        .int        bind_impl_end - bind_impl
