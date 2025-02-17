#include <stdio.h>
#include <stdlib.h>
#include <bind.h>

typedef struct Person {
	char *name;

	void (*sayHi)(void);
} Person;

void Person_sayHi(Person *self) {
	printf("Hi! My name is %s\n", self->name);
}

void Person_free(Person *self) {
	unbind(self->sayHi);

	free(self);
}

Person *Person_new(char *name) {
	Person *self = calloc(1, sizeof(*self));

	self->name = name;
	self->sayHi = (typeof(self->sayHi)) bind(&Person_sayHi, self);

	return self;
}

int main(void)
{
	Person *dayvid = Person_new("Dayvid");
	Person *joao = Person_new("João");

	dayvid->sayHi();
	joao->sayHi();

	Person_free(dayvid);
	Person_free(joao);

	return 0;
}
