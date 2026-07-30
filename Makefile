CFLAGS=-std=c11 -g -static

ifeq ($(shell uname -m),arm64)
.DEFAULT_GOAL := dtest
endif

9cc: 9cc.c

test: 9cc
	./test.sh

clean:
	rm -f 9cc *.o *~ tmp*

IMAGE=compilerbook
DOCKER=docker run --platform linux/amd64 --rm -v "$(CURDIR):/9cc" -w /9cc $(IMAGE)

dtest:
	$(DOCKER) make test

dbuild:
	$(DOCKER) make 9cc

dclean:
	$(DOCKER) make clean

dsh:
	docker run --platform linux/amd64 --rm -it -v "$(CURDIR):/9cc" -w /9cc $(IMAGE) bash

dimage:
	docker build --platform linux/amd64 -t $(IMAGE) https://www.sigbus.info/compilerbook/Dockerfile

.PHONY: test clean dtest dbuild dclean dsh dimage
