# Bind - A equivalent of the JavaScript's `bind` but for C.

#### Why?
The question is, why not?

#### Is this ready?
No. Really, this is really unstable now.

#### Why AArch64 first?
Because i do not have my computer with me, only my phone, and it's 64-bit arm.

#### Usage:
The usage is really simple, there's only two functions:

`bind()` and `unbind()`

Example:
```c
#include <stdio.h>  // `puts`, `fprintf`
#include <bind.h>   // `bind`, `unbind`

int main(void)
{
    int (*put)(void) = (typeof(put)) bind(&puts, "Hello, world!");

    // The `put` function is the `puts` function with it's first argument
    // bound to the "Hello, world!" pointer

    put(); // puts("Hello, world!")

    unbind((void *) put);

    return 0;
}
```
