SRC_FILES=$(shell find . -type f -name "*.java")

jenable.jar: compile.tag manifest
	jar cmf manifest $@ .
compile.tag: $(SRC_FILES)
	javac -Xlint:all *.java
	touch compile.tag

clean:
	-rm *.class compile.tag jenable.jar
