#ifndef __BIND_H__
#define __BIND_H__

/**
 * Bind a value to the first argument of the provided
 * function, while shifting the other arguments to make
 * room for the new one.
 *
 * Example:
 *
 *     int (*printef)(char *, ...) = bind(fprintf, stderr);
 *     // Created a new function that calls fprintf with
 *     // the first argument bound to stderr, any arguments
 *     // provided are going to be placed starting from
 *     // the second argument.
 *
 *     // So, this is the same as:
 *     //   fprintf(stderr, "Error message!\n");
 *     printef("Error message!\n");
 *
 * @param[function] The function pointer to bind the value
 * @param[value] The value for the first parameter
 * @return A new pointer to a function created with `mmap`.
 */
extern void *bind(void *function, void *value);

/**
 * Cleanup a bound function (do munmap() on the region)
 */
extern void unbind(void *function);

#endif /** __BIND_H__ */
