# XXX no versioning of the docker image

ifneq ($(NOCACHE),)
  NOCACHEFLAG=--no-cache
endif

.PHONY: build push clean test validate

build: out/openresty out/redis validate
	docker build ${NOCACHEFLAG} -t planitar/count-von-count .

push:
	docker push planitar/count-von-count

clean:
	rm -rf ./out
	docker rmi -f planitar/count-von-count || true

validate: count-von-count/config/voncount.config
	./script/json-validate.py $<

test:
	docker run -d --name test-cvc planitar/count-von-count
	sleep 3s
	IP=$$(docker inspect -f '{{ .NetworkSettings.IPAddress }}' test-cvc); \
	curl $${IP}/_.gif; res=$$?; \
	if [ $$res -ne 0 ]; then \
	  docker logs test-cvc >&2; \
	  docker rm -f test-cvc \
	  false; \
	fi
	docker rm -f test-cvc

out/openresty out/redis:
	docker run -ti --rm \
	  -v `pwd`/script:/build \
	  -v `pwd`/out/openresty:/opt/openresty \
	  -v `pwd`/out/redis:/opt/redis \
	  planitar/dev-base /build/build-all.sh
