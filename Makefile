.PHONY: format docs test

java-files := $(shell find src -name '*.java')
config-files := $(shell find src -name '*.yml') build.gradle settings.gradle
version := $(shell src/build/version.py)

build: build/libs/FastLeafDecay-$(version).jar
build/libs/FastLeafDecay-$(version).jar: $(java-files) $(config-files)
	./gradlew build
	@echo built build/libs/FastLeafDecay-$(version).jar

format: build/format
build/format: $(java-files) $(config-files)
	@mkdir -p build
	./gradlew :spotlessApply
	@touch $@

test:
	./gradlew check
