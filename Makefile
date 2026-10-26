build:
	swift build

release:
	swift build -c release
	
test:
	swift test --parallel

docker-test:
	docker build -t feather-push-apns-tests . -f ./docker/tests/Dockerfile && docker run --rm feather-push-apns-tests

test-with-coverage:
	swift test --parallel --enable-code-coverage

clean:
	rm -rf .build
	
check:
	./scripts/run-checks.sh

format:
	./scripts/run-swift-format.sh --fix
