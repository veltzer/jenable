# parameters
SRC_FILES:=$(shell find . -type f -name "*.java")
CLASS_FILES:=$(shell find . -type f -name "*.class")
# here we go...
.PHONY: all
all: jenable.jar
jenable.jar: compile.tag manifest
	jar cmf manifest $@ .
compile.tag: $(SRC_FILES)
	javac -Xlint:all $(SRC_FILES) 
	touch compile.tag
.PHONY: clean
clean:
	-rm $(CLASS_FILES)
