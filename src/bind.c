#include <stdio.h>
#include <errno.h>
#include <sys/mman.h>
#include <stdlib.h>

extern void *bind_impl;
extern int bind_impl_size;

struct bind_t {
        void *func;
        void *value;
        char code[];
} __attribute__((packed));

struct bind_t *alloc_bind()
{
        void *ptr = mmap(NULL, bind_impl_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);

        if (ptr == MAP_FAILED) {
                perror("mmap");
                return NULL;
        }

        memcpy(ptr, (void *) &bind_impl, bind_impl_size);

        errno = 0;
        mprotect(ptr, bind_impl_size, PROT_READ | PROT_WRITE | PROT_EXEC);

        return ptr;
}

void dealloc_bind(struct bind_t *ptr) {
        munmap(ptr, bind_impl_size);
}

void *bind(void *function, void *value) {
        struct bind_t *bnd = alloc_bind();
        
        bnd->func = function;
        bnd->value = value;

        return (void *) &bnd->code;
}

void unbind(void *binded) {
        void *ptr = (void *) ((uintptr_t) binded - (uintptr_t) sizeof(struct bind_t));

        dealloc_bind(binded);
}


