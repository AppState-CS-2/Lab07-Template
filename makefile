JUNIT5_JAR = lib/junit-platform-console-standalone-1.8.2.jar
JUNIT5_RUNNER = org.junit.platform.console.ConsoleLauncher
TEST_UTILS = lib/LabTests.jar
CKSTYLE_COMMAND =  -jar lib/checkstyle-all-7.1.1.jar
JAVAC_FLAGS = -d bin -cp src/main:src/tests:$(JUNIT5_JAR):$(TEST_UTILS)
JUNIT_FLAGS = -jar $(JUNIT5_JAR) -cp bin:lib/LabTests.jar --select-class

default: 
	@echo "usage: make target"
	@echo "____________________ test - compile and run tests"
	@echo "____________________ demo - compile and run the demo"
	@echo "____________________ check - runs checkstyle"
	@echo "____________________ compile - compiles all classes"
	@echo "____________________ clean - removes all .class files"

compile:
	javac $(JAVAC_FLAGS) src/**/**/*.java

structuretest:
	make compile
	java $(JUNIT_FLAGS) storage.DoubleLinkedSeqStructureTest

test:
	make compile
	java -cp bin:$(JUNIT5_JAR):$(TEST_UTILS) $(JUNIT5_RUNNER) --scan-class-path
	
demo:
	make compile
	java -cp .:bin client.Demo

check:
	java $(CKSTYLE_COMMAND) -c resources/styles.xml src/main/storage/*.java

submit:
	./lib/webcatSubmit src/main/storage

clean:
	rm -f ./bin/**/*.class
